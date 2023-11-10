Return-Path: <linux-arch+bounces-113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F333A7E79C9
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 08:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B045C28158E
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 07:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A7B6AB1;
	Fri, 10 Nov 2023 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF129A5;
	Fri, 10 Nov 2023 07:38:34 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC3869B;
	Thu,  9 Nov 2023 23:38:32 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SRVtv2NmgzMmjR;
	Fri, 10 Nov 2023 15:33:59 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 10 Nov
 2023 15:38:29 +0800
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to netdevice
To: Mina Almasry <almasrymina@google.com>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Ahern
	<dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Shakeel Butt
	<shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-5-almasrymina@google.com>
 <076fa6505f3e1c79cc8acdf9903809fad6c2fd31.camel@redhat.com>
 <CAHS8izOGSE-PJ1uShkH_Mr6kUoC1EjM_9P1J=_TO6nLFP9K53Q@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <aec0f586-c3b9-8da8-6a39-f313105267f8@huawei.com>
Date: Fri, 10 Nov 2023 15:38:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izOGSE-PJ1uShkH_Mr6kUoC1EjM_9P1J=_TO6nLFP9K53Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/10 10:59, Mina Almasry wrote:
> On Thu, Nov 9, 2023 at 12:30 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> I'm trying to wrap my head around the whole infra... the above line is
>> confusing. Why do you increment dma_addr? it will be re-initialized in
>> the next iteration.
>>
> 
> That is just a mistake, sorry. Will remove this increment.

You seems to be combining comments in different thread and replying in
one thread, I am not sure that is a good practice and I almost missed the
reply below as I don't seem to be cc'ed.

> 
> On Thu, Nov 9, 2023 at 1:29 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:> >>>
>>>>> gen_pool_destroy BUG_ON() if it's not empty at the time of destroying.
>>>>> Technically that should never happen, because
>>>>> __netdev_devmem_binding_free() should only be called when the refcount
>>>>> hits 0, so all the chunks have been freed back to the gen_pool. But,
>>>>> just in case, I don't want to crash the server just because I'm
>>>>> leaking a chunk... this is a bit of defensive programming that is
>>>>> typically frowned upon, but the behavior of gen_pool is so severe I
>>>>> think the WARN() + check is warranted here.
>>>>
>>>> It seems it is pretty normal for the above to happen nowadays because of
>>>> retransmits timeouts, NAPI defer schemes mentioned below:
>>>>
>>>> https://lkml.kernel.org/netdev/168269854650.2191653.8465259808498269815.stgit@firesoul/
>>>>
>>>> And currently page pool core handles that by using a workqueue.
>>>
>>> Forgive me but I'm not understanding the concern here.
>>>
>>> __netdev_devmem_binding_free() is called when binding->ref hits 0.
>>>
>>> binding->ref is incremented when an iov slice of the dma-buf is
>>> allocated, and decremented when an iov is freed. So,
>>> __netdev_devmem_binding_free() can't really be called unless all the
>>> iovs have been freed, and gen_pool_size() == gen_pool_avail(),
>>> regardless of what's happening on the page_pool side of things, right?
>>
>> I seems to misunderstand it. In that case, it seems to be about
>> defensive programming like other checking.
>>
>> By looking at it more closely, it seems napi_frag_unref() call
>> page_pool_page_put_many() directly， which means devmem seems to
>> be bypassing the napi_safe optimization.
>>
>> Can napi_frag_unref() reuse napi_pp_put_page() in order to reuse
>> the napi_safe optimization?
>>
> 
> I think it already does. page_pool_page_put_many() is only called if
> !recycle or !napi_pp_put_page(). In that case
> page_pool_page_put_many() is just a replacement for put_page(),
> because this 'page' may be an iov.

Is there a reason why not calling napi_pp_put_page() for devmem too
instead of calling page_pool_page_put_many()? mem provider has a
'release_page' ops, calling page_pool_page_put_many() directly here
seems to be bypassing the 'release_page' ops, which means devmem is
bypassing most of the main features of page pool.

As far as I can tell, the main features of page pool:
1. Allow lockless allocation and freeing in pool->alloc cache by
   utilizing NAPI non-concurrent context.
2. Allow concurrent allocation and freeing in pool->ring cache by
   utilizing ptr_ring.
3. Allow dma map/unmap and cache sync optimization.
4. Allow detailed stats logging and tracing.
5. Allow some bulk allocation and freeing.
6. support both skb packet and xdp frame.

I am wondering what is the main features that devmem is utilizing
by intergrating into page pool?

It seems the driver can just call netdev_alloc_devmem() and
napi_frag_unref() can call netdev_free_devmem() directly without
intergrating into page pool and it should just works too?

Maybe we should consider creating a new thin layer, in order to
demux to page pool, devmem or other mem type if my suggestion does
not work out too?

> 

