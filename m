Return-Path: <linux-arch+bounces-5353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CEB92D6C5
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 18:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B185B2DDDB
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3401198A0F;
	Wed, 10 Jul 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOB39CZJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DF198A06;
	Wed, 10 Jul 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629387; cv=none; b=u/dlIfjXtGytyJgLOOCFnjXURJ+72mBWir/zeIc6u6VBGnLp9p4KzMbfzpTgrZ/c5r1sbSAL7fWx7FqMpkli0HFzOITUlrMc8Gh6qeFxvtYGhYO24GK1nC+Cs/5YFx+47ZkVGojTEkLrVH3ujfPoG12AnOWkw2IM9W41YaPgjWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629387; c=relaxed/simple;
	bh=VOEQami4KT93qBtaeJsQ3QrGdn1x7XmqJH9KjXDTUok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOQgTXVT5Mk+UUvrf7bx0Am8Ni026QrPub4DJP/2ixizPphjjbcILbWJK+zQkLUVToOJ3PbeM0uCXjdzbNSGfuIUXDQmK/LjGPhuI3Wm4Ewb7iojAAXERTJcJ1689SQg4EprXjIBvdyWrubmNaLla5v+raW2SRsYtKnDXX0mrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOB39CZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D988C4AF0E;
	Wed, 10 Jul 2024 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720629387;
	bh=VOEQami4KT93qBtaeJsQ3QrGdn1x7XmqJH9KjXDTUok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aOB39CZJyMSyw1K+rruCMig4enLLpVwC4wmcFjrJNki6A1jlaMJwosJ9qi8gRob9s
	 z7kFdpwuqr9jEMtf/y6F9JBirzQmzNumlVlD4b5l1/DcvZl1p0vOnft2M9nqMidkg2
	 fMeKFVzWzpdKvcOJw8T8tVAueyIBUoE5fy6eFWwP05DhpQeDO1LP4UgyB2r6dI3IcB
	 VwAb4piQ8k8z2t0MaNbM+KdSE042QTqyYizf8pBU/ymZjtyw0F38O1P7ZzGOvlO5KG
	 spFlwBsXz0iOlmIq8Tsu0Zw/Wqy210Von3cqCm6mraFQxJZhjqMZtEzBl7xdBYwb2m
	 CVueEk61o919A==
Date: Wed, 10 Jul 2024 09:36:24 -0700
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
Subject: Re: [PATCH net-next v16 04/13] netdev: netdevice devmem allocator
Message-ID: <20240710093624.26d22f02@kernel.org>
In-Reply-To: <20240710001749.1388631-5-almasrymina@google.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 00:17:37 +0000 Mina Almasry wrote:
> +	net_devmem_dmabuf_binding_get(binding);

Why does every iov need to hold a ref? pp holds a ref and does its own
accounting, so it won't disappear unless all the pages are returned.

