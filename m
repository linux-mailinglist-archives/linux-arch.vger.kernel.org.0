Return-Path: <linux-arch+bounces-428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64D7F6296
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 16:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418D31C20B01
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968035EF4;
	Thu, 23 Nov 2023 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCM5CXlq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38292C1;
	Thu, 23 Nov 2023 07:21:46 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso624121a12.2;
        Thu, 23 Nov 2023 07:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700752905; x=1701357705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q70ME+Z8MA/iN3ndOUEyZrB6FW+VdFvlQgHMP5KT7Xo=;
        b=iCM5CXlqAt6LnkAOYOhnscwAXsBbXV7C+ZTWy1y0+lqJME3AzFM04ost8zlgR61r5M
         PrzdagkS4HXJTl50UaFQ+Q3IECUJ03ejFDjcec79B2BFVixqsLXRI6vSuDbZErn00DrE
         t+TnrXSpuLl5jkYrkuPBU8gW/eNMhuwRD6kdGmzyqP4Oe7vel1JLRXqyfjQGaibDZUfg
         u6Qdk0e8HKQdZPf4C8WzmJAPLGfXcGTVU8Gnd1tE4n7Zhrc2C8kRMpFR6OQQclsd+lS+
         O7K/3bF/txOsjVMueW2xDUVSFzOtbIxLr4zBdxlr/pUoONyLFHM770WznoBSHrgjsXkf
         XY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752905; x=1701357705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q70ME+Z8MA/iN3ndOUEyZrB6FW+VdFvlQgHMP5KT7Xo=;
        b=K7H/4wA3vRaN/7cbMAiBt8w5gsNJy0M4BfaQKNgWmsgPVNzPI94nd9h8sXMWf8GfSs
         CZ5DVguqnURC7cunaTuGB0O4kqXQXcZoj4ieqBZE5sDfU765YAlpN0cY+kr6dq9bBHpx
         5thmd/2OKtYPrG7zU2WPc0EtFRXAWMB1w7jI2fWVJ5OtyB1SAgc088tzcqHKekD4KUM6
         vtSijG8ReRgvH3b9kt4bJ22P1mAY7csfPyYNI8Z11mDKoHtQCkDsZMZufiMN52+1Hdrm
         LKhVA0TgV8ofja+lNMTeazD6VSfZIOwyfyAGRUGvX+oiq54Q4E4ZsUYPjjELcyP+SOFJ
         lK4w==
X-Gm-Message-State: AOJu0YyYJjE+8LRzi9o2tLqqrlbARxvN2IhkEUEIUkeJG8Imduudu//f
	j7JfZG0GGl8AWJHLPHw1gCvnHo1G/CQRnuEEy0U=
X-Google-Smtp-Source: AGHT+IG7HjrLo+UO2gU6kyO67Qrxj1Fj9BW3CiY12ZHHr9qO2aQ6gsiGv7l3PWYv+dLAVKqIAWPZHZTysn9dpGno6g4=
X-Received: by 2002:a17:90a:1948:b0:280:cd5f:bf90 with SMTP id
 8-20020a17090a194800b00280cd5fbf90mr5907737pjh.23.1700752905538; Thu, 23 Nov
 2023 07:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com> <ZV6Uhsg6WLBtNqU3@memverge.com>
In-Reply-To: <ZV6Uhsg6WLBtNqU3@memverge.com>
From: Vinicius Petrucci <vpetrucci@gmail.com>
Date: Thu, 23 Nov 2023 09:21:08 -0600
Message-ID: <CAEZ6=UNLuOYom1Qng28F2y6XocJM4cnbDG1yq3m1p8btuQ4tRQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
To: Gregory Price <gregory.price@memverge.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-api@vger.kernel.org, minchan@kernel.org, dave.hansen@linux.intel.com, 
	x86@kernel.org, Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com, 
	ying.huang@intel.com, dan.j.williams@intel.com, hezhongkun.hzk@bytedance.com, 
	fvdl@google.com, surenb@google.com, rientjes@google.com, hannes@cmpxchg.org, 
	mhocko@suse.com, Hasan.Maruf@amd.com, jgroves@micron.com, 
	ravis.opensrc@micron.com, sthanneeru@micron.com, emirakhur@micron.com, 
	vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg!

Thanks a lot for quickly looking into this and sharing your notes here.

On Wed, Nov 22, 2023 at 5:53=E2=80=AFPM Gregory Price
<gregory.price@memverge.com> wrote:
>
> > Please note the initial `maxnode` parameter from `mbind` was omitted
> > to ensure the API doesn't exceed 6 arguments. Instead, the constant
> > MAX_NUMNODES was utilized.
> >
>
> I don't think this will work, users have traditionally been allowed to
> shorten their nodemasks, and also for some level of portability.
>
> We may want to consider an arg structure, rather than just chopping an
> argument off.
>

Yes, good point... that should be considered as a more complete
long-term approach beyond the MVP.

> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 10a590ee1c89..91ee300fa728 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1215,11 +1215,10 @@ static struct folio *alloc_migration_target_by_=
mpol(struct folio *src,
> >  }
> >  #endif
> >
> > -static long do_mbind(unsigned long start, unsigned long len,
> > +static long do_mbind(struct mm_struct *mm, unsigned long start, unsign=
ed long len,
> >                    unsigned short mode, unsigned short mode_flags,
> >                    nodemask_t *nmask, unsigned long flags)
> >  {
> > -     struct mm_struct *mm =3D current->mm;
> >       struct vm_area_struct *vma, *prev;
> >       struct vma_iterator vmi;
> >       struct migration_mpol mmpol;
> > @@ -1465,10 +1464,84 @@ static inline int sanitize_mpol_flags(int *mode=
, unsigned short *flags)
> >       return 0;
> >  }
>
> This is a completely insufficient change to do_mbind.  do_mbind utilizes
> `current` in a variety of places for nodemask (cpuset) validation and to
> acquire the task's lock.  This will not work the way you intend it to,
> you end up mixing up node masks between current and target task.
>

Oh oh. True! Good catch!

> see here:
> https://lore.kernel.org/all/20231122211200.31620-7-gregory.price@memverge=
.com/
>

Let me go over this... Thanks!

> We may want to combine this change and with my change so that your iovec
> changes can be re-used, because that is a very nice feature.
>

Sounds good. Thanks again!

Best,

Vinicius

