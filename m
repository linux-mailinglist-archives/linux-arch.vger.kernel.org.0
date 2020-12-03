Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEABA2CDBF8
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 18:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbgLCRKJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 12:10:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbgLCRKI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 12:10:08 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3H3JMt112523;
        Thu, 3 Dec 2020 12:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RpZiGUqqBd425B17pR2oKWRKVMv9NGPUj5cBEDRMzvo=;
 b=rA8HFWgJjvhpqS7KBBkqCi21TjJA9A5+bf5f2tXlIJn3HvC0ajhtopEVcoxIviNagG1t
 +b3xJyxksVkn85TgfYXHt7Z/m/G8aea5RUZu8thT0/ksyglfPptZNLOZCPX7atzXGz1O
 TeIpUgfy7HqpyhukBDeKMfAjWXdypzzo3Llejc9jP6o0rqcIeNo/nuKTPFILsQV5FOj2
 hmOvk0zCDp6bDjy7iS01U4hDSXzG/FxAb8/o6K+P67WanNCO5NRp3bK0bsqqQ5G2KOHg
 ZF2mhhiBRQRNmRybHkxk9xf305GN0s0KHV0mFny8N0nk/e+YBiC6p6IGfHSMITayU8E7 TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35722vwpsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 12:08:49 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B3H4ALq117573;
        Thu, 3 Dec 2020 12:08:44 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35722vwpp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 12:08:44 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B3GqLrK005060;
        Thu, 3 Dec 2020 17:03:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpdc7fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 17:03:41 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B3H3coR23331098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Dec 2020 17:03:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B2D111C058;
        Thu,  3 Dec 2020 17:03:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AA1C11C04C;
        Thu,  3 Dec 2020 17:03:37 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.157.245])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Dec 2020 17:03:37 +0000 (GMT)
Date:   Thu, 3 Dec 2020 18:03:35 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
Message-ID: <20201203170332.GA27195@oc3871087118.ibm.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
 <20201128160141.1003903-7-npiggin@gmail.com>
 <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
 <CALCETrWBtCfD+jZ3S+O8FK-HFPODuhbDEbbfWvS=-iPATNFAOA@mail.gmail.com>
 <CALCETrXAR_9EGaOF8ymVkZycxgZkYk0dR+NjEpTfVzdcS3sOVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXAR_9EGaOF8ymVkZycxgZkYk0dR+NjEpTfVzdcS3sOVw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_09:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030100
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 30, 2020 at 10:31:51AM -0800, Andy Lutomirski wrote:
> other arch folk: there's some background here:
> 
> https://lkml.kernel.org/r/CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com
> 
> On Sun, Nov 29, 2020 at 12:16 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Sat, Nov 28, 2020 at 7:54 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > >
> > > > On big systems, the mm refcount can become highly contented when doing
> > > > a lot of context switching with threaded applications (particularly
> > > > switching between the idle thread and an application thread).
> > > >
> > > > Abandoning lazy tlb slows switching down quite a bit in the important
> > > > user->idle->user cases, so so instead implement a non-refcounted scheme
> > > > that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
> > > > any remaining lazy ones.
> > > >
> > > > Shootdown IPIs are some concern, but they have not been observed to be
> > > > a big problem with this scheme (the powerpc implementation generated
> > > > 314 additional interrupts on a 144 CPU system during a kernel compile).
> > > > There are a number of strategies that could be employed to reduce IPIs
> > > > if they turn out to be a problem for some workload.
> > >
> > > I'm still wondering whether we can do even better.
> > >
> >
> > Hold on a sec.. __mmput() unmaps VMAs, frees pagetables, and flushes
> > the TLB.  On x86, this will shoot down all lazies as long as even a
> > single pagetable was freed.  (Or at least it will if we don't have a
> > serious bug, but the code seems okay.  We'll hit pmd_free_tlb, which
> > sets tlb->freed_tables, which will trigger the IPI.)  So, on
> > architectures like x86, the shootdown approach should be free.  The
> > only way it ought to have any excess IPIs is if we have CPUs in
> > mm_cpumask() that don't need IPI to free pagetables, which could
> > happen on paravirt.
> 
> Indeed, on x86, we do this:
> 
> [   11.558844]  flush_tlb_mm_range.cold+0x18/0x1d
> [   11.559905]  tlb_finish_mmu+0x10e/0x1a0
> [   11.561068]  exit_mmap+0xc8/0x1a0
> [   11.561932]  mmput+0x29/0xd0
> [   11.562688]  do_exit+0x316/0xa90
> [   11.563588]  do_group_exit+0x34/0xb0
> [   11.564476]  __x64_sys_exit_group+0xf/0x10
> [   11.565512]  do_syscall_64+0x34/0x50
> 
> and we have info->freed_tables set.
> 
> What are the architectures that have large systems like?
> 
> x86: we already zap lazies, so it should cost basically nothing to do
> a little loop at the end of __mmput() to make sure that no lazies are
> left.  If we care about paravirt performance, we could implement one
> of the optimizations I mentioned above to fix up the refcounts instead
> of sending an IPI to any remaining lazies.
> 
> arm64: AFAICT arm64's flush uses magic arm64 hardware support for
> remote flushes, so any lazy mm references will still exist after
> exit_mmap().  (arm64 uses lazy TLB, right?)  So this is kind of like
> the x86 paravirt case.  Are there large enough arm64 systems that any
> of this matters?
> 
> s390x: The code has too many acronyms for me to understand it fully,
> but I think it's more or less the same situation as arm64.  How big do
> s390x systems come?
> 
> power: Ridiculously complicated, seems to vary by system and kernel config.
> 
> So, Nick, your unconditional IPI scheme is apparently a big
> improvement for power, and it should be an improvement and have low
> cost for x86.  On arm64 and s390x it will add more IPIs on process
> exit but reduce contention on context switching depending on how lazy

s390 does not invalidate TLBs per-CPU explicitly - we have special
instructions for that. Those in turn initiate signalling to other
CPUs, completely transparent to OS.

Apart from mm_count, I am struggling to realize how the suggested
scheme could change the the contention on s390 in connection with
TLB. Could you clarify a bit here, please?

> TLB works.  I suppose we could try it for all architectures without
> any further optimizations.  Or we could try one of the perhaps
> excessively clever improvements I linked above.  arm64, s390x people,
> what do you think?

I do not immediately see anything in the series that would harm
performance on s390.

We however use mm_cpumask to distinguish between local and global TLB
flushes. With this series it looks like mm_cpumask is *required* to
be consistent with lazy users. And that is something quite diffucult
for us to adhere (at least in the foreseeable future).

But actually keeping track of lazy users in a cpumask is something
the generic code would rather do AFAICT.

Thanks!
