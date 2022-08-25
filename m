Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222D95A10CA
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiHYMl1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 08:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240078AbiHYMl0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 08:41:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F798B2C8;
        Thu, 25 Aug 2022 05:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC878B82919;
        Thu, 25 Aug 2022 12:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EECC433D6;
        Thu, 25 Aug 2022 12:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661431282;
        bh=MBpFKyRwRJJ5rY0/Zj/nuN26Sc26gXGmKPyB6KfUHuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gkOueHl1mst3pXIaKYww0mqQUuD3sM4Rd70jzmkRaPiA2brrqNzPfRUoCR5KbL47Z
         JCYCbRxtiNGVFLmtIgd1D9k/9HRulNIW9PGJe2xiE8boXcp/YW5w/6fSb2EDbkPeah
         mCaR7xYFWSoHIeQwiz3Petekj2Pri1AYijaixLt8oWj0fXeE3R3aJYoot8czyWt3rY
         HLuZHhmhBjGDEiZMv0ArkIeN7yJ3hy3eec3U5KkHOw8RikFklfXtKviGpwQ2HD4Jao
         ZEB3t8dq5D8nsQM4ExIttjQjCQH++bKFpqNpbdey6wPp4IyCsy7f/zfKe3yOOuXX9v
         z9B9yxTsx9qKg==
Received: by mail-wr1-f52.google.com with SMTP id bs25so24476458wrb.2;
        Thu, 25 Aug 2022 05:41:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo2Irc1DgbpOQAM3I0PGoh7Xv4UGjLyRDld0lXk0NvNGzx6ylIYo
        v8SEh9UCiSFROZ1xGKvgo4GYQ4amCOo4onCWprw=
X-Google-Smtp-Source: AA6agR49x2SlvCDAobHEre20umKCwzTfFddAxc6VaftWYq4VWyTScttZrXK4NKz8+F68qj8OpTB+6nJB9gQymqkUk0M=
X-Received: by 2002:a5d:4302:0:b0:225:5303:39e5 with SMTP id
 h2-20020a5d4302000000b00225530339e5mr2252614wrq.380.1661431280743; Thu, 25
 Aug 2022 05:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220817161438.32039-2-ysionneau@kalray.eu> <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com> <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu>
In-Reply-To: <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 Aug 2022 14:41:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHeSemLqAhbBLMGkK4G1225NZbaQvnR3wAWYfJr4AReaw@mail.gmail.com>
Message-ID: <CAMj1kXHeSemLqAhbBLMGkK4G1225NZbaQvnR3wAWYfJr4AReaw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
To:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(cc Arnd)

On Thu, 25 Aug 2022 at 14:21, Yann Sionneau <ysionneau@kalray.eu> wrote:
>
> Hello Ard,
>
> On 25/08/2022 14:12, Ard Biesheuvel wrote:
> > On Thu, 25 Aug 2022 at 14:10, Yann Sionneau <ysionneau@kalray.eu> wrote:
> >> Forwarding also the actual patch to linux-kbuild and linux-arch
> >>
> >> -------- Forwarded Message --------
> >> Subject:        [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
> >> Date:   Wed, 17 Aug 2022 18:14:38 +0200
> >> From:   Yann Sionneau <ysionneau@kalray.eu>
> >> To:     linux-kernel@vger.kernel.org
> >> CC:     Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada
> >> <masahiroy@kernel.org>, Jules Maselbas <jmaselbas@kalray.eu>, Julian
> >> Vetter <jvetter@kalray.eu>, Yann Sionneau <ysionneau@kalray.eu>
> >>
> >>
> >>
> > What happened to the commit log?
>
> This is a forward of this thread: https://lkml.org/lkml/2022/8/17/868
>
> Either I did something wrong with my email agent or maybe the email
> containing the cover letter is taking some time to reach you?
>

Never mind, i see the other thread as well.

Exec summary: out-of-tree port for kvx architecture appears to impose
8 byte alignment for u32 types in some cases.

> >
> >> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> >> ---
> >> include/linux/export-internal.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/export-internal.h
> >> b/include/linux/export-internal.h
> >> index c2b1d4fd5987..d86bfbd7fa6d 100644
> >> --- a/include/linux/export-internal.h
> >> +++ b/include/linux/export-internal.h
> >> @@ -12,6 +12,6 @@
> >> /* __used is needed to keep __crc_* for LTO */
> >> #define SYMBOL_CRC(sym, crc, sec) \
> >> - u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
> >> + u32 __section("___kcrctab" sec "+" #sym) __used __aligned(4)

> > __aligned(4) is the default for u32 so this should not be needed.

>
> Well, I am not completely sure about that. See my cover letter, previous
> mechanism for symbol CRC was actually enforcing the section alignment to
> 4 bytes boundary as well.
>
> Also, I'm not sure it is forbidden for an architecture/compiler
> implementation to actually enforce a stronger alignment on u32, which in
> theory would not break anything.
>

u32 is a Linux type, and Linux expects natural alignment (and padding).

So if your toolchain/architecture violates this rule, I suggest you
typedef u32 to 'unsigned int __aligned(4)' explicitly. so that things
don't break in other places.

However, even then, I am highly skeptical. This really seems like an
issue in your toolchain that could cause problems all over the place.

> But in this precise case it does break something since it will cause
> "gaps" in the end result vmlinux binary segment. For this to work I
> think we really want to enforce a 4 bytes alignment on the section.
>

You are addressing one of many potential issues that could be caused
by this, so I don't think this patch is a good idea tbh.


> >
> >
> >> __crc_##sym = crc
> >> #endif /* __LINUX_EXPORT_INTERNAL_H__ */
> >>
> >> --
> >> 2.37.2
>
> Thanks for your review :)
>
> --
>
> Yann
>
>
>
>
>
