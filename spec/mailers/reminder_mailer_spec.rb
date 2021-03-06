require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  let!(:user) { create(:user) }
  let!(:thing) { create(:thing, title: 'My thing', user: user) }

  describe '#reminder' do
    let(:email) { ReminderMailer.reminder(user).deliver_now }

    it 'sends reminder email to user' do
      expect(email.to).to eq([user.email])
    end

    it 'has related thing in body message' do
      expect(email.body).to have_content(thing.title)
    end

    it 'has link to thing in body message' do
      expect(email.body).to have_link('Change status', href: thing_url(thing))
    end
  end

  describe '#monthly_reminder' do
    let(:email) { ReminderMailer.monthly_reminder(user).deliver_now }

    it 'sends reminder email to user' do
      expect(email.to).to eq([user.email])
    end

    it 'has related thing in body message' do
      expect(email.body).to have_content(thing.title)
    end

    it 'has link to thing in body message' do
      expect(email.body).to have_link(nil, href: thing_url(thing))
    end
  end
end
