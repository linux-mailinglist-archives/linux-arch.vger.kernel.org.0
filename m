Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D084C510016
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351451AbiDZONm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351452AbiDZONj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 10:13:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291196256;
        Tue, 26 Apr 2022 07:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B025D61760;
        Tue, 26 Apr 2022 14:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E92C385AA;
        Tue, 26 Apr 2022 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650982231;
        bh=ZPeje/e98HoyDemHXaKoIfAh2yfEIqi6kqltvCUz+ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crfo0u+PB5SA5RNj0pQLJWatVk5+qE7b+uBd61uRcRaJxczzYs9rk/aVzPXrKyYwc
         griwOklNbGPxwfqD9bWrszcneMdtK+CgXXW2ayV/CSuFqtcqOY4sb8e6wUBk3O37MM
         NeZ4qAp8hltXLoSrkQ0y3zsY+oM+cY/t8FoJi6YM=
Date:   Tue, 26 Apr 2022 16:10:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-api@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 05/10] serial: termbits: ADDRB to indicate 9th bit
 addressing mode
Message-ID: <Ymf9UhyXj7o8cNhq@kroah.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
 <20220426122448.38997-6-ilpo.jarvinen@linux.intel.com>
 <Ymfq+jUXfZcNM/P/@kroah.com>
 <b667479-fb27-8712-cec8-938eed179240@linux.intel.com>
 <17547658-4737-7ec1-9ef9-c61c6287b8b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17547658-4737-7ec1-9ef9-c61c6287b8b@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 05:01:31PM +0300, Ilpo Järvinen wrote:
> One additional thing below I missed on the first read.
> 
> On Tue, 26 Apr 2022, Ilpo Järvinen wrote:
> > On Tue, 26 Apr 2022, Greg KH wrote:
> > 
> > > On Tue, Apr 26, 2022 at 03:24:43PM +0300, Ilpo Järvinen wrote:
> > > > Add ADDRB to termbits to indicate 9th bit addressing mode. This change
> > > > is necessary for supporting devices with RS485 multipoint addressing
> > > > [*]. A later patch in the patch series adds support for Synopsys
> > > > Designware UART capable for 9th bit addressing mode. In this mode, 9th
> > > > bit is used to indicate an address (byte) within the communication
> > > > line. The 9th bit addressing mode is selected using ADDRB introduced by
> > > > an earlier patch.
> > > > 
> > > > [*] Technically, RS485 is just an electronic spec and does not itself
> > > > specify the 9th bit addressing mode but 9th bit seems at least
> > > > "semi-standard" way to do addressing with RS485.
> > > > 
> > > > Cc: linux-api@vger.kernel.org
> > > > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > > > Cc: Matt Turner <mattst88@gmail.com>
> > > > Cc: linux-alpha@vger.kernel.org
> > > > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > > Cc: linux-mips@vger.kernel.org
> > > > Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> > > > Cc: Helge Deller <deller@gmx.de>
> > > > Cc: linux-parisc@vger.kernel.org
> > > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > Cc: Paul Mackerras <paulus@samba.org>
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: sparclinux@vger.kernel.org
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: linux-arch@vger.kernel.org
> > > > Cc: linux-usb@vger.kernel.org
> > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> 
> > > >  #define CMSPAR    010000000000          /* mark or space (stick) parity */
> > > >  #define CRTSCTS   020000000000          /* flow control */
> > > >  
> > > > diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
> > > > index ed18bc61f63d..c6a033732f39 100644
> > > > --- a/arch/powerpc/include/uapi/asm/termbits.h
> > > > +++ b/arch/powerpc/include/uapi/asm/termbits.h
> > > > @@ -171,6 +171,7 @@ struct ktermios {
> > > >  #define HUPCL	00040000
> > > >  
> > > >  #define CLOCAL	00100000
> > > > +#define ADDRB	004000000000		/* address bit */
> > > >  #define CMSPAR	  010000000000		/* mark or space (stick) parity */
> > > >  #define CRTSCTS	  020000000000		/* flow control */
> > > >  
> > > > diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
> > > > index ce5ad5d0f105..5eb1d547b5c4 100644
> > > > --- a/arch/sparc/include/uapi/asm/termbits.h
> > > > +++ b/arch/sparc/include/uapi/asm/termbits.h
> > > > @@ -201,6 +201,7 @@ struct ktermios {
> > > >  #define B3500000  0x00001012
> > > >  #define B4000000  0x00001013  */
> > > >  #define CIBAUD	  0x100f0000  /* input baud rate (not used) */
> > > > +#define ADDRB	  0x20000000  /* address bit */
> > > >  #define CMSPAR	  0x40000000  /* mark or space (stick) parity */
> > > >  #define CRTSCTS	  0x80000000  /* flow control */
> > > 
> > > Why all the different values?  Can't we pick one and use it for all
> > > arches?  Having these be different in different arches and userspace
> > > should not be a thing for new fields, right?
> 
> ADDRB value is the same for all archs (it's just this octal vs hex 
> notation I've followed as per the nearby defines within the same file
> which makes them look different).
> 
> Should I perhaps add to my cleanup list conversion of all those octal ones 
> to hex?

Argh, yes, please, let's do that now, I totally missed that.  Will let
us see how to unify them as well.

thanks,

greg k-h
