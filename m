Return-Path: <linux-arch+bounces-4941-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45990AF19
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 15:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B6A2875CF
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005E2198E69;
	Mon, 17 Jun 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkyQDocK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A7197A88;
	Mon, 17 Jun 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630445; cv=none; b=oTe7oK4bxZ7pHbBAq0+w1ZHRmj2+Jy+a1gUWMr9gcL0Uro3QZEPrVpOID8g0R19+eFTJJ4vswW2DwCA5TDQuCOm+hMw1dCSCI2Q3pc1E6jzL2fHn52EaMreF9dJFS0nNOV0sOq/AeIaGuQ990xu6Z4pdBe+XoPyHc8EZcAHGFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630445; c=relaxed/simple;
	bh=1nrAD4KfLSnRE+kqydRysazLWCkP8jJyqBGQ4Hd6vr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eL+lleYxG/K/uGosnkev+hauwd374azZyCbeGClCBCl6PvtPJryZFjeXwY3jmV0Prkky5Pc6Go4bO93mRP6/wBfi7TqxMZa+ecII5cFMU+cZ12Jt9PTHT4uYZ0pyZs4ov8CgPLoexsXOmqOb3V5t6NsaaKcXcqakOa2FhJLHpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkyQDocK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso757187366b.1;
        Mon, 17 Jun 2024 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718630442; x=1719235242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUae8JuWsbpwcHSTs/RVPWcmF5+7RW32qrRGZUORids=;
        b=AkyQDocKAkm3wA9QKpVyA3+wOLD0HS9GSqpOg028xfcDzF0NXcxR7vcJdrRuk8BCm0
         8KqsHCGdRdaSb+BG3REBtMo2QJzpAManHpxrDaml23UuYF3xADfRvaAaF4D0/7H6FGNt
         XRZeA8rGZIZadbca/QlvcGf910sTa6sN4xriq4khh9cBbzeutPi1bOOh0U6S0JxZKOrH
         uxNW/oKCbgi2MMt+7jV4g2dp+NG/lXZDbFTeaS/U3SXhKsdumymUnwXjrP+b+TXdw/r2
         Ly4F/kQaRpO8v9/rV2L52II6ETsHg/5NyC3LdK5JpJzdTnGUHWN0CX/n7JM1FBkCb/Gm
         86+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630442; x=1719235242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUae8JuWsbpwcHSTs/RVPWcmF5+7RW32qrRGZUORids=;
        b=ZW+V9G2epyh/KysUSiJ3x6oFhva4gSbBZobC2IGmmKvo74OM/IAm/4GoYoRetDYNt8
         avo0ItGEBpady45+/IMqqJp5jJ7cWNx4lvbRkByEc8ywgw3/64nwnlPXlwkdb+LLaHgP
         lC+DAepvktzbIdHQY9vjtHgLNMJwFu8NRNXREybx3rL43mUqKzGPMJITQ+dBtcPjBKnh
         mppseJrch7EgVnBnPyoyXYLct6yeQ1Y21fLAJjHUGAtN5b0afp5r5N6Uv0EmN5qZuvnx
         ybjjwr5giPJ5/I/ZXlEn9GWXEkNCgXnJSiTZWZigKE8PXrld4U48ZdeM242Q2lQkCpoz
         u2AA==
X-Forwarded-Encrypted: i=1; AJvYcCWchIxPUAgYDKe3Rr9kUh/w5051MexNXM1Qtynww3WkOaMBsaGkp/uGYI/gGA4U8fzq5saajeMe8IsEiaRA5YmLXgoV1tzOwgVb7t6fX2QOhze/m7nL0gUzDE3iDCSX+h/Zqs/fg1rQK8nFSfhYT2bAIRuiEBXk0BGqnw8BmLztJUYvE4F7/XZuKHOkikZJbcm75UL6JFBFUzkbbuIbVq2rn5KEcG/j7QAu6tjI3U7C5ZHFRVnfHM7msW3S6v6CGa0u+l/PdnOm9OUdi8xWOfqx70MUJGgEXmU3HQ7t5/ZvqVIaqb0uLK7qEdbzqFFlJ8P4stRe/tFX+WiPXxIgCyTrS+J17I+3PwmZUNj8rRMJ101KlpEppk/2tnHkYDY5rmCjuT+ZRM57NsTdfRFc+BG+xEzLrgxDieBoZ4i4RF03Zej3rFEjnE+TPWQaO90ZnFvOUlvVaSaLZ8wtuaqJF6Zdqezo2i643SBzlfi9SleWIYDRD0TxrwzMZiT2ba151+0xniCJhmXHR09Y19/j6fLZM9CBBx8zNTjk9GxndZS5/vUUFe1kO9+1
X-Gm-Message-State: AOJu0YxbwIZI1DTTNzRaxcvZNypArwvupsJuQ57jOCJWMQ5vs5nTECdq
	G0I0m7viSD1k+3bOgVDZXs980Kq2FkNRW/FnrwEr5vb4ub9vtvnSLtqi+S/U
X-Google-Smtp-Source: AGHT+IHyYrCA4cWOAfaQmJOiDF7VHhRCpPr7ss5P86Xw14pxsXCUj8adUxCN6A9F4atdUbL10vfY8g==
X-Received: by 2002:a17:906:354e:b0:a6f:c17:1572 with SMTP id a640c23a62f3a-a6f5247429amr788950266b.33.1718630442157;
        Mon, 17 Jun 2024 06:20:42 -0700 (PDT)
Received: from [192.168.42.82] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41700sm514847966b.152.2024.06.17.06.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 06:20:41 -0700 (PDT)
Message-ID: <8cd3af33-3a86-478a-a5ac-462c2cca732a@gmail.com>
Date: Mon, 17 Jun 2024 14:20:42 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/13] netdev: add netdev_rx_queue_restart()
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-2-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240613013557.1169171-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 02:35, Mina Almasry wrote:
> Add netdev_rx_queue_restart() function to netdev_rx_queue.h

see nit below

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>


> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v11:
> - Fix not checking dev->queue_mgmt_ops (Pavel).
> - Fix ndo_queue_mem_free call that passed the wrong pointer (David).
> 
> v9: https://lore.kernel.org/all/20240502045410.3524155-4-dw@davidwei.uk/
> (submitted by David).
> - fixed SPDX license identifier (Simon).
> - Rebased on top of merged queue API definition, and changed
>    implementation to match that.
> - Replace rtnl_lock() with rtnl_is_locked() to make it useable from my
>    netlink code where rtnl is already locked.
> 
> ---
>   include/net/netdev_rx_queue.h |  3 ++
>   net/core/Makefile             |  1 +
>   net/core/netdev_rx_queue.c    | 74 +++++++++++++++++++++++++++++++++++
>   3 files changed, 78 insertions(+)
>   create mode 100644 net/core/netdev_rx_queue.c
> 
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index aa1716fb0e53c..e78ca52d67fbf 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -54,4 +54,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>   	return index;
>   }
>   #endif
> +
> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> +
>   #endif
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 62be9aef25285..f82232b358a2c 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
>   
>   obj-y += net-sysfs.o
>   obj-y += hotdata.o
> +obj-y += netdev_rx_queue.o
>   obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
>   obj-$(CONFIG_PROC_FS) += net-procfs.o
>   obj-$(CONFIG_NET_PKTGEN) += pktgen.o
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> new file mode 100644
> index 0000000000000..de0575cf6df5d
> --- /dev/null
> +++ b/net/core/netdev_rx_queue.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/netdevice.h>
> +#include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +
> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
> +{
> +	void *new_mem, *old_mem;
> +	int err;
> +
> +	if (!dev->queue_mgmt_ops || !dev->queue_mgmt_ops->ndo_queue_stop ||
> +	    !dev->queue_mgmt_ops->ndo_queue_mem_free ||
> +	    !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
> +	    !dev->queue_mgmt_ops->ndo_queue_start)
> +		return -EOPNOTSUPP;
> +
> +	DEBUG_NET_WARN_ON_ONCE(!rtnl_is_locked());
> +
> +	new_mem = kvzalloc(dev->queue_mgmt_ops->ndo_queue_mem_size, GFP_KERNEL);
> +	if (!new_mem)
> +		return -ENOMEM;
> +
> +	old_mem = kvzalloc(dev->queue_mgmt_ops->ndo_queue_mem_size, GFP_KERNEL);
> +	if (!old_mem) {
> +		err = -ENOMEM;
> +		goto err_free_new_mem;
> +	}
> +
> +	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
> +	if (err)
> +		goto err_free_old_mem;
> +
> +	err = dev->queue_mgmt_ops->ndo_queue_stop(dev, old_mem, rxq_idx);
> +	if (err)
> +		goto err_free_new_queue_mem;
> +
> +	err = dev->queue_mgmt_ops->ndo_queue_start(dev, new_mem, rxq_idx);
> +	if (err)
> +		goto err_start_queue;
> +
> +	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
> +
> +	kvfree(old_mem);
> +	kvfree(new_mem);
> +
> +	return 0;
> +
> +err_start_queue:
> +	/* Restarting the queue with old_mem should be successful as we haven't
> +	 * changed any of the queue configuration, and there is not much we can
> +	 * do to recover from a failure here.
> +	 *
> +	 * WARN if the we fail to recover the old rx queue, and at least free

nit "if the we"

> +	 * old_mem so we don't also leak that.
> +	 */
> +	if (dev->queue_mgmt_ops->ndo_queue_start(dev, old_mem, rxq_idx)) {
> +		WARN(1,
> +		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
> +		     rxq_idx);
> +		dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
> +	}
> +
> +err_free_new_queue_mem:
> +	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
> +
> +err_free_old_mem:
> +	kvfree(old_mem);
> +
> +err_free_new_mem:
> +	kvfree(new_mem);
> +
> +	return err;
> +}

-- 
Pavel Begunkov

