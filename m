Return-Path: <linux-arch+bounces-6169-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF10E94FA95
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 02:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667291F22978
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 00:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F584A3D;
	Tue, 13 Aug 2024 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQm5zO/c"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB780B;
	Tue, 13 Aug 2024 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508152; cv=none; b=Rxu74Ij/+b3v6IHveGbcYp8yQzZJbbiiUOZBqmItA6WjtalSXVJUBvR0Il9KhpUdp9yfHqEyjZlSUdbAEHej9pOUgBz6P/oLa3YEnc4XfGi25+J9fIGEmRG76NG8gO+0dnXPXqCUM87GJych4LdqqXux2QUs7Hk7JXTWI5hzgUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508152; c=relaxed/simple;
	bh=S1XJ/Rz0CP+PA+3mSURlVDBTpHV1w7efu3oNCRizCkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHPIrdBLUV6NXkS48N2T47PEtrd92zCGTE19Yg6CPt39T9W5gg0OjnXWJjeuVL1XLO1JXvBteH6vkI9zLIV7jHeYW0xt5AAbmlpnDCyHZrbPeskgPX9w1nR6pzikN7EP8mOmGJ0Srfmp9Fh9DHPHHLyy8Wf2e7BXu9yI48q8jQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQm5zO/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6C7C4AF0E;
	Tue, 13 Aug 2024 00:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723508151;
	bh=S1XJ/Rz0CP+PA+3mSURlVDBTpHV1w7efu3oNCRizCkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQm5zO/caWjx/0boPDLSn9iybZGi2E9coWEf8vuRSJQZxFonF6ZMTqNRdf16uoSCa
	 VwE1WzgKVmX0nyQvbpgls5jI3pUxjVDgFpGWDenYKwnUaW60chOXGR7lkefPfATg+1
	 vBAWWTcYTsX1Lcgs1IKvy2oe7UfJqQyNo1o+QfSGRfaNuInEGL84+5SR+SfHh7l8fI
	 V7fXA1AyV0xE9M5t7Flqo0i4T3GntLyIkd8sZcews0vKvH2nqbnRU6yLT6Dr5hQkXL
	 meOJ/JxdpV+tg2ejXTwmE+baIIo1DOu1ervh33EeUjG1j9bXW6gAPX7UuKhT5J3WJx
	 1ANCH5J5uVR7g==
Date: Mon, 12 Aug 2024 17:15:48 -0700
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
Message-ID: <20240812171548.509ca539@kernel.org>
In-Reply-To: <71260e3c-dee4-4bf0-b257-cdabd8cff3f1@gmail.com>
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
	<7e2ffe62-032a-4c5e-953b-b7117ab076be@gmail.com>
	<71260e3c-dee4-4bf0-b257-cdabd8cff3f1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 20:04:41 +0100 Pavel Begunkov wrote:
> >> Also don't see the upside of the explicit "non-capable" flag,
> >> but I haven't thought of that. Is there any use?  
> 
> Or maybe I don't get what you're asking, I explained
> why to have that "PP_IGNORE_PROVIDERS" on top of the flag
> saying that it's supported.
> 
> Which "non-capable" flag you have in mind? A page pool create
> flag or one facing upper layers like devmem tcp?

Let me rephrase - what's the point of having both PP_PROVIDERS_SUPPORTED
and PP_IGNORE_PROVIDERS at the page pool level? PP_CAP_NET(MEM|IOV),
and it's either there or it's not.

If you're thinking about advertising the support all the way to the
user, I'm not sure if page pool is the right place to do so. It's more
of a queue property.

BTW, Mina, the core should probably also check that XDP isn't installed
before / while the netmem is bound to a queue.

