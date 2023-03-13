Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31656B6E9B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Mar 2023 05:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCME5d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Mar 2023 00:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCME5b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2023 00:57:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A78073B877;
        Sun, 12 Mar 2023 21:57:30 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 19C0E204778C; Sun, 12 Mar 2023 21:57:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19C0E204778C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678683450;
        bh=9aLl/BvNmqEEf3Eln7g8qpek3FbNIeMRD0Ya6P8HIrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwpvAFouSf69voKUGyg9brlqv6dO49K9bBxDilrgJFfPsHxpBnrpGctyR9HKwd8Ya
         vd7gZbsTLj67WSxbL8WMEcAI3tQ9mUEFxWZBnBuu1ImcPNFvqj67PQimxhpOTS4h4u
         jI912CeX5cv3iI/ujtzAy5D6/9WQczgoprTIlsOk=
Date:   Sun, 12 Mar 2023 21:57:30 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        arnd@arndb.de, tiala@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
Message-ID: <20230313045730.GA31503@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
 <1678386957-18016-3-git-send-email-ssengar@linux.microsoft.com>
 <ZA5JAVlSVhgv1CBS@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA5JAVlSVhgv1CBS@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks for your review, please find my comments inline.

On Sun, Mar 12, 2023 at 09:49:53PM +0000, Wei Liu wrote:
> On Thu, Mar 09, 2023 at 10:35:57AM -0800, Saurabh Sengar wrote:
> > Virtual Trust Levels (VTL) helps enable Hyper-V Virtual Secure Mode (VSM)
> > feature. VSM is a set of hypervisor capabilities and enlightenments
> > offered to host and guest partitions which enable the creation and
> > management of new security boundaries within operating system software.
> > VSM achieves and maintains isolation through VTLs.
> > 
> > Add early initialization for Virtual Trust Levels (VTL). This includes
> > initializing the x86 platform for VTL and enabling boot support for
> > secondary CPUs to start in targeted VTL context. For now, only enable
> > the code for targeted VTL level as 2.
> > 
> > When starting an AP at a VTL other than VTL 0, the AP must start directly
> > in 64-bit mode, bypassing the usual 16-bit -> 32-bit -> 64-bit mode
> > transition sequence that occurs after waking up an AP with SIPI whose
> > vector points to the 16-bit AP startup trampoline code.
> > 
> > This commit also moves hv_get_nmi_reason function to header file, so
> > that it can be reused by VTL.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/Kconfig                   |  24 +++
> >  arch/x86/hyperv/Makefile           |   1 +
> >  arch/x86/hyperv/hv_vtl.c           | 227 +++++++++++++++++++++++++++++
> >  arch/x86/include/asm/hyperv-tlfs.h |  75 ++++++++++
> >  arch/x86/include/asm/mshyperv.h    |  14 ++
> >  arch/x86/kernel/cpu/mshyperv.c     |   6 +-
> >  include/asm-generic/hyperv-tlfs.h  |   4 +
> >  7 files changed, 346 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/x86/hyperv/hv_vtl.c
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 453f462f6c9c..b9e52ac9c9f9 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -782,6 +782,30 @@ menuconfig HYPERVISOR_GUEST
> >  
> >  if HYPERVISOR_GUEST
> >  
> > +config HYPERV_VTL
> > +	bool "Enable VTL"
> 
> This is not to "Enable VTL". VTL is always there with or without this
> option. This option is to enable Linux to run in VTL2.
> 
> I would suggest it to be changed to HYPERV_VTL2_MODE or something more
> explicit.
> 
> HYPERV_VTL is better reserved to guard code which makes use of VTL
> related functionality -- if there is such a need in the future.

Thanks, I am fine to change the description. However I named it as HYPERV_VTL
so as this is generic and in future it can be extended to other VTLs. I see it
as generic VTL code with current support only for VTL2, others will be added
when need arises.

As per my understanding apart from setting the target VTL, rest of the code
can be reused for any VTL. Once we have the other VTLs support we might think
of tweaking the target vtl whereas the flag name and other code remains same.
Please let me know your opinion on this.

> 
> > +	depends on X86_64 && HYPERV
> > +	default n
> > +	help
> > +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> > +	  enlightenments offered to host and guest partitions which enables
> > +	  the creation and management of new security boundaries within
> > +	  operating system software.
> > +
> > +	  VSM achieves and maintains isolation through Virtual Trust Levels
> > +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
> > +	  being more privileged than lower levels. VTL0 is the least privileged
> > +	  level, and currently only other level supported is VTL2.
> 
> Please be consistent as to VTL 0 vs VTL0. You use one form here and the
> other form in the next paragraph.

Sure will fix this in next version.

> 
> > +
> > +	  Select this option to build a Linux kernel to run at a VTL other than
> > +	  the normal VTL 0, which currently is only VTL 2.  This option
> > +	  initializes the x86 platform for VTL 2, and adds the ability to boot
> > +	  secondary CPUs directly into 64-bit context as required for VTLs other
> > +	  than 0.  A kernel built with this option must run at VTL 2, and will
> > +	  not run as a normal guest.
> > +
> > +	  If unsure, say N
> > +
> >  config PARAVIRT
> >  	bool "Enable paravirtualization code"
> >  	depends on HAVE_STATIC_CALL
> > diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> > index 5d2de10809ae..a538df01181a 100644
> > --- a/arch/x86/hyperv/Makefile
> > +++ b/arch/x86/hyperv/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
> >  obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
> > +obj-$(CONFIG_HYPERV_VTL)	+= hv_vtl.o
> >  
> >  ifdef CONFIG_X86_64
> >  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > new file mode 100644
> > index 000000000000..0da8b242eb8b
> > --- /dev/null
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -0,0 +1,227 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023, Microsoft Corporation.
> > + *
> > + * Author:
> > + *   Saurabh Sengar <ssengar@microsoft.com>
> > + */
> > +
> > +#include <asm/apic.h>
> > +#include <asm/boot.h>
> > +#include <asm/desc.h>
> > +#include <asm/i8259.h>
> > +#include <asm/mshyperv.h>
> > +#include <asm/realmode.h>
> > +
> > +extern struct boot_params boot_params;
> > +static struct real_mode_header hv_vtl_real_mode_header;
> > +
> > +void __init hv_vtl_init_platform(void)
> > +{
> > +	pr_info("Initializing Hyper-V VTL\n");
> > +
> 
> We can be more explicit here, "Linux runs in Hyper-V Virtual Trust Level 2".
> 
> If we go with this, this and other function names should be renamed to
> something more explicit too.

Sure I can do this. However I will like to put it as generic VTL not specific
to VTL 2 only. Please let me know your opinion.

> 
> > +	x86_init.irqs.pre_vector_init = x86_init_noop;
> > +	x86_init.timers.timer_init = x86_init_noop;
> > +
> > +	x86_platform.get_wallclock = get_rtc_noop;
> > +	x86_platform.set_wallclock = set_rtc_noop;
> > +	x86_platform.get_nmi_reason = hv_get_nmi_reason;
> > +
> > +	x86_platform.legacy.i8042 = X86_LEGACY_I8042_PLATFORM_ABSENT;
> > +	x86_platform.legacy.rtc = 0;
> > +	x86_platform.legacy.warm_reset = 0;
> > +	x86_platform.legacy.reserve_bios_regions = 0;
> > +	x86_platform.legacy.devices.pnpbios = 0;
> > +}
> > +
> [...]
> > +static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
> > +{
> > +	u64 status;
> > +	int ret = 0;
> > +	struct hv_enable_vp_vtl *input;
> > +	unsigned long irq_flags;
> > +
> > +	struct desc_ptr gdt_ptr;
> > +	struct desc_ptr idt_ptr;
> > +
> > +	struct ldttss_desc *tss;
> > +	struct ldttss_desc *ldt;
> > +	struct desc_struct *gdt;
> > +
> > +	u64 rsp = initial_stack;
> > +	u64 rip = (u64)&hv_vtl_ap_entry;
> > +
> > +	native_store_gdt(&gdt_ptr);
> > +	store_idt(&idt_ptr);
> > +
> > +	gdt = (struct desc_struct *)((void *)(gdt_ptr.address));
> > +	tss = (struct ldttss_desc *)(gdt + GDT_ENTRY_TSS);
> > +	ldt = (struct ldttss_desc *)(gdt + GDT_ENTRY_LDT);
> > +
> > +	local_irq_save(irq_flags);
> > +
> > +	input = (struct hv_enable_vp_vtl *)(*this_cpu_ptr(hyperv_pcpu_input_arg));
> 
> Not a big deal, but you don't actually need to cast here.

Ok, will fix.

> 
> [...]
> > +
> > +static int hv_vtl_apicid_to_vp_id(u32 apic_id)
> > +{
> > +	u64 control;
> > +	u64 status;
> > +	unsigned long irq_flags;
> > +	struct hv_get_vp_from_apic_id_in *input;
> > +	u32 *output, ret;
> > +
> > +	local_irq_save(irq_flags);
> > +
> > +	input = (struct hv_get_vp_from_apic_id_in *)(*this_cpu_ptr(hyperv_pcpu_input_arg));
> 
> No need to cast here.

Sure.

> 
> [...]
> > +struct hv_x64_table_register {
> > +	__u16 pad[3];
> > +	__u16 limit;
> > +	__u64 base;
> > +} __packed;
> > +
> > +struct hv_init_vp_context_t {
> 
> Drop the _t suffix please.

OK

Regards,
Saurabh

> 
> Thanks,
> Wei.
