Return-Path: <linux-arch+bounces-2448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F371E85785E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 10:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C2B1C20D45
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CFA1BC36;
	Fri, 16 Feb 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RZg1KAp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90251B974
	for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074217; cv=none; b=Vm4CKTgVUx3kcx4WjVeJHiHkA8pDYOUMwt2uhtMbZCACH3mwH3xoLToNkAwjboxG/5fYuX7mW26FAbdI/aI2OMQhFpTBtcL/AnrV/mYROsXwy5ZvUiiE4Jief8vXbQZ2I/K/Hpi0JVvOZzcXBTPTpEZcHr+HUJSSrvRjzRnUEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074217; c=relaxed/simple;
	bh=dkw5/IVhfZj5zs7Oe1iWKLQE3h839PLLeYTuwMZDLgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7NQd3rcrbzDys+vYGwQ33zRhvENT8XZfIDWzahNYrn37zhlToqnOgKfO6gzIW6ymRlS5odIJ1h4/OvhU5gSW9xVnhN27B3yyIgMgqjAWarHLNlj++kmVVWep7NpKwKt/QqNNqj269rgHD6vJoRTyjI4sYWxnF8qMb0DS0kC7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RZg1KAp; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so2007277276.2
        for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2024 01:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708074215; x=1708679015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIsEikU4izdqkDoN+ZKv97zMNiSEQemJahB5wDm74LU=;
        b=2RZg1KApnj84nHSlLVc2ycT5QOJVaBNgiKZM04mw2rYJ+dHzqmQIvADP5iUlzJ9/yK
         efgpsIJ9a3h0Wf04i0V99FO+5BESARCJSjnrnF5mRyd3LAPn/N/EV63r7WHu8VAUopFy
         /xVET4gcr5k9GO4TXksAfX2s2OZjhvzYCtGsxRbCm9+knPX9AHOSlELdDysXodtDIe5Z
         3yxTO7ETynRqPcuSbbaZSQiXKGac7pDYmxSAX08LkQZwj06a+dMyX0LpgmM3WoZNjD+5
         LW1GNS5DRJuwXZob9VEhtSKjJy5wHha0aEx5j75PWx5m1ft19/Ke/LgFplw+qS4Wxy8F
         Vd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074215; x=1708679015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIsEikU4izdqkDoN+ZKv97zMNiSEQemJahB5wDm74LU=;
        b=GXjs3xvsWw4zrfmjsWSPJJdFsb5RpWeGJseKAtavFDgjSDTwyQxKw3SlsnGdUlDzxj
         09jFVQROOPB2LxNmFfSQpxQBgRvGzBU8TLxn8q5dcLhaWrEZh2VtDd/wJmIToX0hg5Pf
         BwGjNvFgls6KQlsjr5sr/brzIbC0zMMbnD9BKsPfi4Q4gc7AQc+B8rVlsKcts29W4Xpp
         DWaBzs5beGZE9YvTuTaBJOPQ7g8LGl0Y1hqg43a9+kcxPHR96f+xd8OrVjJGhgbAyHG1
         VyJjJDJyxhFCcm2jV44qeqoyblbzpHLatMsHjw+/7eDTZNSEIJ23p7rgm1scDlVyxwi6
         jI7g==
X-Forwarded-Encrypted: i=1; AJvYcCUVkXnPdIS9Ix2RU/EcDOulS//ERoqO3ode5dIu2H+CkITzz7EoQioEvEiUREcEGo7fofMdYK/7C6pXrTTcCEn4d2C4I0djPchvYw==
X-Gm-Message-State: AOJu0Yx6NmJ4cCNq3DAuSyv+9ts2PLrbsjjx7QuOgjJmCb2IqijpnVPb
	PQzXASnMRyRg+/ZHVUP6We7NVM2n1dYN+ngreuXrDmW4JZk7hUjenxJHAutbMPRT0VF+aajC1gv
	l1DAWkdRZUnJC/uFRJdTSSio1naaLMwQwp3N5
X-Google-Smtp-Source: AGHT+IE8IHpuOe2beld9vVWKFUEkUtO+/3eNyPe5KrBlxSBI4QdK9EveZ1I5XPH056j0G4IXvvphLveaFK0jjo4oCok=
X-Received: by 2002:a05:6902:200b:b0:dcb:be59:25e1 with SMTP id
 dh11-20020a056902200b00b00dcbbe5925e1mr5215694ybb.30.1708074214367; Fri, 16
 Feb 2024 01:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-14-surenb@google.com>
 <20240215165438.cd4f849b291c9689a19ba505@linux-foundation.org>
 <wdj72247rptlp4g7dzpvgrt3aupbvinskx3abxnhrxh32bmxvt@pm3d3k6rn7pm>
 <CA+CK2bBod-1FtrWQH89OUhf0QMvTar1btTsE0wfROwiCumA8tg@mail.gmail.com>
 <iqynyf7tiei5xgpxiifzsnj4z6gpazujrisdsrjagt2c6agdfd@th3rlagul4nn> <CAJuCfpHxaCQ_sy0u88EcdkgsV-GX3AbhCaiaRW-DWYFvZK1=Ew@mail.gmail.com>
In-Reply-To: <CAJuCfpHxaCQ_sy0u88EcdkgsV-GX3AbhCaiaRW-DWYFvZK1=Ew@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 01:03:22 -0800
Message-ID: <CAJuCfpGbZtUEb+Ay_abmOc=Tc4tuTtLVSK4ANpwvwG_VTAD9-Q@mail.gmail.com>
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 1:02=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Feb 15, 2024 at 5:27=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Feb 15, 2024 at 08:22:44PM -0500, Pasha Tatashin wrote:
> > > On Thu, Feb 15, 2024 at 8:00=E2=80=AFPM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Thu, Feb 15, 2024 at 04:54:38PM -0800, Andrew Morton wrote:
> > > > > On Mon, 12 Feb 2024 13:38:59 -0800 Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > > >
> > > > > > +Example output.
> > > > > > +
> > > > > > +::
> > > > > > +
> > > > > > +    > cat /proc/allocinfo
> > > > > > +
> > > > > > +      153MiB     mm/slub.c:1826 module:slub func:alloc_slab_pa=
ge
> > > > > > +     6.08MiB     mm/slab_common.c:950 module:slab_common func:=
_kmalloc_order
> > > > > > +     5.09MiB     mm/memcontrol.c:2814 module:memcontrol func:a=
lloc_slab_obj_exts
> > > > > > +     4.54MiB     mm/page_alloc.c:5777 module:page_alloc func:a=
lloc_pages_exact
> > > > > > +     1.32MiB     include/asm-generic/pgalloc.h:63 module:pgtab=
le func:__pte_alloc_one
> > > > >
> > > > > I don't really like the fancy MiB stuff.  Wouldn't it be better t=
o just
> > > > > present the amount of memory in plain old bytes, so people can us=
e sort
> > > > > -n on it?
> > > >
> > > > They can use sort -h on it; the string_get_size() patch was specifi=
cally
> > > > so that we could make the output compatible with sort -h
> > > >
> > > > > And it's easier to tell big-from-small at a glance because
> > > > > big has more digits.
> > > > >
> > > > > Also, the first thing any sort of downstream processing of this d=
ata is
> > > > > going to have to do is to convert the fancified output back into
> > > > > plain-old-bytes.  So why not just emit plain-old-bytes?
> > > > >
> > > > > If someone wants the fancy output (and nobody does) then that can=
 be
> > > > > done in userspace.
> > > >
> > > > I like simpler, more discoverable tools; e.g. we've got a bunch of
> > > > interesting stuff in scripts/ but it doesn't get used nearly as muc=
h -
> > > > not as accessible as cat'ing a file, definitely not going to be
> > > > installed by default.
> > >
> > > I also prefer plain bytes instead of MiB. A driver developer that
> > > wants to verify up-to the byte allocations for a new data structure
> > > that they added is going to be disappointed by the rounded MiB
> > > numbers.
> >
> > That's a fair point.
> >
> > > The data contained in this file is not consumable without at least
> > > "sort -h -r", so why not just output bytes instead?
> > >
> > > There is /proc/slabinfo  and there is a slabtop tool.
> > > For raw /proc/allocinfo we can create an alloctop tool that would
> > > parse, sort and show data in human readable format based on various
> > > criteria.
> > >
> > > We should also add at the top of this file "allocinfo - version: 1.0"=
,
> > > to allow future extensions (i.e. column for proc name).
> >
> > How would we feel about exposing two different versions in /proc? It
> > should be a pretty minimal addition to .text.
> >
> > Personally, I hate trying to count long strings digits by eyeball...
>
> Maybe something like this work for everyone then?:

s/work/would work

making too many mistakes. time for bed...

>
> 160432128 (153MiB)     mm/slub.c:1826 module:slub func:alloc_slab_page

