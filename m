Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1567121D619
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 14:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgGMMlm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 08:41:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbgGMMll (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 08:41:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C32079BA0D8FA8D4044F;
        Mon, 13 Jul 2020 20:41:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.75) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Jul 2020
 20:41:32 +0800
Subject: Re: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE
 instructions
To:     Catalin Marinas <catalin.marinas@arm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <guohanjun@huawei.com>, <will@kernel.org>,
        <olof@lixom.net>, <suzuki.poulose@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <linux-arch@vger.kernel.org>, <kuhn.chenqun@huawei.com>,
        <xiexiangyou@huawei.com>, <linux-mm@kvack.org>, <arm@kernel.org>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <159440712962.27784.4664678472466095995.b4-ty@arm.com>
 <20200713122123.GC15829@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <2edcf1ce-38d4-82b2-e500-51f742cae357@huawei.com>
Date:   Mon, 13 Jul 2020 20:41:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200713122123.GC15829@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

On 2020/7/13 20:21, Catalin Marinas wrote:
> On Fri, Jul 10, 2020 at 08:11:19PM +0100, Catalin Marinas wrote:
>> On Fri, 10 Jul 2020 17:44:18 +0800, Zhenyu Ye wrote:
>>> NOTICE: this series are based on the arm64 for-next/tlbi branch:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
>>>
>>> --
>>> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>>> range of input addresses. This series add support for this feature.
>>>
>>> [...]
>>
>> Applied to arm64 (for-next/tlbi), thanks!
>>
>> [1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
>>       https://git.kernel.org/arm64/c/a2fd755f77ff
>> [2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
>>       https://git.kernel.org/arm64/c/db34a081d273
> 
> I'm dropping these two patches from for-next/tlbi and for-next/core.
> They need a check on whether binutils supports the new "tlbi rva*"
> instructions, otherwise the build mail fail.
> 
> I kept the latest incarnation of these patches on devel/tlbi-range for
> reference.
> 

Should we add a check for the binutils version? Just like:

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fad573883e89..d5fb6567e0d2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1300,6 +1300,20 @@ config ARM64_AMU_EXTN
 	  correctly reflect reality. Most commonly, the value read will be 0,
 	  indicating that the counter is not enabled.

+config ARM64_TLBI_RANGE
+	bool "Enable support for tlbi range feature"
+	default y
+	depends on AS_HAS_TLBI_RANGE
+	help
+	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
+	  range of input addresses.
+
+	  The feature introduces new assembly instructions, and they were
+	  support when binutils >= 2.30.
+
+config AS_HAS_TLBI_RANGE
+	def_bool $(as-option, -Wa$(comma)-march=armv8.4-a)
+
 endmenu

 menu "ARMv8.5 architectural features"

Then uses the check in the loop:

	while (pages > 0) {
		if (!IS_ENABLED(CONFIG_ARM64_TLBI_RANGE) ||
		   !cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) ||


If this is ok, I could send a new series soon.

Thanks,
Zhenyu


