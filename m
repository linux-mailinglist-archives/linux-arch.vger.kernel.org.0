Return-Path: <linux-arch+bounces-5278-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2A92838B
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 10:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F49A1C21F5F
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED614533A;
	Fri,  5 Jul 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bPPRVJFz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FypYW0TJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4462145FF4;
	Fri,  5 Jul 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167476; cv=none; b=oNY+84IkT5o5G6aiXmcJOdMD13vSy8uY8tQAvn3fMmnw/XBMpzbF1rb7JkqXdU7Kz42TFHEb5zFjdWOd0cVZ40rXa8Bmdo9dvPRnYYQNm/GoJrwEHa7cbm5bmGi6qbyPBeSDsMBeTGU6pYXRdp6VBu18WHGqj9prFcrI9kaCOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167476; c=relaxed/simple;
	bh=JaZCq90X99txXZZxHzux67wr72AiqVEawp8RvvV6yHg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=g9ILBwXlSM2ZNdXvk6oCKc2Z8zn5RT7/4G0m6UwIzXQPInnbRowUG6LVXe6pcp5/zgBVwjTecmBoElMZUzPJT1a0p5fSPzAh2Qsv9rOpVsD/qKkA41HdwTAi8VWnGgtz+nsnLDxGZBzOc9g4JbiXbN2hQ3apOnC9T0M/lPM96Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bPPRVJFz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FypYW0TJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E8BD1138046B;
	Fri,  5 Jul 2024 04:17:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jul 2024 04:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720167472; x=1720253872; bh=yX5cCkRdrC
	0vhKeykg3zHmQM8vjUu8YPsevI5qXlp5M=; b=bPPRVJFzZMyuJiV7d9nFdo88/a
	OZw6+WdvrAAAOoPbYBosQvrmGTVZVz9XRpJlSu93Yy+cQn9zsKHItGtN+6YX27f9
	PT4Zk9k6d8IfQvqNWo0RquYYvy4r2fZgPcmGVOW5bHBoAR+dw1KElI0CIhM2NHCz
	7/dLGBMFiK0W5qN5nT6XxldhyjG2J6PMiOQbbfXIIaG/ufQn+2oCpX0kVoZ3fLKw
	fbMj3d+iUC7mxpACX1fvj1HD3LlTIU34AiIAtjvaXaN7YNfI/swvoPyL3ql5tM86
	UDAaHovjEsaIjaKREy2w9HUog89ZbUYKZbVfUofT6j7vw7tQ4JkW2phkvswQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720167472; x=1720253872; bh=yX5cCkRdrC0vhKeykg3zHmQM8vjU
	u8YPsevI5qXlp5M=; b=FypYW0TJxqN2Rdcgv/IZURdb7QK+8264E6i0zF1ePm1o
	1ODSn7QOheYwJzVfExxo0nV6c6j4xk/mw/eEy9W1Mfic1B32taOn/qlZk9wgpo2y
	To2X1DFSrkK31nQZ/yWh8p3l+17IGfDBmlCDj+BiMHjmNYrGGAI+zM/3i+rlNnjh
	iwNmM8/u+3/9ib3m2LImWYEjjyjzCu0TBm492PuxFbJM1RsG1OMdkusKXKRreA8w
	1Jyxmwbo/LrcaAtbAWB3kJJXXlyxfpXTbnXXKNBQK6QDkv+em7eKf9Twuefe2O9+
	5v/nofzgqfRf3DF3RMXGxbUSSue9lDdLuWcKe17G6w==
X-ME-Sender: <xms:MKyHZobzYwNs4LEoKjKjOA_vzCIEuvpZnmFmcPVqtp6nECfQWHY4CQ>
    <xme:MKyHZjYw1znDYS-ij887nZqukCUix8VdQhv6AvZnQ3Nd0DvsoQLArNlXXKEfr9NtG
    xG7vTpf3tiAH1nTx9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:MKyHZi9jGDNVqkUNJSwbg0byIb6LTPQcjmQTUtx179Eg4EoBnkeZMA>
    <xmx:MKyHZirhtSCIuc5OoiP2LNYo8sud51vWirq2osKxyXgc3PpthnUtmA>
    <xmx:MKyHZjpfuJDLYwkCMosXhjbij4USIQ1Co_hY7p-sgHRai4LCxVHVSA>
    <xmx:MKyHZgREbdqSntQKkAynDCa9HpUPxMkK522rTvQDprBoepw-p_aTSg>
    <xmx:MKyHZkdGbejUp37PvcNC9Gsa6Ey1KEHis4THiDUXWnr2i_HPu3ZcLMIo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7060CB6008D; Fri,  5 Jul 2024 04:17:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3adf7f7b-a46e-4368-a87a-a217a8a8f9d1@app.fastmail.com>
In-Reply-To: <20240705022334.1378363-3-nico@fluxnic.net>
References: <20240705022334.1378363-1-nico@fluxnic.net>
 <20240705022334.1378363-3-nico@fluxnic.net>
Date: Fri, 05 Jul 2024 10:17:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolas Pitre" <nico@fluxnic.net>, "Russell King" <linux@armlinux.org.uk>
Cc: "Nicolas Pitre" <npitre@baylibre.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, "Nathan Chancellor" <nathan@kernel.org>
Subject: Re: [PATCH 2/2] asm-generic/div64: reimplement __arch_xprod64()
Content-Type: text/plain

On Fri, Jul 5, 2024, at 04:20, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
>
> Several years later I just realized that this code could be optimized
> and more importantly simplified even further. With some reordering, it
> is possible to dispense with overflow handling entirely and still have
> optimal code.
>
> There is also no longer a reason to have the possibility for
> architectures to override the generic version. Only ARM did it and these
> days the compiler does a better job than the hand-crafted assembly
> version anyway.
>
> Kernel binary gets slightly smaller as well. Using the ARM's
> versatile_defconfig plus CONFIG_TEST_DIV64=y:
>
> Before this patch:
>
>    text    data     bss     dec     hex filename
> 9644668 2743926  193424 12582018         bffc82 vmlinux
>
> With this patch:
>
>    text    data     bss     dec     hex filename
> 9643572 2743926  193424 12580922         bff83a vmlinux
>
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

This looks really nice, thanks for the work!

I've tried reproducing your finding to see what compiler
version started being good enough to benefit from the
new version. Looking at just the vmlinux size as you did
above, I can confirm that the generated code is noticeably
smaller in gcc-11 and above, slightly smaller in gcc-10
but larger in gcc-9 and below. With gcc-10 being 4 years
old now and already in debian 'oldstable', that should be
good enough.

Unfortunately, I see that clang-19 still produces smaller
arm code with the old version, so this is likely missing
some optimization that went into gcc. Specifically these
are the numbers I see for an armv7 defconfig with many
drivers disabled for faster builds, comparing the current
upstream version with inline asm, the upstream C version
(patch 1/2 applied) and the new C version (both applied):

text	   data	    bss	    dec	    hex	filename
6332190	2577094	 257664	9166948	 8be064	vmlinux-old-asm
6334518	2577158	 257664	9169340	 8be9bc	vmlinux-old-C
6333366	2577158	 257664	9168188	 8be53c	vmlinux-new-C

The results for clang-14 are very similar. Adding Nathan
and the llvm linux mailing list to see if anyone there
thinks we need to dig deeper on whether llvm should handle
this better.

I also checked a few other 32-bit targets with gcc-14
and found that mips and powerpc get slightly worse with
your new version, while x86 doesn't use this code and
is unaffected.

With all this said, I think we still want your patch
or something very close to it because the new version
is so much more readable and better on the one 32-bit
config that users care about in practice (armv7 with
modern gcc), but it would be nice if we could find
a way to not make it worse for the other configurations.

       Arnd

