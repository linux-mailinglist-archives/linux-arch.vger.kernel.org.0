Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5825A41D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 05:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBDqA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 23:46:00 -0400
Received: from foss.arm.com ([217.140.110.172]:56714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBDp7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 23:45:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 370CDD6E;
        Tue,  1 Sep 2020 20:45:59 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 382A73F66F;
        Tue,  1 Sep 2020 20:45:54 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 03/13] mm/debug_vm_pgtable/ppc64: Avoid setting top
 bits in radom value
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
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
 <3f20130a-f9fc-db9d-50a9-76aca5a1a6d7@linux.ibm.com>
Message-ID: <2f6f2e26-5c77-d9cb-667c-0f7d35923e31@arm.com>
Date:   Wed, 2 Sep 2020 09:15:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3f20130a-f9fc-db9d-50a9-76aca5a1a6d7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 09/01/2020 01:25 PM, Aneesh Kumar K.V wrote:
> On 9/1/20 1:16 PM, Anshuman Khandual wrote:
>>
>>
>> On 09/01/2020 01:06 PM, Aneesh Kumar K.V wrote:
>>> On 9/1/20 1:02 PM, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 09/01/2020 11:51 AM, Aneesh Kumar K.V wrote:
>>>>> On 9/1/20 8:45 AM, Anshuman Khandual wrote:
>>>>>>
>>>>>>
>>>>>> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>>>>>>> ppc64 use bit 62 to indicate a pte entry (_PAGE_PTE). Avoid setting that bit in
>>>>>>> random value.
>>>>>>>
>>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>>> ---
>>>>>>>     mm/debug_vm_pgtable.c | 13 ++++++++++---
>>>>>>>     1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>>>>> index 086309fb9b6f..bbf9df0e64c6 100644
>>>>>>> --- a/mm/debug_vm_pgtable.c
>>>>>>> +++ b/mm/debug_vm_pgtable.c
>>>>>>> @@ -44,10 +44,17 @@
>>>>>>>      * entry type. But these bits might affect the ability to clear entries with
>>>>>>>      * pxx_clear() because of how dynamic page table folding works on s390. So
>>>>>>>      * while loading up the entries do not change the lower 4 bits. It does not
>>>>>>> - * have affect any other platform.
>>>>>>> + * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
>>>>>>> + * used to mark a pte entry.
>>>>>>>      */
>>>>>>> -#define S390_MASK_BITS    4
>>>>>>> -#define RANDOM_ORVALUE    GENMASK(BITS_PER_LONG - 1, S390_MASK_BITS)
>>>>>>> +#define S390_SKIP_MASK        GENMASK(3, 0)
>>>>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>>>>> +#define PPC64_SKIP_MASK        GENMASK(62, 62)
>>>>>>> +#else
>>>>>>> +#define PPC64_SKIP_MASK        0x0
>>>>>>> +#endif
>>>>>>
>>>>>> Please drop the #ifdef CONFIG_PPC_BOOK3S_64 here. We already accommodate skip
>>>>>> bits for a s390 platform requirement and can also do so for ppc64 as well. As
>>>>>> mentioned before, please avoid adding any platform specific constructs in the
>>>>>> test.
>>>>>>
>>>>>
>>>>>
>>>>> that is needed so that it can be built on 32 bit architectures.I did face build errors with arch-linux
>>>>
>>>> Could not (#if __BITS_PER_LONG == 32) be used instead or something like
>>>> that. But should be a generic conditional check identifying 32 bit arch
>>>> not anything platform specific.
>>>>
>>>
>>> that _PAGE_PTE bit is pretty much specific to PPC BOOK3S_64.  Not sure why other architectures need to bothered about ignoring bit 62.
>>
>> Thats okay as long it does not adversely affect other architectures, ignoring
>> some more bits is acceptable. Like existing S390_MASK_BITS gets ignored on all
>> other platforms even if it is a s390 specific constraint. Not having platform
>> specific #ifdef here, is essential.
>>
> 
> Why is it essential?
IIRC, I might have already replied on this couple of times. But let me try once more.
It is a generic test aimed at finding inconsistencies between different architectures
in terms of the page table helper semantics. Any platform specific construct here, to
'make things work' has the potential to hide such inconsistencies and defeat the very
purpose. The test/file here follows this rule consistently i.e there is not a single
platform specific #ifdef right now and would really like to continue maintaining this
property, unless until absolutely necessary. Current situation here wrt 32 bit archs
can easily be accommodated with a generic check such as __BITS_PER_LONG.
