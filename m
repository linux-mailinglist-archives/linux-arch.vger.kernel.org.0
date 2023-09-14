Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584EB79FF23
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 10:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjINIzU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 04:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbjINIzO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 04:55:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0D22101;
        Thu, 14 Sep 2023 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f+H5x/cp2bEzCYiNMmAnXAGMN21bYlWKCmF1GGEIgsw=; b=BW29AHkaUZl9f3QBTA+GNqc2cD
        akwSiNhK+uF/maEQuHHtaqHF3nu0XqMxMeQzdFLI+QWUc8I3cNd1o7e1l+AP6RuHSS77Y979dJek9
        tPospno619x75OsTybQyZ7NM2GuWI87Yi3grTTDbHgrBidHuyQV1rEHjmeQGuxmWEdRCTqFzQqYc0
        d91h9bzh+zqErANRFQ8Leyad1NX2Xzll370qcAQW+RR/IPftGMYjRAokMpI0JzlJs1wd3VChWl2rf
        d1hr1IYTHhAbEa9+BhpuZbV46ojK/mDa3LDLTVx1IrHco4FnrM8SzXEm119Cga0UxZ8pYfs2Y0QTj
        DmY0ADvw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52876)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qgi7l-0003km-2S;
        Thu, 14 Sep 2023 09:54:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qgi7k-0004c0-45; Thu, 14 Sep 2023 09:54:56 +0100
Date:   Thu, 14 Sep 2023 09:54:56 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 01/35] ACPI: Move ACPI_HOTPLUG_CPU to be disabled
 on arm64 and riscv
Message-ID: <ZQLKYCmOT/HnAYL1@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-2-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913163823.7880-2-james.morse@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 04:37:49PM +0000, James Morse wrote:
> diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
> index 48b9f7168bcc..7afe8cbb844e 100644
> --- a/arch/loongarch/include/asm/cpu.h
> +++ b/arch/loongarch/include/asm/cpu.h
> @@ -128,4 +128,11 @@ enum cpu_type_enum {
>  #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
>  #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
>  
> +#if !defined(__ASSEMBLY__)
> +#ifdef CONFIG_HOTPLUG_CPU
> +int arch_register_cpu(int num);
> +void arch_unregister_cpu(int cpu);
> +#endif
> +#endif /* ! __ASSEMBLY__ */

So, for loongarch:

grep arch_.*register_cpu arch/loongarch/ -r
arch/loongarch/kernel/topology.c:int arch_register_cpu(int cpu)
arch/loongarch/kernel/topology.c:EXPORT_SYMBOL(arch_register_cpu);
arch/loongarch/kernel/topology.c:void arch_unregister_cpu(int cpu)
arch/loongarch/kernel/topology.c:EXPORT_SYMBOL(arch_unregister_cpu);

So really this is a fix (since these functions should have prototypes)
and thus should probably be a separate patch.

However, I also wonder whether these prototypes should be added to
linux/cpu.h and be done with it (rather than have every arch prototype
these - it's not like the prototype can be different from this because
of the generic code.

I know in subsequent patches you do that, but it's rather piecemeal,
and I think this is a change that could be submitted now as both a
fix and clean up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
