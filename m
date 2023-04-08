Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B786DB8D5
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 06:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDHE2F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 00:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDHE2E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 00:28:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96938B456;
        Fri,  7 Apr 2023 21:28:02 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 19BA7213B640; Fri,  7 Apr 2023 21:28:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19BA7213B640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680928082;
        bh=W+0x2OvkEBqnZiWb8C8jsuH6ZwkjR30+p5rTEImjBuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOUImu6FQ4W41G/6fzFr2LxrANh36hnC+OtlWuglGa6LH4AGOo7kMb6SnFwBaykD5
         gVsLTzOwA/A/CSxNWbBwWUaJynpijxctsqe5DvJdgZ2w54y015KNwb+xHIO6N6JlnP
         kHXbFwSfJ31TNnygZRrw11QVd+nTXG8u+8FtyYaA=
Date:   Fri, 7 Apr 2023 21:28:02 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: Re: [PATCH v4 2/5] x86/hyperv: Add VTL specific structs and
 hypercalls
Message-ID: <20230408042802.GA14345@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
 <1680598864-16981-3-git-send-email-ssengar@linux.microsoft.com>
 <20230406135113.GB1317@skinsburskii.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406135113.GB1317@skinsburskii.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 06, 2023 at 06:51:13AM -0700, Stanislav Kinsburskii wrote:
> On Tue, Apr 04, 2023 at 02:01:01AM -0700, Saurabh Sengar wrote:
> > Add structs and hypercalls required to enable VTL support on x86.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/x86/include/asm/hyperv-tlfs.h | 75 ++++++++++++++++++++++++++++++
> >  include/asm-generic/hyperv-tlfs.h  |  4 ++
> >  2 files changed, 79 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> > index 0b73a809e9e1..0b0b4e9a4318 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -713,6 +713,81 @@ union hv_msi_entry {
> >  	} __packed;
> >  };
> >  
> > +struct hv_x64_segment_register {
> > +	__u64 base;
> 
> Ideally they arch-size types naming should be consistent: either with underscores or
> without.
> The majority of cases in this file are without underscores.

Although I am fine either way, I think in a non-uapi file "without underscore" is prefered.
I can change this in next version.

Regards,
Saurabh


> 
> Reviewed-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> 
> > +	__u32 limit;
> > +	__u16 selector;
> > +	union {
> > +		struct {
> > +			__u16 segment_type : 4;
> > +			__u16 non_system_segment : 1;
> > +			__u16 descriptor_privilege_level : 2;
> > +			__u16 present : 1;
> > +			__u16 reserved : 4;
> > +			__u16 available : 1;
> > +			__u16 _long : 1;
> > +			__u16 _default : 1;
> > +			__u16 granularity : 1;
> > +		} __packed;
> > +		__u16 attributes;
> > +	};
> > +} __packed;
> > +
> > +struct hv_x64_table_register {
> > +	__u16 pad[3];
> > +	__u16 limit;
> > +	__u64 base;
> > +} __packed;
> > +
> > +struct hv_init_vp_context {
> > +	u64 rip;
> > +	u64 rsp;
> > +	u64 rflags;
> > +
> > +	struct hv_x64_segment_register cs;
> > +	struct hv_x64_segment_register ds;
> > +	struct hv_x64_segment_register es;
> > +	struct hv_x64_segment_register fs;
> > +	struct hv_x64_segment_register gs;
> > +	struct hv_x64_segment_register ss;
> > +	struct hv_x64_segment_register tr;
> > +	struct hv_x64_segment_register ldtr;
> > +
> > +	struct hv_x64_table_register idtr;
> > +	struct hv_x64_table_register gdtr;
> > +
> > +	u64 efer;
> > +	u64 cr0;
> > +	u64 cr3;
> > +	u64 cr4;
> > +	u64 msr_cr_pat;
> > +} __packed;
> > +
> > +union hv_input_vtl {
> > +	u8 as_uint8;
> > +	struct {
> > +		u8 target_vtl: 4;
> > +		u8 use_target_vtl: 1;
> > +		u8 reserved_z: 3;
> > +	};
> > +} __packed;
> > +
> > +struct hv_enable_vp_vtl {
> > +	u64				partition_id;
> > +	u32				vp_index;
> > +	union hv_input_vtl		target_vtl;
> > +	u8				mbz0;
> > +	u16				mbz1;
> > +	struct hv_init_vp_context	vp_context;
> > +} __packed;
> > +
> > +struct hv_get_vp_from_apic_id_in {
> > +	u64 partition_id;
> > +	union hv_input_vtl target_vtl;
> > +	u8 res[7];
> > +	u32 apic_ids[];
> > +} __packed;
> > +
> >  #include <asm-generic/hyperv-tlfs.h>
> >  
> >  #endif
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
