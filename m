Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62273B68CA
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhF1TGC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 15:06:02 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33324 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhF1TGA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 15:06:00 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:48296)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxwXY-00FZtO-Fr; Mon, 28 Jun 2021 13:03:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:38704 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxwXX-00Gdx8-9L; Mon, 28 Jun 2021 13:03:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
        <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
Date:   Mon, 28 Jun 2021 14:02:50 -0500
In-Reply-To: <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Thu, 24 Jun 2021 22:45:23 +0000")
Message-ID: <87v95xx15x.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lxwXX-00Gdx8-9L;;;mid=<87v95xx15x.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JERu3BMiKmUMjDvvelGV7aJUlVNLWdXI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 577 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (2.4%), b_tie_ro: 12 (2.0%), parse: 0.98
        (0.2%), extract_message_metadata: 13 (2.2%), get_uri_detail_list: 1.59
        (0.3%), tests_pri_-1000: 9 (1.5%), tests_pri_-950: 1.33 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 194 (33.7%), check_bayes:
        190 (33.0%), b_tokenize: 7 (1.2%), b_tok_get_all: 10 (1.7%),
        b_comp_prob: 3.1 (0.5%), b_tok_touch_all: 164 (28.5%), b_finish: 1.53
        (0.3%), tests_pri_0: 330 (57.2%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 3.1 (0.5%), poll_dns_idle: 0.90 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 8 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/9] Refactoring exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Thu, Jun 24, 2021 at 01:57:35PM -0500, Eric W. Biederman wrote:
>
>> So far the code has been lightly tested, and the descriptions of some
>> of the patches are a bit light, but I think this shows the direction
>> I am aiming to travel for sorting out exit(2) and exit_group(2).
>
> FWIW, here's the current picture for do_exit(), aside of exit(2) and do_exit_group():
>
> 1) stuff that is clearly oops-like -
>         alpha:die_if_kernel() alpha:do_entUna() alpha:do_page_fault() arm:oops_end()
>         arm:__do_kernel_fault() arm64:die() arm64:die_kernel_fault() csky:alignment()
>         csky:die() csky:no_context() h8300:die() h8300:do_page_fault() hexagon:die()
>         ia64:die() i64:ia64_do_page_fault() m68k:die_if_kernel() m68k:send_fault_sig()
>         microblaze:die() mips:die() nds32:handle_fpu_exception() nds32:die()
>         nds32:unhandled_interruption() nds32:unhandled_exceptions() nds32:do_revinsn()
>         nds32:do_page_fault() nios:die() openrisc:die() openrisc:do_page_fault()
>         parisc:die_if_kernel() ppc:oops_end() riscv:die() riscv:die_kernel_fault()
>         s390:die() s390:do_no_context() s390:do_low_address() sh:die()
>         sparc32:die_if_kernel() sparc32:do_sparc_fault() sparc64:die_if_kernel()
>         x86:rewind_stack_do_exit() xtensa:die() xtensa:bad_page_fault()
> We really do not want ptrace anywhere near any of those and we do not want
> any of that to return; this shit would better be handled right there and
> there - no "post a fatal signal" would do.

Thanks that makes a good start for digging into these.

I think the distinction I would make is:
- If the kernel is broken use do_task_dead.
- Otherwise cleanup the semantics by using start_group_exit,
  start_task_exit or by just cleaning up the code.
  

Looking at the reboot case it looks like we the code
should have become do_group_exit in 2.5.  I have a suspicion
we have a bunch of similar cases that want to terminate the
entire process, but we simply never updated to deal with
multi-thread processes.

I suspect in the reboot case panic if machine_halt or
or machine_power_off fails is more likely the correct
handling.  But we do have funny semantics sometimes.

I will see what I can do to expand my patchset to handle all of these
various callers of do_exit.

Eric
