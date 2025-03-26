Return-Path: <linux-arch+bounces-11147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C877A720B8
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 22:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA2317179F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 21:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1E253343;
	Wed, 26 Mar 2025 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FCeoOZI8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYpEqMwm"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76C217730;
	Wed, 26 Mar 2025 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024247; cv=none; b=E4fOuZY0z7gEfsUrleptIskpmLBT1A3jQAHj3oolK59ROiizIkrT3n/zetQTnOEplS0sOQbvJgIYpXmvWmWUO2W0UyaRWA+k6yCzaNyNL1YBwXGB+iw1+Kaa/wy7sTwTtN6ykVjP9n3PfZ8Sh11Ebub3tA7CI6lRN9fbHFoIAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024247; c=relaxed/simple;
	bh=0JkWBGZ00j7Ls6slQgmuH14VwkOMSTq76Ed2Lf3u9M8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CbBVc4p35Po4RbocTx+ojkVEhwrqiqVlEWvPH1WomoQjDz86w59ChDbiTxDZKTlTd9y5bPs88la2Q+PfVnqaMza2yq564oZgXwDcqMG8a+WZQ0jCoeP00IuADYqXAJFQAXVmBmW/xlNUyZIw+YSKHgElzmWyhyHRU70UWldUGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FCeoOZI8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYpEqMwm; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E52DF13833AD;
	Wed, 26 Mar 2025 17:24:03 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 17:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743024243;
	 x=1743110643; bh=bEzsl0sa8G46Ek7rDaFu7XORc3f6v2NQhtMZVs7Zce0=; b=
	FCeoOZI8Tlh3Bl2rYrg8ax0k9f3f8+fTLdUBNclQR7yMywIiHN2TuNY7ylXtVyBc
	O5D8nRBT5Yd6FL8maXKh+/MQeFLjaFfqLVaIaYamohD44NJqtgtVvxTOCoy/2cKT
	NYW6h1POZKGydBkmL9O87yPHLGYYJo5gDDegc585bevn5pCFLbErsMOvG6gAHMjA
	fyJ/jGA9m2+CUtVrOJ1UEh72SlMCt0kXdIq+3j/KHDvpsBfqpLmgB+IDlPuffMkt
	V6fDlmob2IcvQcXkaIKONuFBpGaMy+WApaRdcZbqmfmGsFrndiWNXTyQYScAA4uV
	q+MttADbq5LqJhbpYj3ERw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743024243; x=
	1743110643; bh=bEzsl0sa8G46Ek7rDaFu7XORc3f6v2NQhtMZVs7Zce0=; b=I
	YpEqMwmaHZX7IJdGqys5Py2gJzFa0e6EpKcVEUrANYa6g82OE9p4xivNV7FDsAgQ
	jiCKxFAuRTi9DLOJMN9ZAaOQg+2e8zZGcHgCSuBQuoFrmbBGjTkr9bw1uqHsurl3
	clMFNT77hwCDfhrLjnUeCc9rwpJ2CQmVWKFuZeoVquXzd0F7xtiCWsy1aKMjqtC7
	dqMmF65rTTsI2cVJrdD2N8hRck2ZZ3aATITrECmYSeUYpwxtH8mVpJt9GsRLyKDe
	KFS+HWbrlraAO+9vMQ4TJVlLqig+pGytyP4wpUNkbe/wAYeAbkmHiTwFOX5XdGEm
	+fLSYUd2p4yGoGO7b0GUQ==
X-ME-Sender: <xms:c3DkZ50rx1LK88T5gxrDla5Q3gxurtDbBx5t3WLDrE_Yama46gIEiw>
    <xme:c3DkZwG8rtLt1_GiKdTlVw6JqA2EfgJ8s60GJkiWWoQbLaR1yboSMSyq6yyR_Yfro
    gn9Ka0TqugqkS7LVDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegvlhhvvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrghnnhhh
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:c3DkZ55Km9e5cu5MkhHJYHcYs5d8PFOori-GvKPazzTsKGpucXCroQ>
    <xmx:c3DkZ20ltGT8YRqPtSd3iGJlFw6bpFGOIA5gR8LR6Y0hOpYRXT9cIQ>
    <xmx:c3DkZ8GhE_2yGDTCVZUjAJp2XNn9Cexa-F1lIewsVO6OtCE_xea_Xg>
    <xmx:c3DkZ3_hgWFn6EXGHzjsYO26682ogYpm-RdQrTn5FB1GCisPyZxGOw>
    <xmx:c3DkZxMrU6a39yXBuZshbFJS2PZQZ29OgMB-invRnqheF6Zfx5LYaZhi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76EC02220073; Wed, 26 Mar 2025 17:24:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4094621b06357a4d
Date: Wed, 26 Mar 2025 22:23:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jann Horn" <jannh@google.com>
Cc: "Marco Elver" <elver@google.com>, "Nathan Chancellor" <nathan@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <4b412238-b20a-4346-bf67-f31df0a9f259@app.fastmail.com>
In-Reply-To: <20250326-rwaat-fix-v1-1-600f411eaf23@google.com>
References: <20250326-rwaat-fix-v1-1-600f411eaf23@google.com>
Subject: Re: [PATCH] rwonce: fix crash by removing READ_ONCE() for unaligned read
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 26, 2025, at 22:04, Jann Horn wrote:
> When arm64 is built with LTO, it upgrades READ_ONCE() to ldar / ldapr
> (load-acquire) to avoid issues that can be caused by the compiler
> optimizing away implicit address dependencies.
>
> Unlike plain loads, these load-acquire instructions actually require an
> aligned address.
>
> For now, fix it by removing the READ_ONCE() that the buggy commit
> introduced.
>
> Fixes: ece69af2ede1 ("rwonce: handle KCSAN like KASAN in read_word_at_a_time()")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/r/20250326203926.GA10484@ax162
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks for the quick fix!

I've applied this on top of the asm-generic branch, but I just sent
the pull request with the regression to Linus an hour ago.

I'll try to get a new pull request out tomorrow.

      Arnd

> ---
>  include/asm-generic/rwonce.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index e9f2b84d2338..52b969c7cef9 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -86,7 +86,12 @@ unsigned long read_word_at_a_time(const void *addr)
>  	kasan_check_read(addr, 1);
>  	kcsan_check_read(addr, 1);
> 
> -	return READ_ONCE(*(unsigned long *)addr);
> +	/*
> +	 * This load can race with concurrent stores to out-of-bounds memory,
> +	 * but READ_ONCE() can't be used because it requires higher alignment
> +	 * than plain loads in arm64 builds with LTO.
> +	 */
> +	return *(unsigned long *)addr;
>  }
> 
>  #endif /* __ASSEMBLY__ */
>
> ---
> base-commit: ece69af2ede103e190ffdfccd9f9ec850606ab5e
> change-id: 20250326-rwaat-fix-63d7557b3d88
>
> -- 
> Jann Horn <jannh@google.com>

