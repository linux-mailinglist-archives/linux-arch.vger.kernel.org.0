Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D47E263495
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 19:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIIR0g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 13:26:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729005AbgIIR0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 13:26:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089HJ2gK051405;
        Wed, 9 Sep 2020 13:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=cjurvjugr7NYNyJv2e5m0mRxD9kWPQ1Co8p7cVwZgRc=;
 b=a0Fn+WGsOgKb9v9OSCIZ4vTawA6Q4ZWyUk5Zt6IyTNtTXdZySGDE4pfNW4f9sOhvDRO5
 pyaNWhLyJ2qz3kHm1udz4qSWUWaxsbyYzZLNWKFPeYNcxy2qdx0OXkhkTDPLQoBCBK1t
 7YomGSfviJhw2ax52kN9UbRlZeV16c8bRZP4tJOx9BLgNI8eZteBXenPoAxximHCBe3r
 oc3mh8uaZpxgVJjOxB3Kwhe+XjRIXqlbY7UiHRXs8QbI/LmnYJW28BEv9GJIlDCWO9Nn
 BcMJVH24ws0Fur+qARRdqFfpfnTFoGkjKZORJo+fOQcFQTXSPiLNreCZu/z5cCKZzuRh 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f3b88711-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 13:25:42 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089HKUCM063750;
        Wed, 9 Sep 2020 13:25:42 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f3b886y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 13:25:42 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089HLmU7024299;
        Wed, 9 Sep 2020 17:25:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 33c2a84w57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 17:25:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089HPaUJ57147902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 17:25:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A04C5AE058;
        Wed,  9 Sep 2020 17:25:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75DA7AE057;
        Wed,  9 Sep 2020 17:25:35 +0000 (GMT)
Received: from thinkpad (unknown [9.171.79.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  9 Sep 2020 17:25:35 +0000 (GMT)
Date:   Wed, 9 Sep 2020 19:25:34 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20200909192534.442f8984@thinkpad>
In-Reply-To: <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
        <20200909142904.00b72921@thinkpad>
        <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_12:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090147
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 9 Sep 2020 09:18:46 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/9/20 5:29 AM, Gerald Schaefer wrote:
> > This only works well as long there are real pagetable pointers involved,
> > that can also be used for iteration. For gup_fast, or any other future
> > pagetable walkers using the READ_ONCE logic w/o lock, that is not true.
> > There are pointers involved to local pXd values on the stack, because of
> > the READ_ONCE logic, and our middle-level iteration will suddenly iterate
> > over such stack pointers instead of pagetable pointers.
> 
> By "There are pointers involved to local pXd values on the stack", did
> you mean "locate" instead of "local"?  That sentence confused me.
> 
> Which code is it, exactly that allocates these troublesome on-stack pXd
> values, btw?

It is the gup_pXd_range() call sequence in mm/gup.c. It starts in
gup_pgd_range() with "pgdp = pgd_offset(current->mm, addr)" and then
the "pgd_t pgd = READ_ONCE(*pgdp)" which creates the first local
stack variable "pgd".

The next-level call to gup_p4d_range() gets this "pgd" value as
input, but not the original pgdp pointer where it was read from.
This is already the essential difference to other pagetable walkers
like e.g. walk_pXd_range() in mm/pagewalk.c, where the original
pointer is passed through. With READ_ONCE, that pointer must not
be further de-referenced, so instead the value is passed over.

In gup_p4d_range() we then have "p4dp = p4d_offset(&pgd, addr)",
with &pgd being a pointer to the passed over pgd value, so that's
the first pXd pointer that does not point directly to the pXd in
the page table, but a local stack variable.

With folded p4d, p4d_offset(&pgd, addr) will simply return
the passed-in &pgd pointer, so we now also have p4dp point to that.
That continues with "p4d_t p4d = READ_ONCE(*p4dp)", and that second
stack variable passed to gup_huge_pud() and so on. Due to inlining,
all those variables will not really be passed anywhere, but simply
sit on the stack.

So far, IIUC, that would also happen on x86 (or everywhere else
actually) for folded levels, i.e. some pXd_offset() calls would
simply return the passed in (stack) value pointer. This works
as designed, and it will not lead to the "iteration over stack
pointer" for anybody but s390, because the pXd_addr_end()
boundaries usually take care that you always return to pgd
level for iteration, and that is the only level with a real
pagetable pointer. For s390, we stay at the first non-folded
level and do the iteration there, which is fine for other
pagetable walkers using the original pointers, but not for
the READ_ONCE-style gup_fast.

I actually had to draw myself a picture to get some hold of
this, or rather a walk-through with a certain pud-crossing
range in a folded 3-level scenario. Not sure if I would have
understood my explanation above w/o that, but I hope you can
make some sense out of it. Or draw yourself a picture :-)
