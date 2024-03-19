Return-Path: <linux-arch+bounces-3033-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE1880359
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57272848DB
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856A918C22;
	Tue, 19 Mar 2024 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ2dF9Vy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99D179A6;
	Tue, 19 Mar 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869180; cv=none; b=mr4daKOwiPL/pxY0ZdhwxhnN6YLfroYEcIJokXQ1yk5Nq/gNFV1Gg5VPl6V4RON0Fk6EY8EvaxfS/xcpXqP1uKIotGUL1mB0khu9hmFx/wMhtZd+KF9sCZvsJ7Gj2fILQJXZUK+Ro3XSMcw6HXIZCHKY4C2DwKUvdaPC/UoKzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869180; c=relaxed/simple;
	bh=qkpP7w3i0afqMWzqjenFL8hIC6b58/5pzizgWxOlhyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G89yQj3GFi5129rnH1ZQJAg0oqhVXjgaGIyY7Buq+sz8gk837aLxNBz+j70ek5isgqgnt/Ge6aCrTWxxrLTBs5GUGIUXaTytUNHlUYSwxpWnPE+O+/5kGh1h6zUZcEcZQ7ujQiSfOK7jCSfO3/a/gVH4GnJ8lXWrkvTMdH/Rejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ2dF9Vy; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-220ee7342ddso2221218fac.3;
        Tue, 19 Mar 2024 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710869178; x=1711473978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+an6r+pXUvZGGrQpMeUK8iakgf50U4ZbnMy71YM61k=;
        b=lJ2dF9VyDcYDf8VEQBRDES2WUbFC5At8ffz+PxZESw90NrKzNFYAUS9okXxZAsXsub
         FF+hX3+8AGGj1Nw9eZ63K4sRVjubKc4l0MqsDjjW9uE58j6V8SxoBtU3LiJkVn2L+vRi
         Ywes37BpBKTaUSlGOsBPaPw4ZoXW7n38Sqr8Pkm16E/7QxkoCQSQGvuabdrnrYMBKm2t
         ZLxbT3zcyDTpAnU47WD41kyFxoSCdA06NCCzP/47KwcqBXyLQG94om/e6onFZZcWzuNl
         GCoLuQWL6hbifOFF3CiWgDpKxm8qfYMuF0iMY0ZPlT1ejMqCbyiU4MTeC4ttFMl+8AjU
         yYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869178; x=1711473978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+an6r+pXUvZGGrQpMeUK8iakgf50U4ZbnMy71YM61k=;
        b=MxPtCIchAVN4Bh3M/XQifQZqHHDfl4ic5WDv4CPThvhQcEsOadUs4ftLBOi7T83IvD
         rR21zVMThneZprtVxUIIzS00OS+tR3z/ebDaUmQnqUVEFl+Pwo+bQ9JIbV9UOPE1Op3W
         VUSukBvJc2a3TBPqOSJh+vzyaLF2xstst2U9CaiI0/uU3PxxJwvKrD00vRB0rSCC1kxc
         QCws767HlhcvTHaId5wOFqxDMNYgiKE3sw0ejifEEA83ZaDovPvObaPOJzuj9SjeWhVh
         aa+0u5sj0G7ejSsNQl7bvCorpkpIu7bOB242gVmbF3aMUgf7etsaZt6FH0qn5zLko5IK
         pA3g==
X-Forwarded-Encrypted: i=1; AJvYcCW7feoTUYNfRPHcabvoYAtVvEl2dvMhj2Gm95gIsK14GdTjX16ClYxNO95oU8eRIq5kHg/oTLTZVzsl8pN4C1WsHOlpoPlSr6D2Y4WZmsHGbAuCtEGAHddMvGxznwu4tx1zsGA2NqxRMzS3EXNKoFbp40npNKdbmrl3khHHAZ8GJjbqvkdHS/ObxQ==
X-Gm-Message-State: AOJu0YwCl5XSQCHOQXtIAfrG8HBkocZH0EOD4rof2qwutCFnvV1S4aRt
	cl/Bq2oDhqlBz+5OngQZgDEH96QF8p13NvayQ5sUm/y68o04OfU3/fqgZ2fHYw==
X-Google-Smtp-Source: AGHT+IE8T/zozGLrqsxPKgRGZQU3Dkvhwuo6uki8TzV7ZqK1OJuj8EQQe8cSsurk9ahytZOpJgolnw==
X-Received: by 2002:a05:6870:46a8:b0:21e:7156:a6ad with SMTP id a40-20020a05687046a800b0021e7156a6admr16607288oap.48.1710869177785;
        Tue, 19 Mar 2024 10:26:17 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id i20-20020aa787d4000000b006e57247f4e5sm10038173pfo.8.2024.03.19.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:26:17 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ying.huang@intel.com,
	dan.j.williams@intel.com,
	honggyu.kim@sk.com,
	corbet@lwn.net,
	arnd@arndb.de,
	luto@kernel.org,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC v3 0/3] move_phys_pages syscall - migrate page contents given
Date: Tue, 19 Mar 2024 13:26:06 -0400
Message-Id: <20240319172609.332900-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- pull forward to v6.8
- style and small fixups recommended by jcameron
- update syscall number (will do all archs when RFC tag drops)
- update for new folio code
- added OCP link to device-tracked address hotness proposal
- kept void* over __u64 simply because it integrates cleanly with
  existing migration code. If there's strong opinions, I can refactor.

This patch set is a proposal for a syscall analogous to move_pages,
that migrates pages between NUMA nodes using physical addressing.

The intent is to better enable user-land system-wide memory tiering
as CXL devices begin to provide memory resources on the PCIe bus.

For example, user-land software which is making decisions based on
data sources which expose physical address information no longer
must convert that information to virtual addressing to act upon it
(see background for info on how physical addresses are acquired).

The syscall requires CAP_SYS_ADMIN, since physical address source
information is typically protected by the same (or CAP_SYS_NICE).

This patch set broken into 3 patches:
  1) refactor of existing migration code for code reuse
  2) The sys_move_phys_pages system call.
  3) ktest of the syscall

The sys_move_phys_pages system call validates the page may be
migrated by checking migratable-status of each vma mapping the page,
and the intersection of cpuset policies each vma's task.


Background:

Userspace job schedulers, memory managers, and tiering software
solutions depend on page migration syscalls to reallocate resources
across NUMA nodes. Currently, these calls enable movement of memory
associated with a specific PID. Moves can be requested in coarse,
process-sized strokes (as with migrate_pages), and on specific virtual
pages (via move_pages).

However, a number of profiling mechanisms provide system-wide information
that would benefit from a physical-addressing version move_pages.

There are presently at least 4 ways userland can acquire physical
address information for use with this interface, and 1 hardware offload
mechanism being proposed by opencompute.

1) /proc/pid/pagemap: can be used to do page table translations.
     This is only really useful for testing, and the ktest was
     written using this functionality.

2) X86:  IBS (AMD) and PEBS (Intel) can be configured to return physical
     and/or vitual address information.

3) zoneinfo:  /proc/zoneinfo exposes the start PFN of zones

4) /sys/kernel/mm/page_idle:  A way to query whether a PFN is idle.
   So long as the page size is known, this can be used to identify
   system-wide idle pages that could be migrated to lower tiers.

   https://docs.kernel.org/admin-guide/mm/idle_page_tracking.html

5) CXL Offloaded Hotness Monitoring (Proposed): a CXL memory device
   may provide hot/cold information about its memory. For example,
   it may report the hottest device addresses (0-based) or a physical
   address (if it has access to decoders for convert bases).

   DPA can be cheaply converted to HPA by combining it with data
   exposed by /sys/bus/cxl/ information (region address bases).

See: https://www.opencompute.org/documents/ocp-cms-hotness-tracking-requirements-white-paper-pdf-1


Information from these sources facilitates systemwide resource management,
but with the limitations of migrate_pages and move_pages applying to
individual tasks, their outputs must be converted back to virtual addresses
and re-associated with specific PIDs.

Doing this reverse-translation outside of the kernel requires considerable
space and compute, and it will have to be performed again by the existing
system calls.  Much of this work can be avoided if the pages can be
migrated directly with physical memory addressing.

Gregory Price (3):
  mm/migrate: refactor add_page_for_migration for code re-use
  mm/migrate: Create move_phys_pages syscall
  ktest: sys_move_phys_pages ktest

 arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 include/linux/syscalls.h                |   5 +
 include/uapi/asm-generic/unistd.h       |   8 +-
 kernel/sys_ni.c                         |   1 +
 mm/migrate.c                            | 288 ++++++++++++++++++++----
 tools/include/uapi/asm-generic/unistd.h |   8 +-
 tools/testing/selftests/mm/migration.c  |  99 ++++++++
 8 files changed, 370 insertions(+), 41 deletions(-)

-- 
2.39.1


