Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520B85517C0
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 13:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiFTLsl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 07:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242052AbiFTLsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 07:48:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9DE17057;
        Mon, 20 Jun 2022 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655725717; x=1687261717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Fg8wToUgzOMv1MBkkI+JlUdgqqTH6ag3Hnfhb3mXbJs=;
  b=H0dXDi4NhcfC1Ih6+wo1mI+6tHgKG2fNeHFvK8slsiYvMgmVP2VlYiED
   p0ex7U7XyLtaufSc8mT2Lcoe3yJTW8ANH6EJf9TiKAeZvbdrJLc85XR4d
   qcTPdpt5g53Y0R6oJBXFCp9N3KYwJxf7SAV30/MAxazvOaLhOPTsX+JiH
   Lq5+Xx3u3pOGVUoZSLWlimVT1QBV1uM5HrhoQk8ac27PcqvvMyfUqwJxb
   FfWER7Xf+FNnUZg8+QT4FfeSbVPEZSO8TcHgMk+dHi+ZmTCkQr/jfTWT1
   +Hvl5sISBEZ+E8nAjlCGib/TcMvPlzSrmtvpkyQ21Xl/pX88WINg7FASL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280605064"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280605064"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:48:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="833079546"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:48:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3FtO-000kLC-P2;
        Mon, 20 Jun 2022 14:48:30 +0300
Date:   Mon, 20 Jun 2022 14:48:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v8 5/6] serial: Support for RS-485 multipoint addresses
Message-ID: <YrBejkxeZfpQ35iG@smile.fi.intel.com>
References: <20220620064030.7938-1-ilpo.jarvinen@linux.intel.com>
 <20220620064030.7938-6-ilpo.jarvinen@linux.intel.com>
 <YrBS03ymAWVajy7e@smile.fi.intel.com>
 <a9b8ec3a-4f40-c0f5-e1a-bb577d5937ff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9b8ec3a-4f40-c0f5-e1a-bb577d5937ff@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 20, 2022 at 02:26:17PM +0300, Ilpo Järvinen wrote:
> On Mon, 20 Jun 2022, Andy Shevchenko wrote:
> > On Mon, Jun 20, 2022 at 09:40:29AM +0300, Ilpo Järvinen wrote:

...

> > > The changes to serial_rs485 struct were test built with a few traps to
> > > detect mislayouting on archs lkp/0day builts for (all went fine):
> > >   BUILD_BUG_ON(((&rs485.delay_rts_after_send) + 1) != &rs485.padding[0]);
> > >   BUILD_BUG_ON(&rs485.padding[1] != &rs485.padding1[0]);
> > >   BUILD_BUG_ON(sizeof(rs485) != ((u8 *)(&rs485.padding[4]) -
> > > 				 ((u8 *)&rs485.flags) + sizeof(__u32)));
> > 
> > You may add static_asserts() for the above mentioned cases.
> 
> I'll add into the end of serial_core.h but in a cleaned up form
> using offsetof(). Those above look rather ugly :-).

Agree!

...

> > > -	__u32	padding[5];		/* Memory is cheap, new structs
> > > -					   are a royal PITA .. */
> > > +	union {
> > > +		/* v1 */
> > > +		__u32	padding[5];		/* Memory is cheap, new structs are a pain */
> > > +
> > > +		/* v2 (adds addressing mode fields) */
> > 
> > How user space will inform a kernel that it's trying v2?
> >
> > Usually when we have a union, it should be accompanied with the enum or version
> > or something to tell which part of it is in use. I can imagine that in this case
> > it's implied by the IOCTL parameters that never should be used on a garbage.
> > 
> > Either add a commit message / UAPI comment or add a version field or ...?
> > 
> > > +		struct {
> > > +			__u8	addr_recv;
> > > +			__u8	addr_dest;
> 
> The flags in .flags indicate when these two new fields are in use. Do you 
> think I need something beyond that. Maybe I should remove those comments 
> so they don't mislead you to think it's a "version" for real?

Yes, either drop this versioning, or replace with a comment on top of a union
like:

	/* The fields are defined by flags */

-- 
With Best Regards,
Andy Shevchenko


