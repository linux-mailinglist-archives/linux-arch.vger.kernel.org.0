Return-Path: <linux-arch+bounces-8481-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F999AD21D
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 19:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2001C232DB
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5A79C4;
	Wed, 23 Oct 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBk6JgKB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F361C9EAC
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703284; cv=none; b=f7EAG5TvMJYESlvabZy5X8qjchFdE9uE3Q05KvEd6al1mLEVB06Dv03W8L03N/HS+hG5UhJTJPTIt7/XCyspVOHCFJr+L0HP+VbT2+5SMuvOzzqYCs/bfaV3cLt1M82ojaICCH3l4+MSpkLUVsZ3TFrNkuIvBjiwbURBaAcVAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703284; c=relaxed/simple;
	bh=bwji3KM0kI7ZVL1Hq5Xm6xTu/GMixHRkt08MlaQijgk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gGFQJINDEpHpdtmPWPMIXUES7lxWyZYWsHXk6aep1Wtc/IS2G4ENabtMRW4M0+v941MVydaT6o/ulAuIGaos/KUAJrceYRHAez6pL4+AC0/p4pPEzeKAfVuHnbZVubmwmWlwzhQU8A2tXswMqef9sUnj6GarJi7yi11L2LkldrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBk6JgKB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2605ce4276so28800276.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729703282; x=1730308082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/SgywtZx7rb7/mEn3XyHfH3Cb2SyryihrWMC3ba6F8=;
        b=aBk6JgKBLRIbloH5t8udpkgM8XsADpg/M/lM//rLpP7vydui9YMr2ThLHOsxkhKSPu
         FKUDRjmACnDVOhDb4tThKoCW31YIlLJUNSNHdYKwWSfBMd+rtj2QBP+DIQdwLgN2ULZC
         etZcvBR0DjIDi5GAj/E5WOPTkz2F/z2b/RWoqzOo+gY2RdwT8/vEUoh5SAYcoh91TNse
         BzBPhFQvn7BMkIeLRBRslz6pXrnsVxM+m/r2g9SrrIgjN8yvgcMgk4ArtuTn1332L2FR
         tXgOOfksdAI9QuUmEOSCGZT4phb7bKx6MOLDOjyB65kqboAx1QMPnVp+t/9O+AO6H188
         zXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703282; x=1730308082;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/SgywtZx7rb7/mEn3XyHfH3Cb2SyryihrWMC3ba6F8=;
        b=sLWeYOyPdWqeUIAnGLHI/KEp84brz8c1HGXKKFN+CG1KodoNEYqeAK38TiWPZrU1p6
         0Ejj/x6YcvT4MTATAYXWdncM5BC/oDdgrjxaMRsvaQezeLoz/kBcjZ5PhdTbzbVkm5aG
         C4rom992ZkEXFLw+hMYX0HvT+xMXuozaj7/h34HN1jJthE0fbExU90jECrQQHHCHZjRv
         ec/4BPcT0H2RvkO6NzE79COC/KYB7dG+CM3q6bhZhtRxpxg5nxQUrKEQPDfx4dGWGpBt
         utgP5WH1tLA5/t+sB8ihESBgwaVPjiRz2urE23+4WJdP+G+3J+qxVnCBctFPp9UFUhRk
         JtIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWK5Wzmthb7ps6gEkkwbxPqYgyXPjHEqTKUxen/3Vj6e4CcTzrddSbIVSXh3OtiephKbrtSNcwE9yI@vger.kernel.org
X-Gm-Message-State: AOJu0YymnBmSMZnYSYzdP47NK1R+0GSQHMu2aIiQSGE2hGPqNIub9map
	odXGb0pxpvGOzC8YJT9E/yhjVbi1ZgNKZGtXEbECavbNKLQY2fFLjACm+6H7RGuPW5S1iPINOmb
	WxA==
X-Google-Smtp-Source: AGHT+IEsK5kZcuCRBJ2lcZigYshTAvQXhOVGbGNjlRgIh/suKcwgOyvPk5eRcakI/OtXpbirCYYTcQ44vPI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:a087:59b9:198a:c44c])
 (user=surenb job=sendgmr) by 2002:a05:6902:50d:b0:e2e:44ae:111a with SMTP id
 3f1490d57ef6-e2e44ae12f1mr899276.8.1729703281826; Wed, 23 Oct 2024 10:08:01
 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:07:53 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023170759.999909-1-surenb@google.com>
Subject: [PATCH v4 0/6] page allocation tag compression
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

This patchset implements several improvements:
1. Gracefully handles module unloading while there are used allocations
allocated from that module;
2. Provides an option to store page allocation tag references in the
page flags, removing dependency on page extensions and eliminating the
memory overhead from storing page allocation references (~0.2% of total
system memory). This also improves page allocation performance when
CONFIG_MEM_ALLOC_PROFILING is enabled by eliminating page extension
lookup. Page allocation performance overhead is reduced from 41% to 5.5%.

Patch #1 introduces mas_for_each_rev() helper function.

Patch #2 introduces shutdown_mem_profiling() helper function to be used
when disabling memory allocation profiling.

Patch #3 copies module tags into virtually contiguous memory which
serves two purposes:
- Lets us deal with the situation when module is unloaded while there
are still live allocations from that module. Since we are using a copy
version of the tags we can safely unload the module. Space and gaps in
this contiguous memory are managed using a maple tree.
- Enables simple indexing of the tags in the later patches.

Patch #4 changes the way we allocate virtually contiguous memory for
module tags to reserve only vitrual area and populate physical pages
only as needed at module load time.

Patch #5 abstracts page allocation tag reference to simplify later
changes.

Patch #6 adds compression option to the sysctl.vm.mem_profiling boot
parameter for storing page allocation tag references inside page flags
if they fit. If the number of available page flag bits is insufficient
to address all kernel allocations, memory allocation profiling gets
disabled with an appropriate warning.

Patchset applies to mm-unstable.

Changes since v3 [1]:
- rebased over Mike's patchset in mm-unstable
- added Reviewed-by, per Liam Howlett
- limited execmem_vmap to work with EXECMEM_MODULE_DATA only,
per Mike Rapoport
- moved __get_vm_area_node() declaration into mm/internal.h,
per Mike Rapoport
- split parts of reserve_module_tags() into helper functions to make it
more readable, per Mike Rapoport
- introduced shutdown_mem_profiling() to be used when disabling memory
allocation profiling
- replaced CONFIG_PGALLOC_TAG_USE_PAGEFLAGS with a new boot parameter
option, per Michal Hocko
- minor code cleanups and refactoring to make the code more readable
- added VMALLOC and MODULE SUPPORT reviewers I missed before

[1] https://lore.kernel.org/all/20241014203646.1952505-1-surenb@google.com/

Suren Baghdasaryan (6):
  maple_tree: add mas_for_each_rev() helper
  alloc_tag: introduce shutdown_mem_profiling helper function
  alloc_tag: load module tags into separate contiguous memory
  alloc_tag: populate memory for module tags as needed
  alloc_tag: introduce pgtag_ref_handle to abstract page tag references
  alloc_tag: support for page allocation tag compression

 Documentation/mm/allocation-profiling.rst |   7 +-
 include/asm-generic/codetag.lds.h         |  19 +
 include/linux/alloc_tag.h                 |  21 +-
 include/linux/codetag.h                   |  40 +-
 include/linux/execmem.h                   |  10 +
 include/linux/maple_tree.h                |  14 +
 include/linux/mm.h                        |  25 +-
 include/linux/page-flags-layout.h         |   7 +
 include/linux/pgalloc_tag.h               | 197 +++++++--
 include/linux/vmalloc.h                   |   3 +
 kernel/module/main.c                      |  80 ++--
 lib/alloc_tag.c                           | 467 ++++++++++++++++++++--
 lib/codetag.c                             | 104 ++++-
 mm/execmem.c                              |  16 +
 mm/internal.h                             |   6 +
 mm/mm_init.c                              |   5 +-
 mm/vmalloc.c                              |   4 +-
 scripts/module.lds.S                      |   5 +-
 18 files changed, 903 insertions(+), 127 deletions(-)


base-commit: b5d43fad926a3f542cd06f3c9d286f6f489f7129
-- 
2.47.0.105.g07ac214952-goog


