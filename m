Return-Path: <linux-arch+bounces-5153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811B918335
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 15:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07ABF1F215AF
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C7718C324;
	Wed, 26 Jun 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOY4waer"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EEF18A930;
	Wed, 26 Jun 2024 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409631; cv=none; b=Nskh2wVHuRaa1O99Cj8Bm2HLncELHf9gg0S5cO2MFcWf+DJ5QWmj/ztOFLWN1l4l8ciQuY7JXlYUnYmvGsl9VASxHIctID9OA+uMiG7uHw6UjU2l3IUGF2WJ8DgYPPmgYVbEt7mGVws101olWQ31yrKIwXWeBs9anrWNFpZ5xZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409631; c=relaxed/simple;
	bh=rSsKiSc4dFI2tkoNlNTsDyIXyV57SbU85aojGhTzijM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IS4L1n5z0jO+9GfrS7x+Wa7lw9lsHTpb7S7XR6iot1aDA3Q/HIzX6bPm7ic4H1lEeodrZx5zyLFW1dNryAiVtf55rvRX5jPFj7iSinw5tyogS/a9X9ONHknpaPUWhGO0UTfRYhifi03+RetQSmuhRGjU94nZlVpb/H9+yiDS4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOY4waer; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6fdd947967so486955566b.2;
        Wed, 26 Jun 2024 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409628; x=1720014428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFl4a85rkCgH8ys4lWAdMJzDTuxnq6IRXeCuLnaU+Ko=;
        b=MOY4waermEgQGuDE/Z8Y91XE2m4Ji5CPK4kC3p6Mnk2ayoMVI/SG65zt2wESlXtPfK
         4KJ4dT4BFUpOpaqoqBlWyqtgZYxrT3/8odwLGRYevviDiMv3u7BAjD7RUzEyHt9YuKK5
         PyXWs1hBKTH9vAuyEruOFF3/bHxu4fYyxjQDfEfEbzdkQ1G1fYGeJy8RNL/IUF816Hlz
         8DMRrZjLvgY8p/ZJnJ4NUBnKKINfgZR8Qli/2ZiwTeDwklD+CYaVSCNTrIH/Mr/WvXQT
         tZTWS4RHhJLwZZeQ+AJs86bufZTrzfKtVErT6dvxHXJQuZs4VFxORPXmfXFmDK01rV/i
         kc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409628; x=1720014428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFl4a85rkCgH8ys4lWAdMJzDTuxnq6IRXeCuLnaU+Ko=;
        b=Jnt35k//YwAVGuzHfZh8oJyhuoIesVL/tvbkqP0HEX8lnlYYeSrhRkx8Uz47TFmy3n
         kCT2mmAk4/sMf1DMa4O0lGbfA5wwhDqD0FSCglggbXAzCO/UDnPedWOvbZbwqM9rlzPJ
         EfqLAFhs3FbD6bisISS2jTTIhysCDFhbNfrzoRpxygkCR3Hkf9pk/kVmDJlPXjttsPCF
         i0SQiGcf/K449qks1Sv77AJGFXWueLdGytrZ2igq43eECxIdhgw0XnBXOX2yUAglLdst
         w5sme/tI2ApZ+uPfUfQoA7CirHzA7Xhh98WOwH1alnItst7faEuWNPTcgRtVFJKLS7Y6
         aaFg==
X-Forwarded-Encrypted: i=1; AJvYcCVoYWzSe3SpUqdUjR/pFPb+AQ8AeNv6+vEvMb/FqwD1Jj/8rWL2+IT4AJtujG9kDovVVffMBBtAWAWjdodOZON+2mpYJo4c29u3bAG3cRyAzBtEtQt3KFN8KHk5I20ToPonF0rVhgBRe6YEhUnFfy2/nY8fUZooUev6k9iSU2y/8BMAKNNFWs245rr/OZlHApRW3vR2BDOI4CgWpWCAcVX2RCN6StbQPQiVQNx0upsDi6wXGX1JFHRRe/rAjEihGgNy7pJRWrtxIPs9FTb25FK90L8e+kYWWDzptlkH6AE3o+U1SPJzGLYfFB4QFHQNG5DA0OYjE/Yk1t3OLy5peSrFpj3DZN/YUVKM7ne8IrVCKunUcT8Fv2sewFa5Nl0f/pH5RrwFLCw5cLR5rD9iAdkkckIboLLpMrTNgT4eC1KmyG+g4wjBPGXju9FeykxzWr/gHQ3pi3eeJdldectuPPLgZFNve5eWRnnYzvUUmT73ZT9koxqV0yjXMkxAx6fpF+DgPiZuVQ==
X-Gm-Message-State: AOJu0YxHsN5weWDKj5nJu5tI3DNP8gz9E11kO3w4rW4xJSJWUBRqFnQM
	7RKQEuGE3D6RX391dTfXUL4lQ/V4+llJST0mSkd2z4Fl9tEMsB6m
X-Google-Smtp-Source: AGHT+IGD5mGfND6mvQHeN5VakSdcpLJO5iAUu9YTrHEpvfoG3vNqvyJwqGy3yIJ4e8gaM2b8isOyjg==
X-Received: by 2002:a17:907:c01a:b0:a72:8c5e:f3d with SMTP id a640c23a62f3a-a728c5e112amr201037566b.49.1719409628168;
        Wed, 26 Jun 2024 06:47:08 -0700 (PDT)
Received: from [192.168.42.3] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7244cbce5bsm425759166b.79.2024.06.26.06.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:47:07 -0700 (PDT)
Message-ID: <09bdd7e5-75ca-42d5-8e59-a8ec05da89c7@gmail.com>
Date: Wed, 26 Jun 2024 14:47:13 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 11/13] net: add SO_DEVMEM_DONTNEED setsockopt
 to release RX frags
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
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
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
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240625024721.2140656-1-almasrymina@google.com>
 <20240625024721.2140656-12-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240625024721.2140656-12-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 03:47, Mina Almasry wrote:
> Add an interface for the user to notify the kernel that it is done
> reading the devmem dmabuf frags returned as cmsg. The kernel will
> drop the reference on the frags to make them available for reuse.

The sock_devmem_dontneed loop is a bit crude, but that can
be handled by follow up patches.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9abc4fe259535..040c66ac26244 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
...
>   
> +#ifdef CONFIG_PAGE_POOL
> +static noinline_for_stack int
> +sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> +{
> +	unsigned int num_tokens, i, j, k, netmem_num = 0;
> +	struct dmabuf_token *tokens;
> +	netmem_ref netmems[16];
> +	int ret = 0;
> +
> +	if (sk->sk_type != SOCK_STREAM || sk->sk_protocol != IPPROTO_TCP)
> +		return -EBADF;
> +
> +	if (optlen % sizeof(struct dmabuf_token) ||
> +	    optlen > sizeof(*tokens) * 128)
> +		return -EINVAL;
> +
> +	tokens = kvmalloc_array(128, sizeof(*tokens), GFP_KERNEL);
> +	if (!tokens)
> +		return -ENOMEM;
> +
> +	num_tokens = optlen / sizeof(struct dmabuf_token);
> +	if (copy_from_sockptr(tokens, optval, optlen)) {
> +		kvfree(tokens);
> +		return -EFAULT;
> +	}
> +
> +	xa_lock_bh(&sk->sk_user_frags);
> +	for (i = 0; i < num_tokens; i++) {
> +		for (j = 0; j < tokens[i].token_count; j++) {
> +			netmem_ref netmem = (__force netmem_ref)__xa_erase(
> +				&sk->sk_user_frags, tokens[i].token_start + j);
> +
> +			if (netmem &&
> +			    !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
> +				netmems[netmem_num++] = netmem;
> +				if (netmem_num == ARRAY_SIZE(netmems)) {
> +					xa_unlock_bh(&sk->sk_user_frags);
> +					for (k = 0; k < netmem_num; k++)
> +						WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> +					netmem_num = 0;
> +					xa_lock_bh(&sk->sk_user_frags);
> +				}
> +				ret++;
> +			}
> +		}
> +	}
> +
> +	xa_unlock_bh(&sk->sk_user_frags);
> +	for (k = 0; k < netmem_num; k++)
> +		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> +
> +	kvfree(tokens);
> +	return ret;
> +}
> +#endif

-- 
Pavel Begunkov

