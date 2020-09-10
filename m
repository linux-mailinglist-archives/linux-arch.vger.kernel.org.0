Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69672646AE
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgIJNPz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 09:15:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730718AbgIJNMZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Sep 2020 09:12:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AD4qXS103955;
        Thu, 10 Sep 2020 09:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=oodDKP5uogVkAkmpIZzRMmexhkNRtABOuWmseLPxbWE=;
 b=XjYulL+ZIiOd9JfWu0OyV3ZQAze//8mmxYA8QoyhtxKXDz1RVr6gFMCtfZ6ZXZe8N10B
 XXe68Q5QWTOOB1e5/TNxiwhxVzvpI7YJVTDrEPQu5Q6gp5AmAiz6rSC2Bb4uveWecbZw
 D6oKP6uvLanWkVIxAnOoK70cKGKF/QNjUh1IiJMVOg8DeYA8L4BAzBWRsTWE2AzQiBnS
 0xJF3gBd0r6D7/NEvRLYMtrhv44s7qg236t39ZpYQWFkhH4YmQv6zkmMqDDOGAiy6nEl
 glq8LM03Af4Tjs0N5GyVQtWSKwC0N1pqfvZsW5Q5WGSo8HUc/90lBliNV8qQQrw9w7h9 DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fmha0h8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 09:11:20 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08AD4oJ1103883;
        Thu, 10 Sep 2020 09:11:19 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fmha0h72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 09:11:19 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AD94OM003244;
        Thu, 10 Sep 2020 13:11:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8e2t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 13:11:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08ADBE0J25886994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 13:11:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FE89AE05F;
        Thu, 10 Sep 2020 13:11:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7E89AE05A;
        Thu, 10 Sep 2020 13:11:12 +0000 (GMT)
Received: from thinkpad (unknown [9.171.93.242])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 10 Sep 2020 13:11:12 +0000 (GMT)
Date:   Thu, 10 Sep 2020 15:11:11 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910151111.33168193@thinkpad>
In-Reply-To: <20200909180324.GI87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
        <20200909142904.00b72921@thinkpad>
        <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
        <20200909192534.442f8984@thinkpad>
        <20200909180324.GI87483@ziepe.ca>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_03:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100120
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 9 Sep 2020 15:03:24 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Sep 09, 2020 at 07:25:34PM +0200, Gerald Schaefer wrote:
> > I actually had to draw myself a picture to get some hold of
> > this, or rather a walk-through with a certain pud-crossing
> > range in a folded 3-level scenario. Not sure if I would have
> > understood my explanation above w/o that, but I hope you can
> > make some sense out of it. Or draw yourself a picture :-)
> 
> What I don't understand is how does anything work with S390 today?

That is totally comprehensible :-)

> If the fix is only to change pxx_addr_end() then than generic code
> like mm/pagewalk.c will iterate over a *different list* of page table
> entries. 
> 
> It's choice of entries to look at is entirely driven by pxx_addr_end().
> 
> Which suggest to me that mm/pagewalk.c also doesn't work properly
> today on S390 and this issue is not really about stack variables?

I guess you are confused by the fact that the generic change will indeed
change the logic for _all_ pagetable walkers on s390, not just for
the gup_fast case. But that doesn't mean that they were doing it wrong
before, we simply can do it both ways. However, we probably should
make that (in theory useless) change more explicit.

Let's compare before and after for mm/pagewalk.c on s390, with 3-level
pagetables, range crossing 2 GB pud boundary.

* Before (with pXd_addr_end always using static 5-level PxD_SIZE):

walk_pgd_range()
-> pgd_addr_end() will use static 2^53 PGDIR_SIZE, range is not cropped,
                  no iterations needed, passed over to next level

walk_p4d_range()
-> p4d_addr_end() will use static 2^42 P4D_SIZE, range still not cropped

walk_pud_range()
-> pud_addr_end() now we're cropping, with 2^31 PUD_SIZE, need two
                  iterations for range crossing pud boundary, doing
                  that right here on a pudp which is actually the
                  previously passed-through pgdp/p4dp (pointing to
                  correct pagetable entry)

* After (with dynamic pXd_addr_end using "correct" PxD_SIZE boundaries,
         should be similar to other archs static "top-level folding"):

walk_pgd_range()
-> pgd_addr_end() will now determine "correct" boundary based on pgd
                  value, i.e. 2^31 PUD_SIZE, do cropping now, iteration
                  will now happen here

walk_p4d/pud_range()
->  operate on cropped range, will not iterate, instead return to pgd level,
    which will then use the same pointer for iteration as in the "Before"
    case, but not on the same level.

IMHO, our "Before" logic is more efficient, and also feels more natural.
After all, it is not really necessary to return to pgd level, and it will
surely cost some extra instructions. We are willing to take that cost
for the sake of doing it in a more generic way, hoping that will reduce
future issues. E.g. you already mentioned that you have plans for using
the READ_ONCE logic also in other places, and that would be such a
"future issue".

> Fundamentally if pXX_offset() and pXX_addr_end() must be consistent
> together, if pXX_offset() is folded then pXX_addr_end() must cause a
> single iteration of that level.

well, that sounds correct in theory, but I guess it depends on "how
you fold it". E.g. what does "if pXX_offset() is folded" mean?
Take pgd_offset() for the 3-level case above. From our previous
"middle-level folding/iteration" perspective, I would say that
pgd/p4d are folded into pud, so if you say "if pgd_offset() is folded
then pgd_addr_end() must cause a single iteration of that level",
we were doing it all correctly, i.e only having single iteration
on pgd/p4d level. You could even say that all others are doing /
using it wrong :-)

Now take pgd_offset() from the "top-level folding/iteration".
Here you would say that p4d/pud are folded into pgd, which again
does not sound like the natural / most efficient way to me,
but IIUC this has to be how it works for all other archs with
(static) pagetable folding. Now you'd say "if pud/p4d_offset()
is folded then pud/p4d_addr_end() must cause a single iteration
of that level", and that would sound correct. At least until
you look more closely, because e.g. p4d_addr_end() in
include/asm-generic/pgtable-nop4d.h is simply this:
#define p4d_addr_end(addr, end) (end)

How can that cause a single iteration? It clearly won't, it only
works because the previous pgd_addr_end already cropped the range
so that there will be only single iterations for p4d/pud.

The more I think of it, the more it sounds like s390 "middle-level
folding/iteration" was doing it "the right way", and everybody else
was wrong, or at least not in an optimally efficient way :-) Might
also be that only we could do this because we can determine the
pagetable level from a pagetable entry value.

Anyway, if you are not yet confused enough, I recommend looking
at the other option we had in mind, for fixing the gup_fast issue.
See "Patch 1" from here:
https://lore.kernel.org/lkml/20200828140314.8556-1-gerald.schaefer@linux.ibm.com/

That would actually have kept that "middle-level iteration" also
for gup_fast, by additionally passing through the pXd pointers.
However, it also needed a gup-specific version of pXd_offset(),
in order to keep the READ_ONCE semantics. For s390, that would
have actually been the best solution, but a generic version of
that might not have been so easy. And doing it like everybody
else can not be so bad, at least I really hope so.

Of course, at some point in time, we might come up with some fancy
fundamental change that would "do it the right middle-level way
for everybody". At least I think I overheard Vasily and Alexander
discussing some wild ideas, but that is certainly beyond this scope
here...
