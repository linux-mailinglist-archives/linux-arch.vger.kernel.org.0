Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274FD21F5FA
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgGNPRN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 11:17:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgGNPRN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 11:17:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A7B0A3B5B896DCDB36BD;
        Tue, 14 Jul 2020 23:17:09 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.75) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Jul 2020
 23:17:03 +0800
Subject: Re: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE
 instructions
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <maz@kernel.org>, <steven.price@arm.com>, <guohanjun@huawei.com>,
        <will@kernel.org>, <olof@lixom.net>, <suzuki.poulose@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <linux-arch@vger.kernel.org>, <kuhn.chenqun@huawei.com>,
        <xiexiangyou@huawei.com>, <linux-mm@kvack.org>, <arm@kernel.org>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <159440712962.27784.4664678472466095995.b4-ty@arm.com>
 <20200713122123.GC15829@gaia>
 <2edcf1ce-38d4-82b2-e500-51f742cae357@huawei.com>
 <20200713165903.GD15829@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <b0c1ae56-3c22-dafe-a145-305714b211eb@huawei.com>
Date:   Tue, 14 Jul 2020 23:17:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200713165903.GD15829@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/7/14 0:59, Catalin Marinas wrote:
>> +config ARM64_TLBI_RANGE
>> +	bool "Enable support for tlbi range feature"
>> +	default y
>> +	depends on AS_HAS_TLBI_RANGE
>> +	help
>> +	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>> +	  range of input addresses.
>> +
>> +	  The feature introduces new assembly instructions, and they were
>> +	  support when binutils >= 2.30.
> 
> It looks like 2.30. I tracked it down to this commit:
> 
> https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=793a194839bc8add71fdc7429c58b10f0667a6f6;hp=1a7ed57c840dcb0401f1a67c6763a89f7d2686d2
> 
>> +config AS_HAS_TLBI_RANGE
>> +	def_bool $(as-option, -Wa$(comma)-march=armv8.4-a)
>> +
>>  endmenu
> 
> The problem is that we don't pass -Wa,-march=armv8.4-a to gas. AFAICT,
> we only set an 8.3 for PAC but I'm not sure how passing two such options
> goes.
> 

Pass the -march twice may not have bad impact.  Test in my toolchains
and the newer one will be chosen.  Anyway, we can add judgment to avoid
them be passed at the same time.

> I'm slightly surprised that my toolchains (and yours) did not complain
> about these instructions. Looking at the binutils code, I think it
> should have complained if -march=armv8.4-a wasn't passed but works fine.
> I thought gas doesn't enable the maximum arch feature by default.
>> An alternative would be to check for a specific instruction (untested):
> 
> 	def_bool $(as-instr,tlbi rvae1is, x0)
> 
> but we need to figure out whether gas not requiring -march=armv8.4-a is
> a bug (which may be fixed) or that gas accepts all TLBI instructions.
> 

As you say in another email, this is a bug.  So we should pass -march=
armv8.4-a to gas if we use toolchains to generate tlbi range instructions.

But this bug only affects the compilation (cause WARNING or ERROR if not
pass -march-armv8.4-a when compiling) but not the judgment.

> A safer bet may be to simply encode the instructions by hand:
> 
> #define SYS_TLBI_RVAE1IS(Rt) \
> 	__emit_inst(0xd5000000 | sys_insn(1, 0, 8, 2, 1) | ((Rt) & 0x1f))
> #define SYS_TLBI_RVALE1IS(Rt) \
> 	__emit_inst(0xd5000000 | sys_insn(1, 0, 8, 2, 5) | ((Rt) & 0x1f))
> 
> (please check that they are correct)
> 

Currently in kernel, all tlbi instructions are passed through __tlbi()
and __tlbi_user(). If we encode the range instructions by hand, we may
should have to add a new mechanism for this:

1. choose a register and save it;
2. put the operations for tlbi range to the register;
3. do tlbi range by asm(SYS_TLBI_RVAE1IS(x0));
4. restore the value of the register.

It's complicated and will only be used with tlbi range instructions.
(Am I understand something wrong? )

So I am prefer to pass -march=armv8.4-a to toolschains to support tlbi
range instruction, just like what PAC does.

Thanks,
Zhenyu




