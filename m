Return-Path: <linux-arch+bounces-4245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B08BEA49
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F7D1C23EA8
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61BC1649C8;
	Tue,  7 May 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkKTbYGO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56BCA951;
	Tue,  7 May 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102257; cv=none; b=Z7++Qrvqv2FwH4fBzksGppMD30CmjKv5yAN/Pcr/aQySolBahEcmNnt1jSR+p13gn++rysEe+iy2MOjIFvsjMjgA56chmhAr4O0Aoul5yf13XGoxfqQYRLhxPt9JlIME9xsnqXsZfHTGGNB6fVc2wCsCT2AOV/SGfNttkQOJHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102257; c=relaxed/simple;
	bh=HnZDIzUIeObivI72n0yspVyYWiN2ICxAA4O4Y/xi8QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pROuzWNaecIpVhhEq0PSzP/IVQ1etkkXQ+ws50eBdcIh7YicWWMhgP2o1YCIy+OiSHvRqol78umxX9V+3W5Kcjdo7uEUV53oS+sO93uqXNNhE3uPs/XDraetO03Dd5TPa1IFnkR87c6U5ZbIveP1j9GfTWJ1YdT7mmbfl8HDn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkKTbYGO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso35765125e9.3;
        Tue, 07 May 2024 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715102254; x=1715707054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJ80Ll1dX/ur3jQ8gDv1wRzdWsBKiGgm1wdEFnXS+WM=;
        b=fkKTbYGOPl8pBCKbFDrxnT/Lz/NSNqFk4Us4ez0Bk6FDJkgjnN4tonU8WC+7D6rhQZ
         CJblPMUFfY2YCqu/jeA4zOuSnWYzT0MvJejuaE62oySLHpNQ60+9ND+9Fip+AsVOZ/wm
         skhnQdeCA35+NbAVr5Kk5YRWL55z6p4qKknWB8N+nRoFsIWYGKPiGgWkmy33t1oCmFAQ
         CylMIY4+aSKmoyQGuchKw5gERQRMRE0M7F61tm3WlJy+c8FpxJNBClWNknVpLVMHyqyl
         GXON8PdtW7VTCu8twU0fP03/71T7O1XeO9g+ivW4SJLgJND0NLf14wZQ+4GmFzJlQ9iy
         46ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102254; x=1715707054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJ80Ll1dX/ur3jQ8gDv1wRzdWsBKiGgm1wdEFnXS+WM=;
        b=X2tfI7ZnAoQ1/2EfixOAA6EkID7cfbKRiXOo63PHBhLN2egG1kTiu5OL/pSaNp+0SS
         Eq4K40xgv2PGIgFJ//F914iP7kmjfUKLwoFSTMx74dub+NtfUwHxhbXkcF6d23Lrgkih
         SP0NNvMvTe9s8CKVzukWM5w+rdBGFDGx7CvhfZGmbF0H6dLYLnmS4CzIRxx7ttD+PBHi
         PcMMbzXJ5Od177aVHV+V6AIZZ1N9noF/xFAxgoQDogeBx0WiXc4UzfDs9ONKcHFRuPte
         0FBfCW/VbnbjgGF85T/xZEHmIdDyGYmgwU9iFYFjoaLL9I5nKOmMrXalXrwggkme/3q8
         4oFw==
X-Forwarded-Encrypted: i=1; AJvYcCWYI84Waa8MNHmypaAdYXSreXlgoyRF/Jr3Fv7JnDAYWEAg0AOW4InwlnmWEsuzOqScsZXWRq8CD6QzpJjMbZBR+R1+oQeer/ho78c/vSm70WZhTknYbOdT/qtyFHm1wpHt+APbds9+Q14nLgk1mw/EA+fiHW0lH3eXPRWLnYpQ8N2s86upr9pcDl8GWCv78EQIMaa4BeXOttycWVIZjVm7Ob9EQp1Ak0r5lk0T3Zflm4te//4mPGq8R2puDwSF9UVWI4B7gvcoeqngo/EE94jlrwa0Gd+hqz4yMLBL059FWU3V2qSmAuoN22VHhaL+G3e+YKLPBQxwH60wtjcsdS+oLZY3HkLVBToMDxl0LChiWodZC32VDzEbT3dI0iDl8mbr3kSPfwQzS5/J700UN0wdiY/P6wTGoRoASZZbekITz526RYPseMSFEdWe9xVobdDtHNBGqW6XEtkMifi7eHafNbkoKJvVU37AdlX3xpLPzXbmhN5YbGqTyud/bqb7bJVY4b41HA==
X-Gm-Message-State: AOJu0YxFmVSKBRihqu0rnnQTmioji8znLuvqWvm46RE9J9fcZY+EpB8y
	thecfmNYMNwIDJlIKiZ9diTedniGIv1jKNLgSHvFT+feqjD1d0us
X-Google-Smtp-Source: AGHT+IHDlSuGL/qwu9xfAiJAS8LLw8j/Re0JFANbHekhpws972LyKLt2Ety9djuJuyXbW7/Wjtrm6A==
X-Received: by 2002:a05:600c:4e4f:b0:41b:e94f:1e88 with SMTP id 5b1f17b1804b1-41f714f9859mr4326055e9.24.1715102253935;
        Tue, 07 May 2024 10:17:33 -0700 (PDT)
Received: from [192.168.42.69] ([85.255.235.91])
        by smtp.gmail.com with ESMTPSA id bd23-20020a05600c1f1700b0041bfb176a87sm24024038wmb.27.2024.05.07.10.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 10:17:33 -0700 (PDT)
Message-ID: <b9018728-ebfd-4021-9028-991103d56702@gmail.com>
Date: Tue, 7 May 2024 18:17:40 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
To: Mina Almasry <almasrymina@google.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Christian Brauner <brauner@kernel.org>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Florian Westphal <fw@strlen.de>, Yunsheng Lin <linyunsheng@huawei.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>,
 Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Richard Gobert <richardbgobert@gmail.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>,
 Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com>
 <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/24 17:42, Mina Almasry wrote:
> On Tue, May 7, 2024 at 9:24 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Tue, May 07, 2024 at 01:18:57PM -0300, Jason Gunthorpe wrote:
>>> On Tue, May 07, 2024 at 05:05:12PM +0100, Pavel Begunkov wrote:
>>>>> even in tree if you give them enough rope, and they should not have
>>>>> that rope when the only sensible options are page/folio based kernel
>>>>> memory (incuding large/huge folios) and dmabuf.
>>>>
>>>> I believe there is at least one deep confusion here, considering you
>>>> previously mentioned Keith's pre-mapping patches. The "hooks" are not
>>>> that about in what format you pass memory, it's arguably the least
>>>> interesting part for page pool, more or less it'd circulate whatever
>>>> is given. It's more of how to have a better control over buffer lifetime
>>>> and implement a buffer pool passing data to users and empty buffers
>>>> back.
>>>
>>> Isn't that more or less exactly what dmabuf is? Why do you need
>>> another almost dma-buf thing for another project?
>>
>> That's the exact point I've been making since the last round of
>> the series.  We don't need to reinvent dmabuf poorly in every
>> subsystem, but instead fix the odd parts in it and make it suitable
>> for everyone.
>>
> 
> 
> FWIW the change Christoph is requesting is straight forward from my
> POV and doesn't really hurt the devmem use case. I'd basically remove
> the ops and add an if statement in the slow path where the ops are
> being used to alloc/free from dmabuf instead of alloc_pages().
> Something like (very rough, doesn't compile):
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 92be1aaf18ccc..2cc986455bce6 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -557,8 +557,8 @@ netmem_ref page_pool_alloc_netmem(struct page_pool
> *pool, gfp_t gfp)
>                  return netmem;
> 
>          /* Slow-path: cache empty, do real allocation */
> -       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
> -               netmem = pool->mp_ops->alloc_pages(pool, gfp);
> +       if (page_pool_is_dmabuf(pool))
> +               netmem = mp_dmabuf_devmem_alloc_pages():
>          else
>                  netmem = __page_pool_alloc_pages_slow(pool, gfp);
>          return netmem;
> 
> 
> The folks that will be negatively impacted by this are
> Jakub/Pavel/David. I think all were planning to extend the hooks for
> io_uring or other memory types.
> 
> Pavel/David, AFAICT you have these options here (but maybe you can
> think of more):
> 
> 1. Align with devmem TCP to use udmabuf for your io_uring memory. I
> think in the past you said it's a uapi you don't link but in the face
> of this pushback you may want to reconsider.

If the argument would be that we have to switch to a less efficient
and less consistent api for io_uring (fast path handling used buffers
back to kernel) just because it has to has dmabuf and without direct
relation to dmabuf, then no, it's not the way anything can be sanely
developed.

> 2. Follow the example of devmem TCP and add another if statement to
> alloc from io_uring, so something like:
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 92be1aaf18ccc..3545bb82c7d05 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -557,8 +557,10 @@ netmem_ref page_pool_alloc_netmem(struct
> page_pool *pool, gfp_t gfp)
>                  return netmem;
> 
>          /* Slow-path: cache empty, do real allocation */
> -       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
> -               netmem = pool->mp_ops->alloc_pages(pool, gfp);
> +       if (page_pool_is_dmabuf(pool))
> +               netmem = mp_dmabuf_devmem_alloc_pages():
> +       else if (page_pool_is_io_uring(pool))
> +               netmem = mp_io_uring_alloc_pages():
>          else
>                  netmem = __page_pool_alloc_pages_slow(pool, gfp);

I don't see why we'd do that instead instead of having a
well made function table, which is equivalent.

>          return netmem;
> 
> Note that Christoph/Jason may not like you adding non-dmabuf io_uring
> backing memory in the first place, so there may be pushback against
> this approach.

Christoph mentioned pages, we're using pages, I don't think it's
too fancy. I don't believe that's it, which would be equivalent to
"let's remove user pointers from the kernel and mandate passing
dmabuf only".


> 3. Pushback on the nack on this thread. It seems you're already
> discussing this. I'll see what happens.
> 
> To be honest the GVE queue-API has just been merged I think, so I'm
> now unblocked on sending non-RFCs of this work and I'm hoping to send
> the next version soon. I may apply these changes on the next version
> for more discussion or leave as is and carry the nack until the
> conversation converges.
> 

-- 
Pavel Begunkov

