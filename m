Return-Path: <linux-arch+bounces-5231-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B6924CB4
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 02:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143C41F23466
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 00:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCFC10E3;
	Wed,  3 Jul 2024 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiWEWXh/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCCE621;
	Wed,  3 Jul 2024 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965997; cv=none; b=T1Mg0CLs9mGg0J9w36PxuZybc+UluVCri907+kPzVrGkvF8q0ypi6iPWFaTL4TeQNttu7XBCKeWMLPEwL41HK1nehJqBa7hRYfPeiNiFeY0RwAuWgf7dMiUK49Zb9HBmko+0g8luDG5uBRspT5T0EWjBikTXu572cSv4C7vwN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965997; c=relaxed/simple;
	bh=SFsqNX+6slZmjSB86CGH3XB+ZErTnNT0rtJ8aW8Urz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvRQi1sdOXSnOeavf5zFPOca8daW6pzIi4KI41V6MNeCOLNnuwo4E5pDVCrx6XZ5opWPleNNw1RFMstb2+yb40wkT2URfyzyGcUbe2GgUt2rG43/2EBGSrJawctDYiVeXYt1n8hkYj+N8ejlApSqHW7P5ZXuHY1IqjEjdAiGpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiWEWXh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E2EC116B1;
	Wed,  3 Jul 2024 00:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719965997;
	bh=SFsqNX+6slZmjSB86CGH3XB+ZErTnNT0rtJ8aW8Urz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiWEWXh/UkVNmeAUfZXdtG67Y1o49S9dbYoJ0d6QyE8RKvUU9FNdAKA2NUpPNV9PI
	 bN41jqlN514pW/0dqfjftsE6C1Wl/gey08FMJGlkX+FEtsrqOG6Jrd7wYaZw5oGVTx
	 BPvwt9pjrvgo8hMtjSWSZHjpQQHjRa5AT89glk/nTXEwMu2EjQMrv0D2h/Bq3/aR0s
	 duFLcXIui+tre++3IefsnC8WBEUTIIqVuvE2wFaj0m/deieFGTvZAwznVeS92uKcJf
	 +Hk8u3LzmuanxtVkpELuHg4qBKIfgdn5+Jkie18lSYvYRX44x/THC6zycH2Ald7Tli
	 4Ls+aEZ227geg==
Date: Tue, 2 Jul 2024 17:19:53 -0700
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
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
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
 <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next v15 02/14] net: netdev netlink api to bind
 dma-buf to a net device
Message-ID: <20240702171953.00886d5a@kernel.org>
In-Reply-To: <20240628003253.1694510-3-almasrymina@google.com>
References: <20240628003253.1694510-1-almasrymina@google.com>
	<20240628003253.1694510-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 00:32:39 +0000 Mina Almasry wrote:
> API takes the dma-buf fd as input, and binds it to the netdevice. The
> user can specify the rx queues to bind the dma-buf to.
> 
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 959755be4d7f9..899ac0882a098 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -268,6 +268,45 @@ attribute-sets:
>          name: napi-id
>          doc: ID of the NAPI instance which services this queue.
>          type: u32
> +  -
> +    name: queue-dmabuf
> +    attributes:
> +      -
> +        name: type
> +        doc: rx or tx queue
> +        type: u8
> +        enum: queue-type
> +      -
> +        name: idx
> +        doc: queue index
> +        type: u32

u8 is a waste of space, since attrs are rounded up to 4B
and we don't use "idx"

How about we use a subset of queue attrs?

	name: queue-id
	subset-of: queue
	attributes:
	  -
	    name: id
	  -
	    name: type

> +  -
> +    name: bind-dmabuf

The naming is a bit too command specific, how about pp-buf ?
Or just dmabuf ?

> +    attributes:
> +      -
> +        name: ifindex
> +        doc: netdev ifindex to bind the dma-buf to.
> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: queues
> +        doc: receive queues to bind the dma-buf to.
> +        type: nest
> +        nested-attributes: queue-dmabuf
> +        multi-attr: true
> +      -
> +        name: dmabuf-fd
> +        doc: dmabuf file descriptor to bind.
> +        type: u32
> +      -
> +        name: dmabuf-id
> +        doc: id of the dmabuf binding
> +        type: u32
> +        checks:
> +          min: 1
> +

We need some form of introspection. Can we add both in the queue dump
and page pool dump some info (dmabuf-id?) to indicate there is a DMABUF
bound to the queue / page pool?

>    -
>      name: qstats
> @@ -579,6 +618,20 @@ operations:
>            attributes:
>              - ifindex
>          reply: *queue-get-op
> +    -
> +      name: bind-rx
> +      doc: Bind dmabuf to netdev
> +      attribute-set: bind-dmabuf
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - dmabuf-fd
> +            - queues
> +        reply:
> +          attributes:
> +            - dmabuf-id

The ops end up getting rendered as an enum, so the ordering matters.
You can't insert in the middle without breaking uAPI.
For attribute sets (which you also added before qstat) it technically
doesn't matter but would be good to have them in order to match ops.

> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 43742ac5b00da..190a504a62358 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -136,6 +136,24 @@ enum {
>  	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
>  };
>  
> +enum {
> +	NETDEV_A_QUEUE_DMABUF_TYPE = 1,
> +	NETDEV_A_QUEUE_DMABUF_IDX,
> +
> +	__NETDEV_A_QUEUE_DMABUF_MAX,
> +	NETDEV_A_QUEUE_DMABUF_MAX = (__NETDEV_A_QUEUE_DMABUF_MAX - 1)
> +};
> +
> +enum {
> +	NETDEV_A_BIND_DMABUF_IFINDEX = 1,
> +	NETDEV_A_BIND_DMABUF_QUEUES,
> +	NETDEV_A_BIND_DMABUF_DMABUF_FD,
> +	NETDEV_A_BIND_DMABUF_DMABUF_ID,

This does look kinda repetitive, maybe let's drop the dmabuf from attr
names?

> +	__NETDEV_A_BIND_DMABUF_MAX,
> +	NETDEV_A_BIND_DMABUF_MAX = (__NETDEV_A_BIND_DMABUF_MAX - 1)
> +};

