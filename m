Return-Path: <linux-arch+bounces-6237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C3C953E56
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 02:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E711C220EB
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 00:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78F34A0A;
	Fri, 16 Aug 2024 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5ITK+WQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B93D64;
	Fri, 16 Aug 2024 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769336; cv=none; b=hM7t2UtWG79RXaYpnazMEWjvYXl4XV7xPUb0Lp+o299IJfQCalpbC1MDsh9g9vuKOyPMq6X/whfVFWefeybLuAGstyqF8SuNop7tQuIdLgTgNvgsbG4J5Mgy5WjiTGj6VC15PB1lb/sBKKOMoVFPyDi2APnyATobeRIQ9SK6MFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769336; c=relaxed/simple;
	bh=Ytv9yoDmPpxLpzsc/yRsSXmYq/2gwEitzTmx7ZSGLI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AK2dVa/UI+er9WvHD2h1yPh0pLaHMIputNVffjywqzM5FBy7NVmzsOa6+dLJAIaxTuPJI/xLsKOMXprDHpqmkpg9bz3lLgcJiqhprIz1Q9PacDchH9qHfy8MWPT3i6x0RLFg9WIRmOK+zlgssVevUNqWz8LgRNxn2SFAxV5NPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5ITK+WQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AD2C32786;
	Fri, 16 Aug 2024 00:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723769335;
	bh=Ytv9yoDmPpxLpzsc/yRsSXmYq/2gwEitzTmx7ZSGLI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e5ITK+WQTBSBd0ONLrV8Z07tHWXazMUo9DUF+ybTMbIx8l9X8e7vv9fHgLRLwkL+F
	 fUFlVZCO1aZmTn7HWjJSb1AFkTLPqJqexHx6JDAUHI/lE1ooDN/ZmbwRaq0hcD2sIc
	 /F7bmJ0uF7YPbeEXlceauH+SehcI+RC1efSfm1PYPBCp+HRMArbvvawNtTwYtB8POl
	 9zKqa00MUqjxTyPKr3oN4UM5dGM6BoxIx87kHA8X+R1VWZcpQ8zvTvKpwX3WbVenMV
	 YHtccFvyDipTPgy5bT8DeAmspcKtDeaACtk8f7jp3VsmXF75Z6u27ITubBXiFFaH7U
	 ddgfGM5Dpvcxw==
Date: Thu, 15 Aug 2024 17:48:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v19 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240815174852.48bbfccf@kernel.org>
In-Reply-To: <20240813211317.3381180-4-almasrymina@google.com>
References: <20240813211317.3381180-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 21:13:05 +0000 Mina Almasry wrote:
> +int dev_get_max_mp_channel(const struct net_device *dev)
> +{
> +	int i, max = -1;

I presume the bug from yesterday is self evident once reported? :)

> +	ASSERT_RTNL();
> +
> +	for (i = 0; i < dev->real_num_rx_queues; i++)
> +		if (dev->_rx[i].mp_params.mp_priv)
> +			/* The number of queues is the idx plus 1. */
> +			max = i + 1;

The +1 is odd. The function as it stands reports min channel count.
Not max_mp_channel, if you ask me. And if you renamed it, you don't
have to use -1 as "not installed".

> +	return max;

