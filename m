Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A264CF8DB
	for <lists+linux-arch@lfdr.de>; Mon,  7 Mar 2022 11:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiCGKCp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Mar 2022 05:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbiCGKBC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2022 05:01:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58372205FE;
        Mon,  7 Mar 2022 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646646492; x=1678182492;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=zC3EygN9B67AQNPvzALqT8NwONoTEFy8bHC2L1G4njc=;
  b=JstJxVGBbUqE7vEW33wQJkXrLylT4VHJHp2qZByUKOt5Ea7DtujQMZh8
   eD4/p7aAvS7znQV2M4cLJCV3289l50yZljmgVJegACGGpfsnYkNK4iwEv
   6Rq23GvPRKd9xdGv+/0yFzkXAu32KlTEIdIVlLnEKFwtmE1a8PlsK9Gv9
   S5Vy0eNpJ1dwLCb9fVBk5sTsC5VDt96c4+53HwmmVr/stwhCVPE8BChgM
   H0zS0ozy1z+ffacOSmiAbdAftg5+tnLSBZJ6qerHsv/n+0tvGrKgJ70Fr
   gtaq25O0hr0Fd+5X5xvgw3//4ynct9C8buIMAbJVhuf23vJHpzDFbVSuv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="340782145"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="340782145"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:48:11 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="553088602"
Received: from rabl-mobl2.ger.corp.intel.com ([10.252.54.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:48:03 -0800
Date:   Mon, 7 Mar 2022 11:48:01 +0200 (EET)
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
In-Reply-To: <20220306194001.GD19394@wunner.de>
Message-ID: <ab43569c-6488-12a6-823-3ef09f2849d@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com> <20220302095606.14818-7-ilpo.jarvinen@linux.intel.com> <20220306194001.GD19394@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-971395012-1646646016=:1677"
Content-ID: <cbee2ae-83f0-872e-34dd-cb9866dd3f6e@linux.intel.com>
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

--8323329-971395012-1646646016=:1677
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <07d5f9f-7fe3-3c54-6566-1873a5191970@linux.intel.com>

On Sun, 6 Mar 2022, Lukas Wunner wrote:

> On Wed, Mar 02, 2022 at 11:56:05AM +0200, Ilpo Järvinen wrote:
> 
> > This change is necessary for supporting devices with RS485
> > multipoint addressing [*].
> 
> If this is only used with RS485, why can't we just store the
> addresses in struct serial_rs485 and use the existing TIOCSRS485
> and TIOCGRS485 ioctls?  There's 20 bytes of padding left in
> struct serial_rs485 which you could use.  No need to add more
> user-space ABI.

It could if it is agreed that serial multipoint addressing is just
a thing in RS-485 and nowhere else? In that case, there is no point
in adding more generic support for it.

> > [*] Technically, RS485 is just an electronic spec and does not
> > itself specify the 9th bit addressing mode but 9th bit seems
> > at least "semi-standard" way to do addressing with RS485.
> 
> Is 9th bit addressing actually used by an Intel customer or was
> it implemented just for feature completeness? I think this mode
> isn't used often (I've never seen a use case myself), primarily
> because it requires disabling parity.

On what basis? ...The datasheet I'm looking at has a timing diagram 
with both D8 (9th bit) and parity so I think your information must be
incorrect. I don't have direct contacts with customers but I'm told
it's important for other org's customers.


-- 
 i.
--8323329-971395012-1646646016=:1677--
