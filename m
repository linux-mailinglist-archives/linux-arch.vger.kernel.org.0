Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA593AA57E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhFPUpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 16:45:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56806 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhFPUpJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 16:45:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltcND-000wZU-Bn; Wed, 16 Jun 2021 14:42:56 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltcNC-001U5E-8W; Wed, 16 Jun 2021 14:42:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
References: <87sg1p30a1.fsf@disp2133>
        <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
        <87pmwsytb3.fsf@disp2133>
        <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133>
        <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
        <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133>
        <87k0mtek4n.fsf_-_@disp2133>
        <CAHk-=wiTEZN_3ipf51sh-csdusW4uGzAXq9m1JcMHu_c8OJ+pQ@mail.gmail.com>
Date:   Wed, 16 Jun 2021 15:42:05 -0500
In-Reply-To: <CAHk-=wiTEZN_3ipf51sh-csdusW4uGzAXq9m1JcMHu_c8OJ+pQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 16 Jun 2021 13:00:52 -0700")
Message-ID: <87czsla6ea.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltcNC-001U5E-8W;;;mid=<87czsla6ea.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19cp4yLb9sESwklHZupra9p6ENsPqWdcfE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 541 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.7%), b_tie_ro: 2.7 (0.5%), parse: 0.62
        (0.1%), extract_message_metadata: 9 (1.7%), get_uri_detail_list: 0.91
        (0.2%), tests_pri_-1000: 17 (3.2%), tests_pri_-950: 0.91 (0.2%),
        tests_pri_-900: 0.79 (0.1%), tests_pri_-90: 269 (49.7%), check_bayes:
        267 (49.4%), b_tokenize: 5 (1.0%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 1.49 (0.3%), b_tok_touch_all: 251 (46.4%), b_finish: 0.73
        (0.1%), tests_pri_0: 230 (42.5%), check_dkim_signature: 0.34 (0.1%),
        check_dkim_adsp: 1.56 (0.3%), poll_dns_idle: 0.31 (0.1%),
        tests_pri_10: 1.62 (0.3%), tests_pri_500: 5 (1.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of switch_stack
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jun 16, 2021 at 11:32 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Prevent security holes by recording when all of the registers are
>> available so generic code changes do not result in security holes
>> on alpha.
>
> Please no, not this way. ldl/stc is extremely expensive on some alpha cpus.
>
> I really think thatTIF_ALLREGS_SAVED bit isn't worth it, except
> perhaps for debugging.
>
> And even for debugging, I think it would be both easier and cheaper to
> just add a magic word to the entry stack instead.

I think I can do something like that.

Looking at arch/alpha/asm/cache.h it looks like alpha had either 32byte
or 64bit cachelines.  Which makes struct switch_stack a full 10 or 5
cachelines in size.  So pushing something extra might hit an extra
cacheline.

However it looks like struct pt_regs is 16 bytes short of a full cache
line so struct switch_stack isn't going to be cacheline aligned. Adding
an extra 8 bytes of magic number will hopefully be in the noise.

If I can I would like to find something that is cheap enough that I can
always leave on.  Mostly because there is little enough testing that a
bug that allows anyone to stomp the kernel stack has existed for 17 years
without being noticed.

If you want it to be a debug option only I can certainly make that
happen.  I am still going "Eek! Arbitrary stack smash!" in my head.

Eric
