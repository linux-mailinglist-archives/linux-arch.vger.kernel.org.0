Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14B551670
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbiFTK6v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbiFTK6f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 06:58:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6F5DD7;
        Mon, 20 Jun 2022 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655722713; x=1687258713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vpL39t3xJejS0Bc6qv3jVN1E/qqa66dF3rn6N+6Zg0U=;
  b=VCOAYqRVZ09Ip/tllDIfGdc+GRGKH2LkpVnWe3jeBhJxzBMQzq1uY4Ks
   K0hEUtnp/uOmlVzjjLJd0c436GNup5bSaXKsh5vC8JC+QODGKwUO42Jwx
   Pktel0Cez4aAFELcm//EYbDliCqUfrAhtiDv2tLSsZuN/SJ52eD6NP9dh
   sok5bK1iRk98cxECEWYAS3uEjPYVlWi5ebxp6jcCzYmZX4jT2xmKzF8g0
   lGlWmaEeWY2h+Q2Atc+8U1bnOmmhK3W89aXQducCnPIcJDntdVBfobXKw
   9Gl5XM3blgFXvAMlwv3CF/hzMyEXTePS9wpB7LveFeR0a5AL2d1puo1io
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260297379"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260297379"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:58:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="689402203"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:58:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3F6x-000kHu-Dx;
        Mon, 20 Jun 2022 13:58:27 +0300
Date:   Mon, 20 Jun 2022 13:58:27 +0300
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
Subject: Re: [PATCH v8 5/6] serial: Support for RS-485 multipoint addresses
Message-ID: <YrBS03ymAWVajy7e@smile.fi.intel.com>
References: <20220620064030.7938-1-ilpo.jarvinen@linux.intel.com>
 <20220620064030.7938-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620064030.7938-6-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 20, 2022 at 09:40:29AM +0300, Ilpo Järvinen wrote:
> Add support for RS-485 multipoint addressing using 9th bit [*]. The
> addressing mode is configured through ->rs485_config().
> 
> ADDRB in termios indicates 9th bit addressing mode is enabled. In this
> mode, 9th bit is used to indicate an address (byte) within the
> communication line. ADDRB can only be enabled/disabled through
> ->rs485_config() that is also responsible for setting the destination and
> receiver (filter) addresses.

> The changes to serial_rs485 struct were test built with a few traps to
> detect mislayouting on archs lkp/0day builts for (all went fine):
>   BUILD_BUG_ON(((&rs485.delay_rts_after_send) + 1) != &rs485.padding[0]);
>   BUILD_BUG_ON(&rs485.padding[1] != &rs485.padding1[0]);
>   BUILD_BUG_ON(sizeof(rs485) != ((u8 *)(&rs485.padding[4]) -
> 				 ((u8 *)&rs485.flags) + sizeof(__u32)));

You may add static_asserts() for the above mentioned cases.

> [*] Technically, RS485 is just an electronic spec and does not itself
> specify the 9th bit addressing mode but 9th bit seems at least
> "semi-standard" way to do addressing with RS485.

...

> -	__u32	padding[5];		/* Memory is cheap, new structs
> -					   are a royal PITA .. */
> +	union {
> +		/* v1 */
> +		__u32	padding[5];		/* Memory is cheap, new structs are a pain */
> +
> +		/* v2 (adds addressing mode fields) */

How user space will inform a kernel that it's trying v2?

Usually when we have a union, it should be accompanied with the enum or version
or something to tell which part of it is in use. I can imagine that in this case
it's implied by the IOCTL parameters that never should be used on a garbage.

Either add a commit message / UAPI comment or add a version field or ...?

> +		struct {
> +			__u8	addr_recv;
> +			__u8	addr_dest;
> +			__u8	padding0[2];
> +			__u32	padding1[4];
> +		};
> +	};

-- 
With Best Regards,
Andy Shevchenko


