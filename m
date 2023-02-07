Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0015268D451
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 11:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjBGKdj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 05:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjBGKdi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 05:33:38 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB5C2E81D;
        Tue,  7 Feb 2023 02:33:24 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BC1685C00AC;
        Tue,  7 Feb 2023 05:33:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Feb 2023 05:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675765994; x=1675852394; bh=z58s3tlmYT
        du/UcxWCsndVijZJpk5Ys9RAEY6puhIII=; b=pjRvaaWe7VbSIaKMXOhsl14NTK
        DTj49AYdV8RW27oy/CBQ60Mvo3reQ+tJXY6R9JMvDAVJFpVBWhADM3w8kqwp8ycj
        biD19/+OZQEyAMTAdUrjslttS15dHl2bZcD8IZ94eW2dL9DnBRsdCHBoX7xmx03X
        cyWuGwOP3Mdcr1SwMmBOADeVPriWNZPiJ2AQbPd0HZl8F3a9qj932I8m4ZGjtbWR
        93WSZS8MHk1u/Hk0U0+TKdCg89o4FNPWC2sJVDDAqx7RAw+IUBL7QXb54CmPNuAN
        0RlhSyijyX3c9dGqghXS1jYzNgq4Nylb05VQbvbsbbG99PzhQBTFciFdNFJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675765994; x=1675852394; bh=z58s3tlmYTdu/UcxWCsndVijZJpk
        5Ys9RAEY6puhIII=; b=XNeb286ist6v9OTQZNUUCDI9MaSTgpyOli6yl0MEaYiT
        J0kUPJyo+yx+Rd8AYFHHZwhdOt/F+GroZqQksMKZf6UwVELxglSKgPgRSdybP+xi
        6hR/KOlHUFXf+0yyV+geVu/4cWdLIueTGVBlTLMeYuFWr7y0pXUyQbqnzfRLOVm1
        5WjKdgbLpd3rnTMxs0v/XuiT4uTD8Nbr3PiNzwqkQE3mYRouyzkjG7zDBt/iGVjS
        bB+1TS4TKEX51i8zRaSZgFBdo+isX/QXwz7BwsW3c234H5CBBSvLArmcoKx62iSS
        v0/uS3K4CB+grkrpeV1D6duwp4eG33Xp4m7Z0NQAFg==
X-ME-Sender: <xms:6SjiY7Y4bpk4LdHTBwVkI1hF29_G4Vxv7RlViXlIt15-JoIMl__Ydg>
    <xme:6SjiY6bFn75IkjLqjU2pTSns4pzZxbycq2YfOsD7KuAXTUG-8FaCq3hHEIgW1hLpP
    Z7F_9HtxLEs2KMMbaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6SjiY9-jAtaO-crySt3zntrQPhfzRgGGFXeixPtRSjsoutV1-ARqGg>
    <xmx:6SjiYxqM0TZ8qUp-iWa4cHu8CSl_z04FkpO9fxmjsbABn7Es4eD8og>
    <xmx:6SjiY2rHU4tX21q6Tm-jyCjjjC8msdrmjQuUhMITUgSTefEoGyLg2w>
    <xmx:6ijiYydCrnSvu2H37oaL9b8Gq8EaGIS7qOcq8cahW32_sXWmt-eRQw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CF7D0B60086; Tue,  7 Feb 2023 05:33:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <dcd17646-4b8d-447b-bd85-c66c4a7b2cf4@app.fastmail.com>
In-Reply-To: <379bcb55-f75d-02ce-a51b-467e21ade5a3@xen0n.name>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <363cd09a5dcb4deab21f58c19025254f@AcuMS.aculab.com>
 <CAAhV-H7Mz1Z5Bo59tq5VRSUx-N39axeiG7xZs2Szn6nuOxgZfQ@mail.gmail.com>
 <9936da8f577842b8b5edafcdc69dc2d1@AcuMS.aculab.com>
 <560d73a8-2f2a-4844-44ff-afffad9c8694@loongson.cn>
 <379bcb55-f75d-02ce-a51b-467e21ade5a3@xen0n.name>
Date:   Tue, 07 Feb 2023 11:32:55 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "WANG Xuerui" <kernel@xen0n.name>,
        "Jianmin Lv" <lvjianmin@loongson.cn>,
        "David Laight" <David.Laight@ACULAB.COM>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
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

On Tue, Feb 7, 2023, at 06:24, WANG Xuerui wrote:

> (Yes I've partially changed my mind after seeing Arnd's suggestion that 
> indeed some optimized codepaths can be enabled if we can know the CPU's 
> unaligned capability at config time. Now I'm in support of making this 
> codegen aspect tunable, but I still think keeping the default as-is 
> would be a better idea. It won't regress or surprise anyone and embedded 
> people's convenience wouldn't get sacrificed.)

I agree the default should always be to have a kernel that works on
every machine that has been produced, but this also depends on which
models specifically lack the unaligned access. If it's just about
pre-production silicon that is now all but scrapped, things are different
from a situation where users may actually use them for normal workloads.

Is there an overview of the available loongarch CPU cores that have
been produced so far, and which ones support unaligned access?

     Arnd
