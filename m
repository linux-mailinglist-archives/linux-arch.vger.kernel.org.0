Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC867C60E
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 09:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjAZIku (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 03:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbjAZIkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 03:40:43 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351629757;
        Thu, 26 Jan 2023 00:40:40 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F66A5C0447;
        Thu, 26 Jan 2023 03:40:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 03:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1674722438; x=
        1674808838; bh=38uolB1vu5XeoWuDZOwJpjEX8L1LM6DR5gOOaFH+JRY=; b=P
        W9Qq3+ikzD50MnIhGp+6w7yxU7DCMwbcLpXaMcSTXgjwMlxnaEWqt6+NqkuC5eoD
        nYW3rXul89VG3BidL4Hd2NLs7VU62p1xU3hi2RdQTBN8MoPO8gbqignWCysAhaTv
        JANZj87X8y6kV4WuPWYEDs1iSQnbyLOmobOqBeEQkQByit56C+8E9fj/XVUywduA
        KXChSJbCOYkgaDa8IQmzQuZOubJH/mxGFDHYZoIPUwP/X1m1ij/4AJvFjBD9C3s9
        Q39ZCRzuw509DNBAqxgpU1qwN86GuRKKHJhEr0obsd/bTwt3DvOTUsJ1q0HGxoWE
        RWVERBJRevoXSTwPBfnWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674722438; x=
        1674808838; bh=38uolB1vu5XeoWuDZOwJpjEX8L1LM6DR5gOOaFH+JRY=; b=g
        OL2S3NaCdUeLQQ3zdm66oO+fVjYFAvSezYBOypuB9ZG4UgR8f6TPi0utD256JH7G
        /hZboE+aj7pgrT1PwEbK635qwUeSX3DArPzMhapzHpwGEV4eTJBfgU6LdE23/aoW
        CCflKZ2Kb1Uyhj9A/mgE/ny/8ZJkmDsECuMY6DROtPXAFStOW9kH5teQr52KaaBm
        uoXh40xYdUwLF9TmnFt6NBq80aV2M9yWC/eKr9IjT8HtUDcxvu0QWcn3/zwlaYr/
        cOvpAjW58J6gl2DnDOBJSv/ZMZtpl/c+HVy7E4M4wkjs+PPWmIuxuzSPMNLzkCYL
        1DP6C4OkdylIXFxbhSh4A==
X-ME-Sender: <xms:hTzSY0PlCbpEW3h6nZG8wInC-pGYuuks1FtcXxqHM9gGR0oHrltPpg>
    <xme:hTzSY6_r6tWlMjcQvkSmGFwJaHaPJfasAgVHOna0OHmncWRFuwAluQUqEtTNb0qoB
    pi-uGUU6E4b9WwjYQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hTzSY7TreSNU8U_mEJw_a6a65ls3Re6gVeJWnFV5ZsJku8_VAss46g>
    <xmx:hTzSY8t_gEu-ehMEcv2MPNG2wwBGZwK-aEiqJNy0rMAxPed9rB6Xzg>
    <xmx:hTzSY8eP7q1vxz9jr1RYMXQx8JxYCiiEh37wAPPq9eRnZROxq1L-_A>
    <xmx:hjzSYzwpC3vfHuKtTQlh_I4cdLdfien7Q1gMLWai5uII-xjEXtmEeQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC027B60086; Thu, 26 Jan 2023 03:40:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <05d32a58-c119-4abb-8e62-9d79bd95324f@app.fastmail.com>
In-Reply-To: <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
Date:   Thu, 26 Jan 2023 09:40:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Pierluigi Passaro" <pierluigi.p@variscite.com>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is disabled
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023, at 09:14, Christophe Leroy wrote:
> Le 25/01/2023 =C3=A0 21:10, Andy Shevchenko a =C3=A9crit=C2=A0:
>> From: Pierluigi Passaro <pierluigi.p@variscite.com>
>>=20
>> Both the functions gpiochip_request_own_desc and
>> gpiochip_free_own_desc are exported from
>>      drivers/gpio/gpiolib.c
>> but this file is compiled only when CONFIG_GPIOLIB is enabled.
>> Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide
>> reasonable definitions and includes in the "#else" branch.
>
> Can you give more details on when and why link fails ?
>
> You are adding a WARN(), I understand it mean the function should neve=
r=20
> ever be called. Shouldn't it be dropped completely by the compiler ? I=
n=20
> that case, no call to gpiochip_request_own_desc() should be emitted an=
d=20
> so link should be ok.
>
> If link fails, it means we still have unexpected calls to=20
> gpiochip_request_own_desc() or gpiochip_free_own_desc(), and we should=20
> fix the root cause instead of hiding it with a WARN().

There are only a handful of files calling these functions:

$ git grep -l gpiochip_request_own_desc
Documentation/driver-api/gpio/driver.rst
arch/arm/mach-omap1/ams-delta-fiq.c
arch/arm/mach-omap1/board-ams-delta.c
drivers/gpio/gpio-mvebu.c
drivers/gpio/gpiolib-acpi.c
drivers/gpio/gpiolib.c
drivers/hid/hid-cp2112.c
drivers/memory/omap-gpmc.c
drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
drivers/power/supply/collie_battery.c
drivers/spi/spi-bcm2835.c
include/linux/gpio/driver.h

All of these should already prevent the link failure through
a Kconfig 'depends on GPIOLIB' for the driver, or 'select GPIOLIB'
for the platform code. I checked all of the above and they seem fine.
If anything else calls the function, I'd add the same dependency
there.

      Arnd
