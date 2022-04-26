Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9850FFF6
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbiDZOGC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 10:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351411AbiDZOGA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 10:06:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BEE1971F4;
        Tue, 26 Apr 2022 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650981771; x=1682517771;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=muy4OIGsUfuoU+ynYUj8788CzK12+NiFyJaROrENCgM=;
  b=bGEdcC8sErWvGC/OmeIesPqYTXfEch4nEDfp2DV4sm9SdYq2dz2eNXx4
   gjvYuskNY6iFX2aNjTy61bVTPZPIhr2l1s3IXvPbsx4KnGK+QkN8HLLTs
   5PWW9OImGO6s/s3SOvTEuQE/2jtacosGMCcVGCdYuLrKS2kaVZRaEUoCF
   sobTfhbbVvILvjeVctKQQYHb+jpznxobPNj5FQuB1f4oUHYqLEM69aJEQ
   iHKzzXP1G4KjBGEjRNAie7WvVGq6GVmZYrMW/IUCiMGotafPKvrrkYVy7
   aSXdZtH7oeClYupr8OXXcBmQqrznQJLp/OlJlpzZMQKLbSLqhjZCggPH0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="328527164"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="328527164"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:01:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="579908538"
Received: from mmilkovx-mobl.amr.corp.intel.com ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:01:33 -0700
Date:   Tue, 26 Apr 2022 17:01:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
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
In-Reply-To: <b667479-fb27-8712-cec8-938eed179240@linux.intel.com>
Message-ID: <17547658-4737-7ec1-9ef9-c61c6287b8b@linux.intel.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com> <20220426122448.38997-6-ilpo.jarvinen@linux.intel.com> <Ymfq+jUXfZcNM/P/@kroah.com> <b667479-fb27-8712-cec8-938eed179240@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-479992224-1650981548=:1644"
Content-ID: <e8f02d4e-af44-a225-9cea-5c1babfa1471@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-479992224-1650981548=:1644
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <16767992-12e-3b16-2fdb-9ced864fa36e@linux.intel.com>

One additional thing below I missed on the first read.

On Tue, 26 Apr 2022, Ilpo Järvinen wrote:
> On Tue, 26 Apr 2022, Greg KH wrote:
> 
> > On Tue, Apr 26, 2022 at 03:24:43PM +0300, Ilpo Järvinen wrote:
> > > Add ADDRB to termbits to indicate 9th bit addressing mode. This change
> > > is necessary for supporting devices with RS485 multipoint addressing
> > > [*]. A later patch in the patch series adds support for Synopsys
> > > Designware UART capable for 9th bit addressing mode. In this mode, 9th
> > > bit is used to indicate an address (byte) within the communication
> > > line. The 9th bit addressing mode is selected using ADDRB introduced by
> > > an earlier patch.
> > > 
> > > [*] Technically, RS485 is just an electronic spec and does not itself
> > > specify the 9th bit addressing mode but 9th bit seems at least
> > > "semi-standard" way to do addressing with RS485.
> > > 
> > > Cc: linux-api@vger.kernel.org
> > > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > > Cc: Matt Turner <mattst88@gmail.com>
> > > Cc: linux-alpha@vger.kernel.org
> > > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > Cc: linux-mips@vger.kernel.org
> > > Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> > > Cc: Helge Deller <deller@gmx.de>
> > > Cc: linux-parisc@vger.kernel.org
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: sparclinux@vger.kernel.org
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: linux-arch@vger.kernel.org
> > > Cc: linux-usb@vger.kernel.org
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---

> > >  #define CMSPAR    010000000000          /* mark or space (stick) parity */
> > >  #define CRTSCTS   020000000000          /* flow control */
> > >  
> > > diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
> > > index ed18bc61f63d..c6a033732f39 100644
> > > --- a/arch/powerpc/include/uapi/asm/termbits.h
> > > +++ b/arch/powerpc/include/uapi/asm/termbits.h
> > > @@ -171,6 +171,7 @@ struct ktermios {
> > >  #define HUPCL	00040000
> > >  
> > >  #define CLOCAL	00100000
> > > +#define ADDRB	004000000000		/* address bit */
> > >  #define CMSPAR	  010000000000		/* mark or space (stick) parity */
> > >  #define CRTSCTS	  020000000000		/* flow control */
> > >  
> > > diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
> > > index ce5ad5d0f105..5eb1d547b5c4 100644
> > > --- a/arch/sparc/include/uapi/asm/termbits.h
> > > +++ b/arch/sparc/include/uapi/asm/termbits.h
> > > @@ -201,6 +201,7 @@ struct ktermios {
> > >  #define B3500000  0x00001012
> > >  #define B4000000  0x00001013  */
> > >  #define CIBAUD	  0x100f0000  /* input baud rate (not used) */
> > > +#define ADDRB	  0x20000000  /* address bit */
> > >  #define CMSPAR	  0x40000000  /* mark or space (stick) parity */
> > >  #define CRTSCTS	  0x80000000  /* flow control */
> > 
> > Why all the different values?  Can't we pick one and use it for all
> > arches?  Having these be different in different arches and userspace
> > should not be a thing for new fields, right?

ADDRB value is the same for all archs (it's just this octal vs hex 
notation I've followed as per the nearby defines within the same file
which makes them look different).

Should I perhaps add to my cleanup list conversion of all those octal ones 
to hex?

> > > diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> > > index 78baba55a8b5..d179b9b57a25 100644
> > > --- a/drivers/char/pcmcia/synclink_cs.c
> > > +++ b/drivers/char/pcmcia/synclink_cs.c
> > > @@ -2287,6 +2287,8 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
> > >  		== RELEVANT_IFLAG(old_termios->c_iflag)))
> > >  	  return;
> > >  
> > > +	tty->termios.c_cflag &= ~ADDRB;
> > 
> > Having to do this for all drivers feels wrong.  It isn't needed for any
> > other flag, right?
> 
> My understanding is that it would be needed for other flags too, it's just 
> that many drivers probably haven't cared enough. Some drivers certainly 
> clear a few flags they don't support while others don't clear any but
> it's also challenging to determine it which flags which driver supports. 
> How bad the impact is per flag varies.
> 
> > That makes me really not like this change as it
> > feels very ackward and
> > yet-another-thing-a-serial-driver-has-to-remember.
> 
> It would be nice to have some mask for supported bits per driver. But it
> will be challenging to add at this point and I'm far from sure I could get 
> them right per driver even if carefully trying to.
> 
> > And as you are wanting to pass this bit to userspace, where is that
> > documented?
> 
> Ah, I probably should add it to driver-api/serial/driver.rst too but ADDRB
> is certainly mentioned alongside with other addressing mode documentation
> I wrote for the later changes in this series.

-- 
 i.
--8323329-479992224-1650981548=:1644--
