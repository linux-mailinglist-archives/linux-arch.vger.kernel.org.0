Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4982A251A93
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgHYOQP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 10:16:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9286 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHYOQP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 10:16:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BbWHt0vQ2z9tx1l;
        Tue, 25 Aug 2020 16:16:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pJ2ZT6WP1cSM; Tue, 25 Aug 2020 16:16:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BbWHs4Dvlz9txlt;
        Tue, 25 Aug 2020 16:16:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 01BDA8B823;
        Tue, 25 Aug 2020 16:16:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PErXmI-tRVWl; Tue, 25 Aug 2020 16:16:07 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7380D8B820;
        Tue, 25 Aug 2020 16:16:04 +0200 (CEST)
Subject: Re: [PATCH v8 2/8] powerpc/vdso: Remove __kernel_datapage_offset and
 simplify __get_datapage()
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com
Cc:     linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
 <0d2201efe3c7727f2acc718aefd7c5bb22c66c57.1588079622.git.christophe.leroy@c-s.fr>
 <87wo34tbas.fsf@mpe.ellerman.id.au>
 <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu>
Message-ID: <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu>
Date:   Tue, 25 Aug 2020 16:15:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 04/08/2020 à 13:17, Christophe Leroy a écrit :
> 
> 
> On 07/16/2020 02:59 AM, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> The VDSO datapage and the text pages are always located immediately
>>> next to each other, so it can be hardcoded without an indirection
>>> through __kernel_datapage_offset
>>>
>>> In order to ease things, move the data page in front like other
>>> arches, that way there is no need to know the size of the library
>>> to locate the data page.
>>>
[...]

>>
>> I merged this but then realised it breaks the display of the vdso in 
>> /proc/self/maps.
>>
>> ie. the vdso vma gets no name:
>>
>>    # cat /proc/self/maps

[...]

>>
>>
>> And it's also going to break the logic in arch_unmap() to detect if
>> we're unmapping (part of) the VDSO. And it will break arch_remap() too.
>>
>> And the logic to recognise the signal trampoline in
>> arch/powerpc/perf/callchain_*.c as well.
> 
> I don't think it breaks that one, because ->vdsobase is still the start 
> of text.
> 
>>
>> So I'm going to rebase and drop this for now.
>>
>> Basically we have a bunch of places that assume that vdso_base is == the
>> start of the VDSO vma, and also that the code starts there. So that will
>> need some work to tease out all those assumptions and make them work
>> with this change.
> 
> Ok, one day I need to look at it in more details and see how other 
> architectures handle it etc ...
> 

I just sent out a series which switches powerpc to the new 
_install_special_mapping() API, the one powerpc uses being deprecated 
since commit a62c34bd2a8a ("x86, mm: Improve _install_special_mapping
and fix x86 vdso naming")

arch_remap() gets replaced by vdso_remap()

For arch_unmap(), I'm wondering how/what other architectures do, because 
powerpc seems to be the only one to erase the vdso context pointer when 
unmapping the vdso. So far I updated it to take into account the pages 
switch.

Everything else is not impacted because our vdso_base is still the base 
of the text and that's what those things (signal trampoline, callchain, 
...) expect.

Maybe we should change it to 'void *vdso' in the same way as other 
architectures, as it is not anymore the exact vdso_base but the start of 
VDSO text.

Note that the series applies on top of the generic C VDSO implementation 
series. However all but the last commit cleanly apply without that 
series. As that last commit is just an afterwork cleanup, it can come in 
a second step.

Christophe
