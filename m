Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF01634E346
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 10:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhC3Ih5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 04:37:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229633AbhC3Ihh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Mar 2021 04:37:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U8ZEfw168269;
        Tue, 30 Mar 2021 04:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=eCcrISktlAw+3fQ6MCDB0YjZKBw+luCOtXLpGcTzW6E=;
 b=Mx6QIAbgPVZJuqe4x26I4xhtz4IJFm3Mftfv6w65siWW0SR/iJE44kEonVGlKKP2SbTZ
 +SuYDkW4rpOAy5M7NyPbHRQA5SjpzyFyPvyxqVrAZJWq/BvAZgJExzO+y0VSwvqGipKx
 +rTwqOKCUXk+EyG/rU0jPyvIrhWFelshAfDjviO1lgMBqyg0vrdX3bkdVI+VnU2NWgJ4
 ApYXl35P6OsuvOVylpY8pAPV87lyBD389dniMuRleFsELeuY6e9AO3X8u3s90i73wtrR
 0uT0VcS3SwUC7aAGhKt6MWMjhBPyOM2nMN85xcqtOAV8RhdHiblbKtkPPXwSHKQJhzu/ zw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhrv1dp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 04:37:32 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12U8WO28009711;
        Tue, 30 Mar 2021 08:37:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 37huyhahkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 08:37:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12U8b8VZ31261098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 08:37:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9887DAE055;
        Tue, 30 Mar 2021 08:37:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5205DAE04D;
        Tue, 30 Mar 2021 08:37:27 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Mar 2021 08:37:27 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: Is s390's new generic-using syscall code actually correct?
References: <CALCETrUx10uHeD7bckVjL9x7S3LEdH3ZfzUbCMWj9j-=nYp8Wg@mail.gmail.com>
        <your-ad-here.call-01616607308-ext-0852@work.hours>
        <CALCETrXrj563KJP3p2+_GM=wARGDqM_BpRP-AACN8TXK8j4ypQ@mail.gmail.com>
        <yt9dim59oy82.fsf@linux.ibm.com>
Date:   Tue, 30 Mar 2021 10:37:27 +0200
In-Reply-To: <yt9dim59oy82.fsf@linux.ibm.com> (Sven Schnelle's message of
        "Tue, 30 Mar 2021 10:13:49 +0200")
Message-ID: <yt9deefxox4o.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dcgSjmEF5TgIC6wyg5NYKFCZf0398Gsq
X-Proofpoint-ORIG-GUID: dcgSjmEF5TgIC6wyg5NYKFCZf0398Gsq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_02:2021-03-26,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300060
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> Hi Andy,
>
> Andy Lutomirski <luto@kernel.org> writes:
>
>> On Wed, Mar 24, 2021 at 10:39 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>>>
>>> Hi Andy,
>>>
>>> On Sat, Mar 20, 2021 at 08:48:34PM -0700, Andy Lutomirski wrote:
>>> > Hi all-
>>> >
>>> > I'm working on my kentry patchset, and I encountered:
>>> >
>>> > commit 56e62a73702836017564eaacd5212e4d0fa1c01d
>>> > Author: Sven Schnelle <svens@linux.ibm.com>
>>> > Date:   Sat Nov 21 11:14:56 2020 +0100
>>> >
>>> >     s390: convert to generic entry
>>> >
>>> > As part of this work, I was cleaning up the generic syscall helpers,
>>> > and I encountered the goodies in do_syscall() and __do_syscall().
>>> >
>>> > I'm trying to wrap my head around the current code, and I'm rather confused.
>>> >
>>> > 1. syscall_exit_to_user_mode_work() does *all* the exit work, not just
>>> > the syscall exit work.  So a do_syscall() that gets called twice will
>>> > do the loopy part of the exit work (e.g. signal handling) twice.  Is
>>> > this intentional?  If so, why?
>>> >
>>> > 2. I don't understand how this PIF_SYSCALL_RESTART thing is supposed
>>> > to work.  Looking at the code in Linus' tree, if a signal is pending
>>> > and a syscall returns -ERESTARTSYS, the syscall will return back to
>>> > do_syscall().  The work (as in (1)) gets run, calling do_signal(),
>>> > which will notice -ERESTARTSYS and set PIF_SYSCALL_RESTART.
>>> > Presumably it will also push the signal frame onto the stack and aim
>>> > the return address at the svc instruction mentioned in the commit
>>> > message from "s390: convert to generic entry".  Then __do_syscall()
>>> > will turn interrupts back on and loop right back into do_syscall().
>>> > That seems incorrect.
>>> >
>>> > Can you enlighten me?  My WIP tree is here:
>>> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/kentry
>>> >
>>>
>>> For all the details to that change we'd have to wait for Sven, who is back
>>> next week.
>>>
>>> > Here are my changes to s390, and I don't think they're really correct:
>>> >
>>> >
>>> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/diff/arch/s390/kernel/syscall.c?h=x86/kentry&id=58a459922be0fb8e0f17aeaebcb0ac8d0575a62c
>>>
>>> Couple of things: syscall_exit_to_user_mode_prepare is static,
>>> and there is another code path in arch/s390/kernel/traps.c using
>>> enter_from_user_mode/exit_to_user_mode.
>>>
>>> Anyhow I gave your branch a spin and got few new failures on strace test
>>> suite, in particular on restart_syscall test. I'll try to find time to
>>> look into details.
>>
>> I refreshed the branch, but I confess I haven't compile tested it. :)
>>
>> I would guess that the new test case failures are a result of the
>> buggy syscall restart logic.  I think that all of the "restart" cases
>> except execve() should just be removed.  Without my patch, I suspect
>> that signal delivery with -ERESTARTSYS would create the signal frame,
>> do an accidental "restarted" syscall that was a no-op, and then
>> deliver the signal.  With my patch, it may simply repeat the original
>> interrupted signal forever.
>
> PIF_SYSCALL_RESTART is set in arch_do_signal_or_restart(), but only if
> there's no signal handler registered. In that case we don't need a
> signal frame, so that should be fine.
>
> The problem why your branch is not working is that arch_do_signal_or_restart()
> gets called from exit_to_user_mode_prepare(), and that is after the
> check whether PIF_SYSCALL_RESTART is set in __do_syscall().
>
> So i'm wondering how to fix that. x86 simply rewinds the pc, so the
> system call instruction gets re-executed when returning to user
> space. For s390 that doesn't work, as the s390 svc instruction might
> have the syscall number encoded. If we would have to restart a system
> call with restart_systemcall(), we need to change the syscall number to
> __NR_restart_syscall. As we cannot change the hardcoded system call
> number, we somehow need to handle that inside of the kernel.
>
> So i wonder whether we should implement the PIF_SYSCALL_RESTART check in
> entry.S after all the return to user space entry code was run but before
> doing the real swtch back to user space. If PIF_SYSCALL_RESTART is set
> we would then just jump back to the entry code and pretend we came from
> user space.
>
> That would have the benefit that the entry C code looks the same like
> other architectures and that amount of code to add in entry.S shouldn't
> be much.

Thinking about this again i guess this idea won't work because the exit
loop might have scheduled the old process away already...
