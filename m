Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAF7A078D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 16:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbjINOlU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbjINOlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 10:41:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEDE1BE1;
        Thu, 14 Sep 2023 07:41:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rmfyl2yvtz6J7Pn;
        Thu, 14 Sep 2023 22:36:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 15:41:12 +0100
Date:   Thu, 14 Sep 2023 15:41:11 +0100
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
Subject: Re: [RFC PATCH v2 25/35] LoongArch: Use the __weak version of
 arch_unregister_cpu()
Message-ID: <20230914154111.0000189d@Huawei.com>
In-Reply-To: <20230913163823.7880-26-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-26-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:38:13 +0000
James Morse <james.morse@arm.com> wrote:

> LoongArch provides its own arch_unregister_cpu(). This clears the
> hotpluggable flag, then unregisters the CPU.
> 
> It isn't necessary to clear the hotpluggable flag when unregistering
> a cpu. unregister_cpu() writes NULL to the percpu cpu_sys_devices
> pointer, meaning cpu_is_hotpluggable() will return false, as
> get_cpu_device() has returned NULL.

Thought that looked odd earlier but didn't care enough to dig.
Seem unlikely state would persist for an unregistered cpu.
Great to see confirmation.

> 
> Remove arch_unregister_cpu() and use the __weak version.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  arch/loongarch/kernel/topology.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
> index 8e4441c1ff39..5a75e2cc0848 100644
> --- a/arch/loongarch/kernel/topology.c
> +++ b/arch/loongarch/kernel/topology.c
> @@ -16,13 +16,4 @@ int arch_register_cpu(int cpu)
>  	return register_cpu(c, cpu);
>  }
>  EXPORT_SYMBOL(arch_register_cpu);
> -
> -void arch_unregister_cpu(int cpu)
> -{
> -	struct cpu *c = &per_cpu(cpu_devices, cpu);
> -
> -	c->hotpluggable = 0;
> -	unregister_cpu(c);
> -}
> -EXPORT_SYMBOL(arch_unregister_cpu);
>  #endif

