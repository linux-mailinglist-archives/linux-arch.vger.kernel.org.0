Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244C01245E9
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 12:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLRLhz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Dec 2019 06:37:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfLRLhz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 06:37:55 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIBbXnD062289;
        Wed, 18 Dec 2019 06:37:35 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wye06cpfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 06:37:34 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBIBbWmj062239;
        Wed, 18 Dec 2019 06:37:32 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wye06cp6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 06:37:32 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBIBZ9aF005603;
        Wed, 18 Dec 2019 11:37:08 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2wvqc6x6g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 11:37:08 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBIBb7A747448394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 11:37:07 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B010BAC062;
        Wed, 18 Dec 2019 11:37:07 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40DFAAC05B;
        Wed, 18 Dec 2019 11:37:04 +0000 (GMT)
Received: from [9.199.40.202] (unknown [9.199.40.202])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 Dec 2019 11:37:03 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] mm/mmu_gather: Invalidate TLB correctly on batch
 allocation failure and flush
To:     Peter Zijlstra <peterz@infradead.org>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
 <20191218053530.73053-2-aneesh.kumar@linux.ibm.com>
 <20191218091733.GO2844@hirez.programming.kicks-ass.net>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <0f0bea3b-b7b5-fa8c-f75c-396cf78c47b4@linux.ibm.com>
Date:   Wed, 18 Dec 2019 17:07:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218091733.GO2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_03:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=2
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912180097
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/18/19 2:47 PM, Peter Zijlstra wrote:
> On Wed, Dec 18, 2019 at 11:05:29AM +0530, Aneesh Kumar K.V wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> Architectures for which we have hardware walkers of Linux page table should
>> flush TLB on mmu gather batch allocation failures and batch flush. Some
>> architectures like POWER supports multiple translation modes (hash and radix)
> 
> nohash, hash and radix in fact :-)
> 
>> and in the case of POWER only radix translation mode needs the above TLBI.
> 
>> This is because for hash translation mode kernel wants to avoid this extra
>> flush since there are no hardware walkers of linux page table. With radix
>> translation, the hardware also walks linux page table and with that, kernel
>> needs to make sure to TLB invalidate page walk cache before page table pages are
>> freed.
>>
>> More details in
>> commit: d86564a2f085 ("mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE")
>>
>> Fixes: a46cc7a90fd8 ("powerpc/mm/radix: Improve TLB/PWC flushes")
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
> 
>> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
>> index b2c0be93929d..7f3a8b902325 100644
>> --- a/arch/powerpc/include/asm/tlb.h
>> +++ b/arch/powerpc/include/asm/tlb.h
>> @@ -26,6 +26,17 @@
>>   
>>   #define tlb_flush tlb_flush
>>   extern void tlb_flush(struct mmu_gather *tlb);
>> +/*
>> + * book3s:
>> + * Hash does not use the linux page-tables, so we can avoid
>> + * the TLB invalidate for page-table freeing, Radix otoh does use the
>> + * page-tables and needs the TLBI.
>> + *
>> + * nohash:
>> + * We still do TLB invalidate in the __pte_free_tlb routine before we
>> + * add the page table pages to mmu gather table batch.
> 
> I'm a little confused though; if nohash is a software TLB fill, why do
> you need a TLBI for tables?
> 

nohash (AKA book3e) has different mmu modes. I don't follow all the 
details w.r.t book3e. Paul or Michael might be able to explain the need 
for table flush with book3e.

Documentation/powerpc/cpu-faimilies.rst shows different hardware assist 
TLB fill support.

What I wanted to convey with the above comment way we handle only radix 
translation mode with tlb_needs_table_invalidate() check. Other 
translations (hash,  different variants of book3e) are all good because 
of the reason outlined above.

-aneesh
