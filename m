Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610157DD8A2
	for <lists+linux-arch@lfdr.de>; Tue, 31 Oct 2023 23:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbjJaWxe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 18:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbjJaWxe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 18:53:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD7191
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 15:53:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc2f17ab26so29850105ad.0
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698792811; x=1699397611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=87511vkM5pQLS/sY+Xc2jbRWOxXQCc9BpRYK++HTkxM=;
        b=qhqXoDE6R+9+4Um4Qfay9xmyC/b7FYsk34axw1w1Ov7XxcuEiOiGsvVWOWlA1PFeFg
         8kgx+B9bJxI+u608pXefG3uB70wABC71dCx4LozAlOL0KKw/DXPu2DTO0kXpZznFsQpm
         Z/TWl1gykU1aWMBWXgCvp8UqTh3sHopabyI2L4Ej6oa8egj0/4Y6EN4/FsEl4sWuDZRl
         x/xz9lSONts/gkQeLNVUcV+d8HzZ/mjy69wOXwh7VzWSFaMAa9X1wm3k6TQwuMR7F3aP
         3NHA79vlP9dzh0fSnlQmPR5osJxYfeVuw6UpKHunCr00fo5AUv6ZfS0ruWlbFFvZwCiM
         TVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698792811; x=1699397611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87511vkM5pQLS/sY+Xc2jbRWOxXQCc9BpRYK++HTkxM=;
        b=lBz7GUFky7eOjflb+CTRy0FkaCtvLoJKu+lfdATPKpClvFGbgzfpBu59ArnWj/7e+U
         imC2Csx/mlIhrscwYcHKjmOUnuNwPyaS4ouWMeSng63JChxMw6Usryau71wJwXGHYooS
         YrkiEcOOI2lxkUgDgqXmCK5EK9zWOUy8WC5paDTYLmjVxMpUelHcUMa8+d0vAosJzniC
         xT9JdRYW0TUD5rw2BjI2efrS2URjxSh7JF7RODL+wRAuwyRDJWb8UAPeokLbw7mbOQoH
         xjy3fL7zXBdEmmSB8XjnTrhXxGq+ukEHflOz0fXvRoKJ/DLa0w2P+ubzM5CJrWylS2nL
         Mupg==
X-Gm-Message-State: AOJu0YzpvdilnkylB3VACrmuqAeUkJlhc0UNgrHUzruoY5FujwGXBYjq
        VWn5g29aBMkdC4lA+uKFaKHrww==
X-Google-Smtp-Source: AGHT+IFkJBny1MzTOAbm3yqjjyqntKNn/QvQV635wjKHR1BORDo8BaW/HAraINKF0pHrz+lkKQOcKA==
X-Received: by 2002:a17:902:e1cd:b0:1ca:8541:e1ea with SMTP id t13-20020a170902e1cd00b001ca8541e1eamr9793668pla.0.1698792810859;
        Tue, 31 Oct 2023 15:53:30 -0700 (PDT)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902ed9300b001bbb8d5166bsm75583plj.123.2023.10.31.15.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 15:53:30 -0700 (PDT)
Date:   Tue, 31 Oct 2023 15:53:28 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Evan Green <evan@rivosinc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 3/5] riscv: Checksum header
Message-ID: <ZUGFaCihPOnlc6Uy@ghost>
References: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
 <20231027-optimize_checksum-v8-3-feb7101d128d@rivosinc.com>
 <DM8PR11MB5751FE93CB74EDE4A2F4876BB8A0A@DM8PR11MB5751.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751FE93CB74EDE4A2F4876BB8A0A@DM8PR11MB5751.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 31, 2023 at 09:11:07AM +0000, Wang, Xiao W wrote:
> 
> 
> > -----Original Message-----
> > From: Charlie Jenkins <charlie@rivosinc.com>
> > Sent: Saturday, October 28, 2023 6:44 AM
> > To: Charlie Jenkins <charlie@rivosinc.com>; Palmer Dabbelt
> > <palmer@dabbelt.com>; Conor Dooley <conor@kernel.org>; Samuel Holland
> > <samuel.holland@sifive.com>; David Laight <David.Laight@aculab.com>;
> > Wang, Xiao W <xiao.w.wang@intel.com>; Evan Green <evan@rivosinc.com>;
> > linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > arch@vger.kernel.org
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>; Albert Ou
> > <aou@eecs.berkeley.edu>; Arnd Bergmann <arnd@arndb.de>; Conor Dooley
> > <conor.dooley@microchip.com>
> > Subject: [PATCH v8 3/5] riscv: Checksum header
> > 
> > Provide checksum algorithms that have been designed to leverage riscv
> > instructions such as rotate. In 64-bit, can take advantage of the larger
> > register to avoid some overflow checking.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/include/asm/checksum.h | 92
> > +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/checksum.h
> > b/arch/riscv/include/asm/checksum.h
> > new file mode 100644
> > index 000000000000..9fd4b1b80641
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -0,0 +1,92 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * IP checksum routines
> 
> The checksum helpers' usage may not be limited to IP protocol.
> 

Will remove IP from the wording.

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
> > +extern unsigned int do_csum(const unsigned char *buff, int len);
> > +#define do_csum do_csum
> > +
> > +/* Default version is sufficient for 32 bit */
> > +#ifdef CONFIG_64BIT
> > +#define _HAVE_ARCH_IPV6_CSUM
> > +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> > +			const struct in6_addr *daddr,
> > +			__u32 len, __u8 proto, __wsum sum);
> > +#endif
> 
> The do_csum and csum_ipv6_magic helpers are implemented in patch 4/5, so the
> declarations should be moved there. Otherwise, build would fail at this patch.
> 

Oops, that snuck into this patch somehow.

> > +
> > +/* Define riscv versions of functions before importing asm-
> > generic/checksum.h */
> > +#include <asm-generic/checksum.h>
> > +
> > +/*
> > + * Quickly compute an IP checksum with the assumption that IPv4 headers
> > will
> > + * always be in multiples of 32-bits, and have an ihl of at least 5.
> > + * @ihl is the number of 32 bit segments and must be greater than or equal
> > to 5.
> > + * @iph is assumed to be word aligned given that NET_IP_ALIGN is set to 2 on
> > + *	riscv, defining IP headers to be aligned.
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
> Just like the next patch does, we can call ror64(csum, 32).

I meant to change this last time, thank you for pointing it out again.

- Charlie

> 
> BRs,
> Xiao
> 
> > +	csum >>= 32;
> > +#endif
> > +	return csum_fold((__force __wsum)csum);
> > +}
> > +
> > +#endif /* __ASM_RISCV_CHECKSUM_H */
> > 
> > --
> > 2.42.0
> 
