Return-Path: <linux-arch+bounces-7293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D49787CB
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 20:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12F51F228D7
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037E12C474;
	Fri, 13 Sep 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uK0xHbEn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64C8C11;
	Fri, 13 Sep 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252050; cv=none; b=PyAM7ygDyNmH6xBe1Qot3OMIWPllZud37udy0nA+Om1LjMrKAPbQfxFmXRlyBrXbLDEgVC3B/W28ydUJbaWBPkZvdwHIsQDraJD1uKzN9GDiEG2w9VkVWZqORZ/BtzhQrOnqvDRS5rf1FPFPItENf8WPpTBf15U7AQicG2sKQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252050; c=relaxed/simple;
	bh=T/FAGmskof49WPg60zyMYqxdzTPYLl+utpDpDsGWIgI=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:From:To:CC:
	 References:In-Reply-To; b=XnvrYJAMPc/AtQYr4QPSpbH9BRlK3L+r0lz9VebhDqayDF473vMCT23gnwqglARKgIvf9uxeEvhHm1b0kaX1Bfzs/jRG7LKfe7KnHc7IWgcDKWvyySjWpW1DOd/Emu+ZWlR0mbSM4CJ+09xBAqBTAgv45dJ04u/Z9aezkQyXBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uK0xHbEn; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726252049; x=1757788049;
  h=mime-version:content-transfer-encoding:date:message-id:
   from:to:cc:references:in-reply-to:subject;
  bh=wLLXE9tAXmUWkp0mNTmCfQvKPHj+bdubDsMn8oPnwBc=;
  b=uK0xHbEnzY8FgxjONqDUcW47zA2JDsb/aUMi+un9nh5LtYk91J/tVm1W
   RyWuBl/P7WuQOS0lF13r7QK1L8tSMM/SRanwgtbcctoSVH4leW8WOMyD5
   aXYpwY/+ZXiV3fBFuiDrHys3ilhdn/89hxe1CK1TAgDianeSGIjElTjbE
   o=;
X-IronPort-AV: E=Sophos;i="6.10,226,1719878400"; 
   d="scan'208";a="453843029"
Subject: Re: [PATCH 16/18] KVM: x86: Take mem attributes into account when faulting
 memory
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 18:27:18 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:19490]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.21:2525] with esmtp (Farcaster)
 id 4d96842b-9f62-44f5-97a0-d8ad265e11a9; Fri, 13 Sep 2024 18:27:04 +0000 (UTC)
X-Farcaster-Flow-ID: 4d96842b-9f62-44f5-97a0-d8ad265e11a9
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 13 Sep 2024 18:27:04 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Fri, 13 Sep 2024
 18:26:58 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Sep 2024 18:26:54 +0000
Message-ID: <D45D9NN03CSH.3B25KJ1XKV6XE@amazon.com>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<pbonzini@redhat.com>, <vkuznets@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <graf@amazon.de>,
	<dwmw2@infradead.org>, <pdurrant@amazon.com>, <mlevitsk@redhat.com>,
	<jgowans@amazon.com>, <corbet@lwn.net>, <decui@microsoft.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <amoorthy@google.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049-dirty
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <20240609154945.55332-17-nsaenz@amazon.com>
 <D3MJJCTNY7OM.WOB5W8AVBH9G@amazon.com> <ZsduQ7tg0oQFDY8h@google.com>
In-Reply-To: <ZsduQ7tg0oQFDY8h@google.com>
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Thu Aug 22, 2024 at 4:58 PM UTC, Sean Christopherson wrote:
> On Thu, Aug 22, 2024, Nicolas Saenz Julienne wrote:
> > On Sun Jun 9, 2024 at 3:49 PM UTC, Nicolas Saenz Julienne wrote:
> > > Take into account access restrictions memory attributes when faulting
> > > guest memory. Prohibited memory accesses will cause an user-space fau=
lt
> > > exit.
> > >
> > > Additionally, bypass a warning in the !tdp case. Access restrictions =
in
> > > guest page tables might not necessarily match the host pte's when mem=
ory
> > > attributes are in use.
> > >
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> >
> > I now realize that only taking into account memory attributes during
> > faults isn't good enough for VSM. We should check the attributes anytim=
e
> > KVM takes GPAs as input for any action initiated by the guest. If the
> > memory attributes are incompatible with such action, it should be
> > stopped. Failure to do so opens side channels that unprivileged VTLs ca=
n
> > abuse to infer information about privileged VTL. Some examples I came u=
p
> > with:
> > - Guest page walks: VTL0 could install malicious directory entries that
> >   point to GPAs only visible to VTL1. KVM will happily continue the
> >   walk. Among other things, this could be use to infer VTL1's GVA->GPA
> >   mappings.
> > - PV interfaces like the Hyper-V TSC page or VP assist page, could be
> >   used to modify portions of VTL1 memory.
> > - Hyper-V hypercalls that take GPAs as input/output can be abused in a
> >   myriad of ways. Including ones that exit into user-space.
> >
> > We would be protected against all these if we implemented the memory
> > access restrictions through the memory slots API. As is, it has the
> > drawback of having to quiesce the whole VM for any non-trivial slot
> > modification (i.e. VSM's memory protections). But if we found a way to
> > speed up the slot updates we could rely on that, and avoid having to
> > teach kvm_read/write_guest() and friends to deal with memattrs. Note
> > that we would still need to use memory attributes to request for faults
> > to exit onto user-space on those select GPAs. Any opinions or
> > suggestions?
> >
> > Note that, for now, I'll stick with the memory attributes approach to
> > see what the full solution looks like.
>
> FWIW, I suspect we'll be better off honoring memory attributes.  It's not=
 just
> the KVM side that has issues with memslot updates, my understanding is us=
erspace
> has also built up "slow" code with respect to memslot updates, in part be=
cause
> it's such a slow path in KVM.

Sean, since I see you're looking at the series. I don't think it's worth
spending too much time with the memory attributes patches. Since
figuring out the sidechannels mentioned above, I found even more
shortcomings in this implementation. I'm reworking the whole thing in a
separate series [1], taking into account sidechannels, MMIO, non-TDP
MMUs, etc. and introducing selftests and an in-depth design document.

[1] https://github.com/vianpl/linux branch 'vsm/memory-protections' (wip)

Thanks,
Nicolas

