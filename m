Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2F37E5A
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfFFURj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 16:17:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:42894 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729512AbfFFURj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:17:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 13:17:30 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2019 13:17:29 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 00/14] Control-flow Enforcement: Branch Tracking, PTRACE
Date:   Thu,  6 Jun 2019 13:09:12 -0700
Message-Id: <20190606200926.4029-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The previous version of CET Branch Tracking/PTRACE patches is here:

  https://lkml.org/lkml/2018/11/20/203

Summary of changes from v6:

  Rebase to v5.2-rc3.

  Add Branch Tracking in the signal handling routines.

  Fix Branch Tracking (and Shadow Stack) for vsyscall (patch #12):
    This patch can be dropped if we expect CET blocking vsyscall.

  Include H.J. Lu's patch to discard .note.gnu.property in the kernel.

H.J. Lu (4):
  x86/vdso: Insert endbr32/endbr64 to vDSO
  x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point
  x86/vsyscall/64: Add ENDBR64 to vsyscall entry points
  x86: Discard .note.gnu.property sections

Yu-cheng Yu (10):
  x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode indirect branch tracking support
  x86/cet/ibt: Add IBT legacy code bitmap setup function
  x86/cet/ibt: Handle signals for IBT
  mm/mmap: Add IBT bitmap size to address space limit check
  x86/cet/ibt: ELF header parsing for IBT
  x86/cet/ibt: Add arch_prctl functions for IBT
  x86/cet/ibt: Add ENDBR to op-code-map
  x86/vsyscall/64: Fixup shadow stack and branch tracking for vsyscall
  x86/cet: Add PTRACE interface for CET

 arch/x86/Kconfig                              | 16 ++++
 arch/x86/Makefile                             |  7 ++
 arch/x86/entry/vdso/Makefile                  | 12 ++-
 arch/x86/entry/vdso/vdso-layout.lds.S         |  1 +
 arch/x86/entry/vdso/vdso32/system_call.S      |  3 +
 arch/x86/entry/vsyscall/vsyscall_64.c         | 28 +++++++
 arch/x86/entry/vsyscall/vsyscall_emu_64.S     |  9 +++
 arch/x86/include/asm/cet.h                    |  8 ++
 arch/x86/include/asm/disabled-features.h      |  8 +-
 arch/x86/include/asm/fpu/regset.h             |  7 +-
 arch/x86/include/asm/mmu_context.h            | 10 +++
 arch/x86/include/uapi/asm/prctl.h             |  2 +
 arch/x86/kernel/cet.c                         | 80 +++++++++++++++++++
 arch/x86/kernel/cet_prctl.c                   | 21 +++++
 arch/x86/kernel/cpu/common.c                  | 17 ++++
 arch/x86/kernel/fpu/regset.c                  | 41 ++++++++++
 arch/x86/kernel/process_64.c                  |  6 ++
 arch/x86/kernel/ptrace.c                      | 16 ++++
 arch/x86/kernel/vmlinux.lds.S                 | 11 ++-
 arch/x86/lib/x86-opcode-map.txt               | 13 ++-
 include/uapi/linux/elf.h                      |  1 +
 mm/mmap.c                                     | 19 ++++-
 .../arch/x86/include/asm/disabled-features.h  |  8 +-
 tools/objtool/arch/x86/lib/x86-opcode-map.txt | 13 ++-
 24 files changed, 345 insertions(+), 12 deletions(-)

-- 
2.17.1

