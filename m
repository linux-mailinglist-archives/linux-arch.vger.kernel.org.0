Return-Path: <linux-arch+bounces-4651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5708D82D4
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 14:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EE828118E
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE767E0FC;
	Mon,  3 Jun 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDNXqg0d"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A56286A6;
	Mon,  3 Jun 2024 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419162; cv=none; b=hBrB8hbcAPmq+hF/yGCDQfxmNLa9t6Ynw6rz+kFGpJD8Rtf9Qk6ftm2HNE34uoU41r5m4vjeuIrlSDGN5PWL8SLZOb6tJOaemJaw/F0WW4mGi2nffMZY9BDo6kKi44z/u/kqn3fZWKKnHMwIepuFgi5+/qxsqzd7oGai4ZJCJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419162; c=relaxed/simple;
	bh=RQVuKO8KsmnX+HwIJQMFQ5nya3BRk3afvXUxYEj9As8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzCP0Y8JsADxqLjwPxQgrU/i+cKAnGqcPnDN2IsPm8nyjFCoq/3nzWNdJbTofF8MaPfESkHko30A+bkF27tIYu+5qN5ZPynRR24ITNlzM2VKWD2MFoOW1okzQ+klUIxZr70fmyq9ckz0Cxsa9Rvwx6amXryvMtU8wRTgJabQ9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDNXqg0d; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so3594221a12.1;
        Mon, 03 Jun 2024 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717419159; x=1718023959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfniF8fjsy176YDZGpwH9nU2UAljfW8YFG1uj+a6gnk=;
        b=TDNXqg0dX/3loM6vbYTEyr1NEGurqH87sB+5Oad9YsQO8kzzevhnRIRepwpE7gcsTD
         e35nWwMYzenHkE5RIg/I3W++ZCaUWmCHDc1PYl8lKDIvH83bHoZYpGMASE03KWWrSjji
         CjyrVXtKVNa7ohmdSp8PJQPjpdJzHNBGK4rUgrNIwizcuiq7I0JxYEIdqWHlzdo0/+sD
         m/0PtAF1kQlVSAjGBJK8iuo/OnY04hxEm+FLtW3zpw3TIH9jYpFgBSJ2faayxzSEB1xe
         uMfTNgUHmWmwXabtHngny8PAph91C3UmTyfTr7thPkahB2ma8jCLC4QZGgwTjvsohHff
         xwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419159; x=1718023959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfniF8fjsy176YDZGpwH9nU2UAljfW8YFG1uj+a6gnk=;
        b=u25CydszaufKfcB2/I18ZPBtqNFaIDHz1T5R9Q2Kl0Ki7T4ZKAwNzj/M5BmKD3XmCb
         LmtTcQJKVBOXA49Q/G6C6y4FUKUlASPF79RaoLFt8v17VdN20SmptVaGVsJF3TOAL0oX
         fZSJkRm/+oVbp2nD6Isk75sUcCqFhB5aMfWyECMu6Z9I80+ZCxvNhv9km4Qg1BF3gkQF
         9PGsEi6DZPKeLST8SsdTU7sj0/nE7aLPsze1TmdxCT4Oi3QwUPoEN5L++3HMkEmd5mQ7
         dQf+ZacAe324iygpFgq+2XCbCq21I+/uAhhpIzYAFfqjUCuhh0WogjstPHndOY4G7lRv
         770g==
X-Forwarded-Encrypted: i=1; AJvYcCWxw9rRkDB0Ogq5peLF4uM8jksb5/RtXSVu8ITqP2Etf3tLyGu+DWlW1dC+Zz2kGkoshPRsqdqePi/0fqen2YacgddH3J5glwTMXdAhjdX/agIuDjMAWLo+VY81ypL4Jt4VtnFmH/q2obWvnxz4gs0ZjwkfUrzb7Zc7fEf0eFs5YY+ab+is2zHMVlvRUNFllAoN493jnbwkorxZVc2+fG4+biCgDD3mS/Ln+w3YHUzN2q2TGVo+sgWVfkmAgYLL+njjpwQKCuIQgMMc4q+bq4l2I8yGuEQ2uTvZQG5pOX2kTlXr3OD266ValHOnniLgQlQP2pVwxa2g7Ae5Ci4WFavLWY5RbC6xgkyt/ThfdA54olLUvmuAUVgwUgGfYPZixx/GdoWPfsVf4rqEBizzCenvpeQFgLcrYpFzOkCfwEH6pd92OUltjgem5zpPQJIw0NxAKaAic4Ejs8SDNzSuHJH8jFoPJbApd6sOfZboxmIZJDYYoIQHBiEyWNSRRbwhxZx+zYD9OQ==
X-Gm-Message-State: AOJu0YyMk7f/HGvHRoBNrtTmSTQhhL7dLdBoe3vGrkHSQvcZCq+G46QV
	Ptgn7ehM2OwFl+HGMzvZWG329x/hS0LtTkpQ6wvQ7HDPTBfowNCy0NeWUGFe
X-Google-Smtp-Source: AGHT+IHWekmH9nbBwxtAyBA3aP0bAtq3ZvyaOoiHlV8Yt/cXh+LsKG2d/23Eymxd3zWFCpXjqiJUYw==
X-Received: by 2002:a50:9b19:0:b0:56e:238e:372c with SMTP id 4fb4d7f45d1cf-57a3653a3d7mr5229810a12.26.1717419158381;
        Mon, 03 Jun 2024 05:52:38 -0700 (PDT)
Received: from [192.168.42.59] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b990easm5173294a12.6.2024.06.03.05.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 05:52:38 -0700 (PDT)
Message-ID: <fb8fd578-96b8-45b9-b6a9-fe407157122f@gmail.com>
Date: Mon, 3 Jun 2024 13:52:41 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 01/14] netdev: add netdev_rx_queue_restart()
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
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
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-2-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240530201616.1316526-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 21:16, Mina Almasry wrote:
> Add netdev_rx_queue_restart() function to netdev_rx_queue.h
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
...
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> new file mode 100644
> index 0000000000000..b3899358e5a9c
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

I believe it should also do:

if (!dev->queue_mgmt_ops)
	return -EOPNOTSUPP;

> +
> +	if (!dev->queue_mgmt_ops->ndo_queue_stop ||
> +	    !dev->queue_mgmt_ops->ndo_queue_mem_free ||
> +	    !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
> +	    !dev->queue_mgmt_ops->ndo_queue_start)
> +		return -EOPNOTSUPP;
> +
> +	DEBUG_NET_WARN_ON_ONCE(!rtnl_is_locked());

-- 
Pavel Begunkov

