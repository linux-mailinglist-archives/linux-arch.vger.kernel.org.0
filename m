Return-Path: <linux-arch+bounces-76-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE927E5490
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 11:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC4A1C208BE
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957CB14287;
	Wed,  8 Nov 2023 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BA14261;
	Wed,  8 Nov 2023 10:56:17 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5A019A5;
	Wed,  8 Nov 2023 02:56:16 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SQMSz45TJzfb2h;
	Wed,  8 Nov 2023 18:56:03 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 8 Nov
 2023 18:56:12 +0800
Subject: Re: [RFC PATCH v3 07/12] page-pool: device memory support
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
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-8-almasrymina@google.com>
 <4a0e9d53-324d-e19b-2a30-ba86f9e5569e@huawei.com>
 <CAHS8izNbw7vAGo2euQGA+TF9CgQ8zwrDqTVGsOSxh22_uo0R1w@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <d4309392-711a-75b0-7bf0-9e7de8fd527e@huawei.com>
Date: Wed, 8 Nov 2023 18:56:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izNbw7vAGo2euQGA+TF9CgQ8zwrDqTVGsOSxh22_uo0R1w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/8 5:56, Mina Almasry wrote:
> On Tue, Nov 7, 2023 at 12:00 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/11/6 10:44, Mina Almasry wrote:
>>> Overload the LSB of struct page* to indicate that it's a page_pool_iov.
>>>
>>> Refactor mm calls on struct page* into helpers, and add page_pool_iov
>>> handling on those helpers. Modify callers of these mm APIs with calls to
>>> these helpers instead.
>>>
>>> In areas where struct page* is dereferenced, add a check for special
>>> handling of page_pool_iov.
>>>
>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>>
>>> ---
>>>  include/net/page_pool/helpers.h | 74 ++++++++++++++++++++++++++++++++-
>>>  net/core/page_pool.c            | 63 ++++++++++++++++++++--------
>>>  2 files changed, 118 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
>>> index b93243c2a640..08f1a2cc70d2 100644
>>> --- a/include/net/page_pool/helpers.h
>>> +++ b/include/net/page_pool/helpers.h
>>> @@ -151,6 +151,64 @@ static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
>>>       return NULL;
>>>  }
>>>
>>> +static inline int page_pool_page_ref_count(struct page *page)
>>> +{
>>> +     if (page_is_page_pool_iov(page))
>>> +             return page_pool_iov_refcount(page_to_page_pool_iov(page));
>>
>> We have added a lot of 'if' for the devmem case, it would be better to
>> make it more generic so that we can have more unified metadata handling
>> for normal page and devmem. If we add another memory type here, do we
>> need another 'if' here?
> 
> Maybe, not sure. I'm guessing new memory types will either be pages or
> iovs, so maybe no new if statements needed.
> 
>> That is part of the reason I suggested using a more unified metadata for
>> all the types of memory chunks used by page_pool.
> 
> I think your suggestion was to use struct pages for devmem. That was
> thoroughly considered and intensely argued about in the initial
> conversations regarding devmem and the initial RFC, and from the
> conclusions there it's extremely clear to me that devmem struct pages
> are categorically a no-go.

Not exactly, I was wondering if adding a more abstract structure specificly
for page pool makes any sense, and each mem type can add its own specific
fields, net stack only see and handle the common fields so that it does not
care about specific mem type, and each provider only see the and handle the
specific fields belonging to it most of the time.

Ideally something like beleow:

struct netmem {
	/* common fields */
	refcount_t refcount;
	struct page_pool *pp;
	......

	union {
		struct devmem{
			struct dmabuf_genpool_chunk_owner *owner;
		};

		struct other_mem{
			...
			...
		};
	};
};

But untill we completely decouple the 'struct page' from the net stack,
the above seems undoable in the near term.
But we might be able to do something as folio is doing now, mm subsystem
is still seeing 'struct folio/page', but other subsystem like slab is using
'struct slab', and there is still some common fields shared between
'struct folio' and 'struct slab'.

As the netmem patchset, is devmem able to reuse the below 'struct netmem'
and rename it to 'struct page_pool_iov'? So that 'struct page' for normal
memory and 'struct page_pool_iov' for devmem share the common fields used
by page pool and net stack? And we might be able to reuse the 'flags',
'_pp_mapping_pad' and '_mapcount' for specific mem provider, which is enough
for the devmem only requiring a single pointer to point to it's
owner?

https://lkml.kernel.org/netdev/20230105214631.3939268-2-willy@infradead.org/

+/**
+ * struct netmem - A memory allocation from a &struct page_pool.
+ * @flags: The same as the page flags.  Do not use directly.
+ * @pp_magic: Magic value to avoid recycling non page_pool allocated pages.
+ * @pp: The page pool this netmem was allocated from.
+ * @dma_addr: Call netmem_get_dma_addr() to read this value.
+ * @dma_addr_upper: Might need to be 64-bit on 32-bit architectures.
+ * @pp_frag_count: For frag page support, not supported in 32-bit
+ *   architectures with 64-bit DMA.
+ * @_mapcount: Do not access this member directly.
+ * @_refcount: Do not access this member directly.  Read it using
+ *   netmem_ref_count() and manipulate it with netmem_get() and netmem_put().
+ *
+ * This struct overlays struct page for now.  Do not modify without a
+ * good understanding of the issues.
+ */
+struct netmem {
+	unsigned long flags;
+	unsigned long pp_magic;
+	struct page_pool *pp;
+	/* private: no need to document this padding */
+	unsigned long _pp_mapping_pad;	/* aliases with folio->mapping */
+	/* public: */
+	unsigned long dma_addr;
+	union {
+		unsigned long dma_addr_upper;
+		atomic_long_t pp_frag_count;
+	};
+	atomic_t _mapcount;
+	atomic_t _refcount;
+};

If we do that, it seems we might be able to allow net stack and page pool to see
the metadata for devmem chunk as 'struct page', and may be able to aovid most of
the 'if' checking in net stack and page pool?

> 
> --
> Thanks,
> Mina
> 
> .
> 

