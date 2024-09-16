Return-Path: <linux-arch+bounces-7334-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EAB97A55F
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 17:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC5B1C25420
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84D158A1F;
	Mon, 16 Sep 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kdRYpM8s"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF4158550;
	Mon, 16 Sep 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500834; cv=none; b=uhAJY+n/Q5k+Yh35NQgJFc2VDZLLeYkzOgOXY+Xv6D0aQgzNct+v3T7WJHEecTVBNVmTugf/uilmJi/Xhx4bWKJmAZiPMsn4uUjTFLvPDBdIkMOl6rtjV6+L/hpmYOUcxb49Vm9pdL1eKzeNIRH1lTTjWo45oip18CK3/dhh7Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500834; c=relaxed/simple;
	bh=IY8C+StfjFJHJtqw4O3q5t4JZ6R26AYxgS+dshF64Y8=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:From:To:CC:
	 References:In-Reply-To; b=np8Ays1Rywe5EWMAWEaCf58M/my84IY9VZZOVJCbrQ/yJw8Vl/wx6xFElNpRS99CGak7FNQ1PxhhQJQNVi/a++i9zy5MYqCFi//6X1pTV+RWYSMmV4pW7d9ED5rjK8Ab4IpascCutIBCXdjz8G9UAHDHAbJg4qe3YIn7X1iUAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kdRYpM8s; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726500833; x=1758036833;
  h=mime-version:content-transfer-encoding:date:message-id:
   from:to:cc:references:in-reply-to:subject;
  bh=EEwEknCR7gPqewEKfA7AQyWhoTIg8MMivyoECSmpsEI=;
  b=kdRYpM8slLpP1+mbE98ePb1MrORmSx6TZzULdNMAqdyuZc8ehl2plGhw
   MUnQcVhNZvLmkItwz2bz8JnWXc7lj0NccZQk17epiH20PQXgIw3OgFGVq
   JD8W7Uj5PtT3EYxDSK61E9NsEQ4SEGi1xSEQ9mAaKbKVkkbC1wP+Va8iB
   w=;
X-IronPort-AV: E=Sophos;i="6.10,233,1719878400"; 
   d="scan'208";a="25953235"
Subject: Re: [PATCH 05/18] KVM: x86: hyper-v: Introduce MP_STATE_HV_INACTIVE_VTL
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 15:33:48 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:51984]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.23:2525] with esmtp (Farcaster)
 id f0c8e00d-30a9-4cd0-acb9-4acbebf05106; Mon, 16 Sep 2024 15:33:46 +0000 (UTC)
X-Farcaster-Flow-ID: f0c8e00d-30a9-4cd0-acb9-4acbebf05106
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 16 Sep 2024 15:33:45 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 16 Sep 2024
 15:33:39 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Sep 2024 15:33:36 +0000
Message-ID: <D47TGLMWFTN2.2VCKLFM1K4GM8@amazon.com>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<pbonzini@redhat.com>, <vkuznets@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <graf@amazon.de>,
	<dwmw2@infradead.org>, <mlevitsk@redhat.com>, <jgowans@amazon.com>,
	<corbet@lwn.net>, <decui@microsoft.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <amoorthy@google.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049-dirty
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <20240609154945.55332-6-nsaenz@amazon.com> <ZuSL_FCfvVywCPxm@google.com>
In-Reply-To: <ZuSL_FCfvVywCPxm@google.com>
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Fri Sep 13, 2024 at 7:01 PM UTC, Sean Christopherson wrote:
> On Sun, Jun 09, 2024, Nicolas Saenz Julienne wrote:
> > Model inactive VTL vCPUs' behaviour with a new MP state.
> >
> > Inactive VTLs are in an artificial halt state. They enter into this
> > state in response to invoking HvCallVtlCall, HvCallVtlReturn.
> > User-space, which is VTL aware, can processes the hypercall, and set th=
e
> > vCPU in MP_STATE_HV_INACTIVE_VTL. When a vCPU is run in this state it'l=
l
> > block until a wakeup event is received. The rules of what constitutes a=
n
> > event are analogous to halt's except that VTL's ignore RFLAGS.IF.
> >
> > When a wakeup event is registered, KVM will exit to user-space with a
> > KVM_SYSTEM_EVENT exit, and KVM_SYSTEM_EVENT_WAKEUP event type.
> > User-space is responsible of deciding whether the event has precedence
> > over the active VTL and will switch the vCPU to KVM_MP_STATE_RUNNABLE
> > before resuming execution on it.
> >
> > Running a KVM_MP_STATE_HV_INACTIVE_VTL vCPU with pending events will
> > return immediately to user-space.
> >
> > Note that by re-using the readily available halt infrastructure in
> > KVM_RUN, MP_STATE_HV_INACTIVE_VTL correctly handles (or disables)
> > virtualisation features like the VMX preemption timer or APICv before
> > blocking.
>
> IIUC, this is a convoluted and roundabout way to let userspace check if a=
 vCPU
> has a wake event, correct?  Even by the end of the series, KVM never sets
> MP_STATE_HV_INACTIVE_VTL, i.e. the only use for this is to combine it as:
>
>   KVM_SET_MP_STATE =3D> KVM_RUN =3D> KVM_SET_MP_STATE =3D> KVM_RUN

Correct.

> The upside to this approach is that it requires minimal uAPI and very few=
 KVM
> changes, but that's about it AFAICT.  On the other hand, making this so p=
ainfully
> specific feels like a missed opportunity, and unnecessarily bleeds VTL de=
tails
> into KVM.
>
> Bringing halt-polling into the picture (by going down kvm_vcpu_halt()) is=
 also
> rather bizarre since quite a bit of time has already elapsed since the vC=
PU first
> did HvCallVtlCall/HvCallVtlReturn.  But that doesn't really have anything=
 to do
> with MP_STATE_HV_INACTIVE_VTL, e.g. it'd be just as easy to go to kvm_vcp=
u_block().
>
> Why not add an ioctl() to very explicitly block until a wake event is rea=
dy?
> Or probably better, a generic "wait" ioctl() that takes the wait type as =
an
> argument.
>
> Kinda like your idea of supporting .poll() on the vCPU FD[*], except it's=
 very
> specifically restricted to a single caller (takes vcpu->mutex).  We could=
 probably
> actually implement it via .poll(), but I suspect that would be more confu=
sing than
> helpful.
>
> E.g. extract the guts of vcpu_block() to a separate helper, and then wire=
 that
> up to an ioctl().
>
> As for the RFLAGS.IF quirk, maybe handle that via a kvm_run flag?  That w=
ay,
> userspace doesn't need to do a round-trip just to set a single bit.  E.g.=
 I think
> we should be able to squeeze it into "struct kvm_hyperv_exit".

It's things like the RFLAG.IF exemption that deterred me from building a
generic interface. We might find out that the generic blocking logic
doesn't match the expected VTL semantics and be stuck with a uAPI that
isn't enough for VSM, nor useful for any other use-case. We can always
introduce 'flags' I guess.

Note that I'm just being cautious here, AFAICT the generic approach
works, and I'm fine with going the "wait" ioctl.

> Actually, speaking of kvm_hyperv_exit, is there a reason we can't simply =
wire up
> HVCALL_VTL_CALL and/or HVCALL_VTL_RETURN to a dedicated complete_userspac=
e_io()
> callback that blocks if some flag is set?  That would make it _much_ clea=
ner to
> scope the RFLAGS.IF check to kvm_hyperv_exit, and would require little to=
 no new
> uAPI.

So IIUC, the approach is to have complete_userspace_io() block after
re-entering HVCALL_VTL_RETURN. Then, have it exit back onto user-space
whenever an event is made available (maybe re-using
KVM_SYSTEM_EVENT_WAKEUP?). That would work, but will need something
extra to be compatible with migration/live-update.

> > @@ -3797,6 +3798,10 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu=
)
> >         if (!gif_set(svm))
> >                 return true;
> >
> > +       /*
> > +        * The Hyper-V TLFS states that RFLAGS.IF is ignored when decid=
ing
> > +        * whether to block interrupts targeted at inactive VTLs.
> > +        */
> >         if (is_guest_mode(vcpu)) {
> >                 /* As long as interrupts are being delivered...  */
> >                 if ((svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
> > @@ -3808,7 +3813,7 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
> >                 if (nested_exit_on_intr(svm))
> >                         return false;
> >         } else {
> > -               if (!svm_get_if_flag(vcpu))
> > +               if (!svm_get_if_flag(vcpu) && !kvm_hv_vcpu_is_idle_vtl(=
vcpu))
>
> Speaking of RFLAGS.IF, I think it makes sense to add a common x86 helper =
to handle
> the RFLAGS.IF vs. idle VTL logic.  Naming will be annoying, but that's ab=
out it.
>
> E.g. kvm_is_irq_blocked_by_rflags_if() or so.

Noted.

Thanks,
Nicolas

