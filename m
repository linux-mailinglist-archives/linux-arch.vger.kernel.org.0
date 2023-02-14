Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B669667A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 15:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjBNOUz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 09:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjBNOUz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 09:20:55 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C5C0;
        Tue, 14 Feb 2023 06:20:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AA6843200302;
        Tue, 14 Feb 2023 09:12:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Feb 2023 09:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676383971; x=1676470371; bh=YRxaNRC4BH
        1ycBKeOawmXxp8krGFIkOuJJQE9+IMh0E=; b=dYZdi6z1BBW8qZ+1yTNZYVnlzu
        bd1rdhnWTBQ3winl855ARQim1KYx5d0+eSeo6xbILH8Dd+fYcX21cDZq7K4dym+B
        1lwEKlo3CnmrObFIGtwewAtKRMzsl73+xY6yGXw4ROSf2JNAVLfo0944TMJrOJlZ
        1tvTH+LTtEip7C0IQzn3doc2lo+gA72BqG/HXPologcAGGOGOUax47AkzoTZhd7g
        D2T/sxmJsk0xcjQvaoLyhMQwBm4UEFyETbAidyKWuUA/z8j6SmXY0dXJbmZNjLAq
        uBPdWjFbtnrjaivDuFbECbd8ILEgcMoOGSAuH1xj8fWbQgMPrq+YYQbJzS6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676383971; x=1676470371; bh=YRxaNRC4BH1ycBKeOawmXxp8krGF
        IkOuJJQE9+IMh0E=; b=plSFOhcc+E+PfxIEOh9EFkWLD7z1ZH8TqV/Yf3HqNFfO
        o0UDk42j6uzH+wqFQb5B5B5SJBG5Vp8XiBifhfV9EuPtwQXBmJ2NHelxCbZ5K3Hz
        RX8guFFpCTdjAgxtVPB3F6jfV+4TOUJeOoNh6wePzGygWyPBYQsHpUX5BP9niFFu
        0xWhf9DXO6X1PnyKoYsbQ8kCvJyRgmqj5i382pEybyGb7+1MO7FGgNmSD3TYvLE6
        InadPT5sQEdLtw3hir2yPkdkpAJYByGvuF9eRMMoXzjnAXyhvE8h5YKeIZ/QarqO
        JeNzq6/MysYlmsjyDmu2UcFPnWC13/9tKTDDjwfQ6Q==
X-ME-Sender: <xms:4JbrYx29CQPfpw-AgqwktggwgqlHPffduFo6v3RJtBvNrSzvWk4JRg>
    <xme:4JbrY4Gvv8-TVyRI4jC7uMOZm4YkOIdyEGTDePZDBYFgIHbhddWNXqNaOKIG7Lboi
    EUteCRBBWO12m5hj-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeifedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4JbrYx74l0zXhtWSNpvI4dS4YaZ55Y67l_qXYTMEt2738mj_yoEK4A>
    <xmx:4JbrY-0EKyp8u8qEEXCpn_eeS3oxLxI4W6aE7cD-a-nvZhHXp__L4g>
    <xmx:4JbrY0HLfeeNmGp9POEmduij6SzPY5T-Cn933nq1FDDJ5D4f6N_7pw>
    <xmx:45brY_lzf_KpqWMPuKF1Oe3JCZOy9uE8pCt1a8rc1FJks4JKxdk9Uw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 30FB2B60086; Tue, 14 Feb 2023 09:12:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <4e57a5aa-fd7a-4cda-90e3-6a02cfeb04c0@app.fastmail.com>
In-Reply-To: <20230214140121.131859-1-gregkh@linuxfoundation.org>
References: <20230214140121.131859-1-gregkh@linuxfoundation.org>
Date:   Tue, 14 Feb 2023 15:12:29 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, "Christoph Hellwig" <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] dma-mapping: no need to pass a bus_type into get_arch_dma_ops()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 14, 2023, at 15:01, Greg Kroah-Hartman wrote:
> The get_arch_dma_ops() arch-specific function never does anything with
> the struct bus_type that is passed into it, so remove it entirely as it
> is not needed.
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note: Unless someone objects, I would like to take this through the
> driver-core tree, as further bus_type cleanups depend on it, and it's
> stand-alone from everyone else's tree at the moment from what I can
> determine.

Nice find!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

It looks like the bus was last required in 2020 before commit
255a69a94b8c ("sparc32: use per-device dma_ops").

    Arnd
