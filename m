Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F173F2618B8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgIHSAd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 14:00:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731574AbgIHSAb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 14:00:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088HaqH0157903;
        Tue, 8 Sep 2020 13:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=9vA8/AJsGG0zJ8yywQHukKRgSAWG6O3CqIKPsfzZe8o=;
 b=BjLNfTKYlNEEc2uStg8DiatoJq2c8F1l7LCfltGYE12PF61BhosKLmVMhzQWKFic7DjB
 ODOQ4Ab7V0OMAwEaC30qGbwq1qp1T1sQo51pCTWKzreipRU6hiEWQxJmQe5KclxEt0E5
 EBuUZCeG2aSeNd5qvxhpE8RDWX35jy6XCZslgOkkR8DkDFWEAobN/09andvUhXdwhHlx
 wsQizFZosh34pdmvFLO4JDQmopAvtfmKsdHT4+nBXtmkS4cUtLhcGG8Z3chJIJWEkkxr
 AQqz2pmQMasv2p8pBrjFZXu8KdUi6V75qyQ/ZhRV9ub4Y3a9IRQg1Y8uS9bNduFJGmeX OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33edub1q6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 13:59:53 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 088Hc2Al163051;
        Tue, 8 Sep 2020 13:59:52 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33edub1q5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 13:59:52 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088HwJR5021149;
        Tue, 8 Sep 2020 17:59:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 33c2a828hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 17:59:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088HxkQm32244068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 17:59:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9951211C050;
        Tue,  8 Sep 2020 17:59:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55EC911C04A;
        Tue,  8 Sep 2020 17:59:45 +0000 (GMT)
Received: from thinkpad (unknown [9.171.25.197])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  8 Sep 2020 17:59:45 +0000 (GMT)
Date:   Tue, 8 Sep 2020 19:59:44 +0200
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
Message-ID: <20200908195944.1a25d1bb@thinkpad>
In-Reply-To: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_09:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080165
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 8 Sep 2020 07:30:50 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/7/20 11:00 AM, Gerald Schaefer wrote:
> > Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> > code") introduced a subtle but severe bug on s390 with gup_fast, due to
> > dynamic page table folding.
> 
> Would it be fair to say that the "fake" page table entries s390
> allocates on the stack are what's causing the trouble here?  That might
> be a nice thing to open up with here.  "Dynamic page table folding"
> really means nothing to me.

We do not really allocate anything on the stack, it is the generic logic
from gup_fast that passes over pXd values (read once before), and using
pointers to such (stack) variables instead of real pXd pointers.
That, combined with the fact that we just return the passed in pointer in
pXd_offset() for folded levels.

That works similar on x86 IIUC, but with static folding, and thus also
proper pXd_addr_end() results because of statically (and correspondingly)
defined Pxd_INDEX/SHIFT. We always have static 5-level PxD_INDEX/SHIFT, and
that cannot really be made dynamic, so we just make pXd_addr_end()
dynamic instead, and that requires the pXd value to determine the correct
pagetable level.

Still makes my head spin when trying to explain, sorry. It is a very
special s390 oddity, or lets call it "feature", because I don't think any
other architecture has "dynamic pagetable folding" capability, depending
on process requirements, for whatever it is worth...

> 
> > @@ -2521,7 +2521,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
> >  	do {
> >  		pmd_t pmd = READ_ONCE(*pmdp);
> >  
> > -		next = pmd_addr_end(addr, end);
> > +		next = pmd_addr_end_folded(pmd, addr, end);
> >  		if (!pmd_present(pmd))
> >  			return 0;
> 
> It looks like you fix this up later, but this would be a problem if left
> this way.  There's no documentation for whether I use
> pmd_addr_end_folded() or pmd_addr_end() when writing a page table walker.

Yes, that is very unfortunate. We did have some lengthy comment in
include/linux/pgtable.h where the pXd_addr_end(_folded) were defined.
But that was moved to arch/s390/include/asm/pgtable.h in this version,
probably because we already had the generalization in mind, where we
would not need such explanation in common header any more.

So, it might help better understand the issue that we have with
dynamic page table folding and READ_ONCE-style pagetable walkers
when looking at that comment.

Thanks for pointing out, that comment should definitely go into
include/linux/pgtable.h again. At least if we would still go for
that "s390 fix first, generalization second" approach, but it
seems we have other / better options now.
