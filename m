Return-Path: <linux-arch+bounces-5734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69912942234
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 23:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263D4285E42
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 21:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147518E056;
	Tue, 30 Jul 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="P9MH1t4B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwCStJUU"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8618E03A;
	Tue, 30 Jul 2024 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374968; cv=none; b=KbliMBhK7k4MKALPA0ZzfwjhPpzJ2aWA7vXNFqiCGgx4f0uMyu4ydkz1xz7wx8ULqPStb17qU/js70FSk3FRCKS3Faud89ASig346j3KMa2fLGsjvvl7fySqm4h8Ru2G5Rs260pLyuKP0fTLBfL4kiyweaJWkj0CQyIQBP+VKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374968; c=relaxed/simple;
	bh=TrKpeWrsxxk4QWXJtnSdjpfuE/x/c2FUFEVUPK84s9s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e8+EtUN0pvTTtwXIt17i33caug6QrNPxO83AGvmzQdvFdmiZrPDJ+Otc4LigiIevu/lUHaVA5z0clxU4AHcw1SA47uDO5RCQcvuSLcPibHaglIaQYAAOny6WGBoqxTtVQR+EG+iU0sAKT457WHfljv4PUWf3avXFtKZob+GF1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=P9MH1t4B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwCStJUU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5CB99114016F;
	Tue, 30 Jul 2024 17:29:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 17:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722374965;
	 x=1722461365; bh=5n9fouO0ra4h/XfpQSfM+wn8VO0HJGyybTEITn+kRl0=; b=
	P9MH1t4Bkyc+6t2ivR+RIkxgqZ9U1g/53F0pvDDeKj4pEJWqog+erBadcXjLGeWc
	v4L15Lf5zFW42nVkKeZUJ5nBjmWPYBgMHWOxTIY7IXToOFfCHT1FU00w8qnPDv5C
	EvTqMuKrqZGjGgbNpBTszlNVW5XN3D4QmD80r41gzAQBaM/Y6f5mPFAGaolFhxMv
	ZuXCUBbQvgROYSz08F329YJUx6dFkMVpbbxiBGMjaeBa9ceKHeFVrIkyuxHpeGwK
	VRlp3NixYJT6ro8t4ml0oB0KNZ+vEvnQEsJVIKgphOywyPEcgyyTfipotuP30uC/
	4QEj34DI33WtIgtmZaJ2jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722374965; x=
	1722461365; bh=5n9fouO0ra4h/XfpQSfM+wn8VO0HJGyybTEITn+kRl0=; b=V
	wCStJUUevQumkP4MsPFWbM/PD7QROMtldhxp8YoJTxh5ReoHcEXOvTxZ7mI8OlB8
	Re7j+CvYWvjd7//TtwJwDk1IMgWJXL8Cu+IbjS+4p0WnfuBMmUWkjGIfT1F3s8FN
	VyNuIkCEGJXl99OuzSQA96EjnqlF8xelWej5wP158W2aDTpVqgSQRMeuRArX+Jeb
	errry7GdGJPAPQd50WBpIXWknTGOlgjReYQGuuhBqA/oP2SWZQm8D/cKWSa0UH5i
	OqHlwHe4z6eM6O7B4Nxj5F4UkZGQ5BqGEPQVDPvhvkqPweBwinsb4dUBaT9FsjEQ
	SymV4luIIuMpgHqUNwFNA==
X-ME-Sender: <xms:NFupZooqQLMXe5aI-jCY4uHqWVztG3X48CEVEF9SaC7ud2TZpDdJiw>
    <xme:NFupZuo0uCOJRy-cwYdaGX5dpk5LzinLDPbRnVG_P2guJvVzXWK5QQ-wZUyKccrmM
    gw5Ffd48fNKg87pink>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:NFupZtMbEWCtnkiVp85m26g4zcmlEzSPvLmGTuNkoqao22wXFpcisw>
    <xmx:NFupZv7WrytzoA9vkk7MQtFvy1ryr8Huybca0l7Ok2rkw_tObr7XQw>
    <xmx:NFupZn6CckdCqAQvf7wVA4V_m5UQ2oaYbf6YKve145H9tgPfrU5m9g>
    <xmx:NFupZvhfDV5qrbzbHOb9uNqrZaGxrcIEUJOEOrSWbp2AvNHpAUV6nw>
    <xmx:NVupZkzfrPRCW7QXTmLiOc839vdRYT1hOS4pUYZsWth6DCZLF-uePaeY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3220AB6008D; Tue, 30 Jul 2024 17:29:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 23:29:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jann Horn" <jannh@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <dba4f23f-385c-4b8c-84ee-cb2a7c791aae@app.fastmail.com>
In-Reply-To: 
 <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
References: 
 <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2024, at 22:15, Jann Horn wrote:
> Refactor the list of constant variables into a macro.
> This should make it easier to add more constants in the future.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I'm not sure whose tree this has to go through - I guess Arnd's?

This is for 6.12, right? I can take it through the asm-generic
tree if that helps, but someone else should review it first.

If you have any other patches that would depend on this patch,
you can also take it through the other tree and add

Acked-by: Arnd Bergmann <arnd@arndb.de>

for cross-architecture bits.

    Arnd

