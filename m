Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430783AF692
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 22:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhFUUGY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 16:06:24 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58178 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhFUUGY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 16:06:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvQ9O-001vem-HU; Mon, 21 Jun 2021 14:04:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvQ9N-00Aepo-Db; Mon, 21 Jun 2021 14:04:06 -0600
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
Date:   Mon, 21 Jun 2021 15:03:57 -0500
In-Reply-To: <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 21 Jun 2021 12:22:06 -0700")
Message-ID: <87a6njf0ia.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lvQ9N-00Aepo-Db;;;mid=<87a6njf0ia.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xxzvL+2c2HnDdD8EOIbBaeuM2HSOQ4LU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 535 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 8 (1.5%), parse: 1.57 (0.3%),
         extract_message_metadata: 22 (4.1%), get_uri_detail_list: 2.2 (0.4%),
        tests_pri_-1000: 12 (2.3%), tests_pri_-950: 1.62 (0.3%),
        tests_pri_-900: 1.47 (0.3%), tests_pri_-90: 174 (32.6%), check_bayes:
        158 (29.6%), b_tokenize: 9 (1.7%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 4.4 (0.8%), b_tok_touch_all: 130 (24.3%), b_finish: 1.13
        (0.2%), tests_pri_0: 294 (54.9%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 0.91 (0.2%), tests_pri_10:
        2.5 (0.5%), tests_pri_500: 12 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jun 21, 2021 at 11:59 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>>         There's a large mess around do_exit() - we have a bunch of
>> callers all over arch/*; if nothing else, I very much doubt that really
>> want to let tracer play with a thread in the middle of die_if_kernel()
>> or similar.
>
> Right you are.
>
> I'm really beginning to hate ptrace_{event,notify}() and those
> PTRACE_EVENT_xyz things.
>
> I don't even know what uses them, honestly. How very annoying.

Modern strace does.  Modern gdb appears not to.

However strace at least does not read the exit code,
or really appear to care about stopping for PTRACE_EVENT_EXIT.

I completely agree with you that they are very annoying.

> I guess it's easy enough (famous last words) to move the
> ptrace_event() call out of do_exit() and into the actual
> exit/exit_group system calls, and the signal handling path. The paths
> that actually have proper pt_regs.
>
> Looks like sys_exit() and do_group_exit() would be the two places to
> do it (do_group_exit() would handle the signal case and
> sys_group_exit()).

For other ptrace_event calls I am playing with seeing if I can split
them in two.  Like sending a signal.  So that we can have perform all
of the work in get_signal.

I think we can even change exit_group(2) and exit(2) so that (at least
when ptraced) they just send the ``event signal'' and then the signal
handling path handles all of the ptrace stuff.


When I started it was just going to be exit and PTRACE_EVENT_EXIT and
some old architectures, and that a generic solution was going to be
hard.

I still think we are going to need to fix the io_uring threads on the
architectures that use the caller saved register optimization like alpha
and m68k.  But I think we can handle the rest in generic code.

Eric
