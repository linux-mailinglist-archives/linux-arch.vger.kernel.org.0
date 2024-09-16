Return-Path: <linux-arch+bounces-7335-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C15497A591
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 17:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68FD1F28D5B
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A546714A4E1;
	Mon, 16 Sep 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sHtQeF5k"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD82B9AA;
	Mon, 16 Sep 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502034; cv=none; b=LTbYDXZwIw19xSh7qqxdYGSiQgsH+EJXP/NaMq+XCUuXmuAESdHXq/Mo5JJOgba/MSX9F78ytuz2zkVRzrnb7wBd7LzaI03KdxJGTz0u6ueFauCq4LTQIGJRVCxWLDnMX2SvkHtVA8IsREG6cR0gqqHvatOkhYlBWr3HuoC4XgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502034; c=relaxed/simple;
	bh=uw0Xybb7UQONV7AUP+zdNBOTaZYJ9vHM92tdymSzwgg=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:To:CC:From:
	 References:In-Reply-To; b=HA7fPKbcg+qZMb+3P0IISagbJf5Oi5IjK0LON8VajcTxgHuS35Z+TC1LDN7dl9dIvq0b5L9+pKQPJ1/bFS+C4/XNS5jXUnz7PgJiWKQOOAdEDfoiI1wutcg5JkwBgt2q4TRlMaMGiVOjGpIm0QuRHlyu4CVshhXYLdHOnqV0g+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sHtQeF5k; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726502033; x=1758038033;
  h=mime-version:content-transfer-encoding:date:message-id:
   to:cc:from:references:in-reply-to:subject;
  bh=uw0Xybb7UQONV7AUP+zdNBOTaZYJ9vHM92tdymSzwgg=;
  b=sHtQeF5kndNn+pIlBdjos1k+Q5FzIBWC/HXSDqk59+xK5xHEk8eA4reJ
   8jXuSq/cmG/KWq4iIO1EBLBlXtvwMDfKu11Jtzs2X8uWSfljTlJ4fAqoE
   Aq6yT+nPeU0b1rMtczJ+2hwScH3qfu3k8p7ZFOxLBfnqGBRrZ0Zg0vu9L
   g=;
X-IronPort-AV: E=Sophos;i="6.10,233,1719878400"; 
   d="scan'208";a="126308750"
Subject: Re: [PATCH 11/18] KVM: x86: Pass the instruction length on memory fault
 user-space exits
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 15:53:49 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:54655]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.43.112:2525] with esmtp (Farcaster)
 id 2d162f68-8f74-48a2-9420-8f12008a1ef2; Mon, 16 Sep 2024 15:53:48 +0000 (UTC)
X-Farcaster-Flow-ID: 2d162f68-8f74-48a2-9420-8f12008a1ef2
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 16 Sep 2024 15:53:48 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 16 Sep 2024
 15:53:42 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Sep 2024 15:53:39 +0000
Message-ID: <D47TVY7H7E3C.3V3RA9GPJGT6E@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<pbonzini@redhat.com>, <vkuznets@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <graf@amazon.de>,
	<dwmw2@infradead.org>, <mlevitsk@redhat.com>, <jgowans@amazon.com>,
	<corbet@lwn.net>, <decui@microsoft.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <amoorthy@google.com>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049-dirty
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <20240609154945.55332-12-nsaenz@amazon.com> <ZuSOaTw1vgwquqTE@google.com>
In-Reply-To: <ZuSOaTw1vgwquqTE@google.com>
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Fri Sep 13, 2024 at 7:11 PM UTC, Sean Christopherson wrote:
> On Sun, Jun 09, 2024, Nicolas Saenz Julienne wrote:
> > In order to simplify Hyper-V VSM secure memory intercept generation in
> > user-space (it avoids the need of implementing an x86 instruction
> > decoder and the actual decoding). Pass the instruction length being run
> > at the time of the guest exit as part of the memory fault exit
> > information.
>
> Why does userspace need the instruction length, but not the associated co=
de stream?

Since the fault already provides the GPA it's trivial to read it from
the VMM. Then again, now that I've dug deeper into the RWX memory
attributes's edge cases, this doesn't always work. For example when
getting a fault during a page walk (the CPU being unable to access the
page that contains the next GPTE due to it being marked non-readable by
a memattr). The fault exit GPA will not point to the code stream.

I will rework/rethink this once I have the complete memattrs story.

Thanks,
Nicolas

