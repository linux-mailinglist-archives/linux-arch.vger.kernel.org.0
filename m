Return-Path: <linux-arch+bounces-869-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0480B87C
	for <lists+linux-arch@lfdr.de>; Sun, 10 Dec 2023 04:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635751F21024
	for <lists+linux-arch@lfdr.de>; Sun, 10 Dec 2023 03:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2015A0;
	Sun, 10 Dec 2023 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoxyH//m"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0379B3;
	Sat,  9 Dec 2023 19:05:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so36402845e9.2;
        Sat, 09 Dec 2023 19:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702177500; x=1702782300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wxl9nnVIfiBOr8Rw+j4D/uD/Nj3r0oHUhj6QGiUGdeU=;
        b=LoxyH//m1WFoAMXNwx3y8v+IwHs6ATUWaj36ukRaIT4y83df4SPIPRUfmUMMy8R3XX
         Ues1NiyS+Q+YNwVa9L6lXBfKABFGkF/c7+RzNIrE4X7aySTz+KqMNMmNfdDWXqX45VtW
         B0yzygKqaqRG7mw1i1q5E32ybQ93m3CP1PEx0mF5GTk9Bdd3c+L/QlBbV20FiPyDTsJ0
         MGdB+RQ1lz0r6WSkSO1QDdXgfIQ7GYhzH9S73cyFLo8mtRkfznLYVt58V0kHpXXsuQdN
         iiY7kS0/HZWZbMzKKiEPRGgRcdjQDpSDueXV+1Zq6Wwh4z926z5fObOSIqdqEnqEO2SO
         o+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702177500; x=1702782300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wxl9nnVIfiBOr8Rw+j4D/uD/Nj3r0oHUhj6QGiUGdeU=;
        b=P8ar+Epx4ClcZp/udhkseNpty+T5ylx98BzwMkuiFHBnX6doNdPxGB9Nv2buqIWAcI
         Bknpum3/GXCx8m+gQDVHXHXx5i7IQ84/cd1XfQfKJrY4e16fx8cRFmwNs3W89zMJU2gv
         ivc2xBip95ONWt7/CrHEpVy94SdA0H/RpsqkCrfS2VNOV3boBZOGYf+o6MKiL9eyJIqo
         XAAjswsdRiKK0FYLh5BgFkTf+v/v0T9e31NCuSoaYlspuPWkIuXizduIpYl+wUFU63OX
         bb4LOUdonodr04UoRF3elaaKYLE5zJ4NXN/6ZS9aH13cteitMGEsLu6JntvZjS+6Fs7u
         /DCA==
X-Gm-Message-State: AOJu0YwJ0zpnSO4XgLAscswxIqDppGM0aic2MHJj2t2sH1CpKY+YRpel
	MSTKgtb3g2pfXJ/AxZqqDFg=
X-Google-Smtp-Source: AGHT+IHJipyQW4yFkljRQowJvIeShM9YAuwDKB6t4bKW0HKwLGG9Hrotr1J6QPfjejCHHrlkaexSCA==
X-Received: by 2002:adf:e282:0:b0:332:ef1e:bb88 with SMTP id v2-20020adfe282000000b00332ef1ebb88mr1266810wri.33.1702177500084;
        Sat, 09 Dec 2023 19:05:00 -0800 (PST)
Received: from [192.168.8.100] ([85.255.236.102])
        by smtp.gmail.com with ESMTPSA id fm21-20020a05600c0c1500b0040c03c3289bsm8341129wmb.37.2023.12.09.19.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 19:04:59 -0800 (PST)
Message-ID: <b1aea7bc-9627-499a-9bee-d2cc07856978@gmail.com>
Date: Sun, 10 Dec 2023 03:03:37 +0000
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
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNVFx6oHoo7y86P8Di9VCVe8A_n_9UZFkg5Wnt=A=YcNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/8/23 23:25, Mina Almasry wrote:
> On Fri, Dec 8, 2023 at 2:56 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 12/8/23 00:52, Mina Almasry wrote:
> ...
>>> +     if (pool->p.queue)
>>> +             binding = READ_ONCE(pool->p.queue->binding);
>>> +
>>> +     if (binding) {
>>> +             pool->mp_ops = &dmabuf_devmem_ops;
>>> +             pool->mp_priv = binding;
>>> +     }
>>
>> Hmm, I don't understand why would we replace a nice transparent
>> api with page pool relying on a queue having devmem specific
>> pointer? It seemed more flexible and cleaner in the last RFC.
>>
> 
> Jakub requested this change and may chime in, but I suspect it's to
> further abstract the devmem changes from driver. In this iteration,
> the driver grabs the netdev_rx_queue and passes it to the page_pool,
> and any future configurations between the net stack and page_pool can
> be passed this way with the driver unbothered.

Ok, that makes sense, but even if passed via an rx queue I'd
at least hope it keeping abstract provider parameters, e.g.
ops, but not hard coded with devmem specific code.

It might even be better done with a helper like
create_page_pool_from_queue(), unless there is some deeper
interaction b/w pp and rx queues is predicted.

>>> +
>>>        if (pool->mp_ops) {
>>>                err = pool->mp_ops->init(pool);
>>>                if (err) {
>>> @@ -1020,3 +1033,77 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
>>>        }
>>>    }
>>>    EXPORT_SYMBOL(page_pool_update_nid);
>>> +
>>> +void __page_pool_iov_free(struct page_pool_iov *ppiov)
>>> +{
>>> +     if (WARN_ON(ppiov->pp->mp_ops != &dmabuf_devmem_ops))
>>> +             return;
>>> +
>>> +     netdev_free_dmabuf(ppiov);
>>> +}
>>> +EXPORT_SYMBOL_GPL(__page_pool_iov_free);
>>
>> I didn't look too deep but I don't think I immediately follow
>> the pp refcounting. It increments pages_state_hold_cnt on
>> allocation, but IIUC doesn't mark skbs for recycle? Then, they all
>> will be put down via page_pool_iov_put_many() bypassing
>> page_pool_return_page() and friends. That will call
>> netdev_free_dmabuf(), which doesn't bump pages_state_release_cnt.
>>
>> At least I couldn't make it work with io_uring, and for my purposes,
>> I forced all puts to go through page_pool_return_page(), which calls
>> the ->release_page callback. The callback will put the reference and
>> ask its page pool to account release_cnt. It also gets rid of
>> __page_pool_iov_free(), as we'd need to add a hook there for
>> customization otherwise.
>>
>> I didn't care about overhead because the hot path for me is getting
>> buffers from a ring, which is somewhat analogous to sock_devmem_dontneed(),
>> but done on pp allocations under napi, and it's done separately.
>>
>> Completely untested with TCP devmem:
>>
>> https://github.com/isilence/linux/commit/14bd56605183dc80b540999e8058c79ac92ae2d8
>>
> 
> This was a mistake in the last RFC, which should be fixed in v1. In
> the RFC I was not marking the skbs as skb_mark_for_recycle(), so the
> unreffing path wasn't as expected.
> 
> In this iteration, that should be completely fixed. I suspect since I
> just posted this you're actually referring to the issue tested on the
> last RFC? Correct me if wrong.

Right, it was with RFCv3

> In this iteration, the reffing story:
> 
> - memory provider allocs ppiov and returns it to the page pool with
> ppiov->refcount == 1.
> - The page_pool gives the page to the driver. The driver may
> obtain/release references with page_pool_page_[get|put]_many(), but
> the driver is likely not doing that unless it's doing its own page
> recycling.
> - The net stack obtains references via skb_frag_ref() ->
> page_pool_page_get_many()
> - The net stack drops references via skb_frag_unref() ->
> napi_pp_put_page() -> page_pool_return_page() and friends.
> 
> Thus, the issue where the unref path was skipping
> page_pool_return_page() and friends should be resolved in this
> iteration, let me know if you think otherwise, but I think this was an
> issue limited to the last RFC.

Then page_pool_iov_put_many() should and supposedly would never be
called by non devmap code because all puts must circle back into
->release_page. Why adding it to into page_pool_page_put_many()?

@@ -731,6 +731,29 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
+	if (page_is_page_pool_iov(page)) {
...
+		page_pool_page_put_many(page, 1);
+		return NULL;
+	}

Well, I'm looking at this new branch from Patch 10, it can put
the buffer, but what if we race at it's actually the final put?
Looks like nobody is going to to bump up pages_state_release_cnt

If you remove the branch, let it fall into ->release and rely
on refcounting there, then the callback could also fix up
release_cnt or ask pp to do it, like in the patch I linked above

-- 
Pavel Begunkov

