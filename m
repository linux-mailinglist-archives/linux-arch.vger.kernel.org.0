Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8001243AB7E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 06:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhJZFAW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Oct 2021 01:00:22 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49286 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhJZFAV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Oct 2021 01:00:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:38974)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mfEX7-00AUu3-5c; Mon, 25 Oct 2021 22:57:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:35654 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mfEX5-004cZ3-Rk; Mon, 25 Oct 2021 22:57:56 -0600
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
Date:   Mon, 25 Oct 2021 23:57:48 -0500
In-Reply-To: <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 25 Oct 2021 16:15:44 -0700")
Message-ID: <87v91kqt6b.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mfEX5-004cZ3-Rk;;;mid=<87v91kqt6b.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19a1ttFBgDkVF1Z/7Vr8GwQ7bJkka56CnU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4960]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 683 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (1.8%), b_tie_ro: 11 (1.5%), parse: 1.11
        (0.2%), extract_message_metadata: 28 (4.1%), get_uri_detail_list: 2.6
        (0.4%), tests_pri_-1000: 20 (2.9%), tests_pri_-950: 1.83 (0.3%),
        tests_pri_-900: 1.58 (0.2%), tests_pri_-90: 330 (48.3%), check_bayes:
        328 (48.0%), b_tokenize: 9 (1.4%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 3.1 (0.5%), b_tok_touch_all: 302 (44.3%), b_finish: 1.30
        (0.2%), tests_pri_0: 269 (39.4%), check_dkim_signature: 0.81 (0.1%),
        check_dkim_adsp: 3.1 (0.5%), poll_dns_idle: 1.07 (0.2%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 11 (1.6%), rewrite_mail: 0.00 (0.0%)
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

Rereading this I think you might be misreading something.

force_siginfo_to_task takes a sigdfl parameter which I am setting in
force_fatal_signal.

When that sigdfl paramter is set force_siginfo_to_task always changes
the signal handler to SIGDFL, and always unblocks the signal.

Because the siglock remains held over send_signal none of those
properties can change during send_signal.  Which means that as long
as we are not talking about a coredump signal complete_signal is
guaranteed to recognize the signal as fatal immediately.

For coredump signals there is a race where siglock is dropped before
get_signal is called that could result in the signal handler being
changed or the signal being blocked.  Which is why I pointed out the
problem is coredumps.

But assuming userspace does not change something in that narrow window
the signal will most definitely be fatal to the target process.

Just as soon as I know if we can have per signal_struct coredumps
without causing regressions I will close the final race.  I can do it
either way but the code is much less complicated with per signal_struct
coredumps.

Hoisting the current zap_threads from fs/coredump.c into complete_signal
is a pain and a half.  While just the per_signal struct part is already
there, and the code just needs a few tweaks to allow get_signal to act
as the coredump rendezvous location.

Eric
