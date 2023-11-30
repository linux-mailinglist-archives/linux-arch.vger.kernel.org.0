Return-Path: <linux-arch+bounces-564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AA07FF6BC
	for <lists+linux-arch@lfdr.de>; Thu, 30 Nov 2023 17:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373BD1C21021
	for <lists+linux-arch@lfdr.de>; Thu, 30 Nov 2023 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806994644D;
	Thu, 30 Nov 2023 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D96810D0;
	Thu, 30 Nov 2023 08:46:49 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh2685pFkz6K5lJ;
	Fri,  1 Dec 2023 00:42:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 96EBF14058E;
	Fri,  1 Dec 2023 00:46:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 Nov
 2023 16:46:46 +0000
Date: Thu, 30 Nov 2023 16:46:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse
	<james.morse@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
Subject: Re: [PATCH 01/21] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
Message-ID: <20231130164646.00006770@Huawei.com>
In-Reply-To: <E1r5R2g-00CsyV-Ss@rmk-PC.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
	<E1r5R2g-00CsyV-Ss@rmk-PC.armlinux.org.uk>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 21 Nov 2023 13:43:54 +0000
Russell King <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> register_cpu_capacity_sysctl() adds a property to sysfs that describes
> the CPUs capacity. This is done from a subsys_initcall() that assumes
> all possible CPUs are registered.
> 
> With CPU hotplug, possible CPUs aren't registered until they become
> present, (or for arm64 enabled). This leads to messages during boot:
> | register_cpu_capacity_sysctl: too early to get CPU1 device!
> and once these CPUs are added to the system, the file is missing.
> 
> Move this to a cpuhp callback, so that the file is created once
> CPUs are brought online. This covers CPUs that are added late by
> mechanisms like hotplug.
> One observable difference is the file is now missing for offline CPUs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> If the offline CPUs thing is a problem for the tools that consume
> this value, we'd need to move cpu_capacity to be part of cpu.c's
> common_cpu_attr_groups. However, attempts to discuss this just end
> up in a black hole, so this is a non-starter. Thus, if this needs
> to be done, it can be done as a separate patch.
> ---
>  drivers/base/arch_topology.c | 38 ++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index b741b5ba82bd..9ccb7daee78e 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -220,20 +220,34 @@ static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
>  
>  static DEVICE_ATTR_RO(cpu_capacity);
>  
> -static int register_cpu_capacity_sysctl(void)
> +static int cpu_capacity_sysctl_add(unsigned int cpu)
>  {
> -	int i;
> -	struct device *cpu;
> +	struct device *cpu_dev = get_cpu_device(cpu);
>  
> -	for_each_possible_cpu(i) {
> -		cpu = get_cpu_device(i);
> -		if (!cpu) {
> -			pr_err("%s: too early to get CPU%d device!\n",
> -			       __func__, i);
> -			continue;
> -		}
> -		device_create_file(cpu, &dev_attr_cpu_capacity);
> -	}
> +	if (!cpu_dev)
> +		return -ENOENT;
> +
> +	device_create_file(cpu_dev, &dev_attr_cpu_capacity);
> +
> +	return 0;
> +}
> +
> +static int cpu_capacity_sysctl_remove(unsigned int cpu)
> +{
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +
> +	if (!cpu_dev)
> +		return -ENOENT;
> +
> +	device_remove_file(cpu_dev, &dev_attr_cpu_capacity);
> +
> +	return 0;
> +}
> +
> +static int register_cpu_capacity_sysctl(void)
> +{
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "topology/cpu-capacity",
> +			  cpu_capacity_sysctl_add, cpu_capacity_sysctl_remove);
>  
>  	return 0;
>  }


