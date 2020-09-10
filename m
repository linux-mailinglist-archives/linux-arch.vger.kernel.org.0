Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12D826428F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 11:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgIJJks (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 05:40:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728207AbgIJJkm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Sep 2020 05:40:42 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08A9Vt6b119469;
        Thu, 10 Sep 2020 05:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=41BJsvawiBO1ghr06VQIrffJCPHY4UzVo4fvKE+7RMs=;
 b=JnI3+HuSFQICzixnbEr3lD/KU407bMni7V5mL/H47oPLaomhPs6t57kI2sBNlnitleWU
 Ljv2tAQ6Y00VBu0RV7fJV/uOYIaFn2+L3EVF73PBzpDn0xMhXi4S9uZF+n3tyogr9cL8
 ytPNf7pxi3XLZLzrvhLCPhCFdXv9qVuX2Is4ueWpwdN5VmTvJ7ZPUFIC/eAC2eqsGvRz
 0ArbCVZIdHdWjs4nUhCUUciXheJ/YGqiDnhHtZPbG7C2gBZK+PQzRO1oEWokDf3RJaPK
 qEdPrU10FoZR5nshuEVIEbRP9lZ8x2Pm0AWZdo3HKCBJEvEDjwjaM3Kk9J6p8hBlCJ8m ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33fg9ejw18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 05:39:36 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A9WV5v121274;
        Thu, 10 Sep 2020 05:39:35 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33fg9ejvxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 05:39:35 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A9c3QB011125;
        Thu, 10 Sep 2020 09:39:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 33c2a81b0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 09:39:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08A9dTSv34800078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 09:39:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EE38AE04D;
        Thu, 10 Sep 2020 09:39:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BD21AE053;
        Thu, 10 Sep 2020 09:39:27 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.67.15])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 10 Sep 2020 09:39:27 +0000 (GMT)
Date:   Thu, 10 Sep 2020 11:39:25 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Message-ID: <20200910093925.GB29166@oc3871087118.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909180324.GI87483@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_01:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1011 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100085
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 09, 2020 at 03:03:24PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 09, 2020 at 07:25:34PM +0200, Gerald Schaefer wrote:
> > I actually had to draw myself a picture to get some hold of
> > this, or rather a walk-through with a certain pud-crossing
> > range in a folded 3-level scenario. Not sure if I would have
> > understood my explanation above w/o that, but I hope you can
> > make some sense out of it. Or draw yourself a picture :-)
> 
> What I don't understand is how does anything work with S390 today?
> 
> If the fix is only to change pxx_addr_end() then than generic code
> like mm/pagewalk.c will iterate over a *different list* of page table
> entries. 
> 
> It's choice of entries to look at is entirely driven by pxx_addr_end().
> 
> Which suggest to me that mm/pagewalk.c also doesn't work properly
> today on S390 and this issue is not really about stack variables?
> 
> Fundamentally if pXX_offset() and pXX_addr_end() must be consistent
> together, if pXX_offset() is folded then pXX_addr_end() must cause a
> single iteration of that level.

Your observation is correct.

Another way to describe the problem is existing pXd_addr_end helpers
could be applied to mismatching levels on s390 (e.g p4d_addr_end
applied to pud or pgd_addr_end applied to p4d). As you noticed,
all *_pXd_range iterators could be called with address ranges that
exceed single pXd table.

However, when it happens with pointers to real page tables (passed to
*_pXd_range iterators) we still operate on valid tables, which just
(lucky for us) happened to be folded. Thus we still reference correct
table entries.

It is only gup_fast case that exposes the issue. It hits because
pointers to stack copies are passed to gup_pXd_range iterators, not
pointers to real page tables itself.

As Gerald mentioned, it is very difficult to explain in a clear way.
Hopefully, one could make sense ot of it.

> Jason
