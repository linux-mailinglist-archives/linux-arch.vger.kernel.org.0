Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A8B53EB79
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbiFFOc0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbiFFOcZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 10:32:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB7619FB4;
        Mon,  6 Jun 2022 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654525944; x=1686061944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UxE8NFVyWkYcl6VDWo0Xc7AS/+WRnnbtxB431hbdf8E=;
  b=BICLIJM1RRUCHuX5r1LZbr9NC+T+7i63AocrimLUDszR/dCCi89tIQkF
   5mXYjeKhFHeEvnHqrwDg+Jp4eU/uw+qrvz0lh8zr5Vatiw+8/bWTa9B2o
   I0bD2HMpA4B7RcvOqjq+UvXDNx3qDGBQUJK0ecrZB+g5nSpmiJfMNBYi+
   aW22VdsYFlfiIbBlcT+K17FNEsy9E5DI0h8D2qTKDaSO6vCOl7NKQNQ6a
   pRqjzv16kzSegYarBS+O4/A5MivnXSkE3ObHjlZ84/8eFM////8/bdiZb
   xj4CZ8u3k8aKcMRRk+obDxVkgPJsjZht12QuKVpmUphsNBo7ZiiRTiE8S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276980221"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276980221"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 07:22:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="614371881"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 06 Jun 2022 07:22:34 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 256EMW5u012713;
        Mon, 6 Jun 2022 15:22:32 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] bitops: always define asm-generic non-atomic bitops
Date:   Mon,  6 Jun 2022 16:21:35 +0200
Message-Id: <20220606142135.965134-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <Yp32xDZ/qF8hM6p0@FVFF77S0Q05N>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com> <20220606114908.962562-3-alexandr.lobakin@intel.com> <Yp32xDZ/qF8hM6p0@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 6 Jun 2022 13:44:52 +0100

> On Mon, Jun 06, 2022 at 01:49:03PM +0200, Alexander Lobakin wrote:
> > Move generic non-atomic bitops from the asm-generic header which
> > gets included only when there are no architecture-specific
> > alternatives, to a separate independent file to make them always
> > available.
> > 
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> >  .../asm-generic/bitops/generic-non-atomic.h   | 124 ++++++++++++++++++
> >  include/asm-generic/bitops/non-atomic.h       | 109 ++-------------
> >  2 files changed, 132 insertions(+), 101 deletions(-)
> >  create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
> > 
> > diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> > new file mode 100644
> > index 000000000000..7a60adfa6e7d
> > --- /dev/null
> > +++ b/include/asm-generic/bitops/generic-non-atomic.h
> > @@ -0,0 +1,124 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H
> > +#define __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H
> > +
> > +#include <linux/bits.h>
> > +
> > +#ifndef _LINUX_BITOPS_H
> > +#error only <linux/bitops.h> can be included directly
> > +#endif
> > +
> > +/*
> > + * Generic definitions for bit operations, should not be used in regular code
> > + * directly.
> > + */
> > +
> > +/**
> > + * gen___set_bit - Set a bit in memory
> > + * @nr: the bit to set
> > + * @addr: the address to start counting from
> > + *
> > + * Unlike set_bit(), this function is non-atomic and may be reordered.
> > + * If it's called on the same region of memory simultaneously, the effect
> > + * may be that only one operation succeeds.
> > + */
> > +static __always_inline void
> > +gen___set_bit(unsigned int nr, volatile unsigned long *addr)
> 
> Could we please use 'generic' rather than 'gen' as the prefix?
> 
> That'd match what we did for the generic atomic_*() and atomic64_*() functions
> in commits
> 
> * f8b6455a9d381fc5 ("locking/atomic: atomic: support ARCH_ATOMIC")
> * 1bdadf46eff6804a ("locking/atomic: atomic64: support ARCH_ATOMIC")
> 
> ... and it avoids any potential confusion with 'gen' meaning 'generated' or
> similar.

Sure! Thanks for giving the hint, I do agree it would look better
and will rename in v2.

> 
> Thanks,
> Mark.
> 
> > +{
> > +	unsigned long mask = BIT_MASK(nr);
> > +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> > +
> > +	*p  |= mask;
> > +}

[...]

> > -- 
> > 2.36.1

Thanks,
Al
