Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70F54DC32
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jun 2022 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358867AbiFPHyF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jun 2022 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359398AbiFPHyE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jun 2022 03:54:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069B558E44;
        Thu, 16 Jun 2022 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655366043; x=1686902043;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=eVrD4xANVA1qmWE7aHLjyWwagcA1Yxkv/BMYL/OgcAk=;
  b=Q9iUx2tDrqqwKmipEwswTd7RSnNb4zFKqL/JVZUSoQLsLfz154okByel
   vZuY26G8lyUO9OzlHv3kf499jwNfD4GgCbRoq9fIl1QEd7+TeunMdBIIt
   P8ft/XcyrT45sneZGdoeirVUKrdpLR05LroyOAZqdFSogZ971iaYm3chE
   pQI+6dIWMQDuYxhiQaZri58tWRfGlSo1GjHaBsC+crfJLqsFwPN3sCwpP
   xNTWc04euJ17ZdcXd8atts2/rdr6LEieen0Cb0449KoCe6I7jaqqcap+e
   D1ObzZNNRddq4jAQHky02adEiIENqDTll6sJ/HXSaOHQydlzgPdTC70dC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="343150292"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="343150292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 00:54:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="641423577"
Received: from mngueron-mobl1.amr.corp.intel.com ([10.252.60.248])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 00:53:58 -0700
Date:   Thu, 16 Jun 2022 10:53:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v7 5/6] serial: Support for RS-485 multipoint addresses
In-Reply-To: <c0996d75-070e-21e6-eb51-a10a358dbb46@kernel.org>
Message-ID: <accefd7-6fbf-b1f1-f467-5eaab0dac051@linux.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com> <20220615124829.34516-6-ilpo.jarvinen@linux.intel.com> <Yqno+b/+W2RP8rnh@smile.fi.intel.com> <ae5c2e50-1a19-7a8f-7dbf-d7ef84128be6@linux.intel.com>
 <c0996d75-070e-21e6-eb51-a10a358dbb46@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-963945969-1655365386=:1693"
Content-ID: <7d41d27a-51c6-841d-b65b-8d75c7e6a73@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-963945969-1655365386=:1693
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <dc1423b6-d575-966b-f087-4525e26fcc5f@linux.intel.com>

On Thu, 16 Jun 2022, Jiri Slaby wrote:

> On 16. 06. 22, 7:04, Ilpo Järvinen wrote:
> > On Wed, 15 Jun 2022, Andy Shevchenko wrote:
> > 
> > > On Wed, Jun 15, 2022 at 03:48:28PM +0300, Ilpo Järvinen wrote:
> > > > Add support for RS-485 multipoint addressing using 9th bit [*]. The
> > > > addressing mode is configured through .rs485_config().
> > > > 
> > > > ADDRB in termios indicates 9th bit addressing mode is enabled. In this
> > > > mode, 9th bit is used to indicate an address (byte) within the
> > > > communication line. ADDRB can only be enabled/disabled through
> > > > .rs485_config() that is also responsible for setting the destination and
> > > > receiver (filter) addresses.
> > > > 
> > > > [*] Technically, RS485 is just an electronic spec and does not itself
> > > > specify the 9th bit addressing mode but 9th bit seems at least
> > > > "semi-standard" way to do addressing with RS485.
> > > > 
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > > Cc: linux-api@vger.kernel.org
> > > > Cc: linux-doc@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: linux-arch@vger.kernel.org
> > > 
> > > Hmm... In order to reduce commit messages you can move these Cc:s after
> > > the
> > > cutter line ('---').
> > 
> > Ok, although the toolchain I use didn't support preserving --- content
> > so I had to create hack to preserve them, hopefully nothing backfires due
> > to the hack. :-)
> > 
> > > > -	__u32	padding[5];		/* Memory is cheap, new structs
> > > > -					   are a royal PITA .. */
> > > > +	__u8	addr_recv;
> > > > +	__u8	addr_dest;
> > > > +	__u8	padding[2 + 4 * sizeof(__u32)];		/* Memory is cheap,
> > > > new structs
> > > > +							 * are a royal PITA ..
> > > > */
> > > 
> > > I'm not sure it's an equivalent. I would leave u32 members  untouched, so
> > > something like
> > > 
> > > 	__u8	addr_recv;
> > > 	__u8	addr_dest;
> > > 	__u8	padding0[2];		/* Memory is cheap, new structs
> > > 	__u32	padding1[4];		 * are a royal PITA .. */
> > > 
> > > And repeating about `pahole` tool which may be useful here to check for
> > > ABI
> > > potential changes.
> > 
> > I cannot take __u32 padding[] away like that, this is an uapi header.
> 
> Yeah, but it's padding after all. I would personally break it for example as
> Andy suggests (if pahole shows no differences in size on both 32/64 bit) and
> wait if something breaks. To be honest, I'd not expect anyone to touch it. And
> if someone does, we would fix it somehow and they should too...

I realized there are plenty of anonymous unions already in include/uapi/ 
so I think I can keep padding[5] too:

        union {
                /* v1 */
                __u32   padding[5];             /* Memory is cheap, new structs are a pain */

                /* v2 (adds addressing mode fields) */
                struct {
                        __u8    addr_recv;
                        __u8    addr_dest;
                        __u8    padding0[2];
                        __u32   padding1[4];
                };
        };

I'll just skip manual pahole step and add a few BUILD_BUG_ON()s and use 
our build bot to do a quick check over all archs it builds for, that gives 
much better confidence on it being ok:

	BUILD_BUG_ON(((&rs485.delay_rts_after_send) + 1) != &rs485.padding[0]);
	BUILD_BUG_ON(&rs485.padding[1] != &rs485.padding1[0]);
	BUILD_BUG_ON(sizeof(rs485) != ((u8 *)(&rs485.padding[4]) - ((u8 *)&rs485.flags) + sizeof(__u32)));


-- 
 i.
--8323329-963945969-1655365386=:1693--
