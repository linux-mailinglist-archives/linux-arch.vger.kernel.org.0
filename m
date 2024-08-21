Return-Path: <linux-arch+bounces-6446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3E695A7CA
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 00:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538A1284805
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09F317B402;
	Wed, 21 Aug 2024 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVNyim/9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C021741FA;
	Wed, 21 Aug 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724279453; cv=none; b=Vrt0mqDIJj8B+Awa+aCpMwEjxA3v9e1OwYSRCUOoxTfjrm5eqhIUjpE4xBOt3+6lMIcCm4b9bo7XZlF2AOofk99Ub19l8P3BOtp6yCxHFJ+JxahDAiIKIp8EiG0E2xL0IKrAnTWKMbPHGRcZi6JBbgulX8BjjF/ojjNXHWc7xCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724279453; c=relaxed/simple;
	bh=9hM1UR02IR6WK1n9AY+5U6wjkUWO6iL3GULiEkR+LAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNeqkwswVl2P61ppsCEUWm5Xh+6y1XmmAUTsOIBYxKin3QNz9TGv8hWp1yfm6OKv8uTQDAv7z/4b/HfFCtKi9T1Hpt+vw7GJ43l4mv5sPefkyHh5cow2E0J+hPqdV8w/ZIHvlX3VVxvNCDJ3TjKH6w6winoVB9VzmrX4POtTnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVNyim/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACDBC32781;
	Wed, 21 Aug 2024 22:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724279452;
	bh=9hM1UR02IR6WK1n9AY+5U6wjkUWO6iL3GULiEkR+LAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qVNyim/9QotcRj/a4kStDywZY9GIvJPHopig9Y4+y0+EqoIREhXFJXkCl6PnoGAB2
	 I/iHlnLZbSl4TYG7HZjEbkGFei+lDhbO/1zgOhMbkXqmQFlVw0lxeAFBtN2KMWogPT
	 1S8H9QZ7mCm6sDyYEqHyB1lX2iKxQEe6kkkay/feGO/6jYfxqI9fyFvOGFB6PPf8kS
	 LvW1Ua/y5yso7XpM6mcbvSnBkZEMZkr7ONtjBPiGZ5Nvjtvaey01yyHTlEcdsm65b7
	 QjnHkd+v6GmK5reTeStHnmg0Uoxag9k0jAqCAx7K5I0FrhauLhjY+G6wM6lsk+vY0I
	 8QGRc1kVegb7g==
Date: Wed, 21 Aug 2024 15:30:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
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
Message-ID: <20240821153049.7dc983db@kernel.org>
In-Reply-To: <CAHS8izPZ9Jiu9Gj+Kk3cQ_+t22M4n4-mbPLhx+fti_HiWzL57Q@mail.gmail.com>
References: <20240813211317.3381180-4-almasrymina@google.com>
	<CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
	<20240819155257.1148e869@kernel.org>
	<CAHS8izPL4YdqFjkTpYavdxQn816=kkUv0xravQJF4Uno7Bn3ZQ@mail.gmail.com>
	<CAMArcTXvccYBPZTEuW-z=uTK7W67utd9-xjPzfxEOvUWhPS7bg@mail.gmail.com>
	<CAHS8izPZ9Jiu9Gj+Kk3cQ_+t22M4n4-mbPLhx+fti_HiWzL57Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 11:36:31 -0400 Mina Almasry wrote:
> Additionally I'm wondering if we should disable adding mp-bound
> devices as slaves completely, regardless of xdp. My concern is that if
> the lower device is using unreadable memory, then the upper device may
> see unreadable memory in its code paths, and will not be expecting
> that, so it may break.

I could be wrong, but my knee jerk reaction is that from datapath
perspective upper devices are just like any other part of the stack.
They should handle (read: not crash with) unreadable frags. The frags
can be injected in many ways, we can't depend on "lower doesn't do MP"
to catch all the bugs.

XDP is isolated, we can prevent unreadable packets from entering XDP
*completely*. We cannot prevent packets from entering the skb paths.
No?

