Return-Path: <linux-arch+bounces-6125-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C7294CBB8
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 09:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7201F21DF4
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 07:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B36B18C918;
	Fri,  9 Aug 2024 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWy7JWX6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013EA1552EB;
	Fri,  9 Aug 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190188; cv=none; b=q/icM8tm/GJw5AQmaxamY0zCZ+d7puypdEBlXsVnmGXFm3qgU5ZumjLFz44PqwyjmMTts65fVHiepjd5mgB4OvprVL9Xbqg6UGtfnychHv6wEotwSsI5FGXuHlKrGb3dxBSoT3pDDzqkrkXajJuGpWY8Rev4RoEnA81aK3mRo3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190188; c=relaxed/simple;
	bh=WciictBvnZZognJdSB//Vkpj36Vtrbm418N+k4gXKM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lue6vbwtS3HJzRZ4DDuQJNKtEil0h6h4lG6IFkP1B5hZIGG8ikUOuuF5Kcihcvq2LJABgU2zkSn7SqbHzVyIsJVSGrB0gMVkoRhgO4qxg5JpAJ98rXp/4ZTYvfg+2Q4hTsM6NO+bTCsHgTb5IFuX9QdMpXBrbmjngJBHjJfFHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWy7JWX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952AFC4AF0D;
	Fri,  9 Aug 2024 07:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723190187;
	bh=WciictBvnZZognJdSB//Vkpj36Vtrbm418N+k4gXKM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWy7JWX63DlQVy2d0mNGhQfP+E5wTH7yt+zLcJ0XE+/2H7ya+xPuYTTvng2lSdR0P
	 fY3FcxC8uU8GMeAkyI60nvRDENoJPGv+KO8RJqpQagYElLNKgByK/OFTroSX355YCs
	 LkPyVbDTwM5NLcPamf6V9UY8mS/5OHdlCJ1Bf0Wrzy8CzH4nnoBsnommLbSLYVYa0S
	 vit/eTqSx1gLR+UhLsyyqz5moCQu5XrPJ2lKHYZlMNpbvAKOB2UKpjpb3hjS9c0GG8
	 efszcgVI6ngSguWbXJ9ztgvoCk8mZPBFojeGqb+x30Hdvr6lK6GLQBG40LF/KOtnNT
	 rWCJ8B29HDgmg==
Date: Fri, 9 Aug 2024 08:56:15 +0100
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Helge Deller <deller@gmx.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	"James E. J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jeroen de Borst <jeroendb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matt Turner <mattst88@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Shailend Chand <shailend@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next v17 03/14] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240809075615.GD3075665@kernel.org>
References: <20240730022623.98909-4-almasrymina@google.com>
 <5d3c74da-7d44-4b88-8961-60f21f84f0ac@web.de>
 <CAHS8izPxfCv1VMFBK1FahGTjVmUSSfrabgY5y6V+XtaszoHQ4w@mail.gmail.com>
 <9aad36fe-cd4c-4ce5-b4d8-6c8619d10c46@web.de>
 <66b2198686b91_3206cf29453@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66b2198686b91_3206cf29453@willemb.c.googlers.com.notmuch>

On Tue, Aug 06, 2024 at 08:39:34AM -0400, Willem de Bruijn wrote:
> Markus Elfring wrote:
> > >> …
> > >>> +++ b/include/net/devmem.h
> > >>> @@ -0,0 +1,115 @@
> > >> …
> > >>> +#ifndef _NET_DEVMEM_H
> > >>> +#define _NET_DEVMEM_H
> > >> …
> > >>
> > >> I suggest to omit leading underscores from such identifiers.
> > >> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+define+a+reserved+identifier
> > >>
> > >
> > > I was gonna apply this change, but I ack'd existing files and I find
> > > that all of them include leading underscores, including some very
> > > recently added files like net/core/page_pool_priv.h.
> > >
> > > I would prefer to stick to existing conventions if that's OK, unless
> > > there is widespread agreement to the contrary.
> > 
> > Under which circumstances would you become interested to reduce development risks
> > also according to undefined behaviour?
> > https://wiki.sei.cmu.edu/confluence/display/c/CC.+Undefined+Behavior#CC.UndefinedBehavior-ub_106
> 
> This series is following established practice in kernel networking.
> 
> If that conflicts with a C standard, then perhaps that needs to be
> resolved project wide.
> 
> Forcing an individual feature to diverge just brings inconsistency.
> That said, this appears to be inconsistent already.
> 
> Main question is whether this is worth respinning a series already at
> v17 with no more fundamental feedback.

No, from my point of view, it is not.

This really is a trivial and somewhat subjective mater.
I don't think it should hold up a substantial piece of work.

