Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2B4351BC
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhJTRrz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40680 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhJTRrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:55456)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeS-00GD3B-6r; Wed, 20 Oct 2021 11:45:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeQ-001NdN-NK; Wed, 20 Oct 2021 11:45:19 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 Oct 2021 12:44:00 -0500
Message-Id: <20211020174406.17889-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeQ-001NdN-NK;;;mid=<20211020174406.17889-14-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19L3CN+Bm0VN8CY3eg1B9cZck2JU8CWhww=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 557 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 15 (2.6%), b_tie_ro: 13 (2.4%), parse: 1.56
        (0.3%), extract_message_metadata: 34 (6.1%), get_uri_detail_list: 3.8
        (0.7%), tests_pri_-1000: 54 (9.7%), tests_pri_-950: 1.67 (0.3%),
        tests_pri_-900: 1.38 (0.2%), tests_pri_-90: 130 (23.3%), check_bayes:
        122 (21.8%), b_tokenize: 13 (2.4%), b_tok_get_all: 10 (1.7%),
        b_comp_prob: 4.2 (0.7%), b_tok_touch_all: 90 (16.1%), b_finish: 1.08
        (0.2%), tests_pri_0: 306 (55.0%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 3.2 (0.6%), poll_dns_idle: 0.47 (0.1%), tests_pri_10:
        1.89 (0.3%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 14/20] exit/syscall_user_dispatch: Send ordinary signals on failure
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use force_fatal_sig instead of calling do_exit directly.  This ensures
the ordinary signal handling path gets invoked, core dumps as
appropriate get created, and for multi-threaded processes all of the
threads are terminated not just a single thread.

When asked Gabriel Krisman Bertazi <krisman@collabora.com> said [1]:
> ebiederm@xmission.com (Eric W. Biederman) asked:
>
> > Why does do_syscal_user_dispatch call do_exit(SIGSEGV) and
> > do_exit(SIGSYS) instead of force_sig(SIGSEGV) and force_sig(SIGSYS)?
> >
> > Looking at the code these cases are not expected to happen, so I would
> > be surprised if userspace depends on any particular behaviour on the
> > failure path so I think we can change this.
>
> Hi Eric,
>
> There is not really a good reason, and the use case that originated the
> feature doesn't rely on it.
>
> Unless I'm missing yet another problem and others correct me, I think
> it makes sense to change it as you described.
>
> > Is using do_exit in this way something you copied from seccomp?
>
> I'm not sure, its been a while, but I think it might be just that.  The
> first prototype of SUD was implemented as a seccomp mode.

If at some point it becomes interesting we could relax
"force_fatal_sig(SIGSEGV)" to instead say
"force_sig_fault(SIGSEGV, SEGV_MAPERR, sd->selector)".

I avoid doing that in this patch to avoid making it possible
to catch currently uncatchable signals.

Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
[1] https://lkml.kernel.org/r/87mtr6gdvi.fsf@collabora.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/entry/syscall_user_dispatch.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index c240302f56e2..4508201847d2 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -47,14 +47,18 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 		 * access_ok() is performed once, at prctl time, when
 		 * the selector is loaded by userspace.
 		 */
-		if (unlikely(__get_user(state, sd->selector)))
-			do_exit(SIGSEGV);
+		if (unlikely(__get_user(state, sd->selector))) {
+			force_fatal_sig(SIGSEGV);
+			return true;
+		}
 
 		if (likely(state == SYSCALL_DISPATCH_FILTER_ALLOW))
 			return false;
 
-		if (state != SYSCALL_DISPATCH_FILTER_BLOCK)
-			do_exit(SIGSYS);
+		if (state != SYSCALL_DISPATCH_FILTER_BLOCK) {
+			force_fatal_sig(SIGSYS);
+			return true;
+		}
 	}
 
 	sd->on_dispatch = true;
-- 
2.20.1

