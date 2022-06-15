Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795E554CA73
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbiFON5D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 09:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiFON5A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 09:57:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE3827B12;
        Wed, 15 Jun 2022 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655301419; x=1686837419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3Dz9pCGYsKL9M71ANGJFS/yhgtgmIg63N13O2SpgOE=;
  b=ZIWSrq97lWkxdwWPN3eRZs8ibstsomDnaF3tgvvIEHOvnq1xblOCBrCp
   yk5n80X3PULcZ7WzqL9rQzrdP+t/gG5jhMkIXhb0DZYLlqw0KtqoHxg1g
   M9+RGxjdrYrjV+cVsvtVrcEqv1QXat75qk2orzn/iCY3T1iEr0nunDk0P
   a98fp6N4xWTpZGaqosb7MECLSJG/66B71mhSQ7frw9gvmpIZjyyEqYV72
   YGNPTGgLlZXqAQvELv5WIGBhbPgh+WSERTM2vkRx/N/dFcQEtrsAdoubK
   +NledGY7xj20xztT7FGKKbcsybIsXEL10tpCYoX681H2ZWtK8GB+Y4Tlu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277760300"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277760300"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 06:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="727403523"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2022 06:56:53 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25FDupkt019852;
        Wed, 15 Jun 2022 14:56:51 +0100
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
Subject: Re: [PATCH v2 4/6] bitops: define const_*() versions of the non-atomics
Date:   Wed, 15 Jun 2022 15:55:06 +0200
Message-Id: <20220615135506.1264880-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <YqlKpwjQ4Hu+Lr8u@yury-laptop>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com> <20220610113427.908751-5-alexandr.lobakin@intel.com> <YqlKpwjQ4Hu+Lr8u@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 14 Jun 2022 19:57:43 -0700

> On Fri, Jun 10, 2022 at 01:34:25PM +0200, Alexander Lobakin wrote:
> > Define const_*() variants of the non-atomic bitops to be used when
> > the input arguments are compile-time constants, so that the compiler
> > will be always to resolve those to compile-time constants as well.
> 
> will be always able?

Right, ooops.

> 
> > Those are mostly direct aliases for generic_*() with one exception
> > for const_test_bit(): the original one is declared atomic-safe and
> > thus doesn't discard the `volatile` qualifier, so in order to let
> > optimize the code, define it separately disregarding the qualifier.
> > Add them to the compile-time type checks as well just in case.
> > 
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> >  .../asm-generic/bitops/generic-non-atomic.h   | 31 +++++++++++++++++++
> >  include/linux/bitops.h                        |  3 +-
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> > index 3ce0fa0ab35f..9a77babfff35 100644
> > --- a/include/asm-generic/bitops/generic-non-atomic.h
> > +++ b/include/asm-generic/bitops/generic-non-atomic.h
> > @@ -121,4 +121,35 @@ generic_test_bit(unsigned long nr, const volatile unsigned long *addr)
> >  	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> >  }
> >  
> > +/*
> > + * const_*() definitions provide good compile-time optimizations when
> > + * the passed arguments can be resolved at compile time.
> > + */
> > +#define const___set_bit			generic___set_bit
> > +#define const___clear_bit		generic___clear_bit
> > +#define const___change_bit		generic___change_bit
> > +#define const___test_and_set_bit	generic___test_and_set_bit
> > +#define const___test_and_clear_bit	generic___test_and_clear_bit
> > +#define const___test_and_change_bit	generic___test_and_change_bit
> > +
> > +/**
> > + * const_test_bit - Determine whether a bit is set
> > + * @nr: bit number to test
> > + * @addr: Address to start counting from
> > + *
> > + * A version of generic_test_bit() which discards the `volatile` qualifier to
> > + * allow the compiler to optimize code harder. Non-atomic and to be used only
> > + * for testing compile-time constants, e.g. from the corresponding macro, or
> > + * when you really know what you are doing.
> 
> Not sure I understand the last sentence... Can you please rephrase?

I basically want to tell that there potentinally might be cases for
using those outside of the actual macros from 6/6. But it might be
redundant at all to mention this.

> 
> > + */
> > +static __always_inline bool
> > +const_test_bit(unsigned long nr, const volatile unsigned long *addr)
> > +{
> > +	const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
> > +	unsigned long mask = BIT_MASK(nr);
> > +	unsigned long val = *p;
> > +
> > +	return !!(val & mask);
> > +}
> > +
> >  #endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index 87087454a288..51c22b8667b4 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -36,7 +36,8 @@ extern unsigned long __sw_hweight64(__u64 w);
> >  
> >  /* Check that the bitops prototypes are sane */
> >  #define __check_bitop_pr(name)						\
> > -	static_assert(__same_type(arch_##name, generic_##name) &&	\
> > +	static_assert(__same_type(const_##name, generic_##name) &&	\
> > +		      __same_type(arch_##name, generic_##name) &&	\
> >  		      __same_type(name, generic_##name))
> >  
> >  __check_bitop_pr(__set_bit);
> > -- 
> > 2.36.1

Thanks,
Olek
