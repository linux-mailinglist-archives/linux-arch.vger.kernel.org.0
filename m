Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06502CC3F2
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 18:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgLBRhp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 12:37:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:52848 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgLBRho (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 12:37:44 -0500
IronPort-SDR: onY5/D1yDAxHeAzwiZtBblQtWwXYZ8FfSUIhJWI/dEZukVi8Anrz6TSQbx7oDbqv1O2VX2BGlO
 QVWrX0OQppMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173154737"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="173154737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 09:36:03 -0800
IronPort-SDR: Wy/5zw3hcDuhEIv3twhlv54mbz6H22Fm4pfiMIORG3YakEV8vu8Gc5wCQ8XWV6L0PHGMfGCcPk
 JpPb+V81XGrQ==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="373578549"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 09:36:00 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kkW3p-00BZAb-IA; Wed, 02 Dec 2020 19:37:01 +0200
Date:   Wed, 2 Dec 2020 19:37:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Yun Levi <ppbuk5246@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, dushistov@mail.ru,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] lib/find_bit: Add find_prev_*_bit functions.
Message-ID: <20201202173701.GM4077@smile.fi.intel.com>
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com>
 <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 02, 2020 at 09:26:05AM -0800, Yury Norov wrote:
> On Wed, Dec 2, 2020 at 3:50 AM Yun Levi <ppbuk5246@gmail.com> wrote:

...

>  I think this patch has some good catches. We definitely need to implement
> find_last_zero_bit(), as it is used by fs/ufs, and their local
> implementation is not optimal.

Side note: speaking of performance, any plans to fix for_each_*_bit*() for
cases when the nbits is known to be <= BITS_PER_LONG?

Now it makes an awful code generation (something like few hundred bytes of
code).

-- 
With Best Regards,
Andy Shevchenko


