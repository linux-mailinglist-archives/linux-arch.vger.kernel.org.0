Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCEB5AE1D5
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiIFIGA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiIFIF7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 04:05:59 -0400
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 01:05:57 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA42419BC;
        Tue,  6 Sep 2022 01:05:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 3C1CA2B05D74;
        Tue,  6 Sep 2022 04:00:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 06 Sep 2022 04:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662451200; x=1662454800; bh=brj1szeKly
        TAOSv7Zty/61H4zbDvgxDc58EskaoF9D8=; b=JEby4DAqHDW268kSZHQAG4RCc7
        JZ7IJNmvcmX9Bfl6E4/+aqa0KlPGGL4KEcHnfZUQeNir/llmwQrhHJoZu1ifhY7q
        IqFYdinvuj5t2OFKW4fZsXetbg4sxKRueCWQK1w0taqjbHB+QhoVoIoznZ5VPtYB
        x9fvMSttkiy4mF7c33B7m4ItiKZSIO8dNQBNkJAl5PVfeVXb+r+laR2DNVqSmdxC
        YDv5Arg7ujNsK9SbGPg3SZdATJ0YPv5wBxFBZJgZZQhmxQm9DF18sUgL9pl/uPE4
        7Wm0lGdbJBYrHPngv2Zrpth1lIfsVG0e98rTeq3dhrShoRtuXktyENvuNHpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662451200; x=1662454800; bh=brj1szeKlyTAOSv7Zty/61H4zbDv
        gxDc58EskaoF9D8=; b=M+ZY/tpcrSlzy+g+89e5VGGKxFslP5eJ509V72bjFkk8
        SjkfyAdFQuSXrPmm8GXr2fER4Tc0QsTOEONpJ0kMDSDPMkLY36Bn3AR9bar6x5Zd
        S9xpvVRobXhnfJqWlj+ZksO5zAqJpZXZLPE1pYZtNS4X/txyg0BAmd/NnB/e6GsL
        w7Xj4Z1249lF617MVCNakKk7FDbJHijD70URv31uz4IQK3G9aLb62Qalvx6DLpru
        IgVCqtpRc5tYg8cZ1BkeM4jRH8snLEEmoyNOPGDNW0XpQSzsHuZDYGTlSU2pJccb
        j1e0TWLte/k9CC352Xzo9Y7p8NEkVROLBt/S93bdsQ==
X-ME-Sender: <xms:AP4WY4kUZWTMXVdq95ZS7HbSMKzyldu526Xe65exvB3A6ZEGnLzSSw>
    <xme:AP4WY33wvpNch4AWDLlkyCBXTB7hyDslobpJEyvm1J0GEhMC_8L3IFexchY8taKVe
    mLEFwEsmEnjimSX5Po>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeljedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeetfeefuddvfedvgeefgfdtveeftdejteegteefjefhleejgffhhfetheff
    vdeihfenucffohhmrghinhepthigthdrihhtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AP4WY2oL-YQxpb95jLm_8iD54z78i_CUKdg8U4g4xNznGs163wl3NA>
    <xmx:AP4WY0mE5hQlXgRBGmOU7J4gBSPZJLV-3oYuCtLkc_vS0HW4mv5H9A>
    <xmx:AP4WY22tj36-DRzC5bLhq5aqhfEglc_nRvENkedrKOahmVQjXFmUYQ>
    <xmx:AP4WY79vxG75azduTBMAyOsc_V21Bsg_PDe-BwKvad2P2LiTT0V8Q3CAllI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 54C57B60086; Tue,  6 Sep 2022 04:00:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <f76020e2-e8bd-4f75-a697-3d6ec6665969@www.fastmail.com>
In-Reply-To: <20220906061313.1445810-9-masahiroy@kernel.org>
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-9-masahiroy@kernel.org>
Date:   Tue, 06 Sep 2022 09:59:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] kbuild: remove head-y syntax
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

On Tue, Sep 6, 2022, at 8:13 AM, Masahiro Yamada wrote:
> Kbuild puts the objects listed in head-y at the head of vmlinux.
> Conventionally, we do this for head*.S, which contains the kernel entry
> point.
>
> A counter approach is to control the section order by the linker script.
> Actually, the code marked as __HEAD goes into the ".head.text" section,
> which is placed before the normal ".text" section.
>
> I do not know if both of them are needed. From the build system
> perspective, head-y is not mandatory. If you can achieve the proper code
> placement by the linker script only, it would be cleaner.
>
> I collected the current head-y objects into head-object-list.txt. It is
> a whitelist. My hope is it will be reduced in the long run.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

The scripts/head-object-list.txt approach feels a little awkward,
so overall I'm not convinced that this is an improvement as long
as there is no final decision for what should be done instead.

If the .head.text section approach works, maybe convert at
a minimum the x86 and arm64 architectures to provide an example
of what it should look like in the end, otherwise I doubt that
any architecture maintainers are going to work on removing their
architectures from the head-object-list.txt file.

> +arch/alpha/kernel/head.o
> +arch/arc/kernel/head.o
> +arch/arm/kernel/head-nommu.o
> +arch/arm/kernel/head.o
> +arch/arm64/kernel/head.o
> +arch/csky/kernel/head.o
> +arch/hexagon/kernel/head.o
> +arch/ia64/kernel/head.o
> +arch/loongarch/kernel/head.o
> +arch/m68k/68000/head.o
> +arch/m68k/coldfire/head.o
> +arch/m68k/kernel/head.o
> +arch/m68k/kernel/sun3-head.o
> +arch/microblaze/kernel/head.o
> +arch/mips/kernel/head.o
> +arch/nios2/kernel/head.o
> +arch/openrisc/kernel/head.o
> +arch/parisc/kernel/head.o
> +arch/powerpc/kernel/head_40x.o
> +arch/powerpc/kernel/head_44x.o
> +arch/powerpc/kernel/head_64.o
> +arch/powerpc/kernel/head_8xx.o
> +arch/powerpc/kernel/head_book3s_32.o
> +arch/powerpc/kernel/head_fsl_booke.o
> +arch/powerpc/kernel/entry_64.o
> +arch/powerpc/kernel/fpu.o
> +arch/powerpc/kernel/vector.o
> +arch/powerpc/kernel/prom_init.o
> +arch/riscv/kernel/head.o
> +arch/s390/kernel/head64.o
> +arch/sh/kernel/head_32.o
> +arch/sparc/kernel/head_32.o
> +arch/sparc/kernel/head_64.o
> +arch/x86/kernel/head_32.o
> +arch/x86/kernel/head_64.o
> +arch/x86/kernel/head32.o
> +arch/x86/kernel/head64.o
> +arch/x86/kernel/ebda.o
> +arch/x86/kernel/platform-quirks.o
> +arch/xtensa/kernel/head.o

Seeing that almost all of these have the same naming
convention, another alternative would be to have a
special case exclusively for arch/*/kernel/head.S and
make that either an assembly file that includes all
the other files from your current list, or use
an intermediate object to link head-*.o into head.o
before putting that first.

     Arnd
