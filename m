Return-Path: <linux-arch+bounces-14854-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A5DC68682
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 10:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B883B2A51F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83330F522;
	Tue, 18 Nov 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hpPFoEw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqKlhTd+"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A32773EC;
	Tue, 18 Nov 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456461; cv=none; b=UQ7pbYpaIUT9uiNW95j08/DL2WCfgrDTLV/Rf41qSsbCR5ORkBtQG2dNTusJVPdYwY3Gajh4xI3/mISqJeo7P+NByc5R1ILzoiVh3Gl1krHtnj/E0C5tY3qTsF7MfHA0xCSAnzRO7HoYuIILHAK5VbK17XHIxf27tIyw/S4goss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456461; c=relaxed/simple;
	bh=C34AzROnmObItnjwKJW5NjtpZhJk0bE64tPbBO2aWmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GgWULctZyL5CSaOeuvN249m8Cdlx0NLKi39mM7McvA4TOo0faaHpBCjEe1a7OalT2lMsmgjy2Dm6MYgJjugXjova5QjFPdQGVXbsV60UVbzIGzck52PW7XY9EQA+F25IUoz/w5zfXKrhX4wqUZ24rn2nGPz+MNqsI8Rhdy31i0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1hpPFoEw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqKlhTd+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763456458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/J1hq5gEXqPn4gX5YwL+jVfVaVD1PS5DQlXW5HY+NxE=;
	b=1hpPFoEwsA0eGITf7T8A5soAd4j/8ZsXFVZ7nX1JKTpjmfg/hQSlv37vJTjmYkjSsOZ3f5
	KNT8es7qY0+BF47kX8z6POzj3W4HntHgShrOxAC1HFOoXQd+q1der+y+4Tua4xdlTyB3vL
	0a44oZz8e5sXOtkyGZwCaBYzu76+L4LMWcx3eL09SDp+/iMs6CXwKzGv+n0nyjIZucnDpF
	qcuI+Nea7RQYac9sK4JLAxbbwm9f9mxIqVes31GTIisn2j0B5NwrJ6A/jgAEvmMEURNz/T
	RuSFhWzr6XeggT+MF3vzVEVKXCq8ETw9VuR/Pe4Os+QRJd6k16KeNqx2QM0s9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763456458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/J1hq5gEXqPn4gX5YwL+jVfVaVD1PS5DQlXW5HY+NxE=;
	b=aqKlhTd++uRkvWi4igwQSm0wjqjDbM7F00xDeBN75xhNjlCxXx+r5U77uudTRlU/gpnWGl
	HGZKgucAfPQInUAA==
To: Luigi Rizzo <lrizzo@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 4/8] genirq: soft_moderation: implement adaptive
 moderation
In-Reply-To: <CAMOZA0KKJ9S45-LnLtYKn-L8dL71tsfs29c6ZL3bkuTcNXorAw@mail.gmail.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-5-lrizzo@google.com> <87jyzo757y.ffs@tglx>
 <CAMOZA0KKJ9S45-LnLtYKn-L8dL71tsfs29c6ZL3bkuTcNXorAw@mail.gmail.com>
Date: Tue, 18 Nov 2025 10:00:57 +0100
Message-ID: <875xb77m0m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 17 2025 at 22:34, Luigi Rizzo wrote:
> (First world problem, for sure: I have examples for AMD, Intel, Arm,
> all of them with 100+ CPUs per numa node, and 160-480 CPUs total)
> On some of the above platforms, MSIx interrupts cause heavy serialization
> of all other PCIe requests. As a result, when the total interrupt rate exceeds
> 1-2M intrs/s, I/O throughput degrades by up to 4x and more.

Is it actually the sum of all interrupts in the system or is it
segmented per root port?

Thanks,

        tglx

