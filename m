Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A54216E0C
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGGNuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 09:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGNuA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 09:50:00 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B162080D;
        Tue,  7 Jul 2020 13:49:56 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     arnd@arndb.de, broonie@kernel.org, guohanjun@huawei.com,
        suzuki.poulose@arm.com, npiggin@gmail.com, maz@kernel.org,
        steven.price@arm.com, aneesh.kumar@linux.ibm.com,
        peterz@infradead.org, Zhenyu Ye <yezhenyu2@huawei.com>,
        mark.rutland@arm.com, Dave.Martin@arm.com, will@kernel.org,
        yuzhao@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
        rostedt@goodmis.org
Cc:     xiexiangyou@huawei.com, kuhn.chenqun@huawei.com,
        zhangshaokun@hisilicon.com, linux-kernel@vger.kernel.org,
        arm@kernel.org, linux-arch@vger.kernel.org,
        prime.zeng@hisilicon.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v5 0/6] arm64: tlb: add support for TTL feature
Date:   Tue,  7 Jul 2020 14:49:54 +0100
Message-Id: <159412959457.30282.6936734936058648673.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625080314.230-1-yezhenyu2@huawei.com>
References: <20200625080314.230-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 Jun 2020 16:03:08 +0800, Zhenyu Ye wrote:
> In order to reduce the cost of TLB invalidation, ARMv8.4 provides
> the TTL field in TLBI instruction.  The TTL field indicates the
> level of page table walk holding the leaf entry for the address
> being invalidated.  This series provide support for this feature.
> 
> When ARMv8.4-TTL is implemented, the operand for TLBIs looks like
> below:
> 
> [...]

Applied to arm64 (for-next/tlbi), thanks!

[3/6] arm64: Add tlbi_user_level TLB invalidation helper
      https://git.kernel.org/arm64/c/e735b98a5fe0
[4/6] tlb: mmu_gather: add tlb_flush_*_range APIs
      https://git.kernel.org/arm64/c/2631ed00b049
[5/6] arm64: tlb: Set the TTL field in flush_tlb_range
      https://git.kernel.org/arm64/c/c4ab2cbc1d87
[6/6] arm64: tlb: Set the TTL field in flush_*_tlb_range
      https://git.kernel.org/arm64/c/a7ac1cfa4c05

I haven't included the first 2 patches as I rebased the above on top of
Marc's TTL branch:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/ttl-for-arm64

-- 
Catalin

