Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7CD4D48F5
	for <lists+linux-arch@lfdr.de>; Thu, 10 Mar 2022 15:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbiCJOLw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Mar 2022 09:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbiCJOLZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2022 09:11:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730F2137012;
        Thu, 10 Mar 2022 06:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921423; x=1678457423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vi9TQW28iAGVT+9VTJCeUAtR3L2XgA27dHLozP1I8zM=;
  b=G27wyBmWvNEAVSPYPdfrwrw+qFtSOgN9J0kMPS6K/D+VmhuYIzqR1hbC
   p9bJdKmSO6uC8JCtOBta+bjGdVF+yIluIHkAi1VYR23x6XUKsLfIbWQUx
   8vbvo20B+2ak6a7Uav7VcfPjbUHU7Jc+Bb66v0a6QDuuCXDHyGikMH9UW
   Fczl5/I3uDFul2r3tp176PE3A3q63e/J7OzLrDmd6TuLLSycxbCud80oQ
   9I2bOGvifIglHMBsvwzyESSnITNeg8Uar+8S8KZUbKv6h/BKsix/9ianu
   0lA3j+sZ1VoUOkGAmoQ/FC3BmimF5cRcludSbtHSMJ0k3JwbGK35jpcQH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="279993773"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="279993773"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:10:23 -0800
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="642568750"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:10:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nSJTv-00EjUS-6x;
        Thu, 10 Mar 2022 16:09:31 +0200
Date:   Thu, 10 Mar 2022 16:09:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-api@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
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
Subject: Re: [RFC PATCH 6/7] serial: General support for multipoint addresses
Message-ID: <YioGmu+KC9WT0KoG@smile.fi.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-7-ilpo.jarvinen@linux.intel.com>
 <20220306194001.GD19394@wunner.de>
 <ab43569c-6488-12a6-823-3ef09f2849d@linux.intel.com>
 <20220309190521.GA9832@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309190521.GA9832@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 09, 2022 at 08:05:21PM +0100, Lukas Wunner wrote:
> On Mon, Mar 07, 2022 at 11:48:01AM +0200, Ilpo Järvinen wrote:
> > On Sun, 6 Mar 2022, Lukas Wunner wrote:
> > > On Wed, Mar 02, 2022 at 11:56:05AM +0200, Ilpo Järvinen wrote:
> > > > This change is necessary for supporting devices with RS485
> > > > multipoint addressing [*].
> > > 
> > > If this is only used with RS485, why can't we just store the
> > > addresses in struct serial_rs485 and use the existing TIOCSRS485
> > > and TIOCGRS485 ioctls?  There's 20 bytes of padding left in
> > > struct serial_rs485 which you could use.  No need to add more
> > > user-space ABI.
> > 
> > It could if it is agreed that serial multipoint addressing is just
> > a thing in RS-485 and nowhere else? In that case, there is no point
> > in adding more generic support for it.
> 
> It's just that the above-quoted sentence in the commit message
> specifically mentions RS485.  If you intend to use it with RS232
> as well, that should be made explicit, otherwise one wonders why
> it wasn't integrated into struct serial_rs485.
> 
> I have no idea how common 9th bit addressing mode is with RS232.
> Goggle turns up links saying it's mainly used with RS485, "but also
> RS232".  Since RS232 isn't a bus but a point-to-point link,
> 9th bit addressing doesn't seem to make as much sense.

In my student years I have an exercise to use 9-bit addressing mode on RS232.
Obviously I forgot all of the details, but I remember that that has a practical
application.

-- 
With Best Regards,
Andy Shevchenko


