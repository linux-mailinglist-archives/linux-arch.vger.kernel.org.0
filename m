Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37DD278B80
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgIYO6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 10:58:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:47916 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgIYO6O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Sep 2020 10:58:14 -0400
IronPort-SDR: G4GEr9bvc6t349AnG1us96uc09AB6Ix7j7ZXzj8WH6QyvIjSFsf8Do1LMZYGZMpdpBrWnPjDjo
 Tx1+Wm/bbjUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="225704474"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="225704474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:58:13 -0700
IronPort-SDR: URjgH0tF0D7TmKiW7s0Aj70ANXXmQDg/X2UeRBd2M/oHM/QpX6i8r0ifdPafqs1Tv4Binh7PPH
 jxdvhJJ53usw==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="512916953"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:58:13 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v13 0/8] Control-flow Enforcement: Indirect Branch Tracking
Date:   Fri, 25 Sep 2020 07:57:56 -0700
Message-Id: <20200925145804.5821-1-yu-cheng.yu@intel.com>
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

Changes in v13:
- Drop the patch that disables vsyscall emulation when CET is enabled, and
  re-introduce an earlier patch that fixes shadow stack and IBT for the
  emulation code.
- Remove "INTEL" string from CET Kconfig options, update help text, and
  change IBT default configuration to N.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Indirect Branch Tracking patches v12.

    https://lkml.kernel.org/r/20200918192312.25978-1-yu-cheng.yu@intel.com/

H.J. Lu (3):
  x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
  x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point
  x86/vdso: Insert endbr32/endbr64 to vDSO

Yu-cheng Yu (5):
  x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode Indirect Branch Tracking support
  x86/cet/ibt: Handle signals for Indirect Branch Tracking
  x86/cet/ibt: ELF header parsing for Indirect Branch Tracking
  x86/vsyscall/64: Fixup Shadow Stack and Indirect Branch Tracking for
    vsyscall emulation

 arch/x86/Kconfig                              | 21 +++++++
 arch/x86/entry/vdso/Makefile                  |  4 ++
 arch/x86/entry/vdso/vdso32/system_call.S      |  3 +
 arch/x86/entry/vsyscall/vsyscall_64.c         | 34 +++++++++++
 arch/x86/entry/vsyscall/vsyscall_emu_64.S     |  9 +++
 arch/x86/entry/vsyscall/vsyscall_trace.h      |  1 +
 arch/x86/include/asm/cet.h                    |  3 +
 arch/x86/include/asm/disabled-features.h      |  8 ++-
 arch/x86/kernel/cet.c                         | 60 ++++++++++++++++++-
 arch/x86/kernel/cet_prctl.c                   |  8 ++-
 arch/x86/kernel/cpu/common.c                  | 17 ++++++
 arch/x86/kernel/fpu/signal.c                  |  8 ++-
 arch/x86/kernel/process_64.c                  |  8 +++
 .../arch/x86/include/asm/disabled-features.h  |  8 ++-
 14 files changed, 184 insertions(+), 8 deletions(-)

-- 
2.21.0

