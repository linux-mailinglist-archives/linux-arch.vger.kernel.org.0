Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143D85E9CF3
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiIZJG4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiIZJG3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 05:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD32B84B;
        Mon, 26 Sep 2022 02:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79A4E60A57;
        Mon, 26 Sep 2022 09:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF644C433B5;
        Mon, 26 Sep 2022 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664183171;
        bh=DCskhEH1rQ9wAhxC9aUCf/PJog9CeJu5exzuKN80sDE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K3QHTR5jCbgHG5Sg7hVWi1ZS/V/UxIpGTHRd9mtv0hgDpV0g8aAZc11BJ4w/m36CO
         oysXpoTR2g7C3iT7aao3bGfUkhhf6Gu5mXirK7dQGWQep4Q3MULUgzkNyhfTgUvGwY
         Jg5z3nQ7nLIFV4k8ZXWsXrKm6em/5INlb4zI8GZkd+efvVsJfIUtDnE/VRPwoLFtnc
         Ow1Q7ge7w+Mn7gLBCy5mf5hC0ncklcKPI8BOEtW10U296AH4PYZfIOYmSHrNSBr2CO
         lUkLJPu+Dg0C49r0jvNzgvRCFqjKR0Ox8bRPA2c0RKg6yEKEl493gf+zPPFIC1VpC+
         lrNYvE8OMv4HQ==
Received: by mail-lf1-f51.google.com with SMTP id s6so9776863lfo.7;
        Mon, 26 Sep 2022 02:06:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf0tXXo3GvJP9Rq5wRqYJeWU2SYtvGA8D1++t3jeTkGQkryZ+YXh
        H3HrYcelmxzIzkpTDveH8I3vUiT870QWUhQOG5g=
X-Google-Smtp-Source: AMsMyM5ILR/ZSwcLTajRPn73S7Mrz7G0KGy5KWG2rlml2NYnnPgppySwnGHAKFNdCZZ01e2uKj1FKh88jMi3gK0TGcg=
X-Received: by 2002:a05:6512:13a1:b0:48d:f14:9059 with SMTP id
 p33-20020a05651213a100b0048d0f149059mr9107494lfa.110.1664183169855; Mon, 26
 Sep 2022 02:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220817161438.32039-2-ysionneau@kalray.eu> <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
 <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu> <CAMj1kXHeSemLqAhbBLMGkK4G1225NZbaQvnR3wAWYfJr4AReaw@mail.gmail.com>
 <CAMuHMdUJZBPuD1=3SMg4G1-UoBr5Evd8mBfhxxuAaoh=K6Rm+w@mail.gmail.com>
 <CAMj1kXF6TchD4g0qO1OeEwt8QYU_TZEriE=1yaCxXrNGBYjmCA@mail.gmail.com>
 <CAK7LNAQ0wiBZB7XDZVodXWtP5m_H-e_xQ78z_eJ82W3pFrKWfQ@mail.gmail.com> <197eb354-2fc8-1712-3c83-34be9391efa8@kalray.eu>
In-Reply-To: <197eb354-2fc8-1712-3c83-34be9391efa8@kalray.eu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 26 Sep 2022 11:05:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHqYwwMKLfVJm+meizxi95f1nku5kb6f=sApMtr2Qr5+Q@mail.gmail.com>
Message-ID: <CAMj1kXHqYwwMKLfVJm+meizxi95f1nku5kb6f=sApMtr2Qr5+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 26 Sept 2022 at 10:48, Yann Sionneau <ysionneau@kalray.eu> wrote:
>
>
> On 8/28/22 16:05, Masahiro Yamada wrote:
> > On Fri, Aug 26, 2022 at 7:17 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >> On Thu, 25 Aug 2022 at 20:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>> Hi Ard,
> >>>
> >>> On Thu, Aug 25, 2022 at 2:56 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>> On Thu, 25 Aug 2022 at 14:21, Yann Sionneau <ysionneau@kalray.eu> wrote:
> >>>>> Well, I am not completely sure about that. See my cover letter, previous
> >>>>> mechanism for symbol CRC was actually enforcing the section alignment to
> >>>>> 4 bytes boundary as well.
> >>> Yes, because else it may become 2-byte aligned on m68k.
> >>>
> >>>>> Also, I'm not sure it is forbidden for an architecture/compiler
> >>>>> implementation to actually enforce a stronger alignment on u32, which in
> >>>>> theory would not break anything.
> >>>>>
> >>>> u32 is a Linux type, and Linux expects natural alignment (and padding).
> >>> Is it? You probably mean its alignment should not be larger than
> >>> 4 bytes? Less has been working since basically forever.
> >>>
> >> You are quite right. of course. And indeed, the issue here is padding
> >> not alignment.
> >>
> > I do not know if __align(4) should be used to avoid the padding issue.
> >
> >
> >
> > Do you think it is a good idea to use an inline assembler,
> > as prior to 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b ?
> >
> >
> > This patch:
> >
> > diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
> > index c2b1d4fd5987..fb90f326b1b5 100644
> > --- a/include/linux/export-internal.h
> > +++ b/include/linux/export-internal.h
> > @@ -12,6 +12,9 @@
> >
> >   /* __used is needed to keep __crc_* for LTO */
> >   #define SYMBOL_CRC(sym, crc, sec)   \
> > -       u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
> > +       asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""     "\n" \
> > +           "__crc_" #sym ":"                                   "\n" \
> > +           ".long " #crc                                       "\n" \
> > +           ".previous"                                         "\n")
> >
> >   #endif /* __LINUX_EXPORT_INTERNAL_H__ */
>
> Ping on this topic, should we "fix our toolchain"?
>
> Or should Linux code be modified to add either __align(4) or use the
> inline assembler? (I've tried your inline asm patch and it seems to fix
> the issue I'm having).
>
> Or both?
>

There are other cases where we rely on sections containing arrays of
u32 to be concatenated without gaps. If you would ever want to enable
HAVE_ARCH_PREL32_RELOCATIONS for your architecture (in order to save
some space in the binary wasted on absolute addresses or RELA
relocations) you'd run into the same issue afaict. So I'd recommend
fixing this in your compiler or linker asap.
