Return-Path: <linux-arch+bounces-917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD380EEC7
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 15:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C31F1C20BCA
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE83745C4;
	Tue, 12 Dec 2023 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akY5MonY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B57D3
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 06:29:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a22f2a28c16so958866b.0
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 06:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702391351; x=1702996151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvAfEdNnHNunYaoKLrlK4WhMdfvO73bGHd2FtWgeUYg=;
        b=akY5MonYgndnmv7rJhhLD8XVdx+ToH7Utth/KzwXWr/lhhAv8XY4vNQCoDAwl2+/vN
         Y9uKJHVhOtXW+KC4c3eusfbWSXQkPvJ9g4FWD1WyN+JFa+jn92zlGhaT8P071noV160G
         dt2gw0FoMEpPMx1+i2DnUUGiMogGyCQI7Y5gQXh9bbf35JWRdBhcwHsf12sUTqABNhjl
         mM4c4JNglhY0yQ82Ll5shFkhgg8y4b7HNZWjwVI6E11vYjlap7G3qkWr5541nCVq5B3q
         m9OPeYpbAk2v3B8AUIBZ0TnkpO82I20r445Eob0OTwA1gLfXwD9gZGXd3RUKnP+yE89+
         Qnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391351; x=1702996151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvAfEdNnHNunYaoKLrlK4WhMdfvO73bGHd2FtWgeUYg=;
        b=MOPhXtmPeNZd3JNnAuc1cftP9qV+7FZ4xEZHT2tcm/0HNQlIPg6Fm1umkbHbf1WT/H
         4cXhYjvvnj68TBiqvr9e1Yo71Wk3cjFPeAYNgT5A2qkZuNh+WZDG00ZbQZBtcnF8uQkS
         cLKItNY6gSEDEcX2kd9ZOB9xMjNE4CcQLaf4TISc6iQXcvLVcOUJtpZJGl4CT8wr0ams
         6zux1mk2UnIHC3nyrPKmsuxGtYUcXOS47zGrnoQy6oaMHyTL1rzGblIEFKpQqRBBVH11
         6c5TK8T9aKqdJM/T5Vta22FzI+P5ab4BTBVKdSIAYQbBrhCQGapal8sSk/S8Htycr2Q9
         noXA==
X-Gm-Message-State: AOJu0Yy8ueDnfR7Xnyq2Z2TNXC7z/l0rlJkKTk75hWC5gV2XOGXosT7T
	9MoYR2L4KfhebruxfTc94TC+pdlva5VLpkLgV0hQDg==
X-Google-Smtp-Source: AGHT+IHSSUddnH7vqmzYJHu7RfzxRhATVPO/EOnWlyPQFn5qUGh1DJZKHNEoTOcGQjr2tdWtG+uz+GEsaHrcS6BiK4g=
X-Received: by 2002:a17:907:7e94:b0:a18:c553:21cb with SMTP id
 qb20-20020a1709077e9400b00a18c55321cbmr3011891ejc.19.1702391350542; Tue, 12
 Dec 2023 06:29:10 -0800 (PST)
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
 <CAHS8izN6Cbjy0FCYhJyNsP396XfgJ_nTFXWuHb5QWNct=PifAg@mail.gmail.com>
 <59e07233-24cb-7fb2-1aee-e1cf7eb72fa9@huawei.com> <CAHS8izMdpo0D7GYzMkOtg1ueCODAVNxtwSP_qPseSYXNMhPGCw@mail.gmail.com>
 <2cdf173c-95e4-2141-56f7-0761705cd737@huawei.com>
In-Reply-To: <2cdf173c-95e4-2141-56f7-0761705cd737@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 06:28:58 -0800
Message-ID: <CAHS8izOTdqqbS6ajAo+c646UwXkK-aB8ET9uJRS6Auszfi0nfA@mail.gmail.com>
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

On Tue, Dec 12, 2023 at 3:17=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/12/12 2:14, Mina Almasry wrote:
> > On Mon, Dec 11, 2023 at 3:51=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2023/12/11 12:04, Mina Almasry wrote:
> >>> On Sun, Dec 10, 2023 at 6:26=E2=80=AFPM Mina Almasry <almasrymina@goo=
gle.com> wrote:
> >>>>
> >>>> On Sun, Dec 10, 2023 at 6:04=E2=80=AFPM Yunsheng Lin <linyunsheng@hu=
awei.com> wrote:
> >>>>>
> >>>>> On 2023/12/9 0:05, Mina Almasry wrote:
> >>>>>> On Fri, Dec 8, 2023 at 1:30=E2=80=AFAM Yunsheng Lin <linyunsheng@h=
uawei.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> As mentioned before, it seems we need to have the above checking =
every
> >>>>>>> time we need to do some per-page handling in page_pool core, is t=
here
> >>>>>>> a plan in your mind how to remove those kind of checking in the f=
uture?
> >>>>>>>
> >>>>>>
> >>>>>> I see 2 ways to remove the checking, both infeasible:
> >>>>>>
> >>>>>> 1. Allocate a wrapper struct that pulls out all the fields the pag=
e pool needs:
> >>>>>>
> >>>>>> struct netmem {
> >>>>>>         /* common fields */
> >>>>>>         refcount_t refcount;
> >>>>>>         bool is_pfmemalloc;
> >>>>>>         int nid;
> >>>>>>         ...
> >>>>>>         union {
> >>>>>>                 struct dmabuf_genpool_chunk_owner *owner;
> >>>>>>                 struct page * page;
> >>>>>>         };
> >>>>>> };
> >>>>>>
> >>>>>> The page pool can then not care if the underlying memory is iov or
> >>>>>> page. However this introduces significant memory bloat as this str=
uct
> >>>>>> needs to be allocated for each page or ppiov, which I imagine is n=
ot
> >>>>>> acceptable for the upside of removing a few static_branch'd if
> >>>>>> statements with no performance cost.
> >>>>>>
> >>>>>> 2. Create a unified struct for page and dmabuf memory, which the m=
m
> >>>>>> folks have repeatedly nacked, and I imagine will repeatedly nack i=
n
> >>>>>> the future.
> >>>>>>
> >>>>>> So I imagine the special handling of ppiov in some form is critica=
l
> >>>>>> and the checking may not be removable.
> >>>>>
> >>>>> If the above is true, perhaps devmem is not really supposed to be i=
ntergated
> >>>>> into page_pool.
> >>>>>
> >>>>> Adding a checking for every per-page handling in page_pool core is =
just too
> >>>>> hacky to be really considerred a longterm solution.
> >>>>>
> >>>>
> >>>> The only other option is to implement another page_pool for ppiov an=
d
> >>>> have the driver create page_pool or ppiov_pool depending on the stat=
e
> >>>> of the netdev_rx_queue (or some helper in the net stack to do that f=
or
> >>>> the driver). This introduces some code duplication. The ppiov_pool &
> >>>> page_pool would look similar in implementation.
> >>
> >> I think there is a design pattern already to deal with this kind of pr=
oblem,
> >> refactoring common code used by both page_pool and ppiov into a librar=
y to
> >> aovid code duplication if most of them have similar implementation.
> >>
> >
> > Code can be refactored if it's identical, not if it is similar. I
>
> Similarity indicates an opportunity to the refactor out the common
> code, like the page_frag case below:
> https://patchwork.kernel.org/project/netdevbpf/cover/20231205113444.63015=
-1-linyunsheng@huawei.com/
>
> But untill we do a proof of concept implemention, it is hard to tell if
> it is feasiable or not.
>
> > suspect the page_pools will be only similar, and if you're not willing
> > to take devmem handling into the page pool then refactoring page_pool
> > code into helpers that do devmem handling may also not be an option.
> >
> >>>>
> >>>> But this was all discussed in detail in RFC v2 and the last response=
 I
> >>>> heard from Jesper was in favor if this approach, if I understand
> >>>> correctly:
> >>>>
> >>>> https://lore.kernel.org/netdev/7aedc5d5-0daf-63be-21bc-3b724cc1cab9@=
redhat.com/
> >>>>
> >>>> Would love to have the maintainer weigh in here.
> >>>>
> >>>
> >>> I should note we may be able to remove some of the checking, but mayb=
e not all.
> >>>
> >>> - Checks that disable page fragging for ppiov can be removed once
> >>> ppiov has frag support (in this series or follow up).
> >>>
> >>> - If we use page->pp_frag_count (or page->pp_ref_count) for
> >>> refcounting ppiov, we can remove the if checking in the refcounting.
> >>>
> >
> > I'm not sure this is actually possible in the short term. The
> > page_pool uses both page->_refcount and page->pp_frag_count for
> > refcounting, and I will not be able to remove the special handling
> > around page->_refcount as i'm not allowed to call page_ref_*() APIs on
> > a non-struct page.
>
> the page_ref_*() API may be avoided using the below patch:
> https://patchwork.kernel.org/project/netdevbpf/patch/20231113130041.58124=
-7-linyunsheng@huawei.com/
>

Even after the patch above, you're still calling page_ref_count() in
the page_pool to check for recycling, so after that patch you're still
using page->_refcount.

> But I am not sure how to do that for tx part if devmem for tx is not
> intergating into page_pool, that is why I suggest having a tx implementat=
ion
> for the next version, so that we can have a whole picture of devmem.
>

I strongly prefer to keep the TX implementation in a separate series.
This series is complicated to implement and review as it is, and is
hitting the 15 patch limit anyway.

> >
> >>> - We may be able to store the dma_addr of the ppiov in page->dma_addr=
,
> >>> but I'm unsure if that actually works, because the dma_buf dmaddr is
> >>> dma_addr_t (u32 or u64), but page->dma_addr is unsigned long (4 bytes
> >>> I think). But if it works for pages I may be able to make it work for
> >>> ppiov as well.
> >>>
> >>> - Checks that obtain the page->pp can work with ppiov if we align the
> >>> offset of page->pp and ppiov->pp.
> >>>
> >>> - Checks around page->pp_magic can be removed if we also have offset
> >>> aligned ppiov->pp_magic.
> >>>
> >>> Sadly I don't see us removing the checking for these other cases:
> >>>
> >>> - page_is_pfmemalloc(): I'm not allowed to pass a non-struct page int=
o
> >>> that helper.
> >>
> >> We can do similar trick like above as bit 1 of page->pp_magic is used =
to
> >> indicate that if it is a pfmemalloc page.
> >>
> >
> > Likely yes.
> >
> >>>
> >>> - page_to_nid(): I'm not allowed to pass a non-struct page into that =
helper.
> >>
> >> Yes, this one need special case.
> >>
> >>>
> >>> - page_pool_free_va(): ppiov have no va.
> >>
> >> Doesn't the skb_frags_readable() checking will protect the page_pool_f=
ree_va()
> >> from being called on devmem?
> >>
> >
> > This function seems to be only called from veth which doesn't support
> > devmem. I can remove the handling there.
> >
> >>>
> >>> - page_pool_sync_for_dev/page_pool_dma_map: ppiov backed by dma-buf
> >>> fundamentally can't get mapped again.
> >>
> >> Can we just fail the page_pool creation with PP_FLAG_DMA_MAP and
> >> DMA_ATTR_SKIP_CPU_SYNC flags for devmem provider?
> >>
> >
> > Jakub says PP_FLAG_DMA_MAP must be enabled for devmem, such that the
> > page_pool handles the dma mapping of the devmem and the driver doesn't
> > use it on its own.
>
> I am not sure what benefit does it bring by enabling the DMA_MAP for devm=
em,
> as devmem seems to call dma_buf_map_attachment() in netdev_bind_dmabuf(),=
 it
> does not really need enabling PP_FLAG_DMA_MAP to get the dma addr for the
> devmem chunk.

--=20
Thanks,
Mina

