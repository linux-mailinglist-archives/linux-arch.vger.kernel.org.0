Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1554A20B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiFMWWq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 18:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiFMWWo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 18:22:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87F96342;
        Mon, 13 Jun 2022 15:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655158932;
        bh=/K38MCAmHWxqyV1M9IU8mCPprustLYV8uXAeCmwAeEQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bqJRkVrfmrxiWp4dHM+lZQYZYWy4oUodCG5GQOBxWKeiD9v2xehtL/oXUA92CTC5u
         UEwDXKvqlCKD6fcpx2lBqW2I+mUBDxkmW6IxjRVZgunZZMgc2QHLBjjMDs8hJns0gd
         UsD2FP3cG2SEpgE3Fp8kSsDtrtvAMLfSAdKXk4XE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.220]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1nVvLI0TwG-00drMA; Tue, 14
 Jun 2022 00:22:12 +0200
Subject: Re: [PATCH v6 5/6] serial: Support for RS-485 multipoint addresses
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas.wunner@intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-api@vger.kernel.org
References: <20220613075227.10394-1-ilpo.jarvinen@linux.intel.com>
 <20220613075227.10394-6-ilpo.jarvinen@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <cd72151d-b087-0fdf-2775-6068999f7d05@gmx.de>
Date:   Tue, 14 Jun 2022 00:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220613075227.10394-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qnVCycgo6Woco+A3lDsqIOO1oP7H1X4CPI8yz97JmGIl88WWKr0
 w9veZfbN+pE+xEqp+BlWuETwaVnzMVZDlca/2HiEABVfIsJC4cTm8uNC+2s445Ze6HGOFXH
 V78VCdX4v523Sy487dlPg1XVplazwhZ/fR0yxSu0CQOCaYnp4cQk5WSlashwrv2xjUJJyD9
 36uU5KhofP6iYfTGwyFgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MVjJOMYMOwE=:7gX1hIQ2xDO46urdrI1QL9
 Bsm1JLAJtVtr1qB/BAypHnrYt+3H+E9FYQkuaBg1FF0egLYxWGXXFnJbz0WZSBOYTNKHiAIQM
 7PuDrugoiJcK/TFBJZ+47jVlxRVJneOo8FgDUhRR1AJutoezw6lOZzkAjQ6NWKGsopqgOq8cO
 7Ya8DQfdAoPRg68Uyklj6rRI6Y9bADWP5CNuB2XMMoq2GSuGmJUQU2RLPP+Vm6jGjPUDYHxFT
 EY8z1IEwEbbhD1TOK4PXU1glK1UhSv3xyW4shxyt+L1nBn31I5e3O3njPOBmhAMiiToScmVm9
 e9h9O/QByjhcYSlxs5/yO+kACi7r/8EZXUKWbtRoNZ4euq2wT59nz+zIy8a9Ej5YTiA7/j+WE
 vEIFUvpZEWB3yqHkRt9h+uxoVs47PI7aOUqfkg3SbQtKTTNNzlM+dVG/6B30kBMWcY9lfIlIg
 b3/uTr8Bh8anwgbKgQNgofQ4dfrjwJDIdETka0s15Pz0t6PNO2Uh4vHIxCiezv/1jJru5TDW6
 op1G1WNieZNoGZLImWXZC7P0CEov8TsxCrx99rTujMXj0RADh57F79aItcj6lzWxliry4kGs/
 c+waCLTx0wnrYxxHLFw8D72/bVwnT03ZJMaar7kWIX3hvor7uRqSKvYB5uG6sQe3Fr9iz9/b1
 baUPbtMASGfljpmSafxOaUzX5l7e6NxgnxO++e+qSpETu4n+DIXfOz/U3R/TWR1scj9dthZKa
 ojE6iy7vdiGvL8Z/v4kOCDg13HOw4bLdNCf+XHcEYzKs9uByllHPbgClKjbymuAVIsg/fScVW
 HeKcG4cVv6Ap+93IlfKZAvijJZOrcCvETnC0r4zOnVgk8YYSJITmQk580zUnPfGtDXKDAKq/a
 yFLMZ1y+/Kp9+UpudB7SJM53zXfz3PJxh9tncVCTOgE/hU63f2HD8UNIdApMbvqyc/+NT+y0k
 zgHocbKY2VqXmOT3t5pJwlIshrk6fJ0z6UBUE5PRQoPremSjFmmy94XE0ik/w0T44eSjO60aj
 1+Ox5B2+lEySItRi0xhtv9k6vaxeuoqVpZgL1lHerbLRxVXQI/UGOLUd/xnl2s7kQGXbNBube
 61VGT7urLlqHAQadzgyz0Xfn5f1digeRTQ9fXNiXKGSjUXiGvzCxJUXag==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hi,

there are some typos in the documentation and comments (see below).


On 13.06.22 at 09:52, Ilpo J=C3=A4rvinen wrote:

> -5. References
> +5. Multipoint Addressing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +   The Linux kernel provides addressiong mode for multipoint RS-485 ser=
ial

addressiong -> addressing

> +   communications line. The addressing mode is enabled with SER_RS485_A=
DDRB
> +   flag in serial_rs485. Struct serial_rs485 fhas two additional flags =
and

fhas -> has

> +   fields for enabling reveive and destination addresses.

reveive -> receive

> +
> +   Address mode flags:
> +	- SER_RS485_ADDRB: Enabled addressing mode (sets also ADDRB in termios=
).
> +	- SER_RS485_ADDR_RECV: Receive (filter) address enabled.
> +	- SER_RS485_ADDR_DEST: Set destination address.
> +
> +   Address fields (enabled with corresponding SER_RS485_ADDR_* flag):
> +	- addr_recv: Receive address.
> +	- addr_dest: Destination address.
> +
> +   Once a receive address is set, the communication can occur only with=
 the
> +   particular device and other peers are filtered out. It is left up to=
 the
> +   receiver side to enforce the filtering. Receive address will be clea=
red
> +   if SER_RS485_ADDR_RECV is not set.
> +
> +   Note: not all devices supporting RS485 support multipoint addressing=
.
> +
> +6. References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   [1]	include/uapi/linux/serial.h
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seria=
l_core.c
> index 76bb1b77b06e..bc18018e8d4b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1294,6 +1294,17 @@ static int uart_check_rs485_flags(struct uart_por=
t *port, struct serial_rs485 *r
>  	if (flags & ~port->rs485_supported->flags)
>  		return -EINVAL;
>
> +	/* Asking for address w/o addressing mode? */
> +	if (!(rs485->flags & SER_RS485_ADDRB) &&
> +	    (rs485->flags & (SER_RS485_ADDR_RECV|SER_RS485_ADDR_DEST)))
> +		return -EINVAL;
> +
> +	/* Address gived but not enabled? */

gived -> given



Regards,
Lino
