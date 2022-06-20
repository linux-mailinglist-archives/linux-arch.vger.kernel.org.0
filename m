Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA184551764
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiFTL03 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbiFTL0Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 07:26:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27AA15FCD;
        Mon, 20 Jun 2022 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655724383; x=1687260383;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=xNzTBMjUROvDXYrLANwro714X0ZywO3dU4OSu7/ZwRc=;
  b=GCxd+ySm0g95LF40JEHNniDHdgtZMtRjImu80m2lAYxL6mooUgsWJNYR
   jgaAF1B9H2PUcjRLvtmekAAqOilwBNFf81987Dw64PXVuQBlTEour5pI4
   n1pHElmj3qHALHxas5bQPcKIemgDlm3eqcGllbq4gvvljJeVYQ/NxPHQS
   2v51URgHrIXc7dTqs8lcUTGhVwc5zvUguyKHgzxkQTqZgeW270MnD3oGd
   WzKy1HI9Cvwp9wqjEbLiM+ASuuySTPoOk3z92F8jnetSjPzeLF9RIum5h
   wlpkUvEeBvZazVQmCLIRqO75679LBKz9xSx80Xex1fSIPnAUJ8CObRtaz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305306743"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305306743"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:26:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643073015"
Received: from lspinell-mobl1.ger.corp.intel.com ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:26:20 -0700
Date:   Mon, 20 Jun 2022 14:26:17 +0300 (EEST)
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
Subject: Re: [PATCH v8 5/6] serial: Support for RS-485 multipoint addresses
In-Reply-To: <YrBS03ymAWVajy7e@smile.fi.intel.com>
Message-ID: <a9b8ec3a-4f40-c0f5-e1a-bb577d5937ff@linux.intel.com>
References: <20220620064030.7938-1-ilpo.jarvinen@linux.intel.com> <20220620064030.7938-6-ilpo.jarvinen@linux.intel.com> <YrBS03ymAWVajy7e@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1339892010-1655723043=:2433"
Content-ID: <292be3e1-171d-3057-de26-39e8e190653a@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1339892010-1655723043=:2433
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <c765df60-e565-8afa-7f3-18ad1c7fe745@linux.intel.com>

On Mon, 20 Jun 2022, Andy Shevchenko wrote:

> On Mon, Jun 20, 2022 at 09:40:29AM +0300, Ilpo Järvinen wrote:
> > Add support for RS-485 multipoint addressing using 9th bit [*]. The
> > addressing mode is configured through ->rs485_config().
> > 
> > ADDRB in termios indicates 9th bit addressing mode is enabled. In this
> > mode, 9th bit is used to indicate an address (byte) within the
> > communication line. ADDRB can only be enabled/disabled through
> > ->rs485_config() that is also responsible for setting the destination and
> > receiver (filter) addresses.
> 
> > The changes to serial_rs485 struct were test built with a few traps to
> > detect mislayouting on archs lkp/0day builts for (all went fine):
> >   BUILD_BUG_ON(((&rs485.delay_rts_after_send) + 1) != &rs485.padding[0]);
> >   BUILD_BUG_ON(&rs485.padding[1] != &rs485.padding1[0]);
> >   BUILD_BUG_ON(sizeof(rs485) != ((u8 *)(&rs485.padding[4]) -
> > 				 ((u8 *)&rs485.flags) + sizeof(__u32)));
> 
> You may add static_asserts() for the above mentioned cases.

I'll add into the end of serial_core.h but in a cleaned up form
using offsetof(). Those above look rather ugly :-).

> > [*] Technically, RS485 is just an electronic spec and does not itself
> > specify the 9th bit addressing mode but 9th bit seems at least
> > "semi-standard" way to do addressing with RS485.
> 
> ...
> 
> > -	__u32	padding[5];		/* Memory is cheap, new structs
> > -					   are a royal PITA .. */
> > +	union {
> > +		/* v1 */
> > +		__u32	padding[5];		/* Memory is cheap, new structs are a pain */
> > +
> > +		/* v2 (adds addressing mode fields) */
> 
> How user space will inform a kernel that it's trying v2?
>
> Usually when we have a union, it should be accompanied with the enum or version
> or something to tell which part of it is in use. I can imagine that in this case
> it's implied by the IOCTL parameters that never should be used on a garbage.
> 
> Either add a commit message / UAPI comment or add a version field or ...?
> 
> > +		struct {
> > +			__u8	addr_recv;
> > +			__u8	addr_dest;

The flags in .flags indicate when these two new fields are in use. Do you 
think I need something beyond that. Maybe I should remove those comments 
so they don't mislead you to think it's a "version" for real?


-- 
 i.
--8323329-1339892010-1655723043=:2433--
