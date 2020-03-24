Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E541912BF
	for <lists+linux-arch@lfdr.de>; Tue, 24 Mar 2020 15:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgCXOTp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 10:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbgCXOTo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 10:19:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9247320788;
        Tue, 24 Mar 2020 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585059583;
        bh=BiuF+8C09ZXZT+Y0m0yfA1PY8+9yZbVyGyhq0q53CDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j8uY0T2TR1Jwh+mYP5o7fUfBxvYDj2Sl4idAVhraSsAtcBNSoG2GLTa2Nhw5StfCf
         Ord/lxL5FmP3Ezz+JZlTqLqPH1cmdjcjL6QF1isp83h4j0zilyyvUqlLU10rl1I0pF
         OouqDxnm0K0Vg5g6FDFTf99yq8YWeEY9bWfUeSA4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jGkP7-00FIiG-KS; Tue, 24 Mar 2020 14:19:41 +0000
Date:   Tue, 24 Mar 2020 14:19:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     <will@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <peterz@infradead.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
Subject: Re: [RFC PATCH v4 3/6] arm64: Add level-hinted TLB invalidation
 helper to tlbi_user
Message-ID: <20200324141939.51917225@why>
In-Reply-To: <20200324134534.1570-4-yezhenyu2@huawei.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
        <20200324134534.1570-4-yezhenyu2@huawei.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yezhenyu2@huawei.com, will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de, rostedt@goodmis.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 24 Mar 2020 21:45:31 +0800
Zhenyu Ye <yezhenyu2@huawei.com> wrote:

> Add a level-hinted parameter to __tlbi_user, which only gets used
> if ARMv8.4-TTL gets detected.
> 
> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
> the level of translation table walk holding the leaf entry for the
> address that is being invalidated.
> 
> This patch set the default level value to 0.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  arch/arm64/include/asm/tlbflush.h | 42 ++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index a3f70778a325..d141c080e494 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -89,6 +89,36 @@
>  		__tlbi(op,  arg);					\
>  	} while(0)
>  
> +#define __tlbi_user_level(op, addr, level)				\
> +	do {								\
> +		u64 arg = addr;						\
> +									\
> +		if (!arm64_kernel_unmapped_at_el0())			\
> +			break;						\
> +									\
> +		if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&	\
> +		    level) {						\
> +			u64 ttl = level;				\
> +									\
> +			switch (PAGE_SIZE) {				\
> +			case SZ_4K:					\
> +				ttl |= 1 << 2;				\
> +				break;					\
> +			case SZ_16K:					\
> +				ttl |= 2 << 2;				\
> +				break;					\
> +			case SZ_64K:					\
> +				ttl |= 3 << 2;				\
> +				break;					\
> +			}						\
> +									\
> +			arg &= ~TLBI_TTL_MASK;				\
> +			arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);		\
> +		}							\
> +									\
> +		__tlbi(op,  (arg) | USER_ASID_FLAG);
> 	\
> +	} while (0)
> +

Isn't this just:

define __tlbi_user_level(op, addr, level)			\
	do {							\
		if (!arm64_kernel_unmapped_at_el0())		\
			break;					\
								\
		__tlbi_level(op, addr | USER_ASID_FLAG, level);	\
	} while (0)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
