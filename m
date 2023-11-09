Return-Path: <linux-arch+bounces-104-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9057E6A6D
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 13:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132541F214B5
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D41DA2C;
	Thu,  9 Nov 2023 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGuM6wOV"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D511DA27
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 12:20:26 +0000 (UTC)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037472737
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 04:20:26 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-457c6267818so322914137.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Nov 2023 04:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699532425; x=1700137225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPcS64LNsr6Re9WYBQ3Sfo6KPTli043xINsR6eR0oWU=;
        b=CGuM6wOVAZlujMOXHQNeku1AE6QvAmM2iij+iJLrYAQC+V2esDVnIAL/n2CqDR+dqw
         LZLkwCzUOcD6ZOE98OaiHbINwIwhVP+/r20yI5s5s9Y4dHeksn6jU+kH9OwcOmCdzqn4
         a9TS+wGPZLS+49mbMhxQ8FLGxePOcPtOAVjnR1W+87oWfDtTzBGDHzvMKwQkcHzR2Eul
         SlduiTaCIla+dHwQ2FFGc6rByWzCsKo75/cfx63kjxyJC4w5gFD4bI1m82CmKxzo+xQM
         CHHfiiqGZ6EGC6jUCM9FjKX6z7wzgAi9KojyMSWa4c7tEoIDOObdG3DCBNcrb2+uzDx3
         v3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699532425; x=1700137225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPcS64LNsr6Re9WYBQ3Sfo6KPTli043xINsR6eR0oWU=;
        b=pNU6X+YLU4YS2W/WF2JR42ZQbv+zLAHDmjjo6oydJWw3reINpQ3NbRB///brt3M8lN
         3qo5CBn////NDLNMTTvnmuQuIgBO0Vj9JLMvYZA430/KBYGFzhY1cA/aeV4DYxdrFuKH
         nMHMNPwK/S1pLGujPu42Helr8jEkshVgwMuOgLvCvSFS6LnHVXE0d09FNu6+8K5RWgZQ
         0GpU04TIa7El0/E2SHs0Q1kpnxf33cAbJcpYDNdylhoNkHKshnlBhDTm1GM+gnks7NdE
         v8HiJfBdstq1ukCEgsk+SSUJit0clpapRFmEXPLRDwHWqOun1XTvuOQ4cCPcY1cKTwgC
         BPOg==
X-Gm-Message-State: AOJu0Yy9CAPGZu01A43pezo3axVjgzuyrAD7FOy0CK5rso2zBKj07pfv
	uOEYw/BUP/0owP89QwFKkQl/ARWrNzXCDFnJHbTD38QsX+2PNk22vuqW8w==
X-Google-Smtp-Source: AGHT+IFfFl922mscmOxZBJu/cgw+xUG99huJKamj4SvfI8CIyJ6yJO0CbXCAJJce1KiW6D25ou0quO0lgo5uh+PiKfc=
X-Received: by 2002:a67:ef5e:0:b0:45d:b022:9835 with SMTP id
 k30-20020a67ef5e000000b0045db0229835mr4061147vsr.22.1699532424738; Thu, 09
 Nov 2023 04:20:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-8-almasrymina@google.com> <4a0e9d53-324d-e19b-2a30-ba86f9e5569e@huawei.com>
 <CAHS8izNbw7vAGo2euQGA+TF9CgQ8zwrDqTVGsOSxh22_uo0R1w@mail.gmail.com>
 <d4309392-711a-75b0-7bf0-9e7de8fd527e@huawei.com> <CAHS8izM1P6d8jgyWE9wFJUJah2YFsjHP2uikDwA0vR=3QA+BXQ@mail.gmail.com>
 <a8ae22dc-5b85-9efe-16c7-d95d455828fa@huawei.com>
In-Reply-To: <a8ae22dc-5b85-9efe-16c7-d95d455828fa@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 9 Nov 2023 04:20:11 -0800
Message-ID: <CAHS8izOh8yC7q9yJN+RAKGs=AgsEf13MnFDmG46=EU05ynnLKw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/12] page-pool: device memory support
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 1:30=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/11/9 11:20, Mina Almasry wrote:
> > On Wed, Nov 8, 2023 at 2:56=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
>
> >
> > Agreed everything above is undoable.
> >
> >> But we might be able to do something as folio is doing now, mm subsyst=
em
> >> is still seeing 'struct folio/page', but other subsystem like slab is =
using
> >> 'struct slab', and there is still some common fields shared between
> >> 'struct folio' and 'struct slab'.
> >>
> >
> > In my eyes this is almost exactly what I suggested in RFC v1 and got
> > immediately nacked with no room to negotiate. What we did for v1 is to
> > allocate struct pages for dma-buf to make dma-bufs look like struct
> > page to mm subsystem. Almost exactly what you're describing above.
>
> Maybe the above is where we have disagreement:
> Do we still need make dma-bufs look like struct page to mm subsystem?
> IMHO, the answer is no. We might only need to make dma-bufs look like
> struct page to net stack and page pool subsystem. I think that is already
> what this pacthset is trying to do, what I am suggesting is just make
> it more like 'struct page' to net stack and page pool subsystem, in order
> to try to avoid most of the 'if' checking in net stack and page pool
> subsystem.
>

First, most of the checking in the net stack is
skb_frag_not_readable(). dma-buf are fundamentally not kmap()able and
not readable. So we can't remove those, no matter what we do I think.
Can we agree on that? If so, lets discuss removing most of the ifs in
the page pool, only.

> > It's a no-go. I don't think renaming struct page to netmem is going to
> > move the needle (it also re-introduces code-churn). What I feel like I
> > learnt is that dma-bufs are not struct pages and can't be made to look
> > like one, I think.
> >
> >> As the netmem patchset, is devmem able to reuse the below 'struct netm=
em'
> >> and rename it to 'struct page_pool_iov'?
> >
> > I don't think so. For the reasons above, but also practically it
> > immediately falls apart. Consider this field in netmem:
> >
> > + * @flags: The same as the page flags.  Do not use directly.
> >
> > dma-buf don't have or support page-flags, and making dma-buf looks
> > like they support page flags or any page-like features (other than
> > dma_addr) seems extremely unacceptable to mm folks.
>
> As far as I tell, as we limit the devmem usage in netstack, the below
> is the related mm function call for 'struct page' for devmem:
> page_ref_*(): page->_refcount does not need changing

Sorry, I don't understand. Are you suggesting we call page_ref_add() &
page_ref_sub() on page_pool_iov? That is basically making
page_pool_iov look like struct page to the mm stack, since page_ref_*
are mm calls, which you say above we don't need to do. We will still
need to special case this, no?

> page_is_pfmemalloc(): which is corresponding to page->pp_magic, and
>                       devmem provider can set/unset it in it's 'alloc_pag=
es'
>                       ops.

page_is_pfmemalloc() has nothing to do with page->pp_magic. It checks
page->lru.next to figure out if this is a pfmemalloc. page_pool_iov
has no page->lru.next. Still need to special case this?

> page_to_nid(): we may need to handle it differently somewhat like this
>                patch does as page_to_nid() may has different implementati=
on
>                based on different configuration.

So you're saying we need to handle page_to_nid() differently for
devmem? So we're not going to be able to avoid the if statement.

> page_pool_iov_put_many(): as mentioned in other thread, if net stack is n=
ot
>                           calling page_pool_page_put_many() directly, we
>                           can reuse napi_pp_put_page() for devmem too, an=
d
>                           handle the special case for devmem in 'release_=
page'
>                           ops.
>

page_pool_iov_put_many()/page_pool_iov_get_many() are called to do
refcounting before the page is released back to the provider. I'm not
seeing how we can handle the special case inside of 'release_page' -
that's too late, as far as I can tell.

The only way to remove the if statements in the page pool is to
implement what you said was not feasible in an earlier email. We would
define this struct:

struct netmem {
        /* common fields */
        refcount_t refcount;
        bool is_pfmemalloc;
        int nid;
        ......
        union {
                struct devmem{
                        struct dmabuf_genpool_chunk_owner *owner;
                };

                struct page * page;
        };
};

Then, we would require all memory providers to allocate struct netmem
for the memory and set the common fields, including ones that have
struct pages. For devmem, netmem->page will be NULL, because netmem
has no page.

If we do that, the page pool can ignore whether the underlying memory
is page or devmem, because it can use the common fields, example:

/* page_ref_count replacement */
netmem_ref_count(struct netmem* netmem) {
    return netmem->refcount;
}

/* page_ref_add replacement */
netmem_ref_add(struct netmem* netmem) {
   atomic_inc(netmem->refcount);
}

/* page_to_nid replacement */
netmem_nid(struct netmem* netmem) {
    return netmem->nid;
}

/* page_is_pfmemalloc() replacement */
netmem_is_pfmemalloc(struct netmem* netmem) {
    return netmem->is_pfmemalloc;
}

/* page_ref_sub replacement */
netmem_ref_sub(struct netmem* netmem) {
    atomic_sub(netmet->refcount);
    if (netmem->refcount =3D=3D 0) {
                  /* release page to the memory provider.
                   * struct page memory provider will do put_page(),
                   * devmem will do something else */
           }
     }
}


I think this MAY BE technically feasible, but I'm not sure it's better:

1. It is a huge refactor to the page pool, lots of code churn. While
the page pool currently uses page*, it needs to be completely
refactored to use netmem*.
2. It causes extra memory usage. struct netmem needs to be allocated
for every struct page.
3. It has minimal perf upside. The page_is_page_pool_iov() checks
currently have minimal perf impact, and I demonstrated that to Jesper
in RFC v2.
4. It also may not be technically feasible. I'm not sure how netmem
interacts with skb_frag_t. I guess we replace struct page* bv_page
with struct netmem* bv_page, and add changes there.
5. Drivers need to be refactored to use netmem* instead of page*,
unless we cast netmem* to page* before returning to the driver.

Possibly other downsides, these are what I could immediately think of.

If I'm still misunderstanding your suggestion, it may be time to send
me a concrete code snippet of what you have in mind. I'm a bit
confused at the moment because the only avenue I see to remove the if
statements in the page pool is to define the struct that we agreed is
not feasible in earlier emails.

> >
> >> So that 'struct page' for normal
> >> memory and 'struct page_pool_iov' for devmem share the common fields u=
sed
> >> by page pool and net stack?
> >
> > Are you suggesting that we'd cast a netmem* to a page* and call core
> > mm APIs on it? It's basically what was happening with RFC v1, where
> > things that are not struct pages were made to look like struct pages.
> >
> > Also, there isn't much upside for what you're suggesting, I think. For
> > example I can align the refcount variable in struct page_pool_iov with
> > the refcount in struct page so that this works:
> >
> > put_page((struct page*)ppiov);
> >
> > but it's a disaster. Because put_page() will call __put_page() if the
> > page is freed, and __put_page() will try to return the page to the
> > buddy allocator!
>
> As what I suggested above, Can we handle this in devmem provider's
> 'release_page' ops instead of calling put_page() directly as for devmem.
>
> >
> >>  And we might be able to reuse the 'flags',
> >> '_pp_mapping_pad' and '_mapcount' for specific mem provider, which is =
enough
> >> for the devmem only requiring a single pointer to point to it's
> >> owner?
> >>
> >
> > All the above seems quite similar to RFC v1 again, using netmem
> > instead of struct page. In RFC v1 we re-used zone_device_data() for
> > the dma-buf owner equivalent.
>
> As we have added a few checkings to limit 'struct page' for devmem to
> be only used in net stack, we can decouple 'struct page' for devmem
> from mm subsystem, zone_device_data() is not really needed, right?
>
> If we can decouple 'struct page' for normal memory from mm subsystem
> through the folio work in the future, then we may define a more abstract
> structure for page pool and net stack instead of reusing 'struct page'
> from mm.
>
> >



--
Thanks,
Mina

