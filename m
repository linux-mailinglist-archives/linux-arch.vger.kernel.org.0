Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5262234E2E7
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhC3IOD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 04:14:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231269AbhC3IN7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Mar 2021 04:13:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U868DR155168;
        Tue, 30 Mar 2021 04:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=Tx0vTlJrzzEHRPOxY5i6He5735ZUbCWKAXaebQPSpZ8=;
 b=nd5IwqAx8aOlSSlRdze32E1Kwv4GWqUj8mkPweiNQlcHzQD6YDqJmACtWE46AC16wHll
 gRJ9y+V0qdZ+9D/iUTPzML908TX8c6r4DHO26XPV9gdIlsaRZ2tY4jxP2A47nWeG+qfS
 uez6ALcA+O3hntZwGPX0BHBufYSGcVgCz/Ef//7XLSWUPpeYgWRN2yEkJqhKbm+6KYQR
 O5bT52ZIGUbrcmrwgv9lhQMy8tJjzaIuojTXAtSf7yLAyFSp1R8MwwKMXjrn3cYDZLZ0
 7BC53XxCXQKwuqjBE99//KZxGaIhTTtrF38Ou15xpI1EKLPXBtywvtyrQ4MPQzg/5saU Hw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37jj60stbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 04:13:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12U8CYxm007647;
        Tue, 30 Mar 2021 08:13:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 37hvb8jged-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 08:13:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12U8Dnbp27132394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 08:13:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96EA7AE053;
        Tue, 30 Mar 2021 08:13:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EABAAE04D;
        Tue, 30 Mar 2021 08:13:49 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Mar 2021 08:13:49 +0000 (GMT)
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
Date:   Tue, 30 Mar 2021 10:13:49 +0200
In-Reply-To: <CALCETrXrj563KJP3p2+_GM=wARGDqM_BpRP-AACN8TXK8j4ypQ@mail.gmail.com>
        (Andy Lutomirski's message of "Wed, 24 Mar 2021 11:06:54 -0700")
Message-ID: <yt9dim59oy82.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YGR-Fnr690GZm7djAbElDBVuN559izJ8
X-Proofpoint-ORIG-GUID: YGR-Fnr690GZm7djAbElDBVuN559izJ8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_02:2021-03-26,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103300055
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andy,

Andy Lutomirski <luto@kernel.org> writes:

> On Wed, Mar 24, 2021 at 10:39 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>>
>> Hi Andy,
>>
>> On Sat, Mar 20, 2021 at 08:48:34PM -0700, Andy Lutomirski wrote:
>> > Hi all-
>> >
>> > I'm working on my kentry patchset, and I encountered:
>> >
>> > commit 56e62a73702836017564eaacd5212e4d0fa1c01d
>> > Author: Sven Schnelle <svens@linux.ibm.com>
>> > Date:   Sat Nov 21 11:14:56 2020 +0100
>> >
>> >     s390: convert to generic entry
>> >
>> > As part of this work, I was cleaning up the generic syscall helpers,
>> > and I encountered the goodies in do_syscall() and __do_syscall().
>> >
>> > I'm trying to wrap my head around the current code, and I'm rather confused.
>> >
>> > 1. syscall_exit_to_user_mode_work() does *all* the exit work, not just
>> > the syscall exit work.  So a do_syscall() that gets called twice will
>> > do the loopy part of the exit work (e.g. signal handling) twice.  Is
>> > this intentional?  If so, why?
>> >
>> > 2. I don't understand how this PIF_SYSCALL_RESTART thing is supposed
>> > to work.  Looking at the code in Linus' tree, if a signal is pending
>> > and a syscall returns -ERESTARTSYS, the syscall will return back to
>> > do_syscall().  The work (as in (1)) gets run, calling do_signal(),
>> > which will notice -ERESTARTSYS and set PIF_SYSCALL_RESTART.
>> > Presumably it will also push the signal frame onto the stack and aim
>> > the return address at the svc instruction mentioned in the commit
>> > message from "s390: convert to generic entry".  Then __do_syscall()
>> > will turn interrupts back on and loop right back into do_syscall().
>> > That seems incorrect.
>> >
>> > Can you enlighten me?  My WIP tree is here:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/kentry
>> >
>>
>> For all the details to that change we'd have to wait for Sven, who is back
>> next week.
>>
>> > Here are my changes to s390, and I don't think they're really correct:
>> >
>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/diff/arch/s390/kernel/syscall.c?h=x86/kentry&id=58a459922be0fb8e0f17aeaebcb0ac8d0575a62c
>>
>> Couple of things: syscall_exit_to_user_mode_prepare is static,
>> and there is another code path in arch/s390/kernel/traps.c using
>> enter_from_user_mode/exit_to_user_mode.
>>
>> Anyhow I gave your branch a spin and got few new failures on strace test
>> suite, in particular on restart_syscall test. I'll try to find time to
>> look into details.
>
> I refreshed the branch, but I confess I haven't compile tested it. :)
>
> I would guess that the new test case failures are a result of the
> buggy syscall restart logic.  I think that all of the "restart" cases
> except execve() should just be removed.  Without my patch, I suspect
> that signal delivery with -ERESTARTSYS would create the signal frame,
> do an accidental "restarted" syscall that was a no-op, and then
> deliver the signal.  With my patch, it may simply repeat the original
> interrupted signal forever.

PIF_SYSCALL_RESTART is set in arch_do_signal_or_restart(), but only if
there's no signal handler registered. In that case we don't need a
signal frame, so that should be fine.

The problem why your branch is not working is that arch_do_signal_or_restart()
gets called from exit_to_user_mode_prepare(), and that is after the
check whether PIF_SYSCALL_RESTART is set in __do_syscall().

So i'm wondering how to fix that. x86 simply rewinds the pc, so the
system call instruction gets re-executed when returning to user
space. For s390 that doesn't work, as the s390 svc instruction might
have the syscall number encoded. If we would have to restart a system
call with restart_systemcall(), we need to change the syscall number to
__NR_restart_syscall. As we cannot change the hardcoded system call
number, we somehow need to handle that inside of the kernel.

So i wonder whether we should implement the PIF_SYSCALL_RESTART check in
entry.S after all the return to user space entry code was run but before
doing the real swtch back to user space. If PIF_SYSCALL_RESTART is set
we would then just jump back to the entry code and pretend we came from
user space.

That would have the benefit that the entry C code looks the same like
other architectures and that amount of code to add in entry.S shouldn't
be much.

Any thoughts?

Regards
Sven
