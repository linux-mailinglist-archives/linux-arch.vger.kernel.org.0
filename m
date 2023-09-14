Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFEC7A020F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjINLAX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINLAW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 07:00:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108C11BFE;
        Thu, 14 Sep 2023 04:00:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmZ7B5FLBz6HJdN;
        Thu, 14 Sep 2023 18:58:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 12:00:15 +0100
Date:   Thu, 14 Sep 2023 12:00:14 +0100
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
Subject: Re: [RFC PATCH v2 03/35] drivers: base: Allow parts of
 GENERIC_CPU_DEVICES to be overridden
Message-ID: <20230914120014.00002866@Huawei.com>
In-Reply-To: <20230913163823.7880-4-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-4-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:37:51 +0000
James Morse <james.morse@arm.com> wrote:

> Architectures often have extra per-cpu work that needs doing
> before a CPU is registered, often to determine if a CPU is
> hotpluggable.
> 
> To allow the ACPI architectures to use GENERIC_CPU_DEVICES, move
> the cpu_register() call into arch_register_cpu(), which is made __weak
> so architectures with extra work can override it.
> This aligns with the way x86, ia64 and loongarch register hotplug CPUs
> when they become present.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * Dropped __init from x86/ia64 arch_register_cpu()
Confused...

> diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
> index 94a848b06f15..741863a187a6 100644
> --- a/arch/ia64/kernel/topology.c
> +++ b/arch/ia64/kernel/topology.c
> @@ -59,7 +59,7 @@ void __ref arch_unregister_cpu(int num)
>  }
>  EXPORT_SYMBOL(arch_unregister_cpu);
>  #else
> -static int __init arch_register_cpu(int num)
> +int __init arch_register_cpu(int num)

Still seems to be here...

>  {
>  	return register_cpu(&sysfs_cpus[num].cpu, num);
>  }

Even more confused because the block wasn't in the RFC at all.
Maybe dropped static?


