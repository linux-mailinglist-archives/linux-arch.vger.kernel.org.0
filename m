Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9153FCB1
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 13:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242314AbiFGLBb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 07:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242611AbiFGLAY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 07:00:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4519831224;
        Tue,  7 Jun 2022 03:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654599503; x=1686135503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xf+xgYb0NBQxQ+h8wlDbNS86vV9+HUcg11x5pXMRmAQ=;
  b=R2doGKjQuidWS+kP8eBepGTA0o9o2t3YZ1d7pIhaFSvt+amH2modQtqO
   8OXFpDR1Z0iyOCd16iZiqBN0B3rqGDTOVsbechc0N7hrbOxTNobw4TjlR
   mZnUK96IULjtFZscvt4FX/X7NxFu+6UeSj9yRomviIhVU79qUDGgV3pzV
   nM2ANswMciiasZldd+Q0ziDOPbh84MQx9RfZhl8JeFTZ0b0mgNRSS/zkq
   IvlAXc4Bmpx7shijjRfhE/f94CLJ95gH7ghQNxVijNeDlD2LDB0N5SzXH
   RlNIwSHZaIpfnei5qaSSy5sA3JElSl0AOm8f6cxPa6PxvWRnQ71S6xloD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="265083760"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="265083760"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 03:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="614868186"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2022 03:58:16 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 257AwEl8019500;
        Tue, 7 Jun 2022 11:58:14 +0100
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
Subject: Re: [PATCH 5/6] bitops: wrap non-atomic bitops with a transparent macro
Date:   Tue,  7 Jun 2022 12:57:18 +0200
Message-Id: <20220607105718.72434-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <Yp4q5KlIxmlznvuh@FVFF77S0Q05N.cambridge.arm.com>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com> <20220606114908.962562-6-alexandr.lobakin@intel.com> <Yp4q5KlIxmlznvuh@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 6 Jun 2022 17:27:16 +0100

> On Mon, Jun 06, 2022 at 01:49:06PM +0200, Alexander Lobakin wrote:
> > In preparation for altering the non-atomic bitops with a macro, wrap
> > them in a transparent definition. This requires prepending one more
> > '_' to their names in order to be able to do that seamlessly.
> > sparc32 already has the triple-underscored functions, so I had to
> > rename them ('___' -> 'sp32_').
> 
> Could we use an 'arch_' prefix here, like we do for the atomics, or is that
> already overloaded?

Yeah it is, for example, x86 has 'arch_' functions defined in its
architecture headers[0] and at the same time uses generic
instrumented '__' helpers[1], so on x86 both underscored and 'arch_'
are defined and they are not the same.
Same with those sparc32 triple-underscored, sparc32 at the same time
uses generic non-instrumented, so it has underscored, 'arch_' and
triple-underscored.

In general, bitops are overloaded with tons of prefixes already :)
I'm not really glad that I introduced one more level, but not that
we have many options here.

> 
> Thanks,
> Mark.
> 
> > 
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---

[...]

> > -- 
> > 2.36.1

Thanks,
Olek
