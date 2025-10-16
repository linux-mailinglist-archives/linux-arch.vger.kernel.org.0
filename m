Return-Path: <linux-arch+bounces-14162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EA9BE3B6E
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 15:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286053A28FB
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03450303CBB;
	Thu, 16 Oct 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SECTnbK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WztbAwXu"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063417A2E8;
	Thu, 16 Oct 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621460; cv=none; b=QE6HVW1Guq9X+KzRApuQAfhIeYkN/dYXLyBjL+8QNvUdrcIzvHjI6YALmcwfHZNJHk5pDrdYJ8aEYwFcccvKNew1kYs9oJrBB/6RVZ/xgNmDreRZaesI/UDuebeE9kEtLcDghOv4lG0BRrHVMCU6LkMKDQ5LxEkvv2JlHpYeIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621460; c=relaxed/simple;
	bh=cTsjsQ0FpIOTJ+hSMo8uPh6Cg/szULls3Pr0P8t6aWg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BpzKqMZI4uOMaSfBVoxWQYeaxXKg6ZVA9KrLomBhxGyJqK5Om5JFRmdzadQwmnHCIOm2Q1szcxz7lbTj7t+odZ+jLyW2SzZuWT9WPKSj25MnLjj/k4kuMs9tv1Xgt/aPg4J2fxncGWARA7Izq+zkMDf+Y+JlJIMvlwOSuZZYFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SECTnbK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WztbAwXu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AC23C1D00245;
	Thu, 16 Oct 2025 09:30:56 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 16 Oct 2025 09:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760621456;
	 x=1760707856; bh=s/MRbpBqt2yqYNof35eOW46gF9jvP1qa9ngAy/6u1w0=; b=
	SECTnbK1aU8FmEyd68ZOtLDgNHywGuo8alcv5/f8WGv76UCcUadVPBd1L3dxwuZY
	VtKeQdsnwgk4/GOWSC2ffXiT2rzt83NqRRJDMgqIyctbYzqZ0iXuwaUOyE6VzOcG
	ObootchY8VxoXAp+qsiiKI62+9qMxCktNsp6wHVWlEFRfZ5mJXG+G/fXvYsmzDqn
	7xgWUAk9ztjtHRRBbWwYUmY1rZPK4vZpAcZ0b7FYHvBxcF1z1Z041FPV94l+xd+u
	byBMGM4KkLfwzcbLErWTsPRPF0okQDPTmYzRsm/134o8sCiU75hICrZteLMN1cPL
	OtpXHL1sip856OFHjwg9kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760621456; x=
	1760707856; bh=s/MRbpBqt2yqYNof35eOW46gF9jvP1qa9ngAy/6u1w0=; b=W
	ztbAwXuQfn3MP2FFuXP8oUUmEUdn38vVOJEiPwd49E1kT3CAAsW7BmaN+scFIL/0
	hulMtq9M8OY8nKz6HECvhY5lI1NqPaCJ2TBnAE2XzPvIFnj8okHBazvY9Iog5Wxn
	ScVbMZcQ2GDCuC4wlL2hmuF7XYBFA0xW1OfhQCeOkraa7QqiNMIi9scOjn/fOjkA
	bedEn9cwi55h+hRYDxLFSwgd2/PaQyg6Fm7ijqd0Aijw0/bG0TEsO2YBHrVm5b45
	IbuXRy6bgq84jxcF0vweGsf2yYso28NkFTL6pRNBYbGSs8RCp4prqv5+GA30d5aZ
	J/WmzZv8S2INA38P3p1+Q==
X-ME-Sender: <xms:j_PwaBk_hmJyYpdili7YT9OheBE3ISiao6pmR3OnZt8SMvSZxjLosw>
    <xme:j_PwaHondES3j4cuJ4j-MdpQAY1YrNhRErT-22Ezj82CraIAPrLy8jHCCaOsbnIKc
    2e70Gfhz-mF6Zci3fDUczz2z4bFX4Wqo9uA2fc5m8Vr2gby7_ogojQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeigedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtth
    hopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehpvghtvghr
    iiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhrtghpth
    htohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheptghorhgs
    vghtsehlfihnrdhnvghtpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kPPwaFUXktOb5IiCYIW3tun37OpNXVlbO22McvRiUi7HNyUaj4kvVQ>
    <xmx:kPPwaMHs8_M6niyvc4-td5bvUJHucdzX3VEMFOYL_2_Dp1R9TZxgxQ>
    <xmx:kPPwaPY-Zz76iKBLCH9ztEvorjTMGEsQn33_ZzURQ5SreS-O4YPaPw>
    <xmx:kPPwaLEe-cCYI2fBE3k6in6e1y41qBaljbrSY8BZs0EnQXO385q4wA>
    <xmx:kPPwaDd0eolJQdUk_daHOCIeYqnbxMcj0WnsjWo1TNdLh3CBCjHVwavc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DFDC870006D; Thu, 16 Oct 2025 09:30:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AH4YsbVvINyJ
Date: Thu, 16 Oct 2025 15:30:19 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-Id: <b80e06b8-e568-408b-8132-99565c50a0ff@app.fastmail.com>
In-Reply-To: 
 <76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org>
 <76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org>
Subject: Re: [RFC v3 1/5] documentation: Discourage alignment assumptions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

 On Wed, Oct 8, 2025, at 00:19, Finn Thain wrote:
> Discourage assumptions that simply don't hold for all Linux ABIs.
> Exceptions to the natural alignment rule for scalar types include
> long long on i386 and sh.
> ---

I think both of the paragraphs you remove are still correct and I
would not remove them:

>  Documentation/core-api/unaligned-memory-access.rst | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/Documentation/core-api/unaligned-memory-access.rst 
> b/Documentation/core-api/unaligned-memory-access.rst
> index 5ceeb80eb539..1390ce2b7291 100644
> --- a/Documentation/core-api/unaligned-memory-access.rst
> +++ b/Documentation/core-api/unaligned-memory-access.rst
> 
> -When writing code, assume the target architecture has natural alignment
> -requirements.
> -

It is clearly important to not intentionally misalign variables
because that breaks on hardware that requires aligned data.

Assuming natural alignment is the safe choice here, but you
could change 'architecture' to 'hardware' here if you
think that is otherwise ambiguous.

> -Similarly, you can also rely on the compiler to align variables and function
> -parameters to a naturally aligned scheme, based on the size of the type of
> -the variable.

This also seems to refer to something else: even on m68k
and i386, scalar stack and .data variables have natural
alignment even though the ABI does not require that.

It's probably a good idea to list the specific exceptions to
the struct layout rules in the previous paragraph, e.g.

[
 Fortunately, the compiler understands the alignment constraints, so in the
 above case it would insert 2 bytes of padding in between field1 and field2.
 Therefore, for standard structure types you can always rely on the compiler
-to pad structures so that accesses to fields are suitably aligned (assuming
-you do not cast the field to a type of different length).
+to pad structures so that accesses to fields are suitably aligned for
+the CPU hardware.
+On all 64-bit architectures, this means that all scalar struct members
+are naturally aligned. However, some 32-bit ABIs including i386
+only align 64-bit members on 32-bit offsets, and m68k uses at most
+16-bit alignment.
]

      Arnd

