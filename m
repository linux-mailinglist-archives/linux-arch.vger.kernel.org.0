Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F9D54CACA
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 16:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355685AbiFOODl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355665AbiFOODR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 10:03:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDD110F1;
        Wed, 15 Jun 2022 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655301782; x=1686837782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wB8IdGjwWR4VpCGztcdlKcCnZSDfsh9h9lU6StlhX6Q=;
  b=UTr6lSsJRpus2LDPO6wGYyoQPDnj63DfpYTp06CToFZe9dB19GwXBBD7
   qL5qhZqd32deyUf0KlgaPLGA/M6OPUyMwCM9jW+9eQI1SPd9+3ybIFfjp
   dMSJYN2b66ddHRg7JVWT0qb7zbmhbsbZnmiKYAsmR/cTu3bnS0DFFkXiN
   yi2Nf0rwfpsKZN+a2gIGlut03Ww2c6KQ+DtMgjOHFynz3JgoRoZWaWc0Y
   uPFxzh8QdzBCs6OJtgT4/ia1NExN8RotTa+YaqPPMoCT2cg+jIfoLYNhN
   ce5p+6KNCOPdN+Qjf9K9mXWu4xkXzhc+d3uMJyvcih3NVoTqTfR0lTuDC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="258822117"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="258822117"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="572033359"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2022 07:02:16 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25FE2EOf020988;
        Wed, 15 Jun 2022 15:02:14 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Wed, 15 Jun 2022 16:00:30 +0200
Message-Id: <20220615140030.1265068-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <YqlRfoB5+VBIw8gJ@yury-laptop>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com> <20220610113427.908751-7-alexandr.lobakin@intel.com> <YqlRfoB5+VBIw8gJ@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 14 Jun 2022 20:26:54 -0700

> Hi Alexander,
> 
> On Fri, Jun 10, 2022 at 01:34:27PM +0200, Alexander Lobakin wrote:
> > Currently, many architecture-specific non-atomic bitop
> > implementations use inline asm or other hacks which are faster or
> > more robust when working with "real" variables (i.e. fields from
> > the structures etc.), but the compilers have no clue how to optimize
> > them out when called on compile-time constants. That said, the
> > following code:
> > 
> > 	DECLARE_BITMAP(foo, BITS_PER_LONG) = { }; // -> unsigned long foo[1];
> > 	unsigned long bar = BIT(BAR_BIT);
> > 	unsigned long baz = 0;
> > 
> > 	__set_bit(FOO_BIT, foo);
> > 	baz |= BIT(BAZ_BIT);
> > 
> > 	BUILD_BUG_ON(!__builtin_constant_p(test_bit(FOO_BIT, foo));
> > 	BUILD_BUG_ON(!__builtin_constant_p(bar & BAR_BIT));
> > 	BUILD_BUG_ON(!__builtin_constant_p(baz & BAZ_BIT));
> 
> Can you put this snippet into lib/test_bitops.c?

Great idea, sure!

> 
> Thanks,
> Yury
> 
> > triggers the first assertion on x86_64, which means that the
> > compiler is unable to evaluate it to a compile-time initializer
> > when the architecture-specific bitop is used even if it's obvious.
> > In order to let the compiler optimize out such cases, expand the
> > bitop() macro to use the "constant" C non-atomic bitop
> > implementations when all of the arguments passed are compile-time
> > constants, which means that the result will be a compile-time
> > constant as well, so that it produces more efficient and simple
> > code in 100% cases, comparing to the architecture-specific
> > counterparts.
> > 
> > The savings are architecture, compiler and compiler flags dependent,
> > for example, on x86_64 -O2:
> > 
> > GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> > LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> > LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
> > 
> > and ARM64 (courtesy of Mark):
> > 
> > GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> > LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> >  include/linux/bitops.h | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index 753f98e0dcf5..364bdc3606b4 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -33,8 +33,24 @@ extern unsigned long __sw_hweight64(__u64 w);
> >  
> >  #include <asm-generic/bitops/generic-non-atomic.h>
> >  
> > +/*
> > + * Many architecture-specific non-atomic bitops contain inline asm code and due
> > + * to that the compiler can't optimize them to compile-time expressions or
> > + * constants. In contrary, gen_*() helpers are defined in pure C and compilers
> > + * optimize them just well.
> > + * Therefore, to make `unsigned long foo = 0; __set_bit(BAR, &foo)` effectively
> > + * equal to `unsigned long foo = BIT(BAR)`, pick the generic C alternative when
> > + * the arguments can be resolved at compile time. That expression itself is a
> > + * constant and doesn't bring any functional changes to the rest of cases.
> > + * The casts to `uintptr_t` are needed to mitigate `-Waddress` warnings when
> > + * passing a bitmap from .bss or .data (-> `!!addr` is always true).
> > + */
> >  #define bitop(op, nr, addr)						\
> > -	op(nr, addr)
> > +	((__builtin_constant_p(nr) &&					\
> > +	  __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) &&	\
> > +	  (uintptr_t)(addr) != (uintptr_t)NULL &&			\
> > +	  __builtin_constant_p(*(const unsigned long *)(addr))) ?	\
> > +	 const##op(nr, addr) : op(nr, addr))
> >  
> >  #define __set_bit(nr, addr)		bitop(___set_bit, nr, addr)
> >  #define __clear_bit(nr, addr)		bitop(___clear_bit, nr, addr)
> > -- 
> 2.36.1

Thanks,
Olek
