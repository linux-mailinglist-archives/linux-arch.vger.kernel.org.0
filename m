Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3436D315
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhD1H0x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 03:26:53 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57461 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1H0x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 03:26:53 -0400
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 90F6624000F;
        Wed, 28 Apr 2021 07:26:03 +0000 (UTC)
Subject: Re: [PATCH] riscv: Remove 32b kernel mapping from page table dump
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210418112856.15078-1-alex@ghiti.fr>
 <CAAhSdy3csxeTiXgf8eKnRYhD7BM1LDLPddrn527AkA_-fiEGkw@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <16cd2359-2453-8184-cf96-2c02800abe8a@ghiti.fr>
Date:   Wed, 28 Apr 2021 03:26:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy3csxeTiXgf8eKnRYhD7BM1LDLPddrn527AkA_-fiEGkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Palmer,

Le 4/20/21 à 12:19 AM, Anup Patel a écrit :
> On Sun, Apr 18, 2021 at 4:59 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>
>> The 32b kernel mapping lies in the linear mapping, there is no point in
>> printing its address in page table dump, so remove this leftover that
>> comes from moving the kernel mapping outside the linear mapping for 64b
>> kernel.
>>
>> Fixes: e9efb21fe352 ("riscv: Prepare ptdump for vm layout dynamic addresses")
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> 
> Looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> 
> Regards,
> Anup
> 
>> ---
>>   arch/riscv/mm/ptdump.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
>> index 0aba4421115c..a4ed4bdbbfde 100644
>> --- a/arch/riscv/mm/ptdump.c
>> +++ b/arch/riscv/mm/ptdump.c
>> @@ -76,8 +76,8 @@ enum address_markers_idx {
>>          PAGE_OFFSET_NR,
>>   #ifdef CONFIG_64BIT
>>          MODULES_MAPPING_NR,
>> -#endif
>>          KERNEL_MAPPING_NR,
>> +#endif
>>          END_OF_SPACE_NR
>>   };
>>
>> @@ -99,8 +99,8 @@ static struct addr_marker address_markers[] = {
>>          {0, "Linear mapping"},
>>   #ifdef CONFIG_64BIT
>>          {0, "Modules mapping"},
>> -#endif
>>          {0, "Kernel mapping (kernel, BPF)"},
>> +#endif
>>          {-1, NULL},
>>   };
>>
>> @@ -379,8 +379,8 @@ static int ptdump_init(void)
>>          address_markers[PAGE_OFFSET_NR].start_address = PAGE_OFFSET;
>>   #ifdef CONFIG_64BIT
>>          address_markers[MODULES_MAPPING_NR].start_address = MODULES_VADDR;
>> -#endif
>>          address_markers[KERNEL_MAPPING_NR].start_address = kernel_virt_addr;
>> +#endif
>>
>>          kernel_ptd_info.base_addr = KERN_VIRT_START;
>>
>> --
>> 2.20.1
>>

Do you think you can take this patch too on for-next?

Thanks,

Alex
