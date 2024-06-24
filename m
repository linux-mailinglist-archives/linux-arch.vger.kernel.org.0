Return-Path: <linux-arch+bounces-5029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9C6913F5E
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2024 02:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F16281357
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2024 00:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D6635;
	Mon, 24 Jun 2024 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz3qcVZp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA7621;
	Mon, 24 Jun 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719187968; cv=none; b=oxL205U3nRd/TzG3MS1DXgNwErj9fBCoB0TBx/sr5f8Tnk/IRpxzSDBQKaFpZPaiQ0xxEeqR1Zd2T/oJezNl3JQrnraYZF3z8DGJdoiUrK4OgB5Dvajo9ZJBbJ+u/5OPvLB4wk6Nb0O5A4nSZr/2S7ga4fzggjYX+ZXhnTIIBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719187968; c=relaxed/simple;
	bh=Dtz74yhHwYpDw3fJBW6H7VeyaYJ9g919PD91SKaeiBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOmEI+JO4XLUaQqmE0BXpr6Iwv3ZZfjWLe/Qv/nn3rpPY83+XF4aKCpOeNoieLEvaNPHjD3sxzlTcz3UL7cZksiQB+Ms0tOUUMQNPixL/HkKEX+thn5dj0s2O9aZ65bjzZSB/PM476+9JtWLejptfI+UXxWyWwZ/WC047J3dVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz3qcVZp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a72420e84feso140806866b.0;
        Sun, 23 Jun 2024 17:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719187965; x=1719792765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvaQpB4RyD6IuxTPoGyM/+nSxIU6CnaaMjIhdH54n8k=;
        b=mz3qcVZp3FagLW1XRPVyCI8Kn0OkchjMcGxWCejgsIaq+s16izTTUSbhN4JoPzLyf/
         wwhtzhfhVyuaxjYHuOmHhhfu4i4VdJOXuyo3Ufu93Ra1LlX56Fejrrb8G0F1b4uOJVfe
         cv85LvDdgdaU5kEiAuBjFUHXaXnrJC3LfLuDFyqcHpII1rjGFasqXJYNc8awN8VupTGN
         BmHqrpp7UvWt83GxPwYwdgfwJUOdkocJPTgnSN/RQlDwtT/hS3jNSN/MbNcBt6AdFs4A
         NWymQ5KpZbcGVONYM3O5hOIxXW/v+PVlMPWjuIuF8ON3iFASeC264GupgvhfGafkKZmt
         K/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719187965; x=1719792765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvaQpB4RyD6IuxTPoGyM/+nSxIU6CnaaMjIhdH54n8k=;
        b=NhHT9u/qThPisl364Gu2G44NIns8cHJo5cEHRU4uKvKaM1oDkjXdj75cvaANEEFF7I
         j8iA/Iog2WguzSclB+cv6h1Z1ztQVbCZFFpIljVRgkyuOOMtfWZPaOSSEJCTg50PIOyq
         gDtSo2Z7E8k01F/bSqA5AdHCRWZjMxEGK4trt4gDd2bhOBWUVw64d15I8BzuHOeWt4bT
         PX6tSc/SKLrz9HadDgF5fvq5tP/mhAUWEbZMDXEvV9QKpGJzfX7hg6IpCJ3d7tJvgmgE
         YtL8kfQWqG3MpSt9ovHR3zG6odPITFoo/g9jeZwi7KqZ+h3vg6uluM8xsEQvb8k942JJ
         Mm8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA3wnTtpGpzFN1v+u4oa6o/+lpOqvZ+BWj5i4L0b4qJ9qIQqEywOXJuBA2w/xAU+Q27tsza9lx+1McNJe15gr4PKjyv2VuKPmEOP0qPqgc7Pe4jlJ0MLqXeqsQ6O7bhLVqSXlQJJ7KMdb3Rds5ut1A0Atct7i0Oj0dTaNOwkIMPsmenfbhzDB9zFjuQk25uOHqOC1WOWc2x3ley8yGdLwfAex8PoKORHdAXYbvh3/jXYWpIhX0pYsOgUb3leQjkG+nsYrZ6WCm/Pti17/6mrg+iBD3W8KN60bLkzcDG3bAUgSQdBbNy8DtCnvzWuY9i3mOxrI++BOW+ERT0N5YLSQSIAU9UQZSzIblIMh1UpvS5hWuYOs7T8L2aHXWypNkTPAu3kppvGnoaahx1rCNn6itHB3vV28tRII4FpLOOvKxYSJMy33Fw5IfJVUmTffbMdQ1TFYRFxBFRC4r3FnLHUEiYGr748LR31Vbv0Tbpp4RMWAo2YS4shyqdZnxwHgSJiLSkKsAIvMxN8Vc1QQx1s7y
X-Gm-Message-State: AOJu0YwhhNfGrwdYAZ59IjzkhzgiKh7209mf5njy/1B/PZhWiba3KUe3
	/w87at2PtBzPDSVfYN6F1S98SxOvMnrTpj8kmtx9tSsCv4WTDDvF
X-Google-Smtp-Source: AGHT+IGgM4Pak9lc8GEauUfyhm0F0Xk1SzKJKpjX/HE+7j2CHx6ksKDfL8SEj9rmyvNGMfWyx9JATg==
X-Received: by 2002:a17:906:2657:b0:a6f:2e80:6e04 with SMTP id a640c23a62f3a-a7245ba3902mr238843866b.19.1719187964975;
        Sun, 23 Jun 2024 17:12:44 -0700 (PDT)
Received: from [192.168.8.113] ([148.252.133.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72479f360bsm142254266b.173.2024.06.23.17.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 17:12:44 -0700 (PDT)
Message-ID: <c9333388-6906-4df9-92b4-ecfd324f5891@gmail.com>
Date: Mon, 24 Jun 2024 01:12:46 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 06/13] page_pool: devmem support
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-7-almasrymina@google.com>
 <439590d4-0f05-4f5e-80ec-e7fdf214e307@gmail.com>
 <CAHS8izNr4x6SW0oY_VJDPZOsrBQEAyJO1qVJQbu8VNJQMtX9Sg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNr4x6SW0oY_VJDPZOsrBQEAyJO1qVJQbu8VNJQMtX9Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/21/24 19:48, Mina Almasry wrote:
> On Mon, Jun 17, 2024 at 7:17 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...
>>>    static inline unsigned long netmem_to_pfn(netmem_ref netmem)
>>>    {
>>> +     if (netmem_is_net_iov(netmem))
>>> +             return 0;
>>
>> IIRC 0 is a valid pfn. Not much of a concern since it's
>> used only for tracing, but might make sense to pass some
>> invalid pfn if there is one
>>
> 
> AFAIU all non-negative pfns are technically valid pfns if the machine
> is big enough.
> 
> I could have this function return long long instead of unsigned long
> so I can return a negative number for errors, and then cast to
> unsigned long when I figure out it's actually a pfn. Seemed like such
> a hassle especially since the call site is just tracing that I figured
> it's not that worth it.

Yeah, sounds like an overkill for tracing

> 
>>> +
>>>        return page_to_pfn(netmem_to_page(netmem));
>>>    }
>>>
>> ...
>>>    static inline netmem_ref netmem_compound_head(netmem_ref netmem)
>>>    {
>>> +     /* niov are never compounded */
>>> +     if (netmem_is_net_iov(netmem))
>>> +             return netmem;
>>> +
>>>        return page_to_netmem(compound_head(netmem_to_page(netmem)));
>>>    }
>>>
>>> +static inline void *netmem_address(netmem_ref netmem)
>>
>> I don't think it's used anywhere, do I miss it?
>>
> 
> Ah, It's used by the GVE devmem implementation:
> https://github.com/mina/linux/commit/da89baa81873d457cbf7b49ee6b4f0d66855b205
> 
> I could leave it out of this patch, then add it with the follow up GVE
> devmem implementation, but I figured almost for sure drivers are going
> to need this eventually, and it's small, so just put it here.

Either way is fine by me, checking the function is not leftovers


-- 
Pavel Begunkov

