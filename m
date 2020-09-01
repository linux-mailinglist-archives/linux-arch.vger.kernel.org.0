Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3355258823
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 08:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIAGZ6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 02:25:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgIAGZ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 02:25:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08163KjH068561;
        Tue, 1 Sep 2020 02:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kWRGaUdmPOig8wv+fxBxDzCZt/Nev1y+4PedObIDZgY=;
 b=LCCu1f/2m1SBE9woxkeLzE2deVGEBLRI+tHE6xi85De/BzUrcuLF9ALnfDfyKSpoNQvu
 oktELGYQtO26KSskVWlLKccYj2Ke45EmJZWazK98WtUySszoZ3624s0I1KwYUjIP3zW4
 XjzN0zd/qnPQOYtU4RRvh3mUoCMhBaUB5BwO1h+oYh8mW6Ty40ShgJ+pOUVpWswZLGL0
 3Xyk976NBJR0xzI9TIwt5iwo8f/ioT8Qqjk+f4emkpIHodU65zfcdc7jEKlRjE+SIMe2
 RiEUZPaPJ1vDwRMzcGmEsvNq3YUMEzX6eDZRy9P8B8xxYsd4JI5IOdi2a9PvDdYQIZvv jw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339df3w19u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 02:25:39 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0816D5jf028190;
        Tue, 1 Sep 2020 06:25:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 337e9gu33b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 06:25:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0816PYt114090542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 06:25:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC830AE051;
        Tue,  1 Sep 2020 06:25:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9018BAE055;
        Tue,  1 Sep 2020 06:25:31 +0000 (GMT)
Received: from [9.85.87.76] (unknown [9.85.87.76])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 06:25:31 +0000 (GMT)
Subject: Re: [PATCH v3 08/13] mm/debug_vm_pgtable/thp: Use page table
 depost/withdraw with THP
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-9-aneesh.kumar@linux.ibm.com>
 <e7877a8d-b433-0cb4-50a7-631de0022c24@arm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <9beaaf93-b2dd-6d56-7737-9f022760f246@linux.ibm.com>
Date:   Tue, 1 Sep 2020 11:55:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e7877a8d-b433-0cb4-50a7-631de0022c24@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010054
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/1/20 8:52 AM, Anshuman Khandual wrote:
> 
> 
> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>> Architectures like ppc64 use deposited page table while updating the huge pte
>> entries.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   mm/debug_vm_pgtable.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index f9f6358899a8..0ce5c6a24c5b 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -154,7 +154,7 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
>>   static void __init pmd_advanced_tests(struct mm_struct *mm,
>>   				      struct vm_area_struct *vma, pmd_t *pmdp,
>>   				      unsigned long pfn, unsigned long vaddr,
>> -				      pgprot_t prot)
>> +				      pgprot_t prot, pgtable_t pgtable)
>>   {
>>   	pmd_t pmd;
>>   
>> @@ -165,6 +165,8 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>>   	/* Align the address wrt HPAGE_PMD_SIZE */
>>   	vaddr = (vaddr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
>>   
>> +	pgtable_trans_huge_deposit(mm, pmdp, pgtable);
>> +
>>   	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>>   	set_pmd_at(mm, vaddr, pmdp, pmd);
>>   	pmdp_set_wrprotect(mm, vaddr, pmdp);
>> @@ -193,6 +195,8 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>>   	pmdp_test_and_clear_young(vma, vaddr, pmdp);
>>   	pmd = READ_ONCE(*pmdp);
>>   	WARN_ON(pmd_young(pmd));
>> +
>> +	pgtable = pgtable_trans_huge_withdraw(mm, pmdp);
> 
> Should the call sites here be wrapped with __HAVE_ARCH_PGTABLE_DEPOSIT and
> __HAVE_ARCH_PGTABLE_WITHDRAW respectively. Though there are generic fallback
> definitions, wondering whether they are indeed essential for all platforms.
> 

No, because Any page table helpers operating on pmd level THP can expect 
a deposited page table.

__HAVE_ARCH_PGTABLE_DEPOSIT indicates that fallback to generic version.

>>   }
>>   
>>   static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>> @@ -373,7 +377,7 @@ static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
>>   static void __init pmd_advanced_tests(struct mm_struct *mm,
>>   				      struct vm_area_struct *vma, pmd_t *pmdp,
>>   				      unsigned long pfn, unsigned long vaddr,
>> -				      pgprot_t prot)
>> +				      pgprot_t prot, pgtable_t pgtable)
>>   {
>>   }
>>   static void __init pud_advanced_tests(struct mm_struct *mm,
>> @@ -1015,7 +1019,7 @@ static int __init debug_vm_pgtable(void)
>>   	pgd_clear_tests(mm, pgdp);
>>   
>>   	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
>> -	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot);
>> +	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
>>   	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
>>   	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
>>   
>>
> 
> There is a checkpatch.pl warning here.
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #7:
> Architectures like ppc64 use deposited page table while updating the huge pte
> 
> total: 0 errors, 1 warnings, 40 lines checked
> 

I will ignore all these, because they are not really important IMHO.

-aneesh
