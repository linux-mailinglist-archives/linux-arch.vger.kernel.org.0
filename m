Return-Path: <linux-arch+bounces-6064-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BD3949959
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 22:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2652428782E
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 20:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F70E16E886;
	Tue,  6 Aug 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8zSpgND"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0416D9DC;
	Tue,  6 Aug 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976978; cv=none; b=sLlfVW/1PTmT87cGOdjTbLrbKTYtkPBEnwkc3IXyWc87c8VOeC8x9T/W0R+M9Xvls53rOY2edB6MLg1Euv7PMMNW6pf1zCsk6CushhntWuNlNKvb49ZBnuKxALsjfIRjN7qGBu2LdFZCu1kioiIDACFfLSwOl1IG05zqPaMnr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976978; c=relaxed/simple;
	bh=DaWt36xVGk9LrklCuq9Y0WSIGFkdQ2NrucnH139qhVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WirFopVNhzVmvlENe3gj+ukigyCMyU+eTnnFh7do3IeovVtnotkk4ABiSaXdVx04XhKYqX6jFoON5OEZs+g4ofvfpay9FeYPK04UiaheniwcPJ5zpT0PUvFp8bBCvbyKeuk2PBng6bbBO8tiA9SAbNlbU/S0CxiYeaqKm/wp+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8zSpgND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D02C4AF0C;
	Tue,  6 Aug 2024 20:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976977;
	bh=DaWt36xVGk9LrklCuq9Y0WSIGFkdQ2NrucnH139qhVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R8zSpgNDpucslJ9LhHrQaMFd6aOxtjVFNEMk72wbX0BbIXsv1hWz5ikW325uy5hAX
	 b9LL2LirkHn6itCJ2gENxcbo+u4UY28lITGzhQfEk1w1qEblRxpxf0KGH1/tbuIFIj
	 B8qkvfb7eya3zycothhbQgRmzJoqJYIYuDVblJoKiRyk0ezPjDEnOEkIikiLyOw4lM
	 MbQ3rHHYOVNtFYvjsXeFob26WqDOEfua5n4XkL1yftJAKY+pZysVkedFwKlNtoxU6l
	 cOWmdEg7sfcXdnL031h9LxhlO28iHpjp8CJWr3VjvOUXn96T6a+mmquVofe/a0KqTO
	 /FAxA9i1hII4w==
Date: Tue, 6 Aug 2024 13:42:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v18 05/14] page_pool: move dmaddr helpers to .c
 file
Message-ID: <20240806134254.265e2bfb@kernel.org>
In-Reply-To: <20240805212536.2172174-6-almasrymina@google.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
	<20240805212536.2172174-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 21:25:18 +0000 Mina Almasry wrote:
> +dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
> +{
> +	struct page *page = netmem_to_page(netmem);
> +
> +	dma_addr_t ret = page->dma_addr;
> +
> +	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
> +		ret <<= PAGE_SHIFT;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(page_pool_get_dma_addr_netmem);

Get should stay in the header.

> +bool page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr)
> +{
> +	struct page *page = netmem_to_page(netmem);
> +
> +	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
> +		page->dma_addr = addr >> PAGE_SHIFT;
> +
> +		/* We assume page alignment to shave off bottom bits,
> +		 * if this "compression" doesn't work we need to drop.
> +		 */
> +		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
> +	}
> +
> +	page->dma_addr = addr;
> +	return false;
> +}
> +EXPORT_SYMBOL(page_pool_set_dma_addr_netmem);

Set should not be in the public (include/linux) header at all,
and should not be exported. net/core/page_pool_priv.h already
exists. Feel free to break this out of the series.

