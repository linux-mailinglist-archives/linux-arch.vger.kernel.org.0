Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E29F5BAA66
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiIPKa7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 06:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiIPKaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 06:30:10 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB086266F;
        Fri, 16 Sep 2022 03:17:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B34DB580F46;
        Fri, 16 Sep 2022 06:16:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 16 Sep 2022 06:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663323406; x=1663327006; bh=dYvenO6eXv
        Bq73VVEqDVoQq9L+xnxo4snht2mJIMSPU=; b=oOKD5VOsSUwrEVicIlM7sF16nO
        4AMrRy8avO8Y/atfhdy1sNwDZMmksKMjThncm/XsqZgDarqcTOulb2NeN6wiATkC
        60oITWKPoowLu6Pik7dcjUTt//ejrceRgq1BKL8bV74Ju2scScI4IdFU5lTv0Lxq
        yVl+p5vpEqaTxEXEhwTBq455ZviGEaYro+p0Sgo4o99TvuIi+WNtxSzlnwoLJ6CP
        I18BvmfGIu+IbXEFMuV7VJP4nWRJgs/tbUUSQGq6IZ2PCSCF4RNuzeie+bf02qup
        6v7f8vQ3R5kd5r6rQCqbidyXa4e1WMkcEI0U7TJqDOmlqm1tE9fzdoK/c5UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663323406; x=1663327006; bh=dYvenO6eXvBq73VVEqDVoQq9L+xn
        xo4snht2mJIMSPU=; b=nxekw7mZItQ0orKllF9S6LPYMGcnMTeHoE+yO7ydYMBP
        Tnx4jK5Ok2569UUXgo9/84bMLMB10SiZf5XzxEZTqIey6jeRmdf9Yi39v0lD76AG
        Y53SjICLCzcq2wOnXB3EprPRmmVj/VmM5iHkpIdlM3vzhBV7youibT0yjN/Je9OK
        vitS6zb5hSaNnJIO0/gOnwc4Alt9d5kvR1XXdOn7Vyh1PlYmTWoO+qKsXCj1fYSu
        qBQV3NnXP37otn9cqxp6P1dLP1tm1ahc6hyzyqRS8GGc3kyXIVZ3s+Ph3aeN4hT7
        XXM0yR+7om4L7FonuXx5wA2v3wLGkb1eBz5kV6H90g==
X-ME-Sender: <xms:DU0kY_1vOOrZJWaAoTi3cJ29riwwJay_VlGpfTOXMjaaz_8E1h3ysg>
    <xme:DU0kY-EY11nQu20uqKMM_6zZmSQEnFpyH2lnvRmdbzCVswa-E83kxPYC7xC1dRpDt
    QXT9GdIUBcOFPaLAis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvtddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DU0kY_4VvIXukk5YIvnF4Pytas3ckfdllPQahYjMT9o7ucssXARlPg>
    <xmx:DU0kY0394rtmtk6VV_pC0QypU3SuBTu_IVgDN-aLAX7FL_AoS7M48Q>
    <xmx:DU0kYyHMeHRMZj7vQwPrZFvhudB6J8zP7T55VfCGE6Axg5ruFDyFNQ>
    <xmx:Dk0kY1ALlj5hOGLM3kQpvzcvDFSAjDmHex2EddaOEG6LId0lCzQ-lA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 67159B60086; Fri, 16 Sep 2022 06:16:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <e5433179-c300-482e-9dad-b1b15c56970a@www.fastmail.com>
In-Reply-To: <CAAhV-H7fiyq7tKJw3CsYDBWjJu89oBJqgNZLxgd+UQE=+X6Czw@mail.gmail.com>
References: <20220818040413.2865849-1-chenhuacai@loongson.cn>
 <CAAhV-H7fiyq7tKJw3CsYDBWjJu89oBJqgNZLxgd+UQE=+X6Czw@mail.gmail.com>
Date:   Fri, 16 Sep 2022 12:16:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@kernel.org>,
        "Huacai Chen" <chenhuacai@loongson.cn>
Cc:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Jianmin Lv" <lvjianmin@loongson.cn>
Subject: Re: [PATCH] Input: i8042 - Add PNP checking hook for Loongson
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 16, 2022, at 11:53 AM, Huacai Chen wrote:
> Ping?
>
> On Thu, Aug 18, 2022 at 12:04 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>>
>> Add PNP checking related functions for Loongson, so that i8042 driver
>> can work well under the ACPI firmware with PNP typed keyboard and mouse
>> configured in DSDT.
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>  drivers/input/serio/i8042-loongsonio.h | 330 +++++++++++++++++++++++++
>>  drivers/input/serio/i8042.h            |   2 +
>>  2 files changed, 332 insertions(+)

This looks like you are just duplicating code from
i8042-x86ia64io.h. Can't you just use that version
directly?

      Arnd
