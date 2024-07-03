Return-Path: <linux-arch+bounces-5237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056A9261A5
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 15:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF57283DCD
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 13:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8417838B;
	Wed,  3 Jul 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h10xqMoj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64007175555;
	Wed,  3 Jul 2024 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012743; cv=none; b=uPE/ZdaI9lBRQRRa1KxKjVqF8n03p5a+DlplQ9P8q/c7TmJCafs+5hZK6CdXCrGG+h91Jli+rI9mqBnAZwOk7A1XppRB3+aXj2BfuT1AaPHokX56ZNgDSYpKBwSH4vLrcZ4TER2BPvhXQvsbA1UNpcJJ9HGwmEuYcoTnW5d46Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012743; c=relaxed/simple;
	bh=zUu2F1hV+miT5I8Gkjrxe7EVSNhBDwp44fj2E7hlYsg=;
	h=Subject:MIME-Version:Content-Type:Date:Message-ID:From:To:CC:
	 References:In-Reply-To; b=KTj/oKm/gJBi3UXE1D37oPapzdIYILnXosbFLyGgUnhx2a26JSYWFABRvOVQm3N9svGU3WQeve3NWz6+guGbTpcyCOVZs0KaRkmaXMJhikCaDyybylUapou2QN8NBlmvjoeUlGW1CuBZiFxzSsvnucAWxfQbfPp3SbAiDHtBs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=h10xqMoj; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720012742; x=1751548742;
  h=mime-version:content-transfer-encoding:date:message-id:
   from:to:cc:references:in-reply-to:subject;
  bh=zUu2F1hV+miT5I8Gkjrxe7EVSNhBDwp44fj2E7hlYsg=;
  b=h10xqMojGvcnQ9vfl7ywtrgPImF73FdjFAK9o4Xgkl5eMqIDKEeupLrt
   9dGOok6wCF8fVcjiL7Ep6bQ0hEN9RijbSI8V4z7CQJ5DQjOClb3gVxXj6
   fO32zvVMbsehWh4krmsxZ/9qIPOvqdrpz7qx3R7zmJARcShegY9NAdpUU
   w=;
X-IronPort-AV: E=Sophos;i="6.09,182,1716249600"; 
   d="scan'208";a="417489642"
Subject: Re: [PATCH 00/18] Introducing Core Building Blocks for Hyper-V VSM Emulation
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 13:18:59 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:59500]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.20.30:2525] with esmtp (Farcaster)
 id 4b69d89c-843b-442a-9219-fefd3322b1f3; Wed, 3 Jul 2024 13:18:58 +0000 (UTC)
X-Farcaster-Flow-ID: 4b69d89c-843b-442a-9219-fefd3322b1f3
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 3 Jul 2024 13:18:57 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Wed, 3 Jul 2024
 13:18:51 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 3 Jul 2024 13:18:48 +0000
Message-ID: <D2FXMJ39HOWV.MEBKDIO1F1TM@amazon.com>
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, <seanjc@google.com>
CC: <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <graf@amazon.de>,
	<dwmw2@infradead.org>, <pdurrant@amazon.co.uk>, <mlevitsk@redhat.com>,
	<jgowans@amazon.com>, <corbet@lwn.net>, <decui@microsoft.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <amoorthy@google.com>
X-Mailer: aerc 0.17.0-152-g73bcb4661460-dirty
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <D2FTASL4CXLN.32GYJ8QZH4OCR@amazon.com> <87ikxm63px.fsf@redhat.com>
In-Reply-To: <87ikxm63px.fsf@redhat.com>
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Hi Vitaly,

On Wed Jul 3, 2024 at 12:48 PM UTC, Vitaly Kuznetsov wrote:
> Nicolas Saenz Julienne <nsaenz@amazon.com> writes:
>
> > Hi Sean,
> >
> > On Sun Jun 9, 2024 at 3:49 PM UTC, Nicolas Saenz Julienne wrote:
> >> This series introduces core KVM functionality necessary to emulate Hyp=
er-V's
> >> Virtual Secure Mode in a Virtual Machine Monitor (VMM).
> >
> > Just wanted to make sure the series is in your radar.
> >
>
> Not Sean here but I was planning to take a look at least at Hyper-V
> parts of it next week.

Thanks for the update.

Nicolas

