Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0112D170171
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 15:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBZOoe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 09:44:34 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55705 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgBZOoe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 09:44:34 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SJV63yfQz9tyg0;
        Wed, 26 Feb 2020 15:44:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=F43a6Y7B; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YgDcVuTElqgx; Wed, 26 Feb 2020 15:44:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SJV62fxZz9tyfy;
        Wed, 26 Feb 2020 15:44:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582728270; bh=eO3lF+ZJhQsxeyroK19gjLYfnwGpenLTxOUpnfp6wIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F43a6Y7Bxj1cRpGgJ7No4+FNv3wTeZbfoxyElYJ0hEHpoYieZmf8wLqib3772js/j
         V7r+2th2c39Iqgq6QxqRNoWCuCyEV5w4Ghrc4DhY5VHlRD+vD7FF2/hwfv7xQkX5JV
         +qPa3ePbwcE1RNrdMbzmCHIISGg1CoUMAAXeaTgU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C9FD18B857;
        Wed, 26 Feb 2020 15:44:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ES6wKYHYICe8; Wed, 26 Feb 2020 15:44:31 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D97098B776;
        Wed, 26 Feb 2020 15:44:29 +0100 (CET)
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
 <1582726182.7365.123.camel@lca.pw> <1582726340.7365.124.camel@lca.pw>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <eb154054-68ab-a659-065b-f4f7dcbb8671@c-s.fr>
Date:   Wed, 26 Feb 2020 15:44:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582726340.7365.124.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 26/02/2020 à 15:12, Qian Cai a écrit :
> On Wed, 2020-02-26 at 09:09 -0500, Qian Cai wrote:
>> On Mon, 2020-02-17 at 08:47 +0530, Anshuman Khandual wrote:
>>
>> How useful is this that straightly crash the powerpc?
> 
> And then generate warnings on arm64,
> 
> [  146.634626][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
> architecture page table helpers
> [  146.643995][    T1] ------------[ cut here ]------------
> [  146.649350][    T1] virt_to_phys used for non-linear address:
> (____ptrval____) (start_kernel+0x0/0x580)

Must be something wrong with the following in debug_vm_pgtable()

	paddr = __pa(&start_kernel);

Is there any explaination why start_kernel() is not in linear memory on 
ARM64 ?

Christophe
