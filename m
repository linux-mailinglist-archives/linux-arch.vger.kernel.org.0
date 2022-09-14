Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5BA5B88CA
	for <lists+linux-arch@lfdr.de>; Wed, 14 Sep 2022 15:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiINNDL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Sep 2022 09:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiINNDK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Sep 2022 09:03:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E2D6051C;
        Wed, 14 Sep 2022 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663160589; x=1694696589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G3nunHZw0HXOmsMTYrHCL5+tpvupI1xxfdIlN7QmvpA=;
  b=NclA4GOAqf5IuV9ARazQllWaZd6E/CtojvPWu/+mT0bAQ6ztpjJ+Hc5c
   P6e24wgjIFGACF2a9iggD1HA8WForMbBEtKclz2iUORfCQf+vg09+4zM8
   Q1xncSSzQpO5J5HSf0OWtO5SgsuRg3cr0Z2Hr1YPPVhG3qPbY3wWMq0vl
   YmVatzY3kGNceHNTpiSgqdOzEHEN6h21Y/wN8IymC2cWlQQ4WNBGcaXiu
   G1B5QFFI6Kf5isUvreRZZBQH7dcpIqexA1y90/0LfC4NkTZpo7vMSw+Lf
   JXgQvD9tVZimTvBUE58kyghA1BNcdx4YwhEFhfQOk+oTPw+FCOxMz9dG9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278808403"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278808403"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 06:03:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="616856582"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 06:03:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oYS2c-002DBl-1B;
        Wed, 14 Sep 2022 16:02:58 +0300
Date:   Wed, 14 Sep 2022 16:02:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2 0/9] gpio: Get rid of ARCH_NR_GPIOS (v2)
Message-ID: <YyHRAnBaoycszSmC@smile.fi.intel.com>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <CAMRc=MehcpT84-ucLbYmdVTAjT86bNb9NEfV6npCmPZHqbsArw@mail.gmail.com>
 <b348a306-3043-4ccc-9067-81759ab29143@www.fastmail.com>
 <CACRpkdbazHcUassRMqZ2oHmama3nWEZ3U3bB-y-3dmo3jgFPWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbazHcUassRMqZ2oHmama3nWEZ3U3bB-y-3dmo3jgFPWg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 14, 2022 at 02:38:53PM +0200, Linus Walleij wrote:
> On Wed, Sep 7, 2022 at 12:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > >>  drivers/gpio/gpio-sta2x11.c              | 411 -----------------------
> (...)
> > sta2x11 is an x86 driver, so not my area, but I think it would be
> > best to kill off the entire platform rather than just its gpio
> > driver, since everything needs to work together and it's clearly
> > not functional at the moment.
> >
> > $ git grep -l STA2X11
> > Documentation/admin-guide/media/pci-cardlist.rst
> > arch/x86/Kconfig
> > arch/x86/include/asm/sta2x11.h
> > arch/x86/pci/Makefile
> > arch/x86/pci/sta2x11-fixup.c
> > drivers/ata/ahci.c
> > drivers/gpio/Kconfig
> > drivers/gpio/Makefile
> > drivers/gpio/gpio-sta2x11.c
> > drivers/i2c/busses/Kconfig
> > drivers/media/pci/Makefile
> > drivers/media/pci/sta2x11/Kconfig
> > drivers/media/pci/sta2x11/Makefile
> > drivers/media/pci/sta2x11/sta2x11_vip.c
> > drivers/media/pci/sta2x11/sta2x11_vip.h
> > drivers/mfd/Kconfig
> > drivers/mfd/Makefile
> > drivers/mfd/sta2x11-mfd.c
> > include/linux/mfd/sta2x11-mfd.h
> >
> > Removing the other sta2x11 bits (mfd, media, x86) should
> > probably be done through the respective tree, but it would
> > be good not to forget those.
> 
> Andy is pretty much default x86 platform device maintainer, maybe
> he can ACK or brief us on what he knows about the status of
> STA2x11?

Actually I have no idea about STA2x11, but in some thread I have noticed that
there were people who know more on the topic and they told that removal is the
right thing to do.

Not sure how it should be done practically (driver-by-driver or altogether),
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for either of the variants if it helps.

-- 
With Best Regards,
Andy Shevchenko


