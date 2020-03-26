Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744AA1942FC
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 16:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCZPYE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Mar 2020 11:24:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59027 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgCZPYE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Mar 2020 11:24:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48p80G6F1Wz9txjy;
        Thu, 26 Mar 2020 16:23:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=QJhesD4w; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NWGJWPMaCs17; Thu, 26 Mar 2020 16:23:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48p80G4yWsz9txhw;
        Thu, 26 Mar 2020 16:23:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585236238; bh=CZedNiiqJ0UJZqFGucqz7RH9S4VZ89sV2dm5t35m/bE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QJhesD4wQa2bJoneY1MwenUCwgUwqSk2wALQ4yKJw1XPxljgbdfEt2iVUC9DtiB+7
         Qp03KQsLcMtvm5iloRRcoXG4f/w4u0Ph+bkyIf3LO/PICDIkvttB2JptzPRNVcj3XJ
         QgjL01MGEvkgL+EWDjA6KH2h4clUrwIDk63DVcjQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2ED0F8B7AB;
        Thu, 26 Mar 2020 16:24:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id H0WwrU9lWfFS; Thu, 26 Mar 2020 16:24:00 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 343758B756;
        Thu, 26 Mar 2020 16:23:58 +0100 (CET)
Subject: Re: [PATCH V2 0/3] mm/debug: Add more arch page table helper tests
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
 <2bb4badc-2b7a-e15d-a99b-b1bd38c9d9bf@arm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a46d18ed-8911-1ec3-c32f-58b6e0d959d7@c-s.fr>
Date:   Thu, 26 Mar 2020 16:23:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2bb4badc-2b7a-e15d-a99b-b1bd38c9d9bf@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 26/03/2020 à 03:23, Anshuman Khandual a écrit :
> 
> 
> On 03/24/2020 10:52 AM, Anshuman Khandual wrote:
>> This series adds more arch page table helper tests. The new tests here are
>> either related to core memory functions and advanced arch pgtable helpers.
>> This also creates a documentation file enlisting all expected semantics as
>> suggested by Mike Rapoport (https://lkml.org/lkml/2020/1/30/40).
>>
>> This series has been tested on arm64 and x86 platforms.
> 
> If folks can test these patches out on remaining ARCH_HAS_DEBUG_VM_PGTABLE
> enabled platforms i.e s390, arc, powerpc (32 and 64), that will be really
> appreciated. Thank you.
> 

On powerpc 8xx (PPC32), I get:

[   53.338368] debug_vm_pgtable: debug_vm_pgtable: Validating 
architecture page table helpers
[   53.347403] ------------[ cut here ]------------
[   53.351832] WARNING: CPU: 0 PID: 1 at mm/debug_vm_pgtable.c:647 
debug_vm_pgtable+0x280/0x3f4
[   53.360140] CPU: 0 PID: 1 Comm: swapper Not tainted 
5.6.0-rc7-s3k-dev-01090-g92710e99881f #3544
[   53.368718] NIP:  c0777c04 LR: c0777bb8 CTR: 00000000
[   53.373720] REGS: c9023df0 TRAP: 0700   Not tainted 
(5.6.0-rc7-s3k-dev-01090-g92710e99881f)
[   53.382042] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 22000222  XER: 20000000
[   53.388667]
[   53.388667] GPR00: c0777bb8 c9023ea8 c6120000 00000001 1e410000 
00000000 00000000 007641c9
[   53.388667] GPR08: 00000000 00000001 00000000 ffffffff 82000222 
00000000 c00039b8 00000000
[   53.388667] GPR16: 00000000 00000000 00000000 fffffff0 065fc000 
1e410000 c6600000 000001e4
[   53.388667] GPR24: 000001d9 c062d14c c65fc000 c642d448 000006c9 
00000000 c65f8000 c65fc040
[   53.423400] NIP [c0777c04] debug_vm_pgtable+0x280/0x3f4
[   53.428559] LR [c0777bb8] debug_vm_pgtable+0x234/0x3f4
[   53.433593] Call Trace:
[   53.436048] [c9023ea8] [c0777bb8] debug_vm_pgtable+0x234/0x3f4 
(unreliable)
[   53.442936] [c9023f28] [c00039e0] kernel_init+0x28/0x124
[   53.448184] [c9023f38] [c000f174] ret_from_kernel_thread+0x14/0x1c
[   53.454245] Instruction dump:
[   53.457180] 41a20008 4bea3ed9 62890021 7d36b92e 7d36b82e 71290fd0 
3149ffff 7d2a4910
[   53.464838] 0f090000 5789077e 3149ffff 7d2a4910 <0f090000> 38c00000 
38a00000 38800000
[   53.472671] ---[ end trace fd5dd92744dc0065 ]---
[   53.519778] Freeing unused kernel memory: 608K

