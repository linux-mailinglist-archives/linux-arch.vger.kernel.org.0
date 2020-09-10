Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFBC264706
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgIJN3f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 09:29:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730889AbgIJN2u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Sep 2020 09:28:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AD94Eo037586;
        Thu, 10 Sep 2020 09:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=QtnNxGocXqrzxtXmh+zLwW3RigR1FCEkXLBN5xsO/Y4=;
 b=AxLsjwHIqfhbwB3BlU3gQerUcgHBbiiujRjuEGnjixXIOpKn0sd0QNxwU/pdnG/FOmdm
 8t+i8v20g0JTEsQ8HE/C9qq+EJpqIuMXS+uEKpHRi/b0/7pCht5fq1XCcXcHXW8BTK2s
 PQT2DcPYGyiyFV7kr62kvhUJPBAUBbf9gI4N3lJNwfILIVDVAvigsgF14nfZxu0uUyxt
 oVBvSmFHpcWk2pB8cgUr7J/n6gkgcF1KAI1tvrzXNCInY46LR+vMUfnPHIzLamCI8scl
 whX6wQsS7WfN6HaWVWfwRxe8yCOQFG1rloDtKfqoiAIKn4Hf7Zg0xN9kZC1PsB2JXiAJ Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fms90naw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 09:28:12 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08ADA9wC048915;
        Thu, 10 Sep 2020 09:28:11 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fms90n9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 09:28:11 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08ADS9ZL026002;
        Thu, 10 Sep 2020 13:28:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 33e5gmsj7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 13:28:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08ADS5Qk31260946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 13:28:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDCEA11C04A;
        Thu, 10 Sep 2020 13:28:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C79811C050;
        Thu, 10 Sep 2020 13:28:04 +0000 (GMT)
Received: from thinkpad (unknown [9.171.93.242])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 10 Sep 2020 13:28:04 +0000 (GMT)
Date:   Thu, 10 Sep 2020 15:28:03 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
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
Message-ID: <20200910152803.1a930afc@thinkpad>
In-Reply-To: <20200910130233.GK87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
        <20200909142904.00b72921@thinkpad>
        <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
        <20200909192534.442f8984@thinkpad>
        <20200909180324.GI87483@ziepe.ca>
        <20200910093925.GB29166@oc3871087118.ibm.com>
        <20200910130233.GK87483@ziepe.ca>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_03:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100120
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 10 Sep 2020 10:02:33 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Sep 10, 2020 at 11:39:25AM +0200, Alexander Gordeev wrote:
> 
> > As Gerald mentioned, it is very difficult to explain in a clear way.
> > Hopefully, one could make sense ot of it.  
> 
> I would say the page table API requires this invariant:
> 
>         pud = pud_offset(p4d, addr);
>         do {
> 		WARN_ON(pud != pud_offset(p4d, addr);
>                 next = pud_addr_end(addr, end);
>         } while (pud++, addr = next, addr != end);
> 
> ie pud++ is supposed to be a shortcut for 
>   pud_offset(p4d, next)
> 
> While S390 does not follow this. Fixing addr_end brings it into
> alignment by preventing pud++ from happening.
> 
> The only currently known side effect is that gup_fast crashes, but it
> sure is an unexpected thing.

It only is unexpected in a "top-level folding" world, see my other reply.
Consider it an optimization, which was possible because of how our dynamic
folding works, and e.g. because we can determine the correct pagetable
level from a pXd value in pXd_offset.

> This suggests another fix, which is to say that pud++ is undefined and
> pud_offset() must always be called, but I think that would cause worse
> codegen on all other archs.

There really is nothing to fix for s390 outside of gup_fast, or other
potential future READ_ONCE pagetable walkers. We do take the side-effect
of the generic change on all other pagetable walkers for s390, but it
really is rather a slight degradation than a fix.
