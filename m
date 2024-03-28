Return-Path: <linux-arch+bounces-3170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3488AE37
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A121F6467F
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD0384FCF;
	Mon, 25 Mar 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gl4CyQ+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED484D23
	for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389560; cv=none; b=oHiM8NP5Bc+Haous1HJYOJO8NGp4sF+gKPZCEi+GUfCi6NmJCf2wbQKJwIck+ElVLrhQsciefsbBUSAYmmgo8VldHQUYGoWs8nPwKZ14hnjOnKv8xITiQERHqOFRyVaNDaaUpVQ19WpvnvYYnNNnebPXo3Wqf/OAJDVx2A3VmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389560; c=relaxed/simple;
	bh=YUkn5bDTJvtPOe4CbVEJJ+OysGCk8+HwOuI6bpiCxQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eam8W//SusJEduZlkJT3Fr+mAjBiuzmCucZQe8Pb/8Ahc5z+llwYwX4i9ygK9XQ+/T1O51yh7GxESHopo6wwuh3D828bSnOrO1cFL803vk41rTN5DL5Kz4xXcDd7MRNdJdTqJCNLu2NFcEI38rD7UV4Mq+IRItNe/E9tKvq/2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gl4CyQ+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc745927098so4259968276.3
        for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2024 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711389553; x=1711994353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1H2/sqpi/sh2ma0fgAVRjfY65QgsbrlBKsllNKG2ck=;
        b=2gl4CyQ+Xvl6vMB2PNXMos2xXZYhPDH+8W1bFAYmkCRuJKlGz64+FLJnLY+nO7mmhv
         4yXbp0XCZUoBDUViWSScVzKZwVJSPlUGmrz1GIYu6yiZOUXxz8R3vcj6t/hEXqf+Rzk5
         ZwPOYWKGouwogs2vAb0YAbFQcXsI5JzizAjND9Xz5pYvi8KOYXq8jOjuVnXKrnBDEgmo
         /me7luk2ASZqf/JphUm/ZFaLeWQXmQUy1LpfzrrNvofTtwWDW8XZW5acdeIEcUNJj+F/
         urtUStjDpqISLSdRprneRNZz0QACMZzMiXWm2WhDTqNECfwxky/+a/gpNSLrZZZM+OjN
         ArTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389553; x=1711994353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1H2/sqpi/sh2ma0fgAVRjfY65QgsbrlBKsllNKG2ck=;
        b=YGB7WWPMLui4JkAFobs/ryctSUiyXieaCqCWIaWTxMmKbLvkG/FkwWBwH4YrGutqnv
         TYvbWohfq2KaHVx6ioB/D3QzFW/AShlqg5032dc9BO14kl3ZTnnZkNQ92i0Y4g4rBA4V
         X1rKoV3e4uTneZgHj441vpQoHG5D/vcLL3fVGO7Zg2Kq6f60uUSF4/o0XdxA37qfLHnk
         7kRwTI2ceshi+MUeOfMnUNR3vjKiVbrWU0cz6DwcZVkO361QaluJyiuDKLDCxaBFfD4Z
         uanb/AqEFEXkzKJGPGJ1Ls4sbgFXCtqLxOanuSg4f8ZsDnIFZrSXAs6cq7+bFoRjn73R
         RNWg==
X-Forwarded-Encrypted: i=1; AJvYcCUD0Rh0rHyccqSd6Nyh48yntraBemjbeV1FKmPf2mpwiFKME7iTDWM/9yx5YD5dAk3AOYo6oDXxGS2AQ2m7h2F59gGakYx53GfPlQ==
X-Gm-Message-State: AOJu0YzQlWaa0+HsEFNluCrVpTV9Ze0mtOCFjzvNKsBM67bE5fHsLPmM
	70lHPLH1KDGPm6Dl51cPfC24MD2unvEMn9+mSgEqNY6WA3LctHelQiUDHCg6lj5DVDamm6789Fx
	utyrjFGLdzxZu+dJ7FxldO3ZlWzch5EEvVVG+
X-Google-Smtp-Source: AGHT+IEgRKkwT38dzLm3NHYgLzcPYKNKFESgwIB1AubKuEz+z0q+SxXd0EUwkL4MQOex5Dj9zrOPFPjYxYadJTqh2sQ=
X-Received: by 2002:a25:acd6:0:b0:dc7:4067:9f85 with SMTP id
 x22-20020a25acd6000000b00dc740679f85mr6265207ybd.58.1711389552854; Mon, 25
 Mar 2024 10:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFnGmt8Q7ZT2Z+gvz=DkRzionXFZ0i5Y1B=UKF6LLqxXA@mail.gmail.com>
 <20240325174934.229745-1-sj@kernel.org>
In-Reply-To: <20240325174934.229745-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 25 Mar 2024 10:59:01 -0700
Message-ID: <CAJuCfpGiuCnMFtViD0xsoaLVO_gJddBQ1NpL6TpnsfN8z5P6fA@mail.gmail.com>
Subject: Re: [PATCH v6 30/37] mm: vmalloc: Enable memory allocation profiling
To: SeongJae Park <sj@kernel.org>
Cc: mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, 
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
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:49=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Mon, 25 Mar 2024 14:56:01 +0000 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > On Sat, Mar 23, 2024 at 6:05=E2=80=AFPM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > Hi Suren and Kent,
> > >
> > > On Thu, 21 Mar 2024 09:36:52 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > >
> > > > This wrapps all external vmalloc allocation functions with the
> > > > alloc_hooks() wrapper, and switches internal allocations to _noprof
> > > > variants where appropriate, for the new memory allocation profiling
> > > > feature.
> > >
> > > I just noticed latest mm-unstable fails running kunit on my machine a=
s below.
> > > 'git-bisect' says this is the first commit of the failure.
> > >
> > >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > >     [10:59:53] Configuring KUnit Kernel ...
> > >     [10:59:53] Building KUnit Kernel ...
> > >     Populating config with:
> > >     $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
> > >     Building with:
> > >     $ make ARCH=3Dum O=3D../kunit.out/ --jobs=3D36
> > >     ERROR:root:/usr/bin/ld: arch/um/os-Linux/main.o: in function `__w=
rap_malloc':
> > >     main.c:(.text+0x10b): undefined reference to `vmalloc'
> > >     collect2: error: ld returned 1 exit status
> > >
> > > Haven't looked into the code yet, but reporting first.  May I ask you=
r idea?
> >
> > Hi SeongJae,
> > Looks like we missed adding "#include <linux/vmalloc.h>" inside
> > arch/um/os-Linux/main.c in this patch:
> > https://lore.kernel.org/all/20240321163705.3067592-2-surenb@google.com/=
.
> > I'll be posing fixes for all 0-day issues found over the weekend and
> > will include a fix for this. In the meantime, to work around it you
> > can add that include yourself. Please let me know if the issue still
> > persists after doing that.
>
> Thank you, Suren.  The change made the error message disappears.  However=
, it
> introduced another one.

Ok, let me investigate and I'll try to get a fix for it today evening.
Thanks,
Suren.

>
>     $ git diff
>     diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
>     index c8a42ecbd7a2..8fe274e9f3a4 100644
>     --- a/arch/um/os-Linux/main.c
>     +++ b/arch/um/os-Linux/main.c
>     @@ -16,6 +16,7 @@
>      #include <kern_util.h>
>      #include <os.h>
>      #include <um_malloc.h>
>     +#include <linux/vmalloc.h>
>
>      #define PGD_BOUND (4 * 1024 * 1024)
>      #define STACKSIZE (8 * 1024 * 1024)
>     $
>     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
>     [10:43:13] Configuring KUnit Kernel ...
>     [10:43:13] Building KUnit Kernel ...
>     Populating config with:
>     $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
>     Building with:
>     $ make ARCH=3Dum O=3D../kunit.out/ --jobs=3D36
>     ERROR:root:In file included from .../arch/um/kernel/asm-offsets.c:1:
>     .../arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previ=
ous prototype for =E2=80=98foo=E2=80=99 [-Wmissing-prototypes]
>         9 | void foo(void)
>           |      ^~~
>     In file included from .../include/linux/alloc_tag.h:8,
>                      from .../include/linux/vmalloc.h:5,
>                      from .../arch/um/os-Linux/main.c:19:
>     .../include/linux/bug.h:5:10: fatal error: asm/bug.h: No such file or=
 directory
>         5 | #include <asm/bug.h>
>           |          ^~~~~~~~~~~
>     compilation terminated.
>
>
> Thanks,
> SJ
>
> [...]

