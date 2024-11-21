Return-Path: <linux-arch+bounces-9146-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B669D477B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 07:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3669D2829E8
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DAA148855;
	Thu, 21 Nov 2024 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gKoF+BDY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYZDcqEi"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20C13C3D6;
	Thu, 21 Nov 2024 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732170314; cv=none; b=gQPyD4/8Zhp8WVIUigzrAf2eDXaOXDFBeF/A+1rdenkzgd5w+J95u6ihA4bGMXV113Me0eKwR2jxnHQPvp4TY+OFbKDJYKC5a9ePirotXBjwsVcsivgnRGWvWQWByTqcoRgyE21nHeZbzaP+irj/1Wtsh8xtrZpSvJwdKPrSi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732170314; c=relaxed/simple;
	bh=egoCVr1BilwzWHcGVBQ98EAvgTTioMWrIXHZIoN9fXA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tHYzzHMaP4rNjRQp40R2QSBCxdjc/ouls8JceVX42DFdyaDH26745Z54+CLJ1D9dp2ka6NlGLUuyt98ABq9ZMr4bctcintogjnZGLcz2lD2+aO3t2Yj5akhEeepAzVrNfCljpO4uE7Wtg1K7u0B5GUT7zbKsqD96k3UerF/w/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gKoF+BDY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYZDcqEi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7ADCF13806C9;
	Thu, 21 Nov 2024 01:25:10 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 21 Nov 2024 01:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732170310;
	 x=1732256710; bh=WuODbQXwSS1VveYgLHkSG2hdi3F4z6KiShzT4+ka20E=; b=
	gKoF+BDY0YkGc2+eaGavkKMkFS5H3vVaNH03xF6GdYxmey8Ap30miRUjhDS/4LCl
	mu2u6AZkl3LAozqhnH1VUSyVLwTqzAbWRMZAGJE0EJ/JNEAUxvOWr+WFRGt+S+LF
	NJiHzextz0C204Ztq0FwIDjrsIyEMqcbGlvdLlUpgqXAN1ndKg5Ifqaf605wJkfO
	IfYC09Gj19CjZNIMK9MQ0zeeHIP2UMutSz0wO3Kz78i0xil1rkVE91GpcZbIkBXn
	cm5mB3yaIysSFdr/bRLBz1Vh/vBmQz68r706AQ7ESSw5FMCkPyk6Ivmx5+4nDgHU
	l65UCUEnnEnwAChEgHUYCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732170310; x=
	1732256710; bh=WuODbQXwSS1VveYgLHkSG2hdi3F4z6KiShzT4+ka20E=; b=m
	YZDcqEiWyAblC3/R+xK0hzCnqFnI79HOsjaMmaiiYAd2/WNd9/bZg5TOhDO7maNj
	pYCC1VVN0OjhC10A2Xpu4Xj8xP+O9EtTD4avG6WTw7erFbeSqG787w2VhrmrMPQF
	udgq0zvTl00Zq2pPXyyqYBG+eI3Xn9cISkTOLXVevvUo/GPhu8039YSV7xiv00bw
	QlhZXPRchlq8EreWUHvrUgO8KQFoHhtmKMTmxV9M2K3GZucEsl8yQOjFbGvvzsf2
	6zRI9lOiWE8bg93QJoSE8rZfGjHU9qbHjf3KNbveMXXDGYvCMSbxitThswxmKVsu
	i8q8rCkv2vh+4rP/oP0Jw==
X-ME-Sender: <xms:RdI-Zyzw_SeAGoz0u1GZwQk40Py-TBXZqSF4Wes2tkvUKc3QVEMlug>
    <xme:RdI-Z-TmbAVszloPDHDRnztykiFqVw8mBHeRf-7GPX8y91-hmHqyhH-nw8Q3tQ6Zx
    BPZGXJ2rEQBNeLRgxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlhhisghrvg
    drtghomhdprhgtphhtthhopehjvhgvthhtvghrsehkrghlrhgrhidrvghupdhrtghpthht
    oheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprhdqth
    hrrggtkhgvrhdqsghotheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghl
    ughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehstghhnh
    gvlhhlvgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehhtghhsehlshhtrdgu
    vgdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:RdI-Z0V_X7AiciSx4PbadCEX4rn3Zn6QQOffxItaS3Nu102BjujRTg>
    <xmx:RdI-Z4iagFM_S2LzuLngwgxAgF8TORQVzwBaN0DCxMhzntx3v9WwxQ>
    <xmx:RdI-Z0DAO7qVj5KmUR2M5RPrkbvwWe2kqiRTUJkpnOr13N-MZ1Vxsg>
    <xmx:RdI-Z5L3EDbf2VHSKnKv6B-fZZ6gnXAxY_dnY9L29GhgXiz295Iwog>
    <xmx:RtI-Z0ttkVd_Gu4oyJyhhnRgM_ov3EpUZUre6G6eONs1xZ8xFJXuD6r8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 962D72220071; Thu, 21 Nov 2024 01:25:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 07:24:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@kernel.org>, pr-tracker-bot@kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Julian Vetter" <jvetter@kalray.eu>, "Nicolas Pitre" <npitre@baylibre.com>,
 "Christoph Hellwig" <hch@lst.de>
Message-Id: <bdfcadb9-b1c5-4992-9c5f-7fe59252f77d@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H7VLPngEb_pxs4Zc4OX3i5X0W0Ao=7qFhY_PMqyEBVjyQ@mail.gmail.com>
References: <c09168a6-23e7-40fd-afc2-4c3ac6deaff6@app.fastmail.com>
 <173214663696.1393168.4436714062176910731.pr-tracker-bot@kernel.org>
 <CAAhV-H7VLPngEb_pxs4Zc4OX3i5X0W0Ao=7qFhY_PMqyEBVjyQ@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.13
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 21, 2024, at 03:20, Huacai Chen wrote:
> Oh, no, why the tag name is asm-generic-3.13?

It looks like I typed it wrong when I wrote the tag message,
sorry about that.

The contents are correct though, and the tag description
does say 6.13.

      Arnd

