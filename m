Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A015053FCF1
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 13:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbiFGLJK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242620AbiFGLIr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 07:08:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245B10F365;
        Tue,  7 Jun 2022 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654599888; x=1686135888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txlfXjkncT5hC674qNejQhjc3HzGWH2n9+3fSqXFElg=;
  b=ZuD7XJunqF+oQFgLH70hHJJzUyDX/9Yyc6z/CGQlpdoTx2vRCSnUIMdU
   c+zfWhewQS+lC0l415FmCsQO53rJ3rhge8dFjRY8a1jhFcm63Mrp0WMax
   P6O85A56btM6uWNuhZisYsr0CngEkzk9lZJDaEp1LiHgLMy2IgiuryQsw
   qREJIxgAk54i4xKov6l73S0FeHzeVIP8Sd//H8/nuzDdMYWgpIEUldZ6B
   dx/PtK3dqDIHU38EmKFI/JcKuKg+qZy7W6E9DR1nJCP7fXN7Krkcx1Dgu
   3BozaNrA6+MRwCS0xy9xiJHRXuyEIg2IordpDtehhM98fpeYUsJiMw9O1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="338066809"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="338066809"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 04:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="614870759"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2022 04:04:18 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 257B4GZI020549;
        Tue, 7 Jun 2022 12:04:16 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
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
Subject: Re: [PATCH 4/6] bitops: unify non-atomic bitops prototypes across architectures
Date:   Tue,  7 Jun 2022 13:03:10 +0200
Message-Id: <20220607110310.72649-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <Yp5oMmzNlq+Ut4So@yury-laptop>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com> <20220606114908.962562-5-alexandr.lobakin@intel.com> <Yp5oMmzNlq+Ut4So@yury-laptop>
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
Date: Mon, 6 Jun 2022 13:48:50 -0700

> On Mon, Jun 06, 2022 at 01:49:05PM +0200, Alexander Lobakin wrote:
> > Currently, there is a mess with the prototypes of the non-atomic
> > bitops across the different architectures:
> > 
> > ret	bool, int, unsigned long
> > nr	int, long, unsigned int, unsigned long
> > addr	volatile unsigned long *, volatile void *
> > 
> > Thankfully, it doesn't provoke any bugs, but can sometimes make
> > the compiler angry when it's not handy at all.
> > Adjust all the prototypes to the following standard:
> > 
> > ret	bool				retval can be only 0 or 1
> > nr	unsigned long			native; signed makes no sense
> > addr	volatile unsigned long *	bitmaps are arrays of ulongs
> > 
> > Finally, add some static assertions in order to prevent people from
> > making a mess in this room again.
> > I also used the %__always_inline attribute consistently they always
> > get resolved to the actual operations.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
> 
> [...]
> 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index 7aaed501f768..5520ac9b1c24 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -26,12 +26,25 @@ extern unsigned int __sw_hweight16(unsigned int w);
> >  extern unsigned int __sw_hweight32(unsigned int w);
> >  extern unsigned long __sw_hweight64(__u64 w);
> >  
> > +#include <asm-generic/bitops/generic-non-atomic.h>
> > +
> >  /*
> >   * Include this here because some architectures need generic_ffs/fls in
> >   * scope
> >   */
> >  #include <asm/bitops.h>
> >  
> > +/* Check that the bitops prototypes are sane */
> > +#define __check_bitop_pr(name)	static_assert(__same_type(name, gen_##name))
> > +__check_bitop_pr(__set_bit);
> > +__check_bitop_pr(__clear_bit);
> > +__check_bitop_pr(__change_bit);
> > +__check_bitop_pr(__test_and_set_bit);
> > +__check_bitop_pr(__test_and_clear_bit);
> > +__check_bitop_pr(__test_and_change_bit);
> > +__check_bitop_pr(test_bit);
> > +#undef __check_bitop_pr
> 
> This one is amazing trick! And the series is good overall. Do you want me to
> take it in bitmap tree, when it's ready, or you'll move it somehow else?

Thanks :) Yeah I'm glad we can use __same_type() (->
__builtin_types_compatible_p()) for functions as well, it simplifies
keeping the prototypes unified a lot.

I'm fine with either your bitmap tree or Arnd's asm-generic tree, so
it was my question which I happily forgot to ask: which of those two
is preferred for the series.

> 
> Thanks,
> Yury

Thanks,
Olek
