Return-Path: <linux-arch+bounces-6365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310B4957E68
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 08:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6661F23805
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 06:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FBA17B4ED;
	Tue, 20 Aug 2024 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OKXbRiwX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pXEC8dOF"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CA1741DC;
	Tue, 20 Aug 2024 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135761; cv=none; b=ZeEUtcCxtXxcexZtKiw7R3TDoEB9rRhib06zPVz9hg6h3UGTKIdBsCoStpvOWq5UhsXiJjKJ/fEZGDJmZ+DTuLV3EmePNJdEnNXqUpBHjkyO9/VSJurP2NItTE9YEKBb6xhop7684opofyr326YVlMbguBBdo62Id32MRos+oJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135761; c=relaxed/simple;
	bh=eIZBPiIt5zVdvAwtZhCOpzSYBNx2G8omnWVeneqoGgU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QkVwAH7mnePRQxgTjHORFmRxgN0jSYO4PXfqPNRrbUgUaYtuh8sTluliXUbg/iYqdO8EmmNikbQvWV2DvgZNoOOCh/OrjdIRE0DW+yBDUi6x32EqdiSa3YsMORSb8hMURPDP/+lGMsXeCJU8ybO7pvgObFi62gg5g9nScYtalXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OKXbRiwX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pXEC8dOF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 796291151BE8;
	Tue, 20 Aug 2024 02:35:58 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-01.internal (MEProxy); Tue, 20 Aug 2024 02:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724135758;
	 x=1724222158; bh=0vDYNAbB+WPOrWtq2CTrXg2IiuXw5vXI+vIJEKJZWmk=; b=
	OKXbRiwXpVJJCx4bX4GFgnZcQYliwB0hi29SUulPXgS5RNckJ/vZOVGPTUalwO9R
	Qc+3Zu4KjcIEDF3b1lrAYrwnyKYiJp0Xny9CWLYJ8FGmCtGwdhrjJgJKayGWPLbO
	A+ceAyTZ7p5V5e/ZudRH5MO4G2ryn4swJzEzzcxFOefc4nocFAFANXClNUT3xTBJ
	rElpMSjQ60DwQwHR+2KjK7c4d4OzEXfnaYDa6Y6AiSUwcJwClYVOQt3ihhGNgvCg
	OSiiDAOjCH49rcRm5rLf///YpTSvVC6y4BAvuQ0IeFZAoMlJLMPZKgBrcFNPRhMm
	G2XKI/y1EkCfMw6c0e77fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724135758; x=
	1724222158; bh=0vDYNAbB+WPOrWtq2CTrXg2IiuXw5vXI+vIJEKJZWmk=; b=p
	XEC8dOFtyoHLQpQbJEJkNxzJCA94u33rkIvGhvM6xgS2+gc7eAmFUdotuRn0uzuW
	oNeIQqzLSTQ64PYp5aOVwhZvKtqUb6u0utY49tGwjvyYrSrwcNUupohXbwkOSz2i
	2OA8cvr7rWpGB5lD0WiDjPhdNoin5gbcgaEOhfYrt9sJ4j4syuS0zrRMpqWMNWpG
	5G8v232a3BVmDviirjxAPc/pRWInsNPMionWt+cVJ/miz2DcLkbDa/0EvOcIUq49
	C86HZ1I85P2zmdEo/jF7YWC00oJu9WUw2ba04OK/lYHEVm/bsRraEOtR/XMVNav2
	vlvP4SWXss4TrMCGwLPbw==
X-ME-Sender: <xms:TjnEZmmPHf9C8Oe6UUmrgXxuvxb-nEaMDNwE3SwMIl2ALMp9aqfr2w>
    <xme:TjnEZt2BMLm8htPnoCaDwQTze3_yIVqinJsSIRvzGNnBWWacMg5xEMh3ZyYv_Flci
    UO3Pq9M6qnuYvL018A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduhedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhshhhumhgrnhdrkhhhrghnug
    hurghlsegrrhhmrdgtohhmpdhrtghpthhtohephihurhihrdhnohhrohhvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhi
    nhhugiesrhgrshhmuhhsvhhilhhlvghmohgvshdrughkpdhrtghpthhtoheplhhinhhugi
    dqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TjnEZkoxcMMvwMveTgw8HY9M80jw74AvtHnqW9i1fr0Lo_TV5j8Xaw>
    <xmx:TjnEZqnkKOQ2333Jgug6eARcVqxZsJ6O58nBkSdbRVeZzZcGNZJ-Hw>
    <xmx:TjnEZk326Hgm_wdYq2rnsethr0XVBPZM-tuwx9UvyvVXwtrx0xVhWA>
    <xmx:TjnEZhupXB4OSFode3f7PmJ0ud_JoPifs0fEDCjSs06WSziUx4o9Gw>
    <xmx:TjnEZuqgoQhTEAUlTvoW7DrzsMjIVc67lY-WCNfYiwNfv2MDUBlRnxlc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 387C016005E; Tue, 20 Aug 2024 02:35:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Aug 2024 08:35:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anshuman Khandual" <anshuman.khandual@arm.com>,
 linux-kernel@vger.kernel.org
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <8b780eda-bb64-4baf-8e24-501baf8ed8db@app.fastmail.com>
In-Reply-To: <17020e56-b0a9-4705-8ee3-c675eca99490@arm.com>
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
 <20240801071646.682731-2-anshuman.khandual@arm.com>
 <090eb237-10f4-4358-be07-1eb8d30c3ec1@arm.com>
 <3b219e52-1d2a-4e6d-adff-efbab3e2282d@app.fastmail.com>
 <17020e56-b0a9-4705-8ee3-c675eca99490@arm.com>
Subject: Re: [PATCH V3 1/2] uapi: Define GENMASK_U128
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 20, 2024, at 03:25, Anshuman Khandual wrote:
> On 8/19/24 12:43, Arnd Bergmann wrote:
>
> Should not the second shift operation warn about the possible
> overflow scenario ? But actually it does not. Or the compiler
> is too smart in detecting what's happening next in the overall
> equation and do the needful while creating the mask below the
> highest bit.

Not sure about the reasoning behind the compiler warning for
one but not the other, but I know that we rely on similar
behavior in places like:

#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))

which is intended to return a zero without a compiler
warning when passing an 'unsigned long' input on 32-bit
architectures.

      Arnd

