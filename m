Return-Path: <linux-arch+bounces-2298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8C98531EC
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 14:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D701C21671
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40F855C27;
	Tue, 13 Feb 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipLzlSDG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E355577C;
	Tue, 13 Feb 2024 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830968; cv=none; b=SnjbfHahzFzMvu8/Llxp678Rtk7+tLPOmpXRQL6s6Yms/HFaEwh5byHneUPJPdFzGvFlLkNHuUD+npXQdd/H/LGYjNJSWYfRWOXVyPXNdWATOKd3vcEc5M4zqTM/RRHs+CQUUbgIEksbrVNNnfbuanyc5crWbA0Cj2x7gvPY77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830968; c=relaxed/simple;
	bh=S2uYMqOrZ63NG8/je4DIvWdofi03vpAm3WmCTXF4nDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV8FeXq9YtgQm+5+WOppo0kc7Y7vEycIZRV/N8//vIJLOhEAxxMT4xDUNeyptIGKNwKj8KCHghvudQ65VhBLkVJqapXd/hJH7Ltcyju1zUkQpymMXs/qu0alD6tHzezp1fFKEZJKqqtsXBeq95AS/o3v6WcPa9CidUOoC0Dnss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipLzlSDG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-562117d3dbfso195302a12.1;
        Tue, 13 Feb 2024 05:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707830965; x=1708435765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFkfsfcQj3EYz0HghFi199sukal5EHX9cCiPBab+av8=;
        b=ipLzlSDGzoX8Vz4cX5XnWHuff2FUxd5SOx+KD6+NH9mUOdjtAUGC6zP/R5Uu5Kj+E3
         yWiRMuq2iesqpMj0QkOa3TLiiWUFvAcOEl1ePBnCuAmyK1HejNxS3I4gPKCHbJiMvHNl
         r+K9ciFtxh023dq4lGX1BSBWkHxMPbGQ3TDCYWTV6r57Zs42KZPPclPmf6P7PCeTUw9x
         IAl3Xdea0JO1ejGzjjXTURz7cnEAjASPnjuSxLgcTSBqwoug7ghomN9hIF3QvPQ18bw3
         jNQ69RFAHOQXFhN60pFT/LUGBDBNvSdyo0X7D9PpWhFloy5eFHhD3CP9ZS2bRxiAR9e0
         MjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830965; x=1708435765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFkfsfcQj3EYz0HghFi199sukal5EHX9cCiPBab+av8=;
        b=cOSQNTx119krJSUpU5d+p+mlu2ywS34J6c5qHRRrVsuf4jL9MAguZjFcWPyTPd656D
         8AQT2E1XjS4Q5+tcWfTPduXdxL3H/GsMOt3eRdt3EMiwIveqzn3lqSni025oDhHP3BUt
         wq8xXUslzpzhOhORT5qzh4E9HAfILa0Xy2473shE2IwwTwoFJMife0Y3owPyFQY6pbyv
         nJiJiMqmUvcSgcD3qtaEk76PN85E2tnytcU6h9KN7ULUcEYNffvMo0d38XH5kP5olAam
         8jfW74zEl5oUZ/vGGWKOMSfAs20uatb2hIyEGLsNJh9zGPrimQWqUCIhyiXrhKmF+CXn
         hf3g==
X-Forwarded-Encrypted: i=1; AJvYcCWrKQnCUssqu3rwXPzrd1qkV8och7wpPTJqA7fZ/DQoJMao5/ujmeZZj6LH93YU7ZblqYJ5WMHB8zPrPBbZpuVrE+3EqX3inR+NFOpoJay7dB92BuphOYoJgQRa+YmnR3xV5TaJ81zJj4VwBwbdpak8I7lLyEYvhsenErFp056HCwtaTyf/CbIfEBQGQN3RVDY32ZN1NIaa5EfRQYUKLgn/DHlBvNEEwiAz4b/tuLxBL7M6NuYf3Z8bflw4uhhplBq5OXkLXH6QDnL5KTJlUrjafqQn26eRF+Ofws1W/4wjI0J4S4SJBmcPAF/wqU4yC170N5Z3ktYqUwbcaEPScZYcx8dNqtEChlX8UjGeQcblAwLP5ux1kc2Py/11XZd8AHbzNeWeitxoKCOsc0AEWRkC4iBoXscjW4EIsl/d+r0zCZB6nwuBNSSTYuXEJB7goal48MoEJz2Db21OPF3x37B0AdoONEU/igT5bmfbiQ2IFoTZuPf7+rKMkI72/ht/pF1ptajLww==
X-Gm-Message-State: AOJu0YzpFLhHUEWn6Dq0By+sdHcAR5+4e6vZspZxP+XBg0hIBPtVZvZJ
	Mdg+3Bg92Lu4T+yRjC4Z9jE0/9xvd8kmOXqni9tADxnke59+mcSY
X-Google-Smtp-Source: AGHT+IGAaHK3Sc+4l2nceOylDioj03KTZYisiZzBNDf0QqrfnPjsS5gVAqMxT1CZy/sHMpkrQYQHTA==
X-Received: by 2002:a17:907:9608:b0:a3c:d535:39b4 with SMTP id gb8-20020a170907960800b00a3cd53539b4mr2812254ejc.9.1707830964861;
        Tue, 13 Feb 2024 05:29:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAx0oFGv8fB8fAq7b4SaoJ1hkmfp3uRl+/+fWTscotDvrWHCHXLoRxfjmKebhxzaOp3oxyPgCcBy0wUW20nGfcHDfKvRtEVCBS5GMpx8HXIHoIIZMS6tP/VX099E08YFCUDuCULizMEnqQPd1i3pKNIDm55WsBNPz+QhIoaSX7ZFh72jKyCoa/amNFGhou++pfV+8YwZ2G+iSP9cnlYVHdylj+4X4J8yWRtWXX86jElRP8t/wE8pBpbYSrQOXQkKZC054KciMa6FURknOG0VlXdC0zp6ZuNvVs9CBiiFkRg+DpmEMQXqYWkhkv4yajMT0pumZHd9eBNJSCmXW+vX7/5Y7C+7qkpJXiJKz8j16QLsdpngzR8AXEYmkEC9mrljQ2qx2Uhf41HTaD45Ry/g8pZuMKJrnmXQ9XLrlDUHGHpVa5vMb/VpXYM0MX3wyEKSkBPn9WaxUHLCzuGEpSs4WQ18r7An+vsFd+e8kSbUhrIET4qj5kolbXe6g24ua4jN6md+Aek5+o8ZKZbFFueWGHcDlwIGrMxBopiiwcsibAijsP5b6ASTAPNQJbwSkKDd7Iv3h3GQ8E11aFoWyv5GC4lOpTFJVkrmvqK+P6SQqmsZhYG3SaaqodTQu0imQwcfkfN7B+ACpJ9uAKlKD3Dw0RgwAksL4zO+wWutuLiqMU4JAtWP153NOjVWQzg1bwYvvy52JSOLKxmdbbth1bOJOxn6FlT5/nbQVz51EHzTC6lw4ox1I2zht1n4/pXvC4xJMyQm5LTy5aX4s9LmAqDUthV9ozliVnKX1wcX2x81SYpQRV+q41d4NethsIuQTU2Ruz5p7bLd0LUUCo1w5qiRkNvVsYH13WxW6rA4YDENQs8F446oIN/ku79kaRptVl0Lva5vqnk3MUnZLnpMV70VqOX4zcmX35IyvdxW67Yf8MDXj8F/OCINzsJpFdiTmZlqjivJ
 m8Z42xDWPt1Ba9H9tb9tPjRDLBd4st4Hcyg2svskzdCdAkPcAa+7wE97qvwfc2NlGS594TjKcJNHcP8uWQHqRcG9MKdFvKUQi5K4Yx7/O+Z84C8r4t2DD596gEUR83otfc9AIEDhgTigpPbmG50ZfjCdk3F8yw6j8etrDcjqrYh4vc5ekJWbAZSIopGyRzXI4aAmCqPWw4sUmqZgbLlSSYbjpe9a32jEJQUWsYgoAPXKb9gebtHfRlySE/0SsQNhCBfZebL28mKl6U/8HhaTcio+qP0Qpf6LeAccr+QpnbqnPAc3XcEaGO0CXVFbb/7fUR/b9AUkPijwDgjwlScg+IVVymbuFOyTfBYxART1X01/ib6XlltUbAskeZwd1nCBIZlS8S3h+4EPpKwdC873ok2ZFaYD9UX9T2pxClQTPGV1cJOKWFYAp8VTG4gM0OMgK3l4ZxjvbO0GtCoZs4FytGj6Efn1+Vi+vml6fpoWKPbu3VcW78o+R8TwxB9cYuHOMWskd+chMBSWkNAEpn6dhBxYV88HAs3p+7Mv1ftWzYOmwrDOzTPf6msY+M+SJNyrsdRC4aujSEetlZVrwLxEq4aFRcEnCQMs5Oh0ocQ1HMGCXwsBeFb8mo/MLE+mDYnVmG1vI6VS58tk5B8xg/IfMMml78r0vQiu751j5ao+tWo75K1Ma4CXeIJy9XDr9mStFHCYpZ8Xk66GhkBASkiUu31WX3xD/AGf4EuM4NM6LTuj6OqdwTUuN2hpbg2hfsdEZeB5cchVr2/dNvrvI/ZWsi77TMoyxmlpZuBW+T4Hu9Yi3c+8dT
Received: from ?IPV6:2620:10d:c096:310::23d8? ([2620:10d:c092:600::1:a107])
        by smtp.gmail.com with ESMTPSA id ss3-20020a170907c00300b00a3d1c0a3d5dsm221682ejc.63.2024.02.13.05.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 05:29:24 -0800 (PST)
Message-ID: <dd4a6633-36d0-4654-a5e1-2824de29c130@gmail.com>
Date: Tue, 13 Feb 2024 13:19:43 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 08/14] memory-provider: dmabuf devmem
 memory provider
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231218024024.3516870-1-almasrymina@google.com>
 <20231218024024.3516870-9-almasrymina@google.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20231218024024.3516870-9-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 02:40, Mina Almasry wrote:
> Implement a memory provider that allocates dmabuf devmem in the form of
> net_iov.
> 
> The provider receives a reference to the struct netdev_dmabuf_binding
> via the pool->mp_priv pointer. The driver needs to set this pointer for
> the provider in the net_iov.
> 
> The provider obtains a reference on the netdev_dmabuf_binding which
> guarantees the binding and the underlying mapping remains alive until
> the provider is destroyed.
> 
> Usage of PP_FLAG_DMA_MAP is required for this memory provide such that
> the page_pool can provide the driver with the dma-addrs of the devmem.
> 
> Support for PP_FLAG_DMA_SYNC_DEV is omitted for simplicity & p.order !=
> 0.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
...
> +
> +static bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
> +					  struct netmem *netmem)
> +{
> +	WARN_ON_ONCE(!netmem_is_net_iov(netmem));
> +
> +	page_pool_clear_pp_info(netmem);
> +
> +	netdev_free_dmabuf(netmem_to_net_iov(netmem));
> +
> +	/* We don't want the page pool put_page()ing our net_iovs. */
> +	return false;
> +}
> +
> +const struct memory_provider_ops dmabuf_devmem_ops = {
> +	.init			= mp_dmabuf_devmem_init,
> +	.destroy		= mp_dmabuf_devmem_destroy,
> +	.alloc_pages		= mp_dmabuf_devmem_alloc_pages,
> +	.release_page		= mp_dmabuf_devmem_release_page,
> +};
> +EXPORT_SYMBOL(dmabuf_devmem_ops);

It might make sense to move all these functions together with
new code from core/dev.c into a new file

-- 
Pavel Begunkov

