Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139B9146362
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 09:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAWIXN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 03:23:13 -0500
Received: from foss.arm.com ([217.140.110.172]:35958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgAWIXN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 03:23:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AADB1FB;
        Thu, 23 Jan 2020 00:23:12 -0800 (PST)
Received: from [10.162.16.32] (p8cg001049571a15.blr.arm.com [10.162.16.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA1773F6C4;
        Thu, 23 Jan 2020 00:26:43 -0800 (PST)
Subject: Re: [PATCH 0/2] mm/thp: rework the pmd protect changing flow
To:     Xuefeng Wang <wxf.wang@hisilicon.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chenzhou10@huawei.com
References: <20200123075514.15142-1-wxf.wang@hisilicon.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <50493410-c44c-7ef0-81f9-d4ce9a525c1f@arm.com>
Date:   Thu, 23 Jan 2020 13:54:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200123075514.15142-1-wxf.wang@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 01/23/2020 01:25 PM, Xuefeng Wang wrote:
> On KunPeng920 board. When changing permission of a large range region,
> pmdp_invalidate() takes about 65% in profile (with hugepages) in JIT tool.
> Kernel will flush tlb twice: first flush happens in pmdp_invalidate, second
> flush happens at the end of change_protect_range(). The first pmdp_invalidate
> is not necessary if the hardware support atomic pmdp changing. The atomic
> changing pimd to zero can prevent the hardware from update asynchronous.
> So reconstruct it and remove the first pmdp_invalidate. And the second tlb
> flush can make sure the new tlb entry valid.
> 
> This patch series add a pmdp_modify_prot transaction abstraction firstly.
> Then add pmdp_modify_prot_start() in arm64, which uses pmdp_huge_get_and_clear()
> to atomically fetch the pmd and zero the entry.

There is a comment section in change_huge_pmd() which details how clearing
the PMD entry there (in prot_numa case) can potentially race with another
concurrent madvise(MADV_DONTNEED, ..) call. Here is the comment block for
reference.

        /*
         * In case prot_numa, we are under down_read(mmap_sem). It's critical
         * to not clear pmd intermittently to avoid race with MADV_DONTNEED
         * which is also under down_read(mmap_sem):
         *
         *      CPU0:                           CPU1:
         *                              change_huge_pmd(prot_numa=1)
         *                               pmdp_huge_get_and_clear_notify()
         * madvise_dontneed()
         *  zap_pmd_range()
         *   pmd_trans_huge(*pmd) == 0 (without ptl)
         *   // skip the pmd
         *                               set_pmd_at();
         *                               // pmd is re-established
         *
         * The race makes MADV_DONTNEED miss the huge pmd and don't clear it
         * which may break userspace.
         *
         * pmdp_invalidate() is required to make sure we don't miss
         * dirty/young flags set by hardware.
         */

By defining the new override with pmdp_huge_get_and_clear(), are not we
now exposed to above race condition ?

- Anshuman
