Return-Path: <linux-arch+bounces-12418-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91FAE1EE9
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA676A191A
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6551C19A297;
	Fri, 20 Jun 2025 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y1VuXv0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WqDOrA1+"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC222D29CF
	for <linux-arch@vger.kernel.org>; Fri, 20 Jun 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433710; cv=none; b=Rx+SP4DXp2Hj4O97fvNO16gkaiHLYRIy1payFljYUx7sziUiRu64G8OX6HQ4nafCvpkB691evyW3LevvR37EWR9rom0vPKstBX8sudbQFWFE1PneGIctikcVkZqfxZsU0J0NQ059oNx2Yp3QKpuz2Rh+qAt/YqyyCwrhzlSGwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433710; c=relaxed/simple;
	bh=58dUD4BofK8DLHehCtX2Jul+ZV9mxcf+lfaiGNGds+A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Zi+ppWkWVYYgx+LADRqiaFowpmEmXDbpN499yMAyx9BsnwvX98HKULuwWHhzfYt8VXAUoOCfjU78pLeHPd/aRjVoT254x+OyzOwvN6MvKAk5dMolWRIJYPbfFyAj+JaCGnddPdr3aoN+fOrZvrBSnIao2DHXvjTsojW/gdeZFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y1VuXv0X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WqDOrA1+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FF5C254012B;
	Fri, 20 Jun 2025 11:35:03 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 20 Jun 2025 11:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750433703;
	 x=1750520103; bh=58dUD4BofK8DLHehCtX2Jul+ZV9mxcf+lfaiGNGds+A=; b=
	Y1VuXv0X2z5jalE2SMB1ekQUXO5Fc+Dp8kCSD+rxiDyLHvAxQBbxoagItPwg+iq+
	e0PY2vrcWPbJZaJlN2eNRl5NOVZJMYdtYWRhSwfKaApN/tv6jWj1ObKnUJ2AIIPG
	w6YgeUB96y8tnR0F5OiZfXetfIcXzSwR/Em0a3L9e46vJu6gdB9XU4pZOBfeqTqs
	ZKwxXNl3+Rg13iwo83EbgGTABqLWMsbUZndsctruOGGSzLBoAwuaLkL/AU/R1+0V
	gZaB8ANHJMIX2ivPJbm7p1AIYqGAapJwgPM5ZEQeaxeNH0VgG5mSEsnGKVfplHFI
	cwVMzWTZUDLTVfFTD5BJeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750433703; x=
	1750520103; bh=58dUD4BofK8DLHehCtX2Jul+ZV9mxcf+lfaiGNGds+A=; b=W
	qDOrA1+jGb7E4LP9d4LISQNnp+TPxpSXh5rH7dh2mpAqOq+p0qR/NVY0LIHhh38g
	0DWEJ87ktpO/1MelxnvWpaDLeq3kX6Aib0uICmfYbt8jB/MkUnDTtY3QvxAxxKUl
	qHggHX7NQ6389Owo5ftEvzPIcrPjn31FRTmhVxUkD/Anc/1Xz0OCPJ2S76oMdzmb
	iUzpEe9pDlK6joTGXEdh8nxVmE+MJG1k5075PQE3wMNibnsgsJrxN89H2akpqWmn
	TGP7yc90MpemC2wnUf0G3qmCueNh6X3I4o9m58hzWXQb0v/ERwxn8l5EdlJPj7vp
	bx5Xr97ZlJZ2AwF8uQUYg==
X-ME-Sender: <xms:p39VaId3zE5yyoqFaBgcXiwYJwzwXYfUrcCg4S-CA2XELBQgZPOI9A>
    <xme:p39VaKNK3MpB0jDJxYj5ZxwfC5f08xVzGbM09mAem7qOpnb4Et36eCQBUN2_l-_Ci
    qLeSQqOgJLkPFPWS_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:p39VaJiRfmpXY_ch_J47AMWz9HThasA_jgI3upsMkjXiMI1FxxlO5Q>
    <xmx:p39VaN_5tVvIc_57Lxm--Y-JlvM5qCntXEl8Co3JCZWi-NRjDCDTEg>
    <xmx:p39VaEuC0YJXnMG5nI_EVSMAn4PXOtgRj3yUiYRJtL0Y4rrxW3kPNw>
    <xmx:p39VaEF4TpbXr0g7YDtGw0ogtwQ0u4v37RL6KWizW-fwJz9yfwCONg>
    <xmx:p39VaCiX-1Cm8rLl1QiBZnWJGk7qET7SgbDIun-Itb8hsCxK85alFZWr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 24A4A700062; Fri, 20 Jun 2025 11:35:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Te868297d6d9fe9f2
Date: Fri, 20 Jun 2025 17:34:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 Linux-Arch <linux-arch@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <01b26ddb-0507-4f23-ba66-fc88413f2514@app.fastmail.com>
In-Reply-To: <20241202040406.GC933328@ZenIV>
References: <20241202040207.GM3387508@ZenIV> <20241202040406.GC933328@ZenIV>
Subject: Re: [PATCH 3/3] loongarch, um, xtensa: get rid of generated
 arch/$ARCH/include/asm/param.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 2, 2024, at 05:04, Al Viro wrote:
> For loongarch and xtensa that gets them to do what x86 et.al. are
> doing - have asm/param.h resolve to uapi variant, which is generated
> by mandatory-y += param.h and contains exact same include.
>
> On um it will resolve to x86 uapi variant instead, which also contains
> the same include (um doesn't have uapi headers, but it does build the
> host ones).
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

