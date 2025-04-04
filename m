Return-Path: <linux-arch+bounces-11275-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97281A7B783
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 07:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DE5189D65A
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 05:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535E175D5D;
	Fri,  4 Apr 2025 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kyfj2nX9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UlXaRuZ7"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F633FD;
	Fri,  4 Apr 2025 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743746349; cv=none; b=OgsGYetC5Z6afjxe2HT8aOJ/lySKvkbzkabPomQwvDzuP9wBftSLeZdUsjIedf+sLQUmbUgJfuH2oLoAi1SOMW99clrpLPiXSJmLROSFxh8qlbyv1qr06nKhWvWAokG5XQFw3AyPtx45as/jIGtG/NvSC+SFwypJJwUSeNrrnso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743746349; c=relaxed/simple;
	bh=4fByqCcS2OpCFx6aaXLTI8NGU7zrTmm182MAT0SBLTA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AOvdwR9i+NWj5SBj9DFOvoCHbyhZJ3BC6/FaQPLc7GQwEu9TbHsuMekuMX9fcxLN8NFIuLVn30CG5dlFip16NkKTGqmXKYnXTfcpCeknpA6nvJPcNE2AeTgKCldWWtkiH5wvOCjmmpikOqnF7lHP6QfqCrUnA2BNtHiCFPPUtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kyfj2nX9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UlXaRuZ7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 26A43254021A;
	Fri,  4 Apr 2025 01:59:07 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Fri, 04 Apr 2025 01:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743746347;
	 x=1743832747; bh=WtWETSKQn6E8bswj3SLwct6dL1bxKxqY0tLnxPdz92w=; b=
	kyfj2nX9ywt+kVVqKE1zT4yIyvL/zGCsiqO6jTMQsjvGPl/kiPADp7TbnoMZCX/+
	QFXcz/uvl9vN8VceDDBP2648jebgklkeEOSTSLzreuLOQ66tbyj1ik2g3RGuwpoL
	UHMfUYvkNRTbRQxAaPry9K9zDXpBx2fzk0BIL/qaFlJEhNIwbWArvn19EjQozfsj
	K1dZKi3x+x/YhUHYDfzSzl3m8Dg1rBI8dhuVS8wFXlPhveAwoPjZxdkSSNpyuQXz
	s1ZsNxjjB+Vt/q1eB5UnBi3CKuftqnsjcYivr0PDrUXPg+bHEks+t0O+KerRhSsa
	IQ+mazqhzkkCr+tYTirCOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743746347; x=
	1743832747; bh=WtWETSKQn6E8bswj3SLwct6dL1bxKxqY0tLnxPdz92w=; b=U
	lXaRuZ7WZImyYo29349y1E1+PLVJ0jXDAetbG1N9eyw+lYEC+kMR3wqtrzLbAxAK
	5giOOqAaZNhi8FRpn3MTMc4IxAxD7pb700AWeI6+xYK5GYSlObTX1hXqSM93KQhZ
	28Fz7hGF6R5qFu5uDqMTN7KG58OOgscxreZyiSP71gFnGHKRqWLsKceOZ7OatKwJ
	IyAz/gPUNOcSKeUlmCjGuN1h9nQqGTO4gQsW0iTArh61X1WDe+EWrhSuhg6V6Juq
	E8EI4of3KJRnKdyNPlZHhSsq2l5n3WHqeHEElu4x0f3dSihhIqHbcxPssBC45/4U
	JUyXvAN7mnhOv1RT4rsXg==
X-ME-Sender: <xms:KnXvZycppOk42usNnGIZ-1ad9UmDjWojB-S12dWSvr4zNG24vbrrTw>
    <xme:KnXvZ8OryAGUYA6VsbLaJDzt9EEOnbekFpg2e6fmAyAQRpgA9DUwHG17U0-pcVoKq
    6gr1ob-e6TRw7IabRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghlmhgvrhesuggrsggsvg
    hlthdrtghomhdprhgtphhtthhopegrlhgvgiesghhhihhtihdrfhhrpdhrtghpthhtohep
    iihhihhhrghnghdrshhhrghordhishgtrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epihhgnhgrtghiohesihgvnhgtihhnrghsrdgtohhmpdhrtghpthhtohepsghjohhrnhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhdqmhgvnhhtvggvsheslhhi
    shhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:KnXvZzis5nVlP2N_1orhQVV-sh5Gv_mpr8KN165f-qtU3w6qAptW8A>
    <xmx:KnXvZ_8PdQo94lXe-_5Ne7XFtI_xMvdMKpEw3gptZnk2RKEaz9wLQg>
    <xmx:KnXvZ-utjr21MYl3URUU1tX-WmnkR98v79aXEKuzmq75_3iqtUZ3IA>
    <xmx:KnXvZ2HLi4WUyOTg1wGHDxc5bhdzD9G4VaRB-WrK6BS-zirO9J2vNw>
    <xmx:KnXvZxswNfWyawCUSZPdgwJw-w89RVRs8F9GgKVBNOcQZV_fTIc4pKdC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 362E42220073; Fri,  4 Apr 2025 01:59:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdae3ef9051e7a30c
Date: Fri, 04 Apr 2025 07:58:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ignacio Encinas" <ignacio@iencinas.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Alexandre Ghiti" <alex@ghiti.fr>
Cc: "Eric Biggers" <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Zhihang Shao" <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <c6efcdca-5739-42b6-8cb4-f4d8cc85b6af@app.fastmail.com>
In-Reply-To: <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
 <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
Subject: Re: [PATCH v3 2/2] riscv: introduce asm/swab.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Apr 3, 2025, at 22:34, Ignacio Encinas wrote:
> +#define ARCH_SWAB(size) \
> +static __always_inline unsigned long __arch_swab##size(__u##size value) \
> +{									\
> +	unsigned long x = value;					\
> +									\
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
> +		asm volatile (".option push\n"				\
> +			      ".option arch,+zbb\n"			\
> +			      "rev8 %0, %1\n"				\
> +			      ".option pop\n"				\
> +			      : "=r" (x) : "r" (x));			\
> +		return x >> (BITS_PER_LONG - size);			\
> +	}                                                               \
> +	return  ___constant_swab##size(value);				\
> +}

I think the fallback should really just use the __builtin_bswap
helpers instead of the ___constant_swab variants. The output
would be the same, but you can skip patch 1/2.

I would also suggest dumbing down the macro a bit so you can
still find the definition with 'git grep __arch_swab64'. Ideally
just put the function body into a macro but leave the three
separate inline function definitions.

     Arnd

