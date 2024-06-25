Return-Path: <linux-arch+bounces-5079-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E7916B50
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 16:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94B61C21DF5
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AAB16F0FD;
	Tue, 25 Jun 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7NAS6q/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D61BC57;
	Tue, 25 Jun 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327572; cv=none; b=f5XEEPdgcvQn4JMomJkS6dgZY6PiiumwDUoP41stimO2bN0BCxQWLGVmsb7fuKpRjp04ugoIkwehALYWzsJsZnieSMIvaAegdcYfXYjtkyiFpG6esN65jKrI/Xyex6hD7gkkjajRyOyEtuQGusW+ESH5h22a2lexGc4iF6N/hMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327572; c=relaxed/simple;
	bh=4wYjB3JY0AnTw9nAvS+x7fjoQVoS9QzpjpY/mNtLggw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1C4q1C9iNAOUTWx9/emcEHSap2TPW/SFp/PQ4mgGEJgfw1k4yZL56uP29swrDjkPg+82F5QIoQuMhL0nIUhMYRQg0nPTi0Fv41PLr4yR9CDviJEzUOqGIeKBPOE+NwzAOaYWxdK/G1HSNldeIkcVHBWEUuHzcjp8onPHXPftJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7NAS6q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AA9C4AF0B;
	Tue, 25 Jun 2024 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327570;
	bh=4wYjB3JY0AnTw9nAvS+x7fjoQVoS9QzpjpY/mNtLggw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h7NAS6q/C2ZzBIAYKai5whZiBum489XS/J7zffMQOVU0xDBrGbji0HlKyZbV0brVY
	 jwHILNhtgojEmdiUQ3GnAfMPUSaUya0+D0cFcjQ9dhbvTuMsGJh4W2x+J7X/9HXZ9V
	 srBl3VFTN1Ly99vlBTFzJFJzSgq138zPAzzOL2os8e1W4DzrZI1H0QEVZ5ZJR09krK
	 /Bmyi4o96W3ViZ6cus20bYwYlLEzMNrqNFN4DiYRoFZwN6N3pBDHKz/uOmL4YFYFQX
	 m3FOmbQnP7K8OC0mOv3dwo1NOo8qb7etGTDcG2HlC0EOZ1X1ih7qXwRSXhT5bSXbyY
	 CFeH6MEdGgYfg==
Date: Tue, 25 Jun 2024 07:59:26 -0700
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
 <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v13 00/13] Device Memory TCP
Message-ID: <20240625075926.146d769d@kernel.org>
In-Reply-To: <CAHS8izO1g5vZodyvKBNyE-Fx7A4EoD70RuDLwXtzE3yvfRw_2g@mail.gmail.com>
References: <20240625024721.2140656-1-almasrymina@google.com>
	<CAHS8izO1g5vZodyvKBNyE-Fx7A4EoD70RuDLwXtzE3yvfRw_2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 07:16:00 -0700 Mina Almasry wrote:
> What happened here is that I sync'd to net-next, ran all the tests
> including the allmodconfig build which took a few hours, then posted
> the series. In the meantime 34 patches got merged to net-next, and one
> of those patches seems to generate a git am failure when I try to use
> b4 to apply:

Got it, feel free to repost as soon as you can build test the rebased
version.

