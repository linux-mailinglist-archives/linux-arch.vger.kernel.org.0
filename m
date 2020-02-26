Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668CF17017F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 15:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBZOp4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 09:45:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9795 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgBZOpz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 09:45:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SJWh2b55z9tyg4;
        Wed, 26 Feb 2020 15:45:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kZ5bMkLJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id piYm9Kq-bip3; Wed, 26 Feb 2020 15:45:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SJWh1L1mz9tyg0;
        Wed, 26 Feb 2020 15:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582728352; bh=BEQC+OIkud+eji3D9C1xajaOV2PnlEzJtZsCBcvukA0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kZ5bMkLJJRmtE/zBn7tAG22RVlZ+eB59QhJ/5515+FA1qAhZsJh2OjTNrixj9vTDj
         g9hhT1i5/9dal9tTCQtAXzKPCb1/TtYD/lHCsid2jxvbbY8kYL0AVDIy3f2yCgUqIz
         SvUkhU4c68nXEu7I9g1qKkvWUZk1WgTaY/zVbTdo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 93C978B858;
        Wed, 26 Feb 2020 15:45:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AccKIxhc_qaM; Wed, 26 Feb 2020 15:45:53 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 75D1B8B776;
        Wed, 26 Feb 2020 15:45:51 +0100 (CET)
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
To:     Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
 <1582726182.7365.123.camel@lca.pw>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7c707b7f-ce3d-993b-8042-44fdc1ed28bf@c-s.fr>
Date:   Wed, 26 Feb 2020 15:45:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582726182.7365.123.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 26/02/2020 à 15:09, Qian Cai a écrit :
> On Mon, 2020-02-17 at 08:47 +0530, Anshuman Khandual wrote:
>> This adds tests which will validate architecture page table helpers and
>> other accessors in their compliance with expected generic MM semantics.
>> This will help various architectures in validating changes to existing
>> page table helpers or addition of new ones.
>>
>> This test covers basic page table entry transformations including but not
>> limited to old, young, dirty, clean, write, write protect etc at various
>> level along with populating intermediate entries with next page table page
>> and validating them.
>>
>> Test page table pages are allocated from system memory with required size
>> and alignments. The mapped pfns at page table levels are derived from a
>> real pfn representing a valid kernel text symbol. This test gets called
>> inside kernel_init() right after async_synchronize_full().
>>
>> This test gets built and run when CONFIG_DEBUG_VM_PGTABLE is selected. Any
>> architecture, which is willing to subscribe this test will need to select
>> ARCH_HAS_DEBUG_VM_PGTABLE. For now this is limited to arc, arm64, x86, s390
>> and ppc32 platforms where the test is known to build and run successfully.
>> Going forward, other architectures too can subscribe the test after fixing
>> any build or runtime problems with their page table helpers. Meanwhile for
>> better platform coverage, the test can also be enabled with CONFIG_EXPERT
>> even without ARCH_HAS_DEBUG_VM_PGTABLE.
>>
>> Folks interested in making sure that a given platform's page table helpers
>> conform to expected generic MM semantics should enable the above config
>> which will just trigger this test during boot. Any non conformity here will
>> be reported as an warning which would need to be fixed. This test will help
>> catch any changes to the agreed upon semantics expected from generic MM and
>> enable platforms to accommodate it thereafter.
> 
> How useful is this that straightly crash the powerpc?
> 
> [   23.263425][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
> architecture page table helpers
> [   23.263625][    T1] ------------[ cut here ]------------
> [   23.263649][    T1] kernel BUG at arch/powerpc/mm/pgtable.c:274!

The problem on PPC64 is known and has to be investigated and fixed.

Christophe
