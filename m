Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC12BA8D9
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 12:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgKTLSb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 06:18:31 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:43236 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgKTLSb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Nov 2020 06:18:31 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CcvDd5WN8z9txwf;
        Fri, 20 Nov 2020 12:18:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id e_u3vwZY56mA; Fri, 20 Nov 2020 12:18:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CcvDd4N8cz9txwc;
        Fri, 20 Nov 2020 12:18:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B624E8B764;
        Fri, 20 Nov 2020 12:18:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Sbkl6wo4JttE; Fri, 20 Nov 2020 12:18:26 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A9C88B820;
        Fri, 20 Nov 2020 12:18:25 +0100 (CET)
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com,
        mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com
Cc:     npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, will@kernel.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org,
        davem@davemloft.net, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com
References: <20201113111901.743573013@infradead.org>
 <16ad8cab-08e2-27a7-6803-baadc6b8721b@csgroup.eu>
Message-ID: <2a32b00b-2214-3283-58e0-9cb0ff4bd728@csgroup.eu>
Date:   Fri, 20 Nov 2020 12:18:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <16ad8cab-08e2-27a7-6803-baadc6b8721b@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

Le 13/11/2020 à 14:44, Christophe Leroy a écrit :
> Hi
> 
> Le 13/11/2020 à 12:19, Peter Zijlstra a écrit :
>> Hi,
>>
>> These patches provide generic infrastructure to determine TLB page size from
>> page table entries alone. Perf will use this (for either data or code address)
>> to aid in profiling TLB issues.
>>
>> While most architectures only have page table aligned large pages, some
>> (notably ARM64, Sparc64 and Power) provide non page table aligned large pages
>> and need to provide their own implementation of these functions.
>>
>> I've provided (completely untested) implementations for ARM64 and Sparc64, but
>> failed to penetrate the _many_ Power MMUs. I'm hoping Nick or Aneesh can help
>> me out there.
>>
> 
> I can help with powerpc 8xx. It is a 32 bits powerpc. The PGD has 1024 entries, that means each 
> entry maps 4M.
> 
> Page sizes are 4k, 16k, 512k and 8M.
> 
> For the 8M pages we use hugepd with a single entry. The two related PGD entries point to the same 
> hugepd.
> 
> For the other sizes, they are in standard page tables. 16k pages appear 4 times in the page table. 
> 512k entries appear 128 times in the page table.
> 
> When the PGD entry has _PMD_PAGE_8M bits, the PMD entry points to a hugepd with holds the single 8M 
> entry.
> 
> In the PTE, we have two bits: _PAGE_SPS and _PAGE_HUGE
> 
> _PAGE_HUGE means it is a 512k page
> _PAGE_SPS means it is not a 4k page
> 
> The kernel can by build either with 4k pages as standard page size, or 16k pages. It doesn't change 
> the page table layout though.
> 
> Hope this is clear. Now I don't really know to wire that up to your series.

Does my description make sense ? Is there anything I can help with ?

Christophe
