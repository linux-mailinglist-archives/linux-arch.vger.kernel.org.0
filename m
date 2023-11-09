Return-Path: <linux-arch+bounces-105-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7E47E6B2F
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 14:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7B6B20C64
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B06111AA;
	Thu,  9 Nov 2023 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB08101C7;
	Thu,  9 Nov 2023 13:24:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5637030C1;
	Thu,  9 Nov 2023 05:24:09 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SR2dd0TsbzmWys;
	Thu,  9 Nov 2023 21:20:53 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 9 Nov
 2023 21:23:31 +0800
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
 <d4309392-711a-75b0-7bf0-9e7de8fd527e@huawei.com>
 <CAHS8izM1P6d8jgyWE9wFJUJah2YFsjHP2uikDwA0vR=3QA+BXQ@mail.gmail.com>
 <a8ae22dc-5b85-9efe-16c7-d95d455828fa@huawei.com>
 <CAHS8izOh8yC7q9yJN+RAKGs=AgsEf13MnFDmG46=EU05ynnLKw@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b123e89d-d4d9-1202-d7c3-9e52e38009d7@huawei.com>
Date: Thu, 9 Nov 2023 21:23:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izOh8yC7q9yJN+RAKGs=AgsEf13MnFDmG46=EU05ynnLKw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/9 20:20, Mina Almasry wrote:
> On Thu, Nov 9, 2023 at 1:30 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/11/9 11:20, Mina Almasry wrote:
>>> On Wed, Nov 8, 2023 at 2:56 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>>>
>>> Agreed everything above is undoable.
>>>
>>>> But we might be able to do something as folio is doing now, mm subsystem
>>>> is still seeing 'struct folio/page', but other subsystem like slab is using
>>>> 'struct slab', and there is still some common fields shared between
>>>> 'struct folio' and 'struct slab'.
>>>>
>>>
>>> In my eyes this is almost exactly what I suggested in RFC v1 and got
>>> immediately nacked with no room to negotiate. What we did for v1 is to
>>> allocate struct pages for dma-buf to make dma-bufs look like struct
>>> page to mm subsystem. Almost exactly what you're describing above.
>>
>> Maybe the above is where we have disagreement:
>> Do we still need make dma-bufs look like struct page to mm subsystem?
>> IMHO, the answer is no. We might only need to make dma-bufs look like
>> struct page to net stack and page pool subsystem. I think that is already
>> what this pacthset is trying to do, what I am suggesting is just make
>> it more like 'struct page' to net stack and page pool subsystem, in order
>> to try to avoid most of the 'if' checking in net stack and page pool
>> subsystem.
>>
> 
> First, most of the checking in the net stack is
> skb_frag_not_readable(). dma-buf are fundamentally not kmap()able and
> not readable. So we can't remove those, no matter what we do I think.
> Can we agree on that? If so, lets discuss removing most of the ifs in
> the page pool, only.

Agreed on the 'not kmap()able and not readable' checking part.

> 
>>> It's a no-go. I don't think renaming struct page to netmem is going to
>>> move the needle (it also re-introduces code-churn). What I feel like I
>>> learnt is that dma-bufs are not struct pages and can't be made to look
>>> like one, I think.
>>>
>>>> As the netmem patchset, is devmem able to reuse the below 'struct netmem'
>>>> and rename it to 'struct page_pool_iov'?
>>>
>>> I don't think so. For the reasons above, but also practically it
>>> immediately falls apart. Consider this field in netmem:
>>>
>>> + * @flags: The same as the page flags.  Do not use directly.
>>>
>>> dma-buf don't have or support page-flags, and making dma-buf looks
>>> like they support page flags or any page-like features (other than
>>> dma_addr) seems extremely unacceptable to mm folks.
>>
>> As far as I tell, as we limit the devmem usage in netstack, the below
>> is the related mm function call for 'struct page' for devmem:
>> page_ref_*(): page->_refcount does not need changing
> 
> Sorry, I don't understand. Are you suggesting we call page_ref_add() &
> page_ref_sub() on page_pool_iov? That is basically making
> page_pool_iov look like struct page to the mm stack, since page_ref_*
> are mm calls, which you say above we don't need to do. We will still
> need to special case this, no?

As we are reusing 'struct page' for devmem, page->_refcount for
devmem and page->_refcount for normal memory should be the same, right?
We may need to ensure 'struct page' for devmem to always look like a head
page for compound page or base page for net stack, as we use get_page()
in __skb_frag_ref().

We can choose to not call page_ref_sub() for page from devmem, we can
call napi_pp_put_page(), and we may be able to special handle the page
from devmem in devmem provider's 'release_page' ops in napi_pp_put_page().

> 
>> page_is_pfmemalloc(): which is corresponding to page->pp_magic, and
>>                       devmem provider can set/unset it in it's 'alloc_pages'
>>                       ops.
> 
> page_is_pfmemalloc() has nothing to do with page->pp_magic. It checks
> page->lru.next to figure out if this is a pfmemalloc. page_pool_iov
> has no page->lru.next. Still need to special case this?

See the comment in napi_pp_put_page():

	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
	 * in order to preserve any existing bits, such as bit 0 for the
	 * head page of compound page and bit 1 for pfmemalloc page, so
	 * mask those bits for freeing side when doing below checking,
	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
	 * to avoid recycling the pfmemalloc page.
	 */

There is some union in struct page, page->lru.next and page->pp_magic is
actually pointing to the same thing as my understanding.


> 
>> page_to_nid(): we may need to handle it differently somewhat like this
>>                patch does as page_to_nid() may has different implementation
>>                based on different configuration.
> 
> So you're saying we need to handle page_to_nid() differently for
> devmem? So we're not going to be able to avoid the if statement.

Yes, it seems to be the only place that might need special handling I
see so far.

> 
>> page_pool_iov_put_many(): as mentioned in other thread, if net stack is not
>>                           calling page_pool_page_put_many() directly, we
>>                           can reuse napi_pp_put_page() for devmem too, and
>>                           handle the special case for devmem in 'release_page'
>>                           ops.
>>
> 
> page_pool_iov_put_many()/page_pool_iov_get_many() are called to do

Can we remove the page_pool_iov_put_many()/page_pool_iov_get_many()
calling?

> refcounting before the page is released back to the provider. I'm not
> seeing how we can handle the special case inside of 'release_page' -
> that's too late, as far as I can tell.

And handle the special case in page_pool_return_page() to mainly
replace put_page() with 'release_page' for devmem page?
https://elixir.free-electrons.com/linux/v6.6-rc1/source/net/core/page_pool.c#L537

> 
> The only way to remove the if statements in the page pool is to
> implement what you said was not feasible in an earlier email. We would
> define this struct:
> 
> struct netmem {
>         /* common fields */
>         refcount_t refcount;
>         bool is_pfmemalloc;
>         int nid;
>         ......
>         union {
>                 struct devmem{
>                         struct dmabuf_genpool_chunk_owner *owner;
>                 };
> 
>                 struct page * page;
>         };
> };
> 
> Then, we would require all memory providers to allocate struct netmem
> for the memory and set the common fields, including ones that have
> struct pages. For devmem, netmem->page will be NULL, because netmem
> has no page.

That is not what I have in mind.

> 
> If we do that, the page pool can ignore whether the underlying memory
> is page or devmem, because it can use the common fields, example:
> 
> /* page_ref_count replacement */
> netmem_ref_count(struct netmem* netmem) {
>     return netmem->refcount;
> }
> 
> /* page_ref_add replacement */
> netmem_ref_add(struct netmem* netmem) {
>    atomic_inc(netmem->refcount);
> }
> 
> /* page_to_nid replacement */
> netmem_nid(struct netmem* netmem) {
>     return netmem->nid;
> }
> 
> /* page_is_pfmemalloc() replacement */
> netmem_is_pfmemalloc(struct netmem* netmem) {
>     return netmem->is_pfmemalloc;
> }
> 
> /* page_ref_sub replacement */
> netmem_ref_sub(struct netmem* netmem) {
>     atomic_sub(netmet->refcount);
>     if (netmem->refcount == 0) {
>                   /* release page to the memory provider.
>                    * struct page memory provider will do put_page(),
>                    * devmem will do something else */
>            }
>      }
> }
> 
> 
> I think this MAY BE technically feasible, but I'm not sure it's better:
> 
> 1. It is a huge refactor to the page pool, lots of code churn. While
> the page pool currently uses page*, it needs to be completely
> refactored to use netmem*.
> 2. It causes extra memory usage. struct netmem needs to be allocated
> for every struct page.
> 3. It has minimal perf upside. The page_is_page_pool_iov() checks
> currently have minimal perf impact, and I demonstrated that to Jesper
> in RFC v2.
> 4. It also may not be technically feasible. I'm not sure how netmem
> interacts with skb_frag_t. I guess we replace struct page* bv_page
> with struct netmem* bv_page, and add changes there.
> 5. Drivers need to be refactored to use netmem* instead of page*,
> unless we cast netmem* to page* before returning to the driver.
> 
> Possibly other downsides, these are what I could immediately think of.
> 
> If I'm still misunderstanding your suggestion, it may be time to send
> me a concrete code snippet of what you have in mind. I'm a bit
> confused at the moment because the only avenue I see to remove the if
> statements in the page pool is to define the struct that we agreed is
> not feasible in earlier emails.
> 

I might be able to do it at the weekend if it is still not making any
sense to you.

> 
> --
> Thanks,
> Mina
> 
> .
> 

