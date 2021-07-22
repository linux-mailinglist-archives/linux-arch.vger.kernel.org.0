Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200C93D2E80
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhGVURa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 16:17:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:15252 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230429AbhGVUR3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 16:17:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211800503"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="211800503"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:58:03 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="433273355"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:58:03 -0700
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v28 00/10] Control-flow Enforcement: Indirect Branch Tracking
Date:   Thu, 22 Jul 2021 13:57:13 -0700
Message-Id: <20210722205723.9476-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Control-flow Enforcement (CET) is a new Intel processor feature that blocks
return/jump-oriented programming attacks.  Details are in "Intel 64 and
IA-32 Architectures Software Developer's Manual" [1].

This is the second part of CET and enables Indirect Branch Tracking (IBT).
It is built on top of the shadow stack series.

Changes in v28:
- Patch #10: Update change log and comments.

Changes in v27:
- Use a ucontext flag to save/restore IBT status.
- Disable IBT support for IA32.
- Rebase to Linus tree v5.13-rc2.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Indirect Branch Tracking patches v27:

    https://lore.kernel.org/r/20210521221531.30168-1-yu-cheng.yu@intel.com/

H.J. Lu (3):
  x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
  x86/vdso: Insert endbr32/endbr64 to vDSO
  x86/vdso/32: Add ENDBR to __kernel_vsyscall entry point

Yu-cheng Yu (7):
  x86/cet/ibt: Add Kconfig option for Indirect Branch Tracking
  x86/cet/ibt: Add user-mode Indirect Branch Tracking support
  x86/cet/ibt: Handle signals for Indirect Branch Tracking
  x86/cet/ibt: Disable IBT for ia32
  x86/cet/ibt: Update ELF header parsing for Indirect Branch Tracking
  x86/vdso: Introduce ENDBR macro
  x86/vdso: Add ENDBR to __vdso_sgx_enter_enclave

 arch/x86/Kconfig                         | 19 +++++
 arch/x86/entry/vdso/Makefile             |  4 +
 arch/x86/entry/vdso/vdso32/system_call.S |  2 +
 arch/x86/entry/vdso/vsgx.S               |  4 +
 arch/x86/ia32/ia32_signal.c              | 22 +++++-
 arch/x86/include/asm/cet.h               | 13 ++++
 arch/x86/include/asm/disabled-features.h |  8 +-
 arch/x86/include/asm/elf.h               | 13 +++-
 arch/x86/include/asm/vdso.h              | 20 ++++-
 arch/x86/include/uapi/asm/ucontext.h     |  5 ++
 arch/x86/kernel/Makefile                 |  1 +
 arch/x86/kernel/cet_prctl.c              |  5 ++
 arch/x86/kernel/ibt.c                    | 99 ++++++++++++++++++++++++
 arch/x86/kernel/process_64.c             |  6 ++
 arch/x86/kernel/signal.c                 |  6 ++
 15 files changed, 221 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/kernel/ibt.c

-- 
2.21.0

