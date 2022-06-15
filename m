Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7898854CAF1
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245596AbiFOOOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 10:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346085AbiFOONr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 10:13:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65128E34;
        Wed, 15 Jun 2022 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655302426; x=1686838426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B8TiHIv5Q07n74NXSDQu97TnsKK0fjGHsjxfyj1wpiY=;
  b=j7s2LQCiH9CKxMSDH7iK001hej/is0TvhiFUsIDii4844ClqkgD1K5Sq
   T4JY0+935qE90NBYUmLzfqYjlIO5JNE98WaI4s3lDMn0hAJwcTaQFiEc5
   8fBNXHG13OPkxqDx8PpnQ1H+se38knaOYn0TmrqnktyzhsFZVxDBBvYan
   KL+KWnQnVkPeXSyGJzSWiKmwilaIzvbYv2Sae4+o1sfZo4S8c6j4ozWsc
   CcwcPBnB8XmwG50cUr7zMApYucDAXYomLHS5WSAfENO48NOi5EOqbEOYC
   bkus4cvuDpCxnar1o/PHXpgl+LGtzl5aNgx8w1THZAr0ae9KLYD5RAxpO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="267662562"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="267662562"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:13:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="536053581"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:13:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o1Tlh-000dUY-Vg;
        Wed, 15 Jun 2022 17:13:13 +0300
Date:   Wed, 15 Jun 2022 17:13:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v7 5/6] serial: Support for RS-485 multipoint addresses
Message-ID: <Yqno+b/+W2RP8rnh@smile.fi.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
 <20220615124829.34516-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615124829.34516-6-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 15, 2022 at 03:48:28PM +0300, Ilpo Järvinen wrote:
> Add support for RS-485 multipoint addressing using 9th bit [*]. The
> addressing mode is configured through .rs485_config().
> 
> ADDRB in termios indicates 9th bit addressing mode is enabled. In this
> mode, 9th bit is used to indicate an address (byte) within the
> communication line. ADDRB can only be enabled/disabled through
> .rs485_config() that is also responsible for setting the destination and
> receiver (filter) addresses.
> 
> [*] Technically, RS485 is just an electronic spec and does not itself
> specify the 9th bit addressing mode but 9th bit seems at least
> "semi-standard" way to do addressing with RS485.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-api@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arch@vger.kernel.org

Hmm... In order to reduce commit messages you can move these Cc:s after the
cutter line ('---').

...

> -	__u32	padding[5];		/* Memory is cheap, new structs
> -					   are a royal PITA .. */
> +	__u8	addr_recv;
> +	__u8	addr_dest;
> +	__u8	padding[2 + 4 * sizeof(__u32)];		/* Memory is cheap, new structs
> +							 * are a royal PITA .. */

I'm not sure it's an equivalent. I would leave u32 members  untouched, so
something like

	__u8	addr_recv;
	__u8	addr_dest;
	__u8	padding0[2];		/* Memory is cheap, new structs
	__u32	padding1[4];		 * are a royal PITA .. */

And repeating about `pahole` tool which may be useful here to check for ABI
potential changes.

-- 
With Best Regards,
Andy Shevchenko


