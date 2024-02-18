Return-Path: <linux-arch+bounces-2475-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E3859406
	for <lists+linux-arch@lfdr.de>; Sun, 18 Feb 2024 03:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4932823FF
	for <lists+linux-arch@lfdr.de>; Sun, 18 Feb 2024 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BA21C10;
	Sun, 18 Feb 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dy0+oSSo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E7A29
	for <linux-arch@vger.kernel.org>; Sun, 18 Feb 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708222896; cv=none; b=MYKYUEl/o0vC734hzm3vjX1pAdQ99lZyS5XOd1/i6bKlUu0ehoeU410mEZADQ3+/lLBsW2JAsi4VGD4XsH1WjuZaeFZnbrXi4j2Za7KlqVhKP+t37PpnlmW2mkw8WNno6FUPHOqvutXS6sUXo5Ubs0EX/rAWxSftn+lpc/fJGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708222896; c=relaxed/simple;
	bh=sGLQWy2gJ22i5/11EUF6i6TeDZNPTR8RdMNYUPKuXtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jufLUhn+OB+yBz0He96TwH85iRYFs48Zr4wHHc53lgT4dhVP2Kq4wg/wNq/wEEOdFPC/ZP1tZH6c08WwG+/2FoZbeSVpwUvkQZUPPAq3hu32tr0nFw6LCw2y1tEqjUcWbtY7ukOu4qQtaXBo56sKQsL1OiSqEVv2ZiDXbyYbmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dy0+oSSo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc236729a2bso3041745276.0
        for <linux-arch@vger.kernel.org>; Sat, 17 Feb 2024 18:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708222892; x=1708827692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGwMPlFmMn7i+PsCRsmYPKBrgHwqE0wRHG6PNy5zjw0=;
        b=Dy0+oSSo/rLVLFYRNniJ8/xLna969/++gNkbWpS6mx2DBrdgoFAbwDKo7xwr5EaXEc
         BxdvFTlyenLEwcJGQy5hh7gYtHG65bMckXjyD3oskfkiunAoXiTycAClPHN6Wtun9zVN
         JD+KyRvBXIKOLfDUgllhnEXBged/RY5qcN5ZgvnvDxdQbsTWJEjnfv6/+0yPBPKJ39ld
         N1sfaXsKEwSAdu7Fcsymy3YO8aLDkEiX+qeJI4YFI7QdKWay0Q6eUnpsUmOCeYLoGYX5
         jVQMRCoKm1AlRWnExVzMTyMzwdyBte1Oka+Eh+wI18AhcMi56/IQzNmSZ3A6ClUI8o/+
         c6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708222892; x=1708827692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGwMPlFmMn7i+PsCRsmYPKBrgHwqE0wRHG6PNy5zjw0=;
        b=Rjoe0zNoV6C8sl5EgIx8iM5AXJT4A5RZhKhnf7Q93Cnz5OPRFlt+KMIYjFyiYsyzGe
         Mdlb/p4xusGqgju1XdnSJYcL0IN0acxqKUIx7pFb76aNfqq8gvMzuykG9l32nB9N844a
         ZvpD7f7MiQYIJu+ZlWQQKrkoREbV2BnJ6f9tLJHWJsM7jKhVjJ6+m0D7VpT0MQufeTdO
         fqkTOUb+jarsm7VWfCQkwVqiE31f9A40r71854a7RkfZrHT4l/bgtbDXurDXaukSf4gr
         Ja1pvJDdD/tPkAZR73xfWfKvob3F92tUEoUYoYWtSwqh3OCvOK1fpfbYjqL3lcklx7d9
         dM6g==
X-Forwarded-Encrypted: i=1; AJvYcCVf7XVJWhO2z8wutj/7OBppZ/Cm0gJSsRp1i41byt3i/KzGzAYSaE795kEgwSWszMvYZSUMNrtZwztwAZAgljv63e0JBOAZ8Kms/A==
X-Gm-Message-State: AOJu0YwQA83OIrafc0d6NeF2feYgD7GaeLsK3ECLizBxFwFj7VxfdQrN
	0VYbMrb2qo1X+osOX3lEsgzYeI3HU7By5x/h/haiVf18SORAlv7ENDoTGTd9DtQH+XQDFxMRgCL
	9N1W9Rt0ea15xgXXv+K079bIwzgHutKdrz0OK
X-Google-Smtp-Source: AGHT+IFbcmWP0wuiiRTf0AlfSBMbSNfrD0N8TNtgVp/GNQHvOsL/OfZQsmBKdpZvPdO7G1/QjsP0VpRVVtpV4P/uhdk=
X-Received: by 2002:a05:6902:268a:b0:dcd:4e54:9420 with SMTP id
 dx10-20020a056902268a00b00dcd4e549420mr9768527ybb.5.1708222891980; Sat, 17
 Feb 2024 18:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-14-surenb@google.com>
 <f92ad1e3-2dde-4db2-9b76-96c6bbc6a208@suse.cz>
In-Reply-To: <f92ad1e3-2dde-4db2-9b76-96c6bbc6a208@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 18 Feb 2024 02:21:18 +0000
Message-ID: <CAJuCfpGemg-aXyiK1fHavdKuW+-9+DM5_4krLAdg+DQh=24Dvg@mail.gmail.com>
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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

On Fri, Feb 16, 2024 at 8:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/12/24 22:38, Suren Baghdasaryan wrote:
> > Introduce CONFIG_MEM_ALLOC_PROFILING which provides definitions to easi=
ly
> > instrument memory allocators. It registers an "alloc_tags" codetag type
> > with /proc/allocinfo interface to output allocation tag information whe=
n
> > the feature is enabled.
> > CONFIG_MEM_ALLOC_PROFILING_DEBUG is provided for debugging the memory
> > allocation profiling instrumentation.
> > Memory allocation profiling can be enabled or disabled at runtime using
> > /proc/sys/vm/mem_profiling sysctl when CONFIG_MEM_ALLOC_PROFILING_DEBUG=
=3Dn.
> > CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT enables memory allocation
> > profiling by default.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst |  16 +++
> >  Documentation/filesystems/proc.rst      |  28 +++++
> >  include/asm-generic/codetag.lds.h       |  14 +++
> >  include/asm-generic/vmlinux.lds.h       |   3 +
> >  include/linux/alloc_tag.h               | 133 ++++++++++++++++++++
> >  include/linux/sched.h                   |  24 ++++
> >  lib/Kconfig.debug                       |  25 ++++
> >  lib/Makefile                            |   2 +
> >  lib/alloc_tag.c                         | 158 ++++++++++++++++++++++++
> >  scripts/module.lds.S                    |   7 ++
> >  10 files changed, 410 insertions(+)
> >  create mode 100644 include/asm-generic/codetag.lds.h
> >  create mode 100644 include/linux/alloc_tag.h
> >  create mode 100644 lib/alloc_tag.c
> >
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/ad=
min-guide/sysctl/vm.rst
> > index c59889de122b..a214719492ea 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -43,6 +43,7 @@ Currently, these files are in /proc/sys/vm:
> >  - legacy_va_layout
> >  - lowmem_reserve_ratio
> >  - max_map_count
> > +- mem_profiling         (only if CONFIG_MEM_ALLOC_PROFILING=3Dy)
> >  - memory_failure_early_kill
> >  - memory_failure_recovery
> >  - min_free_kbytes
> > @@ -425,6 +426,21 @@ e.g., up to one or two maps per allocation.
> >  The default value is 65530.
> >
> >
> > +mem_profiling
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Enable memory profiling (when CONFIG_MEM_ALLOC_PROFILING=3Dy)
> > +
> > +1: Enable memory profiling.
> > +
> > +0: Disabld memory profiling.
>
>       Disable

Ack.

>
> ...
>
> > +allocinfo
> > +~~~~~~~
> > +
> > +Provides information about memory allocations at all locations in the =
code
> > +base. Each allocation in the code is identified by its source file, li=
ne
> > +number, module and the function calling the allocation. The number of =
bytes
> > +allocated at each location is reported.
>
> See, it even says "number of bytes" :)

Yes, we are changing the output to bytes.

>
> > +
> > +Example output.
> > +
> > +::
> > +
> > +    > cat /proc/allocinfo
> > +
> > +      153MiB     mm/slub.c:1826 module:slub func:alloc_slab_page
>
> Is "module" meant in the usual kernel module sense? In that case IIRC is
> more common to annotate things e.g. [xfs] in case it's really a module, a=
nd
> nothing if it's built it, such as slub. Is that "slub" simply derived fro=
m
> "mm/slub.c"? Then it's just redundant?

Sounds good. The new example would look like this:

    > sort -rn /proc/allocinfo
   127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
    56373248     4737 mm/slub.c:2259 func:alloc_slab_page
    14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
    14417920     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
    13377536      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
    11718656     2861 mm/filemap.c:1919 func:__filemap_get_folio
     9192960     2800 kernel/fork.c:307 func:alloc_thread_stack_node
     4206592        4 net/netfilter/nf_conntrack_core.c:2567
func:nf_ct_alloc_hashtable
     4136960     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod]
func:ctagmod_start
     3940352      962 mm/memory.c:4214 func:alloc_anon_folio
     2894464    22613 fs/kernfs/dir.c:615 func:__kernfs_new_node
     ...

Note that [ctagmod] is the only allocation from a module in this example.

>
> > +     6.08MiB     mm/slab_common.c:950 module:slab_common func:_kmalloc=
_order
> > +     5.09MiB     mm/memcontrol.c:2814 module:memcontrol func:alloc_sla=
b_obj_exts
> > +     4.54MiB     mm/page_alloc.c:5777 module:page_alloc func:alloc_pag=
es_exact
> > +     1.32MiB     include/asm-generic/pgalloc.h:63 module:pgtable func:=
__pte_alloc_one
> > +     1.16MiB     fs/xfs/xfs_log_priv.h:700 module:xfs func:xlog_kvmall=
oc
> > +     1.00MiB     mm/swap_cgroup.c:48 module:swap_cgroup func:swap_cgro=
up_prepare
> > +      734KiB     fs/xfs/kmem.c:20 module:xfs func:kmem_alloc
> > +      640KiB     kernel/rcu/tree.c:3184 module:tree func:fill_page_cac=
he_func
> > +      640KiB     drivers/char/virtio_console.c:452 module:virtio_conso=
le func:alloc_buf
> > +      ...
> > +
> > +
> >  meminfo
>
> ...
>
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 0be2d00c3696..78d258ca508f 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -972,6 +972,31 @@ config CODE_TAGGING
> >       bool
> >       select KALLSYMS
> >
> > +config MEM_ALLOC_PROFILING
> > +     bool "Enable memory allocation profiling"
> > +     default n
> > +     depends on PROC_FS
> > +     depends on !DEBUG_FORCE_WEAK_PER_CPU
> > +     select CODE_TAGGING
> > +     help
> > +       Track allocation source code and record total allocation size
> > +       initiated at that code location. The mechanism can be used to t=
rack
> > +       memory leaks with a low performance and memory impact.
> > +
> > +config MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> > +     bool "Enable memory allocation profiling by default"
> > +     default y
>
> I'd go with default n as that I'd select for a general distro.

Well, we have MEM_ALLOC_PROFILING=3Dn by default, so if it was switched
on manually, that is a strong sign that the user wants it enabled IMO.
So, enabling this switch by default seems logical to me. If a distro
wants to have the feature compiled in but disabled by default then
this is perfectly doable, just need to set both options appropriately.
Does my logic make sense?

>
> > +     depends on MEM_ALLOC_PROFILING
> > +
> > +config MEM_ALLOC_PROFILING_DEBUG
> > +     bool "Memory allocation profiler debugging"
> > +     default n
> > +     depends on MEM_ALLOC_PROFILING
> > +     select MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> > +     help
> > +       Adds warnings with helpful error messages for memory allocation
> > +       profiling.
> > +
>

