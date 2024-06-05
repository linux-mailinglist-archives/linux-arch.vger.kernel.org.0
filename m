Return-Path: <linux-arch+bounces-4708-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BE38FCFAC
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 15:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BF11C241D9
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167C14D2AE;
	Wed,  5 Jun 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ddp9v8gK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cH5GaQgQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894A81F;
	Wed,  5 Jun 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593623; cv=none; b=BK+EONIBME7vLuDzlG+1OHMTr4iYgw2S/ueMjeKw5hhQn/FkMNZ3EKwdFK5gwgGnIxXimh3r6+o5Coq32mY8UQg4KZ3q6/yg20t4IGfC/VBSFQQm6hCYuK2Y+tRSW+93PmfVCgnCU32hrS5cWLoXIVPBLgOtG19yBbwneEhGAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593623; c=relaxed/simple;
	bh=PvIoMHkKO8iSZkAT3rpcBtApwteKDRqqo/Ed2wXqyzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RnbQerHwWy+nS11w+C0mORIVLzistJTBsKub+LO47YuV2dzi6NFMVoiq8I65Iri3OVeCUHhEZjr1k3Q+281ysLRcJOwYEJ+DA+9Ou/JwAsJw5aHD1jTZhFKKDv6m2sZh394HSLo+t0M8jqUmayYNKegsRSyuU1+Zhkua5MUIZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ddp9v8gK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cH5GaQgQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717593617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYWn3g2LyW/uf5CwlkYzfpP0ISOJjU2c39/1Gv+YQ1g=;
	b=Ddp9v8gKf7TG/yoHMTlRJdCgCbMuZDAoJdr03reGWGhqRvm2ms9ZIbXOhIRetGdvQAuHit
	Rpu6WBl6bp7ywb+O9BHzEMOiD1prm3K3VJo4a33qcoseK3C/2wG1yBXXwrYQa0qr9RmCF/
	edsncOPwwbAvi7DDICztg74fpmYSx2TRKcf5LN/yHxomd6vfiSbDhTqQ/naDcZaEL/isml
	6+MAKpoATb3XOv9hXqflWq2CkCB4pzHHBZTMP1VQm6qEK2gsIDRYQStZnP6ob8V3m7hwhm
	q8RXsbyzTLdssZw867eNDgVRsrI25lDKXCQ3SFwkI/JkuycQLAMJ8gzBsNhkdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717593617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYWn3g2LyW/uf5CwlkYzfpP0ISOJjU2c39/1Gv+YQ1g=;
	b=cH5GaQgQzNNMR/vz7Wvmo5cCMV1KcMVlvq8kiT1Lz51056P7AQt8WbRpgSxzTLxowrAd20
	voHgBneHNJZdgKCA==
To: Michael Kelley <mhklinux@outlook.com>, "kys@microsoft.com"
 <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
 <decui@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
 <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "maz@kernel.org" <maz@kernel.org>, "den@valinux.co.jp"
 <den@valinux.co.jp>, "jgowans@amazon.com" <jgowans@amazon.com>,
 "dawei.li@shingroup.cn" <dawei.li@shingroup.cn>
Subject: RE: [RFC 06/12] genirq: Add per-cpu flow handler with conditional
 IRQ stats
In-Reply-To: <SN6PR02MB415737FF6F7B40A1CD20C4A9D4F82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-7-mhklinux@outlook.com> <87h6e860f8.ffs@tglx>
 <SN6PR02MB415737FF6F7B40A1CD20C4A9D4F82@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Wed, 05 Jun 2024 15:20:17 +0200
Message-ID: <87zfrz4jce.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 04 2024 at 23:03, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Tuesday, June 4, 2024 11:14 AM
>>    1) Move the inner workings of handle_percpu_irq() out into
>>       a static function which returns the 'handled' value and
>>       share it between the two handler functions.
>
> The "inner workings" aren't quite the same in the two cases.
> handle_percpu_irq() uses handle_irq_event_percpu() while
> handle_percpu_demux_irq() uses __handle_irq_event_percpu().
> The latter doesn't do add_interrupt_randomness() because the
> demultiplexed IRQ handler will do it.  Doing add_interrupt_randomness()
> twice doesn't break anything, but it's more overhead in the hard irq
> path, which I'm trying to avoid.  The extra functionality in the
> non-double-underscore version could be hoisted up to
> handle_percpu_irq(), but that offsets gains from sharing the
> inner workings.

That's not rocket science to solve:

static irqreturn_t helper(desc, func)
{
	boiler_plate..
        ret = func(desc)
	boiler_plate..
        return ret;
}

No?

TBH, I still hate that conditional accounting :)

>>    2) Allocate a proper interrupt for the management mode and invoke it
>>       via generic_handle_irq() just as any other demultiplex interrupt.
>>       That spares all the special casing in the core code and just
>>       works.
>
> Yes, this would work on x86, as the top-level interrupt isn't a Linux IRQ,
> and the interrupt counting is done in Hyper-V specific code that could be
> removed.  The demux'ed interrupt does the counting.
>
> But on arm64 the top-level interrupt *is* a Linux IRQ, so each
> interrupt will get double-counted, which is a problem.

What is the problem?

You have: toplevel, mgmt, device[], right?

They are all accounted for seperately and each toplevel interrupt might
result in demultiplexing one or more interrupts (mgmt, device[]), no?

IMO accounting the toplevel interrupt seperately is informative because
it allows you to figure out whether demultiplexing is clustered or not,
but I lost that argument long ago. That's why most demultiplex muck
installs a chained handler, which is a design fail on it's own.

Thanks,

        tglx


