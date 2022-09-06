Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2BA5AE45A
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 11:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiIFJgt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 05:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiIFJgs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 05:36:48 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8765818;
        Tue,  6 Sep 2022 02:36:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id ADE9B2B05DA0;
        Tue,  6 Sep 2022 05:36:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 06 Sep 2022 05:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662457003; x=1662460603; bh=WwyGQaUNdz
        34kN3ZEwGhlvGV8N4wKyn+GRkma4QpI40=; b=ayDZyhdLdFFsLnxnPOTIPrfa+g
        IGlccbe0skX9JA/gMcT2p/74mMQIVrnD9GAZeWJj0YlNScdnNvUvv/A/8iapIU2v
        vQSKgAoe1WCoWEyPbEeiM/Sde+iNgerPrNl6S08MKAcbCZDD1SF6CnxRuQDtbMAR
        8nx2qVeytiU3O43zJ/00Rh6ojBLGCPvT02sLOUBSxfNzc0UgQ0bnPMMtKmxow6GX
        9xbJaNhHYOM3VIvu1l4RsaiTb+7aDbOzdG9QR8QzSkEdyjCJmnCR9OCQu0CTfkeb
        mmjTxNeCJqc2MG1ZCgr4/hhEL0Ls3Egt/TAZ2/nx6ytZKlDdI4EFkrWCOv3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662457003; x=1662460603; bh=WwyGQaUNdz34kN3ZEwGhlvGV8N4w
        Kyn+GRkma4QpI40=; b=DT2vLJinkCjvRRDQ5bxVndxmIlQjnNKDsYrCBAawQVHU
        v3cPiO6yshRbEsZ5vfvdV4ACZp81rqDGDQDyUROlPra6cvQ3KXNQ97+NHe7bHzoc
        JLyBoT8UADaHo6HOEvx7Y5Y5Q350sXEORPWYSzspRPFvpL+Jximx2j+QC/qGvG1s
        OgL9s+uNa5UN1JTwtCpoH9O614zgpjFZaEiQ2WqjE7ZF0nyBfCtT7QEC5DbEMGHF
        xMBHf1dOZha8cyyBnsg6XayjKjTjOKxJUVzjT4GrtTSCyGOTCkQy2COnxJ6mJ/Nu
        Cl/ZvPxrkAiQLCIuNwMQBCnVkpWB2FNElRPs9A6vhw==
X-ME-Sender: <xms:qhQXY9Hd1SXIac_QFuuxSypgoDeAjPz5il3czcu1NVwKNUMWhvE80A>
    <xme:qhQXYyVU-0MPzMcUq2rXGkzp27tL-MhFKX6SIdK_XHP0huztSImlTG9LiUSpVDFX-
    xMwa29oRn_gtzDXt2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelkedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qhQXY_JpGF_vCnRBBKsxScB7E99_Nj_m2Hk1zXyEIlaPJEp2gYE3-A>
    <xmx:qhQXYzH0jziBM2nPXJm94AQ0Xjq3wvyI1XvsafdFUaRPT0VRyqCwrQ>
    <xmx:qhQXYzXDHkJO6q6CjodxrBPvI-8y_2USGi6ikn_Oxobl4WtO7u1z-A>
    <xmx:qxQXY-S29a3AwVoCjvtaVTDD28TEsOvsjN7iFtP70kBUbCBODMlgHuyv8HM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B498BB60083; Tue,  6 Sep 2022 05:36:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <e3e13c6d-8c50-4d7e-97f4-f948f5addbff@www.fastmail.com>
In-Reply-To: <CACRpkdZzBu4ZmQFvkiyD8ZefZL9FNNKdWgUYTzHhH0ttStUE6g@mail.gmail.com>
References: <20220831195553.129866-1-linus.walleij@linaro.org>
 <CACRpkdZzBu4ZmQFvkiyD8ZefZL9FNNKdWgUYTzHhH0ttStUE6g@mail.gmail.com>
Date:   Tue, 06 Sep 2022 11:36:22 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH v2] sparc: Fix the generic IO helpers
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

On Mon, Sep 5, 2022, at 9:36 PM, Linus Walleij wrote:
> On Wed, Aug 31, 2022 at 9:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> This enables the Sparc to use <asm-generic/io.h> to fill in the
>> missing (undefined) [read|write]sq I/O accessor functions.
>>
...
>
> This might be a candidate for the arch tree as well, I have seen that most
> code merged into arch/sparc these days seem to come through other
> trees than the sparc tree, which has not been updated for 18 months.

Sure, just send me the ones that nobody else has picked up
as a series.

     Arnd
