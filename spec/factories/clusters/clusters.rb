FactoryBot.define do
  factory :cluster, class: Clusters::Cluster do
    user
    name 'test-cluster'

    trait :project do
      after(:create) do |cluster, evaluator|
        cluster.projects << create(:project)
      end
    end

    trait :provided_by_user do
      provider_type :user
      platform_type :kubernetes

      platform_kubernetes factory: [:cluster_platform_kubernetes, :configured]
    end

    trait :provided_by_gcp do
      provider_type :gcp
      platform_type :kubernetes

      provider_gcp factory: [:cluster_provider_gcp, :created]
      platform_kubernetes factory: [:cluster_platform_kubernetes, :configured]
    end

    trait :providing_by_gcp do
      provider_type :gcp
      provider_gcp factory: [:cluster_provider_gcp, :creating]
    end

    trait :disabled do
      enabled false
    end
  end
end
