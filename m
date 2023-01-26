Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2767C88D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 11:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjAZK2O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 05:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjAZK2N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 05:28:13 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA7F126D5;
        Thu, 26 Jan 2023 02:28:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BC4785C049B;
        Thu, 26 Jan 2023 05:28:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 05:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674728890; x=1674815290; bh=zSxeHsJFyS
        /kUWqCkulRCicQEyvTrnSPfQJ9Vnyj+Es=; b=SArs0rsYB9RWF5dkIyHLpNFlkb
        A6B/vxNkxxGSIZTFLSjBZ3SypIMUaOVzeI85EINFh3ByivPJRYOe+ioypqeDiGw+
        vFWmXKYWXWI+mExnoK9nUfsr0pmc71Q+SjDhVCL6+BUrjo48HzO7OsIcl27WjBWR
        cSPqgKiTJ3ykqilErfLUd/PNnjcXADql5OGXKHQDG2W6iAbrwpw1db14fRlta/tz
        JOiWzh5ubJP/Qik+o9hnwaVSlZmrYfo74uFpw8h/qeX1lY8eEkphGwGo4hKQLBjv
        pLASKGczh9wu1aj0x3KMlca2kgG/A58C9oc5Y5ZAFiF1Klbs6jVwG57OkgMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674728890; x=1674815290; bh=zSxeHsJFyS/kUWqCkulRCicQEyvT
        rnSPfQJ9Vnyj+Es=; b=Sso2PvjhwJF4F5wOQFN0RKyOKVFKUUn3jkb/sRa4lbU/
        G3LTnT4u7N9evUUEJAhKLDn2CQcZ+27pLH0Uh2vva0EeAZ+jfRrZwIROdbrOK4rz
        ZdXpKENxRWHgwPdWQML8LfaaJaTxPTPP9WKtxF2myiVe6tVVem6CaunAxqqdag67
        MUHtcpQ5/00MGTlqvGpox/4HF2qQD7kpQcBLwXtjHAzpUdkahaEgnVl5DNJBfxxS
        wWdaj8vw7qqHUZKre0WwqJprca4l3f/JXVemKQRWGYgY6udNEChRRQQtAX9mA2dQ
        P5yeCaQn43WdnrYXNj5MLjpmUcfZsrJlDbjCuZleeA==
X-ME-Sender: <xms:ulXSY2IN9Nv1gPN-R1KkdRnzvRBB-0ZPol2srvg_1JsoeH7-dbKL3w>
    <xme:ulXSY-LaPYWQiAyRUZk9YPEXUmogRTpJgorIjWCDSkMpi6bL7rKDWoCUdRu5gwmDE
    4bF2hrw9V0g1WnTUjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ulXSY2uWtQkCcCM2c3TBkEnZ51ljindxVTzVqO6hD-WmvgP_5PUGnA>
    <xmx:ulXSY7aZ_ADi0WKWpa_3hqe1hApgNBPVIm2BQxyCJmgcucLnqGH3vA>
    <xmx:ulXSY9a6siH1KBZ3Ohq2DpUTANRg3hsAmzKpGit2dAbnY_d_2hqY4g>
    <xmx:ulXSY7PvcmL-sUHDLv1PSr5snQjhDucgFqi1-2-tzmrF7eyPCXYErw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4B436B60086; Thu, 26 Jan 2023 05:28:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <7bf72f8f-1936-4b1e-b970-2fe09b6641ca@app.fastmail.com>
In-Reply-To: <Y9JTPAL7VDXNPy5h@smile.fi.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
 <05d32a58-c119-4abb-8e62-9d79bd95324f@app.fastmail.com>
 <Y9JTPAL7VDXNPy5h@smile.fi.intel.com>
Date:   Thu, 26 Jan 2023 11:27:51 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Pierluigi Passaro" <pierluigi.p@variscite.com>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is disabled
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

On Thu, Jan 26, 2023, at 11:17, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 09:40:18AM +0100, Arnd Bergmann wrote:
>> On Thu, Jan 26, 2023, at 09:14, Christophe Leroy wrote:
>> 
>> All of these should already prevent the link failure through
>> a Kconfig 'depends on GPIOLIB' for the driver, or 'select GPIOLIB'
>> for the platform code. I checked all of the above and they seem fine.
>> If anything else calls the function, I'd add the same dependency
>> there.
>
> So, you think it's worth to send a few separate fixes as adding that
> dependency? But doesn't it feel like a papering over the issue with
> that APIs used in some of the drivers in the first place?

If there are drivers that use the interfaces but shouldn't then
fixing those drivers is clearly better than adding a dependency,
but we can decide that when someone sends a patch.

Adding a stub helper that can never be used legitimately
but turns a build time error into a run time warning seems
counterproductive to me, as the CI systems are no longer
able to report these automatically.

    Arnd
