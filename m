Return-Path: <linux-arch+bounces-6163-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7665294F625
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4091C21B29
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43129189518;
	Mon, 12 Aug 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9pSXQbI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE913A3F2;
	Mon, 12 Aug 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485456; cv=none; b=LBhpTtMbWfM2vQeCTBAWP9/lwHB2GxkSFngMO70cJnRmmTabkwCR6B5jG/6dFSJ3nlZU5L8FnNuMBEU9cDYZBROWjxf9tIsc+QHmQ5+Ucwj9vaqKBevzTPyZ+3hjzLt079lfERf2fTJEkWkD8e9Q1YHd1ACXr5eYdnitT6HBKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485456; c=relaxed/simple;
	bh=PjEd0BdogsUTaZfCUMRZ31Ra4P2TNDube5tSGJ9f9sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MloUkPoBGISIjK0uzF5sGypuqpOgnLmJKvGEYPxG7r3O+Yyzvt9nO3F3IfA1DmfB1LZnnfV2AkQ/cyT9F4blXzmQh8LplYDgUphOqchY4/684dZP101Eho8QCcO4oktwK4H5E7CZnzdJjPEiBLX/hS4TaJgsx1+Dmdwyb9BipeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9pSXQbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E1DC32782;
	Mon, 12 Aug 2024 17:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723485455;
	bh=PjEd0BdogsUTaZfCUMRZ31Ra4P2TNDube5tSGJ9f9sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G9pSXQbIwNKKdmOVG04ccy/1dIHLraWQ0G+g5z/MctkmVUUUXo81tnVQfF1RR+c1J
	 Cvxt8qGSPA8JqYgFK4Wsisbb0RFx5KEJ2r00aZDsq7jtURbAetSPgcZbzv7tLhq3In
	 X8cW65UhPResK30p4YVjVef/gIBciCKXIICBbwOv+MOkXOxEPR0kGDviaLOmGrQHjv
	 1kVsTsVsho3L4Id+uxmWhHD1b/Ou3noRjVmbmLBl93blSGZxY3SAluidKUwiBL8YOv
	 TqI1IrR/S8Qznu2rcbJ2YiWkSSF8CbSPSyNf8gpJaBr19k4+X1N8VCNVUteNnwEgHU
	 0shtOIic2eEhw==
Date: Mon, 12 Aug 2024 10:57:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge
 Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Steffen
 Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, Shailend
 Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240812105732.5d2845e4@kernel.org>
In-Reply-To: <48f3a61f-9e04-4755-b50c-8fae6e6112eb@gmail.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
	<20240805212536.2172174-8-almasrymina@google.com>
	<20240806135924.5bb65ec7@kernel.org>
	<CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
	<20240808192410.37a49724@kernel.org>
	<CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
	<fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com>
	<20240809205236.77c959b0@kernel.org>
	<CAHS8izOXwZS-8sfvn3DuT1XWhjc--7-ZLjr8rMn1XHr5F+ckbA@mail.gmail.com>
	<48f3a61f-9e04-4755-b50c-8fae6e6112eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 22:51:13 +0100 Pavel Begunkov wrote:
> > I think we're talking about 2 slightly different flags, AFAIU.>
> > Pavel and I are suggesting the driver reports "I support memory
> > providers" directly to core (via the queue-api or what not), and we
> > check that flag directly in netdev_rx_queue_restart(), and fail
> > immediately if the support is not there.  
> 
> I might've misread Jakub, but yes, I believe it's different. It'd
> communicate about support for providers to upper layers, so we can
> fail even before attempting to allocate a new queue and init a
> page pool.

Got it. Since allocating memory happens before stopping traffic
I think it's acceptable to stick to a single flag.

> > Jakub is suggesting a page_pool_params flag which lets the driver
> > report "I support memory providers". If the driver doesn't support it
> > but core is trying to configure that, then the page_pool_create will
> > fail, which will cause the queue API operation
> > (ndo_queue_alloc_mem_alloc) to fail, which causes
> > netdev_rx_queue_restart() to fail.  
> 
> And I'm not against this way either if we explicitly get an error
> back instead of trying to figure it out post-factum like by
> checking the references and possibly reverting the allocation.
> Maybe that's where I was confused, and that refcount thing was
> suggested as a WARN_ONCE?

Yup, the refcount (now: check of the page pool list) was meant
as a WARN_ONCE() to catch bad drivers.

> FWIW, I think it warrants two flags. The first saying that the
> driver supports providers at all:
> 
> page_pool_init() {
> 	if (rxq->mp_params)
> 		if (!(flags & PP_PROVIDERS_SUPPORTED))
> 			goto fail;
> }
> 
> And the second telling whether the driver wants to install
> providers for this particular page pool, so if there is a
> separate pool for headers we can set it with plain old kernel
> pages.

The implementation of the queue API should be resilient against
failures in alloc, and not being MP capable is just a form of 
alloc failure. I don't see the upside of double-flag. 

> payload_pool = page_pool_create(rqx, PP_PROVIDERS_SUPPORTED);
> header_pool = page_pool_create(rqx, PP_PROVIDERS_SUPPORTED |
>                                      PP_IGNORE_PROVIDERS);

Also don't see the upside of the explicit "non-capable" flag,
but I haven't thought of that. Is there any use?

One important note. The flag should not be tied to memory providers
but rather to netmem, IOW unreadable memory. MP is an internal detail,
the important fact from the driver-facing API perspective is that the
driver doesn't need struct pages.

> (or invert the flag). That's assuming page_pool_params::queue is
> a generic thing and we don't want to draw equivalence between
> it and memory providers.

