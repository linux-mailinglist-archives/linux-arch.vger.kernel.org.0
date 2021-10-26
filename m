Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FBD43AB6B
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 06:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhJZEs3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Oct 2021 00:48:29 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47510 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhJZEs2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Oct 2021 00:48:28 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:35452)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mfELc-00ATX9-JC; Mon, 25 Oct 2021 22:46:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:34936 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mfELb-004bCG-Is; Mon, 25 Oct 2021 22:46:04 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-13-ebiederm@xmission.com>
        <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
        <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org>
        <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
Date:   Mon, 25 Oct 2021 23:45:23 -0500
In-Reply-To: <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 25 Oct 2021 16:15:44 -0700")
Message-ID: <87o87ctmvw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mfELb-004bCG-Is;;;mid=<87o87ctmvw.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18a6D5O+YrTECRKk40/H4Oj2815LtR98b0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4920]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 382 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 5.0 (1.3%), b_tie_ro: 3.5 (0.9%), parse: 1.14
        (0.3%), extract_message_metadata: 11 (2.9%), get_uri_detail_list: 2.6
        (0.7%), tests_pri_-1000: 10 (2.6%), tests_pri_-950: 1.04 (0.3%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 56 (14.7%), check_bayes:
        55 (14.3%), b_tokenize: 6 (1.6%), b_tok_get_all: 9 (2.4%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 34 (8.8%), b_finish: 0.79
        (0.2%), tests_pri_0: 285 (74.6%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.25 (0.1%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Oct 25, 2021 at 3:41 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> I'm rather nervous about all this, and I'm also nervous about the
>> existing code.  A quick skim is finding plenty of code paths that assume
>> force_sigsegv (or a do_exit that this series touches) are genuinely
>> unrecoverable.
>
> I was going to say "what are you talking about", because clearly Eric
> kept it all fatal.
>
> But then looked at that patch a bit more before I claimed you were wrong.
>
> And yeah, Eric's force_fatal_sig() is completely broken.
>
> It claims to force a fatal signal, but doesn't actually do that at
> all, and is completely misnamed.
>
> It just uses "force_sig_info_to_task()", which still allows user space
> to catch signals - so it's not "fatal" in the least. It only punches
> through SIG_IGN and blocked signals.
>
> So yeah, that's broken.
>
> I do still think that that could the behavior we possibly want for
> that "can't write updated vm86 state back" situation, but for
> something that is called "fatal", it really needs to be fatal.

Once the code gets as far as force_sig_info_to_task the only
bit that is really missing is to make the signals fatal is:

diff --git a/kernel/signal.c b/kernel/signal.c
index 6a5e1802b9a2..fde043f1e59d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1048,7 +1048,6 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
                /*
                 * This signal will be fatal to the whole group.
                 */
-               if (!sig_kernel_coredump(sig)) {
                        /*
                         * Start a group exit and wake everybody up.
                         * This way we don't have other threads
@@ -1065,7 +1064,6 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
                                signal_wake_up(t, 1);
                        } while_each_thread(p, t);
                        return;
-               }
        }
 
        /*

AKA the only real bit missing is the interaction with the coredump code.

Now we can't just delete sig_kernel_coredump a replacement has to be
written.   And the easiest replacement depends on my other set of
changes that are already in linux-next to make coredumps per
signal_struct instead of per mm.

Which means that in a release or two force_fatal_sig will reliably do
what the name says.




So the question is: Should I name force_fatal_sig to something else in
the meantime?  What should I name it?




I do intend to fix that bit in complete_signal, as well as updating the
code in force_siginfo_to_task so that it doesn't need to change the
blocked state or the signal handler.

These special cases have been annoying me for years and now Andy has
found how they are actually hurting us.  So I do intend to fix that code
as quickly as being careful and code review allows.  Which I think means
one additional development cycle after this one.

Eric

