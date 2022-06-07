Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AB540331
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbiFGP6n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbiFGP6m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 11:58:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4215A145;
        Tue,  7 Jun 2022 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654617521; x=1686153521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdLuGXeq1XXduXvqxLVSvWcsygaT1e118Ro8QGLmiwo=;
  b=gG1MeZNGLxpUktLFexr2U81SkagSx8hhCotZDY6HYe+fTSEeqKE+THnO
   g07gerOvkE6EliV/hmZN9+AH4AscJtoivx7V3NJBRQCCr++zdLaw56B82
   YCbpzQVYYEoyLkHKyqnjDhcPQLFccMInCoHdjogVPX11uqgAfP/F39sG/
   i+WuMqApf+qCTBg4lrcpUXZhlym73VkjC/B1BrdrNlVqwsvPKI7oQlqOO
   zXfaXCTWc+P8HfXFnlos2/5lYtLd6ZGlZCjAZM20TiZLy1WnFFW7WIS20
   pfe4JESQSxRBGZWYhyOYPCO6GuARPmLVFhZz+xBNeqBhOzoivRWK9edm3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="256563553"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="256563553"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 08:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="614971769"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2022 08:58:34 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 257FwWT6032707;
        Tue, 7 Jun 2022 16:58:32 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
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
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] bitops: define gen_test_bit() the same way as the rest of functions
Date:   Tue,  7 Jun 2022 17:57:22 +0200
Message-Id: <20220607155722.44040-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <Yp9WFREfdfkho0hm@elver.google.com>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com> <20220606114908.962562-4-alexandr.lobakin@intel.com> <Yp9WFREfdfkho0hm@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marco Elver <elver@google.com>
Date: Tue, 7 Jun 2022 15:43:49 +0200

> On Mon, Jun 06, 2022 at 01:49PM +0200, Alexander Lobakin wrote:
> > Currently, the generic test_bit() function is defined as a one-liner
> > and in case with constant bitmaps the compiler is unable to optimize
> > it to a constant. At the same time, gen_test_and_*_bit() are being
> > optimized pretty good.
> > Define gen_test_bit() the same way as they are defined.
> > 
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> >  include/asm-generic/bitops/generic-non-atomic.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> > index 7a60adfa6e7d..202d8a3b40e1 100644
> > --- a/include/asm-generic/bitops/generic-non-atomic.h
> > +++ b/include/asm-generic/bitops/generic-non-atomic.h
> > @@ -118,7 +118,11 @@ gen___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
> >  static __always_inline int
> >  gen_test_bit(unsigned int nr, const volatile unsigned long *addr)
> >  {
> > -	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> > +	const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
> > +	unsigned long mask = BIT_MASK(nr);
> > +	unsigned long val = *p;
> > +
> > +	return !!(val & mask);
> 
> Unfortunately this makes the dereference of 'addr' non-volatile, and
> effectively weakens test_bit() to the point where I'd no longer consider
> it atomic. Per atomic_bitops.txt, test_bit() is atomic.
> 
> The generic version has been using a volatile access to make it atomic
> (akin to generic READ_ONCE() casting to volatile). The volatile is also
> the reason the compiler can't optimize much, because volatile forces a
> real memory access.

Ah-ha, I see now. Thanks for catching and explaining this!

> 
> Yes, confusingly, test_bit() lives in non-atomic.h, and this had caused
> confusion before, but the decision was made that moving it will cause
> headaches for ppc so it was left alone:
> https://lore.kernel.org/all/87a78xgu8o.fsf@dja-thinkpad.axtens.net/T/#u
> 
> As for how to make test_bit() more compiler-optimization friendly, I'm
> guessing that test_bit() needs some special casing where even the
> generic arch_test_bit() is different from the gen_test_bit().
> gen_test_bit() should probably assert that whatever it is called with
> can actually be evaluated at compile-time so it is never accidentally
> used otherwise.

I like the idea! Will do in v2.
I can move the generics and after, right below them, define
'const_*' helpers which will mostly redirect to 'generic_*', but
for test_bit() it will be a separate function with no `volatile`
and with an assertion that the input args are constants.

> 
> I would also propose adding a comment close to the deref that test_bit()
> is atomic and the deref needs to remain volatile, so future people will
> not try to do the same optimization.

I think that's also the reason why it's not underscored, right?

> 
> Thanks,
> -- Marco

Thanks,
Olek
