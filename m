Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3A20D143
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgF2Sj5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:39:57 -0400
Received: from foss.arm.com ([217.140.110.172]:35142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgF2Sj4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Jun 2020 14:39:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77D68D6E;
        Mon, 29 Jun 2020 01:32:52 -0700 (PDT)
Received: from [10.163.83.176] (unknown [10.163.83.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94C2D3F71E;
        Mon, 29 Jun 2020 01:32:41 -0700 (PDT)
Subject: Re: [PATCH V3 0/4] mm/debug_vm_pgtable: Add some more tests
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     linux-mm@kvack.org, christophe.leroy@c-s.fr, ziy@nvidia.com,
        Jonathan Corbet <corbet@lwn.net>,
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
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
 <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
 <20200624110539.GC24934@oc3871087118.ibm.com>
 <20200624134808.0c460862@thinkpad>
 <20200624144015.GD24934@oc3871087118.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c4a8b4fe-b9f4-b2ec-12ea-7143e4ca0464@arm.com>
Date:   Mon, 29 Jun 2020 14:02:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200624144015.GD24934@oc3871087118.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 06/24/2020 08:10 PM, Alexander Gordeev wrote:
> On Wed, Jun 24, 2020 at 01:48:08PM +0200, Gerald Schaefer wrote:
>> On Wed, 24 Jun 2020 13:05:39 +0200
>> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>>
>>> On Wed, Jun 24, 2020 at 08:43:10AM +0530, Anshuman Khandual wrote:
>>>
>>> [...]
>>>
>>>> Hello Gerald/Christophe/Vineet,
>>>>
>>>> It would be really great if you could give this series a quick test
>>>> on s390/ppc/arc platforms respectively. Thank you.
>>>
>>> That worked for me with the default and debug s390 configurations.
>>> Would you like to try with some particular options or combinations
>>> of the options?
>>
>> It will be enabled automatically on all archs that set
>> ARCH_HAS_DEBUG_VM_PGTABLE, which we do for s390 unconditionally.
>> Also, DEBUG_VM has to be set, which we have only in the debug config.
>> So only the s390 debug config will have it enabled, you can check
>> dmesg for "debug_vm_pgtable" to see when / where it was run, and if it
>> triggered any warnings.
> 
> Yes, that is what I did ;)
> 
> I should have been more clear. I wonder whether Anshuman has in
> mind other options which possibly makes sense to set or unset
> and check how it goes with non-standard configurations.

After enabling CONFIG_DEBUG_VM either explicitly or via DEBUG_VM, ideally
any memory config combination on s390 which can change platform page table
helpers (validated with CONFIG_DEBUG_VM) should also get tested. Recently,
there was a kernel crash on ppc64 [1] and a build failure on ppc32 [2] for
some particular configs. Hence it will be great if you could run this test
on multiple s390 configurations.

[1] 787d563b8642f35c5 ("mm/debug_vm_pgtable: fix kernel crash by checking for THP support")
[2] 9449c9cb420b249eb ("mm/debug_vm_pgtable: fix build failure with powerpc 8xx")

- Anshuman
