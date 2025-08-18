Return-Path: <linux-arch+bounces-13189-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2E2B2A0DA
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 13:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5AF1967F9A
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1131B121;
	Mon, 18 Aug 2025 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="h2oUcSs1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xn1NVHAl"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68331B11E;
	Mon, 18 Aug 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517934; cv=none; b=mN29VIVPVGTtrempVa+pFk4LnuZdoVnj8r9nTogDlhYRYUdkJ4buBaR0kHPT/bkcMVRJ0TTOPXhdmqJzOlAxTFLYKMnGqGSW9j7E73FxSUKnUYeQGYs9UJQr8NvagaMiguFlvP8V1QZuJj+kLJCcAGOBXI3jZDaX1GHJQbFnBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517934; c=relaxed/simple;
	bh=BgEMoriLmYxwTAa7R5ERI/+xqJkVQhPiYVNAlgRqxAo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HVLrz/qCmxAvN5Pi5oOm7lXyNHswCCGY7fvwZYOuzCI39kVyokQz8+VuK5UgR00wCYASiavXNkyYXNcpj9xnpCRPFXM9KNwwZO+rf0ugKSWrN/nVCOuFvqFC8dJb133ZEOSVnH7f2JpXEobLfzYI/f6YX5qjOwOeT+Ip8OoNT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=h2oUcSs1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xn1NVHAl; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1493140019F;
	Mon, 18 Aug 2025 07:52:10 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 18 Aug 2025 07:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755517930;
	 x=1755604330; bh=xdAWM4VoEFpKIci+YeNFUKl++/E12AuQc7lCaC4JGcM=; b=
	h2oUcSs131J819wJvJTUef53dLSfrK3pHFPlRRldLsqNj9I/hXPeoGtIHI0iT3/y
	cDYnQVVpuW99OmB7K+lPEFvYdVlGGBNmmq5brTZ1CAlRoGmeryryE1GgmNfXg9uh
	TgBMuyniCnAQzZ49puTDzar5NmC2cyIQM67Krx8syaWCMDckSSPKeP8gtu49mR+G
	CScPZBKcukCsHxfgw5eePK/lgh0k5Afs7gCHTtSlDE6Igs8y0RlJdZCC0DWaBMRg
	3jpdEJ3JKLLqkOvj0mbZeYhRRnHHa/10vtfCvAe6EL/zUe+Hg6IYuunKbU10dpID
	qk1wvIO+zggkXBgzJra/9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755517930; x=
	1755604330; bh=xdAWM4VoEFpKIci+YeNFUKl++/E12AuQc7lCaC4JGcM=; b=X
	n1NVHAlgbfDXUlT2I+6XovZZtytwOYYHPOHqmZcI+YdW7j58ItLIEfUJAZ3lVOV6
	BwkxX93JgbcU+Z1tJZjR7UFzFxrmFtg+ZzAc6fYXpjM3ZltckyQADhlFNe2qJG2J
	kX+4e0UCLeJGHkp5gxeCB0L+CmHqcEeSK0mK5gspf3CL3JOjNvb3TWJI6GyHs22l
	s9ycEf9qKB17CHI5RpN3wR1Q4JrHBLbL3zWKAhYwwj+h2Igl2dMGUvwkzO3Nrtiv
	7V2g2jQ2PzcYqqKPaFq0h+ePlEDqvP1G3YJwsXG2AvIs0h47UXsRBrjfjM14Pef5
	w0oj60Po2VNhCShuZi7dA==
X-ME-Sender: <xms:6ROjaOuitNLKajWCXYgTbY8qebcCFPEWU-gG3euwtsq2g5EHyoqrFw>
    <xme:6ROjaDec4kPycLiFwmKAMf_8STikAe2q1_5SGAwDjQYAQ32OeQyoIArLarw0HxrwE
    PczG7UIPN7LJrDzVBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehhrghrihhsohhknhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghr
    khdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegtlhesghgvnhhtfihord
    horhhgpdhrtghpthhtohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    iihhvghnghhlihhfvghnghdusehhuhgrfigvihdrtghomhdprhgtphhtthhopehpvghtvg
    hriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6ROjaFqAG9vVd4hWbW6eNyE7SESzQeaM9w92hMsr4lLEwp7yjsDzFg>
    <xmx:6ROjaMofJKUARlp42HjoQme1HABCrz4GM1iJYrMnUidh95kfG7D9xA>
    <xmx:6ROjaDHMlVoyoJbcVzEHbynZIsAzzrbI8zRo0UwXjZ1TdWUZpXVJqQ>
    <xmx:6ROjaGo6Jrd7CjQbAz9kCTkTcJLtjqJ2mGKByJ8Caslhk4ctJ8mcmA>
    <xmx:6hOjaDx8XTH3TIRclWvE8wp-hX4Cj7u2C4YXrjNi-XuGmN1mVBnwmWxF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EF07E700065; Mon, 18 Aug 2025 07:52:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Awa8eXB9XRs-
Date: Mon, 18 Aug 2025 13:51:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Catalin Marinas" <catalin.marinas@arm.com>
Cc: "Ankur Arora" <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Mark Rutland" <mark.rutland@arm.com>, harisokn@amazon.com,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, "Joao Martins" <joao.m.martins@oracle.com>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>
Message-Id: <1ccb0011-d2d2-453f-afcd-dd2967bf572a@app.fastmail.com>
In-Reply-To: <aJ3d2uoKtDop_gQO@arm.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com> <aJXWyxzkA3x61fKA@arm.com>
 <877bz98sqb.fsf@oracle.com> <aJy414YufthzC1nv@arm.com>
 <67b6b738-0f1c-4dd4-817d-95f55ec9272b@app.fastmail.com>
 <aJ3d2uoKtDop_gQO@arm.com>
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 14, 2025, at 15:00, Catalin Marinas wrote:
> On Wed, Aug 13, 2025 at 06:29:37PM +0200, Arnd Bergmann wrote:
>> On Wed, Aug 13, 2025, at 18:09, Catalin Marinas wrote:
>> and virtual machines with CPU overcommit.
>
> Not sure it helps here. With vCPU overcommit, KVM enables WFE trapping
> and the event stream no longer has any effect (it's not like it
> interrupts the host).

I would expect a similar overhead for the WFE trapping as for the
bare-metal hardware case: When the WFE traps, the host has to
reschedule all guests that are in WFE periodically, while WFET
with event stream disabled means this can be driven by an accurate
host timer.

> That said, my worry is that either broken hardware or software rely on
> the event stream unknowingly, e.g. someone using WFE in a busy loop. And
> for hardware errata, we've had a few where the wakeup events don't
> propagate between clusters, though these we can toggle on a case by case
> basis.

Don't we already support hardware without a functional architected
timer even with? Those don't use the event stream today even when
CONFIG_ARM_ARCH_TIMER_EVTSTREAM is enabled.

     Arnd

