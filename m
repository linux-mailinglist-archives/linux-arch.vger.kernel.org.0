Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76F68DA31
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 15:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjBGOLS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjBGOLR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 09:11:17 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B395;
        Tue,  7 Feb 2023 06:11:16 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B62FE5C02DD;
        Tue,  7 Feb 2023 09:11:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Feb 2023 09:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675779073; x=
        1675865473; bh=Jg96Pxt0yVVxL3vYZzmFe2GcsQj9/OICvdYXHXfWT1A=; b=I
        xwZuxP9HsbfeE17W3A/TXYD6TMxCg9dot7t7TcHHPQKvABN+VR3k98AiRhAL4ibq
        /0jWbC74TOAEh5+C8zo7/4AdkdQaBKs87mTWD2ZXjcI58i6uyYl+D+BQqEu+RHPu
        s5VeuPsfjIqPdzA0W0hV+UdkF+FkpPVWb6XFsB1mxismre6S/+Rvvo/dnOFN1Rx1
        s5oKiKHVvSAXPIbTc87IWxapn6hAH3X6k4kpLcwF9yTUu6PXopfzsKitBLmpOp1L
        mUtz0IXLP09E9hKx98zOcnpyUAG1wvq8EdaJwQYMxghnAdS7f1rg/zrVX7DKfdnA
        rZGgjmAzMCNbchP0INZlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675779073; x=
        1675865473; bh=Jg96Pxt0yVVxL3vYZzmFe2GcsQj9/OICvdYXHXfWT1A=; b=P
        HtcdiksJa+6CclsnucdpMNvJpos/aydRwZaZ2LD2dFXoLQPl3GYm5bfW3OTsyoEq
        jpoYwqXx3Fi6dsXEB2pq5yzbijAD9jtm3E/FOCHRa5/Vss2VkRTCgyOr4j8QxCjT
        I8LvYCf91E1A9ScHHZIPSiPJw+9TnZriLRRT2947VkLXhkEfysY0apnwas74boEL
        /NtWgzjM5AFWILWqNG0omI/G5hcWhFvW4VGjNAhc1JHPk2BUubN8O6bvTEhXIRyD
        HKpPQSAT1zv04rT7Te8mg1zXQLKRGxN0Wa5TV4wkoKMRGfKG6LgONpWBsipnpupk
        E9pTnoRaT5ueALDNmSttQ==
X-ME-Sender: <xms:AVziY_657lxuHj7GDAuZ12tw6-kjveHJAyDiQ-cqU9r8CB69BkZV8A>
    <xme:AVziY06B3Q4mPHbqY3RldDzuVbmMJZplOYVCHo-sMXvO4IaKnxu0xg-9wnhBPLxt3
    1BVgB1lEvMBWTBUc3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:AVziY2d6xCUGijZd5Bh2O7nXX512G2GGvZYk34xW6AtCpc5aJQbPAA>
    <xmx:AVziYwIUeAgZSFpKsQ4gGLP5RxX4PEuYpI6bc9k_HGNc3CDxsLFbqA>
    <xmx:AVziYzIVNuciWb5ZDl4szfEf6Hu47rLHp-fhkNJJRK80vs_cFg7itA>
    <xmx:AVziY6_KMm5k_xYbEEPzkOtdPt6gfbCIcuLjoRhasd7ghLh5TsdBSA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F1B01B60086; Tue,  7 Feb 2023 09:11:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <59745bb8-00d0-4fa3-b75c-511db310ac16@app.fastmail.com>
In-Reply-To: <924aa802-410d-a85c-b623-7ca30d15c637@loongson.cn>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <363cd09a5dcb4deab21f58c19025254f@AcuMS.aculab.com>
 <CAAhV-H7Mz1Z5Bo59tq5VRSUx-N39axeiG7xZs2Szn6nuOxgZfQ@mail.gmail.com>
 <9936da8f577842b8b5edafcdc69dc2d1@AcuMS.aculab.com>
 <560d73a8-2f2a-4844-44ff-afffad9c8694@loongson.cn>
 <379bcb55-f75d-02ce-a51b-467e21ade5a3@xen0n.name>
 <dcd17646-4b8d-447b-bd85-c66c4a7b2cf4@app.fastmail.com>
 <924aa802-410d-a85c-b623-7ca30d15c637@loongson.cn>
Date:   Tue, 07 Feb 2023 15:10:54 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jianmin Lv" <lvjianmin@loongson.cn>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "David Laight" <David.Laight@ACULAB.COM>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 7, 2023, at 14:28, Jianmin Lv wrote:
> On 2023/2/7 =E4=B8=8B=E5=8D=886:32, Arnd Bergmann wrote:
>> I agree the default should always be to have a kernel that works on
>> every machine that has been produced, but this also depends on which
>> models specifically lack the unaligned access. If it's just about
>> pre-production silicon that is now all but scrapped, things are diffe=
rent
>> from a situation where users may actually use them for normal workloa=
ds.
>>=20
>> Is there an overview of the available loongarch CPU cores that have
>> been produced so far, and which ones support unaligned access?
>
> So far, produced CPUs based LoongArch include 3A5000, 3B5000, 3C5000L,=20
> 3C5000, 2K2000, 2K1000LA and 2K0500, where 2K1000LA and 2K0500 are=20
> unaligned-access-unsupported, and others are unaligned-access-supporte=
d.

Ok, so these are actually some of the newer (though low-end)
implementations that require the workaround, not the older chips.

In this case, I think both the kernel and toolchain need to default
to -mstrict-align, unless someone specifically asks for the variant
that can support unaligned access. The kernel option could be
guarded by 'depends on EXPERT' to ensure that this is not set by
default.

To be sure that this is set correctly, the
arch/loongarch/kernel/unaligned.c file should also never be included
when EFFICIENT_UNALIGNED_ACCESS is set, to ensure that any attempt
to run such a non-portable kernel on 2K1000LA results in a
a kernel panic rather than silently fixing up the unaligned accesses
at a huge performance cost.

    Arnd
