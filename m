Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B870F767D09
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jul 2023 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjG2IBm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jul 2023 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjG2IBl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jul 2023 04:01:41 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C71F26B8;
        Sat, 29 Jul 2023 01:01:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C5A83320084E;
        Sat, 29 Jul 2023 04:01:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 29 Jul 2023 04:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690617698; x=1690704098; bh=it
        VztlhsdL+TgE9iBCuYgyv0QZn1iL7TtRpdZyaCyBM=; b=K3GKtYlR7bONoMs4wU
        CtMwcBikuXune0t+aupcKbSwA4l3JefblqM5Bcbol9fRmprrs9u4912e0lGX3ILK
        V/yQI8s81nl0XsCw8yY0fXLgkOT6sFtYgdkKK4nwBorUkM7jECQgf4z1bpB7BHeO
        hn05aiGWl0AwWVSvSn8s91zQZ+db77RD5ksoPFyYjqk7ImL5Le3PqANFvvXxL4Hc
        trXh8GlrZBvwLyGNgtOIvjjo++yQkMp0ilkmDQ7T8rtc4kR+xZ9KsXOoxvwngWcA
        lA1MWEWSbKV6oGPtbl2SrQPLNWV8FWm/xFUl9lBUfT80SMLpx3+W8a5ucfrYE+2G
        4sGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690617698; x=1690704098; bh=itVztlhsdL+Tg
        E9iBCuYgyv0QZn1iL7TtRpdZyaCyBM=; b=0EOha8fZdjiqo0sg0OE922E1vqSVw
        +ceoOUMLM5u2ACPky1JbpH8YFeYIC9agJHTtN010wkgUVVd/5bTEuk7MEmjG6X9T
        WYLgjJHPGw+oOf2iM9Dxs9ywojkZCfUtLD97U76zgO2VvZc/fMRMnkxaV3HJmESZ
        lXjPgMewH0qsUQr66Pu+dFdOiBPQgM5NAB9+UXpy/p7/76T4RN8ONL2TobOg10lH
        olf6mBp5b0HljZG8Kp1GAf5kKpruxSQZQdDCO6/2LVBKYAiHJ8iPaIh5mEjHfrqr
        bYhmUnDByaTnHkJ3/fHKgCZ4iZYhyoTwG4C05f48271jY6XskqHF6UUDg==
X-ME-Sender: <xms:YMfEZOgmoC8fMwpRtqguwWHfyQKl-7UeMtBC39dsAe0c9t1lQpunHw>
    <xme:YMfEZPAc-3--76K-fdqkti-PMOKtC-XfagYouBNBru_pv3eykbqlBfsyMGGLDt_ng
    oJ-Ab7KZ-AD42FgVN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieejgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YMfEZGFKi96I8nhFNkV3ostG1V7qBlsT9acoWLLwjt3ANUqmr4KuZg>
    <xmx:YMfEZHQ9cdqcX_EWp_CR_hsrViZG93sHzHy4j5gjJf2YvFjqFFJwtQ>
    <xmx:YMfEZLwmoTryi4H9-c7XvfYgbgMjl0olpaD042Rzmw0TDIdChPYApw>
    <xmx:YsfEZCmNleOV9eCoTRRqHQb7sxX1hOhGi7FevuE1mprIUcWcq3xOQQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 14AD1B6008D; Sat, 29 Jul 2023 04:01:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <e7a792d9-39b9-440a-9c22-99e25b25a396@app.fastmail.com>
In-Reply-To: <20230728234429.GA611252@dev-arch.thelio-3990X>
References: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn>
 <1687443219-11946-2-git-send-email-yangtiezhu@loongson.cn>
 <20230727213648.GA354736@dev-arch.thelio-3990X>
 <1777400a-4d9c-4bdb-9d3b-f8808ef054cc@app.fastmail.com>
 <20230728173103.GA1299743@dev-arch.thelio-3990X>
 <a2fa1a31-e8bb-4659-9631-398b564e7c2b@app.fastmail.com>
 <20230728234429.GA611252@dev-arch.thelio-3990X>
Date:   Sat, 29 Jul 2023 09:59:23 +0200
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 29, 2023, at 01:44, Nathan Chancellor wrote:
> On Fri, Jul 28, 2023 at 10:56:38PM +0200, Arnd Bergmann wrote:

>     DESCEND objtool
>   In file included from 
> /usr/include/aarch64-linux-gnu/asm/bitsperlong.h:1,
>                    from /usr/include/asm-generic/int-ll64.h:12,
>                    from /usr/include/asm-generic/types.h:7,
>                    from /usr/include/aarch64-linux-gnu/asm/types.h:1,
>                    from /linux-stable/tools/include/linux/types.h:13,
>                    from 
> /linux-stable/tools/arch/x86/include/asm/orc_types.h:9,
>                    from /linux-stable/scripts/sorttable.h:96,
>                    from /linux-stable/scripts/sorttable.c:201:
>   /linux-stable/tools/include/asm-generic/bitsperlong.h:14:2: error: 
> #error Inconsistent word size. Check asm/bitsperlong.h
>      14 | #error Inconsistent word size. Check asm/bitsperlong.h
>         |  ^~~~~
>   make[3]: *** [/linux-stable/scripts/Makefile.host:114: 
> scripts/sorttable] Error 1
>   ...
>
>> I also noticed that your command line includes CROSS_COMPILE=x86_64-linux-
>> rather than CROSS_COMPILE=x86_64-linux-gnu-
>
> Right, as I was reproducing this with your kernel.org GCC for
> CROSS_COMPILE and Fedora's GCC for HOSTCC, since I wanted to make sure
> this was not some issue with clang (which it does not appear to be).

Ok, it's beginning to make more sense to me now. I see
that the tools/arch/x86/include/asm/orc_types.h comes from
the x86_64 target build and is intentional, as sorttable.c
needs to access the ORC information. Here the Makefile does

ifdef CONFIG_UNWINDER_ORC
ifeq ($(ARCH),x86_64)
ARCH := x86
endif
HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/x86/include
HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
endif

in order to get the ORC definitions from asm/orc_types.h, but
then it looks like it also gets the uapi/asm/bitsperlong.h
header from there which contains

#if defined(__x86_64__) && !defined(__ILP32__)
# define __BITS_PER_LONG 64
#else
# define __BITS_PER_LONG 32
#endif

and this would set __BITS_PER_LONG to 32 on arm64.

However, I don't see this actually being included on my
machine. Can you dump the sorttable.c preprocessor output
with your setup, using -fdirectives-only, so we can see
which of the two (__BITS_PER_LONG or BITS_PER_LONG) is
actually wrong and triggers the sanity check?

What I see on my machine is that both definitions come
from the local tools/include/ headers, not from the
installed system headers, so I'm still doing something
wrong in my installation:

./tools/include/uapi/asm-generic/bitsperlong.h
#define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)

./tools/include/asm-generic/bitsperlong.h
#define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)

Neither of these files actually contains the sanity
check in linux-6.5-rc3, and comparing these is clearly
nonsensical, as they are defined the same way (rather
than checking CONFIG_64BIT), but also I don't see why
there is both a uapi/ version and a non-uapi version
in what is meant to be a userspace header.

     Arnd
