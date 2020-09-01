Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A225325883C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 08:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIAGbN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 02:31:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41426 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgIAGbN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 02:31:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08162ABa163046;
        Tue, 1 Sep 2020 02:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qSG7OYr31DzJAEZ0fjdEECUakRB9NxXXj+LZHFdQ45U=;
 b=G2S9KXOmuASmgnS7SCAc4rD9zSUGRWLEW/+w1/rFX8WMZjBzUBFIJlw+NpsVKeId2tgb
 m4Ow5wsCp7yajbJK0Ro/GM8BW6p1SqthSGGBxWVeAoyS7m3NI78z5BRSYxblvgcNuvyg
 ppJk2uBnCtBZecKVgNtzSszo36Jd3BsnJS0dkVVhyJdPz84Wlwo5zUE1NKfiDOsG6G8M
 sRpO2pr9R26xqh7Phj7Qs/xLyBX0JQanJqmEc9yzIIhoWeVl3U3H1HA4nm4sf0iaVwlI
 4p383yuRjnGQAmyUk0NmNkHehglxzVqv/xdlgs+R2+mRipdfJam4Odc474a9Uj8pylMU vg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339g0mhpxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 02:30:55 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0816RJ3M007725;
        Tue, 1 Sep 2020 06:30:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 337e9gu38h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 06:30:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0816UplK20644234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 06:30:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B631BAE045;
        Tue,  1 Sep 2020 06:30:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34070AE056;
        Tue,  1 Sep 2020 06:30:48 +0000 (GMT)
Received: from [9.85.87.76] (unknown [9.85.87.76])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 06:30:47 +0000 (GMT)
Subject: Re: [PATCH v3 12/13] mm/debug_vm_pgtable/hugetlb: Disable hugetlb
 test on ppc64
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
 <20200827080438.315345-13-aneesh.kumar@linux.ibm.com>
 <6191e77f-c3b7-21ea-6dbd-eecc09735923@arm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <68f90b44-b830-58be-3c21-424fee05da37@linux.ibm.com>
Date:   Tue, 1 Sep 2020 12:00:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6191e77f-c3b7-21ea-6dbd-eecc09735923@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=895 bulkscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010049
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/1/20 9:33 AM, Anshuman Khandual wrote:
> 
> 
> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>> The seems to be missing quite a lot of details w.r.t allocating
>> the correct pgtable_t page (huge_pte_alloc()), holding the right
>> lock (huge_pte_lock()) etc. The vma used is also not a hugetlb VMA.
>>
>> ppc64 do have runtime checks within CONFIG_DEBUG_VM for most of these.
>> Hence disable the test on ppc64.
> 
> Would really like this to get resolved in an uniform and better way
> instead, i.e a modified hugetlb_advanced_tests() which works on all
> platforms including ppc64.
> 
> In absence of a modified version, I do realize the situation here,
> where DEBUG_VM_PGTABLE test either runs on ppc64 or just completely
> remove hugetlb_advanced_tests() from other platforms as well.
> 
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   mm/debug_vm_pgtable.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index a188b6e4e37e..21329c7d672f 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -813,6 +813,7 @@ static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
>>   #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>>   }
>>   
>> +#ifndef CONFIG_PPC_BOOK3S_64
>>   static void __init hugetlb_advanced_tests(struct mm_struct *mm,
>>   					  struct vm_area_struct *vma,
>>   					  pte_t *ptep, unsigned long pfn,
>> @@ -855,6 +856,7 @@ static void __init hugetlb_advanced_tests(struct mm_struct *mm,
>>   	pte = huge_ptep_get(ptep);
>>   	WARN_ON(!(huge_pte_write(pte) && huge_pte_dirty(pte)));
>>   }
>> +#endif
> 
> In the worst case if we could not get a new hugetlb_advanced_tests() test
> that works on all platforms, this might be the last fallback option. In
> which case, it will require a proper comment section with a "FIXME: ",
> explaining the current situation (and that #ifdef is temporary in nature)
> and a hugetlb_advanced_tests() stub when CONFIG_PPC_BOOK3S_64 is enabled.
> 
>>   #else  /* !CONFIG_HUGETLB_PAGE */
>>   static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot) { }
>>   static void __init hugetlb_advanced_tests(struct mm_struct *mm,
>> @@ -1065,7 +1067,9 @@ static int __init debug_vm_pgtable(void)
>>   	pud_populate_tests(mm, pudp, saved_pmdp);
>>   	spin_unlock(ptl);
>>   
>> +#ifndef CONFIG_PPC_BOOK3S_64
>>   	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
>> +#endif
>

I actually wanted to add #ifdef BROKEN. That test is completely broken. 
Infact I would suggest to remove that test completely.



> #ifdef will not be required here as there would be a stub definition
> for hugetlb_advanced_tests() when CONFIG_PPC_BOOK3S_64 is enabled.
> 
>>   
>>   	spin_lock(&mm->page_table_lock);
>>   	p4d_clear_tests(mm, p4dp);
>>
> 
> But again, we should really try and avoid taking this path.
> 

To be frank i am kind of frustrated with how this patch series is being 
looked at. We pushed a completely broken test to upstream and right now 
we have a code in upstream that crash when booted on ppc64. My attempt 
has been to make progress here and you definitely seems to be not in 
agreement to that.

At this point I am tempted to suggest we remove the DEBUG_VM_PGTABLE 
support on ppc64 because AFAIU it doesn't add any value.


-aneesh
