Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD21B6BAD85
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjCOKV1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjCOKVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:21:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F062385B1D;
        Wed, 15 Mar 2023 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678875630; x=1710411630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AZu0G5MJgXhilc9n2aaLZyeOdNLiwJBTw+hEvyBlZ5c=;
  b=T8kZEwVhIINEHEl+0mRmwwPrRzsXLF7FUm3SCX3oSTSTp5JL/gHm1uAs
   8vpPE8rHK9FSRmlEo3AGDxskwrjRN3EHThEvUJBoij9xWOEXXKmFJkPN5
   wzMN/QYlDYeeP1//cEiWaMeyBXJ6vqxjl9UtY5u1Q3LWNigiUps+LujNT
   AnTBHR9PewSj+N57HdftyM5XJMDJOTP3bJ8G9NKjV/B9hLB8FwUb0Zf3k
   PRAAfrAPOmnYFYRois5zQ/oBnBITYKpQuaIvbvlYNNEACgsGCWYPCJ3R0
   LLVn36dm1ezKX9cHq2wI9j9Bz7UgHU5L5v9c/duuRLyZVQicp7Naa0mdI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="400246109"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="400246109"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 03:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="672684150"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672684150"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by orsmga007.jf.intel.com with SMTP; 15 Mar 2023 03:19:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 15 Mar 2023 12:19:48 +0200
Date:   Wed, 15 Mar 2023 12:19:48 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
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
Message-ID: <ZBGbxDWEhqr8hhgU@intel.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-36-schnelle@linux.ibm.com>
 <CAMuHMdW4f8GJ-kFDPg6Ao=g3ZAXq79u9nUZ_dW1LonHu+vxk8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW4f8GJ-kFDPg6Ao=g3ZAXq79u9nUZ_dW1LonHu+vxk8Q@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 09:16:50AM +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Tue, Mar 14, 2023 at 1:13 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them and guard inline code in headers.
> >
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> 
> > @@ -1284,7 +1285,7 @@ config FB_ATY128_BACKLIGHT
> >
> >  config FB_ATY
> >         tristate "ATI Mach64 display support" if PCI || ATARI
> > -       depends on FB && !SPARC32
> > +       depends on FB && HAS_IOPORT && !SPARC32
> 
> On Atari, this works without ATARI_ROM_ISA, hence it must not depend
> on HAS_IOPORT.
> The only call to inb() is inside a section protected by #ifdef
> CONFIG_PCI. So:

That piece of code is a nop anyway. We immediately overwrite
clk_wr_offset with a hardcoded selection after the register reads.
So if you nuke that nop code then no IOPORT dependency required
at all.

> 
>     depends on FB && !SPARC32
>     depends on ATARI || HAS_IOPORT
> 
> >         select FB_CFB_FILLRECT
> >         select FB_CFB_COPYAREA
> >         select FB_CFB_IMAGEBLIT
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Ville Syrjälä
Intel
