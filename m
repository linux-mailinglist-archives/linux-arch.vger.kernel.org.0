Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C331B7BB0
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgDXQeK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 12:34:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:11407 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgDXQeK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 12:34:10 -0400
IronPort-SDR: XExRAI9o+lqhrFYWuvEyikVXV1a3fByAKsXYyZtkQhv3xdj6aOzYfX3J8UTt3FQY25GehrAEoC
 C84fgaZWopGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 09:34:10 -0700
IronPort-SDR: ngvym3+L5ScyIZ1Lzg94Y3EyStWESL5cit+lM/KL/xmSGIspPVGp49mPFcyjBgcpwPUAyif5XG
 Xt7mXyPXJMjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="274647472"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 24 Apr 2020 09:34:07 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jS1HG-002sEv-MN; Fri, 24 Apr 2020 19:34:10 +0300
Date:   Fri, 24 Apr 2020 19:34:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        akpm@linux-foundation.org, arnd@arndb.de,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200424163410.GD185537@smile.fi.intel.com>
References: <20200424122521.GA5552@syed>
 <20200424141037.ersebbfe7xls37be@wunner.de>
 <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
 <20200424150058.xadjxaga3csh3br6@wunner.de>
 <20200424150828.GA5034@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424150828.GA5034@icarus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 24, 2020 at 11:09:26AM -0400, William Breathitt Gray wrote:
> On Fri, Apr 24, 2020 at 05:00:58PM +0200, Lukas Wunner wrote:
> > On Fri, Apr 24, 2020 at 08:22:38PM +0530, Syed Nayyar Waris wrote:
> > > On Fri, Apr 24, 2020 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > > On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:

...

> > > So, this function preserves the behaviour of earlier
> > > bitmap_set_value8() function and also adds extra functionality to
> > > that.
> > 
> > Please leave drivers as is which use exclusively 8-bit accesses,
> > e.g. gpio-max3191x.c and gpio-74x164.c.  I'm fearing a performance
> > regression if your new generic variant is used.  They work perfectly
> > fine the way they are and I don't see any benefit this series may have
> > for them.
> > 
> > If there are other drivers which benefit from the flexibility of your
> > generic variant then I'm not opposed to changing those.

> We can leave of course bitmap_set_value8 alone, but for 8-bit values the
> difference in latency I suspect is primarily due to the conditional test
> for the word boundaries. This latency is surely overshadowed by the I/O
> latency of the GPIO drivers, so I don't think there's much harm in
> changing those to use the generic function when the bottleneck will not
> be due to the bitmap_set_value/bitmap_get_value operations.

Okay, how many new (non-8-bit) users this will target?

-- 
With Best Regards,
Andy Shevchenko


