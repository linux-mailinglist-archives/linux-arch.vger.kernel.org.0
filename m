Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E641DD942
	for <lists+linux-arch@lfdr.de>; Thu, 21 May 2020 23:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgEUVRi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 17:17:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:63538 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUVRi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 17:17:38 -0400
IronPort-SDR: uds8W+vMqX510KuLiMysfPrhV1xuFnbuQz3t8aBcTbn7HASsz5murp+07KaqShQyi1tBKQw38r
 KKm5mUyfOrGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 14:17:37 -0700
IronPort-SDR: m6oSK0QqnCy8iuARIOKXpyNhnlkfm9AYnpNWX/bVcxPdVBY1OOEMK9syEBvp+wyfHPU07sLfOU
 H5RCbW6fk+1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="440623118"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2020 14:17:36 -0700
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
Subject: [RFC PATCH 0/5] Update selftests/x86 for CET
Date:   Thu, 21 May 2020 14:17:15 -0700
Message-Id: <20200521211720.20236-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When CET is enabled for selftests/x86, two tests need updates.

- The test 'sigreturn_64' does a sigreturn() from a 64-bit context into a
  32-bit context.  The task's 64-bit shadow stack pointer certainly
  triggers a fault.  Fix it by allocating and switching to a new shadow
  stack in the 32-bit address range.

  The arch_ptrcl(ARCH_X86_CET_ALLOC_SHSTK) is updated for taking a bit from
  the input parameter to indicate the desire of MAP_32BIT.  I am proposing
  this change to minimize API changes, but open to any alternatives.

- The test 'sysret_rip' fails because the assembly code needs ENDBR
  opcodes.  Fix it by adding just that.  My latest CET submission (v10)
  does not include the IBT patches.  My purpose of posting this now is to
  show the changes needed in x86 tests.  Since ENDBR is nop when IBT is not
  enabled, this patch can be applied now or split out and merged with the
  IBT patches.

- The makefile changes add "-fcf-protection -mshstk" to the gcc command,
  when those are available.

- Introduce cet_quick_test that checks the system's CET capabilities.

This series is based on my CET series:

https://lore.kernel.org/lkml/20200429220732.31602-2-yu-cheng.yu@intel.com/

Yu-cheng Yu (5):
  x86/cet/shstk: Modify ARCH_X86_CET_ALLOC_SHSTK for 32-bit address
    range
  selftest/x86: Enable CET for selftests/x86
  selftest/x86: Fix sigreturn_64 test.
  selftest/x86: Fix sysret_rip with ENDBR
  selftest/x86: Add CET quick test

 arch/x86/include/asm/cet.h                   |   2 +-
 arch/x86/include/uapi/asm/prctl.h            |   2 +
 arch/x86/kernel/cet.c                        |  19 ++-
 arch/x86/kernel/cet_prctl.c                  |   6 +-
 tools/testing/selftests/x86/Makefile         |   7 +-
 tools/testing/selftests/x86/cet_quick_test.c | 128 +++++++++++++++++++
 tools/testing/selftests/x86/sigreturn.c      |  28 ++++
 tools/testing/selftests/x86/sysret_rip.c     |   5 +-
 8 files changed, 185 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/x86/cet_quick_test.c

-- 
2.21.0

