Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3C47C0182
	for <lists+linux-arch@lfdr.de>; Tue, 10 Oct 2023 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjJJQYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Oct 2023 12:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjJJQX5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Oct 2023 12:23:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA48E;
        Tue, 10 Oct 2023 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jGruK/JRvPoRUKxXzmvtLrVi9bVZIlNLf9fCJALkLIM=; b=xMY47nv2HdLOE6LlA7OyP2LWey
        S0evHCbenZWvVgxR4F8rWt5Ho69xVrBJhByY+bW91oJApLmVwsrjGcr2uN7gma91izQR31ewJ7anp
        v3BAQE2H7edUk4krSzTVY/sH+Z7ymu/VGenzVTiL5Elnk0Ap4xfmeT21t2JGtV3VmipsVKiuqT3j8
        hXipYGeQSRxOHG2qphtUxXdHpvY6yOS2DnND9IvBkjxwo0AZUxc5ZE05SBTBiStPXltyPdy8jeQJL
        By2re7ZSo/L7fV9iuSIAB9+n3fnRuJPnSBvKj9LF/Wj5fUgqDIA5uwTJu7lAT7uRoewWW/jjwBR8y
        ANwieyqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37818)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qqFWH-00028u-29;
        Tue, 10 Oct 2023 17:23:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qqFWF-0007dT-D4; Tue, 10 Oct 2023 17:23:39 +0100
Date:   Tue, 10 Oct 2023 17:23:39 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Salil Mehta <salil.mehta@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
Message-ID: <ZSV6i4pnjQqvWuKp@shell.armlinux.org.uk>
References: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Okay, I give up. 15 days, still no real progress. I don't see any point
in submitting any further patches for the kernel outside of those areas
that I maintain. Clearly no one cares enough to bother (a) properly
reviewing the patch, (b) applying the patch that Thomas thought
"makes tons of sense."

If patches that "makes tons of sense" just get ignored, then what does
the future of the kernel hold? Crap, that's what, utter crap.

As I said, it seems that the Linux kernel process is basically totally
broken and rotten. If a six line patch that "makes tons of sense" can't
be applied, then there's basically no hope what so ever.

FFS.

On Mon, Sep 25, 2023 at 05:28:39PM +0100, Russell King (Oracle) wrote:
> Provide common prototypes for arch_register_cpu() and
> arch_unregister_cpu(). These are called by acpi_processor.c, with
> weak versions, so the prototype for this is already set. It is
> generally not necessary for function prototypes to be conditional
> on preprocessor macros.
> 
> Some architectures (e.g. Loongarch) are missing the prototype for this,
> and rather than add it to Loongarch's asm/cpu.h, lets do the job once
> for everyone.
> 
> Since this covers everyone, remove the now unnecessary prototypes in
> asm/cpu.h, and we also need to remove the 'static' from one of ia64's
> arch_register_cpu() definitions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>  - drop ia64 changes, as ia64 has already been removed.
> 
>  arch/x86/include/asm/cpu.h  | 2 --
>  arch/x86/kernel/topology.c  | 2 +-
>  include/linux/cpu.h         | 2 ++
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index 3a233ebff712..25050d953eee 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -28,8 +28,6 @@ struct x86_cpu {
>  };
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -extern int arch_register_cpu(int num);
> -extern void arch_unregister_cpu(int);
>  extern void soft_restart_cpu(void);
>  #endif
>  
> diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
> index ca004e2e4469..0bab03130033 100644
> --- a/arch/x86/kernel/topology.c
> +++ b/arch/x86/kernel/topology.c
> @@ -54,7 +54,7 @@ void arch_unregister_cpu(int num)
>  EXPORT_SYMBOL(arch_unregister_cpu);
>  #else /* CONFIG_HOTPLUG_CPU */
>  
> -static int __init arch_register_cpu(int num)
> +int __init arch_register_cpu(int num)
>  {
>  	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
>  }
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 0abd60a7987b..eb768a866fe3 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -80,6 +80,8 @@ extern __printf(4, 5)
>  struct device *cpu_device_create(struct device *parent, void *drvdata,
>  				 const struct attribute_group **groups,
>  				 const char *fmt, ...);
> +extern int arch_register_cpu(int cpu);
> +extern void arch_unregister_cpu(int cpu);
>  #ifdef CONFIG_HOTPLUG_CPU
>  extern void unregister_cpu(struct cpu *cpu);
>  extern ssize_t arch_cpu_probe(const char *, size_t);
> -- 
> 2.30.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
