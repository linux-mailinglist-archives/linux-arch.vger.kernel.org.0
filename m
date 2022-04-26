Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9EE50FFD0
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351321AbiDZOCG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 10:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351319AbiDZOCB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 10:02:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FCE19069A;
        Tue, 26 Apr 2022 06:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6958B82004;
        Tue, 26 Apr 2022 13:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF43AC385AA;
        Tue, 26 Apr 2022 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650981527;
        bh=Q2CbGzlO12o2sbSJCVILKFqSAKwSGP36Qpvd86jEE4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPlxeusTmjq/0/+EHFfnDlmdGs+COvFDZFCgTv+38FHJQLu/3K1jRTOXmXkqLXP/J
         qA5n0a+3bskZdBKVwMeeYcIF3N60iifRKD7Sa6eyVSIhkcBzHwhLVOLaneSeWcqnhC
         KjMJhwCaSLPfTwzfbLs4yha6/Z7mC05ooTVOw3+o=
Date:   Tue, 26 Apr 2022 15:58:44 +0200
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 06/10] serial: General support for multipoint addresses
Message-ID: <Ymf6lJdj+nR74Tak@kroah.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
 <20220426122448.38997-7-ilpo.jarvinen@linux.intel.com>
 <YmfsDng2Z04PT3GS@kroah.com>
 <e67014bd-3c32-e7d-2982-a0edb741f3c0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e67014bd-3c32-e7d-2982-a0edb741f3c0@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 04:36:49PM +0300, Ilpo Järvinen wrote:
> On Tue, 26 Apr 2022, Greg KH wrote:
> 
> > On Tue, Apr 26, 2022 at 03:24:44PM +0300, Ilpo Järvinen wrote:
> > > Add generic support for serial multipoint addressing. Two new ioctls
> > > are added. TIOCSADDR is used to indicate the destination/receive
> > > address. TIOCGADDR returns the current address in use. The driver
> > > should implement set_addr and get_addr to support addressing mode.
> > > 
> > > Adjust ADDRB clearing to happen only if driver does not provide
> > > set_addr (=the driver doesn't support address mode).
> > > 
> > > This change is necessary for supporting devices with RS485 multipoint
> > > addressing [*]. A following patch in the patch series adds support for
> > > Synopsys Designware UART capable for 9th bit addressing mode. In this
> > > mode, 9th bit is used to indicate an address (byte) within the
> > > communication line. The 9th bit addressing mode is selected using ADDRB
> > > introduced by the previous patch.
> > > 
> > > Transmit addresses / receiver filter are specified by setting the flags
> > > SER_ADDR_DEST and/or SER_ADDR_RECV. When the user supplies the transmit
> > > address, in the 9bit addressing mode it is sent out immediately with
> > > the 9th bit set to 1. After that, the subsequent normal data bytes are
> > > sent with 9th bit as 0 and they are intended to the device with the
> > > given address. It is up to receiver to enforce the filter using
> > > SER_ADDR_RECV. When userspace has supplied the receive address, the
> > > driver is expected to handle the matching of the address and only data
> > > with that address is forwarded to the user. Both SER_ADDR_DEST and
> > > SER_ADDR_RECV can be given at the same time in a single call if the
> > > addresses are the same.
> > > 
> > > The user can clear the receive filter with SER_ADDR_RECV_CLEAR.
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
> > > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > Cc: Rich Felker <dalias@libc.org>
> > > Cc: linux-sh@vger.kernel.org
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: sparclinux@vger.kernel.org
> > > Cc: Chris Zankel <chris@zankel.net>
> > > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > > Cc: linux-xtensa@linux-xtensa.org
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: linux-arch@vger.kernel.org
> > > Cc: linux-doc@vger.kernel.org
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> 
> > > diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> > > index fa6b16e5fdd8..8cb785ea7087 100644
> > > --- a/include/uapi/linux/serial.h
> > > +++ b/include/uapi/linux/serial.h
> > > @@ -149,4 +149,12 @@ struct serial_iso7816 {
> > >  	__u32	reserved[5];
> > >  };
> > >  
> > > +struct serial_addr {
> > > +	__u32	flags;
> > > +#define SER_ADDR_RECV			(1 << 0)
> > > +#define SER_ADDR_RECV_CLEAR		(1 << 1)
> > > +#define SER_ADDR_DEST			(1 << 2)
> > 
> > You never check for invalid flags being sent to the kernel, which means
> > this api can never change in the future to add new flags :(
> 
> Ok, so you mean the general level should to check
> if (...->flags & ~(SER_ADDR_FLAGS_ALL))
> 	return -EINVAL;
> ?

For any new kernel api you always have to ensure that no "extra" flags
or bits are set and reject it otherwise you can never add any more bits
or flags in the future.  This should be in the Documentation/ directory
for how to add new ioctls somewhere.

> There's some code in the driver that detects invalid flag combinations 
> (in 10/10) but I guess it doesn't satisfies what you're after. It is 
> similar to how serial_rs485 flags is handled, that is, clearing flags it 
> didn't handle (when it can) and returning -EINVAL for impossible 
> combinations such as getting both RECV and DEST addr at the same time.
> I don't know if serial_rs485 flags is a good example at all, it certainly 
> doesn't check whether bits are set where there's no flag defined.
> 
> > And what about struct serial_rs485?  Shouldn't that be used here
> > instead?  Why do we need a new ioctl and structure?
> 
> It is possible (Lukas already mentioned that option too). It just means
> this will be available only on RS485 which could well be enough but Andy 
> mentioned he has in the past come across addressing mode also with some 
> RS232 thing (he didn't remember details anymore and it could be 
> insignificant for the real world of today).

This is rs485 so let's keep it attached to that.  Lots of people do
their own custom addressing schemes on top of 232 but that's up to them
to support in userspace or as a line discipline.

thanks,

greg k-h
