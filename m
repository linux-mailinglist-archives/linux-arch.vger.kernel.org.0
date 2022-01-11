Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F327348B61D
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 19:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbiAKSvy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 11 Jan 2022 13:51:54 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:43654 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbiAKSvx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 13:51:53 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:41480)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7MFM-0064vi-Bf; Tue, 11 Jan 2022 11:51:52 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:34256 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7MFK-00EYmx-4x; Tue, 11 Jan 2022 11:51:51 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Olivier Langlois <olivier@trillion01.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Date:   Tue, 11 Jan 2022 12:51:43 -0600
In-Reply-To: <87lezmrxlq.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 11 Jan 2022 11:28:01 -0600")
Message-ID: <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1n7MFK-00EYmx-4x;;;mid=<87mtk2qf5s.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/sAY0EBan+5IxNXdYAQEe8V39Z5bYE1WY=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Olivier Langlois <olivier@trillion01.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 530 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.34
        (0.3%), extract_message_metadata: 17 (3.3%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-1000: 22 (4.1%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 64 (12.2%), check_bayes:
        63 (11.9%), b_tokenize: 9 (1.7%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 2.7 (0.5%), b_tok_touch_all: 38 (7.2%), b_finish: 0.89
        (0.2%), tests_pri_0: 398 (75.1%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.45 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Olivier Langlois <olivier@trillion01.com> writes:
>
>> On Mon, 2022-01-10 at 15:11 -0600, Eric W. Biederman wrote:
>>> 
>>> 
>>> I have been able to confirm that changing wait_event_interruptible to
>>> wait_event_killable was the culprit.  Something about the way
>>> systemd-coredump handles coredumps is not compatible with
>>> wait_event_killable.
>>
>> This is my experience too that systemd-coredump is doing something
>> unexpected. When I tested the patch:
>> https://lore.kernel.org/lkml/cover.1629655338.git.olivier@trillion01.com/
>>
>> to make sure that the patch worked, sending coredumps to systemd-
>> coredump was making systemd-coredump, well, core dump... Not very
>> useful...
>
> Oh.  Wow....
>
>> Sending the dumps through a pipe to anything else than systemd-coredump
>> was working fine.
>
> Interesting.
>
> I need to read through the pipe code and see how all of that works.  For
> writing directly to disk only ignoring killable interruptions are the
> usual semantics.  Ordinary pipe code has different semantics, and I
> suspect that is what is tripping things up.
>
> As for systemd-coredump it does whatever it does and I suspect some
> versions of systemd-coredump are simply not robust if a coredump stops
> unexpectedly.
>
> The good news is the pipe code is simple enough, it will be possible to
> completely read through that code.

My bug, obvious in hindsight is that "try_to_wait_up(TASK_INTERRUPTIBLE)"
does not work on a task that is in sleeping in TASK_KILLABLE.
That looks fixable in wait_for_dump_helpers it just won't be as easy
as changing wait_event_interruptible to wait_event_killable.

To prevent short pipe write from causing short writes during a coredump
I believe all we need to do handle -ERSTARTSYS with TIF_NOTIFY_SIGNAL.
Something like what I have below.

Until wait_for_dump_helpers is sorted out the coredump won't wait for
the dump helper the way it should, but otherwise things should work.

diff --git a/fs/coredump.c b/fs/coredump.c
index 7dece20b162b..0db1baf91420 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -796,6 +796,10 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	if (dump_interrupted())
 		return 0;
 	n = __kernel_write(file, addr, nr, &pos);
+	while ((n == -ERESTARTSYS) && test_thread_flag(TIF_NOTIFY_SIGNAL)) {
+		tracehook_notify_signal();
+		n = __kernel_write(file, addr, nr, &pos);
+	}
 	if (n != nr)
 		return 0;
 	file->f_pos = pos;

Eric
