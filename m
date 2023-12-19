Return-Path: <linux-arch+bounces-1138-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6468194DC
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 01:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD6E1C238EE
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FF17E2;
	Wed, 20 Dec 2023 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKmmh94W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63E40BE5;
	Wed, 20 Dec 2023 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a1ca24776c3so42141766b.0;
        Tue, 19 Dec 2023 16:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703030402; x=1703635202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwhJzmoPbvlufJXYZVSOwhyDBPsxrIm+e0rqKip7J9M=;
        b=OKmmh94WoF8v1IELhEjaTWfCwW/xeEmGbA8brBTJxz76u0by5oRKcfPsWLBvewhkoV
         SCCYLr/hUb65nO7sOi5bSKCez9cv/PURCmqq7P8hD3Hiv0qisx37QxFO+gc02/gaUYOt
         W/yzkNGf62a6XY4fU8FBeybIdYbgwePiIBnIrVTCErPDWVwOsJMEXCf9xI22+vBxa3Uk
         QXCFQVSpUI6pho9kfCz0YKte1soZBphv184LVsPtoXug8gZZ7sACQx6PTQxT7fk5SXn1
         x78JsYHIMK+ZMIWZraVL8JpsuiefZaC3T4NmorQlUbvff1R/OuzOC4tJBfIhIHPpeHB8
         cpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703030402; x=1703635202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwhJzmoPbvlufJXYZVSOwhyDBPsxrIm+e0rqKip7J9M=;
        b=rUe8Sw6TUUZnTX8mEV6sR1TDsK+yHTqECVQnOUb+bAFV4N/KGv9hPeJl7U6OOb7Mg7
         Kx2pZB1SVxaP24/rAkmRcIvkL8Xu7tBqHNUxnhtaHAbiyt/1FFv8F9tdBERz41a2vLPF
         ARcScpSJizg59m9V4Gly8xtl6UL3pYvuAggM18qrwzpwZG1kyLYy69pPysDW/56/YOA0
         CpOIVrFIzbA2fRdngeiAqHzKwG9it4y9m1XaLgD98n1SAU3RziumHFIJ6C3MX0btwMax
         tpUpZAxuPyoyR5GM28EJmRZwUqdPjKhAUq1Xh3DYZVr95AgznemKVFxC76WGvp5V+q0G
         8hLg==
X-Gm-Message-State: AOJu0YyK2LamWOIyRE3ogtrxsYTaGR3ISWuQwpgGb2luyXV6UZ87baW4
	zvH08U4AhjNS8lbAvDXQ6kw=
X-Google-Smtp-Source: AGHT+IEnzoyGyEaqEP1FV/hE9gguSDOlXvVD4FxAlOhLZGUxznuFC52CV3Bimn4dlMDdoJvMFHB9ag==
X-Received: by 2002:a17:906:5498:b0:a23:4e54:25c9 with SMTP id r24-20020a170906549800b00a234e5425c9mr1807264ejo.36.1703030402286;
        Tue, 19 Dec 2023 16:00:02 -0800 (PST)
Received: from [192.168.8.100] ([85.255.233.166])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906138b00b00a268d06d127sm326646ejc.7.2023.12.19.16.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 16:00:01 -0800 (PST)
Message-ID: <040a2f67-cdc2-4e75-84ba-36ec13cbc00b@gmail.com>
Date: Tue, 19 Dec 2023 23:55:01 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory
 provider
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com>
 <b07a4eca-0c3d-4620-9f97-b1d2c76642c2@gmail.com>
 <CAHS8izNVFx6oHoo7y86P8Di9VCVe8A_n_9UZFkg5Wnt=A=YcNQ@mail.gmail.com>
 <b1aea7bc-9627-499a-9bee-d2cc07856978@gmail.com>
 <CAHS8izPry13h49v+PqrmWSREZKZjYpPesxUTyPQy7AGyFwzo4g@mail.gmail.com>
 <661c1bae-d7d3-457e-b545-5f67b9ef4197@gmail.com>
 <CAHS8izOY9xm=LBEN8sYwEa3aFB4GWDvJVacom3o4mHZPdHzTUg@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izOY9xm=LBEN8sYwEa3aFB4GWDvJVacom3o4mHZPdHzTUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/14/23 20:03, Mina Almasry wrote:
> On Mon, Dec 11, 2023 at 12:37 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
> ...
>>>> If you remove the branch, let it fall into ->release and rely
>>>> on refcounting there, then the callback could also fix up
>>>> release_cnt or ask pp to do it, like in the patch I linked above
>>>>
>>>
>>> Sadly I don't think this is possible due to the reasons I mention in
>>> the commit message of that patch. Prematurely releasing ppiov and not
>>> having them be candidates for recycling shows me a 4-5x degradation in
>>> performance.
>>
>> I don't think I follow. The concept is to only recycle a buffer (i.e.
>> make it available for allocation) when its refs drop to zero, which is
>> IMHO the only way it can work, and IIUC what this patchset is doing.
>>
>> That's also I suggest to do, but through a slightly different path.
>> Let's say at some moment there are 2 refs (e.g. 1 for an skb and
>> 1 for userspace/xarray).
>>
>> Say it first puts the skb:
>>
>> napi_pp_put_page()
>>     -> page_pool_return_page()
>>       -> mp_ops->release_page()
>>          -> need_to_free = put_buf()
>>             // not last ref, need_to_free==false,
>>             // don't recycle, don't increase release_cnt
>>
>> Then you put the last ref:
>>
>> page_pool_iov_put_many()
>>     -> page_pool_return_page()
>>       -> mp_ops->release_page()
>>          -> need_to_free = put_buf()
>>             // last ref, need_to_free==true,
>>             // recycle and release_cnt++
>>
>> And that last put can even be recycled right into the
>> pp / ptr_ring, in which case it doesn't need to touch
>> release_cnt. Does it make sense? I don't see where
>> 4-5x degradation would come from
>>
>>
> 
> Sorry for the late reply, I have been working on this locally.
> 
> What you're saying makes sense, and I'm no longer sure why I was
> seeing a perf degradation without '[net-next v1 10/16] page_pool:
> don't release iov on elevanted refcount'. However, even though what
> you're saying is technically correct, AFAIU it's actually semantically
> wrong. When a page is released by the page_pool, we should call
> page_pool_clear_pp_info() and completely disconnect the page from the
> pool. If we call release_page() on a page and then the page pool sees
> it again in page_pool_return_page(), I think that is considered a bug.

You're adding a new feature the semantics of which is already
different from what is in there, you can extend it any way as long
as it makes sense and agreed on. IMHO, it does. But well, if
there is a better solution I'm all for it.

> In fact I think what you're proposing is as a result of a bug because
> we don't call a page_pool_clear_pp_info() equivalent on releasing
> ppiov.

I don't get it, what bug? page_pool_clear_pp_info() is not called
for ppiov because it doesn't make sense to call it for ppiov,
there is no reason to clear ppiov->pp, nor there is any pp_magic.


> However, I'm reasonably confident I figured out the right thing to do
> here. The page_pool uses page->pp_frag_count for its refcounting.
> pp_frag_count is a misnomer, it's being renamed to pp_ref_count in
> Liang's series[1]). In this series I used a get_page/put_page
> equivalent for refcounting. Once I transitioned to using
> pp_[frag|ref]_count for refcounting inside the page_pool, the issue
> went away, and I no longer need the patch 'page_pool: don't release
> iov on elevanted refcount'.

Lovely, I'll take a look later! (also assuming it's in v5)


> There is an additional upside, since pages and ppiovs are both being
> refcounted using pp_[frag|ref]_count, we get some unified handling for
> ppiov and we reduce the checks around ppiov. This should be fixed
> properly in the next series.
> 
> I still need to do some work (~1 week) before I upload the next
> version as there is a new requirement from MM that we transition to a
> new type and not re-use page*, but I uploaded my changes github with
> the refcounting issues resolved in case they're useful to you. Sorry
> for the churn:
> 
> https://github.com/mina/linux/commits/tcpdevmem-v1.5/
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=809049&state=*
> 

-- 
Pavel Begunkov

