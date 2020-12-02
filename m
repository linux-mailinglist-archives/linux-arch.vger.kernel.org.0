Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2E2CBC68
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 13:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgLBMHE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 07:07:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:19652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgLBMHE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 07:07:04 -0500
IronPort-SDR: uWgMTO5h/21hAoOB60nguGidrYrbPOS/li1EVOD7NwSHZ1wTPPEGZEOC3B1FH/oncwxCHaYMSV
 YcQmID/5wmhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="152831686"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="152831686"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 04:05:22 -0800
IronPort-SDR: WI4jymxyNBTSTdCRD76CykCDJfzjFUg7by17rSz/SQFWb8oZWgQ3s4XoOqhvJPMSYi5SmHsrFW
 1Ol6P4e4fVKQ==
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="345844066"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 04:05:19 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kkQto-00BVBc-5E; Wed, 02 Dec 2020 14:06:20 +0200
Date:   Wed, 2 Dec 2020 14:06:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, dushistov@mail.ru,
        arnd@arndb.de, akpm@linux-foundation.org, gustavo@embeddedor.com,
        vilhelm.gray@gmail.com, richard.weiyang@linux.alibaba.com,
        joseph.qi@linux.alibaba.com, skalluru@marvell.com,
        yury.norov@gmail.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] lib/find_bit: Add find_prev_*_bit functions.
Message-ID: <20201202120620.GC4077@smile.fi.intel.com>
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com>
 <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 02, 2020 at 08:50:24PM +0900, Yun Levi wrote:
> Thanks for kind advice. But I'm so afraid to have questions below:
> 
>  > - it proposes functionality w/o user (dead code)
>      Actually, I add these series functions to rewrite some of the
> resource clean-up routine.
>      A typical case is ethtool_set_per_queue_coalesce 's rollback label.
>      Could this usage be an actual use case?

Then create it as a patch in the series and in cover letter (0 message when you
supply --cover-letter to your `git format-patch ...` command line) mention
this.

>  >- it lacks extension of the bitmap test module to cover the new
>  > functions (that also wants to be a separate patch).
>      I see, then Could I add some of testcase on lib/test_bitops.c for testing?

Sounds good to me. Most important is to have test cases, then we will see which
test suite is the best fit, but as I said sounds like a good shot.

And please do not top post in replies!

> On Wed, Dec 2, 2020 at 7:04 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > On 02/12/2020 10.47, Andy Shevchenko wrote:
> > > On Wed, Dec 02, 2020 at 10:10:09AM +0900, Yun Levi wrote:
> > >> Inspired find_next_*bit function series, add find_prev_*_bit series.
> > >> I'm not sure whether it'll be used right now But, I add these functions
> > >> for future usage.
> > >
> > > This patch has few issues:
> > > - it has more things than described (should be several patches instead)
> > > - new functionality can be split logically to couple or more pieces as well
> > > - it proposes functionality w/o user (dead code)
> >
> > Yeah, the last point means it can't be applied - please submit it again
> > if and when you have an actual use case. And I'll add
> >
> > - it lacks extension of the bitmap test module to cover the new
> > functions (that also wants to be a separate patch).

-- 
With Best Regards,
Andy Shevchenko


