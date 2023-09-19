Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB87A6F36
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjISXKC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 19:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjISXJj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 19:09:39 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B17C4;
        Tue, 19 Sep 2023 16:09:24 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-59c07cf02ebso49652637b3.1;
        Tue, 19 Sep 2023 16:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695164963; x=1695769763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4LUIFygfhett/C9IkVouxBc9S18CsTasygVXq8ih1M8=;
        b=EqHzBlSq8/+2VtzFq1pXpZZNz47hBp/m+CHgymU+ZMmqWiEhxv4FiHCKtUlTscb6aX
         XTF8NsIwiGLaSAQcvrzEy1X09kXjlYewZ0NDodFE9OJzrFWFiNUPSIuduLXo+o1eN3ae
         qLkpPptL2cfYhg3MfuqngcX7E5Kltt+LAJeHpaJ3msmAWV3B6pg/nQUG0nRpZR5GmgWT
         AXflFkqEuagw29XYXzClmspaC2IXFzcEEu20ybhuPkHdfOHMeqC586XzqkAJGZTbpUXD
         3t0d5Jt7QhJysKGwd2bV6wNsQCc+5nQLU0vIc+AO8m7RqJCXc2MBtXKj2/2Wc9rrPFI0
         TO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695164963; x=1695769763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LUIFygfhett/C9IkVouxBc9S18CsTasygVXq8ih1M8=;
        b=XQwYNsX9x8IzypgNrvVcvhM+K6apC1sHdPipNv2HBURThdodW4LBL7HZKAE91dG/Mu
         gmHeNIouNQK7gdV1q+XsG0oYogqsCj5zU2S4+/QGTJZC0Anu4lKdrm+8xOcKT4PA1wTB
         4UqPH3Itf/ZLXGtyCY5iKttaBsZnsPzKTcVUbAvG9M24HJ8Zl47m9EMJ7Wp/H7GKYy2g
         2471vsHpcfwGcWOHOS78FIcGdU0jOBVZwG/DwxXVcApgY7iHNEw8NzlCC87C6OffYWZH
         2JpqUdWYYYyl5sRipg7AjEiFGnI56Giom2n0DH6V0XP1J/kNcUYJmylOpx0YU/WtUhvK
         VnfQ==
X-Gm-Message-State: AOJu0YxvXvADnAbPZ6mEaRWlKCcj+AlCfh7C863HVQzscm7MWrMrvFBx
        UIMh8uLlWn1UJ4gFWxYvxTU9pl8K/PoS
X-Google-Smtp-Source: AGHT+IH4zegi8qYNbIf4HjNVs3xFkqqVpXRECJHm3LwsmgG7lXpA+5Ik7PzctU6JReJ4a41RJKl5Ug==
X-Received: by 2002:a81:6c43:0:b0:584:33c:31f2 with SMTP id h64-20020a816c43000000b00584033c31f2mr777537ywc.17.1695164963126;
        Tue, 19 Sep 2023 16:09:23 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d128-20020a0df486000000b005925765aa30sm3476327ywf.135.2023.09.19.16.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:09:22 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC v2 0/5] move_phys_pages syscall 
Date:   Tue, 19 Sep 2023 19:09:03 -0400
Message-Id: <20230919230909.530174-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

v2:
new:
- ktest for move_phys_pages
- draft man page
- comments about do_pages_move refactor/arguments (mm, task_nodes)
  for the phys_pages usage path.
- compat ptr fixes for do_pages_move
  (will pull this out into a separate patch request as well)

fixes:
- capable(CAP_SYS_ADMIN) requirements
- additional error checking in do_pages_move
- bad refactor in add_page_for_migration, fixed null-deref due to
  not checking the result of follow_page correctly.
- fixed get/put folio ordering issue in add_phys_page_for_migration
- fixed non-memcg build issue in phys_page_migratable
- added additional physical address source information to RFC text
- some formatting and inconsistencies between definitions

=== RFC

This patch set is a proposal for a syscall analogous to move_pages,
that migrates pages between NUMA nodes using physical addressing.

The intent is to better enable user-land system-wide memory tiering
as CXL devices begin to provide memory resources on the PCIe bus.

This patch set broken into 5 patches:
  1) compat ptr bug reported by Arnd
  2) refactor of existing migration code for code reuse
  3) refactor of existing migration code for code reuse
  4) The sys_move_phys_pages system call.
  5) ktest of the syscall
  6) draft man page

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
address information for use with this interface, and 1 that is being
proposed here in the near future.

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

5) CXL (Proposed): a CXL memory device on the PCIe bus may provide
     hot/cold information about its memory.  If a heatmap is provided,
     for example, it would have to be a device address (0-based) or a
     physical address (some base defined by the kernel and programmed
     into device decoders such that it can convert them to 0-based).

     This is presently being proposed but has not been agreed upon yet.

Information from these sources facilitates systemwide resource management,
but with the limitations of migrate_pages and move_pages applying to
individual tasks, their outputs must be converted back to virtual addresses
and re-associated with specific PIDs.

Doing this reverse-translation outside of the kernel requires considerable
space and compute, and it will have to be performed again by the existing
system calls.  Much of this work can be avoided if the pages can be
migrated directly with physical memory addressing.

Gregory Price (5):
  mm/migrate: fix do_pages_move for compat pointers
  mm/migrate: remove unused mm argument from do_move_pages_to_node
  mm/migrate: refactor add_page_for_migration for code re-use
  mm/migrate: Create move_phys_pages syscall
  ktest: sys_move_phys_pages ktest

 arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 include/linux/syscalls.h                |   5 +
 include/uapi/asm-generic/unistd.h       |   8 +-
 kernel/sys_ni.c                         |   1 +
 mm/migrate.c                            | 319 ++++++++++++++++++++----
 tools/include/uapi/asm-generic/unistd.h |   8 +-
 tools/testing/selftests/mm/migration.c  | 101 ++++++++
 8 files changed, 396 insertions(+), 48 deletions(-)

-- 
2.39.1

