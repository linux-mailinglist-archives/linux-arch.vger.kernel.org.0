Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48AA347FA1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 18:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhCXRjZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 13:39:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10606 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237047AbhCXRjA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 13:39:00 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OHWWeq097863;
        Wed, 24 Mar 2021 13:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=i0jVAPdV4uMZGW+9DRVmj8zwB+KQ4zU198TE5YQBbdo=;
 b=JsiMrqpzRtiRzTYFDhNpMa6FvYzaladPqSoxMoB67y2q8HeP6fXSzhFHJf2lUa/cGN4O
 e51qsqXQyS6E43YrVbVFL+EyEkOfbSqeoJj/DE4ePh+R7hhdxDNaeumY8gU0Zl7LsF1P
 RKtxqWBq+k+efPDBx8qgfiID2xWVZ6HIEPjO66fc3wf6zraDvF41S2ENRJghWgBPV7rN
 rh03bGzjDUtKmu890wLoSvk3gvqfFdTETHz8nkHTxQxdDLOWIMVt1VjJbR2RzPgKxB2O
 QFWIZTcXrl4Uw8Q2kOZlWaiXSKzer5zx785K/kUhDaq7oYBrV5GAflChxew3kuFqmdjB zA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37g9cs161f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 13:38:57 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12OHREki030541;
        Wed, 24 Mar 2021 17:38:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99rck3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 17:38:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12OHcYxB13369834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 17:38:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D0F54C052;
        Wed, 24 Mar 2021 17:38:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F69F4C04E;
        Wed, 24 Mar 2021 17:38:51 +0000 (GMT)
Received: from localhost (unknown [9.171.93.123])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Mar 2021 17:38:51 +0000 (GMT)
Date:   Wed, 24 Mar 2021 18:38:50 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: Is s390's new generic-using syscall code actually correct?
Message-ID: <your-ad-here.call-01616607308-ext-0852@work.hours>
References: <CALCETrUx10uHeD7bckVjL9x7S3LEdH3ZfzUbCMWj9j-=nYp8Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrUx10uHeD7bckVjL9x7S3LEdH3ZfzUbCMWj9j-=nYp8Wg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240127
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andy,

On Sat, Mar 20, 2021 at 08:48:34PM -0700, Andy Lutomirski wrote:
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
> 
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
> 
> Can you enlighten me?  My WIP tree is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/kentry
> 

For all the details to that change we'd have to wait for Sven, who is back
next week.

> Here are my changes to s390, and I don't think they're really correct:
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/diff/arch/s390/kernel/syscall.c?h=x86/kentry&id=58a459922be0fb8e0f17aeaebcb0ac8d0575a62c

Couple of things: syscall_exit_to_user_mode_prepare is static,
and there is another code path in arch/s390/kernel/traps.c using
enter_from_user_mode/exit_to_user_mode.

Anyhow I gave your branch a spin and got few new failures on strace test
suite, in particular on restart_syscall test. I'll try to find time to
look into details.
