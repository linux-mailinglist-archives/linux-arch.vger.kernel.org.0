Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0627A02D3
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjINLkd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 07:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINLkd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 07:40:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70771BE8;
        Thu, 14 Sep 2023 04:40:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmZy93y83z6J6kK;
        Thu, 14 Sep 2023 19:35:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 12:40:25 +0100
Date:   Thu, 14 Sep 2023 12:40:25 +0100
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
Subject: Re: [RFC PATCH v2 08/35] x86/topology: Switch over to
 GENERIC_CPU_DEVICES
Message-ID: <20230914124025.00006396@Huawei.com>
In-Reply-To: <20230913163823.7880-9-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-9-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Sep 2023 16:37:56 +0000
James Morse <james.morse@arm.com> wrote:

> Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
> overridden by the arch code, switch over to this to allow common code
> to choose when the register_cpu() call is made.
> 
> x86's struct cpus come from struct x86_cpu, which has no other members
> or users. Remove this and use the version defined by common code.
> 
> This is an intermediate step to the logic being moved to drivers/acpi,
> where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ----
> Changes since RFC:
>  * Fixed the second copy of arch_register_cpu() used for non-hotplug

Hi James,

See below for comment on this.  Upshot - I think you can delete that
function instead and rely on the weak version.

If you can't because of a later change, useful to call that out
in this patch description for those like me who read an review
in a linear fashion!

...

>  EXPORT_SYMBOL(arch_unregister_cpu);
>  #else /* CONFIG_HOTPLUG_CPU */
>  
> -int __init arch_register_cpu(int num)
> +int arch_register_cpu(int num)
>  {
> -	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
> +	return register_cpu(&per_cpu(cpu_devices, num), num);
>  }

Looks like the weak version introduced in patch 3.  Can this
implementation go away and fallback to that?

>  #endif /* CONFIG_HOTPLUG_CPU */
> -
> -static int __init topology_init(void)
> -{
> -	int i;
> -
> -	for_each_present_cpu(i)
> -		arch_register_cpu(i);
> -
> -	return 0;
> -}
> -subsys_initcall(topology_init);

