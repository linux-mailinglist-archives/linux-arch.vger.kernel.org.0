Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0DF67CAB0
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 13:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbjAZMOx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 07:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjAZMOx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 07:14:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91801474C9;
        Thu, 26 Jan 2023 04:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674735292; x=1706271292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fMhmF78sLkly7xduJ/mjkQCmfGoPv2TV3bjvj2gw+g4=;
  b=n6/9Gwmhkxjzw8Wh1iZkJd4zMxiO81Y13YiBQSLijjP/t7i+cItOdvsP
   8RhdhCQUtR7pytdwQ3XWYbkBJJ+85ciVgJhpr3cIgzsobZRdVsjzUqnUT
   un71uottdjkFOiI68n/eGnKriPo9z6Thi5nzv/H5GtRc0KffKSZzEZ+Ga
   e+3s2lVJuiNif4dzuDxSyLoxzxBe2u4i74ELGCdQoYURhkU9E7WANCCd1
   jGnIvHiLbzjBVAGw9EpJtW0lAvp2O4TQF39Eht6JSiHoeWvZRhDoNftVS
   +KDLEEwECgfBGYH4J1eU2Oj9aylphNcPnMntwF8vuQNwQ7xB/ptG/PrFY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="354094327"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="354094327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 04:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="693311923"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="693311923"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2023 04:14:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pL19R-00FNTo-2p;
        Thu, 26 Jan 2023 14:14:45 +0200
Date:   Thu, 26 Jan 2023 14:14:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is
 disabled
Message-ID: <Y9JutROZBPIHj7z6@smile.fi.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
 <05d32a58-c119-4abb-8e62-9d79bd95324f@app.fastmail.com>
 <Y9JTPAL7VDXNPy5h@smile.fi.intel.com>
 <7bf72f8f-1936-4b1e-b970-2fe09b6641ca@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf72f8f-1936-4b1e-b970-2fe09b6641ca@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 11:27:51AM +0100, Arnd Bergmann wrote:
> On Thu, Jan 26, 2023, at 11:17, Andy Shevchenko wrote:
> > On Thu, Jan 26, 2023 at 09:40:18AM +0100, Arnd Bergmann wrote:
> >> On Thu, Jan 26, 2023, at 09:14, Christophe Leroy wrote:
> >> 
> >> All of these should already prevent the link failure through
> >> a Kconfig 'depends on GPIOLIB' for the driver, or 'select GPIOLIB'
> >> for the platform code. I checked all of the above and they seem fine.
> >> If anything else calls the function, I'd add the same dependency
> >> there.
> >
> > So, you think it's worth to send a few separate fixes as adding that
> > dependency? But doesn't it feel like a papering over the issue with
> > that APIs used in some of the drivers in the first place?
> 
> If there are drivers that use the interfaces but shouldn't then
> fixing those drivers is clearly better than adding a dependency,
> but we can decide that when someone sends a patch.
> 
> Adding a stub helper that can never be used legitimately
> but turns a build time error into a run time warning seems
> counterproductive to me, as the CI systems are no longer
> able to report these automatically.

What about adding ifdeffery in their code instead with a FIXME comment? So
we will know that it's ugly and needs to be solved better sooner than later.

-- 
With Best Regards,
Andy Shevchenko


