Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCB283363
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 11:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEJfq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 05:35:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:50803 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgJEJfq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 05:35:46 -0400
IronPort-SDR: qQ9DiyjycTSqqTnDHuTj9pZgHTVrQTFqcQ90az9JCKGFP3HnbBR84e26vl2rYHDMnCVeDsWJnN
 MTbWKoHJkemg==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="142755581"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="142755581"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 02:35:45 -0700
IronPort-SDR: bz6AhyrVwio06dKoiKbmdtFKhE2a4F1NB0oI4T/AlXgityM+kZs4N5M4uC8ldNGgSXZN7v/RIv
 5yGORhHys56Q==
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="516663355"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 02:35:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kPMuA-004aFA-Vi; Mon, 05 Oct 2020 12:35:38 +0300
Date:   Mon, 5 Oct 2020 12:35:38 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/4] bitops: Introduce the for_each_set_clump macro
Message-ID: <20201005093538.GM3956970@smile.fi.intel.com>
References: <cover.1601679791.git.syednwaris@gmail.com>
 <dcd0580812ebae079e6f5035b990b195ccc6b709.1601679791.git.syednwaris@gmail.com>
 <CAHp75VcoGAjrPa7rcORsaDXZLb-n+U3hG0k6O+weMVYweSPVxg@mail.gmail.com>
 <CACG_h5pianK4DRL5YeuSuN0gv6Jvcndc=_wLCL4QgmZyR=bOMw@mail.gmail.com>
 <CAHp75VdC+eH0ScksdAVp==HnDMTMY3vVUZM5NZy6mfVSR0YoLA@mail.gmail.com>
 <20201003125626.GA3732@shinobu>
 <CAHp75VdfGCnoyOEn9-c0O4cx7t8GRTH+Ux_gYiRvZeOnDyQryg@mail.gmail.com>
 <CACG_h5roN0dKGYMcZ3BXNzSMAWdU06mAx8NrpuomaubSRfdm-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACG_h5roN0dKGYMcZ3BXNzSMAWdU06mAx8NrpuomaubSRfdm-A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 03, 2020 at 08:38:14PM +0530, Syed Nayyar Waris wrote:
> On Sat, Oct 3, 2020 at 6:32 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Oct 3, 2020 at 3:56 PM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> > > On Sat, Oct 03, 2020 at 03:45:04PM +0300, Andy Shevchenko wrote:
> > > > On Sat, Oct 3, 2020 at 2:37 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > > > On Sat, Oct 3, 2020 at 2:14 PM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Sat, Oct 3, 2020 at 2:51 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

...

> > > > > > > +               map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> > > > > > > +               map[index] |= value << offset;
> > > >
> > > > Side note: I would prefer + 0 here and there, but it's up to you.
> 
> Andy what do you mean by the above statement, can you please clarify?
> Can you please elaborate on the above statement.

Sure. I meant something like

               map[index + 0] &= ~BITMAP_FIRST_WORD_MASK(start);
               map[index + 0] |= value << offset;

> > > > > > > +               map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > > > > > > +               map[index + 1] |= (value >> space);

-- 
With Best Regards,
Andy Shevchenko


