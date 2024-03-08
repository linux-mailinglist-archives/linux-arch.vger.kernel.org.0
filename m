Return-Path: <linux-arch+bounces-2895-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C459D875BFB
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 02:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA292838E2
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401C4224CC;
	Fri,  8 Mar 2024 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuK2qD6w"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4523748;
	Fri,  8 Mar 2024 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709861443; cv=none; b=acwvILkXcLHMUu0rcqAYldOMXb21DFHE2Q6OcwEuFaQeNd76YMSBoY0gzv4GLFngisTUnB2PMh4CM5iTT05LV0YeCdkjIxoc7gWuLyjQd5Ru2Fm4MAXvBYjKMrMDszZ1G0Ivv1ZysAQPeNgOJHX8vkEMzqV2f2EtnzTCj6u6QH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709861443; c=relaxed/simple;
	bh=pWLPfbMGjAqOMIxZXwrouf7NrYnQYoQSjURpmCc84iU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUYzwCOWas4t/4pTxnKmSP76T6Pb26ePU3ArqJPJ23CzwBFvlyl4EjADLRoflsCUSV6SghsVn6Nf18MrvElfDi/41s15rTgcp2rZwjZk2xbyRzaGPGCedGSUHNvc4UfQozlkP45UYEvFdoHHrb4PR87jz6Lq47L/85nyHmYLeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuK2qD6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD44C433F1;
	Fri,  8 Mar 2024 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709861442;
	bh=pWLPfbMGjAqOMIxZXwrouf7NrYnQYoQSjURpmCc84iU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WuK2qD6wyzgEpkNGU94oUn6yHcPXxuUo3uJrLGDTiIGph4N/vCBqNc4nDv471KEn3
	 sm7aoyIlj2FlbTUAzqmFeQZ3jZxx8uq02/lwxrUs6Fs5ne1P7sc9b+jogdt2cNh5om
	 yy2pPOnMcP+HAkFrHyi8JDY6iodalicwb81v6rzeU0un9tw4HNH9vVQNofxBnlf4+6
	 iDppG8XOmWfXjccjhAEBc5TroehEx0EzshUNRujMpMwMXGGAQ6kBNOJtKint9xVpy2
	 SaraH4eSezKXfORbglRhjRO/jH8oAebaFTPdwegjG2bPLQMw9csoNK+YHGu0qpYXyY
	 O/jGEtvZeHEeQ==
Date: Thu, 7 Mar 2024 17:30:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v6 01/15] queue_api: define queue api
Message-ID: <20240307173039.00e6fbb7@kernel.org>
In-Reply-To: <20240305020153.2787423-2-almasrymina@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
	<20240305020153.2787423-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 18:01:36 -0800 Mina Almasry wrote:
> + * void *(*ndo_queue_mem_alloc)(struct net_device *dev, int idx);
> + *	Allocate memory for an RX queue. The memory returned in the form of
> + *	a void * can be passed to ndo_queue_mem_free() for freeing or to
> + *	ndo_queue_start to create an RX queue with this memory.
> + *
> + * void	(*ndo_queue_mem_free)(struct net_device *dev, void *);
> + *	Free memory from an RX queue.
> + *
> + * int (*ndo_queue_start)(struct net_device *dev, int idx, void *);
> + *	Start an RX queue at the specified index.
> + *
> + * int (*ndo_queue_stop)(struct net_device *dev, int idx, void **);
> + *	Stop the RX queue at the specified index.
>   */
>  struct net_device_ops {
>  	int			(*ndo_init)(struct net_device *dev);
> @@ -1679,6 +1693,16 @@ struct net_device_ops {
>  	int			(*ndo_hwtstamp_set)(struct net_device *dev,
>  						    struct kernel_hwtstamp_config *kernel_config,
>  						    struct netlink_ext_ack *extack);
> +	void *			(*ndo_queue_mem_alloc)(struct net_device *dev,
> +						       int idx);
> +	void			(*ndo_queue_mem_free)(struct net_device *dev,
> +						      void *queue_mem);
> +	int			(*ndo_queue_start)(struct net_device *dev,
> +						   int idx,
> +						   void *queue_mem);
> +	int			(*ndo_queue_stop)(struct net_device *dev,
> +						  int idx,
> +						  void **out_queue_mem);

The queue configuration object was quite an integral part of the design,
I'm slightly worried that it's not here :) Also we may want to rename
the about-to-be-merged ops from netdev_stat_ops and netdev_queue_ops,
and add these there?

https://lore.kernel.org/all/20240306195509.1502746-2-kuba@kernel.org/

Very excited to hear that you made progress on this and ported GVE over!

