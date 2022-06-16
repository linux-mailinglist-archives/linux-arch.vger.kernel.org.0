Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C53654D982
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jun 2022 07:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiFPFE0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jun 2022 01:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349153AbiFPFE0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jun 2022 01:04:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B536A5A154;
        Wed, 15 Jun 2022 22:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655355861; x=1686891861;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BLWxLUoPpHR0Mx/K28WEXQm09XW/3QsGGK6+7EjrGps=;
  b=YqicQFhf27pgy/EYaHH4rHemWejTPzjOvhddlF0K2tfvUNmCkR3wyJRW
   I5bxU9kEnKsh5y8U4wMZ/AjYnCgOnBcnGqBCU2bnXpNyDWQAfuWts62DV
   yYSDhaz8mvtJSpYG5UwW8FhexNAhKwg6t2Dhd+tyCVBtCuQZwzVVsgXyt
   A01PeGN6WZv3ZvqWMf9lJpNjobklYg2md8FOGfbAQFAgksDj4MNUsg3Co
   dlyyIAvlHKV66nZ8SqR3BVKs1ccffKqe2APsmszX7t4xGXkdtk0qdw/dd
   8pGJIw1Qfsx/0tW0Nj2joOIOC1l1noz4zGgQPyVies1ZwjcdP4U4dAJNg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277963358"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="277963358"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:04:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="589477564"
Received: from mngueron-mobl1.amr.corp.intel.com ([10.252.60.248])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:04:16 -0700
Date:   Thu, 16 Jun 2022 08:04:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v7 5/6] serial: Support for RS-485 multipoint addresses
In-Reply-To: <Yqno+b/+W2RP8rnh@smile.fi.intel.com>
Message-ID: <ae5c2e50-1a19-7a8f-7dbf-d7ef84128be6@linux.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com> <20220615124829.34516-6-ilpo.jarvinen@linux.intel.com> <Yqno+b/+W2RP8rnh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1441432405-1655355860=:1693"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1441432405-1655355860=:1693
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 15 Jun 2022, Andy Shevchenko wrote:

> On Wed, Jun 15, 2022 at 03:48:28PM +0300, Ilpo Järvinen wrote:
> > Add support for RS-485 multipoint addressing using 9th bit [*]. The
> > addressing mode is configured through .rs485_config().
> > 
> > ADDRB in termios indicates 9th bit addressing mode is enabled. In this
> > mode, 9th bit is used to indicate an address (byte) within the
> > communication line. ADDRB can only be enabled/disabled through
> > .rs485_config() that is also responsible for setting the destination and
> > receiver (filter) addresses.
> > 
> > [*] Technically, RS485 is just an electronic spec and does not itself
> > specify the 9th bit addressing mode but 9th bit seems at least
> > "semi-standard" way to do addressing with RS485.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-api@vger.kernel.org
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> 
> Hmm... In order to reduce commit messages you can move these Cc:s after the
> cutter line ('---').

Ok, although the toolchain I use didn't support preserving --- content
so I had to create hack to preserve them, hopefully nothing backfires due 
to the hack. :-)

> > -	__u32	padding[5];		/* Memory is cheap, new structs
> > -					   are a royal PITA .. */
> > +	__u8	addr_recv;
> > +	__u8	addr_dest;
> > +	__u8	padding[2 + 4 * sizeof(__u32)];		/* Memory is cheap, new structs
> > +							 * are a royal PITA .. */
> 
> I'm not sure it's an equivalent. I would leave u32 members  untouched, so
> something like
> 
> 	__u8	addr_recv;
> 	__u8	addr_dest;
> 	__u8	padding0[2];		/* Memory is cheap, new structs
> 	__u32	padding1[4];		 * are a royal PITA .. */
> 
> And repeating about `pahole` tool which may be useful here to check for ABI
> potential changes.

I cannot take __u32 padding[] away like that, this is an uapi header. Or 
do you mean I should create anonymous union? ...I'm skeptical that can be 
pulled off w/o breaking user-space compile in some circumstances. Anon 
unions were only introduced by C11 but is it ok to rely on C11 in uapi/ 
headers?

Even making padding smaller has some unwanted consequences if somebody is 
clearing just .padding. In retrospect, having padding as a direct member 
doesn't seem a good idea. That padding[5] should have been within an union 
right from the start to make this easily extendable.

Maybe create a copy of that struct under another name which is just equal 
sized, that would give more freedom on member naming. But can I change 
ioctl's param type to another struct (in _IOR/_IOWR) w/o breaking 
something?

-- 
 i.

--8323329-1441432405-1655355860=:1693--
