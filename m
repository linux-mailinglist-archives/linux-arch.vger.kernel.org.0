Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48D5A3DD5
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiH1Nmz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Aug 2022 09:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiH1Nmy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Aug 2022 09:42:54 -0400
X-Greylist: delayed 39750 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 Aug 2022 06:42:53 PDT
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565492A976;
        Sun, 28 Aug 2022 06:42:53 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 27SDgWgV023777;
        Sun, 28 Aug 2022 22:42:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 27SDgWgV023777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661694152;
        bh=z4Xqt1t3U8i2O7vXSoTPh8j9K9PhDYbKNgs8kKYDV1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uVY2LLahiuzU5P6iUVr4GMtaE/tgTvx9CO084RPZwv42yHOXljg2wZ02Nb3j+p515
         V2KpOZTCV/MQ2D/rikCs5SV4hyK1fcfauIsBHl/kcfnMZ2J+1Cs1qdA5iPRyHHf8LJ
         HubNzQY9/8Jge1DWCyePnIv4mDGEZiuQWirJq4V1vWu4TAorMZDWdEH27dVUswWJ0g
         CyJ09Bw4qeq/SzR2Z/fQIzuiKeb2nMoC/AqbzWerL7nt9MQ7AUJ0Bwgi51p0sSeHJd
         /RTJKgIqOH7TvxEnY8x7jSi/CzVyNp/L/5w/t+YLdZG6uMPgoH3R+RLJxZ05Xcw8cl
         ws/VpQgNLf9Jg==
X-Nifty-SrcIP: [209.85.167.169]
Received: by mail-oi1-f169.google.com with SMTP id a133so7675153oif.4;
        Sun, 28 Aug 2022 06:42:32 -0700 (PDT)
X-Gm-Message-State: ACgBeo1qzharr7QoCoBNty3YZsEQ5LRXbcYrftC5sI8ct8Ec7P9vjJgf
        9zxobt6uy9Fnv1OpKMsUjeVj27lEHnzGhxUhYeg=
X-Google-Smtp-Source: AA6agR5/dNBUarv8LbAmH7c6K5aolE/19K18Dh+wEMFcWatmWpXO2YUZjTMWUWYTjVObDjOmKGFqJnhFGrCSCc4PlG8=
X-Received: by 2002:a05:6808:1189:b0:33a:34b3:6788 with SMTP id
 j9-20020a056808118900b0033a34b36788mr5201457oil.194.1661694151532; Sun, 28
 Aug 2022 06:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220817161438.32039-2-ysionneau@kalray.eu> <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com> <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu>
In-Reply-To: <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 Aug 2022 22:41:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHV19jeYs-y=kpussNWPq_AkcczxaryQoy9OWTSUGV4g@mail.gmail.com>
Message-ID: <CAK7LNATHV19jeYs-y=kpussNWPq_AkcczxaryQoy9OWTSUGV4g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 9:21 PM Yann Sionneau <ysionneau@kalray.eu> wrote:
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

I do not think so.


I do not see such alignment in for __CRC_SYMBOL() in
include/linux/export.h

If you are talking about KCRC_ALIGN
in include/asm-generic/export.h, it is only used by *.S.


Most of EXPORT_SYMBOL's are defined in *.c files,
which include <linux/export.h>

If I am missing something, please point me to the code.








>
> Also, I'm not sure it is forbidden for an architecture/compiler
> implementation to actually enforce a stronger alignment on u32, which in
> theory would not break anything.

It seems like an interesting compiler.

Does it also enforce 8 byte alignment to u8?
(that is, 7-byte padding for u8 ?)



>
> But in this precise case it does break something since it will cause
> "gaps" in the end result vmlinux binary segment. For this to work I
> think we really want to enforce a 4 bytes alignment on the section.


My best guess it, it was previously working for the kvm compiler
because include/linux/export.h previously used an inline assembler.

The kvm toolchain presumably gives natural alignment/padding
to '.long' assembly directive, but enforces 8-byte to u32.




-- 
Best Regards
Masahiro Yamada
