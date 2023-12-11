Return-Path: <linux-arch+bounces-900-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0584480D50E
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 19:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DC71C2138E
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA3168CF;
	Mon, 11 Dec 2023 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZR9oew+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFADC3
	for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 10:14:17 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d9f9fbfd11so1788114a34.2
        for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702318456; x=1702923256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbiqO7RxhSXNHZRSCjwyZy4HmqVXPvY1sANPCgpMBIA=;
        b=2ZR9oew+tVsgkdbtVJPAIjNlqjQeakbUN08vwSybi21pD7JMCR0VjzZNIAL4Ql+O9C
         7+xRmtnoHMGO7vGqublUTMIoEUpQyMp5C/Q15mq28NKrqJo84IPm+I27gcHRRz1QvPk9
         3Bt0ieiBUMQ0b50x1yG5uZKdQu7gk0sJiVHr4pFlWY1CWFkqiCt1k94Yr+K2ec94ewBv
         sGZGHVvgxwJoJpWq6xDMFSAIbxsm7+NGgyHh/5zNQOFLdwzCn7Q68XHR3R3Iw0Y85XfS
         0z1l8SQXvz9P1h9Rve0ew1xgE2nb8v3ipP5ZhXKhMFwu497xQ+GX8qKpLGznUFXJdDtR
         VuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318456; x=1702923256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbiqO7RxhSXNHZRSCjwyZy4HmqVXPvY1sANPCgpMBIA=;
        b=OtbTsghUfmuChlEnr7mfEuFNAu8+zCD0vCUAvltv+MDETDN6p5NSX1m3VDL9nXygvP
         cpDwjPyUuIjRXO0LKoDGCXMq6pHOSBY2h3myg1ERo91lMbXXEgI/LaHy9YgND6dKJfFl
         0qA1bCBjyu6JqTjy9JXYImWmdh1wROg2BsrQeqG+aGwS386GeC5ojh2B7NpytHZ22kjd
         EtD9OnWKOmArDm2qo0fhvUsO3bdGcL8b3XU5sWEHEYYkbHkaCj/LZjDZ4QSix1gGagBA
         Hs6pLPC8Esg5QslO2UhFlsT+QeYOSCfoQSh5Igm9kBdJT0qi/VX7eympBuF6dKCXtfKw
         ULpw==
X-Gm-Message-State: AOJu0YzgB07cihpzQgScuLAjNfVTDLeLW2ICjYnYdIvh67AsBkYqy3hc
	95ZLnrB5gmP/4/LAhhPl0Czyc8MdIDrDiXu1VCaIMQ==
X-Google-Smtp-Source: AGHT+IE8095BrfyI+kTIXDm8hNguhYybzjvVGensk2JElZVZdZ4bLJQ+s/d+dDYVGThzdPiv+aq1lB4rQf1PXQGNIdE=
X-Received: by 2002:a05:6830:164a:b0:6d9:d902:44f0 with SMTP id
 h10-20020a056830164a00b006d9d90244f0mr4280561otr.50.1702318456301; Mon, 11
 Dec 2023 10:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-10-almasrymina@google.com> <32211cbf-3a4e-8a86-6214-4304ddb18a98@huawei.com>
 <CAHS8izOQcuLPwvDff96fuNB7r6EU9OWt3ShueQp=u7wat3L5LA@mail.gmail.com>
 <92e30bd9-6df4-b72f-7bcd-f4fe5670eba2@huawei.com> <CAHS8izPEFsqw50qgM+sPot6XVvOExpd+DrwrmPSR3zsWGLysRw@mail.gmail.com>
 <CAHS8izN6Cbjy0FCYhJyNsP396XfgJ_nTFXWuHb5QWNct=PifAg@mail.gmail.com> <59e07233-24cb-7fb2-1aee-e1cf7eb72fa9@huawei.com>
In-Reply-To: <59e07233-24cb-7fb2-1aee-e1cf7eb72fa9@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 11 Dec 2023 10:14:05 -0800
Message-ID: <CAHS8izMdpo0D7GYzMkOtg1ueCODAVNxtwSP_qPseSYXNMhPGCw@mail.gmail.com>
Subject: Re: [net-next v1 09/16] page_pool: device memory support
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 3:51=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/12/11 12:04, Mina Almasry wrote:
> > On Sun, Dec 10, 2023 at 6:26=E2=80=AFPM Mina Almasry <almasrymina@googl=
e.com> wrote:
> >>
> >> On Sun, Dec 10, 2023 at 6:04=E2=80=AFPM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>>
> >>> On 2023/12/9 0:05, Mina Almasry wrote:
> >>>> On Fri, Dec 8, 2023 at 1:30=E2=80=AFAM Yunsheng Lin <linyunsheng@hua=
wei.com> wrote:
> >>>>>
> >>>>>
> >>>>> As mentioned before, it seems we need to have the above checking ev=
ery
> >>>>> time we need to do some per-page handling in page_pool core, is the=
re
> >>>>> a plan in your mind how to remove those kind of checking in the fut=
ure?
> >>>>>
> >>>>
> >>>> I see 2 ways to remove the checking, both infeasible:
> >>>>
> >>>> 1. Allocate a wrapper struct that pulls out all the fields the page =
pool needs:
> >>>>
> >>>> struct netmem {
> >>>>         /* common fields */
> >>>>         refcount_t refcount;
> >>>>         bool is_pfmemalloc;
> >>>>         int nid;
> >>>>         ...
> >>>>         union {
> >>>>                 struct dmabuf_genpool_chunk_owner *owner;
> >>>>                 struct page * page;
> >>>>         };
> >>>> };
> >>>>
> >>>> The page pool can then not care if the underlying memory is iov or
> >>>> page. However this introduces significant memory bloat as this struc=
t
> >>>> needs to be allocated for each page or ppiov, which I imagine is not
> >>>> acceptable for the upside of removing a few static_branch'd if
> >>>> statements with no performance cost.
> >>>>
> >>>> 2. Create a unified struct for page and dmabuf memory, which the mm
> >>>> folks have repeatedly nacked, and I imagine will repeatedly nack in
> >>>> the future.
> >>>>
> >>>> So I imagine the special handling of ppiov in some form is critical
> >>>> and the checking may not be removable.
> >>>
> >>> If the above is true, perhaps devmem is not really supposed to be int=
ergated
> >>> into page_pool.
> >>>
> >>> Adding a checking for every per-page handling in page_pool core is ju=
st too
> >>> hacky to be really considerred a longterm solution.
> >>>
> >>
> >> The only other option is to implement another page_pool for ppiov and
> >> have the driver create page_pool or ppiov_pool depending on the state
> >> of the netdev_rx_queue (or some helper in the net stack to do that for
> >> the driver). This introduces some code duplication. The ppiov_pool &
> >> page_pool would look similar in implementation.
>
> I think there is a design pattern already to deal with this kind of probl=
em,
> refactoring common code used by both page_pool and ppiov into a library t=
o
> aovid code duplication if most of them have similar implementation.
>

Code can be refactored if it's identical, not if it is similar. I
suspect the page_pools will be only similar, and if you're not willing
to take devmem handling into the page pool then refactoring page_pool
code into helpers that do devmem handling may also not be an option.

> >>
> >> But this was all discussed in detail in RFC v2 and the last response I
> >> heard from Jesper was in favor if this approach, if I understand
> >> correctly:
> >>
> >> https://lore.kernel.org/netdev/7aedc5d5-0daf-63be-21bc-3b724cc1cab9@re=
dhat.com/
> >>
> >> Would love to have the maintainer weigh in here.
> >>
> >
> > I should note we may be able to remove some of the checking, but maybe =
not all.
> >
> > - Checks that disable page fragging for ppiov can be removed once
> > ppiov has frag support (in this series or follow up).
> >
> > - If we use page->pp_frag_count (or page->pp_ref_count) for
> > refcounting ppiov, we can remove the if checking in the refcounting.
> >

I'm not sure this is actually possible in the short term. The
page_pool uses both page->_refcount and page->pp_frag_count for
refcounting, and I will not be able to remove the special handling
around page->_refcount as i'm not allowed to call page_ref_*() APIs on
a non-struct page.

> > - We may be able to store the dma_addr of the ppiov in page->dma_addr,
> > but I'm unsure if that actually works, because the dma_buf dmaddr is
> > dma_addr_t (u32 or u64), but page->dma_addr is unsigned long (4 bytes
> > I think). But if it works for pages I may be able to make it work for
> > ppiov as well.
> >
> > - Checks that obtain the page->pp can work with ppiov if we align the
> > offset of page->pp and ppiov->pp.
> >
> > - Checks around page->pp_magic can be removed if we also have offset
> > aligned ppiov->pp_magic.
> >
> > Sadly I don't see us removing the checking for these other cases:
> >
> > - page_is_pfmemalloc(): I'm not allowed to pass a non-struct page into
> > that helper.
>
> We can do similar trick like above as bit 1 of page->pp_magic is used to
> indicate that if it is a pfmemalloc page.
>

Likely yes.

> >
> > - page_to_nid(): I'm not allowed to pass a non-struct page into that he=
lper.
>
> Yes, this one need special case.
>
> >
> > - page_pool_free_va(): ppiov have no va.
>
> Doesn't the skb_frags_readable() checking will protect the page_pool_free=
_va()
> from being called on devmem?
>

This function seems to be only called from veth which doesn't support
devmem. I can remove the handling there.

> >
> > - page_pool_sync_for_dev/page_pool_dma_map: ppiov backed by dma-buf
> > fundamentally can't get mapped again.
>
> Can we just fail the page_pool creation with PP_FLAG_DMA_MAP and
> DMA_ATTR_SKIP_CPU_SYNC flags for devmem provider?
>

Jakub says PP_FLAG_DMA_MAP must be enabled for devmem, such that the
page_pool handles the dma mapping of the devmem and the driver doesn't
use it on its own.

We may fail creating the page pool on  PP_FLAG_DMA_SYNC_DEV maybe, and
remove the checking from page_pool_sync_for_dev(), I think.

> >
> > Are the removal (or future removal) of these checks enough to resolve t=
his?
>
> Yes, that is somewhat similar to my proposal, the biggest objection seems=
 to
> be that we need to have a safe type checking for it to work correctly.
>
> >
> >>> It is somewhat ironical that devmem is using static_branch to allivia=
te the
> >>> performance impact for normal memory at the possible cost of performa=
nce
> >>> degradation for devmem, does it not defeat some purpose of intergatin=
g devmem
> >>> to page_pool?
> >>>
> >>
> >> I don't see the issue. The static branch sets the non-ppiov path as
> >> default if no memory providers are in use, and flips it when they are,
> >> making the default branch prediction ideal in both cases.
>
> You are assuming the we are not using page pool for both normal memory an=
d
> devmem at the same. But a generic solution should not have that assumptio=
n
> as my understanding.
>
> >>
> >>>>
> >>>>> Even though a static_branch check is added in page_is_page_pool_iov=
(), it
> >>>>> does not make much sense that a core has tow different 'struct' for=
 its
> >>>>> most basic data.
> >>>>>
> >>>>> IMHO, the ppiov for dmabuf is forced fitting into page_pool without=
 much
> >>>>> design consideration at this point.
> >>>>>
> >>>> ...
> >>>>>
> >>>>> For now, the above may work for the the rx part as it seems that yo=
u are
> >>>>> only enabling rx for dmabuf for now.
> >>>>>
> >>>>> What is the plan to enable tx for dmabuf? If it is also intergrated=
 into
> >>>>> page_pool? There was a attempt to enable page_pool for tx, Eric see=
med to
> >>>>> have some comment about this:
> >>>>> https://lkml.kernel.org/netdev/2cf4b672-d7dc-db3d-ce90-15b4e91c4005=
@huawei.com/T/#mb6ab62dc22f38ec621d516259c56dd66353e24a2
> >>>>>
> >>>>> If tx is not intergrated into page_pool, do we need to create a new=
 layer for
> >>>>> the tx dmabuf?
> >>>>>
> >>>>
> >>>> I imagine the TX path will reuse page_pool_iov, page_pool_iov_*()
> >>>> helpers, and page_pool_page_*() helpers, but will not need any core
> >>>> page_pool changes. This is because the TX path will have to piggybac=
k
> >>>
> >>> We may need another bit/flags checking to demux between page_pool own=
ed
> >>> devmem and non-page_pool owned devmem.
> >>>
> >>
> >> The way I'm imagining the support, I don't see the need for such
> >> flags. We'd be re-using generic helpers like
> >> page_pool_iov_get_dma_address() and what not that don't need that
> >> checking.
> >>
> >>> Also calling page_pool_*() on non-page_pool owned devmem is confusing
> >>> enough that we may need a thin layer handling non-page_pool owned dev=
mem
> >>> in the end.
> >>>
> >>
> >> The page_pool_page* & page_pool_iov* functions can be renamed if
> >> confusing. I would think that's no issue (note that the page_pool_*
>
> When you rename those functions, you will have a thin layer automatically=
.
>
> >> functions need not be called for TX path).
> >>
> >>>> on MSG_ZEROCOPY (devmem is not copyable), so no memory allocation fr=
om
> >>>> the page_pool (or otherwise) is needed or possible. RFCv1 had a TX
> >>>> implementation based on dmabuf pages without page_pool involvement, =
I
> >>>> imagine I'll do something similar.
> >>> It would be good to have a tx implementation for the next version, so
> >>> that we can have a whole picture of devmem.



--=20
Thanks,
Mina

