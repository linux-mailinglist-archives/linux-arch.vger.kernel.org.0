Return-Path: <linux-arch+bounces-6994-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433996AE53
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 04:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E377286B5C
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 02:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6DA1A276;
	Wed,  4 Sep 2024 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IP92prut"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DDB15E90
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415506; cv=none; b=uZfXggLhuiht6R8pC6FxqMT7gmUB6BWsy4fiwTr7mFEJqZYxHaMGq5diMrsN93XlPJbzzUcs6t8DjW4SUHHl1Fm/s80Y12O72VSPr8JXmbf2YpaCnjmOkAXPEzIwjtg9teqaOQMGBx073YxT8v1iZaOfgcByDg4+lydvLfRL8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415506; c=relaxed/simple;
	bh=EsRba+pJ4JyRcYEK2iepj8Pqx8bMOP75UMtToD6S0wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mL6bmbtn4Sj20D2vGZyablYH2I8Ny/+W4Y+JpYwCOnbGvxQnuvThFc2jwiyscWwtP/xyhh0ZnJy823lgSDBR4OQX1SBtQSH+Y0rKCGl7etY2RidnsZXiyrgTQ1fCNKqCcQ+e2aAOF7s8/nLAwWuCMxD4Ivw7FYyq1KjvULONT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IP92prut; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4567fe32141so88211cf.0
        for <linux-arch@vger.kernel.org>; Tue, 03 Sep 2024 19:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725415504; x=1726020304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCyPy6iwCP5CjIg/B3ozt0KbGUw/B0FCHsUaXuPiqn0=;
        b=IP92prutU5OojUTdyFmghdiquEcM4QvoSX+45pDOpW/p4RSdm9lsY5S09SeTfYbfhq
         6xwD0d0PNl4XJJ20jjQbVLp4Os/Sn1tPdhu2nmZLz+jPIQhQeUd6DE1gsThEN/Oqf0wE
         eE3mrSuJzQ4kwhourQLInjJ7uSAnCRTkPSHymXS9cA/iDLUfMT3SeOjhfGMyj/S1mcXF
         aBhqR0eh65l6xDLTWkfA83fwKdH5kAnrAJ45wff2gti7ecgDMXNTOABBC0L7mQH9NEMR
         uhlUKnHoeZUAQcS9z+miSBFlLacpfNb1cqy14mXtqX+far5RtXULnrzdnmvWiCCqy7ah
         AtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725415504; x=1726020304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCyPy6iwCP5CjIg/B3ozt0KbGUw/B0FCHsUaXuPiqn0=;
        b=kc/LATp1i1M/2tLc2gEtosQUPHtKxe4ijZQ3pCbDGFO/iHhlcAp4nA2Bc+/D2bEiUY
         LCMBafqasBMuX3Xpprs/nRv4rUi7uWrxmPO1P9Ic9jx5FDC+AVM2rQ4EOgdLVjxS2hxO
         eEp7ZmtVAZIbTL+hW3lpvqhNf3GW381hHvXc8BZqfts/xVspebPIT09/BDnQjt9hFFtj
         kMIZF0QBM+qSIpKcAgCkUaYouiGt5Zv2fU8xyc/w/hcm4RUQ96KdFidjtab3rMqG/mCc
         vSatGcwfbcjwP23B5V9lnjfuSqvKphthcecyLZVj6zkSHIBmagiwn21siM3pmaLnavAd
         hdzw==
X-Forwarded-Encrypted: i=1; AJvYcCWERuKG6i0H/6RURBE6c8q8HOQKdoy40V5WxmIOBJqBAJ3DjNXYIODwa3ypYPP22WUQVfWok+U2QSw2@vger.kernel.org
X-Gm-Message-State: AOJu0YwjySWrMnbAI2QRF24WEzwbhklf0ZoV6B6p+oR4EKviLZDCTyCz
	4Q2CnVljOFhIfeODyutmspHr6wq/hbU+L9smj/krEtHIPFac69ddsIUtlia+5oRFyLY322HTQ+p
	gUyO9pk9pUs/OkTRr2/I8qcVsxJdgPMkfKtq+
X-Google-Smtp-Source: AGHT+IEbZycTL1qRNduokmk2dFqgQ/aI0bamoSE/FU7WW+tZXb6qMK7tmdkD+eHzjSLi5+cwNQdZLetM5UhjTGy3xjQ=
X-Received: by 2002:ac8:5953:0:b0:447:f958:ab83 with SMTP id
 d75a77b69052e-457f7b3648bmr1045391cf.21.1725415503320; Tue, 03 Sep 2024
 19:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com> <20240902044128.664075-6-surenb@google.com>
 <20240901220931.53d3ad335ae9ac3fe7ef3928@linux-foundation.org>
 <CAJuCfpHL04DyQn5WLz0GZ_zMYyg1b6UwKd_+8DSko843uSk7Ww@mail.gmail.com> <3kfgku2oxdcnqgtsevsc6digb2zyapbvchbcarrjipyxgytv2n@7tolozzacukf>
In-Reply-To: <3kfgku2oxdcnqgtsevsc6digb2zyapbvchbcarrjipyxgytv2n@7tolozzacukf>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 3 Sep 2024 19:04:51 -0700
Message-ID: <CAJuCfpGbHShimigbm7ckT76hK9YUc_gy0jb9e5ddq7yjqDKOig@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] alloc_tag: make page allocation tag reference size configurable
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 6:17=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Sep 03, 2024 at 06:07:28PM GMT, Suren Baghdasaryan wrote:
> > On Sun, Sep 1, 2024 at 10:09=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Sun,  1 Sep 2024 21:41:27 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > Introduce CONFIG_PGALLOC_TAG_REF_BITS to control the size of the
> > > > page allocation tag references. When the size is configured to be
> > > > less than a direct pointer, the tags are searched using an index
> > > > stored as the tag reference.
> > > >
> > > > ...
> > > >
> > > > +config PGALLOC_TAG_REF_BITS
> > > > +     int "Number of bits for page allocation tag reference (10-64)=
"
> > > > +     range 10 64
> > > > +     default "64"
> > > > +     depends on MEM_ALLOC_PROFILING
> > > > +     help
> > > > +       Number of bits used to encode a page allocation tag referen=
ce.
> > > > +
> > > > +       Smaller number results in less memory overhead but limits t=
he number of
> > > > +       allocations which can be tagged (including allocations from=
 modules).
> > > > +
> > >
> > > In other words, "we have no idea what's best for you, you're on your
> > > own".
> > >
> > > I pity our poor users.
> > >
> > > Can we at least tell them what they should look at to determine wheth=
er
> > > whatever random number they chose was helpful or harmful?
> >
> > At the end of my reply in
> > https://lore.kernel.org/all/CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8B=
D4HDqxXA@mail.gmail.com/#t
> > I suggested using all unused page flags. That would simplify things
> > for the user at the expense of potentially using more memory than we
> > need.
>
> Why would that use more memory, and how much?

Say our kernel uses 5000 page allocations and there are additional 100
allocations from all the modules we are loading at runtime. They all
can be addressed using 13 bits (8192 addressable tags), so the
contiguous memory we will be preallocating to store these tags is 8192
* sizeof(alloc_tag). sizeof(alloc_tag) is 40 bytes as of today but
might increase in the future if we add more fields there for other
uses (like gfp_flags for example). So, currently this would use 320KB.
If we always use 16 bits we would be preallocating 2.5MB. So, that
would be 2.2MB of wasted memory. Using more than 16 bits (65536
addressable tags) will be impractical anytime soon (current number
IIRC is a bit over 4000).


>
> > In practice 13 bits should be more than enough to cover all
> > kernel page allocations with enough headroom for page allocations
> > coming from loadable modules. I guess using 13 as the default would
> > cover most cases. In the unlikely case a specific system needs more
> > tags, the user can increase this value. It can also be set to 64 to
> > force direct references instead of indexing for better performance.
> > Would that approach be acceptable?
>
> Any knob that has to be kept track of and adjusted is a real hassle -
> e.g. lockdep has a bunch of knobs that have to be periodically tweaked,
> that's used by _developers_, and they're often wrong.

Yes, I understand, but this config would allow us not to waste these
couple of MBs, provide a way for the user to request direct addressing
of the tags and it also helps us to deal with the case I described in
the last paragraph of my posting at
https://lore.kernel.org/all/CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HD=
qxXA@mail.gmail.com/#t

