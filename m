Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD05A3DF1
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiH1OGD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Aug 2022 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiH1OGB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Aug 2022 10:06:01 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E346411829;
        Sun, 28 Aug 2022 07:05:57 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 27SE5hJY027964;
        Sun, 28 Aug 2022 23:05:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 27SE5hJY027964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661695544;
        bh=7p5xEPIE0raguxuqb9tD1++pwdD0zB8NLEYhYSPu/IQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZDCRt1bfvQTNSNT/0wrEHkz5x+qJ+FXgOtLTL/KKBxoJ4U2gU673SXYI1OhtLDjVA
         4XLEkOhfXkCpw2EAZFg+Ci1SkH+8a3F9K0klteXaFDVVORVkUE1Cj6Id2lLTNS9KRM
         jbGk4fy8ZqSS5wXWgi2CUx2b2dtpNjaPvDDHxDTIz+i3rSQd1MHnBXRO+PdznuyfkN
         hK8TrqJoNlZ1v/iDC4Hii66gyDP63+t+UJ0mH99Q5UQhuEUUE4t0+kgJq+c+Kp025b
         mj/NtaHQf0p9/G/Q0zZ2gGuDCxUmwBOgRPKQmW2yVyjgNmVb3cRnckrEay3GMRSN/t
         58myAFCNffXdA==
X-Nifty-SrcIP: [209.85.160.52]
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11eb8b133fbso3311365fac.0;
        Sun, 28 Aug 2022 07:05:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo1l70qejLS2GnPlkxahj1z/7tn9kK1AirLDA0zNkziVBnQi89Xe
        ZMamCt7jwbeoamd67CCInlB33nm23C3lE+Z3wsU=
X-Google-Smtp-Source: AA6agR6kkMIeaI/O17CfGjD2nBsyny/Gn0xIrAbAaim7m9/xcWUWWXRceQCWXvs2mtYynFImUo+tpNppj3iJP84luWg=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr5664935oab.287.1661695542843; Sun, 28
 Aug 2022 07:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220817161438.32039-2-ysionneau@kalray.eu> <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
 <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu> <CAMj1kXHeSemLqAhbBLMGkK4G1225NZbaQvnR3wAWYfJr4AReaw@mail.gmail.com>
 <CAMuHMdUJZBPuD1=3SMg4G1-UoBr5Evd8mBfhxxuAaoh=K6Rm+w@mail.gmail.com> <CAMj1kXF6TchD4g0qO1OeEwt8QYU_TZEriE=1yaCxXrNGBYjmCA@mail.gmail.com>
In-Reply-To: <CAMj1kXF6TchD4g0qO1OeEwt8QYU_TZEriE=1yaCxXrNGBYjmCA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 Aug 2022 23:05:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ0wiBZB7XDZVodXWtP5m_H-e_xQ78z_eJ82W3pFrKWfQ@mail.gmail.com>
Message-ID: <CAK7LNAQ0wiBZB7XDZVodXWtP5m_H-e_xQ78z_eJ82W3pFrKWfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 7:17 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 25 Aug 2022 at 20:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Ard,
> >
> > On Thu, Aug 25, 2022 at 2:56 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Thu, 25 Aug 2022 at 14:21, Yann Sionneau <ysionneau@kalray.eu> wrote:
> > > > Well, I am not completely sure about that. See my cover letter, previous
> > > > mechanism for symbol CRC was actually enforcing the section alignment to
> > > > 4 bytes boundary as well.
> >
> > Yes, because else it may become 2-byte aligned on m68k.
> >
> > > > Also, I'm not sure it is forbidden for an architecture/compiler
> > > > implementation to actually enforce a stronger alignment on u32, which in
> > > > theory would not break anything.
> > > >
> > >
> > > u32 is a Linux type, and Linux expects natural alignment (and padding).
> >
> > Is it? You probably mean its alignment should not be larger than
> > 4 bytes? Less has been working since basically forever.
> >
>
> You are quite right. of course. And indeed, the issue here is padding
> not alignment.
>

I do not know if __align(4) should be used to avoid the padding issue.



Do you think it is a good idea to use an inline assembler,
as prior to 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b ?


This patch:

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index c2b1d4fd5987..fb90f326b1b5 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -12,6 +12,9 @@

 /* __used is needed to keep __crc_* for LTO */
 #define SYMBOL_CRC(sym, crc, sec)   \
-       u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
+       asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""     "\n" \
+           "__crc_" #sym ":"                                   "\n" \
+           ".long " #crc                                       "\n" \
+           ".previous"                                         "\n")

 #endif /* __LINUX_EXPORT_INTERNAL_H__ */







--
Best Regards

Masahiro Yamada
