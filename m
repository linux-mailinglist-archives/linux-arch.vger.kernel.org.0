Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8934CF5A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 13:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhC2Lte (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 07:49:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231359AbhC2LtP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Mar 2021 07:49:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TBXj3E078240;
        Mon, 29 Mar 2021 07:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=qv3anaEnH3dmdnJh+LhoKWtRDkS2LkFaRLofMgA3CI4=;
 b=ZTAXFUzp3YEw4LlqUuqTtu663c1ud+quYLAGk5tvV5qEsTIK5PXkob8taTbdH0K6LB+W
 yhIRJsTxmH1AMgUEPUD0lRe7IseSHoC0uMt/9p7i16KlUocpihiOJTIj2vW1/hqFtwnB
 EEhE5IsTncSnGSaJrWGj2veDjjTNLYTXYXZoPfiY3EbIHWcMGfLFfUxlBcw3TzR3BoaT
 wP9l8DXqRsiJPaR9amPraYHEkOyFD8voo3f6KpEmpI2aHn3DET60JZX83dyeE6Ljkkyh
 LceqeG/6h4i3TaTTdL0RxnBpp3DoJVMmjpvzBbsczSjbEUrPcleM2Rs7u5z33jso0d58 sw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37jj8acnm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 07:49:10 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12TBn8cM008669;
        Mon, 29 Mar 2021 11:49:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 37hvb88wvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 11:49:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12TBn60q39780678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 11:49:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D30552063;
        Mon, 29 Mar 2021 11:49:06 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2AA055204F;
        Mon, 29 Mar 2021 11:49:06 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Is s390's new generic-using syscall code actually correct?
References: <CALCETrUx10uHeD7bckVjL9x7S3LEdH3ZfzUbCMWj9j-=nYp8Wg@mail.gmail.com>
Date:   Mon, 29 Mar 2021 13:49:05 +0200
In-Reply-To: <CALCETrUx10uHeD7bckVjL9x7S3LEdH3ZfzUbCMWj9j-=nYp8Wg@mail.gmail.com>
        (Andy Lutomirski's message of "Sat, 20 Mar 2021 20:48:34 -0700")
Message-ID: <yt9dblb2w572.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E6pNlFG_Ow7IIA3zu_rxL2DBlkj_f-py
X-Proofpoint-ORIG-GUID: E6pNlFG_Ow7IIA3zu_rxL2DBlkj_f-py
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_08:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290091
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andy,

sorry for the late reply, i was away from kernel development for a few
weeks.

Andy Lutomirski <luto@kernel.org> writes:

> Hi all-
>
> I'm working on my kentry patchset, and I encountered:
>
> commit 56e62a73702836017564eaacd5212e4d0fa1c01d
> Author: Sven Schnelle <svens@linux.ibm.com>
> Date:   Sat Nov 21 11:14:56 2020 +0100
>
>     s390: convert to generic entry
>
> As part of this work, I was cleaning up the generic syscall helpers,
> and I encountered the goodies in do_syscall() and __do_syscall().
>
> I'm trying to wrap my head around the current code, and I'm rather confused.
>
> 1. syscall_exit_to_user_mode_work() does *all* the exit work, not just
> the syscall exit work.  So a do_syscall() that gets called twice will
> do the loopy part of the exit work (e.g. signal handling) twice.  Is
> this intentional?  If so, why?

Not really intentional, but i decided to accept the overhead for now and
fix that later by splitting up the generic entry code. Otherwise the
patch would have had even more dependencies. I have not looked yet into
your kentry branch, but will do that later. Maybe there is already a
better way to do it or we can work something out.

> 2. I don't understand how this PIF_SYSCALL_RESTART thing is supposed
> to work.  Looking at the code in Linus' tree, if a signal is pending
> and a syscall returns -ERESTARTSYS, the syscall will return back to
> do_syscall().  The work (as in (1)) gets run, calling do_signal(),
> which will notice -ERESTARTSYS and set PIF_SYSCALL_RESTART.
> Presumably it will also push the signal frame onto the stack and aim
> the return address at the svc instruction mentioned in the commit
> message from "s390: convert to generic entry".  Then __do_syscall()
> will turn interrupts back on and loop right back into do_syscall().
> That seems incorrect.

That sounds indeed broken. My understanding is that x86 is always
rewinding the pc in the restart case, and is exiting to user mode. That
would than also work with signal frames.

However, on s390 we cannot simply rewind the pc as the syscall number
might be encoded in the system call instruction. If a user would have
rewritten the system call number (i.e. with seccomp) it would still
execute the original syscall number.

That makes me wonder why i have not seen problems with signals and system
call restarting so far. Have to read the code again.

Regards
Sven
