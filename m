Return-Path: <linux-arch+bounces-968-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5128810BE4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 08:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F52D1F212CD
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 07:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A981CAA9;
	Wed, 13 Dec 2023 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sp6Pj7hK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32D8100
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:52:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so51534015e9.3
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702453969; x=1703058769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M39btmxp5CMOvqAic+iM2gRDFVus/hb+Dtb73l5YcRQ=;
        b=sp6Pj7hKu+lK93QwTGNytyOkZEVL5VJgYXC/Te9Dly9QURdrnkTE7T8YZ6bsdqAmQJ
         YNuMF9yHWUEu2W3LBADG6YUzvWsZGt39sDhQuKWWVG4sc1USFv24IPAGOaSz/SLgFQb5
         PqtSfIq8je9pE68QSc5Coq2hulrEIpM2Iqd70uE4xjLzGnO0022NwWhazV67NqZXgmt7
         AZsOKcCA5SE+4R2ujHMyc+3DSpK2MKGXNOaov+lJR2UGDf4q1SU1t9PPlRWKLELweOWP
         O5N+2azhs26gSyE9CpsxsXo7NHxabfaEr4pxhoGvHMJKcE+9fEaS3Ybhq64n7P99YUb0
         /Kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702453969; x=1703058769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M39btmxp5CMOvqAic+iM2gRDFVus/hb+Dtb73l5YcRQ=;
        b=EhlledN5o4FaZWucYsIcNkDq1kONQaY0RTafj0M1CgtIcZ7xswiQCp8ysOu7lQcwQk
         cFPFCr+t8EX3lL6kQudGXJHsPxhXdfcqUxXkoq+jjc7/yZ8x+YxFeJ2VwoSYzZNwoFab
         Jh9s4Y4AsqOTtOGDrUOaGhwWAIa5yN8NYpeuaJK44tH7nxotMFuaqL/BCB+XrWcte/aB
         EpgQZAnZC6xUgy+xpXm6P2N7Q2rXmuDJtITCsCv5wft00+j3AAqmH/Nnw5BTFY1sVpPV
         CL8zBQHPG7kOBlX+4wzemBhTkPmKpgwx8j1Km/GGd7Le2TR+MKe11LMIM9G2EJr5rtq8
         vMMA==
X-Gm-Message-State: AOJu0YzoCCck3Sua44ZKpXTs77eyamHJJMeT4HOo86r366Gk2BvP0bQ1
	gWR4eIX4xkYAgEcKrJXGh+cS6V4Nzyj+YXRVikdcHw==
X-Google-Smtp-Source: AGHT+IF8GsUa/W3RJdThooSHp8WYWcUSc4eP6rXO8ssH3BcKraug5UQYXMvk50EClsQDU3QAMz82hldzzEvDsMEPiCw=
X-Received: by 2002:a05:600c:11ce:b0:40c:377c:4b62 with SMTP id
 b14-20020a05600c11ce00b0040c377c4b62mr3749772wmi.50.1702453969020; Tue, 12
 Dec 2023 23:52:49 -0800 (PST)
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
In-Reply-To: <CAHS8izN6Cbjy0FCYhJyNsP396XfgJ_nTFXWuHb5QWNct=PifAg@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 23:52:34 -0800
Message-ID: <CAHS8izODNXtmhBoPk6z=wuj8tvbndcHHHxcZmH64hY57znT-Mg@mail.gmail.com>
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

On Sun, Dec 10, 2023 at 8:04=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Sun, Dec 10, 2023 at 6:26=E2=80=AFPM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > On Sun, Dec 10, 2023 at 6:04=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> > >
> > > On 2023/12/9 0:05, Mina Almasry wrote:
> > > > On Fri, Dec 8, 2023 at 1:30=E2=80=AFAM Yunsheng Lin <linyunsheng@hu=
awei.com> wrote:
> > > >>
> > > >>
> > > >> As mentioned before, it seems we need to have the above checking e=
very
> > > >> time we need to do some per-page handling in page_pool core, is th=
ere
> > > >> a plan in your mind how to remove those kind of checking in the fu=
ture?
> > > >>
> > > >
> > > > I see 2 ways to remove the checking, both infeasible:
> > > >
> > > > 1. Allocate a wrapper struct that pulls out all the fields the page=
 pool needs:
> > > >
> > > > struct netmem {
> > > >         /* common fields */
> > > >         refcount_t refcount;
> > > >         bool is_pfmemalloc;
> > > >         int nid;
> > > >         ...
> > > >         union {
> > > >                 struct dmabuf_genpool_chunk_owner *owner;
> > > >                 struct page * page;
> > > >         };
> > > > };
> > > >
> > > > The page pool can then not care if the underlying memory is iov or
> > > > page. However this introduces significant memory bloat as this stru=
ct
> > > > needs to be allocated for each page or ppiov, which I imagine is no=
t
> > > > acceptable for the upside of removing a few static_branch'd if
> > > > statements with no performance cost.
> > > >
> > > > 2. Create a unified struct for page and dmabuf memory, which the mm
> > > > folks have repeatedly nacked, and I imagine will repeatedly nack in
> > > > the future.
> > > >
> > > > So I imagine the special handling of ppiov in some form is critical
> > > > and the checking may not be removable.
> > >
> > > If the above is true, perhaps devmem is not really supposed to be int=
ergated
> > > into page_pool.
> > >
> > > Adding a checking for every per-page handling in page_pool core is ju=
st too
> > > hacky to be really considerred a longterm solution.
> > >
> >
> > The only other option is to implement another page_pool for ppiov and
> > have the driver create page_pool or ppiov_pool depending on the state
> > of the netdev_rx_queue (or some helper in the net stack to do that for
> > the driver). This introduces some code duplication. The ppiov_pool &
> > page_pool would look similar in implementation.
> >
> > But this was all discussed in detail in RFC v2 and the last response I
> > heard from Jesper was in favor if this approach, if I understand
> > correctly:
> >
> > https://lore.kernel.org/netdev/7aedc5d5-0daf-63be-21bc-3b724cc1cab9@red=
hat.com/
> >
> > Would love to have the maintainer weigh in here.
> >
>
> I should note we may be able to remove some of the checking, but maybe no=
t all.
>
> - Checks that disable page fragging for ppiov can be removed once
> ppiov has frag support (in this series or follow up).
>
> - If we use page->pp_frag_count (or page->pp_ref_count) for
> refcounting ppiov, we can remove the if checking in the refcounting.
>
> - We may be able to store the dma_addr of the ppiov in page->dma_addr,
> but I'm unsure if that actually works, because the dma_buf dmaddr is
> dma_addr_t (u32 or u64), but page->dma_addr is unsigned long (4 bytes
> I think). But if it works for pages I may be able to make it work for
> ppiov as well.
>
> - Checks that obtain the page->pp can work with ppiov if we align the
> offset of page->pp and ppiov->pp.
>
> - Checks around page->pp_magic can be removed if we also have offset
> aligned ppiov->pp_magic.
>
> Sadly I don't see us removing the checking for these other cases:
>
> - page_is_pfmemalloc(): I'm not allowed to pass a non-struct page into
> that helper.
>
> - page_to_nid(): I'm not allowed to pass a non-struct page into that help=
er.
>
> - page_pool_free_va(): ppiov have no va.
>
> - page_pool_sync_for_dev/page_pool_dma_map: ppiov backed by dma-buf
> fundamentally can't get mapped again.
>
> Are the removal (or future removal) of these checks enough to resolve thi=
s?
>

I took a deeper look here, and with some effort I'm able to remove
almost all the custom checks for ppiov. The only remaining checks for
devmem are the checks around these mm calls:

page_is_pfmemalloc()
page_to_nid()
page_ref_count()
compound_head()

page_is_pfmemalloc() checks can be removed by using a bit
page->pp_magic potentially to indicate pfmemalloc().

The other 3, I'm not sure I can remove. They rely on the page flags or
other fields not specific to page_pool pages. The next version should
come with the most minimal amount of devmem checks for the page_pool.

> > > It is somewhat ironical that devmem is using static_branch to allivia=
te the
> > > performance impact for normal memory at the possible cost of performa=
nce
> > > degradation for devmem, does it not defeat some purpose of intergatin=
g devmem
> > > to page_pool?
> > >
> >
> > I don't see the issue. The static branch sets the non-ppiov path as
> > default if no memory providers are in use, and flips it when they are,
> > making the default branch prediction ideal in both cases.
> >
> > > >
> > > >> Even though a static_branch check is added in page_is_page_pool_io=
v(), it
> > > >> does not make much sense that a core has tow different 'struct' fo=
r its
> > > >> most basic data.
> > > >>
> > > >> IMHO, the ppiov for dmabuf is forced fitting into page_pool withou=
t much
> > > >> design consideration at this point.
> > > >>
> > > > ...
> > > >>
> > > >> For now, the above may work for the the rx part as it seems that y=
ou are
> > > >> only enabling rx for dmabuf for now.
> > > >>
> > > >> What is the plan to enable tx for dmabuf? If it is also intergrate=
d into
> > > >> page_pool? There was a attempt to enable page_pool for tx, Eric se=
emed to
> > > >> have some comment about this:
> > > >> https://lkml.kernel.org/netdev/2cf4b672-d7dc-db3d-ce90-15b4e91c400=
5@huawei.com/T/#mb6ab62dc22f38ec621d516259c56dd66353e24a2
> > > >>
> > > >> If tx is not intergrated into page_pool, do we need to create a ne=
w layer for
> > > >> the tx dmabuf?
> > > >>
> > > >
> > > > I imagine the TX path will reuse page_pool_iov, page_pool_iov_*()
> > > > helpers, and page_pool_page_*() helpers, but will not need any core
> > > > page_pool changes. This is because the TX path will have to piggyba=
ck
> > >
> > > We may need another bit/flags checking to demux between page_pool own=
ed
> > > devmem and non-page_pool owned devmem.
> > >
> >
> > The way I'm imagining the support, I don't see the need for such
> > flags. We'd be re-using generic helpers like
> > page_pool_iov_get_dma_address() and what not that don't need that
> > checking.
> >
> > > Also calling page_pool_*() on non-page_pool owned devmem is confusing
> > > enough that we may need a thin layer handling non-page_pool owned dev=
mem
> > > in the end.
> > >
> >
> > The page_pool_page* & page_pool_iov* functions can be renamed if
> > confusing. I would think that's no issue (note that the page_pool_*
> > functions need not be called for TX path).
> >
> > > > on MSG_ZEROCOPY (devmem is not copyable), so no memory allocation f=
rom
> > > > the page_pool (or otherwise) is needed or possible. RFCv1 had a TX
> > > > implementation based on dmabuf pages without page_pool involvement,=
 I
> > > > imagine I'll do something similar.
> > > It would be good to have a tx implementation for the next version, so
> > > that we can have a whole picture of devmem.
> > >
> > > >
> >
> >
> >
> > --
> > Thanks,
> > Mina
>
>
>
> --
> Thanks,
> Mina



--=20
Thanks,
Mina

