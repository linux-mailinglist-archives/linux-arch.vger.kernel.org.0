Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF777D75D6
	for <lists+linux-arch@lfdr.de>; Wed, 25 Oct 2023 22:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjJYUha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Oct 2023 16:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYUh3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2023 16:37:29 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B07DDE
        for <linux-arch@vger.kernel.org>; Wed, 25 Oct 2023 13:37:27 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2c5b2154so95321a34.3
        for <linux-arch@vger.kernel.org>; Wed, 25 Oct 2023 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698266244; x=1698871044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRvWkvBoDYkTwsED6VPJ0pdisbEkaoGqPda2wjpU/Qs=;
        b=MII0mSTzaQsqVwpW2bZubOzl9GP8xBXYgW3rk0k3ReYKcLrieCYwQP2tmFC5O1kssl
         1Lf9FuZ8RiskJ6lVenwZwo8w6QVlTemUAWvQPhvVh7lZGv2BVUt3P3oaz+6e0vJ3nVT6
         NLUZQU61fyc4pHxV5dQUECFsA1WGYxdpdCxWy5uCwcNhYxDllCsoqA01eCLt9y6zRghr
         0r9I5hppaMVdV9aHFjylDJhgY/Nk8jifUnVvUv8HwM9tM7e2dqn7dhPBltnERgXRp7Wb
         GoRYc3/WKLU9r6YzD8DUkkd8d0My9GHNrjKKPlrJ526/zGcics5PhrNOAzpxga+ZBaIL
         ZYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698266244; x=1698871044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRvWkvBoDYkTwsED6VPJ0pdisbEkaoGqPda2wjpU/Qs=;
        b=WpoFZFisNhthGw87WCOv2po1EVcsCNUT2T2bUEsixaB72I1mp3LovwZuB+0Iqhai3u
         LpXPCAkEzgvFvj0PK6pBv66tb5QxA78Sb5YpiHJWgjx0JDdFLLGsyhZVfhW+O3+acEim
         YvXITQmDNDLDdhVL8dNyL5OfG7LIO9HTvK0hfppG2vHLICgY7ltB0D7tlb+ICLtZEh4q
         AuZ+NNzcfc80aJ1e1wM4dcvVLaxM51hIygNH9zqq9U1P5cIcQrt33U3oo7vn9wXkQRfb
         dZvY5l9d/iIG3Ep5jYlDg8GFgv9facwQVKGe4FwzEcG75++1H0M0Pd+OjGzcl+OwZpWP
         UxIA==
X-Gm-Message-State: AOJu0YxCa5LnQIt/Hg06xeO9V7HqdFOw4UsrQD7EQt/4ZUCrtokIzf4+
        hqRYycHAD69dRzZkUrRc8sThXQ==
X-Google-Smtp-Source: AGHT+IFbX7AlguqhQunscrGf7kDQdcHYoFURhBlkQP1vlzURhFZhOpWBh6z5tFsLLNMSZKF3FqxKdg==
X-Received: by 2002:a9d:6286:0:b0:6bd:152f:9918 with SMTP id x6-20020a9d6286000000b006bd152f9918mr18452849otk.14.1698266244527;
        Wed, 25 Oct 2023 13:37:24 -0700 (PDT)
Received: from ghost ([208.116.208.98])
        by smtp.gmail.com with ESMTPSA id g15-20020a056830160f00b006b9cc67386fsm2385303otr.66.2023.10.25.13.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:37:24 -0700 (PDT)
Date:   Wed, 25 Oct 2023 13:37:21 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 2/4] riscv: Checksum header
Message-ID: <ZTl8gauEst2NGrw6@ghost>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
 <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
 <DM8PR11MB575134C301E7E17E72281CFAB8DEA@DM8PR11MB5751.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB575134C301E7E17E72281CFAB8DEA@DM8PR11MB5751.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 25, 2023 at 06:50:05AM +0000, Wang, Xiao W wrote:
> Hi Charlie,
> 
> > -----Original Message-----
> > From: linux-riscv <linux-riscv-bounces@lists.infradead.org> On Behalf Of
> > Charlie Jenkins
> > Sent: Wednesday, September 20, 2023 2:45 AM
> > To: Charlie Jenkins <charlie@rivosinc.com>; Palmer Dabbelt
> > <palmer@dabbelt.com>; Conor Dooley <conor@kernel.org>; Samuel Holland
> > <samuel.holland@sifive.com>; David Laight <David.Laight@aculab.com>;
> > linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > arch@vger.kernel.org
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>; Albert Ou
> > <aou@eecs.berkeley.edu>; Arnd Bergmann <arnd@arndb.de>
> > Subject: [PATCH v7 2/4] riscv: Checksum header
> > 
> > Provide checksum algorithms that have been designed to leverage riscv
> > instructions such as rotate. In 64-bit, can take advantage of the larger
> > register to avoid some overflow checking.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/checksum.h | 79
> > +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/checksum.h
> > b/arch/riscv/include/asm/checksum.h
> > new file mode 100644
> > index 000000000000..dc0dd89f2a13
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -0,0 +1,79 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * IP checksum routines
> > + *
> > + * Copyright (C) 2023 Rivos Inc.
> > + */
> > +#ifndef __ASM_RISCV_CHECKSUM_H
> > +#define __ASM_RISCV_CHECKSUM_H
> > +
> > +#include <linux/in6.h>
> > +#include <linux/uaccess.h>
> > +
> > +#define ip_fast_csum ip_fast_csum
> > +
> > +#include <asm-generic/checksum.h>
> > +
> > +/*
> > + * Quickly compute an IP checksum with the assumption that IPv4 headers
> > will
> > + * always be in multiples of 32-bits, and have an ihl of at least 5.
> > + * @ihl is the number of 32 bit segments and must be greater than or equal
> > to 5.
> > + * @iph is assumed to be word aligned.
> 
> Not sure if the assumption is always true. It looks the implementation in "lib/checksum.c" doesn't take this assumption.
> The ip header can comes after a 14-Byte ether header, which may start from a word-aligned or DMA friendly address.

While lib/checksum.c does not make this assumption, other architectures
(x86, ARM, powerpc, mips, arc) do make this assumption. Architectures
seem to only align the header on a word boundary in do_csum. I worry
that the benefit of aligning iph in this "fast" csum function would
disproportionately impact hardware that has fast misaligned accesses.

- Charlie

> 
> > + */
> > +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> > +{
> > +	unsigned long csum = 0;
> > +	int pos = 0;
> > +
> > +	do {
> > +		csum += ((const unsigned int *)iph)[pos];
> > +		if (IS_ENABLED(CONFIG_32BIT))
> > +			csum += csum < ((const unsigned int *)iph)[pos];
> > +	} while (++pos < ihl);
> > +
> > +	/*
> > +	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> > +	 * worth checking if supported without Alternatives.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		unsigned long fold_temp;
> > +
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > +					      RISCV_ISA_EXT_ZBB, 1)
> > +		    :
> > +		    :
> > +		    :
> > +		    : no_zbb);
> > +
> > +		if (IS_ENABLED(CONFIG_32BIT)) {
> > +			asm(".option push				\n\
> > +			.option arch,+zbb				\n\
> > +				not	%[fold_temp], %[csum]
> > 	\n\
> > +				rori	%[csum], %[csum], 16		\n\
> > +				sub	%[csum], %[fold_temp], %[csum]
> > 	\n\
> > +			.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > +		} else {
> > +			asm(".option push				\n\
> > +			.option arch,+zbb				\n\
> > +				rori	%[fold_temp], %[csum], 32	\n\
> > +				add	%[csum], %[fold_temp], %[csum]
> > 	\n\
> > +				srli	%[csum], %[csum], 32		\n\
> > +				not	%[fold_temp], %[csum]
> > 	\n\
> > +				roriw	%[csum], %[csum], 16		\n\
> > +				subw	%[csum], %[fold_temp], %[csum]
> > 	\n\
> > +			.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > +		}
> > +		return csum >> 16;
> > +	}
> > +no_zbb:
> > +#ifndef CONFIG_32BIT
> > +	csum += (csum >> 32) | (csum << 32);
> 
> Just like patch 3/4 does, we can call ror64(csum, 32).
> 
> BRs,
> Xiao
> 
> > +	csum >>= 32;
> > +#endif
> > +	return csum_fold((__force __wsum)csum);
> > +}
> > +
> > +#endif // __ASM_RISCV_CHECKSUM_H
> > 
> > --
> > 2.42.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
