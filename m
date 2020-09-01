Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712E0258931
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIAHcm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:32:42 -0400
Received: from foss.arm.com ([217.140.110.172]:37736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAHcm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 03:32:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8002A1FB;
        Tue,  1 Sep 2020 00:32:41 -0700 (PDT)
Received: from [10.163.69.134] (unknown [10.163.69.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DFC33F71F;
        Tue,  1 Sep 2020 00:32:36 -0700 (PDT)
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
Message-ID: <75771782-734b-69f6-4a07-2d3542458319@arm.com>
Date:   Tue, 1 Sep 2020 13:02:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1a8abe92-032b-f60f-1df1-52bb409b35a3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 09/01/2020 11:51 AM, Aneesh Kumar K.V wrote:
> On 9/1/20 8:45 AM, Anshuman Khandual wrote:
>>
>>
>> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>>> ppc64 use bit 62 to indicate a pte entry (_PAGE_PTE). Avoid setting that bit in
>>> random value.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>   mm/debug_vm_pgtable.c | 13 ++++++++++---
>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>> index 086309fb9b6f..bbf9df0e64c6 100644
>>> --- a/mm/debug_vm_pgtable.c
>>> +++ b/mm/debug_vm_pgtable.c
>>> @@ -44,10 +44,17 @@
>>>    * entry type. But these bits might affect the ability to clear entries with
>>>    * pxx_clear() because of how dynamic page table folding works on s390. So
>>>    * while loading up the entries do not change the lower 4 bits. It does not
>>> - * have affect any other platform.
>>> + * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
>>> + * used to mark a pte entry.
>>>    */
>>> -#define S390_MASK_BITS    4
>>> -#define RANDOM_ORVALUE    GENMASK(BITS_PER_LONG - 1, S390_MASK_BITS)
>>> +#define S390_SKIP_MASK        GENMASK(3, 0)
>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>> +#define PPC64_SKIP_MASK        GENMASK(62, 62)
>>> +#else
>>> +#define PPC64_SKIP_MASK        0x0
>>> +#endif
>>
>> Please drop the #ifdef CONFIG_PPC_BOOK3S_64 here. We already accommodate skip
>> bits for a s390 platform requirement and can also do so for ppc64 as well. As
>> mentioned before, please avoid adding any platform specific constructs in the
>> test.
>>
> 
> 
> that is needed so that it can be built on 32 bit architectures.I did face build errors with arch-linux

Could not (#if __BITS_PER_LONG == 32) be used instead or something like
that. But should be a generic conditional check identifying 32 bit arch
not anything platform specific.
