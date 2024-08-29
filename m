Return-Path: <linux-arch+bounces-6830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6216C9651C6
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 23:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6382B21069
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 21:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020318CBE3;
	Thu, 29 Aug 2024 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAlm7TqT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60118C004;
	Thu, 29 Aug 2024 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966562; cv=none; b=S8W0hLmJbcLFWcVpEViixWeRMyYNW9VooVz8SBKbBHHOzEstVWf1r+OR7idy8HYrXpyMmxJ8NHMBCAjSJRI2U/Oiaz0y/SpYXbIHzAt/RIai+YYXHZ5THXXWtXRzlkhYOJBN6iOYLOmON1KN9cXDfDIFDabyIQTr8fACGrtgmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966562; c=relaxed/simple;
	bh=AIUYhH6teWWXTjGRBiDsHK8aBX5HXI6HxwijcjNaPFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gU3e5cGiw0UBFDr+70P+bTyhhHtWp4n4m4ljfSgh1uWwTo4128/PWey9ESuigC6zjazraCvr9NKFAhT0DEv6xu9Q46k4cIlYXyD0MGBviFZhzfsUrLY2NDOcmx0leR8tRd3F3sTRWjKOGMdxpAzfU8mbPg0Q7lDm44JPbMtvzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAlm7TqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928C0C4CEC2;
	Thu, 29 Aug 2024 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724966561;
	bh=AIUYhH6teWWXTjGRBiDsHK8aBX5HXI6HxwijcjNaPFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fAlm7TqTA1OF7bSfcuffeGQG/lby/V0HduWcVtaK1nkYVxrKsvZ0MwCaDCRnFEG+l
	 EGJaBNwwfGDLQOAi9NQzrPu18iy/hWTtuQMNOu+0nPCHEIatFrZByxWPwE0VbOiPHV
	 Kn0GHWp5m2uSg/qJ84b+VqPNKa0XjJ+fu/OBf1NUwvWWQNbRow+zOLCORgoxhc7dGf
	 pDTekIK1OdDqJ+63BcryVVmg82U/GxOjsHt7S4p3UNzeciyn8EmGCSuhlNwcHWsg5Y
	 3RQ3Plexe5T9WF8RrpcMu45Pz49Rzo8liFQtQkDcxCd6IZIB0tClRPnCbaazHUdmlH
	 b3qPIO4BvF8ug==
Date: Thu, 29 Aug 2024 14:22:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?B?bA==?= <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v23 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240829142237.4f1ab1ba@kernel.org>
In-Reply-To: <CAHS8izMCZbynEQQ3rPs2QaEbD51ew7VK0sMziBTayCi2yEZ_EA@mail.gmail.com>
References: <20240829060126.2792671-1-almasrymina@google.com>
	<20240829060126.2792671-4-almasrymina@google.com>
	<CAHS8izMCZbynEQQ3rPs2QaEbD51ew7VK0sMziBTayCi2yEZ_EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 12:38:13 -0700 Mina Almasry wrote:
> BTW I submitted 2 iterations already this week, Sunday and Wednesday.
> This is easily fixable and I can resend before the end of the week,
> but if I'm stressing NIPA too much with reposts of this large series I
> can wait until next week. Sorry about that.

Thanks for being considerate to our infra! :)

A few expensive series keep getting reposted, but re-posting tomorrow
should be fine. 

