Return-Path: <linux-arch+bounces-2757-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30053869BAE
	for <lists+linux-arch@lfdr.de>; Tue, 27 Feb 2024 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A91285DF2
	for <lists+linux-arch@lfdr.de>; Tue, 27 Feb 2024 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB11482F3;
	Tue, 27 Feb 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MeJ45Tx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0FF1474AB
	for <linux-arch@vger.kernel.org>; Tue, 27 Feb 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050259; cv=none; b=uT98eFTlksylOwPGTwCtgjiU+0BT6uNTvmzr674Wj7SS0kqYsJ7b8/13sSz7xfBlVR1JcIDeoQcmbX3l+bdM+i4nh33Z+6Osp7bIig3aqn5FnY5aVFy8Q4InBVcSek3gchx1diR4yUo/NpK3t8Q5APqHXY46M9hgY9DukKb04pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050259; c=relaxed/simple;
	bh=nDxGfqMt13C5jtHaHc4vC6L/CJ5CyAlKFCiqHu/Q5AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHbgjL9eZXPNOtdL6vVYuMj46XcE6tsZIjtsoo+1x0xn+OxGmCoWXkKfF5EzunBo3Bne7nMGqDyf/z5tgIUJWyyEYLeqkKYl4m3DGUp8mwWRfVbJ//gj+a+y3rDkwFg3EGNydPn8EPWXLUIYHHAEQSlBYkhtot+81Gauvij8IMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MeJ45Tx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-608cf2e08f9so39706177b3.0
        for <linux-arch@vger.kernel.org>; Tue, 27 Feb 2024 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709050256; x=1709655056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3997VUdAcSrw6hJXGBCDEHFxh3lqzFAtRC+eH0EMEcI=;
        b=0MeJ45TxvkJ0MVWsxEjyDkxWLXiNjVF26WeLwFNYNBOtgGxIyhcsLzKS5TnhhLEcwU
         JiYijcgJmv82zeOo368b8sXVs4teBembBml1GYON/0lHis18lzZl9dcUQ8frrRQLvgPA
         opbdtJxDUXDakZ8nbyT63op1sUOTPpmzjXJk9u+W70IKUJdsCednB9x4nZPklt5yV16N
         PmFU75Lks+InLPBNLRG+u2lSzn3rqWq1EpcldoETVmpVTP77iMVONauUt6eH4wAUG4LI
         pUJRmFY9N+5QY0tcA/q7rdOK4EgYSXmVoMjkpSjcetAIdORSwoOw5EChfdvZJ28Qtkqz
         dbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050256; x=1709655056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3997VUdAcSrw6hJXGBCDEHFxh3lqzFAtRC+eH0EMEcI=;
        b=diCDjmDSyoCvhbQuu4Sqf1OmO8FtLX9Y7iy+/sWTuaIL4inWJHsHfNsf/NEklI9rBT
         MHf72S4kFB4bRWG2H2r/t9NCrDIpsC++YbV5dT7ugcCyzWHv2pGBcdqfRwbfIJwEuunc
         89DZmD5fxnZn7LXlDqrDbrIm4OybbreKGo6KKNVMrHa5Uf7Z24SGoMHjqrLGMPbLUZv4
         VHyQvQQIAiWCNvr1ayDqMOPgIHBkQLgs6dHg+ROsaCD+960RIPVuC/Aw7s9V8I018vKq
         qR54qez2jAaIZ4zG+N7PZruU0fWxZUzdPyoJsoGMiFsQykPNQtWx2ULS5EaaeGSg7Liv
         hQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFA8lQBBfHjngf1As2xg0PTomsrVPT4PJcWuTJF7bXBEdiQ5ltJO90fpDjPtElcB89+Vb96Vv61nxeb+tNJtJI54ivR+CMUxTFLQ==
X-Gm-Message-State: AOJu0YzpDsbJyZZWMCAlIlSUSQCYEUJGMa46yBdJk0wLkIGFlM1a58ky
	LwH1OuHElbGlhqxw5Er2uA2n/T5c88pFl+bkmtNLpxelIeHsjUmTCKjr3v4vWmxAXQqm2lvy6ft
	1WDfXbzmiTWBNIB9gSLe9rwCkQkvmo5cCqupa
X-Google-Smtp-Source: AGHT+IEHPBI8sanvwTrodqkBZscFpfJ5hxIGD0OGV0J9ftpRl85Uhg0i/fQvfgLElKHDPIfjBMGZnSSbq41lp7tF8gc=
X-Received: by 2002:a25:874c:0:b0:dcb:d8d1:2d52 with SMTP id
 e12-20020a25874c000000b00dcbd8d12d52mr2322309ybn.31.1709050255947; Tue, 27
 Feb 2024 08:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <67453a56-d4c2-4dc8-a5db-0a4665e40856@suse.cz>
In-Reply-To: <67453a56-d4c2-4dc8-a5db-0a4665e40856@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Feb 2024 08:10:43 -0800
Message-ID: <CAJuCfpHLEzCzATZ2ZP74--9mfYh-g-2csZ9A9oyaWWEQGNuGpg@mail.gmail.com>
Subject: Re: [PATCH v4 00/36] Memory allocation profiling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Tue, Feb 27, 2024 at 5:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > Overview:
> > Low overhead [1] per-callsite memory allocation profiling. Not just for
> > debug kernels, overhead low enough to be deployed in production.
> >
> > Example output:
> >   root@moria-kvm:~# sort -rn /proc/allocinfo
> >    127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
> >     56373248     4737 mm/slub.c:2259 func:alloc_slab_page
> >     14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
> >     14417920     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
> >     13377536      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
> >     11718656     2861 mm/filemap.c:1919 func:__filemap_get_folio
> >      9192960     2800 kernel/fork.c:307 func:alloc_thread_stack_node
> >      4206592        4 net/netfilter/nf_conntrack_core.c:2567 func:nf_ct=
_alloc_hashtable
> >      4136960     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod] fu=
nc:ctagmod_start
> >      3940352      962 mm/memory.c:4214 func:alloc_anon_folio
> >      2894464    22613 fs/kernfs/dir.c:615 func:__kernfs_new_node
> >      ...
> >
> > Since v3:
> >  - Dropped patch changing string_get_size() [2] as not needed
> >  - Dropped patch modifying xfs allocators [3] as non needed,
> >    per Dave Chinner
> >  - Added Reviewed-by, per Kees Cook
> >  - Moved prepare_slab_obj_exts_hook() and alloc_slab_obj_exts() where t=
hey
> >    are used, per Vlastimil Babka
> >  - Fixed SLAB_NO_OBJ_EXT definition to use unused bit, per Vlastimil Ba=
bka
> >  - Refactored patch [4] into other patches, per Vlastimil Babka
> >  - Replaced snprintf() with seq_buf_printf(), per Kees Cook
> >  - Changed output to report bytes, per Andrew Morton and Pasha Tatashin
> >  - Changed output to report [module] only for loadable modules,
> >    per Vlastimil Babka
> >  - Moved mem_alloc_profiling_enabled() check earlier, per Vlastimil Bab=
ka
> >  - Changed the code to handle page splitting to be more understandable,
> >    per Vlastimil Babka
> >  - Moved alloc_tagging_slab_free_hook(), mark_objexts_empty(),
> >    mark_failed_objexts_alloc() and handle_failed_objexts_alloc(),
> >    per Vlastimil Babka
> >  - Fixed loss of __alloc_size(1, 2) in kvmalloc functions,
> >    per Vlastimil Babka
> >  - Refactored the code in show_mem() to avoid memory allocations,
> >    per Michal Hocko
> >  - Changed to trylock in show_mem() to avoid blocking in atomic context=
,
> >    per Tetsuo Handa
> >  - Added mm mailing list into MAINTAINERS, per Kees Cook
> >  - Added base commit SHA, per Andy Shevchenko
> >  - Added a patch with documentation, per Jani Nikula
> >  - Fixed 0day bugs
> >  - Added benchmark results [5], per Steven Rostedt
> >  - Rebased over Linux 6.8-rc5
> >
> > Items not yet addressed:
> >  - An early_boot option to prevent pageext overhead. We are looking int=
o
> >    ways for using the same sysctr instead of adding additional early bo=
ot
> >    parameter.
>
> I have reviewed the parts that integrate the tracking with page and slab
> allocators, and besides some details to improve it seems ok to me. The
> early boot option seems coming so that might eventually be suitable for
> build-time enablement in a distro kernel.

Thanks for reviewing Vlastimil!

>
> The macros (and their potential spread to upper layers to keep the
> information useful enough) are of course ugly, but guess it can't be
> currently helped and I'm unable to decide whether it's worth it or not.
> That's up to those providing their success stories I guess. If there's
> at least a path ahead to replace that part with compiler support in the
> future, great. So I'm not against merging this. BTW, do we know Linus's
> opinion on the macros approach?

We haven't run it by Linus specifically but hopefully we will see a
comment from him on the mailing list at some point.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

