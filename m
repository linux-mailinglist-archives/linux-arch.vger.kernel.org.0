Return-Path: <linux-arch+bounces-4418-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A4C8C646E
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716E71C21A5C
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBA05C8E2;
	Wed, 15 May 2024 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="K1RcWlVF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8B5A11D
	for <linux-arch@vger.kernel.org>; Wed, 15 May 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767281; cv=none; b=Diiu6yksXuN7JWh1zj14qYYrZCNjOjBn7h0At/dCClUFe60P+Yd/UNHd4xsmx2dopN2tHwi10o62/5MMVX3WnaJRxjphshXg7EH2a9Woyq1l5QND9f3z4v/IVC7O1b/zbZsbLIm1ip1dTRDiPTLlezWSA6G48A+YQUZY5n4xn14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767281; c=relaxed/simple;
	bh=tFC4Uagubb4eoXf9w6qPRw0dVqgXqCUj9Gg59g6y8cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrNYDSUj0PaPRdN2qH/n3Rp9C43wUkVo5T1RKunOHWpQWrAjJh8eRZ2bBugWFbtFHcNEakouP70SkIJ51enIduGm1S3G7v6XbMkUuB2uio+cczmA4j6Fu5ZXtkOe7d75S5dsrfiQhSnqikaxth6/j0yX/BgyqYxbxiweXsg/57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=K1RcWlVF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51ffff16400so10924418e87.2
        for <linux-arch@vger.kernel.org>; Wed, 15 May 2024 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715767277; x=1716372077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukpqZZkZ02pF7RH8XXzq5qjyGt8/k5nmv3oeZg4UY0I=;
        b=K1RcWlVF7Y7Z2kmuv2U08evyQJO5O88iW/TZktke7hjOwzENLKqs6pqbtoMo/mQXpd
         NWEsVJGSfsXVHn5TJi6teJ3btLF0MQLm92TBGcVx8KVaBDA3iVt3I1PoIx8ORd3xiPWh
         9vsj7EzFcg7il8x3V7bH1W6VDWR2CGNzqXMnOpqDQ7OlrIXCvfIGFcil+drnBNad9TKX
         rGjUD6RLAyHJc115+6GwEi6eL5LFoDqAqsNngvXRyA4AjD68zW6rZyVN0MHtVWHfuIwT
         F7kRt5KReQfMK+DCwYtTNTiVEWm6sN6HEQGdlXjULZNKkBOsEYFsjFNNmv79oR9saiB9
         sqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715767277; x=1716372077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukpqZZkZ02pF7RH8XXzq5qjyGt8/k5nmv3oeZg4UY0I=;
        b=OTqUcZ8RVFq9CPMFlzyGWXXJp0MNIN74Wx4NKM/2vu1pBDgpTjhQOOqGjBvir9oJoW
         PI/vyFjK7yJLqO+uyOaHfBkmks2jZasjcw0jTYsPAI1i97pAyVzx63iPRdSTEc2GzUtW
         g7a2MeIHWcOHBCcVJPtIjj0vK/e9e1P7i0SZHwm9xG5hJiRzO/drfGETDec6NmRXBwxP
         tbRXWpJ4tzkBpxM90DrpnwbJsFPopX4x/KfeJTKjfqVxhxYyNudA44+3W+wxi8s7OnNJ
         JMvz1P9VWdZwJnQphLBXGoJtJSUIgCxgQED7/280EAQzglgOQBpMzHAcVWGnHXhg59GF
         sDFA==
X-Forwarded-Encrypted: i=1; AJvYcCVjRAnnMwmFEJBnZ6fq+5v34U50azo2sGVdjWoV6fIKavTsjTvCtyikUPIGOivzPNWC3mq+yz1LcVvyFiR++rACwhaJjN4dztE7ow==
X-Gm-Message-State: AOJu0Yxkf4cx2FLhL08S6BHBd0TSCefIzgYFUq6NYYy3V2L/VmQC5pqH
	+FmD8tdRfj9GouFDmK++3xD7IJtD+mDXlLgI9gNN5LOKi0YghvR9ryaO8PqcCIA=
X-Google-Smtp-Source: AGHT+IFdKwRcFcJDPoxpjnHjRZfubVEt9+BPb8Ln+L2DQVxYwERLJdr4JLAoMMUPEl1bmgBYy5XENg==
X-Received: by 2002:a05:6512:3e17:b0:51d:605e:f0ce with SMTP id 2adb3069b0e04-52210278698mr17687805e87.50.1715767276761;
        Wed, 15 May 2024 03:01:16 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01724sm837186066b.162.2024.05.15.03.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 03:01:16 -0700 (PDT)
Message-ID: <59b1ec87-03dc-4336-8ce1-cb97e5abb7d6@blackwall.org>
Date: Wed, 15 May 2024 13:01:12 +0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 04/14] netdev: support binding dma-buf to
 netdevice
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240510232128.1105145-1-almasrymina@google.com>
 <20240510232128.1105145-5-almasrymina@google.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240510232128.1105145-5-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/05/2024 02:21, Mina Almasry wrote:
> Add a netdev_dmabuf_binding struct which represents the
> dma-buf-to-netdevice binding. The netlink API will bind the dma-buf to
> rx queues on the netdevice. On the binding, the dma_buf_attach
> & dma_buf_map_attachment will occur. The entries in the sg_table from
> mapping will be inserted into a genpool to make it ready
> for allocation.
> 
> The chunks in the genpool are owned by a dmabuf_chunk_owner struct which
> holds the dma-buf offset of the base of the chunk and the dma_addr of
> the chunk. Both are needed to use allocations that come from this chunk.
> 
> We create a new type that represents an allocation from the genpool:
> net_iov. We setup the net_iov allocation size in the
> genpool to PAGE_SIZE for simplicity: to match the PAGE_SIZE normally
> allocated by the page pool and given to the drivers.
> 
> The user can unbind the dmabuf from the netdevice by closing the netlink
> socket that established the binding. We do this so that the binding is
> automatically unbound even if the userspace process crashes.
> 
> The binding and unbinding leaves an indicator in struct netdev_rx_queue
> that the given queue is bound, but the binding doesn't take effect until
> the driver actually reconfigures its queues, and re-initializes its page
> pool.
> 
> The netdev_dmabuf_binding struct is refcounted, and releases its
> resources only when all the refs are released.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v9: https://lore.kernel.org/all/20240403002053.2376017-5-almasrymina@google.com/
> - Removed net_devmem_restart_rx_queues and put it in its own patch
>   (David).
> 
> v8:
> - move dmabuf_devmem_ops usage to later patch to avoid patch-by-patch
>   build error.
> 
> v7:
> - Use IS_ERR() instead of IS_ERR_OR_NULL() for the dma_buf_get() return
>   value.
> - Changes netdev_* naming in devmem.c to net_devmem_* (Yunsheng).
> - DMA_BIDIRECTIONAL -> DMA_FROM_DEVICE (Yunsheng).
> - Added a comment around recovering of the old rx queue in
>   net_devmem_restart_rx_queue(), and added freeing of old_mem if the
>   restart of the old queue fails. (Yunsheng).
> - Use kernel-family sock-priv (Jakub).
> - Put pp_memory_provider_params in netdev_rx_queue instead of the
>   dma-buf specific binding (Pavel & David).
> - Move queue management ops to queue_mgmt_ops instead of netdev_ops
>   (Jakub).
> - Remove excess whitespaces (Jakub).
> - Use genlmsg_iput (Jakub).
> 
> v6:
> - Validate rx queue index
> - Refactor new functions into devmem.c (Pavel)
> 
> v5:
> - Renamed page_pool_iov to net_iov, and moved that support to devmem.h
>   or netmem.h.
> 
> v1:
> - Introduce devmem.h instead of bloating netdevice.h (Jakub)
> - ENOTSUPP -> EOPNOTSUPP (checkpatch.pl I think)
> - Remove unneeded rcu protection for binding->list (rtnl protected)
> - Removed extraneous err_binding_put: label.
> - Removed dma_addr += len (Paolo).
> - Don't override err on netdev_bind_dmabuf_to_queue failure.
> - Rename devmem -> dmabuf (David).
> - Add id to dmabuf binding (David/Stan).
> - Fix missing xa_destroy bound_rq_list.
> - Use queue api to reset bound RX queues (Jakub).
> - Update netlink API for rx-queue type (tx/re) (Jakub).
> 
> RFC v3:
> - Support multi rx-queue binding
> 
> ---
>  Documentation/netlink/specs/netdev.yaml |   4 +
>  include/net/devmem.h                    | 111 +++++++++++
>  include/net/netdev_rx_queue.h           |   2 +
>  include/net/netmem.h                    |  10 +
>  include/net/page_pool/types.h           |   5 +
>  net/core/Makefile                       |   2 +-
>  net/core/dev.c                          |   3 +
>  net/core/devmem.c                       | 254 ++++++++++++++++++++++++
>  net/core/netdev-genl-gen.c              |   4 +
>  net/core/netdev-genl-gen.h              |   4 +
>  net/core/netdev-genl.c                  | 105 +++++++++-
>  11 files changed, 501 insertions(+), 3 deletions(-)
>  create mode 100644 include/net/devmem.h
>  create mode 100644 net/core/devmem.c
> 
[snip]
> +/* Protected by rtnl_lock() */
> +static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> +
> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +	struct netdev_rx_queue *rxq;
> +	unsigned long xa_idx;
> +	unsigned int rxq_idx;
> +
> +	if (!binding)
> +		return;
> +
> +	if (binding->list.next)
> +		list_del(&binding->list);
> +

minor nit:
In theory list.next can still be != null if it's poisoned (e.g. after del). You can
use the list api here (!list_empty(&binding->list) -> list_del_init(&binding->list))
if you initialize it in net_devmem_bind_dmabuf(), then you'll also get nice list
debugging.

> +	xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
> +		if (rxq->mp_params.mp_priv == binding) {
> +			/* We hold the rtnl_lock while binding/unbinding
> +			 * dma-buf, so we can't race with another thread that
> +			 * is also modifying this value. However, the page_pool
> +			 * may read this config while it's creating its
> +			 * rx-queues. WRITE_ONCE() here to match the
> +			 * READ_ONCE() in the page_pool.
> +			 */
> +			WRITE_ONCE(rxq->mp_params.mp_ops, NULL);
> +			WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
> +
> +			rxq_idx = get_netdev_rx_queue_index(rxq);
> +
> +			netdev_rx_queue_restart(binding->dev, rxq_idx);
> +		}
> +	}
> +
> +	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +
> +	net_devmem_dmabuf_binding_put(binding);
> +}
[snip]

Cheers,
 Nik


