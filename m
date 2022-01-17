Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB211491071
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 19:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiAQSq7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 13:46:59 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59742 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAQSq6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 13:46:58 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:45246)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9X1s-005F9h-PW; Mon, 17 Jan 2022 11:46:57 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:49256 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9X1r-003jNu-BN; Mon, 17 Jan 2022 11:46:56 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Olivier Langlois <olivier@trillion01.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211213225350.27481-1-ebiederm@xmission.com>
        <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
        <87sfu3b7wm.fsf@email.froward.int.ebiederm.org>
        <YdniQob7w5hTwB1v@osiris>
        <87ilurwjju.fsf@email.froward.int.ebiederm.org>
        <87o84juwhg.fsf@email.froward.int.ebiederm.org>
        <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
        <87lezmrxlq.fsf@email.froward.int.ebiederm.org>
        <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
        <87h7a5kgan.fsf@email.froward.int.ebiederm.org>
        <991211d94c6dc0ad3501cd9f830cdee916b982b3.camel@trillion01.com>
        <87ee56e43r.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 17 Jan 2022 12:46:48 -0600
In-Reply-To: <87ee56e43r.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 17 Jan 2022 10:09:28 -0600")
Message-ID: <87v8yi8ajr.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n9X1r-003jNu-BN;;;mid=<87v8yi8ajr.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/YV6/Vvn8jXg8frZWqyokYAqL1kRlGwVk=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Olivier Langlois <olivier@trillion01.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 466 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (3.2%), b_tie_ro: 13 (2.7%), parse: 1.27
        (0.3%), extract_message_metadata: 13 (2.9%), get_uri_detail_list: 1.36
        (0.3%), tests_pri_-1000: 6 (1.2%), tests_pri_-950: 1.41 (0.3%),
        tests_pri_-900: 1.22 (0.3%), tests_pri_-90: 81 (17.4%), check_bayes:
        79 (16.9%), b_tokenize: 6 (1.4%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 55 (11.9%), b_finish: 1.29
        (0.3%), tests_pri_0: 333 (71.4%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 1.31 (0.3%), tests_pri_10:
        2.5 (0.5%), tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: io_uring truncating coredumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Subject updated to reflect the current discussion.

> Linus Torvalds <torvalds@linux-foundation.org> writes:

> But I really think it's wrong.
> 
> You're trying to work around a problem the wrong way around. If a task
> is dead, and is dumping core, then signals just shouldn't matter in
> the first place, and thus the whole "TASK_INTERRUPTIBLE vs
> TASK_UNINTERRUPTIBLE" really shouldn't be an issue. The fact that it
> is an issue means there's something wrong in signaling, not in the
> pipe code.
> 
> So I really think that's where the fix should be - on the signal delivery side.

Thinking about it from the perspective of not delivering the wake-ups
fixing io_uring and coredumps in a non-hacky way looks comparatively
simple.  The function task_work_add just needs to not wake anything up
after a process has started dying.

Something like the patch below.

The only tricky part I can see is making certain there are not any races
between task_work_add and do_coredump depending on task_work_add not
causing signal_pending to return true.

diff --git a/kernel/task_work.c b/kernel/task_work.c
index fad745c59234..5f941e377268 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -44,6 +44,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		work->next = head;
 	} while (cmpxchg(&task->task_works, head, work) != head);
 
+	if (notify && (task->signal->flags & SIGNAL_GROUP_EXIT))
+		return 0;
+
 	switch (notify) {
 	case TWA_NONE:
 		break;

Eric
