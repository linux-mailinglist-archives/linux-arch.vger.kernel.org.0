Return-Path: <linux-arch+bounces-14560-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F13C3FB6E
	for <lists+linux-arch@lfdr.de>; Fri, 07 Nov 2025 12:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3DAC4E5C27
	for <lists+linux-arch@lfdr.de>; Fri,  7 Nov 2025 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6DD322DA8;
	Fri,  7 Nov 2025 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YSACZscg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M78qrt2s"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2632142A;
	Fri,  7 Nov 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514524; cv=none; b=ZEZKyBFgy18vTFFmucl2CQnLe6A1xRkXEDcjlZs5m6EOzzcErBmqXmm69tTJoKsDXqKtZp65Qp6VnzbA6t/mYs3S6GwWDipVsseqdfUFBhJSz7L5NMPkkBZ9nWDYGWuCbk8JOwZf/psvgLlXM9W3rHaYEHNf72O/srYRhx4oqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514524; c=relaxed/simple;
	bh=E59CfHEvJ/oc/cU+D6x+nlvvkQV90DmvV0eSp7RQzMA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hMv0j9wba6I6IN6z3qH04pYWgPm/VbgUCxKfBb0HuamzsFYOKQhMv5SwqMJjF7wCLMqaFo/iIYusIR4iUAl9LBUjjHI+d9/Qakp3bbEhs/p7vYJQR7ENvlYkrirsShODacqD/Y4xn4zvtyUJ0LNcEF19y/la1AZ0IFAY9VKrWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YSACZscg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M78qrt2s; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B7AD7A015E;
	Fri,  7 Nov 2025 06:22:00 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 06:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762514520;
	 x=1762600920; bh=eRKQkj5K280R3b/RrHon4pbe8I4h4CIdOkXCqLolvYs=; b=
	YSACZscgaAE6zaTDRz48k1SSNuohLiC/LIJS5vCBdwVEksiOAW9hXZRF9YX6UmW5
	e1SCmj1oD92HAJJsyUIv3JkIoM92HHeFXaBp+24wQZQNYRLuXzAaHfixwUKErGbw
	FIfagbU5Kw1TMnrK6Q7CAtijwz26zrD2rfNtuYzoNGG0Y4HsSaMJJt/iZGdeZkH4
	MJkK9l6OZKPZAizsgxO1byy0HCCKjowFCEWbYJPqhCFjnxZeCRl7qnzjr/jNm/+9
	Rzr4BbS0ZObMiZdn8VxnhFN0tl1GCeWZDeopmwP9abqn70Q9hGqlmv/Lt38qzW9Q
	TkhR5QsqiHjIv/xvIgDUvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762514520; x=
	1762600920; bh=eRKQkj5K280R3b/RrHon4pbe8I4h4CIdOkXCqLolvYs=; b=M
	78qrt2shsLedihBiftY2LhN7qRl3wauqxpz6V1CkKr57MzP6U24Mu1DI272vwvSk
	CNTOZLp4iF/ZayE5PmwqM9VJXRzpZlS8SmLvewp5tv8EHRGubiEVp6OCj0ff0CSz
	oB0r6FpY44INpIvbH7E+tK+0tHIUFl8dEaa38O6VAXjkCtxtyOmC2D67PB641O9m
	NUpkh17fFzY2fjD/6lgZMFd2vIhIGwPRs2wKzIjHOeYpnNeVzx8k5kIPpGCVZhjl
	YRa8TW8W8OgQ69+AwIDkcbxQq+DnM3S8GXATiWjk53HAeHlUlrCiGpjQ376uH6Yg
	wV+bUEV20AvgAYljOWmnw==
X-ME-Sender: <xms:V9YNaSK_IhghXN8L53jQ00QmzximYoN-NILgwl2B1FfeEXKzbE3v1Q>
    <xme:V9YNaU_BagkvJMrbkO8ExKZE6V8-kFozxPFI42YU-Sgi84cSRHnHVdADxRb89UMle
    h_HAFRcXvY84z4uQWG5sAnOWzqyWKprZtJcbXhq4G3Gwf8XM9TvWqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepkhgvvhhinhdrsghrohgushhkhiesrghrmhdrtghomhdprhgtphhtth
    hopehvihhshhgrlhdrmhhoohhlrgesghhmrghilhdrtghomhdprhgtphhtthhopegthhgv
    nhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmse
    hkvhgrtghkrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopegthhgvnhhhuhgrtggriheslhhoohhnghhsohhnrd
    gtnhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhig
    qdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:V9YNaRYqUYbviFtiweRkZtz2Jet6HeK2Pg0GbaBrbRsG_Ey09fAAnA>
    <xmx:V9YNaY1lSA4xcLi1JpSVQ11yzMt7p-rLc7fXkSjzve4S1rkDKKG3lg>
    <xmx:V9YNaUrnEs1k8ksUNkA3ulWIEYfix-yWovCRmJvhyq7RCrVvTbKe7Q>
    <xmx:V9YNaXPd3CiHNXZlRjiZFuUJmWIPORoJpMgZ9tAEE3GQP6ao3JLX4A>
    <xmx:WNYNabx21bZOZhiGnjTHPd7M0uPDhPXMxH0KxkFquw05Yb-X4GzEwMqX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3322B700054; Fri,  7 Nov 2025 06:21:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvUhhSuyoH3V
Date: Fri, 07 Nov 2025 12:21:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Vishal Moola" <vishal.moola@gmail.com>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>, "Jan Kara" <jack@suse.cz>,
 linux-mm@kvack.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <0fbcde0d-4fed-4aa6-b0bf-c4400b9b1cf5@app.fastmail.com>
In-Reply-To: <20251107095922.3106390-1-chenhuacai@loongson.cn>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*() about
 HIGHMEM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 7, 2025, at 10:59, Huacai Chen wrote:
> __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> as follows:
>
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
>
> There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> explicitly.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> Resend because the lines begin with # was eaten by git.

Thanks for your patch, this is an area I've also started
looking at, with the intention to reduce the references
to __GFO_HIGHMEM to the minimum we need for supporting the
remaining platforms that need to use highmem somewhere.

I'm not sure what the reason is for your patch, I assume
this is meant purely as a cleanup, correct? Are you looking
at a wider set of related cleanups, or did you just notice
this one instance?

Note that for the moment, the 32-bit arm __pte_alloc_one() function
still passes __GFP_HIGHMEM when CONFIG_HIGHPTE is set, though
I would like to remove that code path. Unless we remove
that at the same time, this should probably be explained in your
patch description.

      Arnd

