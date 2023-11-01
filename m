Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AFA7DE310
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 16:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjKAPfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjKAPfQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 11:35:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150B7102;
        Wed,  1 Nov 2023 08:35:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AE3C433C9;
        Wed,  1 Nov 2023 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698852909;
        bh=bbdrSxFMrsXv8i5RW4uSoBXIoUFMBluPi9Yoa790odM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgJY1V2HKsWnaXdqbPjdfzpglTtq4dcJLMF+pW0xil4K7rwUmLxqh1iiY/XXQOjXM
         M19pPpzwc1M6I8QCWhA1O5ynJKE2lWLDj1CWSGJAW+n2OEagaQkhjs0A964+/7Rk1Z
         s1svrJnFT0glrtxFNZktZ0K1STk+LOAhF01HCtPqYkAjde+kWePYT/uNA7buXZwuRe
         uqIJI9OiyIs+0BodAgzGbRjZthhdhCTKL2vkMt5vAoC8SNHr2AODXhPZI+y+pwpsTI
         sgygKOQ+nEVsJ+EXqCWQEfLur/RiWcWDx7MHGphZBGPQh7yxxHDq0ot/N/Cr1MFhnP
         BZ8cyZlqOvbVQ==
Date:   Wed, 1 Nov 2023 23:22:52 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 3/5] riscv: Checksum header
Message-ID: <ZUJtTEeFD24ZYXHQ@xhacker>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
 <20231031-optimize_checksum-v9-3-ea018e69b229@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231031-optimize_checksum-v9-3-ea018e69b229@rivosinc.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 31, 2023 at 05:18:53PM -0700, Charlie Jenkins wrote:
> Provide checksum algorithms that have been designed to leverage riscv
> instructions such as rotate. In 64-bit, can take advantage of the larger
> register to avoid some overflow checking.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/checksum.h | 81 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> new file mode 100644
> index 000000000000..3d77cac338fe
> --- /dev/null
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Checksum routines
> + *
> + * Copyright (C) 2023 Rivos Inc.
> + */
> +#ifndef __ASM_RISCV_CHECKSUM_H
> +#define __ASM_RISCV_CHECKSUM_H
> +
> +#include <linux/in6.h>
> +#include <linux/uaccess.h>
> +
> +#define ip_fast_csum ip_fast_csum
> +
> +/* Define riscv versions of functions before importing asm-generic/checksum.h */
> +#include <asm-generic/checksum.h>
> +
> +/*
> + * Quickly compute an IP checksum with the assumption that IPv4 headers will
> + * always be in multiples of 32-bits, and have an ihl of at least 5.
> + * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
> + * @iph is assumed to be word aligned given that NET_IP_ALIGN is set to 2 on
> + *	riscv, defining IP headers to be aligned.
> + */
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +{
> +	unsigned long csum = 0;
> +	int pos = 0;
> +
> +	do {
> +		csum += ((const unsigned int *)iph)[pos];
> +		if (IS_ENABLED(CONFIG_32BIT))
> +			csum += csum < ((const unsigned int *)iph)[pos];
> +	} while (++pos < ihl);
> +
> +	/*
> +	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> +	 * worth checking if supported without Alternatives.
> +	 */
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		unsigned long fold_temp;
> +
> +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> +					      RISCV_ISA_EXT_ZBB, 1)

This looks like a open coding of riscv_has_extension_*, so if
we use the it, the code could be rewritten as:

	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
		if (32bit) {
			asm(...)

		} else {
			asm(...)
		}
		return csum >> 16;
	}
#ifndef CONFIG_32BIT
	csum += ror64(csum, 32);
	csum >>= 32;
#endif
	return csum_fold((__force __wsum)csum);

The code readability is improved and make it a bit easier to refactor
the asm(...) code in the future.

And IMHO, the generated code should be the same.

Thanks

>

> +		    :
> +		    :
> +		    :
> +		    : no_zbb);
> +
> +		if (IS_ENABLED(CONFIG_32BIT)) {
> +			asm(".option push				\n\
> +			.option arch,+zbb				\n\
> +				not	%[fold_temp], %[csum]		\n\
> +				rori	%[csum], %[csum], 16		\n\
> +				sub	%[csum], %[fold_temp], %[csum]	\n\
> +			.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> +		} else {
> +			asm(".option push				\n\
> +			.option arch,+zbb				\n\
> +				rori	%[fold_temp], %[csum], 32	\n\
> +				add	%[csum], %[fold_temp], %[csum]	\n\
> +				srli	%[csum], %[csum], 32		\n\
> +				not	%[fold_temp], %[csum]		\n\
> +				roriw	%[csum], %[csum], 16		\n\
> +				subw	%[csum], %[fold_temp], %[csum]	\n\
> +			.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> +		}
> +		return csum >> 16;
> +	}
> +no_zbb:
> +#ifndef CONFIG_32BIT
> +	csum += ror64(csum, 32);
> +	csum >>= 32;
> +#endif
> +	return csum_fold((__force __wsum)csum);
> +}
> +
> +#endif /* __ASM_RISCV_CHECKSUM_H */
> 
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
