Return-Path: <linux-arch+bounces-188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBB7E9587
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 04:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98451F210F5
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 03:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C2883A;
	Mon, 13 Nov 2023 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSrHsh9B"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E8A8838
	for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 03:29:07 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC74171C
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 19:29:05 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-45db31f9156so1717470137.1
        for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 19:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699846145; x=1700450945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2dGyXj5qPWx8L/oD7d/kJ2B1kSBzAWVgjHl9+VbT5g=;
        b=CSrHsh9BqDX/+zONieAXevR7NLb18gQCuO78q5RU/ltdr9vQOM6ranCrMqhyi32jaL
         s2UzxX2G44i/g9AwnqRS7KMooFi8rKcU407idcCYkgZgfyIaHJXjIViF1Vf6QgXBhLXp
         TAFJPZ3A5m0olNiegRJtM4hoU/mm7At7ggx1gOSdH2+fi+NDLdLpauJljnDMQBkOHVbg
         l3Q0iMNuJn+Ciz9hUm+CN0g31WPchNENDrmiOz29CF7d1aAI4Os1ZmfxJMukV+0rx6GG
         33ED0ficMpON3UfmQaf2mWdIaNurZPD2uU4wSUJVQ03HqG3Nvg3A5DDiVjVZp5HvN++k
         aJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699846145; x=1700450945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2dGyXj5qPWx8L/oD7d/kJ2B1kSBzAWVgjHl9+VbT5g=;
        b=kLVA9VwZSe+aRNrWz5iGRtqvTU04zOV8HY/rGtmAZ7uF5P5kg9ndQPCflOPBgbCGrl
         Gk3U4zEd442S9CgXthqWcJnIN3eeKLansOmS2mq/1n5UpPfyplhQkXVu9TmVHJ4/2ExU
         StkgrrthB/DDGnmJsyWDKs0YwIyfkbtyRYxI9bzLr7hl6qU0QHZDYLntbJBwbcjmD2Um
         w6mPb+c0p1Dm3V3Zkw3Hhrn9rIbePIBtXHkb8IVd2gIiQhup4lwlPcCJTSrJT7ODs4PJ
         VwUwxOem4Aeym0owc3eNaj4WvqTBVLusaHEiLQZK83A20zDZIADSyHviWt7PfBe5woxg
         rl4A==
X-Gm-Message-State: AOJu0YyDaC/4cU3ou9afg5DjjehQIm7YFKK/D1WvJEudIAGcv0lq9V8J
	nGX2SHB5vnMCtTcUlveyoFUcFqdFb4g+7xSbjD12sA==
X-Google-Smtp-Source: AGHT+IHF2Jct5wlvc5iEDA5CXatiC4I+LjFNu9wrknK+tB6gu0XrkZJBw+kq39swHZW/DhuGkGJI2Nhu4+A/S+uBIBE=
X-Received: by 2002:a05:6102:23cd:b0:45d:989b:da4a with SMTP id
 x13-20020a05610223cd00b0045d989bda4amr4899045vsr.22.1699846144896; Sun, 12
 Nov 2023 19:29:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-3-almasrymina@google.com> <20231110151907.023c61cd@kernel.org>
In-Reply-To: <20231110151907.023c61cd@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 12 Nov 2023 19:28:52 -0800
Message-ID: <CAHS8izPKRh7ukRytXaweKcY_76sE7F_3s1sYVgsUXYGrypK93Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/12] net: page_pool: create hooks for custom page providers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 3:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  5 Nov 2023 18:44:01 -0800 Mina Almasry wrote:
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
> > index 6fc5134095ed..d4bea053bb7e 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -60,6 +60,8 @@ struct page_pool_params {
> >       int             nid;
> >       struct device   *dev;
> >       struct napi_struct *napi;
> > +     u8              memory_provider;
> > +     void            *mp_priv;
> >       enum dma_data_direction dma_dir;
> >       unsigned int    max_len;
> >       unsigned int    offset;
>
> you should rebase on top of net-next
>
> More importantly I was expecting those fields to be gone from params.
> The fact that the page pool is configured to a specific provider
> should be fully transparent to the driver, driver should just tell
> the core what queue its creating the pool from and if there's a dmabuf
> bound for that queue - out pops a pp backed by the dmabuf.
>

My issue with this is that if the driver doesn't support dmabuf then
the driver will accidentally use the pp backed by the dmabuf, allocate
a page from it, then call page_address() on it or something, and
crash.

Currently I avoid that by having the driver be responsible for picking
up the dmabuf from the netdev_rx_queue and giving it to the page pool.
What would be the appropriate way to check for driver support in the
netlink API? Perhaps adding something to ndo_features_check?

--=20
Thanks,
Mina

