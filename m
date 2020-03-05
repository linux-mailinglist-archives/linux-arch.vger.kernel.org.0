Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83FB179FE9
	for <lists+linux-arch@lfdr.de>; Thu,  5 Mar 2020 07:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgCEGXX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Mar 2020 01:23:23 -0500
Received: from foss.arm.com ([217.140.110.172]:43564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCEGXX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 01:23:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17EB71FB;
        Wed,  4 Mar 2020 22:23:23 -0800 (PST)
Received: from [10.163.1.88] (unknown [10.163.1.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D1843F534;
        Wed,  4 Mar 2020 22:27:09 -0800 (PST)
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
To:     Christophe Leroy <christophe.leroy@c-s.fr>, Qian Cai <cai@lca.pw>
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
 <bcba7b7f-f351-4ee7-d74e-004a0bfbee47@c-s.fr>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d198fc5a-5337-c346-a21c-1ff133202e68@arm.com>
Date:   Thu, 5 Mar 2020 11:53:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bcba7b7f-f351-4ee7-d74e-004a0bfbee47@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 03/05/2020 11:13 AM, Christophe Leroy wrote:
> 
> 
> Le 05/03/2020 à 01:54, Anshuman Khandual a écrit :
>>
>>
>> On 03/04/2020 04:59 PM, Qian Cai wrote:
>>>
>>>
>>>> On Mar 4, 2020, at 1:49 AM, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>>
>>>> AFAIU, you are not taking an interrupt here. You are stuck in the pte_update(), most likely due to nested locks. Try with LOCKDEP ?
>>>
>>> Not exactly sure what did you mean here, but the kernel has all lockdep enabled and did not flag anything here.
>>
>> As the patch has been dropped from Linux next (next-20200304) perhaps in
>> order to fold back the __pa_symbol() fix [1], so I am planning to respin
>> the original patch once more as V15 while adding Qian's signed off by for
>> the powerpc part. For now lets enable radix MMU ppc64 along with existing
>> ppc32. As PPC_RADIX_MMU depends on PPC_BOOK3S_64, the following change
>> should be good enough ?
> 
> I don't think so, even if you have the Radix MMU compiled in, hash MMU is used when Radix is not available or disabled. So until the Hash MMU problem is fixed, you cannot enable it by default.

So this implies, that with DEBUG_VM given kernel compiled with Radix MMU will
get stuck in soft lock up when forced to use hash MMU in cases where Radix MMU
is either not available or is disabled. Hence, we cannot enable that.

I will still fold the changes from Qian without enabling ppc64 Radix MMU and
respin V15. These new changes dont hurt, build every where and works good
on arm64 and x86 platforms. More over we know that they also fix a problem
for ppc64 Radix MMU platforms. Hence unless there are some other concerns we
should fold them in.

> 
> Christophe
> 
