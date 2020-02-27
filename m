Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23FB170E77
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 03:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgB0CeT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 21:34:19 -0500
Received: from foss.arm.com ([217.140.110.172]:44794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgB0CeS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 21:34:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9D9F1FB;
        Wed, 26 Feb 2020 18:34:15 -0800 (PST)
Received: from [10.163.1.119] (unknown [10.163.1.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D8323F819;
        Wed, 26 Feb 2020 18:34:06 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
To:     Christophe Leroy <christophe.leroy@c-s.fr>, Qian Cai <cai@lca.pw>,
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
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
 <1582726182.7365.123.camel@lca.pw> <1582726340.7365.124.camel@lca.pw>
 <eb154054-68ab-a659-065b-f4f7dcbb8671@c-s.fr>
Message-ID: <52db1e9b-83b3-c41f-ef03-0f43e2159a83@arm.com>
Date:   Thu, 27 Feb 2020 08:04:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <eb154054-68ab-a659-065b-f4f7dcbb8671@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/26/2020 08:14 PM, Christophe Leroy wrote:
> 
> 
> Le 26/02/2020 à 15:12, Qian Cai a écrit :
>> On Wed, 2020-02-26 at 09:09 -0500, Qian Cai wrote:
>>> On Mon, 2020-02-17 at 08:47 +0530, Anshuman Khandual wrote:
>>>
>>> How useful is this that straightly crash the powerpc?
>>
>> And then generate warnings on arm64,
>>
>> [  146.634626][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
>> architecture page table helpers
>> [  146.643995][    T1] ------------[ cut here ]------------
>> [  146.649350][    T1] virt_to_phys used for non-linear address:
>> (____ptrval____) (start_kernel+0x0/0x580)
> 
> Must be something wrong with the following in debug_vm_pgtable()
> 
>     paddr = __pa(&start_kernel);
> 
> Is there any explaination why start_kernel() is not in linear memory on ARM64 ?


Cc: + James Morse <james.morse@arm.com>

This warning gets exposed with DEBUG_VIRTUAL due to __pa() on a kernel symbol
i.e 'start_kernel' which might be outside the linear map. This happens due to
kernel mapping position randomization with KASLR. Adding James here in case he
might like to add more.

__pa_symbol() should have been used instead, for accessing the physical address
here. On arm64 __pa() does check for linear address with __is_lm_address() and
switch accordingly if it is a kernel text symbol. Nevertheless, its much better
to use __pa_symbol() here rather than __pa().

Rather than respining the patch once more, will just send a fix replacing this
helper __pa() with __pa_symbol() for Andrew to pick up as this patch is already
part of linux-next (next-20200226). But can definitely respin if that will be
preferred.

Thanks Qian for catching this.

> 
> Christophe
> 
