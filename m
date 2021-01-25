Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3830274C
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jan 2021 16:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbhAYPvk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jan 2021 10:51:40 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:33499 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbhAYPvi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 10:51:38 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPN7n2tc9z9tycp;
        Mon, 25 Jan 2021 09:19:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id r9zd72zybLeJ; Mon, 25 Jan 2021 09:19:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPN7n1rTrz9tyck;
        Mon, 25 Jan 2021 09:19:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3ECA78B780;
        Mon, 25 Jan 2021 09:19:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9YHVHQQQx1xl; Mon, 25 Jan 2021 09:19:38 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EC7C48B75F;
        Mon, 25 Jan 2021 09:19:37 +0100 (CET)
Subject: Re: [PATCH v10 05/12] mm: HUGE_VMAP arch support cleanup
To:     Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-6-npiggin@gmail.com>
 <20210124114008.GE694255@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <eaa411c5-c3c1-ff87-a671-4059324d0ee1@csgroup.eu>
Date:   Mon, 25 Jan 2021 09:19:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210124114008.GE694255@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 24/01/2021 à 12:40, Christoph Hellwig a écrit :
>> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
>> index 2ca708ab9b20..597b40405319 100644
>> --- a/arch/arm64/include/asm/vmalloc.h
>> +++ b/arch/arm64/include/asm/vmalloc.h
>> @@ -1,4 +1,12 @@
>>   #ifndef _ASM_ARM64_VMALLOC_H
>>   #define _ASM_ARM64_VMALLOC_H
>>   
>> +#include <asm/page.h>
>> +
>> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>> +bool arch_vmap_p4d_supported(pgprot_t prot);
>> +bool arch_vmap_pud_supported(pgprot_t prot);
>> +bool arch_vmap_pmd_supported(pgprot_t prot);
>> +#endif
> 
> Shouldn't the be inlines or macros?  Also it would be useful
> if the architectures would not have to override all functions
> but just those that are it actually implements?
> 
> Also lots of > 80 char lines in the patch.
> 

Since https://github.com/linuxppc/linux/commit/bdc48fa11e46f867ea4d75fa59ee87a7f48be144
this 80 char limit is not strongly enforced anymore.

Allthough 80 is still the prefered limit, code is often more readable with a slightly longer single 
line that with lines splited.

Christophe
