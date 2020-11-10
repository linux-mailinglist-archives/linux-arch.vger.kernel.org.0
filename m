Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53912ADC0A
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 17:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgKJQZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 11:25:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:63840 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732725AbgKJQZE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 11:25:04 -0500
IronPort-SDR: XLjkQnPvR1UHIQFWdctXrSxa8k0DTyygeeMnbwRv1KsuPjqiNIXtcDdsu5/oNvJ108Mhy6SuqM
 lQ1y/KZvuepA==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="149278311"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="149278311"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:25:02 -0800
IronPort-SDR: Rlg+98E3D0zvrpO8W9IDHJlIzwCXgco7nrYFOSoWHHWa0JP2giWKG0O9ihCdAfeE79xuu4SYb3
 tXibfJ1vAMYw==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="308469023"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:25:02 -0800
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
Subject: [PATCH v15 0/7] Control-flow Enforcement: Indirect Branch Tracking
Date:   Tue, 10 Nov 2020 08:24:41 -0800
Message-Id: <20201110162448.9846-1-yu-cheng.yu@intel.com>
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

Changes in v15:
- Rebase to v5.10-rc3.
- Remove changes to tools/arch/x86/include/ files.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Indirect Branch Tracking patches v14:

    https://lkml.kernel.org/r/20201012154530.28382-1-yu-cheng.yu@intel.com/

H.J. Lu (3):
  x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
  x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point
  x86/vdso: Insert endbr32/endbr64 to vDSO

Yu-cheng Yu (4):
  x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode Indirect Branch Tracking support
  x86/cet/ibt: Handle signals for Indirect Branch Tracking
  x86/cet/ibt: ELF header parsing for Indirect Branch Tracking

 arch/x86/Kconfig                         | 21 +++++++++
 arch/x86/entry/vdso/Makefile             |  4 ++
 arch/x86/entry/vdso/vdso32/system_call.S |  3 ++
 arch/x86/include/asm/cet.h               |  3 ++
 arch/x86/include/asm/disabled-features.h |  8 +++-
 arch/x86/kernel/cet.c                    | 60 +++++++++++++++++++++++-
 arch/x86/kernel/cet_prctl.c              |  8 +++-
 arch/x86/kernel/cpu/common.c             | 17 +++++++
 arch/x86/kernel/fpu/signal.c             |  8 ++--
 arch/x86/kernel/process_64.c             |  8 ++++
 10 files changed, 133 insertions(+), 7 deletions(-)

-- 
2.21.0

