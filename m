Return-Path: <linux-arch+bounces-1094-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B0814EA0
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 18:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A415CB23F45
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2818647F70;
	Fri, 15 Dec 2023 17:18:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669A60BA7;
	Fri, 15 Dec 2023 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SsG9z4ZPHz6J9Zx;
	Sat, 16 Dec 2023 01:17:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 71F951400DB;
	Sat, 16 Dec 2023 01:18:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Dec
 2023 17:18:32 +0000
Date: Fri, 15 Dec 2023 17:18:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 21/21] cpumask: Add enabled cpumask for present
 CPUs that can be brought online
Message-ID: <20231215171831.00004a19@Huawei.com>
In-Reply-To: <E1rDOhX-00Dvlg-Ci@rmk-PC.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOhX-00Dvlg-Ci@rmk-PC.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Dec 2023 12:50:59 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
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
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> ---

Needs docs
Documentation/ABI/testing/sysfs-devices-system-cpu
seems to have the rest of the similar entries.

> Outstanding comment:
>  https://lore.kernel.org/r/20230914175443.000038f6@Huawei.com
Very fussy reviewer. I'd ignore him on this :)

Code is fine.

Thanks for taking this forwards.  Maybe the end of this saga is
close!

Jonathan

> ---
>  drivers/base/cpu.c      | 10 ++++++++++
>  include/linux/cpumask.h | 25 +++++++++++++++++++++++++
>  kernel/cpu.c            |  3 +++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 13d052bf13f4..a6e96a0a92b7 100644
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
> index cfb545841a2c..cc72a0887f04 100644
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
> @@ -993,6 +996,7 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
>  #else
>  #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
>  #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
> +#define for_each_enabled_cpu(cpu)   for_each_cpu((cpu), cpu_enabled_mask)
>  #define for_each_present_cpu(cpu)  for_each_cpu((cpu), cpu_present_mask)
>  #endif
>  
> @@ -1015,6 +1019,15 @@ set_cpu_possible(unsigned int cpu, bool possible)
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
> @@ -1096,6 +1109,7 @@ static __always_inline unsigned int num_online_cpus(void)
>  	return raw_atomic_read(&__num_online_cpus);
>  }
>  #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
> +#define num_enabled_cpus()	cpumask_weight(cpu_enabled_mask)
>  #define num_present_cpus()	cpumask_weight(cpu_present_mask)
>  #define num_active_cpus()	cpumask_weight(cpu_active_mask)
>  
> @@ -1104,6 +1118,11 @@ static inline bool cpu_online(unsigned int cpu)
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
> @@ -1128,6 +1147,7 @@ static inline bool cpu_dying(unsigned int cpu)
>  
>  #define num_online_cpus()	1U
>  #define num_possible_cpus()	1U
> +#define num_enabled_cpus()	1U
>  #define num_present_cpus()	1U
>  #define num_active_cpus()	1U
>  
> @@ -1141,6 +1161,11 @@ static inline bool cpu_possible(unsigned int cpu)
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
> index a86972a91991..fe0a5189f8ae 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -3122,6 +3122,9 @@ EXPORT_SYMBOL(__cpu_possible_mask);
>  struct cpumask __cpu_online_mask __read_mostly;
>  EXPORT_SYMBOL(__cpu_online_mask);
>  
> +struct cpumask __cpu_enabled_mask __read_mostly;
> +EXPORT_SYMBOL(__cpu_enabled_mask);
> +
>  struct cpumask __cpu_present_mask __read_mostly;
>  EXPORT_SYMBOL(__cpu_present_mask);
>  


