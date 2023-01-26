Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9267CBAC
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 14:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjAZNIu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 08:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjAZNIu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 08:08:50 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263F55CFDC;
        Thu, 26 Jan 2023 05:08:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9698B3200925;
        Thu, 26 Jan 2023 08:08:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 08:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674738524; x=1674824924; bh=9QQlQ8OR3l
        Q7ANbnLGJzCKzUzxNH3SO1M63tzLmReU8=; b=bGOQSJQrebxBgNQkKOnJyI53Qd
        UZ2y68yn0j1iPnKrhB1p4iTeRNa0TbvDq8V5784vAgvgMy4AjqeYAT61c/YPGsKk
        vDi/TI8H9iRnNE/LgVgoWg8NZgcxcusM6E/qDptd+0DR/KNtVxtVjHfqwWomMRar
        E7UG0CcDLI8y/j9UZ74KGsK06fPgfA54DN0A/4UMtcLi3MP6tooX/n8zG9OZ3hqr
        ZrN1a3oyiyOkylfz3Zk28WMIZhKAxOq5m/ueBks4uGsK9DBgi5+qFq3y/8V3gWhk
        /AOBmUJ0ebp4W1+PYMfiTSP7nFIwo94UeqpaWDpV6rasggW1jp/nh0wWta6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674738524; x=1674824924; bh=9QQlQ8OR3lQ7ANbnLGJzCKzUzxNH
        3SO1M63tzLmReU8=; b=UkVFsbQIWdvMgbEoTghnOBCiu1fmZLk7QAD1cfSqOfDS
        LnFUhh7BssziNnPEjsu1EwUzdFOfIvUnfCLY5UL8yg61kq4INZo7GLjg3a/UFBZQ
        zFX1dxiXV7tNS4TLSusDJ0wsBkrTfzaD0UouiwnqEdQvTk/ci1LAuLVbkiA9fUUD
        Ov8kGqiez0CCtCkdK/GoulEmjRzsWMIanORPbTRDcdWtjrmCIm57SE4oevc9OCOZ
        rY40NHxBl5ietfDDqNGDjniOaESah5BKyx+7Wx29tiTlg61zpA96au7vTZztgZOT
        qU5azHgEtJVTJB1XRpD8tUJDOWFhbVZ7iQh33nJd9w==
X-ME-Sender: <xms:W3vSYzWrUIpSamA3Lgs7TjY-QO_jw778A3EhUghurJGroUoeIZAuww>
    <xme:W3vSY7mf_HDQ3fkDP7wqUtg50JVvUKzv8ZQGL39EzE9kqckfFVkqilu77JJMVRJI_
    Itkh990UOdy5_mWARc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:W3vSY_aP_LaflpUUI2nRqCjCc7I86tzdoVWbvAeQYJeDFnMCLl0IpA>
    <xmx:W3vSY-W7iyIrPcHRTcUxAATF3WM3Z22xFrRN6_dZEOd0Z6bcXHVCww>
    <xmx:W3vSY9mCrkmh7C0TblhQP24w0nWUakSfmSoKRtggg9bRSyJav3KTfg>
    <xmx:XHvSY7ZHQ99m8KMWgfx8xwYuXKbsezBX7xt1Usod_OdaOYf7PFbrLA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 523F9B60086; Thu, 26 Jan 2023 08:08:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <38bfface-43a0-4538-afb3-b94e998f2f81@app.fastmail.com>
In-Reply-To: <Y9JS8HEPMu+/zEFb@smile.fi.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-6-andriy.shevchenko@linux.intel.com>
 <8454db45-a967-4542-8f16-538043542e14@app.fastmail.com>
 <Y9JS8HEPMu+/zEFb@smile.fi.intel.com>
Date:   Thu, 26 Jan 2023 14:08:24 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc:     "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>
Subject: Re: [PATCH v1 5/5] gpio: Clean up headers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023, at 11:16, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 09:42:32AM +0100, Arnd Bergmann wrote:
>> On Wed, Jan 25, 2023, at 21:10, Andy Shevchenko wrote:
>> > There is a few things done:
>> > - include only the headers we are direct user of
>> > - when pointer is in use, provide a forward declaration
>> > - add missing headers
>> > - group generic headers and subsystem headers
>> > - sort each group alphabetically
>> >
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > ---
>> >  include/asm-generic/gpio.h    |  8 --------
>> >  include/linux/gpio.h          |  9 +++------
>> >  include/linux/gpio/consumer.h | 14 ++++++++++----
>> >  include/linux/gpio/driver.h   | 34 ++++++++++++++++++++++++----------
>> >  4 files changed, 37 insertions(+), 28 deletions(-)
>> 
>> This change looks fine, but it conflicts with a slightly
>> broader cleanup that I meant to have already submitted,
>> folding include/asm-generic/gpio.h into linux/gpio.h and
>> removing the driver-side interface from that.
>> 
>> Let me try to dig out my series again, we should be able to
>> either use my version, or merge parts of this patch into it.
>
> Can you share your patches, so I will rebase mine on top and see what's left?
>

See the top patches of my randconfig branch at

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=randconfig-6.3-next

There are eight cleanup patches for gpiolib, plus another seven
patches for individual drivers. I just rebased the tree on top of
linux-next, fixed previous build regression, and will send the
gpiolib patches later on if there are no new problems with it.

   Arnd
