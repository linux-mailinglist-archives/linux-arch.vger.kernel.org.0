Return-Path: <linux-arch+bounces-12419-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895CAE1ECA
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 17:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304D14C3214
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BE5283CBF;
	Fri, 20 Jun 2025 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NyONNO6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WRg1jUbL"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3EA1CAA6D
	for <linux-arch@vger.kernel.org>; Fri, 20 Jun 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433714; cv=none; b=L/GdpBv/gZfZnXTRGq9ZUDqMvRyamuuK9DFokvcAyRUyBUcZ4fu6jWTdqf5THX+7eUhMoIuO0b2MtDL7UwquvKLaCre7oBy1B3eHx4hGIQDC5JZR/CRr4UnnO0B9QMffZj0k2HXrXiRJ1DkuCeixfHVtKQovXPu6xr+W0/B8YwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433714; c=relaxed/simple;
	bh=b4Pf32Mj9wP32Ltmt6mYXrOmBuU4cAQqlIjuBZ9YNzs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LygQ+BuvZudA8LZKuo/h5hYuX542WeavxJ1RDInYThuSoyx77pbW0PgUZh4YxUdM2Dp1g+QIW25zgTinhp6ZEzAsur2fOyT/AY1VlBIc8V6Axs0uQiBnpVts4ngG8RMFs9wO4fhkUh8nL+fYhTi+S8SgAW6pcuQ1SKgMiqeNKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NyONNO6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WRg1jUbL; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3E242540283;
	Fri, 20 Jun 2025 11:35:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 20 Jun 2025 11:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750433711;
	 x=1750520111; bh=m0dqqGr4awLn99WqBRb3iaZ+K3F2GStJ4pUoIclDeGg=; b=
	NyONNO6SwYvEPQparaOuDgd2lmAdtL0v6auEUZYqntzBXmXXI7/sCZy5pbLnvFI2
	kC8AgiCIZUw437akdixgO1ZMrb0b5ekP/Cq0LRf6sXlyGAgHYOv9mkFF4xlzNZqH
	yPD76ZSpiq7D3hB8bq4xeRfCB83hxPyQqbg2rTj9193zRMoWn+2p4kNhaH/xmAN9
	yg0sepAKm796za72lC++bFpgu8H++TKq7QrOY/znv6RZShusMsox/vnQHnE2NJEa
	L4tL0cMPP+US7M6lUFNJxH9cH0rL8AQU4vsx+vEdGkSo2bgllZpt3qwpNrgpfNow
	+nAvOyhEMo2pJ9Zh/kNpAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750433711; x=
	1750520111; bh=m0dqqGr4awLn99WqBRb3iaZ+K3F2GStJ4pUoIclDeGg=; b=W
	Rg1jUbLsb0twu7JIvSRGSiorXW6UGAkgnZgLZl9CFTAJXC9nGVxkl/sY43ZhWDxy
	WjwqgHwl5UoUn3ke0hwUN6yGG4SGP+fUcjf39az962Bqtynob+AVoQqpUws9BK8v
	eDbOKasPJ9JnRNGjD1y1JT/BF8a5aFYgAXI586iu/oKLhX2noadVGwEs/o5ipHFx
	jCvMwCzS0heC5x3o6HzqgJ5i/M5fIWx9m1tyuFsfA7htsoHvmraHHSAd6iNbvcs5
	yn6ShHXmiR/8J7nOn/q0BspqyMeEEdWTAHe7rv5x6thmgzipVPHIIfAHLfQqQjeE
	49XIK5vqygwV0olcQtasA==
X-ME-Sender: <xms:r39VaLjQuW3ZpZZduzfxXYWH5PB9paqoFl4x8QClSEPuyHb8KSQN0A>
    <xme:r39VaIBKOeuLJWfL48q80wdpLivRMQL-a9RKq9xhFZNlPbOTag0tfXrmLuqVrJkOU
    CkHgX08sB9AX-WRJGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:r39VaLEQtEX0KdHoL2U1gld9OoozNrHnWIFCngvRfPUzKeftt1ysVQ>
    <xmx:r39VaISNuZorwvEmODDtjrHFfqIsrSBmAoeaFUMGGf5qv_vllaoB8A>
    <xmx:r39VaIydGcAh4xp_mzZ2hS1oa_y5fGRcZYB688byhYtfP3xr4J5tmA>
    <xmx:r39VaO54avR74KOwstnwJ7PRAKiA0NyDDru4MtZa68MwYnRxKoq2jg>
    <xmx:r39VaIlCMYnmzrI7g3Vrendtg1uqJriNzbkLEcsaj1GCIFU83RqsqHQV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B52F700062; Fri, 20 Jun 2025 11:35:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf4eb377c478d7826
Date: Fri, 20 Jun 2025 17:34:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 Linux-Arch <linux-arch@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <fad45426-3154-4080-8329-3c4f27ea61a2@app.fastmail.com>
In-Reply-To: <20241202040243.GA933328@ZenIV>
References: <20241202040207.GM3387508@ZenIV> <20241202040243.GA933328@ZenIV>
Subject: Re: [PATCH 1/3] xtensa: get rid uapi/asm/param.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 2, 2024, at 05:02, Al Viro wrote:
> The only difference between it and generic is the stray (and utterly
> useless) definition of NGROUPS.  It had been removed on all architectures
> back in 2004; xtensa port began prior to that and hadn't been merged
> until 2005, so it had missed the purge.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

