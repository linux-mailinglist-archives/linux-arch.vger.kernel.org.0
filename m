Return-Path: <linux-arch+bounces-7333-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F597A47D
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 16:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47A91C21D53
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F1B158523;
	Mon, 16 Sep 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="otwDDfn4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2A146588;
	Mon, 16 Sep 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498340; cv=none; b=Gjuc5O07R73U5CoZ1Njt1LZRPj9IDbMXnc50RMvAlHPWyYPaOtvPXkw5KTAsOL4zjJ6CZbzOLm20in51yaGeuXtWtlxavYI8B1ryLpvzV99WfOigLVv2ks2hZ1a5mubBMB2RLjLhjYAmldlGNLA69+hWD5QViOSOOvmnavxHjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498340; c=relaxed/simple;
	bh=c/xZV+vX/Am3bdWc4bOOmCu/skaynt30LDYMe3YOsAY=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:CC:From:To:
	 References:In-Reply-To; b=hSUJMESIjFMaPdo0HLl+sOTiaO1Xm0HhRquasSq5+AdRpyCF12Wh1qJpv53rU2+x7RVCMvR4GDextGTFE5hDhYqcCpfifHULXJrNaNdKpZaPvmE6GqbM3jy8neUxpg7q+6AJ+pglRRWSYEbbDJVrxU8l9bgFkqKQXNXUpf4lKq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=otwDDfn4; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726498338; x=1758034338;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject;
  bh=qpilrzXT5OVD0x5gqq4ZRxUMpgVlkAXVHRopkQ5KZ8k=;
  b=otwDDfn4ACgGojxta66fAK5ip3dVhdVB3efuPAvokB/vs6IKv9KOwFZj
   dtDB1LRHGQ8hcYz2NbFU2TZyD5A2HQC/xg41UzTXlTz3/Mc2w7jUurzMl
   pNp6NRz9DJVxj6Z7cTigcmWtdtBpNoFZKynyPlPofAlF3ON8Dxo4yrbQw
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,233,1719878400"; 
   d="scan'208";a="659258169"
Subject: Re: [PATCH 04/18] KVM: x86: hyper-v: Introduce VTL awareness to Hyper-V's
 PV-IPIs
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 14:52:15 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:33892]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.20.15:2525] with esmtp (Farcaster)
 id 0671944c-7143-4254-94e0-c5381100ea42; Mon, 16 Sep 2024 14:52:14 +0000 (UTC)
X-Farcaster-Flow-ID: 0671944c-7143-4254-94e0-c5381100ea42
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 16 Sep 2024 14:52:13 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 16 Sep 2024
 14:52:07 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Sep 2024 14:52:04 +0000
Message-ID: <D47SKSRO10AG.GPBOAAJP64VP@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<pbonzini@redhat.com>, <vkuznets@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <graf@amazon.de>,
	<dwmw2@infradead.org>, <paul@amazon.com>, <mlevitsk@redhat.com>,
	<jgowans@amazon.com>, <corbet@lwn.net>, <decui@microsoft.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <amoorthy@google.com>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Sean Christopherson <seanjc@google.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049-dirty
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <20240609154945.55332-5-nsaenz@amazon.com> <ZuR-SPaaTBwLTxW3@google.com>
In-Reply-To: <ZuR-SPaaTBwLTxW3@google.com>
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Fri Sep 13, 2024 at 6:02 PM UTC, Sean Christopherson wrote:
> On Sun, Jun 09, 2024, Nicolas Saenz Julienne wrote:
> > HvCallSendSyntheticClusterIpi and HvCallSendSyntheticClusterIpiEx allow
> > sending VTL-aware IPIs. Honour the hcall by exiting to user-space upon
> > receiving a request with a valid VTL target. This behaviour is only
> > available if the VSM CPUID flag is available and exposed to the guest.
> > It doesn't introduce a behaviour change otherwise.
> >
> > User-space is accountable for the correct processing of the PV-IPI
> > before resuming execution.
> >
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> > ---
> >  arch/x86/kvm/hyperv.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 42f44546fe79c..d00baf3ffb165 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -2217,16 +2217,20 @@ static void kvm_hv_send_ipi_to_many(struct kvm =
*kvm, u32 vector,
> >
> >  static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall =
*hc)
> >  {
> > +     bool vsm_enabled =3D kvm_hv_cpuid_vsm_enabled(vcpu);
> >       struct kvm_vcpu_hv *hv_vcpu =3D to_hv_vcpu(vcpu);
> >       u64 *sparse_banks =3D hv_vcpu->sparse_banks;
> >       struct kvm *kvm =3D vcpu->kvm;
> >       struct hv_send_ipi_ex send_ipi_ex;
> >       struct hv_send_ipi send_ipi;
> > +     union hv_input_vtl *in_vtl;
> >       u64 valid_bank_mask;
> > +     int rsvd_shift;
> >       u32 vector;
> >       bool all_cpus;
> >
> >       if (hc->code =3D=3D HVCALL_SEND_IPI) {
> > +             in_vtl =3D &send_ipi.in_vtl;
>
> I don't see any value in having a local pointer to a union.  Just use sen=
d_ipi.in_vtl.

OK, I'll simplify it.

> >               if (!hc->fast) {
> >                       if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send=
_ipi,
> >                                                   sizeof(send_ipi))))
> > @@ -2235,16 +2239,22 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcp=
u, struct kvm_hv_hcall *hc)
> >                       vector =3D send_ipi.vector;
> >               } else {
> >                       /* 'reserved' part of hv_send_ipi should be 0 */
> > -                     if (unlikely(hc->ingpa >> 32 !=3D 0))
> > +                     rsvd_shift =3D vsm_enabled ? 40 : 32;
> > +                     if (unlikely(hc->ingpa >> rsvd_shift !=3D 0))
> >                               return HV_STATUS_INVALID_HYPERCALL_INPUT;
>
> The existing error handling doesn't make any sense to me.  Why is this th=
e _only_
> path that enforces reserved bits?

I don't know.

As far as I can tell, the hypercall was introduced in v5 of the TLFS and
already contained the VTL selection bits. Unfortunately the spec doesn't
explicitly state what to do when hv_input_vtl is received from a non-VSM
enabled guest, so I tried to keep the current behaviour for every case
(send_ipi/send_ipi_ex/fast/!fat).

> Regarding the shift, I think it makes more sense to do:
>
>                         /* Bits 63:40 are always reserved. */
>                         if (unlikely(hc->ingpa >> 40 !=3D 0))
>                                 return HV_STATUS_INVALID_HYPERCALL_INPUT;
>
>                         send_ipi.in_vtl.as_uint8 =3D (u8)(hc->ingpa >> 32=
);
>                         if (unlikely(!vsm_enabled && send_ipi.in_vtl.as_u=
int8))
>                                 return HV_STATUS_INVALID_HYPERCALL_INPUT;
>
> so that it's more obvious exactly what is/isn't reserved when VSM isn't/i=
s enabled.

OK, I agree it's nicer.

> > +                     in_vtl->as_uint8 =3D (u8)(hc->ingpa >> 32);
> >                       sparse_banks[0] =3D hc->outgpa;
> >                       vector =3D (u32)hc->ingpa;
> >               }
> >               all_cpus =3D false;
> >               valid_bank_mask =3D BIT_ULL(0);
> >
> > +             if (in_vtl->use_target_vtl)
>
> Due to the lack of error checking for the !hc->fast case, this will do th=
e wrong
> thing if vsm_enabled=3Dfalse.

Yes. I'll fix it.

Thanks,
Nicolas

