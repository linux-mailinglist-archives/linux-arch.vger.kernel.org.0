Return-Path: <linux-arch+bounces-2975-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A587AA6F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 16:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D1B284CC8
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8277047F73;
	Wed, 13 Mar 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHy1XTA7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07647F51
	for <linux-arch@vger.kernel.org>; Wed, 13 Mar 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343894; cv=none; b=KPqYbKxi8CImYSniNFvr4sXPBntdHvK6N2oMPS/LQqBwSdaWQcpTyBIGPZxa1C4Iu/2o69NEp/g13nljxWAlIHX2sfFhy0xm3MrKkOroX0ZYnrqMYUuljdSMrjkUWn2KuwoYntpcF2CaWMY8ceRIZCKAlR5T1dAb8TslY4PFJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343894; c=relaxed/simple;
	bh=Zq4RfZOjcqNtcLFUzAg0QuQxZvQrvC1IKPOXZvtCEr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEysbvoebXx6ousjOiN4WmVYY/VZ2idUA7CS9sSOHyw0Lwr4Vib8wrHhhp0mh5dYZqs4sCt/0fbyE0MLb6vBQ09uTOKQu+3ZvzknOaKDrLXJUn+iB3zjLBakGJ3bN5tff3maz0Lt/iFOKJqz3eMcGzyU6OpV+Nm66GtFn9FSCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHy1XTA7; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc236729a2bso1107374276.0
        for <linux-arch@vger.kernel.org>; Wed, 13 Mar 2024 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710343891; x=1710948691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtMw74U66kmsHyXAV7bBZ7SbbkNSfFBApfqkzQBmCrI=;
        b=nHy1XTA7EB89TkqAKPt3CSMUwffHkk/CAuX5IYEt3/EzeN/XRhGq2DKnf7K6hxBuX2
         lizjW6ABzbMxvs9EVRQPfIEdfnzXbICsxanCJ313DaPFFsn3XgjJXutzC0m8X+uGp4Z5
         Om3PINc9nBM2T9TOBrh3Fdfv+4E3X3TozhN1tc8/oU8w+/Zy+NQckLE5J7e2sPXxNlyr
         Yg6YbyXesZbqI/nCi6EKIOgO914R0yfPTAzB91Id3Q95jZ4U6SQbdb1pjfCT0GK05Dcl
         tPLny3Iv8ZJxV34iyTvblGo8lJ5DISojziQxMAi9f+np2LqJCj/YFpKveTEQzzcE0BjG
         1ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710343891; x=1710948691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtMw74U66kmsHyXAV7bBZ7SbbkNSfFBApfqkzQBmCrI=;
        b=uFug4yBba9oeo/GFkWXeHXl/ii26h0QBOZqMULpT25UX2rCunkHCmpEDzJldEb5H/d
         3B/6OUuDTUuDabqAww6Vu27bNsdZKDylH0meFasU8QwHYDke3CnEwmeVYKFAHVRlNU3p
         ZUTA2MN0Yi5KxvSzNwtuFtvb0qBqdqM6OnRPNoN7m3vnpKq8GRKDDeyCBmd5N9+JW+ca
         WRwWaYCtoHRQFuMy9ab+XBN7N/k4z2tIztAy1YLj6DByPvFxlgwxSPOu0v9tCNqubWAW
         TFq8kCGSQojSNB+qr7r4c7zRSxUBjEcf0siRHQV9UWRtJQ5sPZnhCO+KudtfpPbNRS7s
         F68A==
X-Forwarded-Encrypted: i=1; AJvYcCVxSEs6jXNgsZ9K/LrV87TLOJ1MfpbD1hsf2GC/sEkR0PMc1X4s9wf7ldQ40nCdNBlUH+607H99JuwO4ixTo2B9ZYxtOSAo6pFb2g==
X-Gm-Message-State: AOJu0YwG8b1b+M0TBWFWN3WfK715QaOfxVFJwZGdt9iqKj0VeWRmHNaT
	96ozi/mVvkO0CLH63UohbZfiZ6ijfcckPOrNpT3rv2HXCXsWRB/ZTt2lsxQCyTUxFUDwt5pwIPj
	tZ5FU1yf8jP7blWQRnu5C8aMaDprrDVrPxaUD
X-Google-Smtp-Source: AGHT+IFt/OYhWjwqlxyr/Zyxfa6nHqBBNGn1lVwocwLdvQz8oj2Fnp7dsALCjpYCUrb0E7Elvx8ovXgew43c6K/l7cs=
X-Received: by 2002:a5b:706:0:b0:dcb:abbc:f597 with SMTP id
 g6-20020a5b0706000000b00dcbabbcf597mr2798485ybq.54.1710343891190; Wed, 13 Mar
 2024 08:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-21-surenb@google.com>
 <ZfHAcVwJ6w9b1x0Z@casper.infradead.org>
In-Reply-To: <ZfHAcVwJ6w9b1x0Z@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Mar 2024 15:31:18 +0000
Message-ID: <CAJuCfpFf2xrCA_Rq_-e5HsDMqeS87p0b28PkK+wgWco17mxyDQ@mail.gmail.com>
Subject: Re: [PATCH v5 20/37] mm: fix non-compound multi-order memory
 accounting in __free_pages
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 3:04=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 06, 2024 at 10:24:18AM -0800, Suren Baghdasaryan wrote:
> > When a non-compound multi-order page is freed, it is possible that a
> > speculative reference keeps the page pinned. In this case we free all
> > pages except for the first page, which will be freed later by the last
> > put_page(). However put_page() ignores the order of the page being free=
d,
> > treating it as a 0-order page. This creates a memory accounting imbalan=
ce
> > because the pages freed in __free_pages() do not have their own alloc_t=
ag
> > and their memory was accounted to the first page. To fix this the first
> > page should adjust its allocation size counter when "tail" pages are fr=
eed.
>
> It's not "ignored".  It's not available!
>
> Better wording:
>
> However the page passed to put_page() is indisinguishable from an
> order-0 page, so it cannot do the accounting, just as it cannot free
> the subsequent pages.  Do the accounting here, where we free the pages.
>
> (I'm sure further improvements are possible)
>
> > +static inline void pgalloc_tag_sub_bytes(struct alloc_tag *tag, unsign=
ed int order)
> > +{
> > +     if (mem_alloc_profiling_enabled() && tag)
> > +             this_cpu_sub(tag->counters->bytes, PAGE_SIZE << order);
> > +}
>
> This is a terribly named function.  And it's not even good for what we
> want to use it for.
>
> static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned =
int nr)
> {
>         if (mem_alloc_profiling_enabled() && tag)
>                 this_cpu_sub(tag->counters->bytes, PAGE_SIZE * nr);
> }
>
> > +++ b/mm/page_alloc.c
> > @@ -4697,12 +4697,21 @@ void __free_pages(struct page *page, unsigned i=
nt order)
> >  {
> >       /* get PageHead before we drop reference */
> >       int head =3D PageHead(page);
> > +     struct alloc_tag *tag =3D pgalloc_tag_get(page);
> >
> >       if (put_page_testzero(page))
> >               free_the_page(page, order);
> >       else if (!head)
> > -             while (order-- > 0)
> > +             while (order-- > 0) {
> >                       free_the_page(page + (1 << order), order);
> > +                     /*
> > +                      * non-compound multi-order page accounts all all=
ocations
> > +                      * to the first page (just like compound one), th=
erefore
> > +                      * we need to adjust the allocation size of the f=
irst
> > +                      * page as its order is ignored when put_page() f=
rees it.
> > +                      */
> > +                     pgalloc_tag_sub_bytes(tag, order);
>
> -       else if (!head
> +       else if (!head) {
> +               pgalloc_tag_sub_pages(1 << order - 1);
>                 while (order-- > 0)
>                         free_the_page(page + (1 << order), order);
> +       }
>
> It doesn't need a comment, it's obvious what you're doing.

All suggestions seem fine to me. I'll adjust the next version accordingly.
Thanks for reviewing and the feedback!

>

