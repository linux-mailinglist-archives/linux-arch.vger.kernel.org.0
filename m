Return-Path: <linux-arch+bounces-5375-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C21592F5BB
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 08:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79111F2261F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B059E13D539;
	Fri, 12 Jul 2024 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UK4VZkrQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PgIg7rp2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A313B2A8;
	Fri, 12 Jul 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767275; cv=none; b=Uq+kuPnGkUyote9Rma0xaYk+onOQT6RQmSRRC4xC4b2sGQwaXc0vTWx6qlTsYsdFyNaFfmhkZB29jNatZwQGHr0y0EJJiAmfcDpm/lR7y56mdgNd4nSR8ErYxgG4WdDqIAUxVytuE0yJaI+L1ZyOxCgPUNnvqzTCdn3IQhLMOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767275; c=relaxed/simple;
	bh=R/n1S2lU3wjKVB5Twt0F6ddDg+D3Vh0Kp3XTwGX53ZA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=eQEnkiSRbl+FHoXgNTnWfloE1mPH7mWDT48oi100pk79WQWJVqYuEV6OTRDqqpcK194Kf2Hiy9QKtYKG8PoDL8+6Gkv0MSSTvWn/fhRkwgoW6NC4y8JkQi/EGzyUCxrkROHAHDmYY01PATFh8Im5l4q96UzRpsvIExna15LA/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UK4VZkrQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PgIg7rp2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 66076138880C;
	Fri, 12 Jul 2024 02:54:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 02:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720767272; x=1720853672; bh=PDVQUKl+Ba
	T+zis/3VmiEmMf8+afWtbIXBJXNSBs60U=; b=UK4VZkrQNX5quSRwdSj5FvyrUU
	XZLceuSSzhbaPZyuj0pTmdzLm8v5CbhcUW+YnniE9xTVzgBU67SaqMq1JH+YVxxy
	1RNppFuMcl4cfZwlFcxmNa1yG/goYFOeJ+7o+x094rp2uDAA2haiVZhdk9sYNyPi
	9B4PjeV21dAZIIovuX01EoyYVgTK9J9mrVmNHfFsDYh3JTccRbmuaqFEm9KlqhdI
	5+CLkue46PQSB4gFp8qaERxRfoskwUC4EFJU2lIHCqe5UoMAq5bTeN75Dj8vpj2Z
	lNWK8B02B0zp/GWU1wsjZPdkWp4o4ERgpFTdoQ8t1dU5e68ZeYnnLBc6R6rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720767272; x=1720853672; bh=PDVQUKl+BaT+zis/3VmiEmMf8+af
	WtbIXBJXNSBs60U=; b=PgIg7rp2MgujU27m7rkpXci6myMoHKnc8qeuBTcn0wD2
	shRTEsaG+v3KINiTDCRwP5VqQko8Jd2uIkcle6mVqTrRMdohC1n3VVmNWGGtoCPq
	g8UoNo0QK+YiQXjjrSuPl8bN+Glx6kocaOO9b11kSbZKhqe8ABV/Z9oBRoGSdvLw
	a7aHz4yndw5FHo1XxgDVcD/f10LFA5bmgOmwNwia9k80VfpIKtOchKjvsg/LbM9Q
	RGj8WxapwDgB+kzSH8u5v23OCOyd/wh+Xlra4Rrm1yeiffyTRNyhWXzucqVqPM1/
	4NNx54PuUtTaqKyYX2ze/1k63AhUCOJ/JybNfYAE/Q==
X-ME-Sender: <xms:JtOQZoZIhW9iqZDb3amQNZQ83lfZCw3Lh086Q4pzGBV_daCdNu9k7w>
    <xme:JtOQZjZhZpLUJ3Lf7jQGduMZ0kOcA_CKRa764OL5Cf-9AYnVbhb3zSwfm-tOqiqJ8
    znJRMpfjs39KeAYlQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnheplefgieffiedtvdffteeiheekfeeifefgtdejgefhheetkeeigfeltdevtdek
    heejnecuffhomhgrihhnpehkrghllhhshihmshdurdhsrghspdhkrghllhhshihmshdvrd
    hsrghspdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JtOQZi9AFrpx2QSmrtYgZX4XZT0QlGRTubNZqWj1VsiliNSZ0C75BQ>
    <xmx:JtOQZir6WmskDXpvoPq156kau3NCS_FhVIGZkfpcnGuc3iP8qlR4wA>
    <xmx:JtOQZjoEerkZ23eMfFyGfMkN1qMEMYxpkhzux-ybCvgJVMYH5lhe9g>
    <xmx:JtOQZgSFHku4PJm0UIoOfOkXAVs8DZpGW2WeRlVhv7-pMhuSPI0vbQ>
    <xmx:KNOQZm35KjA5oNEUEGBsAMlTc3KNniGeZdq0N3TeI_zT3BUKEnRvP1sv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7B5CDB6008D; Fri, 12 Jul 2024 02:54:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1a9e8039-0bf8-40b4-ad07-a51ea569b7b2@app.fastmail.com>
In-Reply-To: 
 <1f28df2a177cf632ac70162b345dc59711959f48.1720763318.git.christophe.leroy@csgroup.eu>
References: 
 <1f28df2a177cf632ac70162b345dc59711959f48.1720763318.git.christophe.leroy@csgroup.eu>
Date: Fri, 12 Jul 2024 08:53:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Alexander Lobakin" <alobakin@pm.me>,
 "Nathan Chancellor" <nathan@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH] vmlinux.lds.h: catch .bss..L* sections into BSS")
Content-Type: text/plain

On Fri, Jul 12, 2024, at 07:51, Christophe Leroy wrote:
> Commit 9a427556fb8e ("vmlinux.lds.h: catch compound literals into
> data and BSS") added catches for .data..L* and .rodata..L* but missed
> .bss..L*
>
> Since commit 5431fdd2c181 ("ptrace: Convert ptrace_attach() to use
> lock guards") the following appears at build:
>
>   LD      .tmp_vmlinux.kallsyms1
> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33' from 
> `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'
>   NM      .tmp_vmlinux.kallsyms1.syms
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33' from 
> `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'
>   NM      .tmp_vmlinux.kallsyms2.syms
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      vmlinux
> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33' from 
> `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'
>
> Lets add .bss..L* to BSS_MAIN macro to catch those sections into BSS.
>
> Fixes: 9a427556fb8e ("vmlinux.lds.h: catch compound literals into data 
> and BSS")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202404031349.nmKhyuUG-lkp@intel.com/

Applied to the asm-generic tree, thanks!

         Arnd

