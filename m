Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B85C1DD955
	for <lists+linux-arch@lfdr.de>; Thu, 21 May 2020 23:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgEUVRy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 17:17:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:63538 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbgEUVRj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 17:17:39 -0400
IronPort-SDR: /ek/8oJ2V+Ltw3KMk1I/+FAoQj59DINL0yzUmoD4t+EIH2wdB1OPGk1Me83exn4Vw17FOhTmU7
 EAUWEz3xCzcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 14:17:39 -0700
IronPort-SDR: LMcmLIjfXH1Ol3DfgbCZO8bv/J1Ew2eZIEWo6FYj3IZl16trrDepmgIeWwt0zp/Y7d9mQmYCDG
 kwaWSRMtT35Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="440623127"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2020 14:17:38 -0700
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
Subject: [RFC PATCH 2/5] selftest/x86: Enable CET for selftests/x86
Date:   Thu, 21 May 2020 14:17:17 -0700
Message-Id: <20200521211720.20236-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200521211720.20236-1-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To build CET-enabled applications, GCC needs to support '-fcf-protection'.
Update x86 selftest makefile to detect and enable CET for x86 selftest
applications.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 tools/testing/selftests/x86/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5d49bfec1e9a..f1bf5ab87160 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -9,6 +9,7 @@ UNAME_M := $(shell uname -m)
 CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
+CAN_BUILD_CET := $(shell ./check_cc.sh $(CC) trivial_program.c -fcf-protection)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
@@ -35,6 +36,10 @@ BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
 
+ifeq ($(CAN_BUILD_CET),1)
+CFLAGS += -fcf-protection -mshstk
+endif
+
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
 CFLAGS += -no-pie
-- 
2.21.0

