Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E367A1BAC5A
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgD0SWG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 14:22:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51866 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgD0SWF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 14:22:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT8OJ-0004rR-An; Mon, 27 Apr 2020 12:22:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT8OI-0004R2-7f; Mon, 27 Apr 2020 12:22:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20200426130100.306246-1-hagen@jauu.net>
        <20200426163430.22743-1-hagen@jauu.net>
        <20200427170826.mdklazcrn4xaeafm@wittgenstein>
        <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
Date:   Mon, 27 Apr 2020 13:18:47 -0500
In-Reply-To: <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
        (Jann Horn's message of "Mon, 27 Apr 2020 19:52:45 +0200")
Message-ID: <87zhawdc6w.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jT8OI-0004R2-7f;;;mid=<87zhawdc6w.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+9SAR66VQWu+9JEUBTAwQ1jTB8c0BBpeI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_08 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 643 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 11 (1.8%), b_tie_ro: 10 (1.5%), parse: 1.36
        (0.2%), extract_message_metadata: 16 (2.4%), get_uri_detail_list: 3.3
        (0.5%), tests_pri_-1000: 16 (2.6%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 173 (26.9%), check_bayes:
        171 (26.6%), b_tokenize: 12 (1.9%), b_tok_get_all: 84 (13.1%),
        b_comp_prob: 4.5 (0.7%), b_tok_touch_all: 65 (10.1%), b_finish: 0.96
        (0.1%), tests_pri_0: 408 (63.4%), check_dkim_signature: 0.81 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.51 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 9 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> On Mon, Apr 27, 2020 at 7:08 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
>> On Sun, Apr 26, 2020 at 06:34:30PM +0200, Hagen Paul Pfeifer wrote:
>> > Working on a safety-critical stress testing tool, using ptrace in an
>> > rather uncommon way (stop, peeking memory, ...) for a bunch of
>> > applications in an automated way I realized that once opened processes
>> > where restarted and PIDs recycled.  Resulting in monitoring and
>> > manipulating the wrong processes.
>> >
>> > With the advent of pidfd we are now able to stick with one stable handle
>> > to identifying processes exactly. We now have the ability to get this
>> > race free. Sending signals now works like a charm, next step is to
>> > extend the functionality also for ptrace.
>> >
>> > API:
>> >          long pidfd_ptrace(int pidfd, enum __ptrace_request request,
>> >                            void *addr, void *data, unsigned flags);
>>
>> I'm in general not opposed to this if there's a clear need for this and
>> users that are interested. But I think if people really prefer having
>> this a new syscall then we should probably try to improve on the old
>> one. Things that come to mind right away without doing a deep review are
>> replacing the void *addr pointer with a dedicated struct ptract_args or
>> union ptrace_args and a size argument. If we're not doing something
>> like this or something more fundamental we can equally well either just
>> duplicate all enums in the old ptrace syscall and append a _PIDFD to it
>> where it makes sense.
>
> Yeah, it seems like just adding pidfd flavors of PTRACE_ATTACH and
> PTRACE_SEIZE should do the job.

I am conflicted about that but I have to agree.    Instead of
duplicating everything it would be good enough to duplicate the once
that cause the process to be attached to use.  Then there would be no
more pid races to worry about.

> And if we do make a new syscall, there is a bunch of de-crufting that
> can be done... for example, just as some low-hanging fruit, a new
> ptrace API probably shouldn't have
> PTRACE_PEEKTEXT/PTRACE_PEEKDATA/PTRACE_POKETEXT/PTRACE_POKEDATA (we
> have /proc/$pid/mem for that, which is much saner than doing peek/poke
> in word-size units), and probably also shouldn't support all the weird
> arch-specific register-accessing requests (e.g.
> PTRACE_PEEKUSR/PTRACE_POKEUSR/PTRACE_GETREGS/PTRACE_SETREGS/PTRACE_GETFPREGS/...)
> that are nowadays accessible via PTRACE_GETREGSET/PTRACE_SETREGSET.


> (And there are also some more major changes that I think would be
> sensible; for example, it'd be neat if you could have notifications
> about the tracee delivered through a pollable file descriptor, and if
> you could get the kernel to tell you in each notification which type
> of ptrace stop you're dealing with (e.g. distinguishing
> syscall-entry-stop vs syscall-exit-stop), and it would be great to be
> able to directly inject syscalls into the child instead of having to
> figure out where a syscall instruction you can abuse is and then
> setting the instruction pointer to that, and it'd be helpful to be
> able to have multiple tracers attached to a single process so that you
> can e.g. have strace and gdb active on the same process
> concurrently...)

How does this differ using the tracing related infrastructure we have
for the kernel on a userspace process?  I suspect augmenting the tracing
infrastructure with the ability to set breakpoints and watchpoints (aka
stopping userspace threads and processes might be a more fertile
direction to go).

But I agree either we want to just address the races in PTRACE_ATTACH
and PTRACE_SIEZE or we want to take a good hard look at things.

There is a good case for minimal changes because one of the cases that
comes up is how much work will it take to change existing programs.  But
ultimately ptrace pretty much sucks so a very good set of test cases and
documentation for what we want to implement would be a very good idea.

Eric


