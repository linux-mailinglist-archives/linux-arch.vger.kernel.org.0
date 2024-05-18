Return-Path: <linux-arch+bounces-4466-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6DD8C91FD
	for <lists+linux-arch@lfdr.de>; Sat, 18 May 2024 20:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C42B214B5
	for <lists+linux-arch@lfdr.de>; Sat, 18 May 2024 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A511A69DF7;
	Sat, 18 May 2024 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="v/AmV8kq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE760EC4
	for <linux-arch@vger.kernel.org>; Sat, 18 May 2024 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716058651; cv=none; b=M2nHcfFMGm3CZ8cqkKbSARz5xaNNv3K+vgkQnwYpMxENhQMiH7WDCNP+RjOAbvfYOwjYqmmDh3HgUIAupwT8UeOpyF9uNvcd0WkEnrwgHYlOkaOs1d8fhoBpT6zfBZ16c1HJTTypodACq8/p38QPn4CLgIvj9qN7YWNgSnBdLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716058651; c=relaxed/simple;
	bh=wAqIRcCabbfn5FNmvGNIGPL+iroeEmFcrvMhrlMZdAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nE1H8iaZKuEQYnN8gH+4QMLlTZtuV50RoxDGKIwkBUTur5ADembYEU4dd3Ef0gpb+v8t0FyTYm0kTigF7W7ssyq+2DpiY3GehH2D+9DcXz66XoNe5VwFRorlntod1G45T+alj8ZbhNPa4I/yBvPevnQU8JvNjgZO17Vu6+1VlMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=v/AmV8kq; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b2e942171cso741536eaf.3
        for <linux-arch@vger.kernel.org>; Sat, 18 May 2024 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1716058649; x=1716663449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YguLbfIUe9SPEVY4PVRNzJgWNLjHIbYrZNjYPjw1wDY=;
        b=v/AmV8kq3UZnHRDaqHKqhNVypfUF8x6d6yBi1N5G0tcfRYE7ce3MRpUzwl4YK2pDOY
         0gSkGZswCXm5bMtnmSlhuxkbS/tIUF9okGsjBZ5fby4NKwqYTPIwTzC4ZoclOyTZFLem
         RT2+G780T4Rvt6sAdooeJFD4Qw3kSZNGJ+JoLSw1NmiZZpBQstNxMDIY5BleC4qlptFg
         +S8gDOPygxpPebphBpPjxk+hnz5mYSWeMnl3BWZFaLUWoQw272KOFLgpA509meCbeaTc
         1zy687rDIDcZ+p0a/pi8z2PkHBDskEdl/PpU+UT704u1+W7ImWvpp5WEZODo1Gd2YGEU
         ZAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716058649; x=1716663449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YguLbfIUe9SPEVY4PVRNzJgWNLjHIbYrZNjYPjw1wDY=;
        b=CCuueRuBWp1O/Ln+YMqv+T570YakSQxAaBYo4GQQkve8bJ7lFH9uOvEfDbYqYb5u75
         UZKmOCC7XzLWLdj44ZigtM/jFRL+4mmxMW2gH9qD7hbTVsema0VsJ3QHXlPH3XCSjzdA
         MwIQtigr49/mdC7VZKpOZMpKopXdJrpnnqw/HEfXbEDhwHAnUlbfE/GFfAVpk38R1t2h
         kN49EXkBR3FNHJOXKjWvIZ7BCmlKV7ohrUvhzg6hUnz8udYOKTUl+vxtCrWr24ALuzWw
         lc2eQL5JjV1ks9dLiog6ew0qWMbamY1pLjO0Eq0h2IGNKBUwfMWNP9L2AytxrVbXuPhK
         ia/w==
X-Forwarded-Encrypted: i=1; AJvYcCXFwnCzI+4VIojZKAtIdz2k/Pq/QXUejThq+dAAzhSbUB3DLu4Ep3a3uIUHJcnrzchw32Qmq9ISd7TzYjSAhT83fWl3/3ojAfiIzg==
X-Gm-Message-State: AOJu0Yw+Bcq2OkJno5UpIw/XPgDdXheZMsYF2lvaoPMODh3RuTd4XN6g
	FgeX5klHRAtkPC1/K1R2Qf+PE3N/iWYT5BuKbWf6odDvrLG+w0u7jOIHLsovh9A=
X-Google-Smtp-Source: AGHT+IHilXoeJ/w5ohYR0i7AU3401ochXIU5LArEI0v5RdvvJ31YBmDQam4A7KpiPZymCfWrte5bew==
X-Received: by 2002:a05:6358:3a11:b0:17b:5661:5e2b with SMTP id e5c5f4694b2df-193bb64065bmr2817534555d.18.1716058648846;
        Sat, 18 May 2024 11:57:28 -0700 (PDT)
Received: from [192.168.1.16] (174-21-188-197.tukw.qwest.net. [174.21.188.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-658764fda40sm5342410a12.5.2024.05.18.11.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 11:57:28 -0700 (PDT)
Message-ID: <eeb59c4f-9208-4700-b73b-9652398371d7@davidwei.uk>
Date: Sat, 18 May 2024 11:57:26 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 04/14] netdev: support binding dma-buf to
 netdevice
Content-Language: en-GB
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
 Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240510232128.1105145-1-almasrymina@google.com>
 <20240510232128.1105145-5-almasrymina@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240510232128.1105145-5-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-10 16:21, Mina Almasry wrote:
> -/* Stub */
>  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return 0;
> +	struct nlattr *tb[ARRAY_SIZE(netdev_queue_dmabuf_nl_policy)];
> +	struct net_devmem_dmabuf_binding *out_binding;
> +	struct list_head *sock_binding_list;
> +	u32 ifindex, dmabuf_fd, rxq_idx;
> +	struct net_device *netdev;
> +	struct sk_buff *rsp;
> +	struct nlattr *attr;
> +	int rem, err = 0;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_DMABUF_FD) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_BIND_DMABUF_QUEUES))
> +		return -EINVAL;
> +
> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
> +	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_BIND_DMABUF_DMABUF_FD]);
> +
> +	rtnl_lock();
> +
> +	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> +	if (!netdev) {
> +		err = -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	err = net_devmem_bind_dmabuf(netdev, dmabuf_fd, &out_binding);
> +	if (err)
> +		goto err_unlock;
> +
> +	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
> +			  genlmsg_len(info->genlhdr), rem) {
> +		if (nla_type(attr) != NETDEV_A_BIND_DMABUF_QUEUES)
> +			continue;
> +
> +		err = nla_parse_nested(
> +			tb, ARRAY_SIZE(netdev_queue_dmabuf_nl_policy) - 1, attr,
> +			netdev_queue_dmabuf_nl_policy, info->extack);
> +		if (err < 0)
> +			goto err_unbind;
> +
> +		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_DMABUF_IDX]);
> +		if (rxq_idx >= netdev->num_rx_queues) {
> +			err = -ERANGE;
> +			goto err_unbind;
> +		}

net_devmem_bind_dmabuf_to_queue() checks for rxq_idx >=
netdev->num_rx_queues as well. I'd say remove the one in
netdev_nl_bind_rx_doit().

Also we may want a generic netdev function e.g. netdev_rx_queue_set_mp()
since I need the same functionality.

> +
> +		err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx,
> +						      out_binding);
> +		if (err)
> +			goto err_unbind;
> +	}
> +
> +	sock_binding_list = genl_sk_priv_get(&netdev_nl_family,
> +					     NETLINK_CB(skb).sk);
> +	if (IS_ERR(sock_binding_list)) {
> +		err = PTR_ERR(sock_binding_list);
> +		goto err_unbind;
> +	}
> +
> +	list_add(&out_binding->list, sock_binding_list);
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp) {
> +		err = -ENOMEM;
> +		goto err_unbind;
> +	}
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr) {
> +		err = -EMSGSIZE;
> +		goto err_genlmsg_free;
> +	}
> +
> +	nla_put_u32(rsp, NETDEV_A_BIND_DMABUF_DMABUF_ID, out_binding->id);
> +	genlmsg_end(rsp, hdr);
> +
> +	rtnl_unlock();
> +
> +	return genlmsg_reply(rsp, info);
> +
> +err_genlmsg_free:
> +	nlmsg_free(rsp);
> +err_unbind:
> +	net_devmem_unbind_dmabuf(out_binding);
> +err_unlock:
> +	rtnl_unlock();
> +	return err;
>  }

