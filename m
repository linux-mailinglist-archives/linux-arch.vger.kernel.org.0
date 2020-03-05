Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5861E179F61
	for <lists+linux-arch@lfdr.de>; Thu,  5 Mar 2020 06:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgCEFng (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Mar 2020 00:43:36 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10515 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCEFnf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 00:43:35 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Y06D6b32z9v0Cs;
        Thu,  5 Mar 2020 06:43:32 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UCg+E84G; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VTVXXCiiDbWA; Thu,  5 Mar 2020 06:43:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Y06D4WRtz9v0Cr;
        Thu,  5 Mar 2020 06:43:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1583387012; bh=O7lgY+PnhSJPbSOI4sr3mclek/SOkIJfidyuwCRZt5E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UCg+E84GGdl1tJQVZH1Ovf1X2MFT1jANeg/avNyTa/wgDK/AFcZlsHC6wtBCTreEW
         IIBoeTbu/OvYV0fGWK+oS5bBaBBh3LdZWCoVTQj2d42uZgyX7h61ciJf6DYFn7C5sq
         y7FFPsJ/rH3Z+NZSn+w0vMP0V2uU5bzXosVLrKE4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5850C8B78D;
        Thu,  5 Mar 2020 06:43:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id y-ltjW1KjHqS; Thu,  5 Mar 2020 06:43:33 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9213B8B756;
        Thu,  5 Mar 2020 06:43:31 +0100 (CET)
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Qian Cai <cai@lca.pw>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <c022e863-0807-fab1-cd41-3c320381f448@c-s.fr>
 <11F41980-97CF-411F-8120-41287DC1A382@lca.pw>
 <57a3bc61-bbd5-e251-9621-7bc28f7901a1@arm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bcba7b7f-f351-4ee7-d74e-004a0bfbee47@c-s.fr>
Date:   Thu, 5 Mar 2020 06:43:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <57a3bc61-bbd5-e251-9621-7bc28f7901a1@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 05/03/2020 à 01:54, Anshuman Khandual a écrit :
> 
> 
> On 03/04/2020 04:59 PM, Qian Cai wrote:
>>
>>
>>> On Mar 4, 2020, at 1:49 AM, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>
>>> AFAIU, you are not taking an interrupt here. You are stuck in the pte_update(), most likely due to nested locks. Try with LOCKDEP ?
>>
>> Not exactly sure what did you mean here, but the kernel has all lockdep enabled and did not flag anything here.
> 
> As the patch has been dropped from Linux next (next-20200304) perhaps in
> order to fold back the __pa_symbol() fix [1], so I am planning to respin
> the original patch once more as V15 while adding Qian's signed off by for
> the powerpc part. For now lets enable radix MMU ppc64 along with existing
> ppc32. As PPC_RADIX_MMU depends on PPC_BOOK3S_64, the following change
> should be good enough ?

I don't think so, even if you have the Radix MMU compiled in, hash MMU 
is used when Radix is not available or disabled. So until the Hash MMU 
problem is fixed, you cannot enable it by default.

Christophe
