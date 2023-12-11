Return-Path: <linux-arch+bounces-875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359380BF14
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 03:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C231F20F35
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 02:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEB6134B7;
	Mon, 11 Dec 2023 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zg0V5sOH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2F6F3
	for <linux-arch@vger.kernel.org>; Sun, 10 Dec 2023 18:26:42 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4662a125b64so70885137.3
        for <linux-arch@vger.kernel.org>; Sun, 10 Dec 2023 18:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702261601; x=1702866401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tcz5MXT3RaIMrhOVMWBMt5zqWEtLULnUCyi7Vfs29I=;
        b=zg0V5sOHoV1x0ibRjSnaPxr0iWn/hVo6ErutIg5WI1RH+RpTuXXmLb192Nm57HeGI9
         TfrNAvlUjAosqvPyULC8MUCgkSXNJqNDI6cqjq8x3+yQYoC1aWC9GTS+9YXHuBuGb97S
         finhrLouu1k4aZPpCg2+5MyT5BTHxntLPL7R1q/8T/I2EgtW4hcYSBoYRq25bGKoIuGO
         UB/+v1t02J6O1cfRNy1Ht9z6IisjZc0rcUmOWa6gIHa8oNFng3/P03YUuvSn5whGSgrL
         m65Bt712PgQHVm0vIRN+vJ8AdzbdA8MRPhOv5FtytBuUXKyNAICvxcQhwR5BaPoHiTBM
         k3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702261601; x=1702866401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Tcz5MXT3RaIMrhOVMWBMt5zqWEtLULnUCyi7Vfs29I=;
        b=byUEIDfCzIIvtBXeEFwndk6AV0ADX7A8q9GTb4mR4WZEFb3JM+dxAKUI5ozUwPXtog
         XY6S9HAsbjyY+dYXUU8GD6pnQjSqSP8jh2pYhA8qvcyN5HMEtQOgJe37LhWxUqv2WwRs
         hPL3al0+DYPZYQkQc3V6v0khOQ9piEpx5uyee7W97JMSUorsSlI+WCQ9+YmokCI1zMAl
         VDZ4PCgueEFuBytiArXtm9fTXVgac0c9HS93O8elKx77qdK+JWj1APqkYMTvTj5B6vuu
         y26S0QWLkfAZyelp+3EchDCybwUL0K6EUE9beesfLkdPusOgS2Wr14weS0Kb52ZyOco5
         v/Bw==
X-Gm-Message-State: AOJu0YxEdB0y/+Wca4wattttmPvFntQXXbpGPW4Pu+ekgW0pt6e2JO64
	3s630No4Dr/4Yl0Hn6dxOcc9Okf3cgQPVf3bZgFSFg==
X-Google-Smtp-Source: AGHT+IGnrr9t6+NGhIIi9S1/72Jel2CtjV+XUhQz+4hhYbzgspOPRBlJJQgX/XwiMt+LGK0mGwNI6RyoqYpB1OqRiRo=
X-Received: by 2002:a67:c11a:0:b0:462:797b:2b62 with SMTP id
 d26-20020a67c11a000000b00462797b2b62mr2228307vsj.32.1702261601420; Sun, 10
 Dec 2023 18:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-10-almasrymina@google.com> <32211cbf-3a4e-8a86-6214-4304ddb18a98@huawei.com>
 <CAHS8izOQcuLPwvDff96fuNB7r6EU9OWt3ShueQp=u7wat3L5LA@mail.gmail.com> <92e30bd9-6df4-b72f-7bcd-f4fe5670eba2@huawei.com>
In-Reply-To: <92e30bd9-6df4-b72f-7bcd-f4fe5670eba2@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 10 Dec 2023 18:26:29 -0800
Message-ID: <CAHS8izPEFsqw50qgM+sPot6XVvOExpd+DrwrmPSR3zsWGLysRw@mail.gmail.com>
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

On Sun, Dec 10, 2023 at 6:04=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/12/9 0:05, Mina Almasry wrote:
> > On Fri, Dec 8, 2023 at 1:30=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >>
> >> As mentioned before, it seems we need to have the above checking every
> >> time we need to do some per-page handling in page_pool core, is there
> >> a plan in your mind how to remove those kind of checking in the future=
?
> >>
> >
> > I see 2 ways to remove the checking, both infeasible:
> >
> > 1. Allocate a wrapper struct that pulls out all the fields the page poo=
l needs:
> >
> > struct netmem {
> >         /* common fields */
> >         refcount_t refcount;
> >         bool is_pfmemalloc;
> >         int nid;
> >         ...
> >         union {
> >                 struct dmabuf_genpool_chunk_owner *owner;
> >                 struct page * page;
> >         };
> > };
> >
> > The page pool can then not care if the underlying memory is iov or
> > page. However this introduces significant memory bloat as this struct
> > needs to be allocated for each page or ppiov, which I imagine is not
> > acceptable for the upside of removing a few static_branch'd if
> > statements with no performance cost.
> >
> > 2. Create a unified struct for page and dmabuf memory, which the mm
> > folks have repeatedly nacked, and I imagine will repeatedly nack in
> > the future.
> >
> > So I imagine the special handling of ppiov in some form is critical
> > and the checking may not be removable.
>
> If the above is true, perhaps devmem is not really supposed to be interga=
ted
> into page_pool.
>
> Adding a checking for every per-page handling in page_pool core is just t=
oo
> hacky to be really considerred a longterm solution.
>

The only other option is to implement another page_pool for ppiov and
have the driver create page_pool or ppiov_pool depending on the state
of the netdev_rx_queue (or some helper in the net stack to do that for
the driver). This introduces some code duplication. The ppiov_pool &
page_pool would look similar in implementation.

But this was all discussed in detail in RFC v2 and the last response I
heard from Jesper was in favor if this approach, if I understand
correctly:

https://lore.kernel.org/netdev/7aedc5d5-0daf-63be-21bc-3b724cc1cab9@redhat.=
com/

Would love to have the maintainer weigh in here.

> It is somewhat ironical that devmem is using static_branch to alliviate t=
he
> performance impact for normal memory at the possible cost of performance
> degradation for devmem, does it not defeat some purpose of intergating de=
vmem
> to page_pool?
>

I don't see the issue. The static branch sets the non-ppiov path as
default if no memory providers are in use, and flips it when they are,
making the default branch prediction ideal in both cases.

> >
> >> Even though a static_branch check is added in page_is_page_pool_iov(),=
 it
> >> does not make much sense that a core has tow different 'struct' for it=
s
> >> most basic data.
> >>
> >> IMHO, the ppiov for dmabuf is forced fitting into page_pool without mu=
ch
> >> design consideration at this point.
> >>
> > ...
> >>
> >> For now, the above may work for the the rx part as it seems that you a=
re
> >> only enabling rx for dmabuf for now.
> >>
> >> What is the plan to enable tx for dmabuf? If it is also intergrated in=
to
> >> page_pool? There was a attempt to enable page_pool for tx, Eric seemed=
 to
> >> have some comment about this:
> >> https://lkml.kernel.org/netdev/2cf4b672-d7dc-db3d-ce90-15b4e91c4005@hu=
awei.com/T/#mb6ab62dc22f38ec621d516259c56dd66353e24a2
> >>
> >> If tx is not intergrated into page_pool, do we need to create a new la=
yer for
> >> the tx dmabuf?
> >>
> >
> > I imagine the TX path will reuse page_pool_iov, page_pool_iov_*()
> > helpers, and page_pool_page_*() helpers, but will not need any core
> > page_pool changes. This is because the TX path will have to piggyback
>
> We may need another bit/flags checking to demux between page_pool owned
> devmem and non-page_pool owned devmem.
>

The way I'm imagining the support, I don't see the need for such
flags. We'd be re-using generic helpers like
page_pool_iov_get_dma_address() and what not that don't need that
checking.

> Also calling page_pool_*() on non-page_pool owned devmem is confusing
> enough that we may need a thin layer handling non-page_pool owned devmem
> in the end.
>

The page_pool_page* & page_pool_iov* functions can be renamed if
confusing. I would think that's no issue (note that the page_pool_*
functions need not be called for TX path).

> > on MSG_ZEROCOPY (devmem is not copyable), so no memory allocation from
> > the page_pool (or otherwise) is needed or possible. RFCv1 had a TX
> > implementation based on dmabuf pages without page_pool involvement, I
> > imagine I'll do something similar.
> It would be good to have a tx implementation for the next version, so
> that we can have a whole picture of devmem.
>
> >



--=20
Thanks,
Mina

