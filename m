Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB59F258C2E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 11:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIAJ67 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 05:58:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgIAJ66 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 05:58:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0819X5he034189;
        Tue, 1 Sep 2020 05:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S5R2pENwrHGOaDDy4JG4nfqufhMJxjYzq3BcPK7DqqY=;
 b=f+KawktrSIte9wveFyStzdtvU4TzMydyBstvuogEkFvjn6FkoHQox2S2/8TX93xuqLFj
 JowjnOEIbB6tsDmLRzO2Ja3K9tN5SJzrWMDGnlu5PxDeciWtxb384Yi3DtEiRVQPrJr0
 BJeGxG2TuKHZ01KQom4cdF+JUHr8j+DJTaN9rtPR2dpSQlF9O/yPunNYyd/SIY4HHWLu
 rsgHfHGvBDwrDBW/i+IJ1IW87VuiwigHb/U/a1UyeJS08BQSAtoKI/Dcs9jkFn7MinKY
 CGNuDgE0sEZWmCq3cLKagS85i9LUQcNYQLCQighT/piytK2K6WG4IRmL6CpC/3LAN5A/ xw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339gd0pya4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 05:58:38 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0819ump7010963;
        Tue, 1 Sep 2020 09:58:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 337en7j0bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 09:58:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0819wXQQ65143156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 09:58:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94C9111C04C;
        Tue,  1 Sep 2020 09:58:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E9B011C050;
        Tue,  1 Sep 2020 09:58:30 +0000 (GMT)
Received: from [9.85.87.174] (unknown [9.85.87.174])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 09:58:30 +0000 (GMT)
Subject: Re: [PATCH v3 13/13] mm/debug_vm_pgtable: populate a pte entry before
 fetching it
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
 <20200827080438.315345-14-aneesh.kumar@linux.ibm.com>
 <edc68223-7f8a-13df-68eb-9682f585adb8@arm.com>
 <abef1791-8779-6b34-3178-3bf3ab36d42b@linux.ibm.com>
 <e3140b44-993e-aa4b-130d-ee2230eff2b5@arm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <7ef7c302-e7e6-570e-3100-5dd1bf9551be@linux.ibm.com>
Date:   Tue, 1 Sep 2020 15:28:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e3140b44-993e-aa4b-130d-ee2230eff2b5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010080
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/1/20 1:08 PM, Anshuman Khandual wrote:
> 
> 
> On 09/01/2020 12:07 PM, Aneesh Kumar K.V wrote:
>> On 9/1/20 8:55 AM, Anshuman Khandual wrote:
>>>
>>>
>>> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>>>> pte_clear_tests operate on an existing pte entry. Make sure that is not a none
>>>> pte entry.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>    mm/debug_vm_pgtable.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>> index 21329c7d672f..8527ebb75f2c 100644
>>>> --- a/mm/debug_vm_pgtable.c
>>>> +++ b/mm/debug_vm_pgtable.c
>>>> @@ -546,7 +546,7 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
>>>>    static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
>>>>                       unsigned long vaddr)
>>>>    {
>>>> -    pte_t pte = ptep_get(ptep);
>>>> +    pte_t pte =  ptep_get_and_clear(mm, vaddr, ptep);
>>>
>>> Seems like ptep_get_and_clear() here just clears the entry in preparation
>>> for a following set_pte_at() which otherwise would have been a problem on
>>> ppc64 as you had pointed out earlier i.e set_pte_at() should not update an
>>> existing valid entry. So the commit message here is bit misleading.
>>>
>>
>> and also fetch the pte value which is used further.
>>
>>
>>>>          pr_debug("Validating PTE clear\n");
>>>>        pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>>>> @@ -944,7 +944,7 @@ static int __init debug_vm_pgtable(void)
>>>>        p4d_t *p4dp, *saved_p4dp;
>>>>        pud_t *pudp, *saved_pudp;
>>>>        pmd_t *pmdp, *saved_pmdp, pmd;
>>>> -    pte_t *ptep;
>>>> +    pte_t *ptep, pte;
>>>>        pgtable_t saved_ptep;
>>>>        pgprot_t prot, protnone;
>>>>        phys_addr_t paddr;
>>>> @@ -1049,6 +1049,8 @@ static int __init debug_vm_pgtable(void)
>>>>         */
>>>>          ptep = pte_alloc_map_lock(mm, pmdp, vaddr, &ptl);
>>>> +    pte = pfn_pte(pte_aligned, prot);
>>>> +    set_pte_at(mm, vaddr, ptep, pte);
>>>
>>> Not here, creating and populating an entry must be done in respective
>>> test functions itself. Besides, this seems bit redundant as well. The
>>> test pte_clear_tests() with the above change added, already
>>>
>>> - Clears the PTEP entry with ptep_get_and_clear()
>>
>> and fetch the old value set previously.
> 
> In that case, please move above two lines i.e
> 
> pte = pfn_pte(pte_aligned, prot);
> set_pte_at(mm, vaddr, ptep, pte);
> 
> from debug_vm_pgtable() to pte_clear_tests() and update it's arguments
> as required.
> 

Frankly, I don't understand what these tests are testing. It all looks 
like some random clear and set.

static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
				   unsigned long vaddr, unsigned long pfn,
				   pgprot_t prot)
{

	pte_t pte = pfn_pte(pfn, prot);
	set_pte_at(mm, vaddr, ptep, pte);

	pte =  ptep_get_and_clear(mm, vaddr, ptep);

	pr_debug("Validating PTE clear\n");
	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
	set_pte_at(mm, vaddr, ptep, pte);
	barrier();
	pte_clear(mm, vaddr, ptep);
	pte = ptep_get(ptep);
	WARN_ON(!pte_none(pte));
}


-aneesh
