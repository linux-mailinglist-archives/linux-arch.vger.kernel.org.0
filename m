Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DABA73FFDA
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjF0Pgp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjF0Pga (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 11:36:30 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1C2D53;
        Tue, 27 Jun 2023 08:36:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 159E95C01CE;
        Tue, 27 Jun 2023 11:36:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 27 Jun 2023 11:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687880185; x=1687966585; bh=d5
        PCHYnKS3d7L563S2theQPvUjw0WZ0+g39I9GarxjQ=; b=yxLBPhTCDTF49mW2Uz
        LlqVVj37ex7Bru80dIxE3uhA1I5NEiD7KtUk2zpv1SeysrSUeNSGRFLtZS1S+kfe
        bsj6Nx1v81RcI0swufiFMjVI4RyNHkXZepJvL14HkTbEYVlMDTd27sBWr3JTYTqE
        cjIMeiRpUOTEEsfF2iy1iiZIdM2Na6goMv44fcIHe7twHPYmn768BHM9okNyrChY
        1EEngb/Xku4ui+hQ+YhknUwPhsu5Y8Asi4ine2zHY95ftIbS1TXH3UCRwc8DkMnQ
        E03vxxygWOFFMelk+dLSNM7HmcZssgWf+2kS47sSvT5XMQNyUvD0D/zJJqnaAT29
        Vypg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687880185; x=1687966585; bh=d5PCHYnKS3d7L
        563S2theQPvUjw0WZ0+g39I9GarxjQ=; b=S/8EL1+4ZVxwdv+H9bsf/FgatEVxU
        4c/sWtG+IBTsMaTLMDKKdAeOSzc4TVl4Rm7nki9FtopuXEa1eY3x7XhOxyTATMXq
        0qxUClPD+KHNXS3oVi+bb2oxL6AwhVxgSGSkbzfQJxDWXCO8WMYbob50rWxGk9el
        lzClXgLr9SYuOWuT/feeZG0mvAJW/YH0b8CnzS5VcY4ktcNanonLoTiDCNoN45pn
        zSiHj/kFDBPzgwcfSzskypmAAkz0NLExK9UGBW6xdg7GduPt64mCUlfkZSoM5tJz
        pjr+kNf3qP0JE3vBuDtY0bChwIv7sz7QUvDLBkswaD/U7nNLIfofeQHEg==
X-ME-Sender: <xms:-AGbZNWPj7v8vbaW4kODgw4w74877q3hh8FPlfAwllhyjbQaif75Mg>
    <xme:-AGbZNm3q21STKJcC4lDboUHTPzN82OlFRn4k1L_4CrhwQpaWHJ9dghkFNFvA9ZVZ
    pr3iK8K_Ln840dLb8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-AGbZJaVtppFTcJ_2Qqa78Q69lPLesss4nuLq02bs2UJKtNS6WlVVA>
    <xmx:-AGbZAXhTSnsNnINliThtSsDUQquRocPeZE1syiv0--MsAcZ-BUEXg>
    <xmx:-AGbZHkRM5H9bSI4gTKttL42tSaX4mfrODSyYtAWTMFJTuuYBeizRw>
    <xmx:-QGbZFaUhHZrO-W1vioGjNytcRS2jmU4Wl3-6WuDkyd8qCRNBRA9TA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4490DB60086; Tue, 27 Jun 2023 11:36:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <00ad433e-9e45-4361-add8-0544db857af0@app.fastmail.com>
In-Reply-To: <20230627145843.31794-1-tzimmermann@suse.de>
References: <20230627145843.31794-1-tzimmermann@suse.de>
Date:   Tue, 27 Jun 2023 17:36:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Sam Ravnborg" <sam@ravnborg.org>, "Helge Deller" <deller@gmx.de>
Cc:     sparclinux@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] arch/sparc: Add module license and description for fbdev helpers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 27, 2023, at 16:58, Thomas Zimmermann wrote:
> Add MODULE_LICENSE() and MODULE_DESCRIPTION() for fbdev helpers
> on sparc. Fixes the following error:
>
> ERROR: modpost: missing MODULE_LICENSE() in arch/sparc/video/fbdev.o
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: 
> https://lore.kernel.org/dri-devel/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4eec0b3048fc ("arch/sparc: Implement fb_is_primary_device() in 
> source file")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
