Return-Path: <linux-arch+bounces-6065-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14A94997A
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 22:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628DEB22603
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 20:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3996156C7B;
	Tue,  6 Aug 2024 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJVWCQrD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71323824A0;
	Tue,  6 Aug 2024 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977231; cv=none; b=L2pZR7xdmQ/SlsSijflD3oQG60GcfUiaPziIOtNoBmy07XeYvsbPq4JQXRXweAZGh4EN6BOtk7s6o6Z3IdW5ARRZYeHuIEtc9ICpTvDOTo3ub+dXODCm6taOFAyloBIhanlkp+8DXvtw3p3b/bKwItFGlLdjB9WcYx1rXt8xKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977231; c=relaxed/simple;
	bh=HeETL+5tKib6MH9kgC1zObM+7LwAINK+PlEoC3/qshQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7odOjkYK48fg4ULfKk9HYnBNE8z92grOULOcONzpRUbTjqH4r1RjT2zgNblKRqkiYWhBFXtoMejeZm1gbVAn8U00x5KOALrFWzC5ZnqRZ8KjefqGexHABtzQGjXf7CyjheIDIL1iYdG6KF0Sv7q0Fo5diTdjJEORyN1HYzn/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJVWCQrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B60C32786;
	Tue,  6 Aug 2024 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722977231;
	bh=HeETL+5tKib6MH9kgC1zObM+7LwAINK+PlEoC3/qshQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lJVWCQrDDKbsQvjukGMXCuSF87yugWQc8eRoJZgUsHxBiA50NHj8igJpW3o7M3HHd
	 79C9gNRxH+J+CcZPmkDa6ukWiHoYcUVfbmRFRwyuvX1WclRmhh+y4UzX6VQhL3nTeM
	 R5p3AjzShDOAF6hUXR2mm53HqxfYWeM0k5C5K6MGIH2TebObE/cUAQ/Um0sdEaem6O
	 wzlLmeOb5IJqItDaMLMoLwbM9Tbh+li84r3/OKD9sPt8xZRQXHGP3i9fT2T/ZC9EEK
	 W8rDe8+o+cFBWwV+PlFV69qQChiCIaGXsfvDg4psTAABB1428TkKfvhRZiXunEebvX
	 7mVyWaxnYtF6A==
Date: Tue, 6 Aug 2024 13:47:08 -0700
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
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v18 04/14] netdev: netdevice devmem allocator
Message-ID: <20240806134708.0034c4b9@kernel.org>
In-Reply-To: <20240805212536.2172174-5-almasrymina@google.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
	<20240805212536.2172174-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 21:25:17 +0000 Mina Almasry wrote:
> +struct net_iov *
> +net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +	struct dmabuf_genpool_chunk_owner *owner;
> +	unsigned long dma_addr;
> +	struct net_iov *niov;
> +	ssize_t offset;
> +	ssize_t index;
> +
> +	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
> +					(void **)&owner);
> +	if (!dma_addr)
> +		return NULL;
> +
> +	offset = dma_addr - owner->base_dma_addr;
> +	index = offset / PAGE_SIZE;
> +	niov = &owner->niovs[index];
> +
> +	niov->dma_addr = 0;

Is the dma_addr not constant for a given niov for the entire lifetime
of the binding? Why flip it back and forth between its value and 0?

