Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF816264AC5
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 19:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIJRLu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 13:11:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbgIJRJM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Sep 2020 13:09:12 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AH5DM2116839;
        Thu, 10 Sep 2020 13:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=qilzlS56H4QvuSWRp/oOCj8An/EyVcbeh6b059Wu1Uw=;
 b=EYBhJJNU5006w3JWzXMvr6IDwOyibiam9QzfW13xlknHHkRr+aIWIng7UFmS6bOotzDb
 5lfmVi8OcQs5qrQwFM/p8dfjBliLZmRkvzKuWTkjLiNr4GaxYlRG6vt9bMXLTEzSygCw
 vckVGWjTm4sFNJuONtYX6eLt9NjVBp4i/TD/P0lr1gOVILDmTMme9Ohaau2bE3L/3i/k
 lpUCy/pwRXQ7w8KKJBiSAc6NnBHzNDLBHDTJfNoLkcqEJNvwaohOnF3helbYWNGo2ml4
 epxy54qQiIclEE373bqTgka/jcK0fo1+41jOe3UuF/q6UGFmpAb2SUHZTApN7fFiAZdp rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fr31r7yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 13:08:08 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08AH6CMB119744;
        Thu, 10 Sep 2020 13:08:06 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fr31r7xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 13:08:06 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AGwMEF016155;
        Thu, 10 Sep 2020 17:08:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 33f91w8ftk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 17:08:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08AH80PM25428362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 17:08:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88F2442047;
        Thu, 10 Sep 2020 17:08:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3171B4203F;
        Thu, 10 Sep 2020 17:07:59 +0000 (GMT)
Received: from thinkpad (unknown [9.171.93.242])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 10 Sep 2020 17:07:59 +0000 (GMT)
Date:   Thu, 10 Sep 2020 19:07:57 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910190757.153319d4@thinkpad>
In-Reply-To: <20200910151026.GL87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
        <20200909142904.00b72921@thinkpad>
        <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
        <20200909192534.442f8984@thinkpad>
        <20200909180324.GI87483@ziepe.ca>
        <20200910093925.GB29166@oc3871087118.ibm.com>
        <20200910130233.GK87483@ziepe.ca>
        <20200910152803.1a930afc@thinkpad>
        <20200910151026.GL87483@ziepe.ca>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_05:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100157
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 10 Sep 2020 12:10:26 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Sep 10, 2020 at 03:28:03PM +0200, Gerald Schaefer wrote:
> > On Thu, 10 Sep 2020 10:02:33 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >   
> > > On Thu, Sep 10, 2020 at 11:39:25AM +0200, Alexander Gordeev wrote:
> > >   
> > > > As Gerald mentioned, it is very difficult to explain in a clear way.
> > > > Hopefully, one could make sense ot of it.    
> > > 
> > > I would say the page table API requires this invariant:
> > > 
> > >         pud = pud_offset(p4d, addr);
> > >         do {
> > > 		WARN_ON(pud != pud_offset(p4d, addr);
> > >                 next = pud_addr_end(addr, end);
> > >         } while (pud++, addr = next, addr != end);
> > > 
> > > ie pud++ is supposed to be a shortcut for 
> > >   pud_offset(p4d, next)
> > > 
> > > While S390 does not follow this. Fixing addr_end brings it into
> > > alignment by preventing pud++ from happening.
> > > 
> > > The only currently known side effect is that gup_fast crashes, but it
> > > sure is an unexpected thing.  
> > 
> > It only is unexpected in a "top-level folding" world, see my other reply.
> > Consider it an optimization, which was possible because of how our dynamic
> > folding works, and e.g. because we can determine the correct pagetable
> > level from a pXd value in pXd_offset.  
> 
> No, I disagree. The page walker API the arch presents has to have well
> defined semantics. For instance, there is an effort to define tests
> and invarients for the page table accesses to bring this understanding
> and uniformity:
> 
>  mm/debug_vm_pgtable.c
> 
> If we fix S390 using the pX_addr_end() change then the above should be
> updated with an invariant to check it. I've added Anshuman for some
> thoughts..

We are very aware of those tests, and actually a big supporter of the
idea. Also part of the supported architectures already, and it has
already helped us find / fix some s390 oddities.

However, we did not see any issues wrt to our pagetable walking,
neither with the current version, nor with the new generic approach.
We do currently see other issues, Anshuman will know what I mean :-)

> For better or worse, that invariant does exclude arches from using
> other folding techniques.
> 
> The other solution would be to address the other side of != and adjust
> the pud++
> 
> eg replcae pud++ with something like:
>   pud = pud_next_entry(p4d, pud, next)
> 
> Such that:
>   pud_next_entry(p4d, pud, next) === pud_offset(p4d, next)
> 
> In which case the invarient changes to 'callers can never do pointer
> arithmetic on the result of pXX_offset()' which is a bit harder to
> enforce.

I might have lost track a bit. Are we still talking about possible
functional impacts of either our current pagetable walking with s390
(apart from gup_fast), or the proposed generic change (for s390, or
others?)?

Or is this rather some (other) generic issue / idea that you have,
in order to put "some more structure / enforcement" to generic
pagetable walkers?
