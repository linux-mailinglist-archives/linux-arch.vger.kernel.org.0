Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D137A0B0C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 18:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjINQyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjINQyv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 12:54:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3381BCB;
        Thu, 14 Sep 2023 09:54:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rmk1X02Syz6K66F;
        Fri, 15 Sep 2023 00:54:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 17:54:44 +0100
Date:   Thu, 14 Sep 2023 17:54:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 35/35] cpumask: Add enabled cpumask for present
 CPUs that can be brought online
Message-ID: <20230914175443.000038f6@Huawei.com>
In-Reply-To: <20230913163823.7880-36-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-36-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:38:23 +0000
James Morse <james.morse@arm.com> wrote:

> The 'offline' file in sysfs shows all offline CPUs, including those
> that aren't present. User-space is expected to remove not-present CPUs
> from this list to learn which CPUs could be brought online.
> 
> CPUs can be present but not-enabled. These CPUs can't be brought online
> until the firmware policy changes, which comes with an ACPI notification
> that will register the CPUs.
> 
> With only the offline and present files, user-space is unable to
> determine which CPUs it can try to bring online. Add a new CPU mask
> that shows this based on all the registered CPUs.

Bikeshed should be blue.

Enabled is a really confusing name for this - to the extent that I'm not sure
what it means.  Assuming I have the sense right, how about the horrible
onlineable or online_capable?


> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/base/cpu.c      | 10 ++++++++++
>  include/linux/cpumask.h | 25 +++++++++++++++++++++++++
>  kernel/cpu.c            |  3 +++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index c709747c4a18..a19a8be93102 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -95,6 +95,7 @@ void unregister_cpu(struct cpu *cpu)
>  {
>  	int logical_cpu = cpu->dev.id;
>  
> +	set_cpu_enabled(logical_cpu, false);
>  	unregister_cpu_under_node(logical_cpu, cpu_to_node(logical_cpu));
>  
>  	device_unregister(&cpu->dev);
> @@ -273,6 +274,13 @@ static ssize_t print_cpus_offline(struct device *dev,
>  }
>  static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
>  
> +static ssize_t print_cpus_enabled(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_enabled_mask));
> +}
> +static DEVICE_ATTR(enabled, 0444, print_cpus_enabled, NULL);
> +
>  static ssize_t print_cpus_isolated(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
> @@ -413,6 +421,7 @@ int register_cpu(struct cpu *cpu, int num)
>  	register_cpu_under_node(num, cpu_to_node(num));
>  	dev_pm_qos_expose_latency_limit(&cpu->dev,
>  					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> +	set_cpu_enabled(num, true);
>  
>  	return 0;
>  }
> @@ -494,6 +503,7 @@ static struct attribute *cpu_root_attrs[] = {
>  	&cpu_attrs[2].attr.attr,
>  	&dev_attr_kernel_max.attr,
>  	&dev_attr_offline.attr,
> +	&dev_attr_enabled.attr,
>  	&dev_attr_isolated.attr,
>  #ifdef CONFIG_NO_HZ_FULL
>  	&dev_attr_nohz_full.attr,
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index f10fb87d49db..a29ee03f13ff 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -92,6 +92,7 @@ static inline void set_nr_cpu_ids(unsigned int nr)
>   *
>   *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
>   *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
> + *     cpu_enabled_mask  - has bit 'cpu' set iff cpu can be brought online
>   *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
>   *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
>   *
> @@ -124,11 +125,13 @@ static inline void set_nr_cpu_ids(unsigned int nr)
>  
>  extern struct cpumask __cpu_possible_mask;
>  extern struct cpumask __cpu_online_mask;
> +extern struct cpumask __cpu_enabled_mask;
>  extern struct cpumask __cpu_present_mask;
>  extern struct cpumask __cpu_active_mask;
>  extern struct cpumask __cpu_dying_mask;
>  #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
>  #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
> +#define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
>  #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
>  #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
>  #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
> @@ -973,6 +976,7 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
>  #else
>  #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
>  #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
> +#define for_each_enabled_cpu(cpu)   for_each_cpu((cpu), cpu_enabled_mask)
>  #define for_each_present_cpu(cpu)  for_each_cpu((cpu), cpu_present_mask)
>  #endif
>  
> @@ -995,6 +999,15 @@ set_cpu_possible(unsigned int cpu, bool possible)
>  		cpumask_clear_cpu(cpu, &__cpu_possible_mask);
>  }
>  
> +static inline void
> +set_cpu_enabled(unsigned int cpu, bool can_be_onlined)
> +{
> +	if (can_be_onlined)
> +		cpumask_set_cpu(cpu, &__cpu_enabled_mask);
> +	else
> +		cpumask_clear_cpu(cpu, &__cpu_enabled_mask);
> +}
> +
>  static inline void
>  set_cpu_present(unsigned int cpu, bool present)
>  {
> @@ -1074,6 +1087,7 @@ static __always_inline unsigned int num_online_cpus(void)
>  	return raw_atomic_read(&__num_online_cpus);
>  }
>  #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
> +#define num_enabled_cpus()	cpumask_weight(cpu_enabled_mask)
>  #define num_present_cpus()	cpumask_weight(cpu_present_mask)
>  #define num_active_cpus()	cpumask_weight(cpu_active_mask)
>  
> @@ -1082,6 +1096,11 @@ static inline bool cpu_online(unsigned int cpu)
>  	return cpumask_test_cpu(cpu, cpu_online_mask);
>  }
>  
> +static inline bool cpu_enabled(unsigned int cpu)
> +{
> +	return cpumask_test_cpu(cpu, cpu_enabled_mask);
> +}
> +
>  static inline bool cpu_possible(unsigned int cpu)
>  {
>  	return cpumask_test_cpu(cpu, cpu_possible_mask);
> @@ -1106,6 +1125,7 @@ static inline bool cpu_dying(unsigned int cpu)
>  
>  #define num_online_cpus()	1U
>  #define num_possible_cpus()	1U
> +#define num_enabled_cpus()	1U
>  #define num_present_cpus()	1U
>  #define num_active_cpus()	1U
>  
> @@ -1119,6 +1139,11 @@ static inline bool cpu_possible(unsigned int cpu)
>  	return cpu == 0;
>  }
>  
> +static inline bool cpu_enabled(unsigned int cpu)
> +{
> +	return cpu == 0;
> +}
> +
>  static inline bool cpu_present(unsigned int cpu)
>  {
>  	return cpu == 0;
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6de7c6bb74ee..2201a6a449b5 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -3101,6 +3101,9 @@ EXPORT_SYMBOL(__cpu_possible_mask);
>  struct cpumask __cpu_online_mask __read_mostly;
>  EXPORT_SYMBOL(__cpu_online_mask);
>  
> +struct cpumask __cpu_enabled_mask __read_mostly;
> +EXPORT_SYMBOL(__cpu_enabled_mask);
> +
>  struct cpumask __cpu_present_mask __read_mostly;
>  EXPORT_SYMBOL(__cpu_present_mask);
>  

