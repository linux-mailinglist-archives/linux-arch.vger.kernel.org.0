Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68526704DAD
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjEPMZB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 08:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjEPMZA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 08:25:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBA61FE7;
        Tue, 16 May 2023 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684239899; x=1715775899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1kZ67IohKTNXw9v48L99Ve76ncobxnQ7nLLOn/LyTKQ=;
  b=bGztEPKF1Ov+pXMZwo7x/7vcEdHRpNeEL7DcfevD2x9YZGx4uFVEaL09
   NHo2034CpOo3G1NCRVB+8rhnq+vqu7TGkLaocANPHxYltlnzWp9mYBKzb
   ntUA65105/kCa1D0omrXEP6e3abCh8FRYkulOvjdcckynDexROuv/PSZ7
   DIl3qdhyE7Wo8jo9O2GmcNcySTTOV4tX8Odbve4xwWCgjmyepUDPlTaVJ
   AyhaWE1prh51BwJBBryizRnJqud+s3NXEL7cjqHtQMYrg1wl1aBA7f0Pl
   wbuaWqJtd3le9q/dKzNdPrMh+dD3tTlzKkM6cqMLDpGIWfnbqQlmfeytZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="414868724"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="414868724"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 05:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="771018670"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="771018670"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga004.fm.intel.com with SMTP; 16 May 2023 05:24:53 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 16 May 2023 15:24:52 +0300
Date:   Tue, 16 May 2023 15:24:52 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 37/41] fbdev: atyfb: Remove unused clock determination
Message-ID: <ZGN2FKSBkMREujgR@intel.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-38-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516110038.2413224-38-schnelle@linux.ibm.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023 at 01:00:33PM +0200, Niklas Schnelle wrote:
> Just below the removed lines par->clk_wr_offset is hard coded to 3 so
> there is no use in determining a different clock just to then ignore it
> anyway. This also removes the only I/O port use remaining in the driver
> allowing it to be built without CONFIG_HAS_IOPORT.
> 
> Link: https://lore.kernel.org/all/ZBx5aLo5h546BzBt@intel.com/
> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>       per-subsystem patches may be applied independently
> 
>  drivers/video/fbdev/aty/atyfb_base.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> index b02e4e645035..cba2b113b28b 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -3498,11 +3498,6 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
>  	if (ret)
>  		goto atyfb_setup_generic_fail;
>  #endif
> -	if (!(aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_EXT_DISP_EN))
> -		par->clk_wr_offset = (inb(R_GENMO) & 0x0CU) >> 2;
> -	else
> -		par->clk_wr_offset = aty_ld_8(CLOCK_CNTL, par) & 0x03U;
> -
>  	/* according to ATI, we should use clock 3 for acelerated mode */
>  	par->clk_wr_offset = 3;
>  
> -- 
> 2.39.2

-- 
Ville Syrjälä
Intel
