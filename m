Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F98258812
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 08:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgIAGXc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 02:23:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgIAGXc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 02:23:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0816ESPV092614;
        Tue, 1 Sep 2020 02:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yoyRoKGbWHQ33j2r6pSr82DlMFsFpDBXh6XA8dUNRIk=;
 b=VR8oUlLxF1O0hJSqODn4dTKbwJQ2yNFGsI2UtoesnXKWPBz6PUqjCe5W3iPH4b96czHs
 TCwNjgI0z2asJXkw7g0d4YlF2uPlYf+rZXALMovuk11kfwryh4FC33JgwaiQg1EKKuda
 M0kwxNMetcdM6xPs9BQJa08U1/qikmCzAqrZBh4WD8etQ3K2hro/hy0NLvGqXqLc7mOr
 c8e0+DOf319tkS5iDCwgDqbDORTTNMi3lNSrBHPOEWrYzVE3M/1eqYrRNuGXcKWyPpEM
 YUK7bk6YONspTDjE5ZIDRVkkuG/cs26oJBtVdxE9CfgfJoWImRtPs86BugdpVMU5gAmt 0Q== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339gup86nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 02:23:11 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0816CGor024734;
        Tue, 1 Sep 2020 06:23:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 337en7hvbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 06:23:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0816N6LW24576424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 06:23:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB52FAE04D;
        Tue,  1 Sep 2020 06:23:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8C42AE053;
        Tue,  1 Sep 2020 06:23:03 +0000 (GMT)
Received: from [9.85.87.76] (unknown [9.85.87.76])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 06:23:03 +0000 (GMT)
Subject: Re: [PATCH v3 06/13] mm/debug_vm_pgtable/THP: Mark the pte entry huge
 before using set_pmd/pud_at
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
 <20200827080438.315345-7-aneesh.kumar@linux.ibm.com>
 <37558832-9cb6-9a11-0009-e268ad51c1f3@arm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <60857a9f-0df2-ff19-d857-8e8582e85099@linux.ibm.com>
Date:   Tue, 1 Sep 2020 11:53:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <37558832-9cb6-9a11-0009-e268ad51c1f3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010054
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/1/20 8:51 AM, Anshuman Khandual wrote:
> 
> 
> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>> kernel expects entries to be marked huge before we use set_pmd_at()/set_pud_at().
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   mm/debug_vm_pgtable.c | 21 ++++++++++++---------
>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 5c0680836fe9..de83a20c1b30 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -155,7 +155,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>>   				      unsigned long pfn, unsigned long vaddr,
>>   				      pgprot_t prot)
>>   {
>> -	pmd_t pmd = pfn_pmd(pfn, prot);
>> +	pmd_t pmd;
>>   
>>   	if (!has_transparent_hugepage())
>>   		return;
>> @@ -164,19 +164,19 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>>   	/* Align the address wrt HPAGE_PMD_SIZE */
>>   	vaddr = (vaddr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
>>   
>> -	pmd = pfn_pmd(pfn, prot);
>> +	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>>   	set_pmd_at(mm, vaddr, pmdp, pmd);
>>   	pmdp_set_wrprotect(mm, vaddr, pmdp);
>>   	pmd = READ_ONCE(*pmdp);
>>   	WARN_ON(pmd_write(pmd));
>>   
>> -	pmd = pfn_pmd(pfn, prot);
>> +	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>>   	set_pmd_at(mm, vaddr, pmdp, pmd);
>>   	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
>>   	pmd = READ_ONCE(*pmdp);
>>   	WARN_ON(!pmd_none(pmd));
>>   
>> -	pmd = pfn_pmd(pfn, prot);
>> +	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>>   	pmd = pmd_wrprotect(pmd);
>>   	pmd = pmd_mkclean(pmd);
>>   	set_pmd_at(mm, vaddr, pmdp, pmd);
>> @@ -237,7 +237,7 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>>   
>>   static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>>   {
>> -	pmd_t pmd = pfn_pmd(pfn, prot);
>> +	pmd_t pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
> 
> There is no set_pmd_at() in this particular test, why change ?


because if you are building a hugepage you should use pmd_mkhuge(). That 
is what is setting _PAGE_PTE with this series. We don't make pfn_pmd set 
_PAGE_PTE


-aneesh
