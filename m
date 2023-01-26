Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEA67CB6A
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 13:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbjAZM46 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 07:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbjAZM4y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 07:56:54 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197254C2B;
        Thu, 26 Jan 2023 04:56:47 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D6B4B320055E;
        Thu, 26 Jan 2023 07:56:45 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 07:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1674737805; x=
        1674824205; bh=mrN9AP1x+KQ6HQiktOIDZMEyE5DQCiPIxxOHlND0nYQ=; b=K
        Uiws7OYeDGsTb5d+zzWZkNiBAS9Y5l1RixhynOEHXxGKPn+L/YZ5rigXKjOuNGx2
        YPu5RR4JbIxPO2ybBXnV3+B7PV58yjvpoDk26uOwSJgJ4VQlomdJE3d/t1rIOBVK
        ovJwYqFekGKAz0ubGQj+jkAazL3EHkQ/ppr8J2mpSXZ4tEvIZN+bFXcxt9Pf4Ptl
        mDCmZRKe0+6jcxMX/xsQxn0XR5u41p92+CH/6x5e3dQ9VztMW99EzsXUUCjs3hlr
        ee9Y4hytoKbay6KjgUadEhZhmqwEr2rBN3LKvS7ztavkKFdoItNOVg6ITI9l6n9S
        KMTqDx5DloE5dNj7mVJZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674737805; x=
        1674824205; bh=mrN9AP1x+KQ6HQiktOIDZMEyE5DQCiPIxxOHlND0nYQ=; b=A
        Cpa6gHV6+muZ0G6UI9xQufkiIGJ3o9dm7ChBHF83nMBkVsyxT1ZKVYpQ8kW+reDA
        bNHY1fz0RG+1/z8G2ZWItZEZXDg9qB61apbg2wj/M924dz6SNdImIzxUD6J2JaO9
        D8VpTS9Im0mct7J59Lat6uuWNAEZq0L/doIeFJt7s+O6NMlRUwsIRUc2mTAavDgq
        F6bS0kGrh8bDAY2+oNX20hLqZ7JsSfMms/89JRJBrdgfYiScswR+8/gddcrhxwji
        lC5TbTQYLHvl70ZeISPL3bF0qvxdyBeOrQHCVZ4nbN1rKzNP6ZUdMbfkq29c+GVt
        DLlbv8jQ68GE1CqxvQivg==
X-ME-Sender: <xms:jHjSYxJFJ2TYxpRbh7cqixsL9N900bxuxtZ_znmc6-M1elJSjLZr1A>
    <xme:jHjSY9KwVH1Vj08rIQvHs-oKr7m1dj4L0CNa2M3q_j0ytNt_DoErdY6ZMBNtDhrqe
    PjOae8RlfhOXFe5his>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jHjSY5tN5IiSmuyXHT3-n2dWC9_ByDx9V8gqkc_tJM23FfWFDN2WXA>
    <xmx:jHjSYya5taBJMNhNYf4N15E9OOd764aT9OLt-LlP-diEIemrK3y8rg>
    <xmx:jHjSY4a9A5H-RQZtMpLADCuGU1INNIZqIFDwW5N_VKduk15zZ2xDcg>
    <xmx:jXjSY-PSfQwF-F3iXCz5zZ2LaGaXPVsnNYDg9l481uxBXx39KGAR9g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B956CB60086; Thu, 26 Jan 2023 07:56:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <a9ec7f46-dd07-40e7-ae48-a1e48d2101c5@app.fastmail.com>
In-Reply-To: <7b7df1f7-4f47-d19a-02ff-91984b25ba98@csgroup.eu>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
 <Y9JTo1RkxT2jORPE@smile.fi.intel.com>
 <7b7df1f7-4f47-d19a-02ff-91984b25ba98@csgroup.eu>
Date:   Thu, 26 Jan 2023 13:56:26 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc:     "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Pierluigi Passaro" <pierluigi.p@variscite.com>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is disabled
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023, at 13:44, Christophe Leroy wrote:
> Le 26/01/2023 =C3=A0 11:19, Andy Shevchenko a =C3=A9crit=C2=A0:
>> On Thu, Jan 26, 2023 at 08:14:49AM +0000, Christophe Leroy wrote:
>>> Le 25/01/2023 =C3=A0 21:10, Andy Shevchenko a =C3=A9crit=C2=A0:
>>>> From: Pierluigi Passaro <pierluigi.p@variscite.com>
>>>>
>>>> Both the functions gpiochip_request_own_desc and
>>>> gpiochip_free_own_desc are exported from
>>>>       drivers/gpio/gpiolib.c
>>>> but this file is compiled only when CONFIG_GPIOLIB is enabled.
>>>> Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide
>>>> reasonable definitions and includes in the "#else" branch.
>>>
>>> Can you give more details on when and why link fails ?
>>>
>>> You are adding a WARN(), I understand it mean the function should ne=
ver
>>> ever be called. Shouldn't it be dropped completely by the compiler ?=
 In
>>> that case, no call to gpiochip_request_own_desc() should be emitted =
and
>>> so link should be ok.
>>>
>>> If link fails, it means we still have unexpected calls to
>>> gpiochip_request_own_desc() or gpiochip_free_own_desc(), and we shou=
ld
>>> fix the root cause instead of hiding it with a WARN().
>>=20
>> I agree, but what do you suggest exactly? I think the calls to that f=
unctions
>> shouldn't be in the some drivers as it's layering violation (they are=
 not a
>> GPIO chips to begin with). Simply adding a dependency not better than=
 this one.
>>=20
>
> My suggestion is to go step by step. First step is to explicitely list=20
> drivers that call those functions without selecting GPIOLIB.

I tried that and sent the list of the drivers that call these functions,
but as I wrote, all of them already require GPIOLIB to be set.

This means either I made a mistake in my search, or the problem
has already been fixed. Either way, I think Andy should provide
the exact build failure he observed so we know what caller caused
the issue.

     Arnd
