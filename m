Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C6D3B38D9
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jun 2021 23:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhFXVk1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 17:40:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59776 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXVk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 17:40:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:34726)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwX2z-008su7-FE; Thu, 24 Jun 2021 15:38:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:51012 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwX2y-003iue-41; Thu, 24 Jun 2021 15:38:05 -0600
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
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>
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
        <87y2az5bmt.fsf_-_@disp2133>
        <CAHk-=wg16ZBqtLngzE2edV8e68Qxje2kFehnKTrBBe5opcsj-w@mail.gmail.com>
Date:   Thu, 24 Jun 2021 16:37:19 -0500
In-Reply-To: <CAHk-=wg16ZBqtLngzE2edV8e68Qxje2kFehnKTrBBe5opcsj-w@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 24 Jun 2021 13:11:18 -0700")
Message-ID: <87a6nf54hc.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwX2y-003iue-41;;;mid=<87a6nf54hc.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18LalAUym3BX/fF3gpKr2RXYRq1CIkZYD0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 368 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (3.0%), b_tie_ro: 10 (2.6%), parse: 0.98
        (0.3%), extract_message_metadata: 16 (4.2%), get_uri_detail_list: 1.16
        (0.3%), tests_pri_-1000: 26 (7.2%), tests_pri_-950: 1.31 (0.4%),
        tests_pri_-900: 1.10 (0.3%), tests_pri_-90: 63 (17.2%), check_bayes:
        61 (16.7%), b_tokenize: 8 (2.1%), b_tok_get_all: 8 (2.3%),
        b_comp_prob: 2.6 (0.7%), b_tok_touch_all: 39 (10.6%), b_finish: 0.99
        (0.3%), tests_pri_0: 236 (64.3%), check_dkim_signature: 0.66 (0.2%),
        check_dkim_adsp: 3.0 (0.8%), poll_dns_idle: 0.85 (0.2%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 7/9] signal: Make individual tasks exiting a first class concept.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jun 24, 2021 at 12:03 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Implement start_task_exit_locked and rewrite the de_thread logic
>> in exec using it.
>>
>> Calling start_task_exit_locked is equivalent to asyncrhonously
>> calling exit(2) aka pthread_exit on a task.
>
> Ok, so this is the patch that makes me go "Yeah, this seems to all go together".
>
> The whole "start_exit()" thing seemed fairly sane as an interesting
> concept to the whole ptrace notification thing, but this one actually
> made me think it makes conceptual sense and how we had exactly that
> "start exit asynchronously" case already in zap_other_threads().
>
> So doing that zap_other_threads() as that async exit makes me just
> thin kthat yes, this series is the right thing, because it not only
> cleans up the ptrace condition, it makes sense in this entirely
> unrelated area too.
>
> So I think I'm convinced. I'd like Oleg in particular to Ack this
> series, and Al to look it over, but I do think this is the right
> direction.

Thanks.

It took a bit of exploration and playing with things to get here,
but I had the same sense.

Next round I will see if I can clean up the patches a bit more.

Eric
