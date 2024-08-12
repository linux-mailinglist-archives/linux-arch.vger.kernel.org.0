Return-Path: <linux-arch+bounces-6168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5D294FA78
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 01:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDB128159D
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D9219A295;
	Mon, 12 Aug 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu7jc8ms"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC91804F;
	Mon, 12 Aug 2024 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723507032; cv=none; b=VXDGJ1080Bpq1HoMeJX0aDMLMvh2OEyrLEJPYi6G7+3onaI5edMxkDxIXu+Dl9umfkk9Pp3IeHdSEhpFJG/XteAxQhJ8yy77bl8jtnBuj0RMA3KfpbRO4HfGncf3wHnS1EYCavjkPG/4cw8lolTW6wPXlL3Wz7c8aZF6uyRGuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723507032; c=relaxed/simple;
	bh=Jr9ZiAeKQT2m5eKlEJkFL1K/dVRLIXlbe8RR0cKjDv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjNnPzye6aB/mJ1Dq+ppTkpeu4jB2DGvY7et1ZbsP2zXYk/8LibtFoCw9xWUf3OjOD6r40yGAB5JD4aWEyPjmwhqZwYBn/ya8+BsyILCKkbg8BV5nXp9pgoCKuxfG8OjrQBQ06JL3qhYuFnAcGOIKC3RbxCa5B7foEl7R9FYl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu7jc8ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2500C4AF0E;
	Mon, 12 Aug 2024 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723507031;
	bh=Jr9ZiAeKQT2m5eKlEJkFL1K/dVRLIXlbe8RR0cKjDv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yu7jc8msljkFCiQiwDF8/zfbezYJqanad92vT7bLx1dIuUShflvBssxWFPxEF/6Tn
	 Y6qZR26h6davxDADewPqVrDbdDczF8Qcfmj7XUmuNBVgamCljt10Aq6S9lIkNZrlTC
	 DI1MmuAnHiAfpgm3qDz7e1Bxg9pWMNEsq3xGTfFREDalBFadkOa+tffRzqkA0tT8uP
	 fY9gXJLt3AIpZK7oFuq6X15n6MRFUxghZeDdZK64myodmq9N2bG7na/OJa4W3FBwc+
	 VjF7d55qI3ua0l1zhG9f4oRBuranyt4ci5N38sYz5rLuG4RyFeUjSKg0qqpUAjLWuY
	 q9MRn2l+gjx0g==
Date: Mon, 12 Aug 2024 16:57:08 -0700
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
Message-ID: <20240812165708.33234ed6@kernel.org>
In-Reply-To: <a6747b29-ed79-49d4-9ffe-b62074db1e09@gmail.com>
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
	<20240812105732.5d2845e4@kernel.org>
	<CAHS8izPb51gvEHGHeQwWTs4YmimLLamau1c4j=Z4KGM8ZJrx5g@mail.gmail.com>
	<a6747b29-ed79-49d4-9ffe-b62074db1e09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 20:10:39 +0100 Pavel Begunkov wrote:
> > 1. Drivers need to be able to say "I support unreadable netmem".
> > Failure to report unreadable netmem support should cause the netlink
> > API to fail when the user tries to bind dmabuf/io uring memory.
> > 
> > 2. Drivers need to be able to say "I want a header pool (with readable
> > netmem)" or "I want a data pool (potentially with unreadable netmem)".
> > 
> > Pavel is suggesting implementing both of these in 2 different flags.
> > 
> > Jakub is suggesting implementing both with 1 flag which says "I can
> > support unreadable netmem for this pool" , and guarding against #1
> > with a refcount check to detect if a dmabuf pool should have been
> > created but wasn't.  
> 
> That would be iffy IIUC, but I think Jakub just explicitly said
> that the refcount trick was just for debugging purposes and not
> for gauging errors like "providers are not supported by the driver".
> 
> "Yup, the refcount (now: check of the page pool list) was meant
> as a WARN_ONCE() to catch bad drivers."

Sorry, insufficient caffeine level in the morning.
We can't WARN_ONCE(), indeed.

