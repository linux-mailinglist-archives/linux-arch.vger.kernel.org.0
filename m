Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E83AA5C2
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 22:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhFPU7g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 16:59:36 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52468 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhFPU7f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 16:59:35 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltcbG-00ATlW-UN; Wed, 16 Jun 2021 14:57:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltcbF-00HDkM-UZ; Wed, 16 Jun 2021 14:57:26 -0600
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
        <CAHk-=whvNaYffE8Eaa4-jjYbF_r1u1sh5LF5zXFhdEP8hxySMQ@mail.gmail.com>
Date:   Wed, 16 Jun 2021 15:57:19 -0500
In-Reply-To: <CAHk-=whvNaYffE8Eaa4-jjYbF_r1u1sh5LF5zXFhdEP8hxySMQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 16 Jun 2021 13:37:29 -0700")
Message-ID: <878s398r4g.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltcbF-00HDkM-UZ;;;mid=<878s398r4g.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/LF91xWCnMbfZu757yY8QEIXk7UwFgnxc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 436 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.4%), b_tie_ro: 9 (2.1%), parse: 0.91 (0.2%),
         extract_message_metadata: 11 (2.6%), get_uri_detail_list: 1.14 (0.3%),
         tests_pri_-1000: 15 (3.4%), tests_pri_-950: 1.20 (0.3%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 149 (34.3%), check_bayes:
        148 (33.9%), b_tokenize: 7 (1.7%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 127 (29.2%), b_finish: 0.90
        (0.2%), tests_pri_0: 234 (53.7%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 0.95 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of switch_stack
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jun 16, 2021 at 1:00 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> And even for debugging, I think it would be both easier and cheaper to
>> just add a magic word to the entry stack instead.
>
> IOW, just add a
>
>       unsigned long magic;
>
> to "struct switch_stack", and then make the stack switch code push that value.
>
> That would be cheap enough to be just unconditional, but you could
> make it depend on a debug config option too, of course.
>
> It helps if 'xyz' is some constant that is easyish to generate. It
> might not be a constant - maybe it could be the address of that
> 'magic' field itself, so you'd just generate it with
>
>     stq $r,($r)
>
> and it would be equally easy to just validate at lookup for that WARN_ON_ONCE():
>
>     WARN_ON_ONCE(switch_stack->magic != (unsigned long)&switch_stack->magic);
>
> or whatever.
>
> It's for debugging, not security. So it doesn't have to be some kind
> of super-great magic number, just something easy to generate and check
> (that isn't a common value like "0" that trivially exist on the stack
> anyway).

Fair enough.

I was thinking for a moment that do_sigreturn might have a problem with
that but restore_sigcontext makes it clear that struct switch_stack is
not exposed to userspace.

Do you know if struct switch_stack or pt_regs is ever exposeed to
usespace?  They are both defined in arch/alpha/include/uapi/asm/ptrace.h
which makes me think userspace must see those definitions somewhere.

Eric
