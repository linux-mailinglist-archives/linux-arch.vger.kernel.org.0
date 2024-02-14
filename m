Return-Path: <linux-arch+bounces-2362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6158552F2
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 20:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8272B24F2A
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C9B13A875;
	Wed, 14 Feb 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hk1jdUmD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9A13A27C
	for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937785; cv=none; b=MW9HAM+WZ2uiYXt8FmKhCmB7KxugKHPgUCy6DrQuoA+DpPv+Lb0mx9d198gRODVzDqbTG4uINoPPWzQK80lcE+/aYyC7kkN0Yv1d6QuHXoeRyIBkzzG7RlnBPITxmgF7EMpGHFgYY7Rc5Is4aGjB9LPVCurB9jLQJiVj89hjdno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937785; c=relaxed/simple;
	bh=7dJubmbUsQFXN8Bmn/iqqhqzUqvL9YDW9A4PwCTZpGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHlpsWa8n3emEDidpiSvYPkvLfQnHlHbV0Rm/fQG0yWPEaDycD2YujRxsHguQVdab7hhV1bXbcXoI+5DP8QaeUl3PTtS55KLh+ln00VfZzfqFUmtXog7iZmzJ43U5XWsPEu4E8u87fb/kwAOixv44yIIy3+o1+L7yhl8kmxU8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hk1jdUmD; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso925919276.2
        for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 11:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707937782; x=1708542582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYQ1iEqH1bC/aeDNG7RWtd5Zq4jRnkeS9Y1nPQkLhuU=;
        b=hk1jdUmDKoWNYCVQNvuhe/KXccAzQclL6keyuwBfLLOD0iIZidK/XoMxQR4iofKF4M
         LjE5RxqHumu9djxGPw17mEpxHFTr7hwvgOoqbtvn8kqsayViEua17ouNnxzcvaHG70hI
         wyVHQyX5+EVFHepnaDFuwmlAMWXVUb0IliyeV9uWw7JuN7rVzti54/1UmAbx3VOCEVtL
         RHeeUrBIwGZ9bdTGTexEcIhKe1Bg41NU8WWMsj9VHL4fiJjQi3pE/NyVPQe+T7MTxVSA
         IKRi/StsaDC6aaNYt4BSZSRkW6iYxJvZ3zAxVnKbnyWPTpSVlQ6giq+f1FKDKmVQV8c+
         IwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937782; x=1708542582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYQ1iEqH1bC/aeDNG7RWtd5Zq4jRnkeS9Y1nPQkLhuU=;
        b=eicfovZfQ7jm4+WkqS68QfRY13v0n6BSjoqWPIzxqyG/i2GZsRmlVKfq239wJZBFA1
         /MC92bHT0STqR1SfHfnp1I23enRe0T8MrGTqDdWgeW+Ms1ArIFF+EcNr68qqQ9f4+WaW
         +f+eRQrfRNWonbIWf6qkxxEfJVUJOGOHk8MLFYTUQwXhd4p9M74Y25eehRdRYtuGpxeA
         6JHzhY/sTg4fp2gdqqQZBuzK1LYAnkR0vhGHU828rnMxcUBWZktZ5iQQO8j78OwMItwy
         mRNnyxtm6KYwPF/Y3H/7bYjI4qEaLseuYMr9NOcW7OW34EKYmG0eXA1/avIvDaDE+FyB
         pOhg==
X-Forwarded-Encrypted: i=1; AJvYcCWYH2v3cbtJDFlUdv6Ymqcs4+bxCOKUcppdloDVONdFA9vkBLsgBvuw9n4QZrM+a1PPXKpUR61zzye5Etw1iITXaZRUDJGXM+F66Q==
X-Gm-Message-State: AOJu0Yy+jmJ6Go6daLzcLJkhvhsSoJkkCVQkgouoRZ5w+ZteHbWkDSyq
	jOoLvzGeIHxgze7zNeSz8kVZ1dc7hV+nA7UZX/rByz7hT5WyBCgok+sgLY3TBK67BI4bgvioFUZ
	6bY145GAYRi8o3dnSPTVxQGQIjyVupi0mRkDm
X-Google-Smtp-Source: AGHT+IE0myNa43nYnaJsvlAr1q2GXvgjSojXmvsXBpkzj6lBL3cERK/G4k9guWv0KYdWk2/nQyibRz7ihpshNEhuuEk=
X-Received: by 2002:a25:2d01:0:b0:dcc:8114:5a54 with SMTP id
 t1-20020a252d01000000b00dcc81145a54mr3243973ybt.43.1707937782071; Wed, 14 Feb
 2024 11:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <4f24986587b53be3f9ece187a3105774eb27c12f.camel@linux.intel.com>
In-Reply-To: <4f24986587b53be3f9ece187a3105774eb27c12f.camel@linux.intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 11:09:30 -0800
Message-ID: <CAJuCfpGnnsMFu-2i6-d=n1N89Z3cByN4N1txpTv+vcWSBrC2eg@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:54=E2=80=AFAM Tim Chen <tim.c.chen@linux.intel.c=
om> wrote:
>
> On Mon, 2024-02-12 at 13:38 -0800, Suren Baghdasaryan wrote:
> > Memory allocation, v3 and final:
> >
> > Overview:
> > Low overhead [1] per-callsite memory allocation profiling. Not just for=
 debug
> > kernels, overhead low enough to be deployed in production.
> >
> > We're aiming to get this in the next merge window, for 6.9. The feedbac=
k
> > we've gotten has been that even out of tree this patchset has already
> > been useful, and there's a significant amount of other work gated on th=
e
> > code tagging functionality included in this patchset [2].
> >
> > Example output:
> >   root@moria-kvm:~# sort -h /proc/allocinfo|tail
> >    3.11MiB     2850 fs/ext4/super.c:1408 module:ext4 func:ext4_alloc_in=
ode
> >    3.52MiB      225 kernel/fork.c:356 module:fork func:alloc_thread_sta=
ck_node
> >    3.75MiB      960 mm/page_ext.c:270 module:page_ext func:alloc_page_e=
xt
> >    4.00MiB        2 mm/khugepaged.c:893 module:khugepaged func:hpage_co=
llapse_alloc_folio
> >    10.5MiB      168 block/blk-mq.c:3421 module:blk_mq func:blk_mq_alloc=
_rqs
> >    14.0MiB     3594 include/linux/gfp.h:295 module:filemap func:folio_a=
lloc_noprof
> >    26.8MiB     6856 include/linux/gfp.h:295 module:memory func:folio_al=
loc_noprof
> >    64.5MiB    98315 fs/xfs/xfs_rmap_item.c:147 module:xfs func:xfs_rui_=
init
> >    98.7MiB    25264 include/linux/gfp.h:295 module:readahead func:folio=
_alloc_noprof
> >     125MiB     7357 mm/slub.c:2201 module:slub func:alloc_slab_page
> >
> > Since v2:
> >  - tglx noticed a circular header dependency between sched.h and percpu=
.h;
> >    a bunch of header cleanups were merged into 6.8 to ameliorate this [=
3].
> >
> >  - a number of improvements, moving alloc_hooks() annotations to the
> >    correct place for better tracking (mempool), and bugfixes.
> >
> >  - looked at alternate hooking methods.
> >    There were suggestions on alternate methods (compiler attribute,
> >    trampolines), but they wouldn't have made the patchset any cleaner
> >    (we still need to have different function versions for accounting vs=
. no
> >    accounting to control at which point in a call chain the accounting
> >    happens), and they would have added a dependency on toolchain
> >    support.
> >
> > Usage:
> > kconfig options:
> >  - CONFIG_MEM_ALLOC_PROFILING
> >  - CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> >  - CONFIG_MEM_ALLOC_PROFILING_DEBUG
> >    adds warnings for allocations that weren't accounted because of a
> >    missing annotation
> >
> > sysctl:
> >   /proc/sys/vm/mem_profiling
> >
> > Runtime info:
> >   /proc/allocinfo
> >
> > Notes:
> >
> > [1]: Overhead
> > To measure the overhead we are comparing the following configurations:
> > (1) Baseline with CONFIG_MEMCG_KMEM=3Dn
> > (2) Disabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
> >     CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dn)
> > (3) Enabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
> >     CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dy)
> > (4) Enabled at runtime (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
> >     CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dn && /proc/sys/vm/mem_profi=
ling=3D1)
> > (5) Baseline with CONFIG_MEMCG_KMEM=3Dy && allocating with __GFP_ACCOUN=
T
> >
>
> Thanks for the work on this patchset and it is quite useful.
> A clarification question on the data:
>
> I assume Config (2), (3) and (4) has CONFIG_MEMCG_KMEM=3Dn, right?

Yes, correct.

> If so do you have similar data for config (2), (3) and (4) but with
> CONFIG_MEMCG_KMEM=3Dy for comparison with (5)?

I have data for these additional configs (didn't think there were that
important):
(6) Disabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dn)  && CONFIG_MEMCG_KMEM=3Dy
(7) Enabled by default (CONFIG_MEM_ALLOC_PROFILING=3Dy &&
CONFIG_MEM_ALLOC_PROFILING_BY_DEFAULT=3Dy) && CONFIG_MEMCG_KMEM=3Dy


>
> Tim
>
> > Performance overhead:
> > To evaluate performance we implemented an in-kernel test executing
> > multiple get_free_page/free_page and kmalloc/kfree calls with allocatio=
n
> > sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> > affinity set to a specific CPU to minimize the noise. Below are results
> > from running the test on Ubuntu 22.04.2 LTS with 6.8.0-rc1 kernel on
> > 56 core Intel Xeon:
> >
> >                         kmalloc                 pgalloc
> > (1 baseline)            6.764s                  16.902s
> > (2 default disabled)    6.793s (+0.43%)         17.007s (+0.62%)
> > (3 default enabled)     7.197s (+6.40%)         23.666s (+40.02%)
> > (4 runtime enabled)     7.405s (+9.48%)         23.901s (+41.41%)
> > (5 memcg)               13.388s (+97.94%)       48.460s (+186.71%)

(6 default disabled+memcg)    13.332s (+97.10%)         48.105s (+184.61%)
(7 default enabled+memcg)     13.446s (+98.78%)       54.963s (+225.18%)

(6) shows a bit better performance than (5) but it's probably noise. I
would expect them to be roughly the same. Hope this helps.

> >
>
>

