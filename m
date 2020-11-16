Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B802B4E3D
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbgKPRnM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 12:43:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbgKPRmS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 12:42:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 304AD1F45E45
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     hch@infradead.org, mingo@redhat.com, keescook@chromium.org,
        arnd@arndb.de, luto@amacapital.net, wad@chromium.org,
        rostedt@goodmis.org, paul@paul-moore.com, eparis@redhat.com,
        oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 00/10] Migrate syscall entry/exit work to SYSCALL_WORK flagset
Date:   Mon, 16 Nov 2020 12:41:56 -0500
Message-Id: <20201116174206.2639648-1-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This is the v2 of the SYSCALL_WORK flagset.  It addresses the issues
raised by hch and tglx in the previous iteration (thank you!)  regarding
casts, styling, and naming of the variable fields.  It also fixes
comments that were missing on the previous version.

This was tested by running the modified syscall features on a x86 box.
I just compile tested for architectures that are !CONFIG_GENERIC_ENTRY.

This patchset can be found at the following repo/tag

  https://gitlab.collabora.com/krisman/linux.git -b x86-tif-cleanup-v2

Below, is the original cover letter, with reasoning and design.

Original cover letter
====================

Thomas,

This a refactor work moving the work done by features like seccomp,
ptrace, audit and tracepoints out of the TI flags.  The reasons are:

   1) Scarcity of TI flags in x86 32-bit.

   2) TI flags are defined by the architecture, while these features are
   arch-independent.

   3) Community resistance in merging new architecture-independent
   features as TI flags.

The design exposes a new field in struct thread_info that is read at
syscall_trace_enter and syscall_work_exit in place of the ti flags.
No functional changes is expected from this patchset.  The design and
organization of this patchset achieves the following goals:

  1) SYSCALL_WORK flags are architecture-independent

  2) Architectures that are not using the generic entry code can
  continue to use TI flags transparently and be converted later.

  3) Architectures that migrate to the generic entry code are forced to
  use the new design.

  4) x86, since it supports the generic code, is migrated in this
  patchset.

The transparent usage of TIF or SYSCALL_WORK flags is achieved through
some macros.  Any code outside of the generic entry code is converted to
use the flags only through the accessors.

The patchset has some transition helpers, in an attempt to simplify the
patches converting each of the subsystems separately.  I believe this
simplifies the review while making the tree bisectable.

I tested this by running each of the features in x86.  Other
architectures were compile tested only.

This is based on top of tip/master.

A tree with the patches applies can be pulled from

  https://gitlab.collabora.com/krisman/linux.git -b x86/tif-cleanup-v1

Please, if possible, consider queueing this for the 5.11 merge window,
as this is blocking the Syscall User Dispatch work that has been on the
list for a while.

Gabriel Krisman Bertazi (10):
  x86: Expose syscall_work field in thread_info
  entry: Expose helpers to migrate TIF to SYSCALL_WORK flags
  entry: Wire up syscall_work in common entry code
  seccomp: Migrate to use SYSCALL_WORK flag
  tracepoints: Migrate to use SYSCALL_WORK flag
  ptrace: Migrate to use SYSCALL_TRACE flag
  ptrace: Migrate TIF_SYSCALL_EMU to use SYSCALL_WORK flag
  audit: Migrate to use SYSCALL_WORK flag
  entry: Drop usage of TIF flags in the generic syscall code
  x86: Reclaim unused x86 TI flags

 arch/x86/include/asm/thread_info.h | 11 +-------
 include/asm-generic/syscall.h      | 24 ++++++++++------
 include/linux/entry-common.h       | 44 ++++++++++-------------------
 include/linux/seccomp.h            |  2 +-
 include/linux/thread_info.h        | 44 +++++++++++++++++++++++++++++
 include/linux/tracehook.h          | 17 +++++------
 include/trace/syscall.h            |  6 ++--
 kernel/auditsc.c                   |  4 +--
 kernel/entry/common.c              | 45 +++++++++++++++---------------
 kernel/fork.c                      |  8 +++---
 kernel/ptrace.c                    | 16 +++++------
 kernel/seccomp.c                   |  6 ++--
 kernel/trace/trace_events.c        |  8 +++---
 kernel/tracepoint.c                |  4 +--
 14 files changed, 134 insertions(+), 105 deletions(-)

-- 
2.29.2

