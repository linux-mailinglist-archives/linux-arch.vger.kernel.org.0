Return-Path: <linux-arch+bounces-6124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444FB94C873
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 04:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCF8280CD0
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2E171AF;
	Fri,  9 Aug 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKaWvUP+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBCC11CA0;
	Fri,  9 Aug 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723170254; cv=none; b=rcavAV/HxHaRlMZB/K9gN27K+y8C8qql+R6MjoMeNcrwRNOnvKpy5/F4WqhGCYe+uCWm3dGvAIesC9YkpZfXzA0p/LLdNTzJjD4VLtExNv4nr9kT0XoR8sgW9p8IcvIFRPq3nW3/SHNiNhTSRxSLiVHb0mpnYwb3jsa9N5UrPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723170254; c=relaxed/simple;
	bh=a4NH/DyOZYr+hQdPVdV/xn3d1kqB1GhzzrD+9MYKuho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAQReQjed2MaNUAAQRcVm6y66OwGRzyymcG6Qb9zr9ZZFX4kE1TT1jAN9SqZZ2+42YHNMH3uT6XJ8ukEJ/sVR7sXLpx1LJxo7hfVX5MpfCHhttjrDm8OyRoaK5loHbvs9vo3NrDSSo55k/zFpEsnHLaKL0ss45CzrxgVgX4e9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKaWvUP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C56DC32782;
	Fri,  9 Aug 2024 02:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723170253;
	bh=a4NH/DyOZYr+hQdPVdV/xn3d1kqB1GhzzrD+9MYKuho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vKaWvUP+gW8ZxGS17B65tL1nrDAvJqciL9lSUQksuPZ4Iy4KhEGJQGOpNkkXmO+kV
	 pkdaDInHp2dgMHzollw10zS4gIySrBFG6IgrrwYHj8LsAscwBWBwWjLcNHYy5tTzNE
	 KSKa+C7m9EwkOjuzA8zG5VWtu7bn8KHoTxxNt5UYMtqglx1DnjyChjgN286dWqm0WA
	 rT4bNmb9sUeUr0tdrbHNHwMsbmKPhEiAz7/jK5pb3Y5hSQ728/DeRHxDA8I+BOaR8Y
	 khTAMu7d9Hv788u9Zd01H6xUkCZfx7Afr0wMZbiiN0Z1P7b+nVi/ftr6us3vFG5KWz
	 4W9X6eOb829Uw==
Date: Thu, 8 Aug 2024 19:24:10 -0700
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
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240808192410.37a49724@kernel.org>
In-Reply-To: <CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
	<20240805212536.2172174-8-almasrymina@google.com>
	<20240806135924.5bb65ec7@kernel.org>
	<CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 16:36:24 -0400 Mina Almasry wrote:
> > How do you know that the driver:
> >  - supports net_iov at all (let's not make implicit assumptions based
> >    on presence of queue API);
> >  - supports net_iov in current configuration (eg header-data split is
> >    enabled)
> >  - supports net_iov for _this_ pool (all drivers must have separate
> >    buffer pools for headers and data for this to work, some will use
> >    page pool for both)
> >
> > What comes to mind is adding an "I can gobble up net_iovs from this
> > pool" flag in page pool params (the struct that comes from the driver),  
> 
> This already sorta exists in the current iteration, although maybe in
> an implicit way. As written, drivers need to set params.queue,
> otherwise core will not attempt to grab the mp information from
> params.queue. A driver can set params.queue for its data pages pool
> and not set it for the headers pool. AFAICT that deals with all 3
> issues you present above.
> 
> The awkward part is if params.queue starts getting used for other
> reasons rather than passing mp configuration, but as of today that's
> not the case so I didn't add the secondary flag. If you want a second
> flag to be added preemptively, I can do that, no problem. Can you
> confirm params.queue is not good enough?

I'd prefer a flag. The setting queue in a param struct is not a good
API for conveying that the page pool is for netmem payloads only.

> > and then on the installation path we can check if after queue reset
> > the refcount of the binding has increased. If it did - driver has
> > created a pool as we expected, otherwise - fail, something must be off.
> > Maybe that's a bit hacky?  
> 
> What's missing is for core to check at binding time that the driver
> supports net_iov. I had relied on the implicit presence of the
> queue-API.
> 
> What you're proposing works, but AFAICT it's quite hacky, yes. I
> basically need to ASSERT_RTNL in net_devmem_binding_get() to ensure
> nothing can increment the refcount while the binding is happening so
> that the refcount check is valid.

True. Shooting from the hip, but we could walk the page pools of the
netdev and find the one that has the right mp installed, and matches
queue? The page pools are on a list hooked up to the netdev, trivial
to walk.

> I think a less hacky approach is to add a function to the queue-API
> like ndo_queue_supported_features(), which lets the driver declare
> that it supports net_iov at a given rx queue. However I'm open to both
> approaches. What do you prefer?

I kinda like trying to query the page pools more, because it's both
fewer driver changes, and it actually validates that the driver did 
the right thing based on outcomes. Driver callback may have bugs.

If you prefer strongly - fine, but hm.

