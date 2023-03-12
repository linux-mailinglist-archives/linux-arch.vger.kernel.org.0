Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD29C6B6BDE
	for <lists+linux-arch@lfdr.de>; Sun, 12 Mar 2023 22:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCLVuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Mar 2023 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCLVt7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Mar 2023 17:49:59 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC6D1043F;
        Sun, 12 Mar 2023 14:49:57 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so6556604wms.1;
        Sun, 12 Mar 2023 14:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678657796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciUH2K2b185BvScrtOTL0Sqk4RrdEzj1aaThj5pGCpQ=;
        b=ulLXKlBhqwve9szSCeiUgHJNCrAcMTNAt0S8sVXsnn7kGqHI74oBO0+ugM3q24fCE3
         E434EtN9KlcyIR8oqwFomkv/k7wOC2VH4Cg5e9MpxqqCNFSiSULQJfWyi0zSHcK71KLA
         sjEFIO+YUm8b9WnOdZ6QXPYLPKMdXUdbdPfvBpZkU5FS6stmLBl2HLyIZl+uHgvdZccW
         W18h+TOrr0IGv/25Z+G9LxS+PTizBBCJ8L7MFFkG9/ESQsXHQGruEmYPj8MLgqUrtSSb
         1bgs/8SMyALyoDULiOjPUbuo8xBB4e4ERAM8aQ/P8LG8T6heCkRNnHDBFfPpeQWW5py4
         ktdg==
X-Gm-Message-State: AO0yUKWXGt3MbhIvDHw6Nt18NJ3PBI5ZYb5O1ZO/Sffb9vDXPa5jgk0p
        9cm+S2QHLO5JuZeXw7e4/h0=
X-Google-Smtp-Source: AK7set+60VDwNsXcwRYqGYHJQF5rqWFoUT8oalPGUGVfkEG556YHGFMNiSzZXPcsX2pOSUZLol9boQ==
X-Received: by 2002:a05:600c:310e:b0:3e9:f15b:935b with SMTP id g14-20020a05600c310e00b003e9f15b935bmr9388863wmo.32.1678657796014;
        Sun, 12 Mar 2023 14:49:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l5-20020a7bc445000000b003eae73f0fc1sm6903106wmi.18.2023.03.12.14.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:49:55 -0700 (PDT)
Date:   Sun, 12 Mar 2023 21:49:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
Message-ID: <ZA5JAVlSVhgv1CBS@liuwe-devbox-debian-v2>
References: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
 <1678386957-18016-3-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678386957-18016-3-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 09, 2023 at 10:35:57AM -0800, Saurabh Sengar wrote:
> Virtual Trust Levels (VTL) helps enable Hyper-V Virtual Secure Mode (VSM)
> feature. VSM is a set of hypervisor capabilities and enlightenments
> offered to host and guest partitions which enable the creation and
> management of new security boundaries within operating system software.
> VSM achieves and maintains isolation through VTLs.
> 
> Add early initialization for Virtual Trust Levels (VTL). This includes
> initializing the x86 platform for VTL and enabling boot support for
> secondary CPUs to start in targeted VTL context. For now, only enable
> the code for targeted VTL level as 2.
> 
> When starting an AP at a VTL other than VTL 0, the AP must start directly
> in 64-bit mode, bypassing the usual 16-bit -> 32-bit -> 64-bit mode
> transition sequence that occurs after waking up an AP with SIPI whose
> vector points to the 16-bit AP startup trampoline code.
> 
> This commit also moves hv_get_nmi_reason function to header file, so
> that it can be reused by VTL.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/Kconfig                   |  24 +++
>  arch/x86/hyperv/Makefile           |   1 +
>  arch/x86/hyperv/hv_vtl.c           | 227 +++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  75 ++++++++++
>  arch/x86/include/asm/mshyperv.h    |  14 ++
>  arch/x86/kernel/cpu/mshyperv.c     |   6 +-
>  include/asm-generic/hyperv-tlfs.h  |   4 +
>  7 files changed, 346 insertions(+), 5 deletions(-)
>  create mode 100644 arch/x86/hyperv/hv_vtl.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 453f462f6c9c..b9e52ac9c9f9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -782,6 +782,30 @@ menuconfig HYPERVISOR_GUEST
>  
>  if HYPERVISOR_GUEST
>  
> +config HYPERV_VTL
> +	bool "Enable VTL"

This is not to "Enable VTL". VTL is always there with or without this
option. This option is to enable Linux to run in VTL2.

I would suggest it to be changed to HYPERV_VTL2_MODE or something more
explicit.

HYPERV_VTL is better reserved to guard code which makes use of VTL
related functionality -- if there is such a need in the future.

> +	depends on X86_64 && HYPERV
> +	default n
> +	help
> +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> +	  enlightenments offered to host and guest partitions which enables
> +	  the creation and management of new security boundaries within
> +	  operating system software.
> +
> +	  VSM achieves and maintains isolation through Virtual Trust Levels
> +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
> +	  being more privileged than lower levels. VTL0 is the least privileged
> +	  level, and currently only other level supported is VTL2.

Please be consistent as to VTL 0 vs VTL0. You use one form here and the
other form in the next paragraph.

> +
> +	  Select this option to build a Linux kernel to run at a VTL other than
> +	  the normal VTL 0, which currently is only VTL 2.  This option
> +	  initializes the x86 platform for VTL 2, and adds the ability to boot
> +	  secondary CPUs directly into 64-bit context as required for VTLs other
> +	  than 0.  A kernel built with this option must run at VTL 2, and will
> +	  not run as a normal guest.
> +
> +	  If unsure, say N
> +
>  config PARAVIRT
>  	bool "Enable paravirtualization code"
>  	depends on HAVE_STATIC_CALL
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 5d2de10809ae..a538df01181a 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
>  obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
> +obj-$(CONFIG_HYPERV_VTL)	+= hv_vtl.o
>  
>  ifdef CONFIG_X86_64
>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> new file mode 100644
> index 000000000000..0da8b242eb8b
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Author:
> + *   Saurabh Sengar <ssengar@microsoft.com>
> + */
> +
> +#include <asm/apic.h>
> +#include <asm/boot.h>
> +#include <asm/desc.h>
> +#include <asm/i8259.h>
> +#include <asm/mshyperv.h>
> +#include <asm/realmode.h>
> +
> +extern struct boot_params boot_params;
> +static struct real_mode_header hv_vtl_real_mode_header;
> +
> +void __init hv_vtl_init_platform(void)
> +{
> +	pr_info("Initializing Hyper-V VTL\n");
> +

We can be more explicit here, "Linux runs in Hyper-V Virtual Trust Level 2".

If we go with this, this and other function names should be renamed to
something more explicit too.

> +	x86_init.irqs.pre_vector_init = x86_init_noop;
> +	x86_init.timers.timer_init = x86_init_noop;
> +
> +	x86_platform.get_wallclock = get_rtc_noop;
> +	x86_platform.set_wallclock = set_rtc_noop;
> +	x86_platform.get_nmi_reason = hv_get_nmi_reason;
> +
> +	x86_platform.legacy.i8042 = X86_LEGACY_I8042_PLATFORM_ABSENT;
> +	x86_platform.legacy.rtc = 0;
> +	x86_platform.legacy.warm_reset = 0;
> +	x86_platform.legacy.reserve_bios_regions = 0;
> +	x86_platform.legacy.devices.pnpbios = 0;
> +}
> +
[...]
> +static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
> +{
> +	u64 status;
> +	int ret = 0;
> +	struct hv_enable_vp_vtl *input;
> +	unsigned long irq_flags;
> +
> +	struct desc_ptr gdt_ptr;
> +	struct desc_ptr idt_ptr;
> +
> +	struct ldttss_desc *tss;
> +	struct ldttss_desc *ldt;
> +	struct desc_struct *gdt;
> +
> +	u64 rsp = initial_stack;
> +	u64 rip = (u64)&hv_vtl_ap_entry;
> +
> +	native_store_gdt(&gdt_ptr);
> +	store_idt(&idt_ptr);
> +
> +	gdt = (struct desc_struct *)((void *)(gdt_ptr.address));
> +	tss = (struct ldttss_desc *)(gdt + GDT_ENTRY_TSS);
> +	ldt = (struct ldttss_desc *)(gdt + GDT_ENTRY_LDT);
> +
> +	local_irq_save(irq_flags);
> +
> +	input = (struct hv_enable_vp_vtl *)(*this_cpu_ptr(hyperv_pcpu_input_arg));

Not a big deal, but you don't actually need to cast here.

[...]
> +
> +static int hv_vtl_apicid_to_vp_id(u32 apic_id)
> +{
> +	u64 control;
> +	u64 status;
> +	unsigned long irq_flags;
> +	struct hv_get_vp_from_apic_id_in *input;
> +	u32 *output, ret;
> +
> +	local_irq_save(irq_flags);
> +
> +	input = (struct hv_get_vp_from_apic_id_in *)(*this_cpu_ptr(hyperv_pcpu_input_arg));

No need to cast here.

[...]
> +struct hv_x64_table_register {
> +	__u16 pad[3];
> +	__u16 limit;
> +	__u64 base;
> +} __packed;
> +
> +struct hv_init_vp_context_t {

Drop the _t suffix please.

Thanks,
Wei.
