Return-Path: <linux-arch+bounces-74-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE37E4F8B
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 04:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1591C20B39
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 03:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5FD1383;
	Wed,  8 Nov 2023 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7C1C29;
	Wed,  8 Nov 2023 03:41:09 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B12101;
	Tue,  7 Nov 2023 19:41:09 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SQ9px2b6kzfb1V;
	Wed,  8 Nov 2023 11:40:57 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 8 Nov
 2023 11:40:41 +0800
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to netdevice
To: Mina Almasry <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	David Ahern <dsahern@kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-5-almasrymina@google.com>
 <1fee982f-1e96-4ae8-ede0-7e57bf84c5f7@huawei.com>
 <CAHS8izPV3isMWyjFnr7bJDDPANg-zm_M=UbHyuhYWv1Viy7fRw@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <c1b689bd-a05b-85e9-0ce4-7264c818c2dc@huawei.com>
Date: Wed, 8 Nov 2023 11:40:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izPV3isMWyjFnr7bJDDPANg-zm_M=UbHyuhYWv1Viy7fRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/8 5:59, Mina Almasry wrote:
> On Mon, Nov 6, 2023 at 11:46 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/11/6 10:44, Mina Almasry wrote:
>>> +
>>> +void __netdev_devmem_binding_free(struct netdev_dmabuf_binding *binding)
>>> +{
>>> +     size_t size, avail;
>>> +
>>> +     gen_pool_for_each_chunk(binding->chunk_pool,
>>> +                             netdev_devmem_free_chunk_owner, NULL);
>>> +
>>> +     size = gen_pool_size(binding->chunk_pool);
>>> +     avail = gen_pool_avail(binding->chunk_pool);
>>> +
>>> +     if (!WARN(size != avail, "can't destroy genpool. size=%lu, avail=%lu",
>>> +               size, avail))
>>> +             gen_pool_destroy(binding->chunk_pool);
>>
>>
>> Is there any other place calling the gen_pool_destroy() when the above
>> warning is triggered? Do we have a leaking for binding->chunk_pool?
>>
> 
> gen_pool_destroy BUG_ON() if it's not empty at the time of destroying.
> Technically that should never happen, because
> __netdev_devmem_binding_free() should only be called when the refcount
> hits 0, so all the chunks have been freed back to the gen_pool. But,
> just in case, I don't want to crash the server just because I'm
> leaking a chunk... this is a bit of defensive programming that is
> typically frowned upon, but the behavior of gen_pool is so severe I
> think the WARN() + check is warranted here.

It seems it is pretty normal for the above to happen nowadays because of
retransmits timeouts, NAPI defer schemes mentioned below:

https://lkml.kernel.org/netdev/168269854650.2191653.8465259808498269815.stgit@firesoul/

And currently page pool core handles that by using a workqueue.

