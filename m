Return-Path: <linux-arch+bounces-876-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5D380BF27
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 03:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A48280C65
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7682513ACD;
	Mon, 11 Dec 2023 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfkHS50p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D9BFE
	for <linux-arch@vger.kernel.org>; Sun, 10 Dec 2023 18:30:44 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d3efc071e2so37177017b3.0
        for <linux-arch@vger.kernel.org>; Sun, 10 Dec 2023 18:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702261843; x=1702866643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAtSrNzMXsIYIDI7PZZlxLCtSwOpIMs+ASH6ed+/tjA=;
        b=kfkHS50p/4DfNP73jFkplJQx4+JWvLxxa4LNvTSeGoobcrko2XLvH/NZ6quTsMZOab
         NdmWYAdwVF5MHT60/4DLYtOy/Mnc6lgNY5mRQRi9VN+MeHEjJn6W2Nu7My0R/qMau35o
         ZGeLxcxNzIt6VNoq6m66hbN4DOADYj6G1N1sQLZNH6L83ux1jH7ZPP/ng7Nzbx+oFzOs
         B/FYaffWCTuNe3H+AgTPhV+T83nDHYMsEmdMmzfrStfzLvqsqDQPt7MTUaVyRjg1gyTr
         4xAR8TXLHR0iX6iGwEDVYqFq2zs52meOjlTYsps2O2U7TXT5bJFrOft9um4vkdwyxILq
         PQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702261843; x=1702866643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAtSrNzMXsIYIDI7PZZlxLCtSwOpIMs+ASH6ed+/tjA=;
        b=eDVmyDGi5W/xZNu3AmF86waAt7bbwZd+NdHbgaIjPI18aGEn3WTbY0a+bR3OeeNQdZ
         AWDdhrHXOuIMOzs9++icp0jReXZTB7oaxbZ7WvNmy4MhK+Kjc0NiYgQBELoo802dp7ew
         R33fEkDMuqdb6aJLDyW9+Tg9PQmFTZCpTakIa2SRXf8lXNk3PhiaPN+66qjfxBoc9XC8
         RUfqQznWM/OjUaecGYP7eXg4tRTT2zf7Wrb2RCY3vn5CNOkQp74N/Rh5ldnYhg9kKmlS
         zhuzsH6P2lfJfb1rnpu79/sE+tJJvOnsdU5wj4DhefhjuItjKnyw3ka+MyiIjNZYevLL
         ycFA==
X-Gm-Message-State: AOJu0Yy1bKBXF/Yh8Y22zY/ozS6hPqI130h6biqorEMxIpcoEe/uY3ot
	UYyacZ3DpJUbti7i84W+t35XcDp+yr1dkkSpOAlXsQ==
X-Google-Smtp-Source: AGHT+IGGqMlSPjDVYieXAFXfTdaTOxuiJ3lLEL51+OWjNcqSXuTv2PUuu9mIj5zJTvIoqC0km/gDSIto1RwhSwcpwjo=
X-Received: by 2002:a0d:ef46:0:b0:5d7:1941:2c26 with SMTP id
 y67-20020a0def46000000b005d719412c26mr2628477ywe.83.1702261842924; Sun, 10
 Dec 2023 18:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com> <b07a4eca-0c3d-4620-9f97-b1d2c76642c2@gmail.com>
 <CAHS8izNVFx6oHoo7y86P8Di9VCVe8A_n_9UZFkg5Wnt=A=YcNQ@mail.gmail.com> <b1aea7bc-9627-499a-9bee-d2cc07856978@gmail.com>
In-Reply-To: <b1aea7bc-9627-499a-9bee-d2cc07856978@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 10 Dec 2023 18:30:31 -0800
Message-ID: <CAHS8izPry13h49v+PqrmWSREZKZjYpPesxUTyPQy7AGyFwzo4g@mail.gmail.com>
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory provider
To: Pavel Begunkov <asml.silence@gmail.com>
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
	Yunsheng Lin <linyunsheng@huawei.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 7:05=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 12/8/23 23:25, Mina Almasry wrote:
> > On Fri, Dec 8, 2023 at 2:56=E2=80=AFPM Pavel Begunkov <asml.silence@gma=
il.com> wrote:
> >>
> >> On 12/8/23 00:52, Mina Almasry wrote:
> > ...
> >>> +     if (pool->p.queue)
> >>> +             binding =3D READ_ONCE(pool->p.queue->binding);
> >>> +
> >>> +     if (binding) {
> >>> +             pool->mp_ops =3D &dmabuf_devmem_ops;
> >>> +             pool->mp_priv =3D binding;
> >>> +     }
> >>
> >> Hmm, I don't understand why would we replace a nice transparent
> >> api with page pool relying on a queue having devmem specific
> >> pointer? It seemed more flexible and cleaner in the last RFC.
> >>
> >
> > Jakub requested this change and may chime in, but I suspect it's to
> > further abstract the devmem changes from driver. In this iteration,
> > the driver grabs the netdev_rx_queue and passes it to the page_pool,
> > and any future configurations between the net stack and page_pool can
> > be passed this way with the driver unbothered.
>
> Ok, that makes sense, but even if passed via an rx queue I'd
> at least hope it keeping abstract provider parameters, e.g.
> ops, but not hard coded with devmem specific code.
>
> It might even be better done with a helper like
> create_page_pool_from_queue(), unless there is some deeper
> interaction b/w pp and rx queues is predicted.
>

Off hand I don't see the need for a new create_page_pool_from_queue().
page_pool_create() already takes in a param arg that lets us pass in
the queue as well as any other params.

> >>> +
> >>>        if (pool->mp_ops) {
> >>>                err =3D pool->mp_ops->init(pool);
> >>>                if (err) {
> >>> @@ -1020,3 +1033,77 @@ void page_pool_update_nid(struct page_pool *po=
ol, int new_nid)
> >>>        }
> >>>    }
> >>>    EXPORT_SYMBOL(page_pool_update_nid);
> >>> +
> >>> +void __page_pool_iov_free(struct page_pool_iov *ppiov)
> >>> +{
> >>> +     if (WARN_ON(ppiov->pp->mp_ops !=3D &dmabuf_devmem_ops))
> >>> +             return;
> >>> +
> >>> +     netdev_free_dmabuf(ppiov);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(__page_pool_iov_free);
> >>
> >> I didn't look too deep but I don't think I immediately follow
> >> the pp refcounting. It increments pages_state_hold_cnt on
> >> allocation, but IIUC doesn't mark skbs for recycle? Then, they all
> >> will be put down via page_pool_iov_put_many() bypassing
> >> page_pool_return_page() and friends. That will call
> >> netdev_free_dmabuf(), which doesn't bump pages_state_release_cnt.
> >>
> >> At least I couldn't make it work with io_uring, and for my purposes,
> >> I forced all puts to go through page_pool_return_page(), which calls
> >> the ->release_page callback. The callback will put the reference and
> >> ask its page pool to account release_cnt. It also gets rid of
> >> __page_pool_iov_free(), as we'd need to add a hook there for
> >> customization otherwise.
> >>
> >> I didn't care about overhead because the hot path for me is getting
> >> buffers from a ring, which is somewhat analogous to sock_devmem_dontne=
ed(),
> >> but done on pp allocations under napi, and it's done separately.
> >>
> >> Completely untested with TCP devmem:
> >>
> >> https://github.com/isilence/linux/commit/14bd56605183dc80b540999e8058c=
79ac92ae2d8
> >>
> >
> > This was a mistake in the last RFC, which should be fixed in v1. In
> > the RFC I was not marking the skbs as skb_mark_for_recycle(), so the
> > unreffing path wasn't as expected.
> >
> > In this iteration, that should be completely fixed. I suspect since I
> > just posted this you're actually referring to the issue tested on the
> > last RFC? Correct me if wrong.
>
> Right, it was with RFCv3
>
> > In this iteration, the reffing story:
> >
> > - memory provider allocs ppiov and returns it to the page pool with
> > ppiov->refcount =3D=3D 1.
> > - The page_pool gives the page to the driver. The driver may
> > obtain/release references with page_pool_page_[get|put]_many(), but
> > the driver is likely not doing that unless it's doing its own page
> > recycling.
> > - The net stack obtains references via skb_frag_ref() ->
> > page_pool_page_get_many()
> > - The net stack drops references via skb_frag_unref() ->
> > napi_pp_put_page() -> page_pool_return_page() and friends.
> >
> > Thus, the issue where the unref path was skipping
> > page_pool_return_page() and friends should be resolved in this
> > iteration, let me know if you think otherwise, but I think this was an
> > issue limited to the last RFC.
>
> Then page_pool_iov_put_many() should and supposedly would never be
> called by non devmap code because all puts must circle back into
> ->release_page. Why adding it to into page_pool_page_put_many()?
>
> @@ -731,6 +731,29 @@ __page_pool_put_page(struct page_pool *pool, struct =
page *page,
> +       if (page_is_page_pool_iov(page)) {
> ...
> +               page_pool_page_put_many(page, 1);
> +               return NULL;
> +       }
>
> Well, I'm looking at this new branch from Patch 10, it can put
> the buffer, but what if we race at it's actually the final put?
> Looks like nobody is going to to bump up pages_state_release_cnt
>

Good catch, I think indeed the release_cnt would be incorrect in this
case. I think the race is benign in the sense that the ppiov will be
freed correctly and available for allocation when the page_pool next
needs it; the issue is with the stats AFAICT.

> If you remove the branch, let it fall into ->release and rely
> on refcounting there, then the callback could also fix up
> release_cnt or ask pp to do it, like in the patch I linked above
>

Sadly I don't think this is possible due to the reasons I mention in
the commit message of that patch. Prematurely releasing ppiov and not
having them be candidates for recycling shows me a 4-5x degradation in
performance.

What I could do here is detect that the refcount was dropped to 0 and
fix up the stats in that case.

--=20
Thanks,
Mina

