Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF00361E32
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 12:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbhDPKrt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 06:47:49 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36217 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhDPKrt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Apr 2021 06:47:49 -0400
X-Originating-IP: 81.185.167.252
Received: from [192.168.43.237] (252.167.185.81.rev.sfr.net [81.185.167.252])
        (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 62B3840011;
        Fri, 16 Apr 2021 10:47:18 +0000 (UTC)
Subject: Re: [PATCH] riscv: Protect kernel linear mapping only if
 CONFIG_STRICT_KERNEL_RWX is set
To:     Anup Patel <anup@brainfault.org>
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
References: <20210415110426.2238-1-alex@ghiti.fr>
 <CAAhSdy2pD2q99-g3QSSHbpqw1ZD402fStFmbKNFzht2m=MS8mQ@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <f659c498-a273-f249-a81b-cab1ed1ba2bb@ghiti.fr>
Date:   Fri, 16 Apr 2021 06:47:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy2pD2q99-g3QSSHbpqw1ZD402fStFmbKNFzht2m=MS8mQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anup,

Le 4/16/21 à 6:41 AM, Anup Patel a écrit :
> On Thu, Apr 15, 2021 at 4:34 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>
>> If CONFIG_STRICT_KERNEL_RWX is not set, we cannot set different permissions
>> to the kernel data and text sections, so make sure it is defined before
>> trying to protect the kernel linear mapping.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> 
> Maybe you should add "Fixes:" tag in commit tag ?

Yes you're right I should have done that. Maybe Palmer will squash it as 
it just entered for-next?

> 
> Otherwise it looks good.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thank you!

Alex

> 
> Regards,
> Anup
> 
>> ---
>>   arch/riscv/kernel/setup.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 626003bb5fca..ab394d173cd4 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -264,12 +264,12 @@ void __init setup_arch(char **cmdline_p)
>>
>>          sbi_init();
>>
>> -       if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
>> +       if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
>>                  protect_kernel_text_data();
>> -
>> -#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>> -       protect_kernel_linear_mapping_text_rodata();
>> +#ifdef CONFIG_64BIT
>> +               protect_kernel_linear_mapping_text_rodata();
>>   #endif
>> +       }
>>
>>   #ifdef CONFIG_SWIOTLB
>>          swiotlb_init(1);
>> --
>> 2.20.1
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
