Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023BC3B3671
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jun 2021 21:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhFXTCx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 15:02:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59072 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXTCw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 15:02:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:47220)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUaW-008eEM-5B; Thu, 24 Jun 2021 13:00:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47074 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwUaU-003RZx-84; Thu, 24 Jun 2021 13:00:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
Date:   Thu, 24 Jun 2021 14:00:22 -0500
In-Reply-To: <875yy3850g.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 24 Jun 2021 13:57:35 -0500")
Message-ID: <87lf6z6qbd.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwUaU-003RZx-84;;;mid=<87lf6z6qbd.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19jB/askomOw8mCNdMyrXPaKVH+zkQz15E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1332 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (0.9%), b_tie_ro: 10 (0.7%), parse: 1.01
        (0.1%), extract_message_metadata: 12 (0.9%), get_uri_detail_list: 0.82
        (0.1%), tests_pri_-1000: 14 (1.1%), tests_pri_-950: 1.56 (0.1%),
        tests_pri_-900: 1.18 (0.1%), tests_pri_-90: 729 (54.8%), check_bayes:
        727 (54.6%), b_tokenize: 6 (0.5%), b_tok_get_all: 7 (0.5%),
        b_comp_prob: 2.9 (0.2%), b_tok_touch_all: 705 (53.0%), b_finish: 1.75
        (0.1%), tests_pri_0: 540 (40.5%), check_dkim_signature: 0.57 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 0.51 (0.0%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 16 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/9] signal/seccomp: Dump core when there is only one live thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Replace get_nr_threads with atomic_read(&current->signal->live) as
that is a more accurate number that is decremented sooner.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3e06d4628d98..5301eca670a0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1241,7 +1241,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		seccomp_log(this_syscall, SIGSYS, action, true);
 		/* Dump core only if this is the last remaining thread. */
 		if (action != SECCOMP_RET_KILL_THREAD ||
-		    get_nr_threads(current) == 1) {
+		    (atomic_read(&current->signal->live) == 1)) {
 			/* Show the original registers in the dump. */
 			syscall_rollback(current, current_pt_regs());
 			/* Trigger a coredump with SIGSYS */
-- 
2.20.1

