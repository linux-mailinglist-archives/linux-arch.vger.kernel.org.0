Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1F6A85CF
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 17:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCBQFi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 11:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCBQFi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 11:05:38 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE1F83B0D6;
        Thu,  2 Mar 2023 08:05:33 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 48FDB209FE32; Thu,  2 Mar 2023 08:05:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48FDB209FE32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677773133;
        bh=L801GfCIaCc8TQ59NB6OalOz4HbAG1dowLBurfTTNUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EbEOiM7jx9UTqagU+Vf/tR69Gm/9ndQznRX4QcmY592TKfPoI9Xdo61UbOv6g4xWK
         XqIZ8wINF2wRqwaTh+ksYgTfqQlb9GMjzL0b4PBZsl2mV9cPVdsVnufpu9+DmfaHge
         hUmCmWEua0E7ofBqUREv6iYojXaZxGcX/QevxzGk=
Date:   Thu, 2 Mar 2023 08:05:33 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/hyperv: VTL support for Hyper-V
Message-ID: <20230302160533.GA30703@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1677665288-6879-1-git-send-email-ssengar@linux.microsoft.com>
 <1677665288-6879-3-git-send-email-ssengar@linux.microsoft.com>
 <20230301133436.GA1135@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301133436.GA1135@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

Thanks for your review.

On Wed, Mar 01, 2023 at 05:34:36AM -0800, Jeremi Piotrowski wrote:
> On Wed, Mar 01, 2023 at 02:08:08AM -0800, Saurabh Sengar wrote:
> > VTL helps enable Hyper-V Virtual Secure Mode (VSM) feature. VSM is a
> > set of hypervisor capabilities and enlightenments offered to host and
> > guest partitions which enable the creation and management of new
> > security boundaries within operating system software. VSM achieves
> > and maintains isolation through VTLs.
> > 
> > Add early initialization for Virtual Trust Levels (VTL). This includes
> > initializing the x86 platform for VTL and enabling boot support for
> > secondary CPUs to start in targeted VTL context. For now, only enable
> > the code for targeted VTL level as 2.
> > 
> > In VTL, AP has to start directly in the 64-bit mode, bypassing the
> > usual 16-bit -> 32-bit -> 64-bit mode transition sequence that occurs
> > after waking up an AP with SIPI whose vector points to the 16-bit AP
> > startup trampoline code.
> > 
> > This commit also moves hv_get_nmi_reason function to header file, so
> > that it can be reused by VTL.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/Kconfig                   |  23 +++
> >  arch/x86/hyperv/Makefile           |   1 +
> >  arch/x86/hyperv/hv_vtl.c           | 242 +++++++++++++++++++++++++++++
> >  arch/x86/include/asm/hyperv-tlfs.h |  75 +++++++++
> >  arch/x86/include/asm/mshyperv.h    |  14 ++
> >  arch/x86/kernel/cpu/mshyperv.c     |   6 +-
> >  include/asm-generic/hyperv-tlfs.h  |   4 +
> >  7 files changed, 360 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/x86/hyperv/hv_vtl.c
> > 
(...)
> > +	 * Do not try to access the PIC (even if it is there).
> > +	 * Reserve 1 IRQ so that PCI MSIs to not get allocated to virq 0,
> > +	 * which is not generally considered a valid IRQ by Linux (and so
> > +	 * causes various problems).
> > +	 */
> 
> This sounds like a bug that should be investigated and fixed and not worked around.

Agree, I will fix thi in V2.

> 
> > +	vtl_pic = null_legacy_pic;
> > +	vtl_pic.nr_legacy_irqs = 1;
> > +	vtl_pic.probe = vtl_pic_probe;
> > +	legacy_pic = &vtl_pic;
> > +}
> > +
> > +static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
> > +{
> > +	return ((u64)desc->base3 << 32) | ((u64)desc->base2 << 24) |
> > +		(desc->base1 << 16) | desc->base0;
> > +}
(...)
> > +	if (boot_cpu_has(X86_FEATURE_XSAVE))
> > +		panic("XSAVE has to be disabled as it is not supported by this module.\n"
> > +			  "Please add 'noxsave' to the kernel command line.\n");
> 
> boot_cpu_has -> cpu_feature_enabled (I've seen this suggestion from Boris several times).

OK

> 
> > +
> > +	real_mode_header = &hv_vtl_real_mode_header;
> > +	apic->wakeup_secondary_cpu_64 = hv_vtl_wakeup_secondary_cpu;
> > +
> > +	return 0;
> > +}
> > +early_initcall(hv_vtl_early_init);
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> > index 0b73a809e9e1..08a6845a233d 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -713,6 +713,81 @@ union hv_msi_entry {
> >  	} __packed;
> >  };
> >  
> > +struct hv_x64_segment_register {
> > +	__u64 base;
> > +	__u32 limit;
> > +	__u16 selector;
> > +	union {
> > +		struct {
(...)
> > -	return 0;
> > -}
> > -
> >  #ifdef CONFIG_X86_LOCAL_APIC
> >  /*
> >   * Prior to WS2016 Debug-VM sends NMIs to all CPUs which makes
> > @@ -521,6 +516,7 @@ static void __init ms_hyperv_init_platform(void)
> >  
> >  	/* Register Hyper-V specific clocksource */
> >  	hv_init_clocksource();
> > +	hv_vtl_init_platform();
> 
> Is there a way to runtime check for VTL and which VTL we're running at? That
> way this could be made a conditional call, and kernels with HYPERV_VTL enabled
> would also work in a normal environment.

VTL can only be detected at runtime via hypercall. However hypercalls
are not available this early in boot process.

> 
> >  #endif
> >  	/*
> >  	 * TSC should be marked as unstable only after Hyper-V
> > diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> > index b870983596b9..87258341fd7c 100644
> > --- a/include/asm-generic/hyperv-tlfs.h
> > +++ b/include/asm-generic/hyperv-tlfs.h
> > @@ -146,6 +146,7 @@ union hv_reference_tsc_msr {
> >  /* Declare the various hypercall operations. */
> >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
> >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
> > +#define HVCALL_ENABLE_VP_VTL			0x000f
> >  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
> >  #define HVCALL_SEND_IPI				0x000b
> >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
> > @@ -165,6 +166,8 @@ union hv_reference_tsc_msr {
> >  #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
> >  #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
> >  #define HVCALL_RETARGET_INTERRUPT		0x007e
> > +#define HVCALL_START_VP				0x0099
> > +#define HVCALL_GET_VP_ID_FROM_APIC_ID		0x009a
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
> >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
> >  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
> > @@ -218,6 +221,7 @@ enum HV_GENERIC_SET_FORMAT {
> >  #define HV_STATUS_INVALID_PORT_ID		17
> >  #define HV_STATUS_INVALID_CONNECTION_ID		18
> >  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> > +#define HV_STATUS_VTL_ALREADY_ENABLED		134
> >  
> >  /*
> >   * The Hyper-V TimeRefCount register and the TSC
> > -- 
> > 2.34.1
> > 
