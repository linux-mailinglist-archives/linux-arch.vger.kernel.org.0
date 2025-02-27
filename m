Return-Path: <linux-arch+bounces-10424-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39AA47E77
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 14:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CC73A9207
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C43122F174;
	Thu, 27 Feb 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dpw3udR3"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3111EB5ED;
	Thu, 27 Feb 2025 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661469; cv=none; b=C5ITfpT4jcwVHPphaBwnLNLxsBkWZHknJf27p7kLafZYNzsQER/8cbATXfJsQxWxRP/npSOGDLcCO5/bLgmvkUnLpvlmWGW3/ENqC6AsLofmqOyBFVXt0Ajxu0L+/fFxJjbo8K8zyDG/dLPRB0tDdypV7v1CnzhT1G7feaUyEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661469; c=relaxed/simple;
	bh=RhAn648KZjGR1zL9fk7lBgC1kuhesOSbeueMHlrV+FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3fhmBk9yNtZedd0uJfc6NMuRGpGM6oJBgaLn6l9YyJbMAPgyUga06ncKCQdauJ7mN5K9jc3/6wZd4tpACP54NvLTeDhZdJ4sfAKyhZ4b9DIjjshdPzL99wzFGw3EedNmfPBQQis/Uj4MELnRO0Ozx9ytmCHG+sOgLxtS5hvPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dpw3udR3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C4NTJOJ3dCAJ9+vpvzEprQrWJrpsHSJFBRqUQ8todYw=; b=Dpw3udR3BJAFq9SyV4WrEEtnAj
	4AK/f2BJmM2iCspBbFHcvyAYokish3HnL+MnOj7JlEsRpxTpwaGNuOZ0GjF1xl2kJOx4qt3J2ahuW
	az6fb102wILROrGzFvXwJPaH58zNpMOOcrCBc343TieQO3/CDGnn7X1+s/6kO95pgHKXAnEejIoZr
	eB7TVgWCB6dlZRGlAflwAymbuHq47SCX9B61CP43qWtZ2O6ijiX7nvvVtATjJJOXC5cOJJTTKtd0a
	0oXIb31u03yt/F+rw+NDupYNgVgy0IBHz3v3ZGkJAqcax4tYjHYegxiTUmQ4/XbT5eUfHjXU340Lp
	d0XLYfiw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tndYL-0000000Hb1D-0gW6;
	Thu, 27 Feb 2025 13:03:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 45472300472; Thu, 27 Feb 2025 14:03:47 +0100 (CET)
Date: Thu, 27 Feb 2025 14:03:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
	Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	iommu@lists.linux.dev, linux-mtd@lists.infradead.org
Subject: Re: [PATCH *-next 00/18] Remove weird and needless 'return' for void
 APIs
Message-ID: <20250227130347.GA5880@noisy.programming.kicks-ass.net>
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
 <46d17d84-5298-4460-96b0-9c62672167a0@icloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d17d84-5298-4460-96b0-9c62672167a0@icloud.com>

On Thu, Feb 27, 2025 at 08:48:19PM +0800, Zijun Hu wrote:
> On 2025/2/21 21:02, Zijun Hu wrote:
> > void api_func_a(...);
> > 
> > static inline void api_func_b(...)
> > {
> > 	return api_func_a(...);
> > }
> 
> The Usage : Return void function in void function
> 
> IMO, perhaps, the usage is not good since:
> 
> A) STD C does not like the usage, and i find GCC has no description
> about the usage.
>    C11/C17: 6.8.6.4 The return statement
>    "A return statement with an expression shall not appear in a
> function whose return type is void"

We really don't use STD C, the kernel is littered with extensions.

> B) According to discussion, the usage have function that return type
>    of the callee api_func_a() is monitored. but this function has below
> shortcoming as well:
> 
> the monitor is not needed if the caller api_func_b() is in the same
> module with the callee api_func_a(), otherwise, provided the callee is
> a API and provided by author of other module. the author needs to clean
> up lot of usages of the API if he/she changes the API's return type from
> void to any other type, so it is not nice to API provider.
> 
> C) perhaps, most ordinary developers don't known the function mentioned
>    by B), and also feel strange for the usage

It is quite common to do kernel wide updates using scripts / cocinelle.

If you have a specialization that wraps a function to fill out a default
value, then you want the return types to keep matching.

Ex.

return_type foo(type1 a1, type2 a2);

return_type my_foo(type1 a1)
{
	return foo(a1, value);
}

is a normal thing to do. The whole STD C cannot return void bollocks
breaks that when return_type := void, so in that regards I would call
this a STD C defect.

