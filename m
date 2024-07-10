Return-Path: <linux-arch+bounces-5359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE94592D995
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 21:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7470F1F22F87
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0FD19884B;
	Wed, 10 Jul 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi53vr1z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9119883B;
	Wed, 10 Jul 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641336; cv=none; b=YuIqkJ8P3ippsRKB6QKUbN1Fu5NyVpso04Z1TvEyyyhXlepZ2Uzippq/2ye+KloZdo7ZYzF+ovbSn2yHxfDEAdvwriNLQmyRvQ4/C+JaBdgLMzx0kqnpBhSQCJZoApxs5vUChcb3OfaXqVAn9RUkJmHdttMtBoblFVmP3Zi+WXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641336; c=relaxed/simple;
	bh=m6YJRUhJFp+I/9POpuBvwDiHuMwf1S6qPgk80cnGhLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwHcKb6n7xNLqXuMPof8E/vnNXqLyOA5h3Yw3UxUmuq73IPNGWWnwWoVHe12xQ8xFI65YscoYqFnzK19zwnO0C4zN093w0b510PAcnTIdS9R7Dz8ic3plSRHR4STVK1olk2LkU/kzBDIigPf+u1maD9Mq8FD8SPPdgMAnelogI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi53vr1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C4CC32781;
	Wed, 10 Jul 2024 19:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720641335;
	bh=m6YJRUhJFp+I/9POpuBvwDiHuMwf1S6qPgk80cnGhLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pi53vr1zI4Wks/2eTESosaaytYbnJD9ORg+iZn3xswrdEGtuLTa1eAmpA+XoMUmPE
	 OIKdzsnskRaE5w/dUcmpuj19h5wUm5soO6dasphhXnMnpjSqDUcBTaNrFDfULJxAB4
	 jTPMPee1sVnBxa6eE6wKPUMKGq8+OxITZmOBS8X9x3YNIxdrvhTwbGkZm5DEGK0EBZ
	 gpYTsiZPbYeJ3QT4F+0bIjGIuNg8MesGlFQ507Ea6945SYDMBHjd84paGHbGJfJWjB
	 k24VeKBn503ebkMeNYRgOL/8Oe3Igt3C7wga7w7aJbRCdrntWHnBTyydgKU3lK4l56
	 qew0lqYdiLNuQ==
Date: Wed, 10 Jul 2024 12:55:33 -0700
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
Subject: Re: [PATCH net-next v16 04/13] netdev: netdevice devmem allocator
Message-ID: <20240710125533.7a14bbe7@kernel.org>
In-Reply-To: <CAHS8izOoM3YfcQorLJXL4H+t2OL+oJ4fPP5ZBJRhnH5AxsUqfQ@mail.gmail.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-5-almasrymina@google.com>
	<20240710093624.26d22f02@kernel.org>
	<CAHS8izOoM3YfcQorLJXL4H+t2OL+oJ4fPP5ZBJRhnH5AxsUqfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jul 2024 12:29:58 -0700 Mina Almasry wrote:
> On Wed, Jul 10, 2024 at 9:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Wed, 10 Jul 2024 00:17:37 +0000 Mina Almasry wrote: =20
> > > +     net_devmem_dmabuf_binding_get(binding); =20
> >
> > Why does every iov need to hold a ref? pp holds a ref and does its own
> > accounting, so it won't disappear unless all the pages are returned. =20
>=20
> I guess it doesn't really need to, but this is the design/approach I
> went with, and I actually prefer it a bit. The design is borrowed from
> how struct dev_pagemap does this, IIRC. Every page allocated from the
> pgmap holds a reference to the pgmap to ensure the pgmap doesn't go
> away while some page that originated from it is out in the wild, and
> similarly I did so in the binding here.

Oh, you napi_pp_put_page() on the other end! I can see how that could
be fine.

> We could assume that the page_pool is accounting iovs for us, but that
> is not always true, right? page_pool_return_page() disconnects a
> netmem from the page_pool and AFAIU the page_pool can go away while
> there is such a netmem still in use in the net stack. Currently this
> can't happen with iovs because I currently don't support non-pp
> refcounting for iovs (so they're always recyclable), but you have a
> comment on the other patch asking why that works; depending on how we
> converge on that conversation, the details of how the pp refcounting
> could change.

Even then - we could take the ref as the page "leaks" out of the pool,
rather than doing it on the fast path, right? Or just BUG_ON() 'cause
that reference ain't coming back ;)

> It's nice to know that the binding refcounting will work regardless of
> the details of how the pp refcounting works. IMHO having the binding
> rely on the pp refcounting to ensure all the iovs are freed introduces
> some fragility.
>=20
> Additionally IMO the net_devmem_dmabuf_binding_get/put aren't so
> expensive to want to optimize out, right? The allocation is a slow
> path anyway and the fast path recycles netmem.

Yes, I should have read patch 10. I think it's avoidable :) but with
recycling it can indeed perform just fine (do you happen to have
recycling rate stats from prod runs?)

