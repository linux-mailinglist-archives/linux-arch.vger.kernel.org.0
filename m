Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47199714C8F
	for <lists+linux-arch@lfdr.de>; Mon, 29 May 2023 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjE2O5H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 May 2023 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2O5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2023 10:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0866B7;
        Mon, 29 May 2023 07:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89A7F61B91;
        Mon, 29 May 2023 14:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE05C433EF;
        Mon, 29 May 2023 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685372225;
        bh=JsYQ9lj3pZLAlJkBzkkA1W1VrbTHRJOfd46VLHqXM+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvpJ19XaBY0CbiZsJTodwykH4m0lnnIElrsSTNYZTwb9A+hzVOWgWjhyYW6kbjnvd
         RSQS1yaj9rWHvM+wgOIGDJyS0Qq3Mg0SseunVXB9oBdAR+sIYYEaJcdvqcxmhIgB9V
         U6l9Trr9rDXT9XzU+2h2wF2x2Fatze/Oy5EBO75M=
Date:   Mon, 29 May 2023 15:57:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 6/7] docs: update some straggling Documentation/arm
 references
Message-ID: <2023052953-italics-consonant-ea11@gregkh>
References: <20230529144856.102755-1-corbet@lwn.net>
 <20230529144856.102755-7-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230529144856.102755-7-corbet@lwn.net>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 29, 2023 at 08:48:55AM -0600, Jonathan Corbet wrote:
> The Arm documentation has moved to Documentation/arch/arm; update the
> last remaining references to match.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-input@vger.kernel.org
> Cc: linux-sunxi@lists.linux.dev
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  MAINTAINERS                          | 4 ++--
>  drivers/input/touchscreen/sun4i-ts.c | 2 +-
>  drivers/pwm/pwm-atmel.c              | 2 +-
>  drivers/pwm/pwm-pxa.c                | 2 +-
>  drivers/tty/serial/Kconfig           | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
