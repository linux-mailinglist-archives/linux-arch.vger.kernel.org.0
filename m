Return-Path: <linux-arch+bounces-64-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A433C7E4B36
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 22:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0346A281439
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867B2F85F;
	Tue,  7 Nov 2023 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUOVXhdc"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2E2F856
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 21:57:05 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B910DD
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 13:57:05 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5be6d6c04bfso606787b3.3
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699394224; x=1699999024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za6M8Y2d+jQ3Qt9gKNkmeDGWA71k/TCax11+8YIBTGE=;
        b=CUOVXhdcdM/DQfztHuawAMT/L1AEUiCtEV2qbEKvyBblelqOQ7FpmGm4sHhCGxAeoe
         oP6P8k57YbO7+F6hhZ9vXMM1mS9jEDh2/SYP5nAb97NkFWkbTi0GFdUJ6BS1oILnmWwz
         EExeVBxBu+WYAg8g4urdIcThxuVtP8FW3wM2u/KF9qnt3ZF2cVhWAo0dKZQbc7OT1Jm+
         LWMiyXp1A56lWxWQR6gk9WhQ+nb3FNLTJE6AkD2heKaNp4fKArs0VzfO+rsRA6umIfHM
         6si0lUZgbIAm/xkJsDPmfyna+uGmHUF6GYOmFTZSHHd49uT2FjkNkK+GvtqSz2pLZakA
         8r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394224; x=1699999024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za6M8Y2d+jQ3Qt9gKNkmeDGWA71k/TCax11+8YIBTGE=;
        b=BPtZzksf084HRJhkOqzEt4HhT+3w2eQG0kFsl0FLV9H7mdyActxfNlGTGERQREBfgi
         en8TAL4VEwKE+Q54wSZViWtSHBmxlpIj56DmTXjEtSXBYfwVePL0h8d6otjRxLyoJ2sP
         BX7Znt8t4+uw5qEAjGAFJc5GbCm6/niz2beO/qUTtbfAGBdRT/5gxfgv7DgukyoII2Tn
         qtbCJ9nGOPgEkgrVAB9e1dz08RJ+Vi1cWVyzIdeBN/oQMBhY7hId4qdKKuKk8jttU18G
         JyGKkkftHIzbsbPzoiURdY7r/IZKkfRhz9q5XMF00s5BAlMFXghutdlnSwtHMpeZ+piW
         LRFA==
X-Gm-Message-State: AOJu0YwXSGJJeBWCWdl2EYgycTkAy91b2Dz27wAuPpAVnQYyPDOqD2lq
	AnHUqq5xUGZPgLNsdrD1CsmbE14FObVzlBLima0R8CmmW1hZKiaNNCE=
X-Google-Smtp-Source: AGHT+IF/bsw99ICNUinQH8HJWUTE/TqZCFPYGxxxKhtjJLazoPWjgkibzNnUub2UFOZbJnwmVInaoZNQXuN3J7zXnD4=
X-Received: by 2002:a05:690c:15:b0:5b3:3eb5:6624 with SMTP id
 bc21-20020a05690c001500b005b33eb56624mr13539795ywb.46.1699394224143; Tue, 07
 Nov 2023 13:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-8-almasrymina@google.com> <4a0e9d53-324d-e19b-2a30-ba86f9e5569e@huawei.com>
In-Reply-To: <4a0e9d53-324d-e19b-2a30-ba86f9e5569e@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Nov 2023 13:56:51 -0800
Message-ID: <CAHS8izNbw7vAGo2euQGA+TF9CgQ8zwrDqTVGsOSxh22_uo0R1w@mail.gmail.com>
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

On Tue, Nov 7, 2023 at 12:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/6 10:44, Mina Almasry wrote:
> > Overload the LSB of struct page* to indicate that it's a page_pool_iov.
> >
> > Refactor mm calls on struct page* into helpers, and add page_pool_iov
> > handling on those helpers. Modify callers of these mm APIs with calls t=
o
> > these helpers instead.
> >
> > In areas where struct page* is dereferenced, add a check for special
> > handling of page_pool_iov.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >  include/net/page_pool/helpers.h | 74 ++++++++++++++++++++++++++++++++-
> >  net/core/page_pool.c            | 63 ++++++++++++++++++++--------
> >  2 files changed, 118 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/he=
lpers.h
> > index b93243c2a640..08f1a2cc70d2 100644
> > --- a/include/net/page_pool/helpers.h
> > +++ b/include/net/page_pool/helpers.h
> > @@ -151,6 +151,64 @@ static inline struct page_pool_iov *page_to_page_p=
ool_iov(struct page *page)
> >       return NULL;
> >  }
> >
> > +static inline int page_pool_page_ref_count(struct page *page)
> > +{
> > +     if (page_is_page_pool_iov(page))
> > +             return page_pool_iov_refcount(page_to_page_pool_iov(page)=
);
>
> We have added a lot of 'if' for the devmem case, it would be better to
> make it more generic so that we can have more unified metadata handling
> for normal page and devmem. If we add another memory type here, do we
> need another 'if' here?

Maybe, not sure. I'm guessing new memory types will either be pages or
iovs, so maybe no new if statements needed.

> That is part of the reason I suggested using a more unified metadata for
> all the types of memory chunks used by page_pool.

I think your suggestion was to use struct pages for devmem. That was
thoroughly considered and intensely argued about in the initial
conversations regarding devmem and the initial RFC, and from the
conclusions there it's extremely clear to me that devmem struct pages
are categorically a no-go.

--
Thanks,
Mina

