Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E05BE44C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 13:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiITLUS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 07:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiITLUR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 07:20:17 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776FB32D98;
        Tue, 20 Sep 2022 04:20:15 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 84EF2280F3D8F;
        Tue, 20 Sep 2022 13:20:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7AB6B27C89; Tue, 20 Sep 2022 13:20:11 +0200 (CEST)
Date:   Tue, 20 Sep 2022 13:20:11 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v9 5/6] serial: Support for RS-485 multipoint addresses
Message-ID: <20220920112011.GA7187@wunner.de>
References: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
 <20220624204210.11112-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624204210.11112-6-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 24, 2022 at 11:42:09PM +0300, Ilpo Järvinen wrote:
> ADDRB in termios indicates 9th bit addressing mode is enabled. In this
> mode, 9th bit is used to indicate an address (byte) within the
> communication line. ADDRB can only be enabled/disabled through
> ->rs485_config() that is also responsible for setting the destination and
> receiver (filter) addresses.
[...]
> --- a/include/uapi/asm-generic/termbits-common.h
> +++ b/include/uapi/asm-generic/termbits-common.h
> @@ -46,6 +46,7 @@ typedef unsigned int	speed_t;
>  #define EXTA		B19200
>  #define EXTB		B38400
>  
> +#define ADDRB		0x20000000	/* address bit */
>  #define CMSPAR		0x40000000	/* mark or space (stick) parity */
>  #define CRTSCTS		0x80000000	/* flow control */
>

You may want to consider submitting a patch to the Linux man-pages
project to document the newly introduced bit:

https://www.kernel.org/doc/man-pages/patches.html
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man3/termios.3

Thanks,

Lukas
