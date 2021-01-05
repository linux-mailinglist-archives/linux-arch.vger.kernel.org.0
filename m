Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A42EAD7B
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 15:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbhAEOjr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jan 2021 09:39:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:57659 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbhAEOjr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Jan 2021 09:39:47 -0500
IronPort-SDR: 76GgTXaTbOxZI+4owxucJxNXHQhGBNlK59dqgMCyfv/Qa1pkMGV17Az9DYXIgpOnmcTuApvpbo
 kRiDBnb25b4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="195646550"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="195646550"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 06:38:26 -0800
IronPort-SDR: ORfDRMZuZZIjtE6Ot4XA8E9TvMJhsJAUxJ1mx5ey/k3CoGP/FtoFSprpDMWbSJKdXdzmdZ3M8W
 V7uDqPgr1s2g==
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="397844641"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 06:38:20 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kwnUX-002Cub-Lc; Tue, 05 Jan 2021 16:39:21 +0200
Date:   Tue, 5 Jan 2021 16:39:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/5] Introduce the for_each_set_clump macro
Message-ID: <20210105143921.GL4077@smile.fi.intel.com>
References: <cover.1608963094.git.syednwaris@gmail.com>
 <CACRpkdYZwMy5faNhUyiNnvdnMOf4ac7XWqjnf3f4jCJeE=p2Lw@mail.gmail.com>
 <CAMpxmJW46Oh2h7RrBNo5vACfYnWy63rZOO=Va=ppUDeaj5GpBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJW46Oh2h7RrBNo5vACfYnWy63rZOO=Va=ppUDeaj5GpBg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 05, 2021 at 03:19:13PM +0100, Bartosz Golaszewski wrote:
> On Sun, Dec 27, 2020 at 10:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Sat, Dec 26, 2020 at 7:41 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> >
> > > Since this patchset primarily affects GPIO drivers, would you like
> > > to pick it up through your GPIO tree?
> >
> > Actually Bartosz is handling the GPIO patches for v5.12.
> > I tried to merge the patch series before but failed for
> > various reasons.

> My info on this is a bit outdated - didn't Linus Torvalds reject these
> patches from Andrew Morton's PR? Or am I confusing this series with
> something else?

Linus T. told that it can be done inside GPIO realm. This version tries
(badly in my opinion) to achieve that.

-- 
With Best Regards,
Andy Shevchenko


