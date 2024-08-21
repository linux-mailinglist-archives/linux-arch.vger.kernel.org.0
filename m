Return-Path: <linux-arch+bounces-6396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10AE959252
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 03:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993CF2849CD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 01:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CC44964E;
	Wed, 21 Aug 2024 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2iT7nVX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97222619;
	Wed, 21 Aug 2024 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204983; cv=none; b=fDzMpk7BrNJPj5OWIiWw3VoR91npcZ6u4Oyi78ZR0ytegB4fAzz2F4kItRQGmw+qfhXi3/UgFn0AoU8wnxZ40KkgpnofplcxFxkCqdHNiVRvay2q/S5pnJO6NNPRwXuE/72Qm1whNXQONp6g36kTXkgO2Gpc9DA//Pzvqa4Sido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204983; c=relaxed/simple;
	bh=QEcP0D5pWqJNvY0cdxNsEMzC1z85w9dK6ebctCCsuV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvvdf4NX8YzdSN+TUPj9g5/TjsL/VkQwdWZWE36GJazKtwQagJfl8xeWswsana1KCO3OyTQab3nBBX6t84dVk1PbkcdMV6kjXTfBW40GCzU6JLn98Wqrwz2aBxaf9JiNSYwVpAnarpcZQABHKUqjhr7OQgJPMLOn8KPq1fqgZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2iT7nVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08F7C4AF0E;
	Wed, 21 Aug 2024 01:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724204983;
	bh=QEcP0D5pWqJNvY0cdxNsEMzC1z85w9dK6ebctCCsuV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W2iT7nVXCenGsX9Oubfa9dTGURB+eoci50JGFgIlkmI342HyusXhc8AyBnwB+ywLf
	 ZQtmlnQUNDrCsZw+AUuG7W9A3FAObsjhOc+gk+umK4RuOqyL/8QL+62PEAtvBoUnjB
	 6IymVrFBIkHkliksUN0JXCdRCtEuXkyaVmmMMIl22AEpbJGpiaWmOtI5g4XAP69s+z
	 V1vs89QQNhPc0UFEfcL6cRZoJhWzXdaN1vipw0+lKUkhWfYpMGwhbQ1zvnLb9/E0zZ
	 QfNZfQmvivEdqVncvanJZF41b7MJHe6hO6UU9qoyHymgCtnfOQNdURwOz0w5omEp+i
	 hwuwhwYfKeeBA==
Date: Tue, 20 Aug 2024 18:49:39 -0700
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
Message-ID: <20240820184939.47708aac@kernel.org>
In-Reply-To: <CAHS8izO-F2qwbEEtYONOYgNFsP3jxpv0etgSKknnAQ8itA5Cdw@mail.gmail.com>
References: <20240813211317.3381180-4-almasrymina@google.com>
	<CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
	<20240819155257.1148e869@kernel.org>
	<CAHS8izPL4YdqFjkTpYavdxQn816=kkUv0xravQJF4Uno7Bn3ZQ@mail.gmail.com>
	<20240820081920.6630a73f@kernel.org>
	<CAHS8izO-F2qwbEEtYONOYgNFsP3jxpv0etgSKknnAQ8itA5Cdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 13:11:20 -0400 Mina Almasry wrote:
> > Protecting the stack from unreadable memory is *the* challenge
> > in this series. The rest is a fairly straightforward.  
> 
> Understandable. I pulled the trigger on v21 with the build fix last
> night after reading your response on the other thread. If you manage
> to review that and let me know of any other issues I'm going to run
> into down the road, that would be great. But I read in some other
> thread that you're overloaded. Sorry if I'm piling on. Feel free to cr
> it if necessary, of course.

Sorry, I was hoping to but the Intel series with its layers of magic
macros exhausted my mental capacity (and time). Feel free to resubmit
without the full 24h wait.

