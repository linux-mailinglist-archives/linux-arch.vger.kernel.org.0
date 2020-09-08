Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E01260C5B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 09:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgIHHr7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 03:47:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728786AbgIHHr5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 03:47:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0887WvWo103539;
        Tue, 8 Sep 2020 03:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7Wyqh7MeIDjAi+eJ5NjBqYqiJMPciT86nd2J6e9RnVc=;
 b=Js9F8PhV3ve4wSZgPSOWcU4+eeye6MkHg/szXsay/J6iuPgAhdofffSX07lx5D0GB0MR
 aF3AWsVsPiNuALSZ2Ww/0ODHXvdsSuWL2ppLGknUwxHOojMVlJKQWQ34+3Z4zGHemuf/
 CG+DBQmn90MfyDRP9EFKac+an9e+LBFMUCrkGiSHfzLuAdo5+lU362NCriWYQIykpxcL
 nTkdHznuDua9GcQmyPXh+3kC0kqSDkEpsTsJH/nm3C7tr5g+T4aKtUwaNYqIXkBH3INy
 MxdZyJfAA/AsR3Auowrl4nya8/gDktt2AioTDodBt0qKN6TD7l4QjnGSkQ6rUS8oadYV QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33e4x71s09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 03:46:46 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0887Xmoc107206;
        Tue, 8 Sep 2020 03:46:46 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33e4x71rye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 03:46:46 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0887g14q000548;
        Tue, 8 Sep 2020 07:46:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 33cm5hhgv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 07:46:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0887kfuH31916436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 07:46:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F7D15204E;
        Tue,  8 Sep 2020 07:46:41 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.35.55])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id E6CF352050;
        Tue,  8 Sep 2020 07:46:39 +0000 (GMT)
Date:   Tue, 8 Sep 2020 09:46:38 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 2/3] mm: make pXd_addr_end() functions page-table
 entry aware
Message-ID: <20200908074638.GA19099@oc3871087118.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
 <31dfb3ed-a0cc-3024-d389-ab9bd19e881f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31dfb3ed-a0cc-3024-d389-ab9bd19e881f@csgroup.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_03:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080066
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 08, 2020 at 07:14:38AM +0200, Christophe Leroy wrote:
> You forgot arch/powerpc/mm/book3s64/subpage_prot.c it seems.

Yes, and also two more sources :/
	arch/powerpc/mm/kasan/8xx.c
	arch/powerpc/mm/kasan/kasan_init_32.c

But these two are not quite obvious wrt pgd_addr_end() used
while traversing pmds. Could you please clarify a bit?


diff --git a/arch/powerpc/mm/kasan/8xx.c b/arch/powerpc/mm/kasan/8xx.c
index 2784224..89c5053 100644
--- a/arch/powerpc/mm/kasan/8xx.c
+++ b/arch/powerpc/mm/kasan/8xx.c
@@ -15,8 +15,8 @@
 	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd += 2, block += SZ_8M) {
 		pte_basic_t *new;
 
-		k_next = pgd_addr_end(k_cur, k_end);
-		k_next = pgd_addr_end(k_next, k_end);
+		k_next = pmd_addr_end(k_cur, k_end);
+		k_next = pmd_addr_end(k_next, k_end);
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index fb29404..3f7d6dc6 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -38,7 +38,7 @@ int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_
 	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
 		pte_t *new;
 
-		k_next = pgd_addr_end(k_cur, k_end);
+		k_next = pmd_addr_end(k_cur, k_end);
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
@@ -196,7 +196,7 @@ void __init kasan_early_init(void)
 	kasan_populate_pte(kasan_early_shadow_pte, PAGE_KERNEL);
 
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pmd_addr_end(addr, end);
 		pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_pte);
 	} while (pmd++, addr = next, addr != end);
 

> Christophe
