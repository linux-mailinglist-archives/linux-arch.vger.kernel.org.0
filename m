Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC60F178ACE
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 07:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgCDGtF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 01:49:05 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7396 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgCDGtF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Mar 2020 01:49:05 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48XPcF5vVkz9v0st;
        Wed,  4 Mar 2020 07:49:01 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TjnV6xMQ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dW39OVxTZgd8; Wed,  4 Mar 2020 07:49:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48XPcF4ZcKz9v0ss;
        Wed,  4 Mar 2020 07:49:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1583304541; bh=wrQNL9rvesEDlWoNS4tGcfPvGhYnLZNAbgZHq9fGbnE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TjnV6xMQKz2IO1bGDE4HAZJMFDjYTtnjTtNNjZEsh1GJH/DNUiegOPbfzQzRdUJdq
         mfbcsqR6vxFcKaMgtar20QBjEJl5cDZGZqEWM5VabMwt/qfmG0b/5ARzKJJU0pQlpP
         HX98Thi1AQonukArlC4ShOrxhDCLgoABIqbXgKFo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 784788B826;
        Wed,  4 Mar 2020 07:49:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oPUcSMTN_Vcy; Wed,  4 Mar 2020 07:49:02 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A1098B820;
        Wed,  4 Mar 2020 07:49:02 +0100 (CET)
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
To:     Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>
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
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
 <1582726182.7365.123.camel@lca.pw>
 <7c707b7f-ce3d-993b-8042-44fdc1ed28bf@c-s.fr>
 <1582732318.7365.129.camel@lca.pw> <1583178042.7365.146.camel@lca.pw>
 <e8516497-f1b9-b222-e219-73b68880ac75@arm.com>
 <12260F9A-695D-40F8-932F-61D86D77D441@lca.pw>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c022e863-0807-fab1-cd41-3c320381f448@c-s.fr>
Date:   Wed, 4 Mar 2020 07:48:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <12260F9A-695D-40F8-932F-61D86D77D441@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 04/03/2020 à 02:39, Qian Cai a écrit :
> 
>> Below is slightly modified version of your change above and should still
>> prevent the bug on powerpc. Will it be possible for you to re-test this
>> ? Once confirmed, will send a patch enabling this test on powerpc64
>> keeping your authorship. Thank you.
> 
> This works fine on radix MMU but I decided to go a bit future to test hash
> MMU. The kernel will stuck here below. I did confirm that pte_alloc_map_lock()
> was successful, so I don’t understand hash MMU well enough to tell why
> it could still take an interrupt at pte_clear_tests() even before we calls
> pte_unmap_unlock()?

AFAIU, you are not taking an interrupt here. You are stuck in the 
pte_update(), most likely due to nested locks. Try with LOCKDEP ?

Christophe

> 
> [   33.881515][    T1] ok 8 - property-entry
> [   33.883653][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
> architecture page table helpers
> [   60.418885][    C8] watchdog: BUG: soft lockup - CPU#8 stuck for 23s!
> [swapper/0:1]

