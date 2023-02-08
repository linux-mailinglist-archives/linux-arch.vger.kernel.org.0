Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40F68F05A
	for <lists+linux-arch@lfdr.de>; Wed,  8 Feb 2023 15:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjBHOIy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Feb 2023 09:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBHOIx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2023 09:08:53 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069977685;
        Wed,  8 Feb 2023 06:08:52 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B6DF55C02A4;
        Wed,  8 Feb 2023 09:08:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 08 Feb 2023 09:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675865329; x=1675951729; bh=t70pFotM08
        WZEEBXeymP/ERe9MBVmO+Zic4c4HkOq1c=; b=sVxAB3FBtgekBLKCJ64D0MHEAP
        08SY1mesXCcoeQRmjPuAXNa05+HnkJC31XOGFppjpdX3Nfua1DS37eF3mLiPDQr+
        DCqs1R5Hxyyq2HCKmfbt7SCjQYJe3lTEbGKgkDOdZxzUDj1OXwuyQYhxqwd+IMFb
        liSMFHL253EJXD47wMYzFV9rH1iN6blR4GUu5U4ai85/65A4gSs1I7ItcQTAmDOr
        swiXJbQoPd6uV5WnoTXNgRMD89YB0c5tOsoJhYX6PxgyFY0xVAMpVe/EgfAPoeBX
        NRxJQdE3XNWlJbTiQjb0MYnnMy/lW46g7QGNavpQw+KuQ68jv05VLEUrVwGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1675865329; x=1675951729; bh=t70pFotM08WZEEBXeymP/ERe9MBV
        mO+Zic4c4HkOq1c=; b=QVM6gcZ0kwqfmU9VP67qyufMc0U1If0SqoEVUMAkSZ7J
        izGXq07TfC1o9YC1OQLikVTd3su8YmN31k5Uo0yQAlvCyyHBXAg3ArnfO2HijzDu
        1rL+mdXd2ZcaVB6W+uLRmEBknN3IoDdEVfxEBk4MsmIUxRUCTk8NDZY6GvHHoaXV
        YtxrUm4u5gfSo5MN3yf379ZN6vElmaHuqfiruWd3csGu4ZYtkpQ1P4vwiSXEmiXe
        mEB2CP0p+/nNKzkDsHm4fHc++O3uBh7kbuKmXPKcraY9KOHs9HSP7V9erJmx+fCg
        9lTtz1Q2W/PRtDr76q3Sq7HHBf2otyAyGH4XzV/0Kw==
X-ME-Sender: <xms:8azjY3C92X_NzT7CTBBpeK7eSace79zvC2pMtSyGxiFOlNETU67FRQ>
    <xme:8azjY9hkHhvVoUglhg6jTUI0w8hL_Em59YDHzUufAbYKDGo3wn0_7wADBCTv-L8f4
    BME_y0nntUoPROHevM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehtddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8azjYylYCxms6e3--Yv9ZYzRNf7sZPjmjW4FzSzpM0SaCx7zcZdm0w>
    <xmx:8azjY5zLuPNPiJzNAmmwLZQtz6jWVOt7OdeM9iLLDSflRQBRmwuz4g>
    <xmx:8azjY8SdsASXnquEbY7CeDw6fL4z1e8ZNO1lYrtcf6FBdnHYw0NOwg>
    <xmx:8azjY7Fe8auy1qLrhURk4VYeySoQnoyp_F1GnEOfqwdZrzf3t0u05w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5F13EB60086; Wed,  8 Feb 2023 09:08:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <93dbbc7c-0e0d-4ae0-98fa-0d611ccd73d6@app.fastmail.com>
In-Reply-To: <20230208140536.2911880-1-chenhuacai@loongson.cn>
References: <20230208140536.2911880-1-chenhuacai@loongson.cn>
Date:   Wed, 08 Feb 2023 15:08:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] LoongArch: Make -mstrict-align configurable
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 8, 2023, at 15:05, Huacai Chen wrote:
> Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
> configurable.
>
> Not all LoongArch cores support h/w unaligned access, we can use the
> -mstrict-align build parameter to prevent unaligned accesses.
>
> CPUs with h/w unaligned access support:
> Loongson-2K2000/2K3000/3A5000/3C5000/3D5000.
>
> CPUs without h/w unaligned access support:
> Loongson-2K500/2K1000.
>
> This option is enabled by default to make the kernel be able to run on
> all LoongArch systems. But you can disable it manually if you want to
> run kernel only on systems with h/w unaligned access support in order to
> optimise for performance.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
