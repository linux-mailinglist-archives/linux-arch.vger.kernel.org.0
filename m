Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0161733AB
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 10:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgB1JUV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Feb 2020 04:20:21 -0500
Received: from foss.arm.com ([217.140.110.172]:35394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgB1JUU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Feb 2020 04:20:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2C8E1FB;
        Fri, 28 Feb 2020 01:20:19 -0800 (PST)
Received: from [10.163.1.119] (unknown [10.163.1.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E52C03F7B4;
        Fri, 28 Feb 2020 01:20:10 -0800 (PST)
Subject: Re: [PATCH] mm/debug: Add tests validating arch page table helpers
 for core features
To:     Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-snps-arc@lists.infradead.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
 <51421bb3-9075-d7e9-1750-0553a1ebe64a@c-s.fr>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f99692be-5d38-fdb7-46f1-205c7cc7481c@arm.com>
Date:   Fri, 28 Feb 2020 14:50:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <51421bb3-9075-d7e9-1750-0553a1ebe64a@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 02/27/2020 04:12 PM, Christophe Leroy wrote:
> 
> 
> Le 27/02/2020 à 11:33, Anshuman Khandual a écrit :
>> This adds new tests validating arch page table helpers for these following
>> core memory features. These tests create and test specific mapping types at
>> various page table levels.
>>
>> * SPECIAL mapping
>> * PROTNONE mapping
>> * DEVMAP mapping
>> * SOFTDIRTY mapping
>> * SWAP mapping
>> * MIGRATION mapping
>> * HUGETLB mapping
> 
> For testing HUGETLB mappings, you also have to include tests of hugepd functions/helpers. Not all archictures have hugepage size which matches with page tables levels (e.g. powerpc). Those architectures use hugepd_t.

Dont see much hugepd_t in generic HugeTLB. Just wondering which generic
hugepd helpers can be tested here. Could you please be bit more specific.
As we have not yet started looking for arch specific page table helpers
test requirements, all the test scenarios here need to be generic.

> 
> Christophe
> 
