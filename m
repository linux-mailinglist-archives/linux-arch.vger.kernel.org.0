Return-Path: <linux-arch+bounces-1286-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29550825C83
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jan 2024 23:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8351F217EC
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jan 2024 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37519358B7;
	Fri,  5 Jan 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jWbMMa4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7FRtFqQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982E35890;
	Fri,  5 Jan 2024 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id DCCDE3200B0C;
	Fri,  5 Jan 2024 17:25:42 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jan 2024 17:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704493542; x=1704579942; bh=iMsZNlGRtM
	ubQvf9H8XXkAzcuSCYW1RsMmEmn3Ttxug=; b=jWbMMa4yHlKJwD+tQ0Rhvw7doY
	6dv6WRbgnzVy3PZ+TxPrQ+NFHeexO9WdgLSzmoq1/8ftV1Cn30IX95Mep8N00/wq
	HLUrYIr2gy1L4atIW/uSjAximEKDtf3HzT5+CkXfXbf0oLNA0KGUIfr48wHCfjSU
	Jil44sr93ccglvPw4gQt4C4AoZrCyBf7qJ6FKIrVEXTllnklgC49X0Ua2K4oXySJ
	GUrDtnLHs9mwwPlJU0LM1EB4O8MQAELonwpgl8jh6/TET5QEjWPh3VhXztrrqfK4
	nDrkPnaYkw9PM2PExKyy++vGfq75ox8l9cKhv8W5Nv2zKDW1j3E49JpzcCuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704493542; x=1704579942; bh=iMsZNlGRtMubQvf9H8XXkAzcuSCY
	W1RsMmEmn3Ttxug=; b=d7FRtFqQiu0fpvp6v4gM5Z14djHRrSDTtga/y836dLZQ
	CoZPKkvzkAcL6L88EVaRpiDmsoiKS5wCvCVGEbKbJZFPBcFIREgMfom9tbSqNKB3
	06Mp3SvObzOhWFCAd+FGw5dYu86Xb1Gta8ekKdPVswccLXKqJ36kDB1iI3bREr4W
	9yxw4+rGeyASoFZXplZYwAQGo2NmPCoAkdDU/nbuYtmBp1j4r/1Gp9ZWbBthEQA0
	ythsXxDaTo5ala+dIXawZAOiNfypt2W4V68/4TuPbjaCJypS2aqRQqK/EL02NOSI
	VUX/7OhrASpxOyZSxX7lER4pyn3L22HyQrdAMn3e7Q==
X-ME-Sender: <xms:5oGYZbK_POQ_XgLzhr33RWdb3aI4Q6S9GdgBORjkJcTCWALOdLS5VA>
    <xme:5oGYZfKmJR76dWzzsBV6usUstDl1EqLWuElSY9UK0ozjtq5k2My9zh4Q9GFLCUFb1
    8K3xh_gOt1qXPGkXsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:5oGYZTvZfWShhF-8dvpym2EevvLA_rN1_oT_MsoT88IyrLrielYYOA>
    <xmx:5oGYZUbsB4wpUmA2_rZUfEYIB1D6PA9FuJPDfxQZ7ClVTGxT89TLww>
    <xmx:5oGYZSZCcn7cGS4gnVltUNSp94i1DVmiMGnSNRQfFTojJ8b1qVLfAA>
    <xmx:5oGYZVz6ObSSw8yzkAq-jQn16rHNz-Th0vazgHhcfp_rE1T3-flJNA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2BE22B6008D; Fri,  5 Jan 2024 17:25:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e16b15b-e715-43a3-915e-7f43fb4af935@app.fastmail.com>
In-Reply-To: <20240104094010.394669-1-stuart.menefy@codasip.com>
References: <20240104094010.394669-1-stuart.menefy@codasip.com>
Date: Fri, 05 Jan 2024 23:25:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Stuart Menefy" <stuart.menefy@codasip.com>, linux-kernel@vger.kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "David McKay" <david.mckay@codasip.com>
Subject: Re: [PATCH] asm-generic: Fix 32 bit __generic_cmpxchg_local
Content-Type: text/plain

On Thu, Jan 4, 2024, at 10:40, Stuart Menefy wrote:
> From: David McKay <david.mckay@codasip.com>
>
> Commit 656e9007ef58 ("asm-generic: avoid __generic_cmpxchg_local
> warnings") introduced a typo that means the code is incorrect for 32 bit
> values. It will work fine for postive numbers, but will fail for
> negative numbers on a system where longs are 64 bit.
>
> Fixes: 656e9007ef58 ("asm-generic: avoid __generic_cmpxchg_local warnings")
> Signed-off-by: David McKay <david.mckay@codasip.com>
> Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>

Applied to the asm-generic tree, thanks a lot!

      arnd

