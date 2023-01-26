Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5D67C622
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 09:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjAZInD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 03:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbjAZInA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 03:43:00 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B824491;
        Thu, 26 Jan 2023 00:42:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C8385C00BF;
        Thu, 26 Jan 2023 03:42:52 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 03:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674722572; x=1674808972; bh=nO+L+3JIww
        M86tiUtG5AIEeFVrH8ls6dxU+K7+QHLI4=; b=l9M+Gxf/8h1qzORPNJ7YcsmCp3
        OstcJLTj5DIsu347LkcLXTLEvjcLc9K+O+zpedlRfIIzRWT05TPrOKG0lXs8cu22
        4hWoU2xTfEsgdPWjb+4O/uEFaYoa/XTYdSqY2jWsThGejM436dZmiOXP1gfJFObX
        PYG67cBLHUXl8NtYwtvfCXElyhkSx/kRzm4z8Jt4OrMpLEc/KbMnFZXc8p0ilh3x
        2794c0TS1Slnp9OpY1SLI2rJj71hxcLIfuk9LBgq0jpD2KgX+5kfwkCYUQQT/oyN
        ibHj5mRNu4Ii3ftj9M/IGDJ2Og1iOqlXzG8fXN5/JFRypXEYDrVIRO+irb0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674722572; x=1674808972; bh=nO+L+3JIwwM86tiUtG5AIEeFVrH8
        ls6dxU+K7+QHLI4=; b=L1+9fQt//P0FLmgvzgGv1+uTArB3sXDjL9s22qZdi63D
        Kb0kzukmtqJwgRhU1FtVb7JMMThaJJTgdpFjfeFV2w9WN6Z+HQNIKxljJ4uKMNTo
        oVOj6+6hl+zr58I5C8Td026QN+jqpESCCuJ/gGEV1XU6LLXaiKIfjmzJxEFdSYN2
        7vGd06EqWYeswOr6Ud1W3OpIDNtDtlAceB3ii2tYZXy8c3dMzJjOafMs7qcPKAWM
        edCQFP4WKXKD9/emhanO0GWrdaTvTEGX8RzN0wZuoI77MGfk3NfE6VLfJk49d4nX
        4fP0GezCjlRzfMYWcYbd3BkPj7JYTWjsjoKbiuG+Cw==
X-ME-Sender: <xms:DD3SY_Y3pPxQDd9beYitRETBBplj3tulHSyo8Mh15kOBYzyLCAsBAA>
    <xme:DD3SY-bz8E5Wu7FSh9T6b33m1zPnpOkFol0uq3iuiQN4w8JRHUPd3mD0zY6_JJDFr
    4vixELAkqop0qNxT8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:DD3SYx_VIFvQ5UyXU6pH4PvnF2vVUi3ZLnNHhx6bwQWBz3Ul3BuEFA>
    <xmx:DD3SY1oE7OsbFSmQEjCEj1w3uNSTIUEP3Nevbjj6QlUSBcpoNrIheg>
    <xmx:DD3SY6p6osrobRnUYr7R1lal3X5pM6ZEOTqK9nrEwDvQvO3MOQFndQ>
    <xmx:DD3SY7eGB7Wcba07282fDBsDwWPELL4-hrIpt4Kj4_7N5KFCLb4BHQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 06FDFB60086; Thu, 26 Jan 2023 03:42:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <8454db45-a967-4542-8f16-538043542e14@app.fastmail.com>
In-Reply-To: <20230125201020.10948-6-andriy.shevchenko@linux.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-6-andriy.shevchenko@linux.intel.com>
Date:   Thu, 26 Jan 2023 09:42:32 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>
Subject: Re: [PATCH v1 5/5] gpio: Clean up headers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 25, 2023, at 21:10, Andy Shevchenko wrote:
> There is a few things done:
> - include only the headers we are direct user of
> - when pointer is in use, provide a forward declaration
> - add missing headers
> - group generic headers and subsystem headers
> - sort each group alphabetically
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/asm-generic/gpio.h    |  8 --------
>  include/linux/gpio.h          |  9 +++------
>  include/linux/gpio/consumer.h | 14 ++++++++++----
>  include/linux/gpio/driver.h   | 34 ++++++++++++++++++++++++----------
>  4 files changed, 37 insertions(+), 28 deletions(-)

This change looks fine, but it conflicts with a slightly
broader cleanup that I meant to have already submitted,
folding include/asm-generic/gpio.h into linux/gpio.h and
removing the driver-side interface from that.

Let me try to dig out my series again, we should be able to
either use my version, or merge parts of this patch into it.

     Arnd
