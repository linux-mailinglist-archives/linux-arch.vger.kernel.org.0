Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB0A68BE0E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 14:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBFNXg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 08:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjBFNX1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 08:23:27 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058751DBB8;
        Mon,  6 Feb 2023 05:22:59 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9DDAD5C00AE;
        Mon,  6 Feb 2023 08:22:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 06 Feb 2023 08:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675689756; x=
        1675776156; bh=RT1G3uIp5WZZ3c8eEMivJSXV4ld8jAT2lpHuPYCrzvA=; b=E
        ey8y1Ldnem1AngMxOeHSyi4dSAP2lnz5qtF8chI7CyMo8YFp5i95QNrNFeTgkBPU
        D//IBkdN50DjBqIrmWTqcHWYKzVbs6KDAlx0XNpnA/2Uvmbocjk8ildrYizPncyr
        21TYV9ogvt+sTgQOwsrzmDfBj30QR0LNmPVygzdax7pdVMptnEUEe7mtU0MRecRh
        jUV4birOAV6QgyyOt6xBVy8ElKcyb3srKy5/zt/c+GMTnO8n7UwXvia6O18aOGTm
        M2UjLSWad2/afvulhYUfuUloGA0745m/QUqZpJnz7MV0GvmFijGLqito53TzoLTb
        ruWUw8hLtxLAztEr8OKQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675689756; x=
        1675776156; bh=RT1G3uIp5WZZ3c8eEMivJSXV4ld8jAT2lpHuPYCrzvA=; b=j
        4r98C3i1WmULw0L0g+wmUCsidf83oXiBUi1yr9K/wgFiKaTfMNQ7oyaaOPjwlnL0
        QQCCadkI8iocypZKzuGGoxU2VEQw5/oD8N96pHLH1pB0eUlF/Rdhcjze7s97nYST
        dXPpE7pdTZcjbv6SGdHZeNY+vtaDAtAOzzmiUVo65bgHROa+fF3R1UxV6ulxHwY6
        a5YqrETyQ8L2CMlLEHeseoBCCsPWAwXINEuMgEt3JNBO6TPdnfENXrKmtFL3kNCF
        kJnIxibrJzP0pgFzyKIpvMo5lsFRm1GtPrPjOZRrMpI+PHYsFzulpM37iwBGGP1O
        szLZKd/rLEdXdtk2XPk2A==
X-ME-Sender: <xms:G__gY7kepHaVZmhwJbl_pi_h4KNpircvueKm20Vfdhw25XynZHtgLg>
    <xme:G__gY-1m_f_l8KRdAqceFakERZjFSGfKPIS4Gr0XNYepXZGfHiFkwAca8et60MOcp
    H9AlRmK4Kpo-fXOo6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:G__gYxoZOgn6y5foUs8RA9cVCEGPdpaz1jiMmnlnrE6eJUJNZf4z_Q>
    <xmx:G__gYzl4JRVRRCG99nshqA1J2fym1-y14S0jyeY12G0JrVnxucQ_aw>
    <xmx:G__gY50qxylxuNFDlYKVrkuke9iTS9duDzQHWObkD0uR7GKsqF70Ow>
    <xmx:HP_gYyJ8aSPCd5ZF9PeiKKVON05H1_CDkIgfhm5Q063a0Dk8pBhpew>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CD84AB60086; Mon,  6 Feb 2023 08:22:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-108-ge995779fee-fm-20230203.001-ge995779f
Mime-Version: 1.0
Message-Id: <b9f274ad-591b-40b5-9441-a45fe67b5b8d@app.fastmail.com>
In-Reply-To: <3b17d229-bad4-e6a0-9055-c585dd5a62e4@loongson.cn>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <5fc85453-1e2c-1f00-7879-1b5fa318c78a@xen0n.name>
 <5303aeda-5c66-ede6-b3ac-7d8ebd73ec70@loongson.cn>
 <b1809500e4d55564a1084a3014fb9603ba3d1438.camel@xry111.site>
 <3b17d229-bad4-e6a0-9055-c585dd5a62e4@loongson.cn>
Date:   Mon, 06 Feb 2023 14:22:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jianmin Lv" <lvjianmin@loongson.cn>,
        "Xi Ruoyao" <xry111@xry111.site>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Huacai Chen" <chenhuacai@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 6, 2023, at 14:13, Jianmin Lv wrote:
> On 2023/2/6 =E4=B8=8B=E5=8D=887:18, Xi Ruoyao wrote:
>> On Mon, 2023-02-06 at 18:24 +0800, Jianmin Lv wrote:
>>> Hi, Xuerui
>>>
>>> I think the kernels produced with and without -mstrict-align have ma=
inly
>>> following differences:
>>> - Diffirent size. I build two kernls (vmlinux), size of kernel with
>>> -mstrict-align is 26533376 bytes and size of kernel without
>>> -mstrict-align is 26123280 bytes.
>>> - Diffirent performance. For example, in kernel function jhash(), the
>>> assemble code slices with and without -mstrict-align are following:
>>=20
>> But there are still questions remaining:
>>=20
>> (1) Is the difference contributed by a bad code generation of GCC?  If
>> true, it's better to improve GCC before someone starts to build a dis=
tro
>> for LA264 as it would benefit the user space as well.
>>=20
> AFAIK, GCC builds to produce unaligned-access-enabled target binary by=20
> default (without -mstrict-align) for improving user space performance=20
> (small size and runtime high performance), which is also based the fac=
t=20
> that the vast majority of LoongArch CPUs support unaligned-access.
>
>> (2) Is there some "big bad unaligned access loop" on a hot spot in the
>> kernel code?  If true, it may be better to just refactor the C code
>> because doing so will benefit all ports, not only LoongArch.  Otherwi=
se,
>> it may be unworthy to optimize for some cold paths.
>>=20
> Frankly, I'm not sure if there is this kind of hot code in kernel, I=20
> just see the difference from different kernel size and different=20
> assemble code slice. And I'm afraid that it may be difficult to judge=20
> whether it is reasonable hot code or not if exists.

Just look for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, this will
show you code locations that use different implementations based on
whether the kernel should run on CPUs without unaligned access or
not.

      Arnd
