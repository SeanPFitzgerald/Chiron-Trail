class Api::V1::PrescriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    med = Medication.new(medication_params)

    if med.save
      script = Prescription.new(notes: params[:notes])
      script.user = current_user
      script.medication = med
      
      if script.save
        render status: 201, json: {
          message: "Successfully created new prescription.",
          prescription: script
        }.to_json
      else
        render json: { error: script.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: med.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def prescription_params
    params.require(:prescription).permit(:notes)
  end

  def medication_params
    params.require(:medication).permit(:name, :dosage)
  end
end
