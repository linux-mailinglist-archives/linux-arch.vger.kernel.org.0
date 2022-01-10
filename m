Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483F4489BC5
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 16:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiAJPFc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 10:05:32 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:40872 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiAJPFc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 10:05:32 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:49390)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6wEk-009CRL-Um; Mon, 10 Jan 2022 08:05:31 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:44010 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6wEj-009w8V-MM; Mon, 10 Jan 2022 08:05:30 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-6-ebiederm@xmission.com>
        <YdelKq9U86/dHPcm@zeniv-ca.linux.org.uk>
        <87mtk6xegz.fsf@email.froward.int.ebiederm.org>
        <YdpWHgJBwEF/21hR@zeniv-ca.linux.org.uk>
Date:   Mon, 10 Jan 2022 09:05:22 -0600
In-Reply-To: <YdpWHgJBwEF/21hR@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Sun, 9 Jan 2022 03:27:26 +0000")
Message-ID: <87a6g3y6kt.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n6wEj-009w8V-MM;;;mid=<87a6g3y6kt.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19fb8lVHdQfx0COisiixMKefnJNcBkrZ5g=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 706 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 10 (1.4%), parse: 1.35
        (0.2%), extract_message_metadata: 15 (2.1%), get_uri_detail_list: 1.50
        (0.2%), tests_pri_-1000: 11 (1.5%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 96 (13.6%), check_bayes:
        94 (13.3%), b_tokenize: 8 (1.1%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 3.5 (0.5%), b_tok_touch_all: 70 (9.9%), b_finish: 0.98
        (0.1%), tests_pri_0: 549 (77.8%), check_dkim_signature: 0.79 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 13 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 06/10] exit: Implement kthread_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sat, Jan 08, 2022 at 12:35:40PM -0600, Eric W. Biederman wrote:
>
>> There are kernel threads started by modules that do:
>> 	complete(...);
>>         return 0;
>> 
>> That should be at a minimum calling complete_and_exit.  Possibly should
>> be restructured to use kthread_stop().
>> 
>> Some of those users of the now removed thread_exit() in staging are
>> among the offenders.
>> 
>> However thread_exit() was implemented as:
>> 	#define thread_exit() complete_and_exit(NULL, 0)
>> 
>> Which does nothing with a completion, it was just a really funny way to
>> spell "do_exit(0)".
>
> Yes.  And there's a plenty of cargo-culting in that area.
>  
>> While I agree digging through all of the kernel threads and finding the
>> ones that should be calling complete_and_exit is a fine idea.  It is
>> a concern independent of these patches.
>
> BTW, could somebody explain how could this
> /*
>  * Prevent the kthread exits directly, and make sure when kthread_stop()
>  * is called to stop a kthread, it is still alive. If a kthread might be
>  * stopped by CACHE_SET_IO_DISABLE bit set, wait_for_kthread_stop() is
>  * necessary before the kthread returns.
>  */
> static inline void wait_for_kthread_stop(void)
> { 
>         while (!kthread_should_stop()) {
>                 set_current_state(TASK_INTERRUPTIBLE);
>                 schedule();
>         }
> } 
>
> in drivers/md/bcache/bcache.h possibly avoid losing wakeups?
>
> AFAICS, it can be called while in TASK_RUNNING.  Suppose kthread_stop()
> gets called just after the check for kthread_should_stop().  Our thread
> is still in TASK_RUNNING; kthread_stop() sets the flag for the next
> kthread_should_stop() to observe and does wake_up_process() to our
> thread.  Which does nothing.  Now our thread goes into TASK_INTERRUPTIBLE
> and calls schedule().  Sure, as soon as it gets woken up it'll call
> kthread_should_stop(), get true from it and that's it.  What's going
> to wake it up, though?
>
> The same goes for e.g. fs/btrfs/disk-io.c:cleaner_kthread():
>                 if (kthread_should_stop())
>                         return 0;
>                 if (!again) {
>                         set_current_state(TASK_INTERRUPTIBLE);
>                         schedule();
>                         __set_current_state(TASK_RUNNING);
>                 }
> can't be right.  Similar fun exists in e.g. fs/jfs, etc.
>
> Am I missing something?

Those examples look as suspect to me as they do to you.

Eric

