Return-Path: <linux-arch+bounces-4890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8A9080AB
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2024 03:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD5628439F
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2024 01:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C445FEED;
	Fri, 14 Jun 2024 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg9ZtS8y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872431773D;
	Fri, 14 Jun 2024 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718328897; cv=none; b=VsHrwmH5eYxeiKZFTbnBcWzlULoydE+R7s6cx1jJa8c0Ccth2DsEIxMIH9nHk4a9IH9RD01S/Pk4IPQ+WD/KR570Xa5XYQGDp6oxp9G/KjvqL9QdJdHM3Vszn1XrX8cMTaGXhxOAstp5A/rWavqEs63mJk4VS1VevaXQNjp4rSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718328897; c=relaxed/simple;
	bh=CYOxmE4ntQW4bNMvxq9UIlsEBzTRL4qLB1FV48Xatv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USAUY/NF7f9lomUFU0/3qPvQFhIc5mrecPjwbnTHMK6Ruj5KN6zhnD0kQWa7XUT8H7DTvXi24TGeT5fFQ/5ScIs7yqdZcsE0rumG+c9rCTUfme+LP9Q6HJ0SIHzXqIqsEIOosy1u+qd6OimLeN+3c5iD+j7F/h9+2UI6gYg0ovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg9ZtS8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61242C2BBFC;
	Fri, 14 Jun 2024 01:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718328897;
	bh=CYOxmE4ntQW4bNMvxq9UIlsEBzTRL4qLB1FV48Xatv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sg9ZtS8yEezxbjTVPI568a2KvEHqvKq8ud8+uPe6dGMbTueQSEMPMAgj2PCgXuIB9
	 Il047nqeXnP6P/oSYmAKQCAxosjwrgYOaHdSYN8DpizcnGRlWkldLzTTe90OSa9FGv
	 MBAW9iL444FGaNr9FcdswWY3pHc51pXPD6UDrHaFRQu/JWFwS+m0CctYfvcTP+Y/us
	 3tPXqBkvjF/1WlqhH8l2wOQHXRcCWEIeW4JHfm3b/MLKWXXuS8tFi+ZMZi3LlOasMl
	 Pv1svqR65L1eeiVLZrRKEQMiPGyOnYtk2TTlgDn5OVb4lEV9805bZIfH/6hgbdu1Gs
	 S7zj/D1FRPg8w==
Date: Thu, 13 Jun 2024 18:34:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, "Christian
 =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v12 00/13] Device Memory TCP
Message-ID: <20240613183453.2423e23b@kernel.org>
In-Reply-To: <20240613013557.1169171-1-almasrymina@google.com>
References: <20240613013557.1169171-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 01:35:37 +0000 Mina Almasry wrote:
> v12: https://patchwork.kernel.org/project/netdevbpf/list/?series=859747&state=*

patches 5 and 6 transiently break the build

../include/trace/events/page_pool.h:65:23: error: use of undeclared identifier 'NET_IOV'
   65 |                   __entry->netmem & NET_IOV, __entry->pfn, __entry->release)
      |                                     ^
../include/trace/events/page_pool.h:91:23: error: use of undeclared identifier 'NET_IOV'
   91 |                   __entry->netmem & NET_IOV, __entry->pfn, __entry->hold)
      |                                     ^

Looking at NIPA status the builders are 12h behind, so please don't
repost immediately. This series takes a lot of compute cycles to build.

FWIW there is a docker version of NIPA checks in the nipa repo.

https://github.com/linux-netdev/nipa/tree/main/docker

IDK if it still works, but could help avoid mistakes..

