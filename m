Return-Path: <linux-arch+bounces-1733-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE56C83E32B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 21:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3261C24362
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 20:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B0F22EE7;
	Fri, 26 Jan 2024 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YIJ99kLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vu2MCvLv"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1323742;
	Fri, 26 Jan 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300080; cv=none; b=Ze1clGZUfLQkjZ9vOrz0PDMlcPqK4NAsOVTr7fdIhOY82dFHLbg4C3TW/faOeixFR1jcAG0jJgrVidtW1165rABhLBXQXdia2qHhQi6iz7oU+FvqT/3Xjv5FJ1Xhf5zruzlOg/AAgcmmmneHpPYU5cgwyI7FD//pa8b8MTSHG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300080; c=relaxed/simple;
	bh=OZ+ewMuXtA4D3cA/M9PX3XdetpRqcRYxX9K0zlX/pAs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=bjpvytn7X4zu2MIn8fXtE4HsREIC/m1TgG4OQblcZ7JieDAJotRwI+qOW86HefOqeWENxn/e6G1MlZk3LCnpyxJB382fxzcacpB2BUL1W0VZpyaTjyfumc2zN9ZNV76SQ5tTC/4Cq1b3aG9jOebDC4WP8pUAqquEeFjqAJG4UUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YIJ99kLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vu2MCvLv; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 7150F3200A35;
	Fri, 26 Jan 2024 15:14:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 26 Jan 2024 15:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706300075; x=1706386475; bh=PTTnJNpgNL
	bDx/r8kMhAAD2XWV9ioSxofi77o56JusE=; b=YIJ99kLYDyqroGJIzUbpHzPHVX
	QsvSynFvH4MInjiyWyZHTn0Qd0cAeJ2P6DIiCx1h3g0xzP/5T7J9BSuXzuKCM+Ia
	v2OcmD2n36J/kgiOa95fuBHNJUUpF0BxdK/ZOpHl/vcNIFO224cgA6JLCZUw+0pV
	QoDd9wlfBiAY51lcpejIQpVJWb5IfEBxJ43C+IeK7pVMZHJv4RMnfg1LaY/fbOME
	MsxQAwoAuxr7uhhaWcbWg+7LGZQj4gUJZRQWo3BY/B76pfk03v8D1AfxkKRqj/zG
	dTFqvAjYl89iqOuXc2+VHrIiNalGMpfh5q73x3GnicCz7QRcIqHk2njeFFXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706300075; x=1706386475; bh=PTTnJNpgNLbDx/r8kMhAAD2XWV9i
	oSxofi77o56JusE=; b=vu2MCvLvQA8eiso83CL7hL5P4fRPHqqI2Ykvr+Ussytp
	2ydwGhRFwTs7/4Pj3EDqlwKqsHcPCNkL+CWMJtB/mVp1nVKQJBST/puHQPgAlbfP
	NNXHT8XC8Nc+Ej0fHR5NvCEDhiDlBh57a7G//Gc6q9hpDvkFyOPcVkYOl75WtSr7
	MP4X4vcySrf/ASU0iaZC0/wUFtaj/eD+jx3FSFr4U9cdfqkdKKnWMMuvoz/M2dSl
	IAwVPKzqvRXkBcvwVFRcP3Dxsn2fwkZkefnYxwsupJPm1VfYPaHLxA1K8wUVb2vJ
	H1FSCWH5og9QLRgQIUArNRbM5Vxrxvq4AUqSg754Vg==
X-ME-Sender: <xms:qxK0ZR55l5SvosYqT67ebLxU1n5YbOHtWRHRasdOu03z-Lw822UGoA>
    <xme:qxK0Ze6h7U5N2LrJdm4vOzCcwheJyTXrvta3jMpHxD0T8ne4rHC4EubKxTCRHF3Mq
    BZCz1UxPNn26rHbYvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefg
    udfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qxK0ZYcecr1D80HNjkZJ7FnKRcWIkR3t7-9r77lJWZk2ZBWOuY7aFw>
    <xmx:qxK0ZaK1W6z9GCC8FdIw_PC5SNS_mZaHKK49fz6j-br0rsFMnH-ZMw>
    <xmx:qxK0ZVKm1_ElaurtIU4NyxlTIe0C3Ia3rrm4FtZ4fhV0uOm66cEVLQ>
    <xmx:qxK0ZSBxnMQy-blz1558pEOaOeZvOacpVBhAOJSxpbcAaMwJhpUnCg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4C631B6008D; Fri, 26 Jan 2024 15:14:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c54d0ede-4f41-4fcf-8fe7-d3f9e1bb63a4@app.fastmail.com>
In-Reply-To: <e523b29c-0fd0-4b7c-bf8c-d3424ee2c031@efficios.com>
References: <e523b29c-0fd0-4b7c-bf8c-d3424ee2c031@efficios.com>
Date: Fri, 26 Jan 2024 21:14:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Matthew Wilcox" <willy@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-mm <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Russell King" <linux@armlinux.org.uk>
Subject: Re: [REGRESSION] v5.13: FS_DAX unavailable on 32-bit ARM
Content-Type: text/plain

On Fri, Jan 26, 2024, at 20:33, Mathieu Desnoyers wrote:
>
> A) I have prepared a patch series introducing cache_is_aliasing() with 
> new Kconfig
>     options:
>
>    * ARCH_HAS_CACHE_ALIASING
>    * ARCH_HAS_CACHE_ALIASING_DYNAMIC
>
> and implemented it for all architectures. The "DYNAMIC" implementation
> implements cache_is_aliasing() as a runtime check, which is what is needed
> on architectures like 32-bit ARM.
>
> With this we can basically narrow down the list of architectures which are
> unsupported by DAX to those which are really affected, without actually solving
> the issue for architectures with virtually aliased dcaches.

The dynamic option should only be required when building for
ARMv6, which is really rare. On an ARMv7-only configuration,
we know that the dcache is non-aliasing, so the compile-time
check should be sufficient.

Even on ARMv6, this could be done as a compile-time choice
by platform, since we mostly know what the chips can do:
bcm2835, imx3, wm8750 and s3c64xx are non-aliasing because
they are limited to 16KB L1 caches, while omap2 and as2500
are aliasing with 32KB caches. With realview/integrator it
depends on the exact CPU that was installed.

     Arnd

