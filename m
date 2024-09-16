Return-Path: <linux-arch+bounces-7336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0B697A615
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 18:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0E21F22E9A
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0E15A86D;
	Mon, 16 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Lt8/AirC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5841C28E;
	Mon, 16 Sep 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504400; cv=none; b=qGDrbB3Cv+9thSdplZrLXtd8DeTNem7fV6zYNDQw7+x7eBrRMH5yRK0ynAfNEu61gQ5RnUzlA+DVrHUYIMIt6Dkdc39JFk2xKbLi73Y4fW8I5WgABm4nEMhP4fBlYH5UNRewp/H+dGj6NPOh4H0mgoRuYKhpY6M+zQovl62AJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504400; c=relaxed/simple;
	bh=2BbvgXonCHBHnrI9Z7+Ify0OIb25BwJ33TpYDlTYK6g=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:To:CC:From:
	 References:In-Reply-To; b=VGwx/dRKcfX045xm+40A5vYWC2d74uwhvqGCI68mXjcheD+rRwv6Sue7L6TKhtZ1bsF4U1Cnm5ZQx8iuFJPoFISXox6I+qQ0N3lzcAlNM2NLJfG7r1oMgOxKiZh6nSZG5bEUAJUGytGlkRH+yTr030B9g2mECcAkqyvSF/e97DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Lt8/AirC; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726504399; x=1758040399;
  h=mime-version:content-transfer-encoding:date:message-id:
   to:cc:from:references:in-reply-to:subject;
  bh=vaEcfC/w1S3Egx7r/IoKG6EaTpC7QKbehfqIGwBFT84=;
  b=Lt8/AirCPdhFrfkziewRPjLqIpjhAqr9qSwFjMcFm6wuiK4DBGi5z+YQ
   4QWqYy5iuQRQZB5DrifKt6CMajY+lqHFouBLEm2YmofPlgzs+4NLoeiQL
   VLQSZcv2HTbSqhvUxAIf3aLb8TOyONJgJMQ2lNziPfzoIDheg/hzaHWV2
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,233,1719878400"; 
   d="scan'208";a="368416637"
Subject: Re: [PATCH 00/18] Introducing Core Building Blocks for Hyper-V VSM Emulation
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 16:32:56 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:23051]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.8:2525] with esmtp (Farcaster)
 id 2fbf8d00-c6e4-4567-9513-91621abe81cc; Mon, 16 Sep 2024 16:32:52 +0000 (UTC)
X-Farcaster-Flow-ID: 2fbf8d00-c6e4-4567-9513-91621abe81cc
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 16 Sep 2024 16:32:52 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 16 Sep 2024
 16:32:46 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Sep 2024 16:32:43 +0000
Message-ID: <D47UPV0JIIMY.35CRZ8ZNZCGA1@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<pbonzini@redhat.com>, <vkuznets@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <graf@amazon.de>,
	<dwmw2@infradead.org>, <paul@amazon.com>, <mlevitsk@redhat.com>,
	<jgowans@amazon.com>, <corbet@lwn.net>, <decui@microsoft.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <amoorthy@google.com>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049-dirty
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <ZuSQNZYWfeHTpAKN@google.com>
In-Reply-To: <ZuSQNZYWfeHTpAKN@google.com>
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Fri Sep 13, 2024 at 7:19 PM UTC, Sean Christopherson wrote:
> On Sun, Jun 09, 2024, Nicolas Saenz Julienne wrote:
> > This series introduces core KVM functionality necessary to emulate Hype=
r-V's
> > Virtual Secure Mode in a Virtual Machine Monitor (VMM).
>
> ...
>
> > As discussed at LPC2023 and in our previous RFC [2], we decided to mode=
l each
> > VTL as a distinct KVM VM. With this approach, and the RWX memory attrib=
utes
> > introduced in this series, we have been able to implement VTL memory
> > protections in a non-intrusive way, using generic KVM APIs. Additionall=
y, each
> > CPU's VTL is modeled as a distinct KVM vCPU, owned by the KVM VM tracki=
ng that
> > VTL's state. VTL awareness is fully removed from KVM, and the responsib=
ility
> > for VTL-aware hypercalls, VTL scheduling, and state transfer is delegat=
ed to
> > userspace.
> >
> > Series overview:
> > - 1-8: Introduce a number of Hyper-V hyper-calls, all of which are VTL-=
aware and
> >        expected to be handled in userspace. Additionally an new VTL-spe=
cifc MP
> >        state is introduced.
> > - 9-10: Pass the instruction length as part of the userspace fault exit=
 data
> >         in order to simplify VSM's secure intercept generation.
> > - 11-17: Introduce RWX memory attributes as well as extend userspace fa=
ults.
> > - 18: Introduces the main VSM CPUID bit which gates all VTL configurati=
on and
> >       runtime hypercalls.
>
> Aside from the RWX attributes, which to no one's surprise will need a lot=
 of work
> to get them performant and functional, are there any "big" TODO items tha=
t you see
> in KVM?

Aside from VTLs and VTL switching, there is bunch of KVM features we
still need to be fully compliant with the VSM spec:
- KVM_TRANSLATE2, which Nikolas Wipper posted a week ago [1].
  Technically we can do this in user-space, but it's way simpler to
  re-use KVM's page-walker.

- Hv's TlbFlushInhibit, it allows VTL1 to block VTL0 vCPUs from issuing
  TLB Flushes, and blocks them until uninhibited. Note this only applies
  to para-virtualized TLB flushes:
  HvFlushVirtualAddress{Space,SpaceEx,List,ListEx}, so it's 100% Hyper-V
  specific.

- CPU register pinning/intecepting, we plan on reusing what HEKI
  proposed some time ago, and expose it through an IOCTL using ONE_REG
  to represent registers.

- MBEC aware memory attributes, we don't plan on enabling support for
  these with the first RWX memattrs submission. We'll do it as a follow
  up, especially as not every Windows VBS feature requires it
  (Credential Guard doesn't need it, HVCI does).

> If this series is more or less code complete, IMO modeling VTLs as distin=
ct VM
> structures is a clear win.

I agree.

> Except for the "idle VTL" stuff, which I think we can simplify, this
> series is quite boring, and I mean that in the best possible way :-)

:)

Thanks,
Nicolas

[1] https://lore.kernel.org/kvm/20240910152207.38974-1-nikwip@amazon.de

