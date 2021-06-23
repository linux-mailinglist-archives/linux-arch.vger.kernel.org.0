Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE93B1C9F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFWOhL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 10:37:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50778 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWOhK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Jun 2021 10:37:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lw3xr-00DZwe-3m; Wed, 23 Jun 2021 08:34:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lw3xp-001cBY-Vq; Wed, 23 Jun 2021 08:34:50 -0600
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
Date:   Wed, 23 Jun 2021 09:33:50 -0500
In-Reply-To: <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 22 Jun 2021 17:41:51 -0700")
Message-ID: <87zgvgabw1.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lw3xp-001cBY-Vq;;;mid=<87zgvgabw1.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19bOZKovoM2dTCNa4FoP/ARdkEwpSg1W4M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
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
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 533 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (2.3%), b_tie_ro: 10 (1.9%), parse: 1.01
        (0.2%), extract_message_metadata: 16 (3.0%), get_uri_detail_list: 1.41
        (0.3%), tests_pri_-1000: 23 (4.4%), tests_pri_-950: 1.38 (0.3%),
        tests_pri_-900: 1.22 (0.2%), tests_pri_-90: 75 (14.1%), check_bayes:
        73 (13.6%), b_tokenize: 6 (1.2%), b_tok_get_all: 14 (2.6%),
        b_comp_prob: 3.0 (0.6%), b_tok_touch_all: 44 (8.2%), b_finish: 1.42
        (0.3%), tests_pri_0: 390 (73.2%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 3.3 (0.6%), poll_dns_idle: 1.45 (0.3%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jun 22, 2021 at 1:53 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Playing with it some more I think I have everything working working
>> except for PTRACE_EVENT_SECCOMP (which can stay ptrace_event) and
>> group_exit(2).
>>
>> Basically in exit sending yourself a signal and then calling do_exit
>> from the signal handler is not unreasonable, as exit is an ordinary
>> system call.
>
> Ok, this is a bit odd, but I do like the concept of just making
> ptrace_event just post a signal, and have all ptrace things always be
> handled at signal time (or the special system call entry/exit, which
> is fine too).
>
>> For purposes of discussion this is my current draft implementation.
>
> I didn't check what is so different about exit_group() that you left
> that as an exercise for the reader, but if that ends up then removing
> the whole "wait synchromously for ptrace" cases for good I don't
> _hate_ this. It's a bit odd, but it would be really nice to limit
> where ptrace picks up data.

I am still figuring out exit_group.  I am hoping for sometime today.
My intuition tells me I can do it, and I have a sense of what threads I
need to pull to get there.  I just don't know what the code is going to
look like yet.

Basically solving exit_group means moving ptrace_event out of do_exit.

> We do end up doing that stuff in "get_signal()", and that means that
> we have the interaction with io_uring calling it directly, but it's at
> least not a new thing.

The ugliest bit is having to repeat the wait_for_vfork_done both in fork
and in get_signal.

Eric
