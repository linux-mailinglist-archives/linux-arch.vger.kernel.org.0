Return-Path: <linux-arch+bounces-5969-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B216947C91
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7BD1C21BA5
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6E012EBCA;
	Mon,  5 Aug 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Lo2Ip46l"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727517C64;
	Mon,  5 Aug 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867137; cv=none; b=oTh0NtzpuDRx0iuYyGfJCMFOTLxbjnfDWQxb4reuQcYmDcu1gKKUp31oYSWlYnaquGGeyFxszI3o1OFvIQAIxTR50UPsD8wp7brb+I8GIIeP4D+Oe9vWfBtfVcZj5Das1QmqE5TYZ0YYQv98YIpQU7lnIK8XGSwxN3aJ7Bv1pmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867137; c=relaxed/simple;
	bh=9M4xpkoH3LimV0O0XQcpYnwFUNXxsSPpdOBU2ZuvMyY=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:CC:From:To:
	 References:In-Reply-To; b=MfR2Uo70qspShBNPq0l2OxJaCH9rvj5Nl6YeiOv/wOWcoA5fi5qlUhEcFRoGH3zAaLS6Rb3MQnkN2XiS8jRjpNUihHrFOfcsum1VIpnCNddadXd+MY1cXbHkYH6FG1qVcmi35OOtSzFLrIDQ7+gP1I3RxKOid60PeSfAHak/yDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Lo2Ip46l; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722867135; x=1754403135;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:references:in-reply-to:subject;
  bh=MK25yrGsMeryEu/GddZa4lO4IjN5z+54ON7xDCNErE8=;
  b=Lo2Ip46lrst1H5aB7j2LI1HD6MWx6P2XQcFLmajRQ4QXSczhFQRQEcKJ
   9YjGWrwxdBeaWGWBYJgEI9sT2HCT+BH5PUousdxcNxhSDX6FLlkFc72KK
   JvHMkPIJPYl1jMOrRB/60O2TJpkhsnmwS2Nn8iADSrfV+bBOnMczxgagP
   s=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="112496171"
Subject: Re: [PATCH 01/18] KVM: x86: hyper-v: Introduce XMM output support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 14:08:58 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:29010]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.23:2525] with esmtp (Farcaster)
 id e194f651-d149-4251-920f-bb202d846005; Mon, 5 Aug 2024 14:08:57 +0000 (UTC)
X-Farcaster-Flow-ID: e194f651-d149-4251-920f-bb202d846005
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 14:08:56 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 5 Aug 2024
 14:08:50 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 5 Aug 2024 14:08:46 +0000
Message-ID: <D381CRQ2XJL9.1NBVMKT4SR51P@amazon.com>
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
 <D2RVJ6QCVNOU.XC0OC54QHI51@amazon.com> <878qxk5mox.fsf@redhat.com>
In-Reply-To: <878qxk5mox.fsf@redhat.com>
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Mon Jul 29, 2024 at 1:53 PM UTC, Vitaly Kuznetsov wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
> Nicolas Saenz Julienne <nsaenz@amazon.com> writes:
>
> > Hi Vitaly,
> > Thanks for having a look at this.
> >
> > On Mon Jul 8, 2024 at 2:59 PM UTC, Vitaly Kuznetsov wrote:
> >> Nicolas Saenz Julienne <nsaenz@amazon.com> writes:
> >>
> >> > Prepare infrastructure to be able to return data through the XMM
> >> > registers when Hyper-V hypercalls are issues in fast mode. The XMM
> >> > registers are exposed to user-space through KVM_EXIT_HYPERV_HCALL an=
d
> >> > restored on successful hypercall completion.
> >> >
> >> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> >> >
> >> > ---
> >> >
> >> > There was some discussion in the RFC about whether growing 'struct
> >> > kvm_hyperv_exit' is ABI breakage. IMO it isn't:
> >> > - There is padding in 'struct kvm_run' that ensures that a bigger
> >> >   'struct kvm_hyperv_exit' doesn't alter the offsets within that str=
uct.
> >> > - Adding a new field at the bottom of the 'hcall' field within the
> >> >   'struct kvm_hyperv_exit' should be fine as well, as it doesn't alt=
er
> >> >   the offsets within that struct either.
> >> > - Ultimately, previous updates to 'struct kvm_hyperv_exit's hint tha=
t
> >> >   its size isn't part of the uABI. It already grew when syndbg was
> >> >   introduced.
> >>
> >> Yes but SYNDBG exit comes with KVM_EXIT_HYPERV_SYNDBG. While I don't s=
ee
> >> any immediate issues with the current approach, we may want to introdu=
ce
> >> something like KVM_EXIT_HYPERV_HCALL_XMM: the userspace must be prepar=
ed
> >> to handle this new information anyway and it is better to make
> >> unprepared userspace fail with 'unknown exit' then to mishandle a
> >> hypercall by ignoring XMM portion of the data.
> >
> > OK, I'll go that way. Just wanted to get a better understanding of why
> > you felt it was necessary.
> >
>
> (sorry for delayed reply, I was on vacation)
>
> I don't think it's an absolute must but it appears as a cleaner approach
> to me.
>
> Imagine there's some userspace which handles KVM_EXIT_HYPERV_HCALL today
> and we want to add XMM handling there. How would we know if xmm portion
> of the data is actually filled by KVM or not? With your patch, we can of
> course check for HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE in
> KVM_GET_SUPPORTED_HV_CPUID but this is not really straightforward, is
> it? Checking the size is not good either. E.g. think about downstream
> versions of KVM which may or may not have certain backports. In case we
> (theoretically) do several additions to 'struct kvm_hyperv_exit', it
> will quickly become a nightmare.
>
> On the contrary, KVM_EXIT_HYPERV_HCALL_XMM (or just
> KVM_EXIT_HYPERV_HCALL2) approach looks cleaner: once userspace sees it,
> it knows that 'xmm' portion of the data can be relied upon.

Makes sense, thanks for the explanation.

Nicolas

