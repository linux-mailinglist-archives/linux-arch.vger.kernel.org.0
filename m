Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC52589C6
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIAHzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:55:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgIAHzd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 03:55:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0817WoKV140706;
        Tue, 1 Sep 2020 03:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XTtN1jV7Et+1GeMKl4ogc3mT6nlqn7rNPzY6fodlILc=;
 b=WeMGrXOj3vUVmEPVhPMDloTByUNUfWr1R97STPPM5BmD0izC3CZfXJtHcZqNl5DQzwgB
 4e73CzdTi3INFo/8HvUztz/iZA/UpIZQVYGRtewCguyyEh8fKT9xCP25QmbVr1sHpIOx
 8f52syLL5bKCSMRrXEheztpQlyE0CO2ymhoRmbycefwcIFwo7TVFXPIiaCxzRkM0RoMH
 aOEHREG6EnfS8vh9PcsRPU4SLcnVNgHz3DgQe53i04klUWcvzX/6ogul4kIbNtzU7z9O
 /cS0zV9ozyojYi5TFvrlOej13AQiAAa8nkLJcn3Jbo4Iv4CIRVyD14clYjWQcW2AfRsb JA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339g8jbnp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 03:55:09 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0817qArf007322;
        Tue, 1 Sep 2020 07:55:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 337en7hx1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 07:55:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0817t5I221430600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 07:55:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4388111C052;
        Tue,  1 Sep 2020 07:55:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC9E711C05B;
        Tue,  1 Sep 2020 07:55:02 +0000 (GMT)
Received: from [9.85.87.174] (unknown [9.85.87.174])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Sep 2020 07:55:02 +0000 (GMT)
Subject: Re: [PATCH v3 03/13] mm/debug_vm_pgtable/ppc64: Avoid setting top
 bits in radom value
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
 <20200827080438.315345-4-aneesh.kumar@linux.ibm.com>
 <3a0b0101-e6ec-26c5-e104-5b0bb95c3e51@arm.com>
 <1a8abe92-032b-f60f-1df1-52bb409b35a3@linux.ibm.com>
 <75771782-734b-69f6-4a07-2d3542458319@arm.com>
 <e5d32d12-d904-ed8c-8963-d43d2c3744d9@linux.ibm.com>
 <c371e316-7533-62c7-a1c6-9b6745d8d1ea@arm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <3f20130a-f9fc-db9d-50a9-76aca5a1a6d7@linux.ibm.com>
Date:   Tue, 1 Sep 2020 13:25:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c371e316-7533-62c7-a1c6-9b6745d8d1ea@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_04:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010065
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/1/20 1:16 PM, Anshuman Khandual wrote:
> 
> 
> On 09/01/2020 01:06 PM, Aneesh Kumar K.V wrote:
>> On 9/1/20 1:02 PM, Anshuman Khandual wrote:
>>>
>>>
>>> On 09/01/2020 11:51 AM, Aneesh Kumar K.V wrote:
>>>> On 9/1/20 8:45 AM, Anshuman Khandual wrote:
>>>>>
>>>>>
>>>>> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>>>>>> ppc64 use bit 62 to indicate a pte entry (_PAGE_PTE). Avoid setting that bit in
>>>>>> random value.
>>>>>>
>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>> ---
>>>>>>     mm/debug_vm_pgtable.c | 13 ++++++++++---
>>>>>>     1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>>>> index 086309fb9b6f..bbf9df0e64c6 100644
>>>>>> --- a/mm/debug_vm_pgtable.c
>>>>>> +++ b/mm/debug_vm_pgtable.c
>>>>>> @@ -44,10 +44,17 @@
>>>>>>      * entry type. But these bits might affect the ability to clear entries with
>>>>>>      * pxx_clear() because of how dynamic page table folding works on s390. So
>>>>>>      * while loading up the entries do not change the lower 4 bits. It does not
>>>>>> - * have affect any other platform.
>>>>>> + * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
>>>>>> + * used to mark a pte entry.
>>>>>>      */
>>>>>> -#define S390_MASK_BITS    4
>>>>>> -#define RANDOM_ORVALUE    GENMASK(BITS_PER_LONG - 1, S390_MASK_BITS)
>>>>>> +#define S390_SKIP_MASK        GENMASK(3, 0)
>>>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>>>> +#define PPC64_SKIP_MASK        GENMASK(62, 62)
>>>>>> +#else
>>>>>> +#define PPC64_SKIP_MASK        0x0
>>>>>> +#endif
>>>>>
>>>>> Please drop the #ifdef CONFIG_PPC_BOOK3S_64 here. We already accommodate skip
>>>>> bits for a s390 platform requirement and can also do so for ppc64 as well. As
>>>>> mentioned before, please avoid adding any platform specific constructs in the
>>>>> test.
>>>>>
>>>>
>>>>
>>>> that is needed so that it can be built on 32 bit architectures.I did face build errors with arch-linux
>>>
>>> Could not (#if __BITS_PER_LONG == 32) be used instead or something like
>>> that. But should be a generic conditional check identifying 32 bit arch
>>> not anything platform specific.
>>>
>>
>> that _PAGE_PTE bit is pretty much specific to PPC BOOK3S_64.  Not sure why other architectures need to bothered about ignoring bit 62.
> 
> Thats okay as long it does not adversely affect other architectures, ignoring
> some more bits is acceptable. Like existing S390_MASK_BITS gets ignored on all
> other platforms even if it is a s390 specific constraint. Not having platform
> specific #ifdef here, is essential.
> 

Why is it essential?

-aneesh
