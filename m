Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC23703BE
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 00:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhD3Wv0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 18:51:26 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58832 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhD3Wv0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Apr 2021 18:51:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcby1-00CRJD-1J; Fri, 30 Apr 2021 16:50:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcby0-0003Er-5p; Fri, 30 Apr 2021 16:50:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
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
        kasan-dev <kasan-dev@googlegroups.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
Date:   Fri, 30 Apr 2021 17:50:32 -0500
In-Reply-To: <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 30 Apr 2021 17:49:45 -0500")
Message-ID: <m1tunns7yf.fsf_-_@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lcby0-0003Er-5p;;;mid=<m1tunns7yf.fsf_-_@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Yarb9/ltgjgzGllxki6uzGX9RRVA0vaU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_XMDrugObfuBody_08,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4938]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 397 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.6 (1.2%), b_tie_ro: 3.3 (0.8%), parse: 1.13
        (0.3%), extract_message_metadata: 12 (2.9%), get_uri_detail_list: 2.3
        (0.6%), tests_pri_-1000: 11 (2.8%), tests_pri_-950: 0.98 (0.2%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 64 (16.0%), check_bayes:
        62 (15.7%), b_tokenize: 7 (1.8%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 1.59 (0.4%), b_tok_touch_all: 45 (11.3%), b_finish: 0.68
        (0.2%), tests_pri_0: 290 (73.1%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 2.6 (0.7%), poll_dns_idle: 1.24 (0.3%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/3] siginfo: Move si_trapno inside the union inside _si_fault
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


It turns out that linux uses si_trapno very sparingly, and as such it
can be considered extra information for a very narrow selection of
signals, rather than information that is present with every fault
reported in siginfo.

As such move si_trapno inside the union inside of _si_fault.  This
results in no change in placement, and makes it eaiser to extend
_si_fault in the future as this reduces the number of special cases.
In particular with si_trapno included in the union it is no longer a
concern that the union must be pointer alligned on most architectures
because the union followes immediately after si_addr which is a
pointer.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/compat.h             | 4 +---
 include/uapi/asm-generic/siginfo.h | 6 +-----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f0d2dd35d408..24462ed63af4 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -214,12 +214,10 @@ typedef struct compat_siginfo {
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
 		struct {
 			compat_uptr_t _addr;	/* faulting insn/memory ref. */
-#ifdef __ARCH_SI_TRAPNO
-			int _trapno;	/* TRAP # which caused the signal */
-#endif
 #define __COMPAT_ADDR_BND_PKEY_PAD  (__alignof__(compat_uptr_t) < sizeof(short) ? \
 				     sizeof(short) : __alignof__(compat_uptr_t))
 			union {
+				int _trapno;	/* TRAP # which caused the signal */
 				/*
 				 * used when si_code=BUS_MCEERR_AR or
 				 * used when si_code=BUS_MCEERR_AO
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 03d6f6d2c1fe..2abdf1d19aad 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -63,9 +63,6 @@ union __sifields {
 	/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
 	struct {
 		void __user *_addr; /* faulting insn/memory ref. */
-#ifdef __ARCH_SI_TRAPNO
-		int _trapno;	/* TRAP # which caused the signal */
-#endif
 #ifdef __ia64__
 		int _imm;		/* immediate value for "break" */
 		unsigned int _flags;	/* see ia64 si_flags */
@@ -75,6 +72,7 @@ union __sifields {
 #define __ADDR_BND_PKEY_PAD  (__alignof__(void *) < sizeof(short) ? \
 			      sizeof(short) : __alignof__(void *))
 		union {
+			int _trapno;	/* TRAP # which caused the signal */
 			/*
 			 * used when si_code=BUS_MCEERR_AR or
 			 * used when si_code=BUS_MCEERR_AO
@@ -150,9 +148,7 @@ typedef struct siginfo {
 #define si_int		_sifields._rt._sigval.sival_int
 #define si_ptr		_sifields._rt._sigval.sival_ptr
 #define si_addr		_sifields._sigfault._addr
-#ifdef __ARCH_SI_TRAPNO
 #define si_trapno	_sifields._sigfault._trapno
-#endif
 #define si_addr_lsb	_sifields._sigfault._addr_lsb
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
-- 
2.30.1

