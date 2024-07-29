Return-Path: <linux-arch+bounces-5669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E493EDE7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 09:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1844282CD0
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1B12C465;
	Mon, 29 Jul 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="X6sEyyDV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VInkPxI3"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9084D25;
	Mon, 29 Jul 2024 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236566; cv=none; b=guwHU4SkqLnZRVz3byGBL3ClV3lWXj016JxoUdqsOmgYlopZVJxHLtnpSw7s/qUo12QlbPE3TOLCnESkgceuz5F3xIuGyspSkAVttdssQDqFiBzRZxfYg97FmTfiIT6J79sWSSq4vQLnMEj4nxAkrHGR/MJMZo9iN7JG76CL1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236566; c=relaxed/simple;
	bh=xljAVq2AI+HXD6xrKTZ/yyxJY5ISMHdHtrKDNx8zAs0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UZRKSfv6IT7aODtLO8Y7A6/iOMJpcaxgWpb0IoamFZUsQ3ln7KqbqMFgmgcFXe8VtgLF3mxCjPm3YYdPYBi6qbjDcjlViRiw+3XnhdkFRrk88+pqXFKQJcYexoW4m/7NKUHmx/upwjv6KOMz2A5iejNkf11qbJ6OiRvPL9NXoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=X6sEyyDV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VInkPxI3; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id 674302000ED;
	Mon, 29 Jul 2024 03:02:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Mon, 29 Jul 2024 03:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1722236562; x=1722243762; bh=hGG+ePgWzn
	dtOiaFUWIwTWUzuqt+6sQvsZYw00TGxkU=; b=X6sEyyDVP2R0prfFfX3zKXdYCZ
	WeYLYbsQQ9K7lAxhXT5032spSI05phsmkLSkY2BT3xaqQ2dNGE60gIoP9m+dvW8M
	guc1NQtfaC5+SPx//VR+TUauVTVQ1VO1DKt5m/ACh6SL1shEKvP3Zj2dS09rIfRA
	Ye3HtphwUT7LIT3XtYeONHtOsbVGN8JhykqEmKrELZNrOx5XoLNygkcV86F8HMPJ
	uoU1PrV77xmdTKUMfGsmsm05WdaVRsz7L8IbyFTonFrp8i3ZnlmpDI7OK33AjvgP
	/Zdc7msQ5bA4rL+Mxcax/OYkRhUaobKDveCmzPW3g6vlDIxD+ii0juqMo0oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722236562; x=1722243762; bh=hGG+ePgWzndtOiaFUWIwTWUzuqt+
	6sQvsZYw00TGxkU=; b=VInkPxI3AbZmQ/Bb6DLUoOfg+9WhiERb6BjcAy4481ue
	cHUx1hFM2q73XsJ0jNz25wNZ3ILFsZsoU30Z+sacvVGQEdG4DOKnC/XgPk7/iVpG
	0vzv0fLvARr8NM0XTGS1+GNleUIRihSw+LNRnr7+yPY3SRxwdPqKQjKE29J6cTJV
	lTxNeXE60u9pqry883UNmYPhYEd2xFk/VvFtuIH3XwINgqA+Q6Fm85NTSoqoK+2y
	1/QuwE2WQUK+/8h84noe29dGAzR68uLZp6QAPP2zcc5VWGuy0etV08iR9Hw44gXP
	FNba82LFNVH4cCz5an5BLf76EZjP8Hq/+K9M5Nliog==
X-ME-Sender: <xms:kT6nZoHGI9fDnNOyHkKN1VAKI0jeWw_UnFgUgHt4TuHaVWI7KXLejg>
    <xme:kT6nZhWHdeNTsl7w0QoUspMKnrmZGAbgFqxeuUYi6Dbvtp3fH7BkVFAMqpbWMZuTN
    s1uAQwGZUDcz4CdK3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedugdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:kT6nZiK6IyX_uKW1-DGEa6I5VkL_oAGUmnvHSfGCHJpgnebVlOFMbw>
    <xmx:kT6nZqE4rEE_v38OJku2Y2s6-7h5xt8qVfo6jBLqkDCFShTnKEMVjw>
    <xmx:kT6nZuWG5L9Mc9loue7ddy0zBNZh0caTfY03uElmbUTHR1X5OetaJQ>
    <xmx:kT6nZtPJgXdejwN1ov-n-O97a1torKEmnmP_vZXz_NMnTDJQmaN9MQ>
    <xmx:kj6nZrluBx0db4vbNToIRt_Vs9SKbkfPxfl15oyufOl6u3dEWh2NQRWy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 038B4B6008D; Mon, 29 Jul 2024 03:02:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63eb1654-c614-4f6a-9bc5-8c8085eadf8c@app.fastmail.com>
In-Reply-To: <20240728203001.2551083-7-xur@google.com>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-7-xur@google.com>
Date: Mon, 29 Jul 2024 09:02:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rong Xu" <xur@google.com>, "Han Shen" <shenhan@google.com>,
 "Sriraman Tallam" <tmsriram@google.com>, "David Li" <davidxl@google.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Vegard Nossum" <vegard.nossum@oracle.com>, "John Moon" <john@jmoon.dev>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Mike Rapoport" <rppt@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Rafael Aquini" <aquini@redhat.com>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Eric DeVolder" <eric.devolder@oracle.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Benjamin Segall" <bsegall@google.com>,
 "Breno Leitao" <leitao@debian.org>,
 "Wei Yang" <richard.weiyang@gmail.com>,
 "Brian Gerst" <brgerst@gmail.com>, "Juergen Gross" <jgross@suse.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Kees Cook" <kees@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>,
 "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev,
 "Krzysztof Pszeniczny" <kpszeniczny@google.com>,
 "Stephane Eranian" <eranian@google.com>
Subject: Re: [PATCH 6/6] Add Propeller configuration for kernel build.
Content-Type: text/plain

On Sun, Jul 28, 2024, at 22:29, Rong Xu wrote:
>  Documentation/dev-tools/index.rst     |   1 +
>  Documentation/dev-tools/propeller.rst | 188 ++++++++++++++++++++++++++
>  MAINTAINERS                           |   7 +
>  Makefile                              |   1 +
>  arch/Kconfig                          |  22 +++
>  arch/x86/Kconfig                      |   1 +
>  arch/x86/boot/compressed/Makefile     |   3 +
>  arch/x86/kernel/vmlinux.lds.S         |   4 +
>  arch/x86/platform/efi/Makefile        |   1 +
>  drivers/firmware/efi/libstub/Makefile |   2 +
>  include/asm-generic/vmlinux.lds.h     |   8 +-
>  scripts/Makefile.lib                  |  10 ++
>  scripts/Makefile.propeller            |  25 ++++
>  tools/objtool/check.c                 |   1 +

I have not looked in much detail, but I see that you need
a special case for arch/x86/boot/compressed and
drivers/firmware/efi, which makes it likely that you
need to also disable properller support for
arch/x86/purgatory/Makefile, which tends to have similar
requirements.

     Arnd

