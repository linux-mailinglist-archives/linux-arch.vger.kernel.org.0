Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9CD6C6CF7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 17:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjCWQJh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjCWQJf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 12:09:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BD32CCF;
        Thu, 23 Mar 2023 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679587764; x=1711123764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oqSdem/sOUPFA6LJjb47XXFK2yU7aMg4ahHIKQNpGhA=;
  b=A6OB1ziWY98bUcoTF0iMFohkk+yPuAVoixJURXM2iRc1n5pjzupm/E/p
   k0zVXbCCNrcEPwZTLGRPzWvc4RlZcF9SAjz96Row8AiLOiXQutQhzmLwS
   0PBUi3SFikayrPxcZcOphXi56DF4XorAemfY6D6XbWXrRpoFpCUFjX1jC
   grnDup1fjR7ywFx4grnw5tdJnk9yLJDFXhxdoP4HvxaJiB4jZJZGqYu12
   DDAPajZHXBt2d1xzj2LX3ivs4KrRaFtpEJ+/tGk3cfBCGIbv8rpmgf3wd
   TJW64cC2mzWo5TDE+CyiemhfnIPmxt1zkz84+4/H896uZdpWVRPfrrXc+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323400518"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="323400518"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 09:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="714869188"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="714869188"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by orsmga001.jf.intel.com with SMTP; 23 Mar 2023 09:08:09 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 23 Mar 2023 18:08:08 +0200
Date:   Thu, 23 Mar 2023 18:08:08 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-fbdev@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v3 35/38] video: handle HAS_IOPORT dependencies
Message-ID: <ZBx5aLo5h546BzBt@intel.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-36-schnelle@linux.ibm.com>
 <CAMuHMdW4f8GJ-kFDPg6Ao=g3ZAXq79u9nUZ_dW1LonHu+vxk8Q@mail.gmail.com>
 <ZBGbxDWEhqr8hhgU@intel.com>
 <917b95c9af1b80843b8a361d1b7fa337a25105e7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <917b95c9af1b80843b8a361d1b7fa337a25105e7.camel@linux.ibm.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023 at 03:17:38PM +0100, Niklas Schnelle wrote:
> On Wed, 2023-03-15 at 12:19 +0200, Ville Syrjälä wrote:
> > On Wed, Mar 15, 2023 at 09:16:50AM +0100, Geert Uytterhoeven wrote:
> > > Hi Niklas,
> > > 
> > > On Tue, Mar 14, 2023 at 1:13 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > > not being declared. We thus need to add HAS_IOPORT as dependency for
> > > > those drivers using them and guard inline code in headers.
> > > > 
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > 
> > > Thanks for your patch!
> > > 
> > > > --- a/drivers/video/fbdev/Kconfig
> > > > +++ b/drivers/video/fbdev/Kconfig
> > > 
> > > > @@ -1284,7 +1285,7 @@ config FB_ATY128_BACKLIGHT
> > > > 
> > > >  config FB_ATY
> > > >         tristate "ATI Mach64 display support" if PCI || ATARI
> > > > -       depends on FB && !SPARC32
> > > > +       depends on FB && HAS_IOPORT && !SPARC32
> > > 
> > > On Atari, this works without ATARI_ROM_ISA, hence it must not depend
> > > on HAS_IOPORT.
> > > The only call to inb() is inside a section protected by #ifdef
> > > CONFIG_PCI. So:
> > 
> > That piece of code is a nop anyway. We immediately overwrite
> > clk_wr_offset with a hardcoded selection after the register reads.
> > So if you nuke that nop code then no IOPORT dependency required
> > at all.
> > 
> 
> I agree this "looks" like a nop but are we sure the inb() doesn't have
> side effects? 

Yes. It's just trying to check which PLL dividers/etc. are currently
used. In VGA mode it gets it from a the GENMO and in non-VGA mode from
CLOCK_CNTL. And then it says "screw that" and just uses index 3 instead.

Though I must say that mach64 GX seems to use that clk_wr_offset
very differently so I'm not sure the PCI+GX combo is even working
currently, assuming those even exist. I don't think I have anything
older than a PCI mach64 VT myself.

> (for reference drivers/video/fbdev/aty/aty/atyfb_base.c:
> atyfb_setup_generc() towards the end)
> 
> It does feel a bit out of scope for this series but if it's really a
> nop nuking it surely is the cleaner solution.
> 
> Thanks,
> Niklas

-- 
Ville Syrjälä
Intel
