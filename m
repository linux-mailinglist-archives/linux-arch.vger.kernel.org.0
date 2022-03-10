Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344334D46F2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Mar 2022 13:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiCJMae (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Mar 2022 07:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiCJMae (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2022 07:30:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7266A818A5;
        Thu, 10 Mar 2022 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646915373; x=1678451373;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KpU7qHsFQttScVYV4Sy+C7cKf/dHAGOyV91juLQL6gk=;
  b=NgFY8eRdD81ohSejE1d5DO20LjYbv3RY7ET76nPkYeMlSHg+aTstckek
   S8/ctGS3G1ijTVnjn2V2MsmQBDECfd/WZvpxEVm2IgscOkJs+vKOoW2R1
   Tg5/RbkIrbMIVpdK/CSoAwz4XaaVqm/BSVs7q72b21hpCQNN2lU//vuSh
   KrvPemzpbYV7jvLCigfVO/dNhbya2kQUeWEN3/Dclbug8ZNYwZd4FyuZW
   fQTUUJSUa5eBvBFgNovM0f5gwecjeXRZKDkfFUsU6KY5xe+PUvF7W7awO
   v+fMUYdLsZ5fp5+4hzDD/MyQsKaGsAhe6tFIDP6zC3mCuyqEtSCIUS5B/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318459313"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="318459313"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 04:29:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554624288"
Received: from mborg-mobl.ger.corp.intel.com ([10.252.33.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 04:29:23 -0800
Date:   Thu, 10 Mar 2022 14:29:21 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
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
Subject: Re: [RFC PATCH 6/7] serial: General support for multipoint
 addresses
In-Reply-To: <20220309190521.GA9832@wunner.de>
Message-ID: <6feb796a-ea58-9a6-f2f9-a11ca72acfd@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com> <20220302095606.14818-7-ilpo.jarvinen@linux.intel.com> <20220306194001.GD19394@wunner.de> <ab43569c-6488-12a6-823-3ef09f2849d@linux.intel.com> <20220309190521.GA9832@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-24784813-1646915371=:1973"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-24784813-1646915371=:1973
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 9 Mar 2022, Lukas Wunner wrote:

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
> specifically mentions RS485.

That sentence is just to justify why addressing mode is needed,
not to take a stance on whether it is only used with RS485 or not.

> If you intend to use it with RS232
> as well, that should be made explicit, otherwise one wonders why
> it wasn't integrated into struct serial_rs485.
> 
> I have no idea how common 9th bit addressing mode is with RS232.
> Goggle turns up links saying it's mainly used with RS485, "but also
> RS232".  Since RS232 isn't a bus but a point-to-point link,
> 9th bit addressing doesn't seem to make as much sense.

While I don't know any better, I can image though that with an 
RS232-to-RS485 converter, it could make some sense.

If I put them back to serial_rs485 / rs485 config, it's basically just 
where I initially started from with this patchset (offlist).


-- 
 i.

--8323329-24784813-1646915371=:1973--
