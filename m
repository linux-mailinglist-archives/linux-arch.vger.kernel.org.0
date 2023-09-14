Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757047A0337
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjINMBg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 08:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjINMBf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 08:01:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5301BE8;
        Thu, 14 Sep 2023 05:01:30 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmbQR00lDz68944;
        Thu, 14 Sep 2023 19:56:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 13:01:27 +0100
Date:   Thu, 14 Sep 2023 13:01:26 +0100
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
        <jianyong.wu@arm.com>, <justin.he@arm.com>,
        <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v2 11/35] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
Message-ID: <20230914130126.000069db@Huawei.com>
In-Reply-To: <20230913163823.7880-12-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-12-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:37:59 +0000
James Morse <james.morse@arm.com> wrote:

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
> ---
> If the offline CPUs thing is a problem for the tools that consume
> this value, we'd need to move cpu_capacity to be part of cpu.c's
> common_cpu_attr_groups.

I think we should do that anyway and then use an is_visible() if we want to
change whether it is visible in offline cpus.

Dynamic sysfs file creation is horrible - particularly when done
from an totally different file from where the rest of the attributes
are registered.  I'm curious what the history behind that is.

Whilst here, why is there a common_cpu_attr_groups which is
identical to the hotpluggable_cpu_attr_groups in base/cpu.c?


+CC GregKH
Given changes in drivers/base/

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
> +static int cpu_capacity_sysctl_add(unsigned int cpu)
> +{
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +
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
>  static int register_cpu_capacity_sysctl(void)
>  {
> -	int i;
> -	struct device *cpu;
> -
> -	for_each_possible_cpu(i) {
> -		cpu = get_cpu_device(i);
> -		if (!cpu) {
> -			pr_err("%s: too early to get CPU%d device!\n",
> -			       __func__, i);
> -			continue;
> -		}
> -		device_create_file(cpu, &dev_attr_cpu_capacity);
> -	}
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "topology/cpu-capacity",
> +			  cpu_capacity_sysctl_add, cpu_capacity_sysctl_remove);
>  
>  	return 0;
>  }

