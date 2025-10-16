Return-Path: <linux-arch+bounces-14158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BBBE1D16
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 08:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDC5934D3FE
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307012E8E05;
	Thu, 16 Oct 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MshjixAm"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD761A9B46;
	Thu, 16 Oct 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597594; cv=none; b=iqgV0Lzun7RWaXc04/Dq5yA0vq03oR//LNJHRa0cW4M9wlwGM4XMVRMsifoU964+ydn682lMvkUIqDBe9GtVX4V2OAsQSmrvqvi14C6hj0BUiCwAlBS062R1masRDYmvMp+F4kXfFRZbt1mFzhfWoFWQnusjjrHWhl9uO/f5aSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597594; c=relaxed/simple;
	bh=LoP0iL2fgdFZyWRft6p0C1mJ+sXum2DzJhkgo80tJwY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GgGH6LMVLXSsvIOPMMQfIHrdp+GV75Kl5h82Ujr/B1ez/yyO8q+J7GoCRf35IPp6YEKwTIWYxCegN72A4BAEuKl/qRC+5B4v3VE3iX2HhMmrrVA70PtA+FO6J3Rdf9N26jWdTDqUDYk1c1lJ90G83p0TMaCx6ZM45995te3BZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MshjixAm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C05014000F4;
	Thu, 16 Oct 2025 02:53:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 02:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760597589; x=1760683989; bh=tcUBI5yvDagqARx1NRhoV/Xb73Hae3sjMcC
	zbp2ZYMI=; b=MshjixAmEDWJtMGKvrmtBxn8dNwDRLg8fCulAR/XGo3Gsrfuynv
	pV/lk8YPlC2PY56rMG3RyG5WNNZDL5vTRTVyHg5rzDJc9adoIiGP+DBpYPWnBT/r
	gZ1uIp/EFCIaMHdB5ncUSmXl4MD5Tub7GGKEcuCWT80VWFxKoGGJGuRS2M2ETIRw
	/iKPKDlp6pUHYEf3LUUGHYarSNsQos2MLapnv/S3nvCM99QmFlJAmuJKA9y9kCp7
	R/5yxrJFHn7siUrXblYkGGNI/pmTinXisoBUZj0aKNa2C3I+wAQnx8zbrYPWyskM
	jQOF1d1SI4s6gd9T/W3wgWQmiKjQvbfEU4w==
X-ME-Sender: <xms:VJbwaG8r2GtnqYu_SyRHYVMJCO6mTOCi-aEd2j__gZMaLjmP7_t9sQ>
    <xme:VJbwaKYrKgw5b4WDAtVqdtM34Q2ZFD8NXrV9FANNezB_BxwEV4C3-kCDROtqVWPP1
    g3REiOAwt1ypuKZMcNbCIA1tD4bwywQibLuaaXZMOSN7l0v9faWR4A>
X-ME-Received: <xmr:VJbwaEoHqwlbUCRYubDX81jG181ptZlPIR8HlTq_FB-4f_EATTnaeNiietu4tjPlkLpSypcpu_NohqMID3K5AKQ_oS8gw1VZUos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuh
    igsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsgho
    qhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfi
    hnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhr
    tghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VJbwaP3dFtsuOU6BbisEcqdjq5j4-7XdMeq6K7FhkpxAXaV9TFuJoQ>
    <xmx:VJbwaMla1P6LLOpI_G6WJiwD14sEUFKkzKxaEh_n7JJyNIknZLQHpg>
    <xmx:VJbwaLZ8ZeeRsp6rqWOIr9WhdsUOR_yC8BJ7Ejr4IZfWKcablR_3qg>
    <xmx:VJbwaO8whWJLF9_uQWbe_M3DgeWM1Z_t9XlpDgeSBsDU1mq54U19Tw>
    <xmx:VZbwaDgCeOhZ0pxog5aFoAFfJE_CiynmZYMXUc28LRzsN7A1vM-bgH7->
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 02:53:05 -0400 (EDT)
Date: Thu, 16 Oct 2025 17:53:05 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: David Laight <david.laight.linux@gmail.com>
cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [RFC v3 1/5] documentation: Discourage alignment assumptions
In-Reply-To: <20251015145332.260eebe6@pumpkin>
Message-ID: <29188dc5-32a3-28f9-b488-26cca713e070@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org> <76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org> <20251014112359.451d8058@pumpkin> <f5f939ae-f966-37ba-369d-be147c0642a3@linux-m68k.org>
 <20251015145332.260eebe6@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Wed, 15 Oct 2025, David Laight wrote:

> 
> There are several separate alignments:
> - The alignment the cpu needs, for most x86 instructions this is 1 byte [1].
>   Many RISC cpu require 'word' alignment (for some definition of 'word').
>   A problematic case is data that crosses page boundaries.
> - The alignment the compiler uses for structure members; returned by _Alignof().
>   m68k only 16bit aligns 32bit values.
> - The 'preferred' alignment returned by __alignof__().
>   32bit x86 returns 8 for 64bit types even though the ABI only 4-byte aligns them.
> - The 'natural' alignment based on the size of the item.
>   I'd guess that 'complex double' (if supported) may only be 8 byte aligned.
> 

Those distinctions could be useful in a discussion about memory 
efficiency. But this document is concerned with avoiding a performance 
penalty -- it's entirely unconcerned with over-alignment and memory waste.
Hence, "aligned" is used as shorthand for "naturally aligned".

The ambiguity in this document (and my proposed change) stems from using 
the word architecture to cover ABI, platform, CPU, ISA etc.
I can improve upon that.

> What normally matters is the ABI alignment for structure members.
> If you mark anything 'packed' the compiler will generate shifts and masks (etc)
> to get working code.
> Taking the address of an item in a packed structure generates a warning
> for very good reason. 
> 

I believe the problem with 'packed' is already covered in this document.

> [1] I've fallen foul of gcc deciding to 'vectorise' a loop and then having
> it crash because the buffer address was misaligned.
> Nasty because the code worked in initial testing and I expected the loop
> (32bit adds of a buffer) to work fine even when misaligned.
> 

I think that pitfall is already discussed also, along with a remedy.

There is also this,

    ... for standard structure types you can always rely on the compiler 
    to pad structures so that accesses to fields are suitably aligned 
    (assuming you do not cast the field to a type of different length).

So it seems to be fairly comprehensive but I may be missing something (?)

