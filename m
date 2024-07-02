Return-Path: <linux-arch+bounces-5224-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B764924153
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3327B1C23FB1
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0261BA095;
	Tue,  2 Jul 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbH6HACB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738315B995;
	Tue,  2 Jul 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931884; cv=none; b=YZV9wXkStbCUTTsGxC8/K9D2bb1j4DJeVg8FU+O8RFwagYzHueBFzBNmOodXFimAetaYdW1VRYjL+dl7ho8Tp7Il316w3TlehMPKwA2h7Rp6dyfQ4WwlsQGp5biZyETaFXNnMBld8qqtl60Wn1yplW33EQMRjaww9yZjUkrtqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931884; c=relaxed/simple;
	bh=a6MsgyRv5ETlLiC+FFxBcEYINP46U3opPqsO9hRNSEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbC/rGhMHwF2lOrri/qzkETr4/4Q3BN4KpD9UgSILMtGl8Goys2JFsD3q7ZSxTNgt5DfBbxZsZrYsIJwVFV3ZFYXimq/Q5VOyo9tGtaD/YJ7jX3Nn03VT71xzBAE60psDIO92VhTTWNVPgVtdk3cDycbdYgc0ccZDTM6z3pNyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbH6HACB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-425809eef0eso16896815e9.3;
        Tue, 02 Jul 2024 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719931881; x=1720536681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9exeTGo15NDIXtZ8CZttQ0DqkF9R2Zr4DFJbKqAaPNs=;
        b=fbH6HACBfuTgGeRjrV+1iAxXV1fDV/GLue6zWfnKxXb7qetANEJ6UVDjIqQXes8GoN
         Qqp4UMuKsOjZv+h50QXKqlIZUXdzAi/AXjLr+D3rIq+FudB0b9KG+VIQMInUdcvAPlhg
         dhd6aWd/Dtl92qLhriLDBNRPjY2OoOqxv+aPeWBbm3qtMj7KhDi5jTij/d7wlkv2YYnA
         NJMau2Yg79UKkS2EFo0Xl5idpS490C+D7mzrPnrI/CJjI9JDjZJcaOix6ABJOuB1um74
         mVs3mr7cN25ApYaRpB/tOC0zuRp/lggWRiCd9+aH2p0UQHt1LcRFEq9bIUP4J8FgPM1N
         fP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719931881; x=1720536681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9exeTGo15NDIXtZ8CZttQ0DqkF9R2Zr4DFJbKqAaPNs=;
        b=HKPByz/OZW+qnrSxTx8c3j/O4g8fOlre3p+ujKy9Ms4UkFxtHzlMFpKSg3fNNIAP4C
         m5CSdTSdyAISInDNPoCGQ5l9jdqOHAn/UbCI0yg0sOdxq+ChyYviu5dkP/WAqd01o9Of
         6B+tP93riGGTHcD1NEU8OKmH89q9PQfNBLOVsjPQ4lRIGFQA14avzlt1HC1D76EOWYHf
         QNROcivOg693bW8+J5g4AARJ0GDZL+vPvEW5jiBln3xtovLd6gqhw4iG1ZHL7wv7iS3z
         Qe5WjiksXCaSvFlh7/Mv5lfk6CiZLJztK/3+YCSO1XvAfeuJa+G6bKJ0J4/CSlilSoLg
         y+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiTIa2nSMURR/CpeKfoeiOVOiEC/rxMJ+LAZ7q+SAxK+fgF4GtQGlFS0pjG9GHuVQ9pOgRTgtLZ5aanuEjAQyhOWSX72brY+WcvRwgKGanF0UCeXHB7G7l5XNqpLV5Gvq0uvhDfIXIq4dYZocZKfT7gqNRE5TjHoOVWqH9f/pvY6I3DFFaHhb9q0M/d3b4xZpkSh08c2+qr4q+SqPxh7PHCGYwB2gdxr5pDcACsOVobIWtLZHw8rySsfWCaL33nQYBpDL26+TCZKxw8cPzyE8JcqoD5izT9QwTPPvYsQI/m93nIFdQks9ZCZjufbdInqJk9hOtMtpLMFhAwFf1W3lvNErW38zxWjenJjinAwEfMW0neDAsLxM8WrrK3LlYdzf/kD/OxAG9JAj8/N1i0Ghoq3Y7LTeRasOQIy1FMB4QFXAuD5xjne/tP8O8EANecIRUvssAqxqiWiQduouyta9bNsOdyLipV96PFoKkjbvuw1Yb9KbbJ7SaNH5iBIez9mHFuhiJyA==
X-Gm-Message-State: AOJu0YxwqvCnHFtwiFul6H4V6o3sZJ2Q1SspoTL+gFWWPiGSpOP1vIGo
	yVvtHj0AU97Ol/z6Ep5Yt6i2pnFEdzWZvIfADOaZYzliJQ7mErpG
X-Google-Smtp-Source: AGHT+IGzOBc1vQHu0QBwklnUCvbjhak188JOOHMbtiFlqkhdFm9lr/bH6DiMEipX26Z4kjyu+6WAGA==
X-Received: by 2002:a5d:6c6a:0:b0:366:ead8:6019 with SMTP id ffacd0b85a97d-3677571b6c7mr7819432f8f.49.1719931880435;
        Tue, 02 Jul 2024 07:51:20 -0700 (PDT)
Received: from [192.168.42.74] ([148.252.146.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba0bsm13413733f8f.69.2024.07.02.07.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 07:51:20 -0700 (PDT)
Message-ID: <8335651b-3296-460a-b9a6-4a36a7ec8bc8@gmail.com>
Date: Tue, 2 Jul 2024 15:51:27 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 10/14] tcp: RX path for devmem TCP
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
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-11-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240628003253.1694510-11-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/24 01:32, Mina Almasry wrote:
> In tcp_recvmsg_locked(), detect if the skb being received by the user
> is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
> flag - pass it to tcp_recvmsg_devmem() for custom handling.
> 
> tcp_recvmsg_devmem() copies any data in the skb header to the linear
> buffer, and returns a cmsg to the user indicating the number of bytes
> returned in the linear buffer.
> 
> tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> and returns to the user a cmsg_devmem indicating the location of the
> data in the dmabuf device memory. cmsg_devmem contains this information:
> 
> 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> 2. the size of the frag. 'frag_size'.
> 3. an opaque token 'frag_token' to return to the kernel when the buffer
> is to be released.
> 
> The pages awaiting freeing are stored in the newly added
> sk->sk_user_frags, and each page passed to userspace is get_page()'d.
> This reference is dropped once the userspace indicates that it is
> done reading this page.  All pages are released when the socket is
> destroyed.

Already gave it in v13, but it got lost

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

