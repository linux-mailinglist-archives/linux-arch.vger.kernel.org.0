Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1B4D397B
	for <lists+linux-arch@lfdr.de>; Wed,  9 Mar 2022 20:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiCITGX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Mar 2022 14:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiCITGX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2022 14:06:23 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC16F482;
        Wed,  9 Mar 2022 11:05:23 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4A151100BA624;
        Wed,  9 Mar 2022 20:05:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 278F54C5886; Wed,  9 Mar 2022 20:05:21 +0100 (CET)
Date:   Wed, 9 Mar 2022 20:05:21 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-api@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
Subject: Re: [RFC PATCH 6/7] serial: General support for multipoint addresses
Message-ID: <20220309190521.GA9832@wunner.de>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-7-ilpo.jarvinen@linux.intel.com>
 <20220306194001.GD19394@wunner.de>
 <ab43569c-6488-12a6-823-3ef09f2849d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab43569c-6488-12a6-823-3ef09f2849d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 07, 2022 at 11:48:01AM +0200, Ilpo Järvinen wrote:
> On Sun, 6 Mar 2022, Lukas Wunner wrote:
> > On Wed, Mar 02, 2022 at 11:56:05AM +0200, Ilpo Järvinen wrote:
> > > This change is necessary for supporting devices with RS485
> > > multipoint addressing [*].
> > 
> > If this is only used with RS485, why can't we just store the
> > addresses in struct serial_rs485 and use the existing TIOCSRS485
> > and TIOCGRS485 ioctls?  There's 20 bytes of padding left in
> > struct serial_rs485 which you could use.  No need to add more
> > user-space ABI.
> 
> It could if it is agreed that serial multipoint addressing is just
> a thing in RS-485 and nowhere else? In that case, there is no point
> in adding more generic support for it.

It's just that the above-quoted sentence in the commit message
specifically mentions RS485.  If you intend to use it with RS232
as well, that should be made explicit, otherwise one wonders why
it wasn't integrated into struct serial_rs485.

I have no idea how common 9th bit addressing mode is with RS232.
Goggle turns up links saying it's mainly used with RS485, "but also
RS232".  Since RS232 isn't a bus but a point-to-point link,
9th bit addressing doesn't seem to make as much sense.


> > > [*] Technically, RS485 is just an electronic spec and does not
> > > itself specify the 9th bit addressing mode but 9th bit seems
> > > at least "semi-standard" way to do addressing with RS485.
> > 
> > Is 9th bit addressing actually used by an Intel customer or was
> > it implemented just for feature completeness? I think this mode
> > isn't used often (I've never seen a use case myself), primarily
> > because it requires disabling parity.
> 
> On what basis? ...The datasheet I'm looking at has a timing diagram 
> with both D8 (9th bit) and parity so I think your information must be
> incorrect.

E.g. the discussion here says that 9th bit addressing requires that
parity is disabled or the character size is reduced to 7-bit:

https://www.microchip.com/forums/m299904.aspx

I guess that applies only to some UARTs, the Synopsys databook doesn't
mention any such constraints.

Thanks,

Lukas
