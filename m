Return-Path: <linux-arch+bounces-873-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8786280BEDF
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 03:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1099F280C70
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 02:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3810A3C;
	Mon, 11 Dec 2023 02:04:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CEBD9;
	Sun, 10 Dec 2023 18:04:08 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SpQ5r3nGLz14M0c;
	Mon, 11 Dec 2023 10:04:00 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 7268C1800B8;
	Mon, 11 Dec 2023 10:04:05 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Dec
 2023 10:04:05 +0800
Subject: Re: [net-next v1 09/16] page_pool: device memory support
To: Mina Almasry <almasrymina@google.com>
CC: Shailend Chand <shailend@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Ahern
	<dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-10-almasrymina@google.com>
 <32211cbf-3a4e-8a86-6214-4304ddb18a98@huawei.com>
 <CAHS8izOQcuLPwvDff96fuNB7r6EU9OWt3ShueQp=u7wat3L5LA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <92e30bd9-6df4-b72f-7bcd-f4fe5670eba2@huawei.com>
Date: Mon, 11 Dec 2023 10:04:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izOQcuLPwvDff96fuNB7r6EU9OWt3ShueQp=u7wat3L5LA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2023/12/9 0:05, Mina Almasry wrote:
> On Fri, Dec 8, 2023 at 1:30 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>>
>> As mentioned before, it seems we need to have the above checking every
>> time we need to do some per-page handling in page_pool core, is there
>> a plan in your mind how to remove those kind of checking in the future?
>>
> 
> I see 2 ways to remove the checking, both infeasible:
> 
> 1. Allocate a wrapper struct that pulls out all the fields the page pool needs:
> 
> struct netmem {
>         /* common fields */
>         refcount_t refcount;
>         bool is_pfmemalloc;
>         int nid;
>         ...
>         union {
>                 struct dmabuf_genpool_chunk_owner *owner;
>                 struct page * page;
>         };
> };
> 
> The page pool can then not care if the underlying memory is iov or
> page. However this introduces significant memory bloat as this struct
> needs to be allocated for each page or ppiov, which I imagine is not
> acceptable for the upside of removing a few static_branch'd if
> statements with no performance cost.
> 
> 2. Create a unified struct for page and dmabuf memory, which the mm
> folks have repeatedly nacked, and I imagine will repeatedly nack in
> the future.
> 
> So I imagine the special handling of ppiov in some form is critical
> and the checking may not be removable.

If the above is true, perhaps devmem is not really supposed to be intergated
into page_pool.

Adding a checking for every per-page handling in page_pool core is just too
hacky to be really considerred a longterm solution.

It is somewhat ironical that devmem is using static_branch to alliviate the
performance impact for normal memory at the possible cost of performance
degradation for devmem, does it not defeat some purpose of intergating devmem
to page_pool?

> 
>> Even though a static_branch check is added in page_is_page_pool_iov(), it
>> does not make much sense that a core has tow different 'struct' for its
>> most basic data.
>>
>> IMHO, the ppiov for dmabuf is forced fitting into page_pool without much
>> design consideration at this point.
>>
> ...
>>
>> For now, the above may work for the the rx part as it seems that you are
>> only enabling rx for dmabuf for now.
>>
>> What is the plan to enable tx for dmabuf? If it is also intergrated into
>> page_pool? There was a attempt to enable page_pool for tx, Eric seemed to
>> have some comment about this:
>> https://lkml.kernel.org/netdev/2cf4b672-d7dc-db3d-ce90-15b4e91c4005@huawei.com/T/#mb6ab62dc22f38ec621d516259c56dd66353e24a2
>>
>> If tx is not intergrated into page_pool, do we need to create a new layer for
>> the tx dmabuf?
>>
> 
> I imagine the TX path will reuse page_pool_iov, page_pool_iov_*()
> helpers, and page_pool_page_*() helpers, but will not need any core
> page_pool changes. This is because the TX path will have to piggyback

We may need another bit/flags checking to demux between page_pool owned
devmem and non-page_pool owned devmem.

Also calling page_pool_*() on non-page_pool owned devmem is confusing
enough that we may need a thin layer handling non-page_pool owned devmem
in the end.

> on MSG_ZEROCOPY (devmem is not copyable), so no memory allocation from
> the page_pool (or otherwise) is needed or possible. RFCv1 had a TX
> implementation based on dmabuf pages without page_pool involvement, I
> imagine I'll do something similar.
It would be good to have a tx implementation for the next version, so
that we can have a whole picture of devmem.

> 

