Return-Path: <linux-arch+bounces-6344-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA1957826
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 00:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4FF286EBE
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 22:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674FB1DD3B4;
	Mon, 19 Aug 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+425N8/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85B1591FC;
	Mon, 19 Aug 2024 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107981; cv=none; b=WTjx6jglKxA5EMcFDBvKwFdOr9zHpKrapdYdiU8ao8EK3zLzCneYBohg08+hVf2GKP4+awqfokCiWvGlzKwhwpZ+SBzygKScygvCvJe7hn+HDcnU1HM/wKWIQVH7RWTHvmDbP2mLEz50dHVyUwT/QzxNrYMWIAygT11TQTGXphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107981; c=relaxed/simple;
	bh=z8tvJ/r+K51rMUGiQ7v/KfC1hjjU9qrDmdqSPzMw1FI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mizGuU0pMncf4Y9aERIHL8SyGiEHtxD9pF6nJ0iOOgMEYEFbg4Q2taJXtxr5f1pi8/JZiNZ6WJDo1jn0N71wS6n+oxySy0FQCFzgFU+iDueK8yULzrlQpHpQvCaACAX21w+pCh4GjbFD0Iv7M0rQDIjn5Ep21VShPlj2vH1kNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+425N8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ED0C4AF12;
	Mon, 19 Aug 2024 22:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724107980;
	bh=z8tvJ/r+K51rMUGiQ7v/KfC1hjjU9qrDmdqSPzMw1FI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X+425N8/0Z0g9jYHaBI4EUs6dVJXQlWC758nv9kpCZbKzTDNb6P2p1FPy3r+7duwl
	 u68IWRgnb7ZJcMUYHFffZJJaJTZr9bP2leFUXp0TPrhzWj73LiizT6k1B46np7glzU
	 6kCHjT0/sKrazot7Ln9ZOyLLWfEErLTDlhRUia0WS07ZOowAWukzj3LBM4ZhRXBn4t
	 nO8e1WKgWHjK1k//RopJ63LkktIInRVyYi9Q+cS5CAvyy/hNwl7zTUj4idOxU8s5KN
	 cUZuIwNxTEg4dS+POUv9Q+Tsy6hoBuKT58z5QH6U5BXP+rLKPZJxm066BR2w0ssGPV
	 8p8UNW1SqEHtg==
Date: Mon, 19 Aug 2024 15:52:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, Shailend
 Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v19 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240819155257.1148e869@kernel.org>
In-Reply-To: <CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
References: <20240813211317.3381180-4-almasrymina@google.com>
	<CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 00:44:27 +0900 Taehee Yoo wrote:
> > @@ -9537,6 +9540,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
> >                         NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the same time");
> >                         return -EEXIST;
> >                 }
> > +               if (dev_get_max_mp_channel(dev) != -1) {
> > +                       NL_SET_ERR_MSG(extack, "XDP can't be installed on a netdev using memory providers");
> > +                       return -EINVAL;
> > +               }  
> 
> Should we consider virtual interfaces like bonding, bridge, etc?
> Virtual interfaces as an upper interface of physical interfaces can
> still install XDP prog.
> 
> # ip link add bond0 type bond
> # ip link set eth0 master bond0
> # ip link set bond0 xdp pin /sys/fs/bpf/x/y
> and
> # ip link set bond0 xdpgeneric pin /sys/fs/bpf/x/y
> 
> All virtual interfaces can install generic XDP prog.
> The bonding interface can install native XDP prog.

Good point. We may need some common helpers to place the checks for XDP.
They are spread all over the place now.

