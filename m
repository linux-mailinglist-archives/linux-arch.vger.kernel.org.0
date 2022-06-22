Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBD3554CC4
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357478AbiFVOWv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353396AbiFVOWu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 10:22:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABABA13D2A;
        Wed, 22 Jun 2022 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655907769; x=1687443769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FIomGT1BU8L+wKYhsbRgrEVpUz0TNAc9c/kXUa0n8fY=;
  b=hA3I3SAh3kYWGHf6tmliGGc4nVZH3XUQrGMS8LOQWSKJAp8e6kkMXaPR
   aSNgiNdOZ6yiYGvC8cTcEyDKZu1EmhB1EJF0NfjXCuL/PQF0/C2YnwGJ7
   XfY2GbrIvWq4o6eCxYzdfZtfqt6m7dCPPjNiEfU97hv8SoJ4sM/ZDrqc9
   x2JCGeNVSqj81dGj+2yEck+rabqiFsdvPy4gGlB/1O3O1mc+AYdrj2yHo
   gODyIdlCYCWo2C5FROq4Q1+JX5aYVGot3NDV0ZKA6gLhxlySL/yf5uMQY
   lq3Rhyl3xh/K6Hg9F/ZOTHBmjeGYSSFlqMED7kAhqd3OpeVrlTXNJbWlV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="366750900"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="366750900"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 07:22:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690523078"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 07:22:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o41Ff-000sND-3c;
        Wed, 22 Jun 2022 17:22:39 +0300
Date:   Wed, 22 Jun 2022 17:22:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
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
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] bitops: let optimize out non-atomic bitops on
 compile-time constants
Message-ID: <YrMlrjbue7twWLk1@smile.fi.intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com>
 <20220622122440.87087-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622122440.87087-1-alexandr.lobakin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 22, 2022 at 02:24:40PM +0200, Alexander Lobakin wrote:
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Tue, 21 Jun 2022 21:15:45 +0200
> 
> > While I was working on converting some structure fields from a fixed
> > type to a bitmap, I started observing code size increase not only in
> > places where the code works with the converted structure fields, but
> > also where the converted vars were on the stack. That said, the
> > following code:
> 
> [...]
> 
> Oh gosh, now s390 failed and 7/8 revealed one existing code flaw in
> the ice driver.
> I'll fix those, then will try to test more platforms (to not spam
> series again) and send v5 soon (mentioning this as bots CCs only
> myself).

One mail per person? Because I also got a report.

-- 
With Best Regards,
Andy Shevchenko


