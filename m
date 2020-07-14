Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAE21F695
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGNP6q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 11:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgGNP6q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 11:58:46 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93708223C6;
        Tue, 14 Jul 2020 15:58:43 +0000 (UTC)
Date:   Tue, 14 Jul 2020 16:58:41 +0100
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
Message-ID: <20200714155840.GE18793@gaia>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <159440712962.27784.4664678472466095995.b4-ty@arm.com>
 <20200713122123.GC15829@gaia>
 <2edcf1ce-38d4-82b2-e500-51f742cae357@huawei.com>
 <20200713165903.GD15829@gaia>
 <b0c1ae56-3c22-dafe-a145-305714b211eb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c1ae56-3c22-dafe-a145-305714b211eb@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 14, 2020 at 11:17:01PM +0800, Zhenyu Ye wrote:
> On 2020/7/14 0:59, Catalin Marinas wrote:
> >> +config ARM64_TLBI_RANGE
> >> +	bool "Enable support for tlbi range feature"
> >> +	default y
> >> +	depends on AS_HAS_TLBI_RANGE
> >> +	help
> >> +	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> >> +	  range of input addresses.
> >> +
> >> +	  The feature introduces new assembly instructions, and they were
> >> +	  support when binutils >= 2.30.
> > 
> > It looks like 2.30. I tracked it down to this commit:
> > 
> > https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=793a194839bc8add71fdc7429c58b10f0667a6f6;hp=1a7ed57c840dcb0401f1a67c6763a89f7d2686d2
> > 
> >> +config AS_HAS_TLBI_RANGE
> >> +	def_bool $(as-option, -Wa$(comma)-march=armv8.4-a)

You could make this more generic like AS_HAS_ARMV8_4.

> > The problem is that we don't pass -Wa,-march=armv8.4-a to gas. AFAICT,
> > we only set an 8.3 for PAC but I'm not sure how passing two such options
> > goes.
> 
> Pass the -march twice may not have bad impact.  Test in my toolchains
> and the newer one will be chosen.  Anyway, we can add judgment to avoid
> them be passed at the same time.

I think the last one always overrides the previous (same with the .arch
statements in asm files). For example:

echo "paciasp" | aarch64-none-linux-gnu-as -march=armv8.2-a -march=armv8.3-a

succeeds but the one below fails:

echo "paciasp" | aarch64-none-linux-gnu-as -march=armv8.3-a -march=armv8.2-a

> > A safer bet may be to simply encode the instructions by hand:
> > 
> > #define SYS_TLBI_RVAE1IS(Rt) \
> > 	__emit_inst(0xd5000000 | sys_insn(1, 0, 8, 2, 1) | ((Rt) & 0x1f))
> > #define SYS_TLBI_RVALE1IS(Rt) \
> > 	__emit_inst(0xd5000000 | sys_insn(1, 0, 8, 2, 5) | ((Rt) & 0x1f))
> > 
> > (please check that they are correct)
> 
> Currently in kernel, all tlbi instructions are passed through __tlbi()
> and __tlbi_user(). If we encode the range instructions by hand, we may
> should have to add a new mechanism for this:
> 
> 1. choose a register and save it;
> 2. put the operations for tlbi range to the register;
> 3. do tlbi range by asm(SYS_TLBI_RVAE1IS(x0));
> 4. restore the value of the register.
> 
> It's complicated and will only be used with tlbi range instructions.
> (Am I understand something wrong? )
> 
> So I am prefer to pass -march=armv8.4-a to toolschains to support tlbi
> range instruction, just like what PAC does.

It will indeed get more complicated than necessary. So please go with
the -Wa,-march=armv8.4-a check in Kconfig and update the
arch/arm64/Makefile to pass this option (after the 8.3 one).

Thanks.

-- 
Catalin
