Return-Path: <linux-arch+bounces-7350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B2597B8D2
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B28B1F22B5C
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9174C08;
	Wed, 18 Sep 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPk6lIPO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA017085C
	for <linux-arch@vger.kernel.org>; Wed, 18 Sep 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646180; cv=none; b=OueSRX9/W4cH9T7uYEd6HK3B3cG9I5A9+L9quOmNCjLK5GaRKAvMO+YwSlbj4scKFs3iWg1lapqDk3f9yM7QQtR//oyOIUoiXw/+RSMR5ZdJKCX5ek2n0+9IrV4Qw7UQJu+yZY/Nk/DnEOYUq0f4TbiAiBOmq0EZWQdCZnk3rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646180; c=relaxed/simple;
	bh=E6sYje1FTSCQR6Phn3zxl12MQWQkG0ia5UJs7jeqW10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZXFiSBThSkoexN6X8Us8Pkyim8IANvOTBEkkzxvzmP6zHnZCMnzLdnBOHiwgRP9AGF6UGe7Vg6JwIUaIdg14fmQAL9Iond2TGg3aUW5/AaJU1pMvyy733iPnNkz9ps6lxdbO2RVftbJ39na4fSYMES9I1Jgk99Gg/6IgYR8gak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPk6lIPO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ddcb18b13cso52284557b3.1
        for <linux-arch@vger.kernel.org>; Wed, 18 Sep 2024 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726646178; x=1727250978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlQ4Yaq6kY+TAD4XQKPrVKTHn9jUpmIJO7M7toxIG6M=;
        b=gPk6lIPOsqP16q1fdb3o6WNodLbzsTyU1ysSFXMqsaG/P4g2Pf2cvHCo/X2K140idI
         wssA+PpidHLMZTG/qqroSwuJtLeKpLA+gZGSdEa8xkJKpFB0lfaFA3vzYLkmb0SvmhmA
         CRaNDFR8DaNavU+EXZQI0r9gVBKBUdSAC/LNI9yKuAUa/sQ8/ddkfLDLqQ2UCMfGTCnG
         XsuOtTMxW2IG+40XdrGiLCheMBtfp40Y7fVqW4EFJFF5jXdhNGCGawy5tmLTkAS+XnQA
         eRwsLyFeTrG2ThfQwOOGOsICyhCtFoNFPrQj39CMeFqXzo1VJtMZDbZoccNmN8L3Yt3b
         EfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726646178; x=1727250978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlQ4Yaq6kY+TAD4XQKPrVKTHn9jUpmIJO7M7toxIG6M=;
        b=pgnIIlfhSnUUwAuXHteJJRh6s6Y5YnZJr/+Rk4O4WT/n9yold9vYMJY1WFr6ZwkfE2
         8hbvZXBzK7m/MK8JKU5a7sxdKvVlFN0NJD2htiv8QTVuf2K47lnUhF7h+pKI6Sax6+X0
         tPs2dlDIzJxcf33iflvJEzYLHkiCOqLoxIl/oq6uY6vtMb1DPcOKD/bwIysku7ihZnvj
         5FQ2d/l/kN3kKlxsHPcu1ThFbdnta7hBaedr1pkzNvfjyuhYSDZn67QRig1ogr+S2nvo
         5JxTrOAjjN3Sva7S+l7ogwK8HH/b+TDhwq04lVicViCZ2n9VJFt4O5OICWGAJ3RykK2p
         dWlg==
X-Forwarded-Encrypted: i=1; AJvYcCWPiNz0qvSUcdV1bGzi2G0rHNNS/XukFmlUD1YbufqhpDZnarZ3+VxdFLcJ536hEnhSTnm0gXNEIj+S@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8PYCPE4HEY8h05zj8ziKfXHchcM/SFSi1pqPjXuc6Ol373upS
	/x7q313MvuKGp4CUWO8S0YWRPMFNXqJU3Jo4YyLFopvbj2j3+mneVkLxAMArMVonEyAvyGSX3ih
	hBg==
X-Google-Smtp-Source: AGHT+IG5J5++nWPV0aFihORTlQmC2H/Ah9MYQoDGjE3lVKqRoNKbWt/ZoG4m7Y5ovFCNYdEeJv75pFhcNIA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e947:0:b0:6ae:d83e:9172 with SMTP id
 00721157ae682-6dbb6b865b6mr3800587b3.5.1726646178348; Wed, 18 Sep 2024
 00:56:18 -0700 (PDT)
Date: Wed, 18 Sep 2024 00:56:16 -0700
In-Reply-To: <D47TGLMWFTN2.2VCKLFM1K4GM8@amazon.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240609154945.55332-1-nsaenz@amazon.com> <20240609154945.55332-6-nsaenz@amazon.com>
 <ZuSL_FCfvVywCPxm@google.com> <D47TGLMWFTN2.2VCKLFM1K4GM8@amazon.com>
Message-ID: <ZuqHoK1E8gyMC6Ew@google.com>
Subject: Re: [PATCH 05/18] KVM: x86: hyper-v: Introduce MP_STATE_HV_INACTIVE_VTL
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	graf@amazon.de, dwmw2@infradead.org, mlevitsk@redhat.com, jgowans@amazon.com, 
	corbet@lwn.net, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	amoorthy@google.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 16, 2024, Nicolas Saenz Julienne wrote:
> On Fri Sep 13, 2024 at 7:01 PM UTC, Sean Christopherson wrote:
> > On Sun, Jun 09, 2024, Nicolas Saenz Julienne wrote:
> > E.g. extract the guts of vcpu_block() to a separate helper, and then wire that
> > up to an ioctl().
> >
> > As for the RFLAGS.IF quirk, maybe handle that via a kvm_run flag?  That way,
> > userspace doesn't need to do a round-trip just to set a single bit.  E.g. I think
> > we should be able to squeeze it into "struct kvm_hyperv_exit".
> 
> It's things like the RFLAG.IF exemption that deterred me from building a
> generic interface. We might find out that the generic blocking logic
> doesn't match the expected VTL semantics and be stuck with a uAPI that
> isn't enough for VSM, nor useful for any other use-case.

That's only motivation for ensuring that we are as confident as we can reasonably
be that the uAPI we merge will work for VSM, e.g. by building out userspace and
proving that a generic ioctl() provides the necessary functionality.  If there's
no other immediate use case, then there's no reason to merge a generic ioctl()
until VSM support is imminent.  And if there is another use case, then the concern
that a generic ioctl() isn't useful obviously goes away.

> We can always introduce 'flags' I guess.
>
> Note that I'm just being cautious here, AFAICT the generic approach
> works, and I'm fine with going the "wait" ioctl.
> 
> > Actually, speaking of kvm_hyperv_exit, is there a reason we can't simply wire up
> > HVCALL_VTL_CALL and/or HVCALL_VTL_RETURN to a dedicated complete_userspace_io()
> > callback that blocks if some flag is set?  That would make it _much_ cleaner to
> > scope the RFLAGS.IF check to kvm_hyperv_exit, and would require little to no new
> > uAPI.
> 
> So IIUC, the approach is to have complete_userspace_io() block after
> re-entering HVCALL_VTL_RETURN. Then, have it exit back onto user-space
> whenever an event is made available (maybe re-using KVM_SYSTEM_EVENT_WAKEUP?).

Mostly out of curiosity, why does control need to return to userspace?

> That would work, but will need something extra to be compatible with
> migration/live-update.

Gah, right, because KVM's generic ABI is that userspace must complete I/O exits
before saving/restoring state.  Yeah, having KVM automatically enter a blocking
state is probably a bad idea.

