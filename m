Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A658767746
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 22:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjG1U5G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjG1U5F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 16:57:05 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA57E69;
        Fri, 28 Jul 2023 13:57:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A1E6D5C0042;
        Fri, 28 Jul 2023 16:57:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 28 Jul 2023 16:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690577820; x=1690664220; bh=Ey
        7an+eYR/EJFsqkCsdCEc8Gpv7n/y5ox8OPRdihLJI=; b=J27Ci6eOLXZMwc/xdV
        k4/V2Ujs43ozjAJSJfzx33h29LYVAIsS3r2RJin3T/aW9oDcdd1RmPgh7hHplotG
        ao4ExzZ+Elqt0PbHK3Vwpar0x2Xmc2UCfGmd9fLSKLLisrOaXsiEwdG5b2JHXKt+
        trvJN84Kz9wP971MY1lA3BBjQeeyG2oSSDzot3+ap9eRp7uEKFLnlROvX1RyyOkQ
        cPGLOYSXKF2fUtPeIw12+zug1HWozIuI7m5ocf203YAa3ZVbwLL7SuHuIeBvEwy1
        nvlcDVRyTjyvo5hL1QEan/7GpZf+ZIRBcKTAPl0Kj8QzxbfeY/jlO1r1V5TxEC0+
        ky/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690577820; x=1690664220; bh=Ey7an+eYR/EJF
        sqkCsdCEc8Gpv7n/y5ox8OPRdihLJI=; b=jRJzUyuQYnTKWqqxrP/jCtF5Nsa3F
        Z59ZYd6uvIJ2NsV4sighrm6TCgeOo4hzicUeS4qEK+Vc+ptBiyjvc/iA+cYC7qv6
        VqOpjVspD8FHl2t86zbctNl4U6KKcV/7akn+jkek9JdiTIerAcCZWdWGRztGSzTD
        QXBS6NvyFWX057/XWOQkz+PrLRXQCf6pn1xfl0QV2XjV4QlfAXvRdgYWDkE/mzRD
        NEKr+b+vfaWojiojrIpnd6m19hA63OKiKjUnNLjWYYllRHHTX0IUURnuGkJ6VsMO
        XihH+C35mv6VdKTqMaysBbrtnOmshMXX5yufdrvqln2HCjtpBrM7IYeUg==
X-ME-Sender: <xms:myvEZE3Kf0PQjnUrKwFBbfhjCs9alz8rvv8ujuU6sPyCqxIxrKFZRA>
    <xme:myvEZPFsHBpgijMZ8HW7DHJccCK07jIYm0mAqG_Jj7RYocsyKSpYoRlSvRbgK3z_r
    D3bOsCQ5MZXNNhuvIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeigdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:myvEZM5Ahws0Z6Fti2HV7CL8kSy_SrbZMY_Sbxx9dXQfT347gKfP-Q>
    <xmx:myvEZN0XmxO5j6XNcdHCoRnudYI_QAaQeYPj4xFi6joKwRoWSUVFiA>
    <xmx:myvEZHF7eZKaSta7Ug36jfJ0rnDDOlRQg4ULRxeVexvvBQiC87wrIA>
    <xmx:nCvEZNb439Dex4aaWQw5WdvGXT_tu2dwlKreo-BLQHj5EG1ucwKbTw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 49564B60089; Fri, 28 Jul 2023 16:56:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <a2fa1a31-e8bb-4659-9631-398b564e7c2b@app.fastmail.com>
In-Reply-To: <20230728173103.GA1299743@dev-arch.thelio-3990X>
References: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn>
 <1687443219-11946-2-git-send-email-yangtiezhu@loongson.cn>
 <20230727213648.GA354736@dev-arch.thelio-3990X>
 <1777400a-4d9c-4bdb-9d3b-f8808ef054cc@app.fastmail.com>
 <20230728173103.GA1299743@dev-arch.thelio-3990X>
Date:   Fri, 28 Jul 2023 22:56:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nathan Chancellor" <nathan@kernel.org>
Cc:     "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 1/2] asm-generic: Unify uapi bitsperlong.h for arm64, riscv and
 loongarch
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

On Fri, Jul 28, 2023, at 19:31, Nathan Chancellor wrote:
> On Fri, Jul 28, 2023 at 01:00:30PM +0200, Arnd Bergmann wrote:
>>
>> of the uapi version. The sanity check in the kernel-side header
>> is intended to cross-check the CONFIG_64BIT value against the
>> __BITS_PER_LONG constant from the header.
>> 
>> My first guess would be that this only worked by accident if the headers
>> defaulted to "#define __BITS_PER_LONG 32" in and #undef CONFIG_64BIT"
>> when include/generated/autoconf.h, but now the __BITS_PER_LONG value
>> is actually correct.
>
> That seems like a reasonable theory. I am still busy looking into other
> things today but I can try to double back to this on Monday if you don't
> make any progress.

I tried reproducing this today on arm64 Debian with linux-6.5-rc3
and clang-14.0.6 but I don't see the problem here. With 'make V=1'
I see command for building scripts/sorttable is

clang -Wp,-MMD,scripts/.sorttable.d -Wall -Wmissing-prototypes \
 -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11   \
 -I./tools/include -I./tools/arch/x86/include -DUNWINDER_ORC_ENABLED \
 -o scripts/sorttable scripts/sorttable.c   -lpthread

which does create an arm64 executable but includes the x86 headers,
which is clearly a bug by itself, it just doesn't trigger the problem
for me.

I also noticed that your command line includes CROSS_COMPILE=x86_64-linux-
rather than CROSS_COMPILE=x86_64-linux-gnu-, and I think we've had
problems with that in the past, when "clang --target=x86_64-linux"
fails to find the glibc system headers.

     Arnd
