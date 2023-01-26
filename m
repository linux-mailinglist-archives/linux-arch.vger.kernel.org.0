Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8167CD48
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 15:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjAZOKz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 09:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjAZOKo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 09:10:44 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E038B305E1;
        Thu, 26 Jan 2023 06:10:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E6C5C320092D;
        Thu, 26 Jan 2023 09:10:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 09:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674742238; x=1674828638; bh=U4/r5dEQVW
        x3dUhx1q619GsM2gBX67/2IbFa62g79pQ=; b=VitC5m5ZKrj9aJkwfsqhl6rrIn
        rjpjHYk/JpdBSO5g0k5d+PB+lq2VIjK+ltomiwQSHBtrjlX1ShUCsHNRBmV5r7aN
        PZ0DrhSVfr0VTf7ddlN2E0XBIDEAHNej5R2ERaZTnnddhPmNktYbGcFLbu3vGTAa
        NTUfJeAYaOl4aielSpvUVHiJv1K8zr2GgcIe78zDFEcadLOWkttOE39+jcyMRROZ
        Spv/e1mWqedhBGzjJCkVt9sopiXSVqT21spwpbCCwlXR2noNBJyDbKXlVdMgZZxQ
        gY/TY5Zao/EzwPzfh2wo+nJk/VPYAhyRWFxTgdHyXPgECb66i9kQrLJnjjJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674742238; x=1674828638; bh=U4/r5dEQVWx3dUhx1q619GsM2gBX
        67/2IbFa62g79pQ=; b=pBezrvZ/KoJB+oazpPSXQZ3v3cJlcHYnqq6FHLUAxTmn
        c964WuSj3qfPVYSjkfqlaW93yOc67osErakfjU3Ss2dzc+QkaIcbvSal8NixuhL9
        3ouLKpqQaoLmM5xvHNTsMVHl9xmtkitErObvj2NFZWoBKxfsrCWxjqdN7hyiRWXr
        iFBJQnFY4fe3ylcBH3XujVleb2bPWkaWDKIj/Yp6agnqQXGFgpAAq/inQSsFYSea
        6KuElIczYZ2J0YnXQJoB1BO5ViOSb7ajeLBDVgDvBFegQnoYIu5GydmFTx+KwVmZ
        0rPVcK2G9dM1zpgjBu1A6RzejPsONUcNYR70LW4MKA==
X-ME-Sender: <xms:3onSY5fJPBNTTNiylmZt8cNbON9Jw-zelUwrjOLHX5jJz_PCdbJ7eg>
    <xme:3onSY3ObKd9fwitNqm_T3ilq23stf6VYf080DksGmFwHLDX5kXbTsOBWIR_ajSPx0
    pyCVD3IPpj7C6Utf7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3onSYyjaxGX_ZYMg9ARyB6sq6zv96P-J2j0b1r-EorDASu-0dCUUAA>
    <xmx:3onSYy8_lEInyTOBJtNttgOfc7f-kWn1CKItZstHIScLm7MZU6xwaQ>
    <xmx:3onSY1vlesccpBnbd_xi30VjwoH31dt03YCvJLQyT3ZJ9vIBqTO05g>
    <xmx:3onSY7CcfnICaCVecYgHBHkpDwWtD9ioCdh3VRpm4FlHKsc_77glYg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F1222B60086; Thu, 26 Jan 2023 09:10:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <5d11eea7-0dd4-44d5-be09-27ae18492916@app.fastmail.com>
In-Reply-To: <AM6PR08MB4376030EDCFAD7F5FD5313D2FFCF9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
 <Y9JTo1RkxT2jORPE@smile.fi.intel.com>
 <7b7df1f7-4f47-d19a-02ff-91984b25ba98@csgroup.eu>
 <a9ec7f46-dd07-40e7-ae48-a1e48d2101c5@app.fastmail.com>
 <Y9KAPge5zy0cIqi8@smile.fi.intel.com>
 <AM6PR08MB4376030EDCFAD7F5FD5313D2FFCF9@AM6PR08MB4376.eurprd08.prod.outlook.com>
Date:   Thu, 26 Jan 2023 15:10:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Pierluigi Passaro" <pierluigi.p@variscite.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is disabled
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023, at 14:41, Pierluigi Passaro wrote:
> On Thu, Jan 26, 2023 at 02:29PM +0100, Arnd Bergmann wrote:
>> > >>>
>> > >>> If link fails, it means we still have unexpected calls to
>> > >>> gpiochip_request_own_desc() or gpiochip_free_own_desc(), and we should
>> > >>> fix the root cause instead of hiding it with a WARN().

>> > This means either I made a mistake in my search, or the problem
>> > has already been fixed. Either way, I think Andy should provide
>> > the exact build failure he observed so we know what caller caused
>> > the issue.
>> 
>> I believe it's not me, who first reported it. So, Pierluigi, can you point
>> out to the LKP message that reported the issue?
>> 
>> P.S> LKP sometimes finds a really twisted configurations to probe on.
>> 
>> 
> I've received the following messages:
> - https://lore.kernel.org/all/202301240409.tZdm0o0a-lkp@intel.com/
> - https://lore.kernel.org/all/202301240439.wYz6uU0k-lkp@intel.com/
> - https://lore.kernel.org/all/20230124075600.649bd7bb@canb.auug.org.au/
> Please let me know if you need further details.

I think these three are all regressions that are caused by the patch
in this thread, rather than the original problem that it was trying
to fix.

The one we're looking for is a randconfig bug that showed up
as a link failure when referencing gpiochip_request_own_desc
or gpiochip_free_own_desc.

      Arnd
