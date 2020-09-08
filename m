Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C9B2619D0
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 20:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbgIHS0j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 14:26:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59320 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731143AbgIHQKc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 12:10:32 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088C2N45026586;
        Tue, 8 Sep 2020 08:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bk5rcbbcZuqui6iq7AaxW7ch2nhktIj2N2mRiYGdeNc=;
 b=MRw17lZ3R27QmcBHd47Fndtm2NABJ8kSHHGObMDEzjXiJcYacpSSSkwMCuRJY+2J1P0h
 uSk5My/MlHdnMpJm2VpUcLvRCKEEivbXndVUMjGChBI7RhmXvLbQ1Ix1HXZnVzWBOW3v
 uHp/VtSlenVmLcuE8LRYM7I9iaVff2PXFPhHGtpPDbK9CjXWWwIJRE5zjpC+HKFuLqwz
 USj5YwAc1BxEhwlJABAmYQbM4fB+eqrYloJrg/ekOu7luwRNHWWQSdkHe1YfePlCirHk
 +rJd3blnyz/zrlDvfSSv/1cMsSh3SpGkXXBz1OStd036QGEFhdMH8H0nWD+Kk+vGaEwM fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33e8vpscxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 08:11:13 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 088C2UDW027254;
        Tue, 8 Sep 2020 08:10:26 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33e8vpsca9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 08:10:26 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088C7w5q006594;
        Tue, 8 Sep 2020 12:09:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 33e5gmr53e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 12:09:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088C7UiP58196288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 12:07:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61964AE056;
        Tue,  8 Sep 2020 12:09:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98841AE051;
        Tue,  8 Sep 2020 12:09:01 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.146.40])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Sep 2020 12:09:01 +0000 (GMT)
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
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
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <82fbe8f9-f199-5fc2-4168-eb43ad0b0346@csgroup.eu>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Message-ID: <70a3dcb5-5ed1-6efa-6158-d0573d6927da@de.ibm.com>
Date:   Tue, 8 Sep 2020 14:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <82fbe8f9-f199-5fc2-4168-eb43ad0b0346@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_06:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009080108
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 08.09.20 07:06, Christophe Leroy wrote:
> 
> 
> Le 07/09/2020 à 20:00, Gerald Schaefer a écrit :
>> From: Alexander Gordeev <agordeev@linux.ibm.com>
>>
>> Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
>> code") introduced a subtle but severe bug on s390 with gup_fast, due to
>> dynamic page table folding.
>>
>> The question "What would it require for the generic code to work for s390"
>> has already been discussed here
>> https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
>> and ended with a promising approach here
>> https://lkml.kernel.org/r/20190419153307.4f2911b5@mschwideX1
>> which in the end unfortunately didn't quite work completely.
>>
>> We tried to mimic static level folding by changing pgd_offset to always
>> calculate top level page table offset, and do nothing in folded pXd_offset.
>> What has been overlooked is that PxD_SIZE/MASK and thus pXd_addr_end do
>> not reflect this dynamic behaviour, and still act like static 5-level
>> page tables.
>>
> 
> [...]
> 
>>
>> Fix this by introducing new pXd_addr_end_folded helpers, which take an
>> additional pXd entry value parameter, that can be used on s390
>> to determine the correct page table level and return corresponding
>> end / boundary. With that, the pointer iteration will always
>> happen in gup_pgd_range for s390. No change for other architectures
>> introduced.
> 
> Not sure pXd_addr_end_folded() is the best understandable name, allthough I don't have any alternative suggestion at the moment.
> Maybe could be something like pXd_addr_end_fixup() as it will disappear in the next patch, or pXd_addr_end_gup() ?
> 
> Also, if it happens to be acceptable to get patch 2 in stable, I think you should switch patch 1 and patch 2 to avoid the step through pXd_addr_end_folded()

given that this fixes a data corruption issue, wouldnt it be the best to go forward
with this patch ASAP and then handle the other patches on top with all the time that
we need?
> 
> 
>>
>> Fixes: 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")
>> Cc: <stable@vger.kernel.org> # 5.2+
>> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pgtable.h | 42 +++++++++++++++++++++++++++++++++
>>   include/linux/pgtable.h         | 16 +++++++++++++
>>   mm/gup.c                        |  8 +++----
>>   3 files changed, 62 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
>> index 7eb01a5459cd..027206e4959d 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -512,6 +512,48 @@ static inline bool mm_pmd_folded(struct mm_struct *mm)
>>   }
>>   #define mm_pmd_folded(mm) mm_pmd_folded(mm)
>>   +/*
>> + * With dynamic page table levels on s390, the static pXd_addr_end() functions
>> + * will not return corresponding dynamic boundaries. This is no problem as long
>> + * as only pXd pointers are passed down during page table walk, because
>> + * pXd_offset() will simply return the given pointer for folded levels, and the
>> + * pointer iteration over a range simply happens at the correct page table
>> + * level.
>> + * It is however a problem with gup_fast, or other places walking the page
>> + * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
>> + * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
>> + * a stack variable, which cannot be used for pointer iteration at the correct
>> + * level. Instead, the iteration then has to happen by going up to pgd level
>> + * again. To allow this, provide pXd_addr_end_folded() functions with an
>> + * additional pXd value parameter, which can be used on s390 to determine the
>> + * folding level and return the corresponding boundary.
>> + */
>> +static inline unsigned long rste_addr_end_folded(unsigned long rste, unsigned long addr, unsigned long end)
> 
> What does 'rste' stands for ?
> 
> Isn't this line a bit long ?

this is region/segment table entry according to the architecture. 
On our platform we do have the pagetables with a different format that
next levels (segment table -> 1MB granularity, region 3rd table -> 2 GB
granularity, region 2nd table -> 4TB granularity, region 1st table -> 8 PB
granularity. ST,R3,R2,R1 have the same format and are thus often called
crste (combined region and segment table entry).
