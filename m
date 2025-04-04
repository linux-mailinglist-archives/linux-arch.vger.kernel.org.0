Return-Path: <linux-arch+bounces-11273-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CABA7B775
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 07:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D857178DBE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 05:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D131662EF;
	Fri,  4 Apr 2025 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AsVS10ce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yj5o5bYT"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB61624DD;
	Fri,  4 Apr 2025 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743745408; cv=none; b=jMIh8KCZkWGeDD0HKDbkd7Ztf1eGyzdw7x0HZVNdug2eRBwgxRZIpb7Yof9odR+0bKjSCGcHCYEky3BUHGybGVvVq1BYD0dkCEt+PfYNuUGiMUHjRq0MnDfh/pdd0qeqK7aZkZD8xDWDda92kMjd2kqsd7r7lquzY3/XiXM6ifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743745408; c=relaxed/simple;
	bh=qQFF/NBDKdDQ32P98GoBbGcFJst3gasRnlt/QSB7pbE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q13C9SPKIeRS87fp+GP+jvRtNDT9o07A4rNS1iwXdDWh8tzwryF1WCR/GA76b+lsGUhqKuHkhAkZgoqx0v9JG7gWyyk+ffWS2/kGIfnSfoO+PxKZpGyIC3gwLHAQfLtjL7LdIzvZMQaXbVjSafhAZkUCneywr9zr8bIA057PuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AsVS10ce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yj5o5bYT; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EDFC2540178;
	Fri,  4 Apr 2025 01:43:24 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Fri, 04 Apr 2025 01:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743745404;
	 x=1743831804; bh=LCuXw9LIl6DwgqGPiNReP7BXBeSdI1Eyn50diesQm6s=; b=
	AsVS10cef0cf59Jd7pQumIsdrtQRdmCGQRSJu9VlycrcnFzGFEVId8sGAkMhzyRD
	LZ22MRe6xPxKi6n5BTAsSm2jJsjr8E0Ba7PDpeD3kJpTRaVlxo1BErDlTtHomqdD
	/19fwmXXGhwOusTp+a/nDxeCXsWuYC38eAQVqiuQ6raj09z0czWRrclWEhSVTJLD
	8/VVDobicF6PFLOrX2lZ8anmJrggo/CDwbmS8LZJlgAiTX3YZrwjgRSOpEn3tmgu
	gBiQsGvN6X3rHMwIskUbF2DILJNH+aIh39tQoe3qltRCbzqJILdPKIZ99TcGxpQW
	whX36viMS3oIHAzZm82Slw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743745404; x=1743831804; bh=L
	CuXw9LIl6DwgqGPiNReP7BXBeSdI1Eyn50diesQm6s=; b=Yj5o5bYTIVdcpfUha
	Cnpkm5RWLsR0L7RAxO433OjqImSSBMu5aPPelMPFaHfGlSEomirpChLqCSp0SB9j
	m5vEFed4fEdfPgxLh7OG+yItunbirMiJGDDDpZlVwJUGO4PjjfH6bgCGMgN++0iq
	vxHhzkL9gVN3ebSBh+gRBJwJ1XZMdyfPI4UMhsCPvbNxJJ6hdVNksaym+ImBXLdq
	Bf74eE9K61WQGvDTAhPD5l1/Ho6lR1JMfri4xon63PDEVNSleB2Ljc5efl+LQ2EH
	YOEDAmBADP/MqDI9o1Uk8UzNSFFaLHlC1/sXjfy4NUpW/8Yj9TiraNTdWnAYi8v6
	lWn+Q==
X-ME-Sender: <xms:e3HvZ76SxLg1rBu3YdACOaqy-HTL1y7njmJKXbF1nvzTJg0dgtpQrw>
    <xme:e3HvZw5Lp5rgALjehglB-nValKHg9c51PT_5_dGeqZaeJhh86wzFB-hq8kb7OAAG1
    jXVyfddoPKW7VhHfOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffhteetheeuhffgteeghfdt
    ueefudeuleetgfehtdejieffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnih
    gvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopeihuhhrhidrnhhorhho
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehirhhoghgvrhhssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnh
    drhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhgrtghosgdrvgdrkhgv
    lhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:e3HvZyfh8XL3pbftiatpqMEYP0e6fRFb846kVK0LtewGQOl0U8X4dQ>
    <xmx:e3HvZ8JTHehgvno3DGBZfrBMKXTHC75kQPtSeFm2VI2rdOzdfja6sA>
    <xmx:e3HvZ_K52Ny0vBwh4_yLwR5d-Una6FwD7uO2XDp5h_x3n5CIId7o7A>
    <xmx:e3HvZ1w0VYc5e6OWEAx_7bXItkYEPEl9_X5oPlc6PEdItD8-D8TFyw>
    <xmx:fHHvZznnM-PSMgKZAd_xXLk8i3m6InLreV1LxynEIBcb5rSjxkzEaqru>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2F4852220073; Fri,  4 Apr 2025 01:43:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tbabee1c6d5c86beb
Date: Fri, 04 Apr 2025 07:43:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ian Rogers" <irogers@google.com>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Jakub Kicinski" <kuba@kernel.org>,
 "Jacob Keller" <jacob.e.keller@intel.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <48a734d3-0920-402c-afab-f4f205cd6b0d@app.fastmail.com>
In-Reply-To: <20250403165702.396388-4-irogers@google.com>
References: <20250403165702.396388-1-irogers@google.com>
 <20250403165702.396388-4-irogers@google.com>
Subject: Re: [PATCH v1 3/5] bitops: Silence a clang -Wshorten-64-to-32 warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Apr 3, 2025, at 18:57, Ian Rogers wrote:
> The clang warning -Wshorten-64-to-32 can be useful to catch
> inadvertent truncation. In some instances this truncation can lead to
> changing the sign of a result, for example, truncation to return an
> int to fit a sort routine. Silence the warning by making the implicit
> truncation explicit.

The fls64() function only seems to deal with unsigned values, so
I don't see how it would change the sign.

> diff --git a/include/asm-generic/bitops/fls64.h 
> b/include/asm-generic/bitops/fls64.h
> index 866f2b2304ff..9ad3ff12f454 100644
> --- a/include/asm-generic/bitops/fls64.h
> +++ b/include/asm-generic/bitops/fls64.h
> @@ -21,7 +21,7 @@ static __always_inline int fls64(__u64 x)
>  	__u32 h = x >> 32;
>  	if (h)
>  		return fls(h) + 32;
> -	return fls(x);
> +	return fls((__u32)x);
>  }

Maybe this would be clearer with an explicit upper_32_bits()/
lower_32_bits() instead of the cast and the shift?

      Arnd

