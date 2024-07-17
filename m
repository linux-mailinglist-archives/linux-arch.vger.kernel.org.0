Return-Path: <linux-arch+bounces-5460-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9243933E35
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8251F22E3C
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F368181306;
	Wed, 17 Jul 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C/B/+NXF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578C181305;
	Wed, 17 Jul 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225561; cv=none; b=KPlmM+qXGI4tihquRn1P3eozI/RK5mX9b0ZXv5Q6RSeZ1IHr3WtkIW5hCO9gSEAhkIIuge4q7bNHLMCkBW9gYbu+kc26614GSFQixkcZ+C0yruV4sGrckXTCu1BBMe4oIQ+tDJAxJLP4sQZoAdr06gY2/ePZyZtCyrfiI3lEIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225561; c=relaxed/simple;
	bh=1lR02oMQv+V2tbmfFFsl0y0YQ25gtfrRxBx4+/lkn14=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:CC:From:To:
	 References:In-Reply-To; b=jrxcKn+KTUP1woDvvPC9zuDhK7icHkc4Mu86NSsRc9W3hr3BZEU8mBvea8I+0BwmcgV8KwFYgyX8plYsWkX1JpGAUmCOqNdbAkohuno+rF/NNnheaOHSxFfCkX2oyHYmMfBUys/YmhXkaZR8PzaZOwHt3K/pxrD8573xFVJW/GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C/B/+NXF; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1721225559; x=1752761559;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject;
  bh=L0gJtkXsccFAdkb5G8v7DotagDjkLmoYlxnspKJJ7cY=;
  b=C/B/+NXFQBMqkgATYsMf/Htj5kSSQ8zP8W4rU3bb8MglrCgvkwpXyrcB
   6tLQB/T0rKGzfDsGDePdrJELyeIjDinZt/kwRYZolfKvLuiyTp/VcqOR1
   wKHhDqH2DKmudYpPrraM4moOewXVKzjvDj99OV6X16atmEn/EGOV4rYjs
   I=;
X-IronPort-AV: E=Sophos;i="6.09,214,1716249600"; 
   d="scan'208";a="219459791"
Subject: Re: [PATCH 01/18] KVM: x86: hyper-v: Introduce XMM output support
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 14:12:34 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:58146]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.96:2525] with esmtp (Farcaster)
 id c3db9657-0cf7-4e75-85b4-18627a7435c3; Wed, 17 Jul 2024 14:12:33 +0000 (UTC)
X-Farcaster-Flow-ID: c3db9657-0cf7-4e75-85b4-18627a7435c3
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 17 Jul 2024 14:12:33 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Wed, 17 Jul 2024
 14:12:27 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Jul 2024 14:12:23 +0000
Message-ID: <D2RVJ6QCVNOU.XC0OC54QHI51@amazon.com>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <graf@amazon.de>,
	<dwmw2@infradead.org>, <pdurrant@amazon.com>, <mlevitsk@redhat.com>,
	<jgowans@amazon.com>, <corbet@lwn.net>, <decui@microsoft.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <amoorthy@google.com>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
X-Mailer: aerc 0.17.0-152-g73bcb4661460-dirty
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <20240609154945.55332-2-nsaenz@amazon.com> <87tth0rku3.fsf@redhat.com>
In-Reply-To: <87tth0rku3.fsf@redhat.com>
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Hi Vitaly,
Thanks for having a look at this.

On Mon Jul 8, 2024 at 2:59 PM UTC, Vitaly Kuznetsov wrote:
> Nicolas Saenz Julienne <nsaenz@amazon.com> writes:
>
> > Prepare infrastructure to be able to return data through the XMM
> > registers when Hyper-V hypercalls are issues in fast mode. The XMM
> > registers are exposed to user-space through KVM_EXIT_HYPERV_HCALL and
> > restored on successful hypercall completion.
> >
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> >
> > ---
> >
> > There was some discussion in the RFC about whether growing 'struct
> > kvm_hyperv_exit' is ABI breakage. IMO it isn't:
> > - There is padding in 'struct kvm_run' that ensures that a bigger
> >   'struct kvm_hyperv_exit' doesn't alter the offsets within that struct=
.
> > - Adding a new field at the bottom of the 'hcall' field within the
> >   'struct kvm_hyperv_exit' should be fine as well, as it doesn't alter
> >   the offsets within that struct either.
> > - Ultimately, previous updates to 'struct kvm_hyperv_exit's hint that
> >   its size isn't part of the uABI. It already grew when syndbg was
> >   introduced.
>
> Yes but SYNDBG exit comes with KVM_EXIT_HYPERV_SYNDBG. While I don't see
> any immediate issues with the current approach, we may want to introduce
> something like KVM_EXIT_HYPERV_HCALL_XMM: the userspace must be prepared
> to handle this new information anyway and it is better to make
> unprepared userspace fail with 'unknown exit' then to mishandle a
> hypercall by ignoring XMM portion of the data.

OK, I'll go that way. Just wanted to get a better understanding of why
you felt it was necessary.

> >
> >  Documentation/virt/kvm/api.rst     | 19 ++++++++++
> >  arch/x86/include/asm/hyperv-tlfs.h |  2 +-
> >  arch/x86/kvm/hyperv.c              | 56 +++++++++++++++++++++++++++++-
> >  include/uapi/linux/kvm.h           |  6 ++++
> >  4 files changed, 81 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/ap=
i.rst
> > index a71d91978d9ef..17893b330b76f 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -8893,3 +8893,22 @@ Ordering of KVM_GET_*/KVM_SET_* ioctls
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> >  TBD
> > +
> > +10. Hyper-V CPUIDs
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This section only applies to x86.
>
> We can probably use
>
> :Architectures: x86
>
> which we already use.

Noted.

> > +
> > +New Hyper-V feature support is no longer being tracked through KVM
> > +capabilities.  Userspace can check if a particular version of KVM supp=
orts a
> > +feature using KMV_GET_SUPPORTED_HV_CPUID.  This section documents how =
Hyper-V
> > +CPUIDs map to KVM functionality.
> > +
> > +10.1 HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE
> > +------------------------------------------
> > +
> > +:Location: CPUID.40000003H:EDX[bit 15]
> > +
> > +This CPUID indicates that KVM supports retuning data to the guest in r=
esponse
> > +to a hypercall using the XMM registers. It also extends ``struct
> > +kvm_hyperv_exit`` to allow passing the XMM data from userspace.
>
> It's always good to document things, thanks! I'm, however, wondering
> what should we document as part of KVM API. In the file, we already
> have:
> - "4.118 KVM_GET_SUPPORTED_HV_CPUID"
> - "struct kvm_hyperv_exit" description in "5. The kvm_run structure"
>
> The later should definitely get extended to cover XMM and I guess the
> former can accomodate the 'no longer being tracked' comment. With that,
> maybe there's no need for a new section?

I'll try to fit it that way.

> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/=
hyperv-tlfs.h
> > index 3787d26810c1c..6a18c9f77d5fe 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -49,7 +49,7 @@
> >  /* Support for physical CPU dynamic partitioning events is available*/
> >  #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE    BIT(3)
> >  /*
> > - * Support for passing hypercall input parameter block via XMM
> > + * Support for passing hypercall input and output parameter block via =
XMM
> >   * registers is available
> >   */
> >  #define HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE         BIT(4)
>
> This change of the comment is weird (or I may have forgotten something
> important), could you please elaborate?. Currently, we have:
>
> /*
>  * Support for passing hypercall input parameter block via XMM
>  * registers is available
>  */
> #define HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE         BIT(4)
> ...
> /*
>  * Support for returning hypercall output block via XMM
>  * registers is available
>  */
> #define HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE                BIT(15)
>
> which seems to be correct. TLFS also defines
>
> Bit 4: XmmRegistersForFastHypercallAvailable
>
> in CPUID 0x40000009.EDX (Nested Hypervisor Feature Identification) which
> probably covers both but we don't set this leaf in KVM currently ...

You're right, this comment update no longer applies. It used to in an
older version of the patch, but slipped through the cracks as I rebased
it. Sorry.

> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 8a47f8541eab7..42f44546fe79c 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -1865,6 +1865,7 @@ struct kvm_hv_hcall {
> >       u16 rep_idx;
> >       bool fast;
> >       bool rep;
> > +     bool xmm_dirty;
> >       sse128_t xmm[HV_HYPERCALL_MAX_XMM_REGISTERS];
> >
> >       /*
> > @@ -2396,9 +2397,49 @@ static int kvm_hv_hypercall_complete(struct kvm_=
vcpu *vcpu, u64 result)
> >       return ret;
> >  }
> >
> > +static void kvm_hv_write_xmm(struct kvm_hyperv_xmm_reg *xmm)
> > +{
> > +     int reg;
> > +
> > +     kvm_fpu_get();
> > +     for (reg =3D 0; reg < HV_HYPERCALL_MAX_XMM_REGISTERS; reg++) {
> > +             const sse128_t data =3D sse128(xmm[reg].low, xmm[reg].hig=
h);
> > +             _kvm_write_sse_reg(reg, &data);
> > +     }
> > +     kvm_fpu_put();
> > +}
> > +
> > +static bool kvm_hv_is_xmm_output_hcall(u16 code)
> > +{
> > +     return false;
> > +}
> > +
> > +static bool kvm_hv_xmm_output_allowed(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_vcpu_hv *hv_vcpu =3D to_hv_vcpu(vcpu);
> > +
> > +     return !hv_vcpu->enforce_cpuid ||
> > +            hv_vcpu->cpuid_cache.features_edx &
> > +                    HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
> > +}
> > +
> >  static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
> >  {
> > -     return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.=
result);
> > +     bool fast =3D !!(vcpu->run->hyperv.u.hcall.input & HV_HYPERCALL_F=
AST_BIT);
> > +     u16 code =3D vcpu->run->hyperv.u.hcall.input & 0xffff;
> > +     u64 result =3D vcpu->run->hyperv.u.hcall.result;
> > +
> > +     if (hv_result_success(result) && fast &&
> > +         kvm_hv_is_xmm_output_hcall(code)) {
>
> Assuming hypercalls with XMM output are always 'fast', should we include
> 'fast' check in kvm_hv_is_xmm_output_hcall()?

Sounds good, yes.

> > +             if (unlikely(!kvm_hv_xmm_output_allowed(vcpu))) {
> > +                     kvm_queue_exception(vcpu, UD_VECTOR);
> > +                     return 1;
> > +             }
> > +
> > +             kvm_hv_write_xmm(vcpu->run->hyperv.u.hcall.xmm);
> > +     }
> > +
> > +     return kvm_hv_hypercall_complete(vcpu, result);
> >  }
> >
> >  static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_h=
v_hcall *hc)
> > @@ -2553,6 +2594,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
> >       hc.rep_cnt =3D (hc.param >> HV_HYPERCALL_REP_COMP_OFFSET) & 0xfff=
;
> >       hc.rep_idx =3D (hc.param >> HV_HYPERCALL_REP_START_OFFSET) & 0xff=
f;
> >       hc.rep =3D !!(hc.rep_cnt || hc.rep_idx);
> > +     hc.xmm_dirty =3D false;
> >
> >       trace_kvm_hv_hypercall(hc.code, hc.fast, hc.var_cnt, hc.rep_cnt,
> >                              hc.rep_idx, hc.ingpa, hc.outgpa);
> > @@ -2673,6 +2715,15 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
> >               break;
> >       }
> >
> > +     if (hv_result_success(ret) && hc.xmm_dirty) {
> > +             if (unlikely(!kvm_hv_xmm_output_allowed(vcpu))) {
> > +                     kvm_queue_exception(vcpu, UD_VECTOR);
> > +                     return 1;
> > +             }
> > +
> > +             kvm_hv_write_xmm((struct kvm_hyperv_xmm_reg *)hc.xmm);
> > +     }
> > +
> >  hypercall_complete:
> >       return kvm_hv_hypercall_complete(vcpu, ret);
> >
> > @@ -2682,6 +2733,8 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
> >       vcpu->run->hyperv.u.hcall.input =3D hc.param;
> >       vcpu->run->hyperv.u.hcall.params[0] =3D hc.ingpa;
> >       vcpu->run->hyperv.u.hcall.params[1] =3D hc.outgpa;
> > +     if (hc.fast)
> > +             memcpy(vcpu->run->hyperv.u.hcall.xmm, hc.xmm, sizeof(hc.x=
mm));
> >       vcpu->arch.complete_userspace_io =3D kvm_hv_hypercall_complete_us=
erspace;
> >       return 0;
> >  }
> > @@ -2830,6 +2883,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struc=
t kvm_cpuid2 *cpuid,
> >                       ent->ebx |=3D HV_ENABLE_EXTENDED_HYPERCALLS;
> >
> >                       ent->edx |=3D HV_X64_HYPERCALL_XMM_INPUT_AVAILABL=
E;
> > +                     ent->edx |=3D HV_X64_HYPERCALL_XMM_OUTPUT_AVAILAB=
LE;
> >                       ent->edx |=3D HV_FEATURE_FREQUENCY_MSRS_AVAILABLE=
;
> >                       ent->edx |=3D HV_FEATURE_GUEST_CRASH_MSR_AVAILABL=
E;
> >
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index d03842abae578..fbdee8d754595 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -90,6 +90,11 @@ struct kvm_pit_config {
> >
> >  #define KVM_PIT_SPEAKER_DUMMY     1
> >
> > +struct kvm_hyperv_xmm_reg {
> > +     __u64 low;
> > +     __u64 high;
> > +};
> > +
> >  struct kvm_hyperv_exit {
> >  #define KVM_EXIT_HYPERV_SYNIC          1
> >  #define KVM_EXIT_HYPERV_HCALL          2
> > @@ -108,6 +113,7 @@ struct kvm_hyperv_exit {
> >                       __u64 input;
> >                       __u64 result;
> >                       __u64 params[2];
> > +                     struct kvm_hyperv_xmm_reg xmm[6];
>
> In theory, we have HV_HYPERCALL_MAX_XMM_REGISTERS in TLFS (which you
> already use in the code). While I'm not sure it makes sense to make KVM
> ABI dependent on TLFS changes (probably not), we may want to leave a
> short comment explaining where '6' comes from.

Will do.

Thanks,
Nicolas

