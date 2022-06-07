Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061C75403BB
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbiFGQ2T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 12:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiFGQ2T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 12:28:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B9B75221;
        Tue,  7 Jun 2022 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654619298; x=1686155298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ExbyLBBVlB99JJjQlhxs6g9MkUreWgPpOBU5Q2moeO4=;
  b=O9YzUUrgNny0g1n/fjKkK7nD8ghcJD67N3bjISH/S5QHPhJkUCMX98vA
   xThtctH/e5rbnsRCWnoo8cF/FRfHv40Iju/Jop7XzgfBOplV5taafuBlh
   UwD05gjOcWsLrj4Zp6Mcx25Y8yoje7yzykrdyBH4QAjL+iWnP6aGSzHuO
   RNimX/+NJ4cGpoMKlCFQ5V+U2chylJJ2Q2concdccOtSdmrdiUq8xbG2C
   0sCHohRIGAUoz56vI/y/oHNJ8OeHuR7hNxPt2uITCWE9vhdieEe3vPibu
   UR411XX79ymUXMpxwfFIGBEaP9mXcxW6xLlN8NGxgUygEUFfvGj6ZM5j5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257171093"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="257171093"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:28:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="723396141"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 09:28:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyc3s-000Vr1-Gp;
        Tue, 07 Jun 2022 19:28:08 +0300
Date:   Tue, 7 Jun 2022 19:28:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
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
Subject: Re: [PATCH 3/6] bitops: define gen_test_bit() the same way as the
 rest of functions
Message-ID: <Yp98mK3tfMrHVpvt@smile.fi.intel.com>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com>
 <20220606114908.962562-4-alexandr.lobakin@intel.com>
 <Yp9WFREfdfkho0hm@elver.google.com>
 <20220607155722.44040-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607155722.44040-1-alexandr.lobakin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 07, 2022 at 05:57:22PM +0200, Alexander Lobakin wrote:
> From: Marco Elver <elver@google.com>
> Date: Tue, 7 Jun 2022 15:43:49 +0200
> > On Mon, Jun 06, 2022 at 01:49PM +0200, Alexander Lobakin wrote:

...

> > I would also propose adding a comment close to the deref that test_bit()
> > is atomic and the deref needs to remain volatile, so future people will
> > not try to do the same optimization.
> 
> I think that's also the reason why it's not underscored, right?

Non-__ prefixed bitops are atomic, __ non-atomic.

-- 
With Best Regards,
Andy Shevchenko


