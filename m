Return-Path: <linux-arch+bounces-1909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26CA843EBA
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 12:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316431C24B60
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0E768FA;
	Wed, 31 Jan 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="c3ZpuaVm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g729DEvY"
X-Original-To: linux-arch@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9EA762CD;
	Wed, 31 Jan 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701743; cv=none; b=GYEcqHOGqcxQMmmAcNSUOSErICIsONQtPXJL5ODKKokd32rCxaaVi3mGIALWy1AcLpK6dnqMpqN01672HyKro6YAf7G6eQNzgyPxXC1P0IzwtEa2EL/5akAhquGQru1//gzqk9fuIhtbQdGdSMqCk0zawiyQlSJ6IOZQ1UbCdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701743; c=relaxed/simple;
	bh=TRuURq3q59U4DW7sJNnHZgy5fStIIlr8tOaoqxV0LV0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HlSK8NAAvrO8wyNzlohHGNtYVVdn3tIJmh3dbkuJMMDnHEgQ+fHT6GEDj8JSvLkevcZhfKX+ME/MzS0yKO6n+EG3gj4T3EHhbN9jNsT4Z/fF3/ONa4IrEej5dgDxiqBt02S4OOlsL2WT4A7Cp1pkmRII5fOe1jvElND1I461yrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=c3ZpuaVm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g729DEvY; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 12BB15C0159;
	Wed, 31 Jan 2024 06:49:00 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 06:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706701740; x=1706788140; bh=jT9sL1YmAi
	hadqrUHigLsBRY9XsxrsPNsnYd6WguPNA=; b=c3ZpuaVmDri3q/zgzFGGbYmnlr
	v5KtWlex5deya16dz2doLnWM2HemO/U/HByq33bviMR/T9HI0G4pZbgv4fujo9oD
	4QK93CVIvQkIYCM8siJl8h9UENtfj2T1ztvpKQM9P6dWEW5DR5bkX+vQnUsf8tqT
	0hNDIzLs6ENHxC/iAcdfHFMVWJCISYq5FVd+w6pLyPpqSTdLmQqlaiy5EqwSpLJ5
	gNPLoYMEn10BUTsE94g26AlDSc2/488D23UFbD2R0/6gFfPYw9jPh7iZQMJjmQ+/
	apB3+jOj6eIns2ECguBdY41z7tomKGgvuiWfN8rYTr4XqPCk6zLXwhYppZ3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706701740; x=1706788140; bh=jT9sL1YmAihadqrUHigLsBRY9Xsx
	rsPNsnYd6WguPNA=; b=g729DEvYgTEUVfuUErlIPFGRGtDR83GKuPIeKNPF5qqn
	uxdYFRuuSWq5zUBAu1MrgjdwaWnyLJ9PdmIyPfNtH5IW66LqliMwHzqIIXlDGrm0
	Uya8VqEUYCW/lzuZU7AD4ecc8R896HXsmgWjAKdJGq0X2J6TCf31hka+6Y6YXWn8
	MFJ82gEIkX3+5d7zGmCg9HtytLi6n3WSXSrlXmey5sF4m/S51mVDHvETHyBsv2Nk
	41VDjckeTDlfGbJGSzxMphJ79B091QKB5nkLzz0A/TvXhKLIglD+l/2i9ajq8zOd
	XQ3PSA/Udf7DrrGQSiXZbNrTxpo7lMwZvEKqt3679Q==
X-ME-Sender: <xms:qzO6ZfM2_SFlM_qzag13_ifNoa3-UhBdDDAGjZVeLRrkm2GR7OHZNw>
    <xme:qzO6ZZ_TKKLvGaYfkC55jwQgM53vTFn51AFdxcT1qUpTfMlsipg8NuHu5Oh44SIda
    qEipBu8DXdUpITruyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qzO6ZeRMd6nErXTpUgamGeftjqhas_qBP8Tp8EZ21Owe4ius29S0gQ>
    <xmx:qzO6ZTsB9DWZQvEYMAIxSne630UngHy3z0jMrVSz5yUGmJ3iuNDhCQ>
    <xmx:qzO6ZXdMp7o7XjskIemSSB24ax5p4pytl6Jklotu9jqYsMRNDmkXfg>
    <xmx:rDO6Zb7mx2aAd5no5SShJqenqMT50SpLR8gInAzlkBlCzQtUcgjOuA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 270C7B6008D; Wed, 31 Jan 2024 06:48:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e55b5c0-6c8d-45b4-ac04-cf694bcb08d3@app.fastmail.com>
In-Reply-To: <20240131055159.2506-1-yan.y.zhao@intel.com>
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
Date: Wed, 31 Jan 2024 12:48:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yan Zhao" <yan.y.zhao@intel.com>,
 "Linus Walleij" <linus.walleij@linaro.org>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
Content-Type: text/plain

On Wed, Jan 31, 2024, at 06:51, Yan Zhao wrote:
> This is a tiny fix to pfn_to_virt() for some platforms.
>
> The original implementaion of pfn_to_virt() takes PFN instead of PA as the
> input to macro __va, with PAGE_SHIFT applying to the converted VA, which
> is not right under most conditions, especially when there's an offset in
> __va.
>
>
> Yan Zhao (4):
>   asm-generic/page.h: apply page shift to PFN instead of VA in
>     pfn_to_virt
>   csky: apply page shift to PFN instead of VA in pfn_to_virt
>   Hexagon: apply page shift to PFN instead of VA in pfn_to_virt
>   openrisc: apply page shift to PFN instead of VA in pfn_to_virt

Nice catch, this is clearly a correct fix, and I can take
the series through the asm-generic tree if we want to take
this approach.

I made a couple of interesting observations looking at this patch
though:

- this function is only used in architecture specific code on
  m68k, riscv and s390, though a couple of other architectures
  have the same definition.

- There is another function that does the same thing called
  pfn_to_kaddr(), which is defined on arm, arm64, csky,
  loongarch, mips, nios2, powerpc, s390, sh, sparc and x86,
  as well as yet another pfn_va() on parisc.

- the asm-generic/page.h file used to be included by h8300, c6x
  and blackfin, all of which are now gone. It has no users left
  and can just as well get removed, unless we find a new use
  for it.

Since it looks like the four broken functions you fix
don't have a single caller, maybe it would be better to
just remove them all?

How exactly did you notice the function being wrong,
did you try to add a user somewhere, or just read through
the code?

    Arnd

