Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B7121D5BA
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 14:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgGMMVa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 08:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMV3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 08:21:29 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C95920738;
        Mon, 13 Jul 2020 12:21:26 +0000 (UTC)
Date:   Mon, 13 Jul 2020 13:21:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com,
        Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org,
        olof@lixom.net, suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, prime.zeng@hisilicon.com,
        linux-arch@vger.kernel.org, kuhn.chenqun@huawei.com,
        xiexiangyou@huawei.com, linux-mm@kvack.org, arm@kernel.org
Subject: Re: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE
 instructions
Message-ID: <20200713122123.GC15829@gaia>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <159440712962.27784.4664678472466095995.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159440712962.27784.4664678472466095995.b4-ty@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 08:11:19PM +0100, Catalin Marinas wrote:
> On Fri, 10 Jul 2020 17:44:18 +0800, Zhenyu Ye wrote:
> > NOTICE: this series are based on the arm64 for-next/tlbi branch:
> > git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
> > 
> > --
> > ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> > range of input addresses. This series add support for this feature.
> > 
> > [...]
> 
> Applied to arm64 (for-next/tlbi), thanks!
> 
> [1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
>       https://git.kernel.org/arm64/c/a2fd755f77ff
> [2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
>       https://git.kernel.org/arm64/c/db34a081d273

I'm dropping these two patches from for-next/tlbi and for-next/core.
They need a check on whether binutils supports the new "tlbi rva*"
instructions, otherwise the build mail fail.

I kept the latest incarnation of these patches on devel/tlbi-range for
reference.

-- 
Catalin
