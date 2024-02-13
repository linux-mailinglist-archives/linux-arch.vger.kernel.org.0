Return-Path: <linux-arch+bounces-2296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6192F8531BD
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 14:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192B5285AA4
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA155E6D;
	Tue, 13 Feb 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btMYa1Ey"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3F55C1A;
	Tue, 13 Feb 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830695; cv=none; b=YXUZY+haRnHMJ+QmeCo/zgTNsZztVvMUkuMCdINaMeWHGSXmxx4q4Dhu3DRK9Cjqo4z/ATfrLQTftXoZgZNqkVwYaKYP58ad/eFytvyrSf2w1/1eQilfclfqHcIBQFjTr6KmrrFD/F/2CmBxbHmGmMnHtK+Ki1l8A/+wgf3zLdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830695; c=relaxed/simple;
	bh=59TqRRl9p0ZETIIG/FXzqG6eofAWlEzd0c94odzx7/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UT0oyYDEGglUQ9TkWCsAZBc/bJwfjL5Y60rsLtGFRNPDIz1DBxf5Kjg1cjGDS21ZgoQ/L+SjBL0CZeb+PW6AYNNpq8CtFRG+sCVm6CWnF32FOa+7Wi9pRY9hgstJMt7qwzEJS6vuikbGER3K0Op2TVjrBdhW/0Alfmk+5Dy2HG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btMYa1Ey; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso6020915a12.3;
        Tue, 13 Feb 2024 05:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707830692; x=1708435492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QyYjoH+AqqQf6ghl+XM6LALnTPi51ZlBkMJjWYJ7D0=;
        b=btMYa1EyA4h8C8/eefQ7OTU5j8j9e3xUFMnq8DTLC6gOcE4FDjjf6fbOIj805oHxVT
         AC3XcU4JhfD+k6qt78JwMvuO2QgW7i9II5nVNau2UUdK0iNqi/a7rTS5KzI9RJJeLkqI
         BUSJPxCVzB1MlxH2bfDku6nbEdZY5HoUZyqlY/JWQIPFBtFiS/1GIzYKfH8QxW/4iorw
         oDntrnRQSSu6SK/OBtabnvnuIi0xJ7N9/rpPa+UJzwBkOyK5LpmP6+6kcyCHYExZVrKH
         xOoDZ3sZzFzL+oX/1Dw2dVGVF6JiH6mSr9qm6CaVUC6nmoIOuHmE5go6wfhzneQ5jFjZ
         CoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830692; x=1708435492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QyYjoH+AqqQf6ghl+XM6LALnTPi51ZlBkMJjWYJ7D0=;
        b=ug33i/csHo71ELSF2ut+fvS7ZIrrTnDF9Oar2FxC4A6h5YdgI8V+AJajGoxS4B28+3
         vNGLYDNyMLD1yZyQixvBYKqtHbrWLoriPVwNiVeRg7G8YUYaj1ogNRA/NGABFsJNItaC
         96qo5voPPkGCzhDR5aGQbQxRSW0Qi05a3IhjaDkwgE+Q1LnydGnx+GpeZoAYliszMw1q
         KCzpU9F5HHaDrHy6lnA9SDGv3THOcYNV9zFOZPY0RA7a5n+tFBOu4LDviOza2DECl334
         hhmsjSw3qmlH98+VkLUAuZe5jF3fEReg1Y15FTCmMqIx3HMYyHL0rSckJGHcJhBCiBZ1
         ky9A==
X-Forwarded-Encrypted: i=1; AJvYcCXcTHz3WqjquAloNpq27L1ro4BJc9TMrLlmA29DP0pwY7Xc/87lPeG2QRAN0nL72X90iIFeehuWAfRBDtv7fB3wDA/QDqG6Iiv1JQUNCkxj8w5H42atbcZLLxN/ip3OUUfB2ibr7MDvBnJJemp2Qcv2X7NZfucdiTud234BdQWtzgagIHZUSOvUFBQyKf6Fbu7CHcmqbcvWD1ZLzYxXkJ1LyJ0vF3NW/z12hKoOzekxbsoiMHKRjzc1qvbZbt+iry0n8k7QENTYRkTdLzrz1EgBDbc+6cSHOvjc+3XCAEaCd/JRUx/5AQ5GqgUlhD/Zaf/Hd1UddFodNbuAF+bHZER1Xfmew/vUHhHhQjVkE3Vs8yi+gdAtQsOFFOpxMngMvii9IHiBxgkjMtVdr/rUH/VfRA5o6oa6m3IFsO3IHImYG6hLGMeLrRUKZwgwjSnhyPzFx51AJGqLsy8A4SaAKc3xyKj3l2/tiso2RoBEH6fBQ4MhvPsILN1lgRY+q48BsDu9lTyfaQ==
X-Gm-Message-State: AOJu0YyVIYs0xNrGamwG1iuQbyvTf6ChFKspADKrSw1XkyPIVcaerkDl
	8v6dY1akdnIGC9YmTOn5Lno6n8ff+yjikQhjCZSn7p7IeG9DD0ar
X-Google-Smtp-Source: AGHT+IEvOYZMro6HR8cOXNPUYT9ZgCc4vRcUyvz622HX4ZCDWHklO0ODmEGlx46UXe5UhrZ820A4mQ==
X-Received: by 2002:a05:6402:3596:b0:55f:95ac:d698 with SMTP id y22-20020a056402359600b0055f95acd698mr7503927edc.32.1707830691640;
        Tue, 13 Feb 2024 05:24:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMeArKJi3EifAmOpZcv2Grgg9QOavC+wNyABJk3QLZgkNc7dOXBIDhbgy8vyOBMzsIrAMg6FrTdfqq7fwyR5rS+2iJZSxB/qmQAEIC1C1pB7TfSTnxP+fx13ldXqknLXUyTvQm3D6HdvE0YKiG62Us26JWt3npm8XPaqI9wVM7uGfq0QbE96JFT+LYhAB+W+FwwSi7bTZ4TRkyuc/9DU0cv2LVCr+rvOuhmUBAT4otlLbZm9JYT7Gb/SCjZ5OV5+ll1i1snATirzjnVrJzfPtE0/hYuUaVgoyNXCWtTnLPowekY81P9qkSPcVtd84PjsqjdGrsL2fNGFZEnbHcSvh5CYGQf2B2uGf2BofpqJJhDKcOT01XGpkxqj9v70H0Un4YGKaLxCfh1+5250VMj+waUOL6WvWcMrzfyseTPpoDkRBp4L8ZHuLLQyTJt4FrAuXja+bLhKwDQFwev99ad42GfufGTCKtRi+m6V9Ux+jhKo86FnyUr5R7cBp+NYO0fxy3F6DEGrQc8SH0ZYmIPlXq6OZwQfyJTz9KnKqFdKANS9Uq4VYesafVkDuF5CapSqUVXFTg+p/Pa13rAzk2q/FgOO5yacnYiIWg5S4Eaa4K1Ti+SgzjfQRV622HGf3+lNlZV+7iV3+J/sE+ft6cr/BtFGDVxlmic3zBJmpdlHqRckBqxyWOopqShkKQLpFgAEU5o38mRv70DSn/RNbvUKGe1mElMc/LkPbbHMDk+kjGEn7/Yq5UE7FDt6Zh5dz2rSrl+sKaHFhYVznDZR7n14ZcEylWSFsoa+g43I156d2UhVaNF8wOKD2fu7qIr3PHiNJfehYyF7Wmr84+QGesFaDSpvqEzEt2IIlKOd/KuWr45ctoOeN3EibzRaSdG4gXEubW5gJ0OEIifsXLv/HCy8Bxf0o/J5de6QM3zr4FijUzwJemHVQ/co7tmATUVldvLIICXf
 CIP5qDmyEYTAWaO4M1rQ11q8jNdj7sP3/cdMu8dYlTxUfELhGwSQX7KdjeI1WJpQg9IC5oR+NcK3wbN5vegyuTGdzm7+auiSLWF8HnWsFY68PsWpIWtV/dd2ZclddAz8PGWZsCPlS/zjrJ0Ymurg5TU6+Er2DLD36rt+PwoT3ggtvpTxvStbhZ9qXxFRBlHJmeAWqFbYhvIsniswygmR+AN4MRbypKK/gViMQ6AnHEKWhunUMirCeA+XPlvApszlNpZj2b49UlEA/Fv2gSkf6qmnXSW4D30DtfHIBs8HNpgsABcttGxCFCxZTWjB5QMwq/atg923vuboIb3o4uMzyYRsNviYeiS2DqNkQTWanwr0qsbgu9C20qbo3/ehtFpDSHBPyen61sVJDmtcPjquAi7dLUy9cxtDcKyPLSvQZ4aNLL2wEe2nGMq5kSJDZtqOs7OOqDIgkH0Yd9NTB2oGen6uU/efOYA7h5WwZElwofslyM9YrCfiZcPkjEf6vtrIQOtlGoWwIJRgbpDkdG7opM4YrEmT8U8nBM9A1aEA12kcIyzQLW94+2lb7MJYHOg+PrKRZXZCFbEOD+lgbfQki9jGXan3k2jGZuppHdRIIf9y+suKZH2riCtWMNkvHFbKX+1v7X0xnJcapXJw7qEtF+5Dk67dDlKhHCOjdPG6YGEoRr/1jmt1J11viRTPtzb0mmjgRyRlnOPJchCv2Ysw/TI0r1H8a0ryGeSOkGhgtamEBDuUs86JnW4sT9WCzH4nO9TOErXZo7rBDnpYdVt0pganVoza54ZkelCxQUtzuQmd+hBPHU
Received: from ?IPV6:2620:10d:c096:310::23d8? ([2620:10d:c092:600::1:a107])
        by smtp.gmail.com with ESMTPSA id b6-20020aa7c906000000b00560ba66587csm3657441edt.13.2024.02.13.05.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 05:24:51 -0800 (PST)
Message-ID: <94ff0733-5987-4bf5-a53c-011e03aa6323@gmail.com>
Date: Tue, 13 Feb 2024 13:15:08 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 05/14] netdev: netdevice devmem allocator
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
 <20231218024024.3516870-6-almasrymina@google.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20231218024024.3516870-6-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 02:40, Mina Almasry wrote:
> Implement netdev devmem allocator. The allocator takes a given struct
> netdev_dmabuf_binding as input and allocates net_iov from that
> binding.
> 
> The allocation simply delegates to the binding's genpool for the
> allocation logic and wraps the returned memory region in a net_iov
> struct.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v1:
> - Rename devmem -> dmabuf (David).
> 
> ---
>   include/net/devmem.h | 12 ++++++++++++
>   include/net/netmem.h | 26 ++++++++++++++++++++++++++
>   net/core/dev.c       | 38 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 76 insertions(+)
> 
...
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 45eb42d9990b..7fce2efc8707 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -14,8 +14,34 @@
>   
>   struct net_iov {
>   	struct dmabuf_genpool_chunk_owner *owner;
> +	unsigned long dma_addr;
>   };
>   
> +static inline struct dmabuf_genpool_chunk_owner *
> +net_iov_owner(const struct net_iov *niov)
> +{
> +	return niov->owner;
> +}
> +
> +static inline unsigned int net_iov_idx(const struct net_iov *niov)
> +{
> +	return niov - net_iov_owner(niov)->niovs;
> +}
> +
> +static inline dma_addr_t net_iov_dma_addr(const struct net_iov *niov)
> +{
> +	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
> +
> +	return owner->base_dma_addr +
> +	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);

Looks like it should have been niov->dma_addr

> +}
> +
> +static inline struct netdev_dmabuf_binding *
> +net_iov_binding(const struct net_iov *niov)
> +{
> +	return net_iov_owner(niov)->binding;
> +}
> +
>   /* netmem */
>   
>   struct netmem {
...

-- 
Pavel Begunkov

