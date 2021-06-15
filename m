Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A213A8986
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 21:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOTeD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 15:34:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53420 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOTeC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 15:34:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltEmu-007YGd-82; Tue, 15 Jun 2021 13:31:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltEmt-00FC9o-1T; Tue, 15 Jun 2021 13:31:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
In-Reply-To: <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> (Michael
        Schmitz's message of "Tue, 15 Jun 2021 10:26:33 +1200")
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
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 15 Jun 2021 14:30:59 -0500
Message-ID: <87fsxjorgs.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltEmt-00FC9o-1T;;;mid=<87fsxjorgs.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18kd161ANp8gAbkjGsKS094xb9QyLKgQ0I=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Michael Schmitz <schmitzmic@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 610 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.9%), b_tie_ro: 10 (1.6%), parse: 1.54
        (0.3%), extract_message_metadata: 4.6 (0.8%), get_uri_detail_list:
        1.70 (0.3%), tests_pri_-1000: 4.8 (0.8%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.14 (0.2%), tests_pri_-90: 188 (30.7%), check_bayes:
        186 (30.5%), b_tokenize: 8 (1.4%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 164 (26.8%), b_finish: 0.87
        (0.1%), tests_pri_0: 379 (62.2%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.81 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 6 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> Hi Eric,
>
> On 15/06/21 4:26 am, Eric W. Biederman wrote:
>> Michael Schmitz <schmitzmic@gmail.com> writes:
>>
>>> On second thought, I'm not certain what adding another empty stack frame would
>>> achieve here.
>>>
>>> On m68k, 'frame' already is a new stack frame, for running the new thread
>>> in. This new frame does not have any user context at all, and it's explicitly
>>> wiped anyway.
>>>
>>> Unless we save all user context on the stack, then push that context to a new
>>> save frame, and somehow point get_signal to look there for IO threads
>>> (essentially what Eric suggested), I don't see how this could work?
>>>
>>> I must be missing something.
>> It is only designed to work well enough so that ptrace will access
>> something well defined when ptrace accesses io_uring tasks.
>>
>> The io_uring tasks are special in that they are user process
>> threads that never run in userspace.  So as long as everything
>> ptrace can read is accessible on that process all is well.
> OK, I'm testing a patch that would save extra context in sys_io_uring_setup,
> which ought to ensure that for m68k.

I had to update ret_from_kernel_thread to pop that state to get Linus's
change to boot.  Apparently kernel_threads exiting needs to be handled.

>> Having stared a bit longer at the code I think the short term
>> fix for both of PTRACE_EVENT_EXIT and io_uring is to guard
>> them both with CONFIG_HAVE_ARCH_TRACEHOOK.

Which does not work because nios2 which looks susceptible
sets CONFIG_HAVE_ARCH_TRACEHOOK.

A further look shows that there is also PTRACE_EVENT_EXEC that
needs to be handled so execve and execveat need to be wrapped
as well.

Do you happen to know if there is userspace that will run
in qemu-system-m68k that can be used for testing?

Eric

