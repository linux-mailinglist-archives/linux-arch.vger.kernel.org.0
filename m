Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD1C70F73D
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjEXNFA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjEXNEe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 09:04:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E4B9E;
        Wed, 24 May 2023 06:04:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6ADF05C012C;
        Wed, 24 May 2023 09:04:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 09:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684933460; x=1685019860; bh=u/
        j4tury9PFogUt8uLVpuUyYP4Hl3pM3mNXPm8a+p4Y=; b=GI+13FVrtR4WkTH9VX
        VILe0xD9T7UZrsXz11/XIV+qPSVtW2W73t1IeitFzu0RvZa3GQVqNptX140iAiM/
        2mJfId1J+reaamo/q7Wg/2DRGKOs6A7te3UeMVr9jQlj211H8apkX+7QsrX6bFs5
        FuUAybE8D6YCzqX96iF/IhDL8y9KNipRJV3retpe+O6S9azm0kw8D2q01MPFiP/S
        SXRkjYqLxJHRHQ8BsFQbgT+UEqQcJVB1qNMfECi7a7LXWR8Im4CrR5i9NY9gg14a
        2AKG4dywXUr1XGDnnXweybTZ78ubK/4BY6vAp1oFcWi28kYhENCAsGDCTAWvNqWv
        uAog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684933460; x=1685019860; bh=u/j4tury9PFog
        Ut8uLVpuUyYP4Hl3pM3mNXPm8a+p4Y=; b=Mu/KV0wcgODrud6sCQYr+ooG1Pi46
        XDkZbafQMXnsYK5JOPAraXE+J304VGJ1D2IQnd2mhnU0EzMUxrCAxaeYd+gtjgQa
        38iLNdkwRTLkFN2r3oRx3HP1UVeRDUibNq3m6hdAs0TXyZxJ4FcrttHSZBIWdqvm
        fDOksOAY4GCxTASCu8Fd5fiT/7Lk+AzLNsFkkse1zb6iOhDdxTQQFB6senkdSJsG
        18u59TMDO9Dvh9Mgm8S+S+3pWDd4K+OJu5drKF4AAKu/wHx8m1AZzMx1oCDzrECO
        YL0cxeYgNDdgf8OrbCvXr/82GN49ID1VhvM9T0Z/Ye4FHNyampSyZMmWw==
X-ME-Sender: <xms:UwtuZA_34z0U_uFJReH0M9Ay7QUIRJmlD5DZsWwGgvbGcc1EXvAhRw>
    <xme:UwtuZIvH0TUNDitckQmCAxET5pvd-Y09XIgOzgHo8OFazMmcEDmvT2yuCcV8gfjpn
    5Ooc6N1N0gzJ3i6TJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UwtuZGAwHdnwKhHL7EU2E83IxqmoRU02a6M9Bd3Mp-PbjWobVQV1uQ>
    <xmx:UwtuZAdFR8jdCgIHuH99Hzrae7Lrl5CvgpSrnl29fWbztG9_pt-wEg>
    <xmx:UwtuZFNyFD-GRCaPXl6ZQ_xrHd9zJUKYTGOhZ6AuaaOCBncFpNWnlQ>
    <xmx:VAtuZIq142wN3y14Rzp7qi8n8eYmBPvxAGo5TxMjtvMFDKHWtiEhWA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 75941B60086; Wed, 24 May 2023 09:04:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <e4a31b5c-3b52-4565-aeb4-9151a148e188@app.fastmail.com>
In-Reply-To: <CACRpkdahOz++MD7f=Bmq2f_nT=TQkY5f5vT5PL=YEB4R2B7Vcw@mail.gmail.com>
References: <CACRpkdahOz++MD7f=Bmq2f_nT=TQkY5f5vT5PL=YEB4R2B7Vcw@mail.gmail.com>
Date:   Wed, 24 May 2023 15:03:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Greg Ungerer" <gerg@linux-m68k.org>, linux-mm@vger.kernel.org,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [GIT PULL] Convert virt_to_phys() into static inlines
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 24, 2023, at 14:53, Linus Walleij wrote:
> Hi Arnd,
>
> I am pretty confident of this branch now, so this needs some
> rotation in linux-next for the v6.5 kernel. No errors from zeroday!
> So please pull it into the arch tree for v6.5.
>
> If it feels shaky anyway I can set up a separate branch to pull it
> into linux-next. I heard you have a way to shake out unknown
> issues with stuff like this using randconfigs...

I've pushed it out to the asm-generic tree now, and merged it into
my randconfig branch, which should tell me about corner cases on
arm/arm64 and x86, but it won't find anything else. If I see
regressions here, I'll let you know and take it back from the
asm-generic tree.

      Arnd
