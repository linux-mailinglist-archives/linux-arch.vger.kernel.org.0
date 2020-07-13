Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D021DE12
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgGMQ7L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 12:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730185AbgGMQ7K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 12:59:10 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA4B20738;
        Mon, 13 Jul 2020 16:59:06 +0000 (UTC)
Date:   Mon, 13 Jul 2020 17:59:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com,
        will@kernel.org, olof@lixom.net, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, prime.zeng@hisilicon.com,
        linux-arch@vger.kernel.org, kuhn.chenqun@huawei.com,
        xiexiangyou@huawei.com, linux-mm@kvack.org, arm@kernel.org
Subject: Re: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE
 instructions
Message-ID: <20200713165903.GD15829@gaia>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <159440712962.27784.4664678472466095995.b4-ty@arm.com>
 <20200713122123.GC15829@gaia>
 <2edcf1ce-38d4-82b2-e500-51f742cae357@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2edcf1ce-38d4-82b2-e500-51f742cae357@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 13, 2020 at 08:41:31PM +0800, Zhenyu Ye wrote:
> On 2020/7/13 20:21, Catalin Marinas wrote:
> > On Fri, Jul 10, 2020 at 08:11:19PM +0100, Catalin Marinas wrote:
> >> On Fri, 10 Jul 2020 17:44:18 +0800, Zhenyu Ye wrote:
> >>> NOTICE: this series are based on the arm64 for-next/tlbi branch:
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
> >>>
> >>> --
> >>> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> >>> range of input addresses. This series add support for this feature.
> >>>
> >>> [...]
> >>
> >> Applied to arm64 (for-next/tlbi), thanks!
> >>
> >> [1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
> >>       https://git.kernel.org/arm64/c/a2fd755f77ff
> >> [2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
> >>       https://git.kernel.org/arm64/c/db34a081d273
> > 
> > I'm dropping these two patches from for-next/tlbi and for-next/core.
> > They need a check on whether binutils supports the new "tlbi rva*"
> > instructions, otherwise the build mail fail.
> > 
> > I kept the latest incarnation of these patches on devel/tlbi-range for
> > reference.
> 
> Should we add a check for the binutils version? Just like:
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fad573883e89..d5fb6567e0d2 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1300,6 +1300,20 @@ config ARM64_AMU_EXTN
>  	  correctly reflect reality. Most commonly, the value read will be 0,
>  	  indicating that the counter is not enabled.
> 
> +config ARM64_TLBI_RANGE
> +	bool "Enable support for tlbi range feature"
> +	default y
> +	depends on AS_HAS_TLBI_RANGE
> +	help
> +	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> +	  range of input addresses.
> +
> +	  The feature introduces new assembly instructions, and they were
> +	  support when binutils >= 2.30.

It looks like 2.30. I tracked it down to this commit:

https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=793a194839bc8add71fdc7429c58b10f0667a6f6;hp=1a7ed57c840dcb0401f1a67c6763a89f7d2686d2

> +config AS_HAS_TLBI_RANGE
> +	def_bool $(as-option, -Wa$(comma)-march=armv8.4-a)
> +
>  endmenu

The problem is that we don't pass -Wa,-march=armv8.4-a to gas. AFAICT,
we only set an 8.3 for PAC but I'm not sure how passing two such options
goes.

I'm slightly surprised that my toolchains (and yours) did not complain
about these instructions. Looking at the binutils code, I think it
should have complained if -march=armv8.4-a wasn't passed but works fine.
I thought gas doesn't enable the maximum arch feature by default.

An alternative would be to check for a specific instruction (untested):

	def_bool $(as-instr,tlbi rvae1is, x0)

but we need to figure out whether gas not requiring -march=armv8.4-a is
a bug (which may be fixed) or that gas accepts all TLBI instructions.

A safer bet may be to simply encode the instructions by hand:

#define SYS_TLBI_RVAE1IS(Rt) \
	__emit_inst(0xd5000000 | sys_insn(1, 0, 8, 2, 1) | ((Rt) & 0x1f))
#define SYS_TLBI_RVALE1IS(Rt) \
	__emit_inst(0xd5000000 | sys_insn(1, 0, 8, 2, 5) | ((Rt) & 0x1f))

(please check that they are correct)

-- 
Catalin
