Return-Path: <linux-arch+bounces-6533-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886495B9FB
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 17:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC77CB227C6
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 15:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88DF181B86;
	Thu, 22 Aug 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nb3175Ni"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570D2C87A;
	Thu, 22 Aug 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340077; cv=none; b=OKS6VDokbvBVkGPHL0j3/qg1VSJPhxwyPXXdoN5qUSeXdp4mNamARu2YhgqxTXQUmpwcUO2STYNTjeM86Bp8ugpiBxc+llos8LKsccW/BagKdAL8OVeWa0kduZalqlCE93yW9PDyeb3wJkEps/gu3RJuHg4mrWG8xX7iKCS1SK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340077; c=relaxed/simple;
	bh=0ebK4nIoa5BOEpjmy0XRvJ7VKPjWzhDV62tWEIf3CvI=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:From:To:CC:
	 References:In-Reply-To; b=f3cMRQPypWpP9xBgt2Yu3WsqFxPxlPIVUBlPzi4r5chT5co6HVQFM+lhN+IPx9Ez+ChreuQ7S6v1K/L3Pu2qKWi+WFkOQSz4DDjp4IPULbxANbZ5qD746M/RFiqvLD4ttxvY45XQ859TGj7h1KUI+TiXDKztwg96w3KGefUqf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Nb3175Ni; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724340076; x=1755876076;
  h=mime-version:content-transfer-encoding:date:message-id:
   subject:from:to:cc:references:in-reply-to;
  bh=f2eZRkmfeS+Cis+NAGo9bRj42tCz3s9a2o3q7s6DBDI=;
  b=Nb3175NisnR/bLRTZF5JH6RsxlhnLRl4jkdVvDYmOEDpb1BAzPLVGMhd
   riJlEe8TVeazzg14jUnoxOq6nFTd/eNN7MtsOZr1T0Iw32dIZBRS+bclh
   NcMXkPQJLulj8VcPAjbLFUiAokMerKtGAtuY912QW53BvmS0BQ+GL9U/5
   A=;
X-IronPort-AV: E=Sophos;i="6.10,167,1719878400"; 
   d="scan'208";a="20619224"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 15:21:13 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:7014]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.212:2525] with esmtp (Farcaster)
 id a3167566-1ec3-4ce8-b883-c56528e2878a; Thu, 22 Aug 2024 15:21:12 +0000 (UTC)
X-Farcaster-Flow-ID: a3167566-1ec3-4ce8-b883-c56528e2878a
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 22 Aug 2024 15:21:11 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Thu, 22 Aug 2024
 15:21:05 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Aug 2024 15:21:02 +0000
Message-ID: <D3MJJCTNY7OM.WOB5W8AVBH9G@amazon.com>
Subject: Re: [PATCH 16/18] KVM: x86: Take mem attributes into account when
 faulting memory
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<graf@amazon.de>, <dwmw2@infradead.org>, <pdurrant@amazon.com>,
	<mlevitsk@redhat.com>, <jgowans@amazon.com>, <corbet@lwn.net>,
	<decui@microsoft.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<amoorthy@google.com>
X-Mailer: aerc 0.18.2-22-gfff69046b02f-dirty
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <20240609154945.55332-17-nsaenz@amazon.com>
In-Reply-To: <20240609154945.55332-17-nsaenz@amazon.com>
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Sun Jun 9, 2024 at 3:49 PM UTC, Nicolas Saenz Julienne wrote:
> Take into account access restrictions memory attributes when faulting
> guest memory. Prohibited memory accesses will cause an user-space fault
> exit.
>
> Additionally, bypass a warning in the !tdp case. Access restrictions in
> guest page tables might not necessarily match the host pte's when memory
> attributes are in use.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

I now realize that only taking into account memory attributes during
faults isn't good enough for VSM. We should check the attributes anytime
KVM takes GPAs as input for any action initiated by the guest. If the
memory attributes are incompatible with such action, it should be
stopped. Failure to do so opens side channels that unprivileged VTLs can
abuse to infer information about privileged VTL. Some examples I came up
with:
- Guest page walks: VTL0 could install malicious directory entries that
  point to GPAs only visible to VTL1. KVM will happily continue the
  walk. Among other things, this could be use to infer VTL1's GVA->GPA
  mappings.
- PV interfaces like the Hyper-V TSC page or VP assist page, could be
  used to modify portions of VTL1 memory.
- Hyper-V hypercalls that take GPAs as input/output can be abused in a
  myriad of ways. Including ones that exit into user-space.

We would be protected against all these if we implemented the memory
access restrictions through the memory slots API. As is, it has the
drawback of having to quiesce the whole VM for any non-trivial slot
modification (i.e. VSM's memory protections). But if we found a way to
speed up the slot updates we could rely on that, and avoid having to
teach kvm_read/write_guest() and friends to deal with memattrs. Note
that we would still need to use memory attributes to request for faults
to exit onto user-space on those select GPAs. Any opinions or
suggestions?

Note that, for now, I'll stick with the memory attributes approach to
see what the full solution looks like.

Nicolas

