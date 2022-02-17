Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F064B9C54
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 10:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiBQJq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 04:46:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiBQJq0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 04:46:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6234C1704F;
        Thu, 17 Feb 2022 01:46:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13C2912FC;
        Thu, 17 Feb 2022 01:46:12 -0800 (PST)
Received: from [10.163.49.10] (unknown [10.163.49.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 568D63F718;
        Thu, 17 Feb 2022 01:46:10 -0800 (PST)
Subject: Re: [PATCH 00/30] mm/mmap: Drop protection_map[] and platform's
 __SXXX/__PXXX requirements
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
References: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5c809720-7b6e-4791-7eb3-0b4565789f3f@arm.com>
Date:   Thu, 17 Feb 2022 15:16:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/14/22 8:00 AM, Anshuman Khandual wrote:
> protection_map[] is an array based construct that translates given vm_flags
> combination. This array contains page protection map, which is populated by
> the platform via [__S000 .. __S111] and [__P000 .. __P111] exported macros.
> Primary usage for protection_map[] is for vm_get_page_prot(), which is used
> to determine page protection value for a given vm_flags. vm_get_page_prot()
> implementation, could again call platform overrides arch_vm_get_page_prot()
> and arch_filter_pgprot(). Some platforms override protection_map[] that was
> originally built with __SXXX/__PXXX with different runtime values.
> 
> Currently there are multiple layers of abstraction i.e __SXXX/__PXXX macros
> , protection_map[], arch_vm_get_page_prot() and arch_filter_pgprot() built
> between the platform and generic MM, finally defining vm_get_page_prot().
> 
> Hence this series proposes to drop all these abstraction levels and instead
> just move the responsibility of defining vm_get_page_prot() to the platform
> itself making it clean and simple.
> 
> This first introduces ARCH_HAS_VM_GET_PAGE_PROT which enables the platforms
> to define custom vm_get_page_prot(). This starts converting platforms that
> either change protection_map[] or define the overrides arch_filter_pgprot()
> or arch_vm_get_page_prot() which enables for those constructs to be dropped
> off completely. This series then converts remaining platforms which enables
> for __SXXX/__PXXX constructs to be dropped off completely. Finally it drops
> the generic vm_get_page_prot() and then ARCH_HAS_VM_GET_PAGE_PROT as every
> platform now defines their own vm_get_page_prot().
> 
> The series has been inspired from an earlier discuss with Christoph Hellwig
> 
> https://lore.kernel.org/all/1632712920-8171-1-git-send-email-anshuman.khandual@arm.com/
> 
> This series applies on 5.17-rc3 after the following patch.
> 
> https://lore.kernel.org/all/1643004823-16441-1-git-send-email-anshuman.khandual@arm.com/
> 
> This series has been cross built for multiple platforms.
> 
> - Anshuman
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Changes in V1:
> 
> - Add white spaces around the | operators 
> - Moved powerpc_vm_get_page_prot() near vm_get_page_prot() on powerpc
> - Moved arm64_vm_get_page_prot() near vm_get_page_prot() on arm64
> - Moved sparc_vm_get_page_prot() near vm_get_page_prot() on sparc
> - Compacted vm_get_page_prot() switch cases on all platforms
> -  _PAGE_CACHE040 inclusion is dependent on CPU_IS_040_OR_060
> - VM_SHARED case should return PAGE_NONE (not PAGE_COPY) on SH platform
> - Reorganized VM_SHARED, VM_EXEC, VM_WRITE, VM_READ
> - Dropped the last patch [RFC V1 31/31] which added macros for vm_flags combinations
>   https://lore.kernel.org/all/1643029028-12710-32-git-send-email-anshuman.khandual@arm.com/


Hello,

Just a gentle ping. I am planning to respin the series earlier next week
on v5.17-rc5 with the build failure fixes and also accommodating a review
comment from Geert. But will really appreciate some more reviews/comments/
suggestions as the series changes code in every platform.

Although all individual patches copy required reviewers and mailing lists,
I am wondering should they all be included in the cover letter and copied
for individual patches as well via cc-cover. But previously, patches with
many emails copied, faced problems while being delivered to mailing lists.

- Anshuman
