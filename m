Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC567CA90
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 13:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbjAZMHy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 07:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAZMHx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 07:07:53 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A84E1E280;
        Thu, 26 Jan 2023 04:07:52 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DF56F320092E;
        Thu, 26 Jan 2023 07:07:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 07:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674734870; x=1674821270; bh=ntjxN9egP0
        JnczzgtV83gw6W0AJFojT1Kx5iE4O7JKo=; b=oTkDRQey0luvL25Su8rdsPMSNZ
        7Sb6mHjycBfIopMAdnvDVoTXnJsGZxR/ZryxaThDRlqz5bTRojlZq8IO2rUsRd0a
        JHS6GUqH1pxMgT4LWgWXauhn9NdajKh0i5wc7DE98ioavFM8oESvyTLS32WRQ6S3
        A8lnR9O0zb4DBV0DoU9F69Q2JLoviGCQ+Fcfl/aLdw/obug+ct/93kcPZQz514+1
        UEoQ1tyMhcfNdZd6gtPUCChxvDXvbcrQT3v8H15KBbi662rxs0uULe7uQI4LDq+c
        ojE63mv2bXcQ2zlIpWdVNzvYGRDx1Qh0JckzktUjB3KdG6Wor7/C3xN+ELdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674734870; x=1674821270; bh=ntjxN9egP0JnczzgtV83gw6W0AJF
        ojT1Kx5iE4O7JKo=; b=MR2ikMF1QFS3wCfsO9T/dOOejCqhzgjTilfAmvyRNHCa
        q0+J0kg4aFvJoTbv+djc+mlJ1iozMrj1LXMALeh2SbqXwaXNZJ+9iC+xkBQJTwaK
        bSwW5XvnDTVyq+Sf/Ms/z3u+yiY+Bo80WjStYgAy5U6rVEt/lKmYmeNRYy0pLLV9
        yUkx5eJQTuWCj68a3OxRBjREM6Yfmg4j96FlXAriQD+1c4ATm4egkZELo0QB5kPL
        DkBozqQQ5dBf7c+hMwlRvKQDcKIr7ALiRWSL2QWHi0sSaExh4srflBG41vxtRvgs
        28xuHVbQjnG6QiLGYTbn+s590+dYETBvWjUPvU9gZw==
X-ME-Sender: <xms:FW3SY1bgKvBi-0Q0-SWc13FiIPAOENqHrejHh3zaXuF3OBqJWwiJ4A>
    <xme:FW3SY8bkDHM4tcTeP8b_QoPi3CTIixWglMSRlpaIrZEQ7Q9AZ8jjuaTDxgZpJUlkt
    u1ZBWeCCnSjaiSrj1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:FW3SY3-k7yNdEKAEAo__v_JQwsqoXpR2y3cEX_eIuKR25REAEUfEzQ>
    <xmx:FW3SYzqQyqYxwSH9achp75tBwSbjlLB-dh4mHImH2yryFjdgtjBDWQ>
    <xmx:FW3SYwpJj3-Hc565q3eWKLLdfVy0w_uW8y_2Qr20iNAy_j6-LnW61Q>
    <xmx:Fm3SY7Aa11x8PqSmYRpDLPvafthrY8bh03C-aKhHIhgwd7Y4JH40vA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8D555B60086; Thu, 26 Jan 2023 07:07:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <38a9a8f8-6bc7-42aa-b5e2-0148371e29c8@app.fastmail.com>
In-Reply-To: <8d492ee4a391bd089a01c218b0b4e05cf8ea593c.1674729407.git.geert+renesas@glider.be>
References: <8d492ee4a391bd089a01c218b0b4e05cf8ea593c.1674729407.git.geert+renesas@glider.be>
Date:   Thu, 26 Jan 2023 13:07:29 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Tomasz Figa" <tomasz.figa@gmail.com>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Will Deacon" <will@kernel.org>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        "Dejin Zheng" <zhengdejin5@gmail.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] iopoll: Call cpu_relax() in busy loops
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023, at 11:45, Geert Uytterhoeven wrote:
> It is considered good practice to call cpu_relax() in busy loops, see
> Documentation/process/volatile-considered-harmful.rst.  This can not
> only lower CPU power consumption or yield to a hyperthreaded twin
> processor, but also allows an architecture to mitigate hardware issues
> (e.g. ARM Erratum 754327 for Cortex-A9 prior to r2p0) in the
> architecture-specific cpu_relax() implementation.
>
> As the iopoll helpers lack calls to cpu_relax(), people are sometimes
> reluctant to use them, and may fall back to open-coded polling loops
> (including cpu_relax() calls) instead.
>
> Fix this by adding calls to cpu_relax() to the iopoll helpers:
>   - For the non-atomic case, it is sufficient to call cpu_relax() in
>     case of a zero sleep-between-reads value, as a call to
>     usleep_range() is a safe barrier otherwise.
>   - For the atomic case, cpu_relax() must be called regardless of the
>     sleep-between-reads value, as there is no guarantee all
>     architecture-specific implementations of udelay() handle this.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Arnd Bergmann <arnd@arndb.de>
