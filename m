Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3404176D6AA
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 20:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjHBSSj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjHBSSd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 14:18:33 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5832103;
        Wed,  2 Aug 2023 11:18:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 498BF3200754;
        Wed,  2 Aug 2023 14:18:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 14:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1691000302; x=1691086702; bh=Sm
        MQ6kJN4Wc3hcGgVxP+bMiAcMtZCScse6Dh72DQZNY=; b=RS2lZDrqYqL/YCzd28
        LQCEyYTBpZ9AsOx0epUPG7MNbrjDFXtbn2z9kisIrwzEFRddS8DfdcM4pINxZ//S
        5OZE92Kstnns7ub7HeGv0fpTJBX8OtBSFKJpxGDUGHF8XRBobYAx/rMNGnyCjym7
        YMESHJFdKICPLHtuv6ikqbcVe3W7vyxG+OaoTho+CZi9nYIvCwjRJdKhf57NElLn
        jPBvbA2kRk8Sx+ttZ0omoSfqXeXMjP/gBLwz+9y5dTYLnxLIhGtXkGiqnOpt9v5m
        43bdfIu9/HZyez1rthW6GvPxKTxX20wVPxAZiNEZjpSFXabaFM6wVQdH0mFK2RUy
        vAKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691000302; x=1691086702; bh=SmMQ6kJN4Wc3h
        cGgVxP+bMiAcMtZCScse6Dh72DQZNY=; b=xi6gI5pRORVFWj2yXsvH8AwNVpnA9
        A5a1Fyq0dj4s0Io3/eZsSzAY4OFS64wWHck4CM0gPb81+pJadaLf00nsSoPmHJGI
        yqdSVZAjgY8ehq3RhWDC8UYbVMzAjmVMcHBwywcIOa99Qy8QIUW+xbMGwUSFU/Hs
        FsKW2jX4AqemuoL3171ZDDO0JyfwO5hM/zB1YSrSGeShaHj08n4uujRORratQFhl
        PdYVWLxvY+XY+sg3MZG5ljs1mFykrJFTKazhDfBDkPHOoXt9PCcCQyRrdFxl5fzU
        UzHNPG8eosDSYySxkWrL7sJIGGLzV7IY67xLvNFuQEpYFlAws4/AKP5Bw==
X-ME-Sender: <xms:7Z3KZCgwPzHXYeemGEu9Qyj5ErRzXXH7EmceR0J370__O_AtKGSjjQ>
    <xme:7Z3KZDCNARqZ3h2BImuDxS4dIQevS2UNF-oTbZUqXfYBpaiOyAILrbSyW8-38C9LE
    EfCTFet5V4DvB9mokg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7Z3KZKGVIjfLGAQDf86B3N3SiiyttqfRRZrEnPxSrvNnVIeMTrgxGQ>
    <xmx:7Z3KZLTHd1_k1KnwARlCRCdU78UDy3la_61mG4Ce8f6O-CyIIGuYXA>
    <xmx:7Z3KZPyDn7GRtzeLKBJWaBVSepGHmVV8VtgKVnt7SFKOubhKGBQC1Q>
    <xmx:7p3KZGkolqmrhhVrqabX3Jmlg1oqsm7SuSv25c8SSN5llD02sVBiBQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9F7D1B60089; Wed,  2 Aug 2023 14:18:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <dd48b4ff-1009-41fe-baf5-be89432c5d28@app.fastmail.com>
In-Reply-To: <CAHk-=wjmWjd+xe88cf14hFGkSK7fYJBSixK8Ym0DLYCa+dTxtg@mail.gmail.com>
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
 <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
 <20230802161553.GA2108867@dev-arch.thelio-3990X>
 <CAHk-=wjmWjd+xe88cf14hFGkSK7fYJBSixK8Ym0DLYCa+dTxtg@mail.gmail.com>
Date:   Wed, 02 Aug 2023 20:17:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Will Deacon" <will.deacon@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>
Cc:     "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero regardless
 of endianness
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 2, 2023, at 19:37, Linus Torvalds wrote:
> On Wed, 2 Aug 2023 at 09:16, Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> We see this warning with ARCH=arm64 defconfig + CONFIG_CPU_BIG_ENDIAN=y.
>
> Oh Christ. I didn't even realize that arm64 allowed a BE config.
>
> The config option goes back to 2013 - are there actually BE user space
> implementations around?

At least NXP's Layerscape and Huawei's SoCs ended up in big-endian
appliances, running legacy software ported from mips or powerpc.
I agree this was a mistake, but that wasn't nearly as obvious ten
years ago when there were still new BE-only sparc, mips and powerpc
put on the market -- that really only ended in 2017.

> People, why do we do that? That's positively crazy. BE is dead and
> should be relegated to legacy platforms. There are no advantages to
> being different just for the sake of being different - any "security
> by obscurity" argument would be far outweighed by the inconvenience to
> actual users.
>
> Yes, yes, I know the aarch64 architecture technically allows BE
> implementations - and apparently you can even do it by exception
> level, which I had to look up. But do any actually exist?
>
> Does the kernel even work right in BE mode? It's really easy to miss
> some endianness check when all the actual hardware and use is LE, and
> when (for example) instruction encoding and IO is then always LE
> anyway.

This was always only done for compatibility with non-portable
software when companies with large custom network stacks argued
that it was cheaper to build the entire open source software to
big-endian than port their own product to little-endian. ;-)

We (Linaro) used to test all toolchain and kernel releases in
big-endian mode as member companies had customers that asked
for it, but that stopped a while ago as those legacy software
stacks either got more portable or got replaced over time.

Many Arm systems won't boot BE kernels any more because UEFI
firmware only supports LE, or because of driver bugs.
Virtual machines are still likely to work fine though.
I'm fairly sure that all Arm Cortex and Neoverse cores still\
support BE mode in all exception levels, OTOH at least Apple's
custom CPUs do not implement it at all.

     Arnd
