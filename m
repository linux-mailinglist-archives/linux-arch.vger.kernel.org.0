Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5457681F3
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jul 2023 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjG2VMv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jul 2023 17:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG2VMu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jul 2023 17:12:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4598010C4;
        Sat, 29 Jul 2023 14:12:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AEE9D5C00B7;
        Sat, 29 Jul 2023 17:12:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 29 Jul 2023 17:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690665168; x=1690751568; bh=2L
        fIRxHFYf7tdiKVZVDNRsDqP9EiptdXtOO6rttjJd4=; b=YbZfH+nF9ZC2Yv40Wb
        Fuit5rGlhfVzwXrH42XrZzJqEC8pysRJ8jeQeKPOki3IyRtp6rxWoRGy2h5cABB9
        ARDZfDrglsLhUklgLkagtif1+btu2DkPyK7YfFfQoucZJFyzxV2srxa+0AUKSt3B
        OJZPc5voyrmbP0Xhp5yf13ZHQpmAsAYJSVVq3jrmM88JWwrc/O4f3C1KAYrAd9oI
        d8E9B92d6P9ioClbGuWJozgpUhmvqmblVVuUxZb1CCH1E4wTqRPSN1zJchFvPLaz
        JnRRozeaut/LtlU7fcn4+56F4jpC0s3yAFJOtPwrIVfG+RWHIgeQTQyDYFP1SqxG
        Oq4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690665168; x=1690751568; bh=2LfIRxHFYf7td
        iKVZVDNRsDqP9EiptdXtOO6rttjJd4=; b=m/YLPu8q3mhrS02GufIu+7Pus8img
        YX5e4oOtO1PLj2Iw6Gr4VJ1jz1mVHnqlxu3r7U17Xeuq1vngeo3zyWfU7f5nKdc2
        +H4T+t9DF1HrvdUptLghKQg8zFof6zG3u6RLWvhI37skysYRAr4wRqd0h1oHNlNV
        PS0TGJ4m5mSjfXPokI6eRFwV/1hIKKGF5P7jwJN1xzWg/V+C2fCJ54oM6NLb1Q82
        BntUGD10s/jC5xQEoH+trlllxHbSC95zVQ+5w13pYz3B+gaZO75aWmNYJdaOZ+Ew
        yZWLTjGiJjaWyHsn/IEe4Htsd7h7VAJNlBzwR3axlSFehqxrT8RGoz5Hg==
X-ME-Sender: <xms:z4DFZGACuWJH4Ai-lBBrfMWjpda14AuslY2pzRV42qxJAmcr6hrVPQ>
    <xme:z4DFZAhfXvlLYmX9UkleogrCArOiJNv-rohV5b756dna6JHyvX-dFx5uIiuj6Dfnt
    wIKbkq4pEZI4-8DdJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieekgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjedvvddvudeludehjeeitdehheeivdejgfelleffiefgvefhhfeuudfhgeef
    feehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:z4DFZJn-T3kYtGDsJY4kOvnouMsFLtEenPFOL30hx98C2nXI8vOh3g>
    <xmx:z4DFZExJvC0WEy5OIkZ_IByrdwEBK5xB-od0lZL1JJWU58QvY_Iogg>
    <xmx:z4DFZLRBWVm5HJ7q0oAB4cR_DY0O1CMgQEknhzzozOs9cb1MqM52Kg>
    <xmx:0IDFZGG_T2KqYRFvQlA-APHwKjQP-i6-G3opAzZVn6KmDzyfP0OjJA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 37ABCB60089; Sat, 29 Jul 2023 17:12:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <6d6641b6-748e-412c-a139-35fc873a6a1b@app.fastmail.com>
In-Reply-To: <20230729174617.GA1229655@dev-arch.thelio-3990X>
References: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn>
 <1687443219-11946-2-git-send-email-yangtiezhu@loongson.cn>
 <20230727213648.GA354736@dev-arch.thelio-3990X>
 <1777400a-4d9c-4bdb-9d3b-f8808ef054cc@app.fastmail.com>
 <20230728173103.GA1299743@dev-arch.thelio-3990X>
 <a2fa1a31-e8bb-4659-9631-398b564e7c2b@app.fastmail.com>
 <20230728234429.GA611252@dev-arch.thelio-3990X>
 <e7a792d9-39b9-440a-9c22-99e25b25a396@app.fastmail.com>
 <20230729174617.GA1229655@dev-arch.thelio-3990X>
Date:   Sat, 29 Jul 2023 23:12:26 +0200
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 29, 2023, at 19:46, Nathan Chancellor wrote:
> On Sat, Jul 29, 2023 at 09:59:23AM +0200, Arnd Bergmann wrote:
>> On Sat, Jul 29, 2023, at 01:44, Nathan Chancellor wrote:

>> 
>> in order to get the ORC definitions from asm/orc_types.h, but
>> then it looks like it also gets the uapi/asm/bitsperlong.h
>> header from there which contains
>> 
>> #if defined(__x86_64__) && !defined(__ILP32__)
>> # define __BITS_PER_LONG 64
>> #else
>> # define __BITS_PER_LONG 32
>> #endif
>> 
>> and this would set __BITS_PER_LONG to 32 on arm64.
>> 
>> However, I don't see this actually being included on my
>> machine. Can you dump the sorttable.c preprocessor output
>> with your setup, using -fdirectives-only, so we can see
>> which of the two (__BITS_PER_LONG or BITS_PER_LONG) is
>> actually wrong and triggers the sanity check?
>
> Sure thing, this is the output of:
>
>   $ gcc -I/linux-stable/tools/include 
> -I/linux-stable/tools/arch/x86/include -DUNWINDER_ORC_ENABLED -I 
> ./scripts -E -fdirectives-only /linux-stable/scripts/sorttable.c
>
> https://gist.github.com/nathanchance/d2c3e58230930317dc84aff80fef38bf

Ok, so what we get is that the system-wide
/usr/include/aarch64-linux-gnu/asm/bitsperlong.h

includes the source tree file 
tools/include/asm-generic/bitsperlong.h

which in the old kernels only has the "32" fallback value.

>> What I see on my machine is that both definitions come
>> from the local tools/include/ headers, not from the
>> installed system headers, so I'm still doing something
>> wrong in my installation:
>
> Just to make sure, you have the 6.5-rc1+ headers installed and you are
> attempting to build the host tools from an earlier Linux release than
> 6.5-rc1? I don't see a problem with building these host programs on
> mainline/6.5, I see this issue when building them in older stable
> releases (my reproduction so far has been on 6.4 but I see it when
> building all currently supported long term stable releases) when I have
> the 6.5-rc1+ headers installed.

Ok, I see. I missed that part of your description earlier.

>
> which seems to be where the mismatch is coming from?

Right, exactly.

>> ./tools/include/asm-generic/bitsperlong.h
>> #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
>> 
>> Neither of these files actually contains the sanity
>> check in linux-6.5-rc3, and comparing these is clearly
>> nonsensical, as they are defined the same way (rather
>> than checking CONFIG_64BIT), but also I don't see why
>> there is both a uapi/ version and a non-uapi version
>> in what is meant to be a userspace header.
>
> May be worth looping in the tools/ folks, since that whole directory is
> rather special IMO...

I think the good news is that this only happens because
the tools/ directory contains a copy of the kernel headers
including that sanity check, and other user space won't
suffer from it because they don't contain copies of kernel
internal headers.

Reverting the change might still end up being the easiest way
out regardless, but it does seem like we should be able
to address this in the tools directory by making sure it doesn't
mix the installed headers with the local ones.

Part of the problem I think is that the installed 
/usr/include/asm-generic/int-ll64.h includes
/usr/include/aarch64-linux-gnu/asm/bitsperlong.h, so both
of them are the uapi headers, but this one has an
"include <asm-generic/bitsperlong.h>" that expects the
uapi version but instead gets the kernel version from
the tools directory. We could override this by adding
a working tools/include/asm-generic/bitsperlong.h header,
but that has to be backported to the stable kernels then.

       Arnd
