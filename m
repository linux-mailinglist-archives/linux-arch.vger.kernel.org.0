Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB6250D29
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgHYAak (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:30:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:28750 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbgHYAad (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:30:33 -0400
IronPort-SDR: gkdM9hOxviYv5S2PRvDtZvzjDIIFKQqXtvni1clfxx+kf6AxaRK1qESdn+94Cle5RSHVQ8pjGJ
 x4mJ/pwiUJrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="174053256"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="174053256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:30:33 -0700
IronPort-SDR: 67oZwxQgYdJmA+KUqL3mx/insEcOmQz8+Fw2zgB45hu4tE5sq6WVUE5kNs/tmLEdpDBb/61GGS
 r3onGRfXEP3g==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="443429289"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:30:32 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v11 0/9] Control-flow Enforcement: Indirect Branch Tracking, PTRACE
Date:   Mon, 24 Aug 2020 17:26:35 -0700
Message-Id: <20200825002645.3658-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Control-flow Enforcement (CET) is a new Intel processor feature that blocks
return/jump-oriented programming attacks.  Details are in "Intel 64 and
IA-32 Architectures Software Developer's Manual" [1].

This is the second part of CET and enables Indirect Branch Tracking (IBT).
It is built on top of the shadow stack series.

Changes from v9:

- Remove the legacy bitmap arch_prctl() as it is not used by GLIBC anymore.
  Should it be needed in the future, I will re-post the patch separately.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Previous IBT patches v9:

    https://lkml.kernel.org/r/20200205182308.4028-1-yu-cheng.yu@intel.com/

    There have been no major changes since v9, and there is no IBT patches
    v10.

H.J. Lu (4):
  x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
  x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point
  x86/vdso: Insert endbr32/endbr64 to vDSO
  x86: Disallow vsyscall emulation when CET is enabled

Yu-cheng Yu (5):
  x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode Indirect Branch Tracking support
  x86/cet/ibt: Handle signals for Indirect Branch Tracking
  x86/cet/ibt: ELF header parsing for Indirect Branch Tracking
  x86/cet: Add PTRACE interface for CET

 arch/x86/Kconfig                              | 26 +++++++-
 arch/x86/entry/vdso/Makefile                  |  4 ++
 arch/x86/entry/vdso/vdso32/system_call.S      |  3 +
 arch/x86/include/asm/cet.h                    |  3 +
 arch/x86/include/asm/disabled-features.h      |  8 ++-
 arch/x86/include/asm/fpu/regset.h             |  7 ++-
 arch/x86/kernel/cet.c                         | 60 ++++++++++++++++++-
 arch/x86/kernel/cet_prctl.c                   |  8 ++-
 arch/x86/kernel/cpu/common.c                  | 17 ++++++
 arch/x86/kernel/fpu/regset.c                  | 44 ++++++++++++++
 arch/x86/kernel/fpu/signal.c                  |  8 ++-
 arch/x86/kernel/process_64.c                  |  8 +++
 arch/x86/kernel/ptrace.c                      | 16 +++++
 include/uapi/linux/elf.h                      |  1 +
 .../arch/x86/include/asm/disabled-features.h  |  8 ++-
 15 files changed, 208 insertions(+), 13 deletions(-)

-- 
2.21.0

