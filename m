Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2352A373D49
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhEEOMn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 10:12:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57894 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbhEEOMj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 10:12:39 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFZ-003DNA-CP; Wed, 05 May 2021 08:11:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFU-00007y-Mt; Wed, 05 May 2021 08:11:41 -0600
From:   "Eric W. Beiderman" <ebiederm@xmission.com>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  5 May 2021 09:10:57 -0500
Message-Id: <20210505141101.11519-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210505141101.11519-1-ebiederm@xmission.com>
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <20210505141101.11519-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1leIFU-00007y-Mt;;;mid=<20210505141101.11519-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/QXnIVQ6G593CxEvZS6/KauUA3zjfSAPU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1321 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (0.9%), b_tie_ro: 11 (0.8%), parse: 1.61
        (0.1%), extract_message_metadata: 18 (1.3%), get_uri_detail_list: 2.3
        (0.2%), tests_pri_-1000: 19 (1.4%), tests_pri_-950: 1.65 (0.1%),
        tests_pri_-900: 1.40 (0.1%), tests_pri_-90: 54 (4.1%), check_bayes: 52
        (3.9%), b_tokenize: 10 (0.8%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        2.2 (0.2%), b_tok_touch_all: 30 (2.3%), b_finish: 0.92 (0.1%),
        tests_pri_0: 1192 (90.2%), check_dkim_signature: 0.79 (0.1%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 0.35 (0.0%), tests_pri_10:
        4.4 (0.3%), tests_pri_500: 13 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 08/12] signal: Remove __ARCH_SI_TRAPNO
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Now that this define is no longer used remove it from the kernel.

v1: https://lkml.kernel.org/r/m18s4zs7nu.fsf_-_@fess.ebiederm.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/include/uapi/asm/siginfo.h | 2 --
 arch/mips/include/uapi/asm/siginfo.h  | 2 --
 arch/sparc/include/uapi/asm/siginfo.h | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/siginfo.h b/arch/alpha/include/uapi/asm/siginfo.h
index 6e1a2af2f962..e08eae88182b 100644
--- a/arch/alpha/include/uapi/asm/siginfo.h
+++ b/arch/alpha/include/uapi/asm/siginfo.h
@@ -2,8 +2,6 @@
 #ifndef _ALPHA_SIGINFO_H
 #define _ALPHA_SIGINFO_H
 
-#define __ARCH_SI_TRAPNO
-
 #include <asm-generic/siginfo.h>
 
 #endif
diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
index c34c7eef0a1c..8cb8bd061a68 100644
--- a/arch/mips/include/uapi/asm/siginfo.h
+++ b/arch/mips/include/uapi/asm/siginfo.h
@@ -10,9 +10,7 @@
 #ifndef _UAPI_ASM_SIGINFO_H
 #define _UAPI_ASM_SIGINFO_H
 
-
 #define __ARCH_SIGEV_PREAMBLE_SIZE (sizeof(long) + 2*sizeof(int))
-#undef __ARCH_SI_TRAPNO /* exception code needs to fill this ...  */
 
 #define __ARCH_HAS_SWAPPED_SIGINFO
 
diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
index 68bdde4c2a2e..0e7c27522aed 100644
--- a/arch/sparc/include/uapi/asm/siginfo.h
+++ b/arch/sparc/include/uapi/asm/siginfo.h
@@ -8,9 +8,6 @@
 
 #endif /* defined(__sparc__) && defined(__arch64__) */
 
-
-#define __ARCH_SI_TRAPNO
-
 #include <asm-generic/siginfo.h>
 
 
-- 
2.30.1

