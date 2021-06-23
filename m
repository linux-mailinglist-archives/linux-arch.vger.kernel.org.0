Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6461C3B1BDA
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFWOC7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 10:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhFWOC6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 10:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BDE0610C7;
        Wed, 23 Jun 2021 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624456840;
        bh=DWQrl2ZGMrRzWQH6OHfsw47jgYfoH2bZLoFaNEVct3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxBmqqmt3lQrw0OyDJEWyMAyUY7JmKId/uKXw2xtFK346PEtBGV2SJoC3Q8MkiDio
         DX7ouBSx4lx20RL7FRismgx3IpNgC0ryVUSrMkLIw0qjbsIPW8bAksf5cZ7ycjdZKu
         DB0N2RXo0muCmVx1OLBy4zQIG1CIDynqlaco6uQsRUGts6cOqc6Grqtwm0hKZM2LdB
         C/s/2vxRDkIUH2qPW/ElzqfEEbDuvW12fu5XXhQh4DS8GP+V5qj+RBto7J0+MOtlxI
         uEahCS8uBC6u/kQaRicuN0NuDJeltnFklA7LV/l4CObUlHXLzQWlZClMSVn6vkjm4S
         0cNyE11jd0Xzw==
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>, aneesh.kumar@linux.ibm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, steven.price@arm.com,
        Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        liushixin2@huawei.com, Xiexiangyou <xiexiangyou@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        huyaqin <huyaqin1@huawei.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, zhurui3@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: tlb: fix the TTL value of tlb_get_level
Date:   Wed, 23 Jun 2021 15:00:18 +0100
Message-Id: <162444629282.759882.14655008602043376684.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b80ead47-1f88-3a00-18e1-cacc22f54cc4@huawei.com>
References: <b80ead47-1f88-3a00-18e1-cacc22f54cc4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 23 Jun 2021 15:05:22 +0800, Zhenyu Ye wrote:
> The TTL field indicates the level of page table walk holding the *leaf*
> entry for the address being invalidated. But currently, the TTL field
> may be set to an incorrent value in the following stack:
> 
> pte_free_tlb
>     __pte_free_tlb
>         tlb_remove_table
>             tlb_table_invalidate
>                 tlb_flush_mmu_tlbonly
>                     tlb_flush
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: tlb: fix the TTL value of tlb_get_level
      https://git.kernel.org/arm64/c/52218fcd61cb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
