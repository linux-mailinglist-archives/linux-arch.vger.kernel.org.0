Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1B296E18
	for <lists+linux-arch@lfdr.de>; Fri, 23 Oct 2020 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463303AbgJWL61 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Oct 2020 07:58:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8417 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463298AbgJWL6U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Oct 2020 07:58:20 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CHjRV0CCKz9v03C;
        Fri, 23 Oct 2020 13:58:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7G-FT5rRhz1r; Fri, 23 Oct 2020 13:58:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CHjRT6NvJz9v036;
        Fri, 23 Oct 2020 13:58:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B5098B869;
        Fri, 23 Oct 2020 13:58:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1m4yl6SK3FoB; Fri, 23 Oct 2020 13:58:15 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73E308B85E;
        Fri, 23 Oct 2020 13:58:14 +0200 (CEST)
Subject: Re: [PATCH v8 2/8] powerpc/vdso: Remove __kernel_datapage_offset and
 simplify __get_datapage()
To:     Will Deacon <will@kernel.org>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <87wo34tbas.fsf@mpe.ellerman.id.au>
 <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu>
 <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu>
 <87imd5h5kb.fsf@mpe.ellerman.id.au>
 <CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com>
 <87a6yf34aj.fsf@mpe.ellerman.id.au> <20200921112638.GC2139@willie-the-truck>
 <ad72ffd3-a552-cc98-7545-d30285fd5219@csgroup.eu>
 <542145eb-7d90-0444-867e-c9cbb6bdd8e3@gmail.com>
 <ba9861da-2f5b-a649-5626-af00af634546@csgroup.eu>
 <20201023112514.GE20933@willie-the-truck>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <284cacf4-9811-4b67-385c-2783a7cd9b31@csgroup.eu>
Date:   Fri, 23 Oct 2020 13:57:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201023112514.GE20933@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 23/10/2020 à 13:25, Will Deacon a écrit :
> On Fri, Oct 23, 2020 at 01:22:04PM +0200, Christophe Leroy wrote:
>> Hi Dmitry,
>>
>> Le 28/09/2020 à 17:08, Dmitry Safonov a écrit :
>>> On 9/27/20 8:43 AM, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 21/09/2020 à 13:26, Will Deacon a écrit :
>>>>> On Fri, Aug 28, 2020 at 12:14:28PM +1000, Michael Ellerman wrote:
>>>>>> Dmitry Safonov <0x7f454c46@gmail.com> writes:
>>> [..]
>>>>>>> I'll cook a patch for vm_special_mapping if you don't mind :-)
>>>>>>
>>>>>> That would be great, thanks!
>>>>>
>>>>> I lost track of this one. Is there a patch kicking around to resolve
>>>>> this,
>>>>> or is the segfault expected behaviour?
>>>>>
>>>>
>>>> IIUC dmitry said he will cook a patch. I have not seen any patch yet.
>>>
>>> Yes, sorry about the delay - I was a bit busy with xfrm patches.
>>>
>>> I'll send patches for .close() this week, working on them now.
>>
>> I haven't seen the patches, did you sent them out finally ?
> 
> I think it's this series:
> 
> https://lore.kernel.org/r/20201013013416.390574-1-dima@arista.com
> 
> but they look really invasive to me, so I may cook a small hack for arm64
> in the meantine / for stable.
> 

Not sure we are talking about the same thing.

I can't see any new .close function added to vm_special_mapping in order to replace arch_unmap() hook.

Christophe
