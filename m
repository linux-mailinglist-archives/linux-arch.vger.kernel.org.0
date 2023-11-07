Return-Path: <linux-arch+bounces-15-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF4A7E3235
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 01:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793DB280E3B
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC410F0;
	Tue,  7 Nov 2023 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GaVApw0h"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED16315AA
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 00:24:08 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55447125
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 16:24:04 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45d94e7759eso1514883137.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 16:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699316643; x=1699921443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpkgociZWtNmHNqup8fc4OP6m9kvy0WIbsUu3JqjrFo=;
        b=GaVApw0hOud1Xw6db4glBTFJo8iBe1OqNQoGimb+Dtp+ClwWvIbxnPmHJakYWqO+nk
         3LOPE8evloiG3m1Pd5se8xet9e5/WYduh1HWtdb2sFo8NMQdTVmqqsXWVeY0MwtqsQZi
         gB3NNIn71w9awI2qYBu2Myc1kvU4uf1TI5DGSk7x6aASQCpqONOGkSpWiqpW/NFSs2IQ
         usMwoNyRZMjfyhLcoW8a9IWrmKwglyEw+wwAMfQ6HTTvr6mIoZ3CEMf3JiUqWgFP7Sse
         yZXJQLVIB87K6smWXXP7X5aKZQsVpqTJ0C413h8hgLX7qnkz2MGnj6u9e1+qzgH1phWZ
         4Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699316643; x=1699921443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpkgociZWtNmHNqup8fc4OP6m9kvy0WIbsUu3JqjrFo=;
        b=hiiHOBlntZhKGMEW2VkDTjTqOD92vrRjLL14EKtgpikHrJBsokzG51dp7IjXtVRbuJ
         kXSvOQW22hEtDMwKhfndtXG68m+Cwac/pB3PMnagC+ya394jqKl2tbbbTYw15HVmmn5a
         L3xRoQz36rMBbwZD6rTEPEKpkDcPrnczqdUa4t3sHphdEXkW5xWwJHDI2Xo/RFuk4YsY
         DeQk6aWOzwqlRpbI8hSu920M72w4vZDMUmTzWrnuNWZwaJYt2puFUEYxRz9O3rxtUR+M
         tompmWGmoLfNcynPSHD4UnvX2voNlDQ8lwHACIoMgJZ9sqTLhfbSTHX1qBSfwTmRdAtn
         zMmg==
X-Gm-Message-State: AOJu0Yxo0gLRLVTtWeZh5Fpzn9mWz+rXqEM0rsuIbwtaXEtOotQC6+JA
	ZA2UA74JFGaL7h3OiKecgpLW02Vx+jLSF/Jgkph6HwQJjHmqjP19PEM=
X-Google-Smtp-Source: AGHT+IETMKyQIhhyycP7VfpcyOAP+36Ndh1eORahNjRPB1IML5/P0pzLe4lyVRhYqpQBeNyazLdIIUZ8jHzBSAAkKuo=
X-Received: by 2002:a05:6102:2049:b0:45f:642e:41c with SMTP id
 q9-20020a056102204900b0045f642e041cmr2136927vsr.13.1699316643304; Mon, 06 Nov
 2023 16:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com> <fa44c3d1-92b9-4686-ab3b-4fcda257aafd@kernel.org>
In-Reply-To: <fa44c3d1-92b9-4686-ab3b-4fcda257aafd@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Nov 2023 16:23:52 -0800
Message-ID: <CAHS8izPW++mf1rq2XdezvXJpxhc6Ey1-_2nbpEymm5KThV18yw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 4:16=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 11/5/23 7:44 PM, Mina Almasry wrote:
> > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > index 176eb5834746..cdd4fb129968 100644
> > --- a/net/core/datagram.c
> > +++ b/net/core/datagram.c
> > @@ -425,6 +425,9 @@ static int __skb_datagram_iter(const struct sk_buff=
 *skb, int offset,
> >                       return 0;
> >       }
> >
> > +     if (skb_frags_not_readable(skb))
> > +             goto short_copy;
> > +
> >       /* Copy paged appendix. Hmm... why does this look so complicated?=
 */
> >       for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> >               int end;
> > @@ -616,6 +619,9 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, str=
uct sock *sk,
> >  {
> >       int frag;
> >
> > +     if (skb_frags_not_readable(skb))
> > +             return -EFAULT;
>
> This check ....
> > +
> >       if (msg && msg->msg_ubuf && msg->sg_from_iter)
> >               return msg->sg_from_iter(sk, skb, from, length);
>
>
> ... should go here. That allows custome sg_from_iter to have access to
> the skb. What matters is not expecting struct page (e.g., refcounting);
> if the custom iter does not do that then all is well. io_uring's iter
> does not look at the pages, so all good.
>
> >
> > diff --git a/net/core/gro.c b/net/core/gro.c
> > index 42d7f6755f32..56046d65386a 100644
> > --- a/net/core/gro.c
> > +++ b/net/core/gro.c
> > @@ -390,6 +390,9 @@ static void gro_pull_from_frag0(struct sk_buff *skb=
, int grow)
> >  {
> >       struct skb_shared_info *pinfo =3D skb_shinfo(skb);
> >
> > +     if (WARN_ON_ONCE(skb_frags_not_readable(skb)))
> > +             return;
> > +
> >       BUG_ON(skb->end - skb->tail < grow);
> >
> >       memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);
> > @@ -411,7 +414,7 @@ static void gro_try_pull_from_frag0(struct sk_buff =
*skb)
> >  {
> >       int grow =3D skb_gro_offset(skb) - skb_headlen(skb);
> >
> > -     if (grow > 0)
> > +     if (grow > 0 && !skb_frags_not_readable(skb))
> >               gro_pull_from_frag0(skb, grow);
> >  }
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 13eca4fd25e1..f01673ed2eff 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1230,6 +1230,14 @@ void skb_dump(const char *level, const struct sk=
_buff *skb, bool full_pkt)
> >               struct page *p;
> >               u8 *vaddr;
> >
> > +             if (skb_frag_is_page_pool_iov(frag)) {
>
> Why skb_frag_is_page_pool_iov here vs skb_frags_not_readable?

Seems like a silly choice on my end. I should probably check
skb_frags_not_readable() and not kmap any frags in that case. Will do.

--=20
Thanks,
Mina

