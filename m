Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF80133D705
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 16:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhCPPRr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 11:17:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:18965 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236013AbhCPPRI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 11:17:08 -0400
IronPort-SDR: wJqnzQQa2YAknybRRxZEYsKhfAInLgoSJTSj+Te9nDpQUquI2ndiZjs/i3CIK+Su9Uw3d6fkaS
 woJb2EGVzLyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274320146"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="274320146"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:13:26 -0700
IronPort-SDR: IqQnowSIiUmzhkvbINxygMGAqof4v93N73/CesmNU6qqg4NirfR9vG9rAfoSRL413pkv+rNROU
 C4+e+pVwZZzQ==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449748967"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:13:25 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v23 0/9] Control-flow Enforcement: Indirect Branch Tracking
Date:   Tue, 16 Mar 2021 08:13:10 -0700
Message-Id: <20210316151320.6123-1-yu-cheng.yu@intel.com>
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

Changes in v23:
- Add patch #6: introduce a macro for ENDBR instructions.
- Patch #7: replace endbr32 with ENDBR macro.
- Patch #9: revise, add/replace endbr64 with ENDBR macro.
- Rebase to Linus tree v5.12-rc3.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Indirect Branch Tracking patches v22:

    https://lore.kernel.org/r/20210310220519.16811-1-yu-cheng.yu@intel.com/

H.J. Lu (3):
  x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
  x86/vdso/32: Add ENDBR to __kernel_vsyscall entry point
  x86/vdso: Insert endbr32/endbr64 to vDSO

Yu-cheng Yu (6):
  x86/cet/ibt: Update Kconfig for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode Indirect Branch Tracking support
  x86/cet/ibt: Handle signals for Indirect Branch Tracking
  x86/cet/ibt: Update ELF header parsing for Indirect Branch Tracking
  x86/entry: Introduce ENDBR macro
  x86/vdso: Add ENDBR to __vdso_sgx_enter_enclave

 arch/x86/Kconfig                         |  1 +
 arch/x86/entry/calling.h                 | 18 ++++++++
 arch/x86/entry/vdso/Makefile             |  4 ++
 arch/x86/entry/vdso/vdso32/system_call.S |  2 +
 arch/x86/entry/vdso/vsgx.S               |  4 ++
 arch/x86/include/asm/cet.h               |  3 ++
 arch/x86/kernel/cet.c                    | 59 +++++++++++++++++++++++-
 arch/x86/kernel/cet_prctl.c              |  5 ++
 arch/x86/kernel/fpu/signal.c             |  8 ++--
 arch/x86/kernel/process_64.c             |  8 ++++
 10 files changed, 107 insertions(+), 5 deletions(-)

-- 
2.21.0

