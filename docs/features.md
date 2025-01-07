---
layout: page
title: Features
---

<script setup>
  import FeaturePageTitle from "./.vitepress/theme/components/FeaturePageTitle.vue";
  import FeaturePageSection from "./.vitepress/theme/components/FeaturePageSection.vue";
  import FeatureList from "./.vitepress/theme/components/FeatureList.vue";
  import { users, webDomains, mail, dns, databases, serverAdmin } from "./_data/features";
</script>

<FeaturePage>
  <FeaturePageTitle>
    <template #title>Характеристики</template>
  </FeaturePageTitle>
  <FeaturePageSection image="/images/undraw_two_factor_authentication_namy.svg">
    <template #title>Пользователи</template>
    <template #lead>Предоставляйте доступ к вашему серверу другим пользователям и ограничивайте их ресурсы.</template>
    <template #list>
      <FeatureList :items="users"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_web_developer_re_h7ie.svg">
    <template #title>Веб-домены</template>
    <template #lead>Добавляйте множество доменов и сразу устанавливайте приложения.</template>
    <template #list>
      <FeatureList :items="webDomains"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_domain_names_re_0uun.svg">
    <template #title>DNS</template>
    <template #lead>Управляйте своим собственным DNS сервером!</template>
    <template #list>
      <FeatureList :items="dns"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_personal_email_re_4lx7.svg">
    <template #title>Mail</template>
    <template #lead>Размещайте на своем сервере свои собственные электронные письма, не нужно платить поставщику деловой почты!</template>
    <template #list>
      <FeatureList :items="mail"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_maintenance_re_59vn.svg">
    <template #title>Базы данных</template>
    <template #lead>Базы данных - от электронной коммерции до блогов - всегда полезны, и вы можете выбирать между MySQL и PostgreSQL.</template>
    <template #list>
      <FeatureList :items="databases"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_server_status_re_n8ln.svg">
    <template #title>Администрирование сервера</template>
    <template #lead>Ультранастраиваемая и удобная в использовании Hestia настолько мощна, насколько вы могли бы пожелать.</template>
    <template #list>
      <FeatureList :items="serverAdmin"></FeatureList>
    </template>
  </FeaturePageSection>
</FeaturePage>
