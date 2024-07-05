Return-Path: <linux-arch+bounces-5280-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC59286CC
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 12:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DEE1F2624B
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D21482E7;
	Fri,  5 Jul 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O/EHh3Ru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M/wNXcgt"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82D143C46;
	Fri,  5 Jul 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175418; cv=none; b=g0662Wojv+jPQE9JcKMCxONUEZ4Ju5LYZ3Z4u5eqAZ7CGdfNsjiQECTT9LzvmBitjD2QnRtnvrWMMqBXwwaGtAWMeHoAB1TUg1vZ52he+piw4XvBfuP+0eplmS5b7w35FdyfAplVMbpeVLkToz/8p1hhZiMZwY6IRDbRTqbXwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175418; c=relaxed/simple;
	bh=qaBZaG71HMTXmkH5lTODIl18rVFJYCWXRSxZMfOLWcg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=VUP22YFdRWZeuLGNXjpQMZPnYpg5HCovFJAlexLt5gjSRHnKsH/lpJeMNsCgg7Anx9EqXBAAnFHIL1cnNnwU/r10d9XMWsaxV8j2SZeEPq49z9nMWBj237Utlu5kj4TZnc3H7AdYx4JPcR5bdxOxCmJL5mR7rupeEZ50UVCJhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O/EHh3Ru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M/wNXcgt; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6004F1140275;
	Fri,  5 Jul 2024 06:30:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jul 2024 06:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720175415; x=1720261815; bh=0BgwcyYVzV
	oWvDg1RD6E7vJTPHk03GlivOzQH40VODw=; b=O/EHh3RuZcTx3qDtbU4nyccmFZ
	tTOdX037S98MZOEnDQsOPMGt6Lq3m4gsNjmdB7/2jiLzukoStDpKSI/tGMfvQ6xs
	srVco6iMb3vIbvMqw5X77jtHys2nL/qhhD1PEz+Bg9AZaAroDDgtSyJ5PH1hGlos
	nw3KAYGBHh4ZojJUtc/Psh7/xwrtvlWTfGho9SlZGJU7HZDJGMJEKgxu4kPXs1Tu
	WHc7flZ2IjaE4iOlMzkcXDHJQJOZxsrjp3J+ZwizWcCMr3gA6z3oY6o2gfxaDCVT
	d5t0PTQF3Q6mZAkCSbsfi81WESbnI0Q3XKU17iGzmfXt4DS3CtgQ71tyWgOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720175415; x=1720261815; bh=0BgwcyYVzVoWvDg1RD6E7vJTPHk0
	3GlivOzQH40VODw=; b=M/wNXcgt6NFUUVIGStmiaQaluZawsrLN8ZvRLRCCZsfy
	F0WxZ64Y7y7vLBgMatyOUKLjWUrND5d4ABIygpuq3n9hiOezrf2/tNIhs8tCECJL
	9pbUV0rMReilzJUrwMkfhOAaLVbZleKL5n6jOXKXG5ydef7xgtjCifAjGqJts2kv
	zNo73v+73HswXZ3YKgS1gpxzIjdt5vZGHP5NR03xlTyi24O4NYexmSsqCE4OlxsA
	CSkrMANci32zquzD6pbxDF8xdWHYXR8wc1It7iq24stsFDS151RDT75gsUug6W4n
	jjCoFYhcpQX3bs/+Arp2hrU2BhQFmbcT5JI4/s6nYA==
X-ME-Sender: <xms:M8uHZtXxZgEnC7dJkuQgtJLMTie3hiSNQRQIK5-0RPPBBJbtH2jq1A>
    <xme:M8uHZtlxbAReuvNXstJeBpLnlxuPxmANBwa0rPdSsMVYTm50x4nMPPEfCGJlSKgU6
    J4rtIzoF_LRgxRZWzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:M8uHZpbH4WkJ5osvgGk3AKjBODw6RhhpnJ7akc20RK4X0PT9b5X8JA>
    <xmx:M8uHZgUrnkXBeGIxHueMC39J03oZWjGuuSxvedwWIp58BlMVsVqHAw>
    <xmx:M8uHZnmT3vn8mmQa-ixoQCXFJoM7flSrSkhkz8fZBP8w4wUzJN7ZVw>
    <xmx:M8uHZtcctr51KMWlegX-Kwb_Qi2ZbgcBOvkG2AFeT2ygegRNnu5oIQ>
    <xmx:N8uHZo7APVUulbUymCX_R30UFUPRJltjifqXXpKVgmxgy-5ev2-2zdo_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7DCF9B6008D; Fri,  5 Jul 2024 06:30:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3294e24c-565d-4688-ba6a-4bb98a2ef65f@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2407050323400.38148@angie.orcam.me.uk>
References: <20240704143611.2979589-1-arnd@kernel.org>
 <alpine.DEB.2.21.2407050323400.38148@angie.orcam.me.uk>
Date: Fri, 05 Jul 2024 12:29:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Arnd Bergmann" <arnd@kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>, "Dinh Nguyen" <dinguyen@kernel.org>,
 "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH 00/17] arch: convert everything to syscall.tbl
Content-Type: text/plain

On Fri, Jul 5, 2024, at 12:18, Maciej W. Rozycki wrote:
> On Thu, 4 Jul 2024, Arnd Bergmann wrote:
>
>>  arch/alpha/include/asm/unistd.h               |   1 +
>
>  This seems out of sync with the actual changes, any idea what happened 
> here?

Sorry about this, I was writing the series description while
still doing some treewide tests that showed I had missed a
change in a rebase. When I originally wrote the clone3
patch, alpha was still missing clone3 support, so I added
a line there to mark the syscall as broken. The current
version is based on 6.10-rc, so clone3 actually works now
and the patch I sent no longer needs to mark it as broken.

     Arnd

