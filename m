Return-Path: <linux-arch+bounces-7009-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F262096C09F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9B71F270B9
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87601DB548;
	Wed,  4 Sep 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VcR8knTT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3vLJdL8"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFB1773D;
	Wed,  4 Sep 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460281; cv=none; b=sMqMCH5vhPZSxHoWuN9BfjE3/4hjzw7PUzH4Ta8P6oG8Z/gsMftpvz/vpAI/2bCXdwt+Scy9CqzFS4vmHOKzU+5RFYVlohciufN6q06Xxwd4DRrefwNDIUBPeXrznuAJ/JJBWFg12P+pW6z+S/9XEXSGzTZv69UCYf7reE8BaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460281; c=relaxed/simple;
	bh=kk3KDkabUcBjOBROxOGJn17cV75vr/ZvBn4nanNtGGs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rWX5VkP7dzFPW9xnVRJFCYf4M8mP+D61cAxH1o5HCPBf7ePkmtyKTSPre+YpfWa52rWDAN6b0N67SyrK3PZnuGymutAy/vYVYTJ+KOn7l65c6bW8zhm4BaJOu28RMkXmr1TZdrwyJtRbLKYtMU8m6kKPzr4x0LhaqT6ZbGCekKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VcR8knTT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3vLJdL8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE7BC1140294;
	Wed,  4 Sep 2024 10:31:18 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 10:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725460278;
	 x=1725546678; bh=EgXxsNca/Kx28o3gcc/HStaYh/U0IAH/AmlrsPXw1XM=; b=
	VcR8knTTnf+MWH4g9GuWy3ck4li8i32dYMW+2RPCzNAomvBtfZVUOdUxrKPaSAL2
	rEKAbiC4TRpjTEqxAC7Vzcw2yi8+SYkh1VKkJHMTnGQCs6CygL25LC94Uyh3xiOk
	yOQIIFa++Rs8I4LpUnPtvQhlUTIuV+olJFqXh0Sq8maP4mkgZaXr8WljloR/m7cx
	CK0BHJXnaavWPp7PsHewNnajQ2rQMlYNrbwcOwqLKhi0XFryE3136fRG7UXm69gf
	09E1+8yicADI56bzXW0igyuuUPl0ZJmGui10qMcq2EwfC4DYulW76ea2zY1b66L7
	kiomTtGgF1HeC7Uz9T065Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725460278; x=
	1725546678; bh=EgXxsNca/Kx28o3gcc/HStaYh/U0IAH/AmlrsPXw1XM=; b=c
	3vLJdL880YYW8xyAU6P3fA4BAzE5YYPBzU9ESIkVT+B5poqVelEqDsXsI1qD712D
	/ftKGRTmQ4gWmIr/mequJ7w5b4fHfPm7w7cs3vxBB9vCbfUCDpYyklugv3xphafM
	tY+ylnxqnUVWOOG23yooG3xD4uwY3RvWhGltC4o79CgpBzY/0l5yj1/FnHXymavS
	x9d5ynct7lUS29j4MMqbPW4Mb34NHme+yOjnKljduw0SHju9b4XuFuVuiRuyzsjS
	vVx/Ht/CjfUTfQqNZuFO9Pkf0D8pP7wlNL4mRa50qxBk7Z/p7XCOVSWtBQhaAS1T
	zmqmAwC3HrFLSn+baO44Q==
X-ME-Sender: <xms:Nm_YZrCubwPMvFRYhiLMhGASh_OFNN-8zkiLXxG0zr2uRX0nhTNA5Q>
    <xme:Nm_YZhidtb8Yr9vOST4TKIb1yWjVOmVTxiQ2FuCyqhb_P_tFjF-PX8ULqjrdOC32-
    tDuMZ5dgwxicGm2D_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvnhdrsghrohifnhesihhnthgvlh
    drtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgdqmh
    grrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehtghhlgieslhhinhhu
    thhrohhnihigrdguvgdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtph
    htthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Nm_YZmnL92QO1YuABDDcLxNwVhVc3tzoE4bz2Lynp1_t4FQ1sHCWpQ>
    <xmx:Nm_YZtxd8XVvHvskJTTQ7IqfVZ2a8hkHRVZQ_R4fgfyJpsmULmPvdw>
    <xmx:Nm_YZgRjLJ3axcmXFVf66dSxDXCN34Xs6dLi1vzRzW30dJjdJV_qAQ>
    <xmx:Nm_YZgZdcg359xr-5neQXJHRZ9C3noh0AM3kptoXzhlu_TDqpVr4dw>
    <xmx:Nm_YZlSdoDmEmT7lxlsh_gu6pzOWShoesvKQOYFhMwTyVDa2wRo6ppM3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4A6972220087; Wed,  4 Sep 2024 10:31:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Sep 2024 14:30:57 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Jonathan Corbet" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, "Len Brown" <len.brown@intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <f2e34459-cbb1-4697-a57e-d8f4e43588dd@app.fastmail.com>
In-Reply-To: 
 <20240904-devel-anna-maria-b4-timers-flseep-v1-6-e98760256370@linutronix.de>
References: 
 <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-6-e98760256370@linutronix.de>
Subject: Re: [PATCH 06/15] timers: Update function descriptions of sleep/delay related
 functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 4, 2024, at 13:04, Anna-Maria Behnsen wrote:
> A lot of commonly used functions for inserting a sleep or delay lack a
> proper function description. Add function descriptions to all of them to
> have important information in a central place close to the code.
>
> No functional change.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  include/asm-generic/delay.h | 46 ++++++++++++++++++++++++++++++++++-----
>  include/linux/delay.h       | 48 ++++++++++++++++++++++++++++++----------
>  kernel/time/sleep_timeout.c | 53 ++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 123 insertions(+), 24 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic

    Arnd

