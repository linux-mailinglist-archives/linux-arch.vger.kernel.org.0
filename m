Return-Path: <linux-arch+bounces-72-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9307E4DB1
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 01:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEA91C20A44
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 00:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2851650;
	Wed,  8 Nov 2023 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PSMIJXl"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38262A
	for <linux-arch@vger.kernel.org>; Wed,  8 Nov 2023 00:02:51 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815510D2
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 16:02:50 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7ba6fa81aabso2826631241.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699401769; x=1700006569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhGCgNMMnqKk3D3DcXRS957yq5a/Kz42rRw6Zd9CW+U=;
        b=1PSMIJXl9RupistbaT8e/WtduGUftDhNnA3/ee/wMeOwhoMNOOj9ofAuaMycpyNXZu
         zQJU9nyZMQr5dKjNqV6QRFNriGNno6PhYtvUVv76CQ0jp2z/+gRiYrUcxHn0vMZ5lbSI
         LJfi6+7WUffhmSpa6GLqI8h0oOayhDKapd1MPeFnCq7HvpuJYKbIqQlR0WIekKHgRCRO
         TyTisICSI9vyzZMvq852e3Dv7udplOnciSR2hLACULPoRb5HPZduAarn+m0UNTX50gND
         HHzJG45PV7yNkrIObg3EkvqXVeL3k3AO+ADdYal7GVMDi7pR3lsFUmopzGIaERRw2PCl
         hnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699401769; x=1700006569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhGCgNMMnqKk3D3DcXRS957yq5a/Kz42rRw6Zd9CW+U=;
        b=H00qkOGYebVq6COB3kmz26iz9SUWm+L29netZPpaYmvLkGB4yzGJPV0MSieawK7BgF
         DQSRN6MZu39aVvT0jxcSc4976h/ONQjYaoZ8WLxeNs5VFbU6fyNXHDvLxJFh9lzUmT0t
         XH8qy6TNkjNxA7g791R96orkVw1sTI/Bb2mkWjGf6OKrFKF9zAqnnvsDBlE0je6lVO0X
         3ySrWCxzax5sFgfC6lSEXvWr9ymH66RD3NhQtw9im83MZxZ5pDE5Xrc9AmfTao6mLb8V
         nmrz24Zcecu5hN0ga2B43tO4dCbjP8suTGiK17xRtxBVJ8zZob/JBcCDX8SOO/O8oghq
         Kk6A==
X-Gm-Message-State: AOJu0Yy9KFXcsSxgzVY8zZNP3OtieRxkHA8vDWQSUPTUpRSdjyTWaXte
	ZIxtv1YtM+IauKYIF2KO/MmRquIMFo0vMcLaKuwYLQ==
X-Google-Smtp-Source: AGHT+IFms8ZvtGXtemkp+mi4ABPteesfsjhExnDKjmFJ+Eb3POz3AZg+/vWO+o8o1uY0zVVc5E9w65kScoa/ixFh4MU=
X-Received: by 2002:a05:6102:20de:b0:45f:57b4:c20d with SMTP id
 i30-20020a05610220de00b0045f57b4c20dmr259111vsr.2.1699401769314; Tue, 07 Nov
 2023 16:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-7-almasrymina@google.com> <583db67b-96c6-4e17-bea0-b5a14799db4a@kernel.org>
In-Reply-To: <583db67b-96c6-4e17-bea0-b5a14799db4a@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Nov 2023 16:02:38 -0800
Message-ID: <CAHS8izME7NixQrrh+qKnMR4+FyTzKW=B2pYyNffJ+igiehe-7g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory provider
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

On Mon, Nov 6, 2023 at 1:02=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 11/05, Mina Almasry wrote:
> > +static inline bool page_is_page_pool_iov(const struct page *page)
> > +{
> > +     return (unsigned long)page & PP_DEVMEM;
> > +}
>
> Speaking of bpf: one thing that might be problematic with this PP_DEVMEM
> bit is that it will make debugging with bpftrace a bit (more)
> complicated. If somebody were trying to get to that page_pool_iov from
> the frags, they will have to do the equivalent of page_is_page_pool_iov,
> but probably not a big deal? (thinking out loud)

Good point, but that doesn't only apply to bpf I think. I'm guessing
even debugger drgn access to the bv_page in the frag will have trouble
if it's actually accessing an iov with LSB set.

But this is not specific to this use for LSB pointer trick. I think
all code that currently uses LSB pointer trick will have similar
troubles. In this context my humble vote is that we get such big
upside from reducing code churn that it's reasonable to tolerate such
side effects.

I could alleviate some of the issues by teaching drgn to do the right
thing for devmem/iovs... time permitting.

On Mon, Nov 6, 2023 at 3:49=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 11/5/23 7:44 PM, Mina Almasry wrote:
> > diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/he=
lpers.h
> > index 78cbb040af94..b93243c2a640 100644
> > --- a/include/net/page_pool/helpers.h
> > +++ b/include/net/page_pool/helpers.h
> > @@ -111,6 +112,45 @@ page_pool_iov_binding(const struct page_pool_iov *=
ppiov)
> >       return page_pool_iov_owner(ppiov)->binding;
> >  }
> >
> > +static inline int page_pool_iov_refcount(const struct page_pool_iov *p=
piov)
> > +{
> > +     return refcount_read(&ppiov->refcount);
> > +}
> > +
> > +static inline void page_pool_iov_get_many(struct page_pool_iov *ppiov,
> > +                                       unsigned int count)
> > +{
> > +     refcount_add(count, &ppiov->refcount);
> > +}
> > +
> > +void __page_pool_iov_free(struct page_pool_iov *ppiov);
> > +
> > +static inline void page_pool_iov_put_many(struct page_pool_iov *ppiov,
> > +                                       unsigned int count)
> > +{
> > +     if (!refcount_sub_and_test(count, &ppiov->refcount))
> > +             return;
> > +
> > +     __page_pool_iov_free(ppiov);
> > +}
> > +
> > +/* page pool mm helpers */
> > +
> > +static inline bool page_is_page_pool_iov(const struct page *page)
> > +{
> > +     return (unsigned long)page & PP_DEVMEM;
>
> This is another one where the code can be more generic to not force a
> lot changes later.  e.g., PP_CUSTOM or PP_NO_PAGE. Then io_uring use
> case with host memory can leverage the iov pool in a similar manner.
>
> That does mean skb->devmem needs to be a flag on the page pool and not
> just assume iov =3D=3D device memory.
>
>
>


--=20
Thanks,
Mina

