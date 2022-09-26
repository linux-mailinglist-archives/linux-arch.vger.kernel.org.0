Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97825E9D02
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiIZJLV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 05:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiIZJLU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 05:11:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F043B957;
        Mon, 26 Sep 2022 02:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA20AB80691;
        Mon, 26 Sep 2022 09:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6190AC433C1;
        Mon, 26 Sep 2022 09:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664183474;
        bh=KalDO0bNMeLlv1wFIbLh7z2AYIvNk9jQZX3B5SSRhPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X4Kv9itoaO8T3+NmWeQ9ckeq4cuT2ATIULC73Ws88EeVJWGMpChLt7ZjZosfUiZKe
         Dfpz51iGqoKL7mWEAN8NpUo4/U4V3FxT7BsPPk9CaQHZkDNamDVOZiuJRy8YtKsIif
         6ssNkXBd+LiBJFRsyP+lpivFZJcJ3syz13QKI97xXMAKNDGQOSZd3h+TsRm1KhIkcm
         1cQ2GsOCVMvKbOvhjzt/Mf61XKbTFbeop+P/UMezqrYoKBgGo9HoPLZmnqgOl/bGc3
         pPVNMQqBu0FTAbMSbot2PHW9bmzZO0ebpQ4cXn9mXxBL+juWl2sqyHQeWIvyhIh1C9
         kp3aFNfu9I/cA==
Received: by mail-lf1-f49.google.com with SMTP id k10so9816369lfm.4;
        Mon, 26 Sep 2022 02:11:14 -0700 (PDT)
X-Gm-Message-State: ACrzQf1c9O4Jem2d1OWUeBWTY3lH3RPrL12guo8yjp/UJcHyajkoTs79
        Pc8O+CbOSWDJDM657wfEAtQHfiJhy8Ms7RBMHBE=
X-Google-Smtp-Source: AMsMyM6gRU+tsSjSXF5mvs4l1lA3eV0j1hR8ThZNIt+HWqkiDnHcBHrkqNlUlScxDzkqyR0ydAODJgL97EL7ccGtfuM=
X-Received: by 2002:ac2:4431:0:b0:497:aaf5:83eb with SMTP id
 w17-20020ac24431000000b00497aaf583ebmr8290805lfl.228.1664183472334; Mon, 26
 Sep 2022 02:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220817161438.32039-2-ysionneau@kalray.eu> <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
 <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu> <CAMj1kXHeSemLqAhbBLMGkK4G1225NZbaQvnR3wAWYfJr4AReaw@mail.gmail.com>
 <CAMuHMdUJZBPuD1=3SMg4G1-UoBr5Evd8mBfhxxuAaoh=K6Rm+w@mail.gmail.com>
 <CAMj1kXF6TchD4g0qO1OeEwt8QYU_TZEriE=1yaCxXrNGBYjmCA@mail.gmail.com>
 <CAK7LNAQ0wiBZB7XDZVodXWtP5m_H-e_xQ78z_eJ82W3pFrKWfQ@mail.gmail.com>
 <197eb354-2fc8-1712-3c83-34be9391efa8@kalray.eu> <CAK7LNATccB3K-wagEB3+Tf8FVPp7F26nKAXEiCPPxjOd5qyt-Q@mail.gmail.com>
In-Reply-To: <CAK7LNATccB3K-wagEB3+Tf8FVPp7F26nKAXEiCPPxjOd5qyt-Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 26 Sep 2022 11:11:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFK3zygrFJCmdaoyuFANLgxBDTGH7zXYUU2ECk66zR6dg@mail.gmail.com>
Message-ID: <CAMj1kXFK3zygrFJCmdaoyuFANLgxBDTGH7zXYUU2ECk66zR6dg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
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

On Mon, 26 Sept 2022 at 11:06, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Mon, Sep 26, 2022 at 5:48 PM Yann Sionneau <ysionneau@kalray.eu> wrote:
> >
> >
> > On 8/28/22 16:05, Masahiro Yamada wrote:
> > > On Fri, Aug 26, 2022 at 7:17 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >> On Thu, 25 Aug 2022 at 20:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >>> Hi Ard,
> > >>>
> > >>> On Thu, Aug 25, 2022 at 2:56 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>>> On Thu, 25 Aug 2022 at 14:21, Yann Sionneau <ysionneau@kalray.eu> wrote:
> > >>>>> Well, I am not completely sure about that. See my cover letter, previous
> > >>>>> mechanism for symbol CRC was actually enforcing the section alignment to
> > >>>>> 4 bytes boundary as well.
> > >>> Yes, because else it may become 2-byte aligned on m68k.
> > >>>
> > >>>>> Also, I'm not sure it is forbidden for an architecture/compiler
> > >>>>> implementation to actually enforce a stronger alignment on u32, which in
> > >>>>> theory would not break anything.
> > >>>>>
> > >>>> u32 is a Linux type, and Linux expects natural alignment (and padding).
> > >>> Is it? You probably mean its alignment should not be larger than
> > >>> 4 bytes? Less has been working since basically forever.
> > >>>
> > >> You are quite right. of course. And indeed, the issue here is padding
> > >> not alignment.
> > >>
> > > I do not know if __align(4) should be used to avoid the padding issue.
> > >
> > >
> > >
> > > Do you think it is a good idea to use an inline assembler,
> > > as prior to 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b ?
> > >
> > >
> > > This patch:
> > >
> > > diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
> > > index c2b1d4fd5987..fb90f326b1b5 100644
> > > --- a/include/linux/export-internal.h
> > > +++ b/include/linux/export-internal.h
> > > @@ -12,6 +12,9 @@
> > >
> > >   /* __used is needed to keep __crc_* for LTO */
> > >   #define SYMBOL_CRC(sym, crc, sec)   \
> > > -       u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
> > > +       asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""     "\n" \
> > > +           "__crc_" #sym ":"                                   "\n" \
> > > +           ".long " #crc                                       "\n" \
> > > +           ".previous"                                         "\n")
> > >
> > >   #endif /* __LINUX_EXPORT_INTERNAL_H__ */
> >
> > Ping on this topic, should we "fix our toolchain"?
> >
> > Or should Linux code be modified to add either __align(4) or use the
> > inline assembler? (I've tried your inline asm patch and it seems to fix
> > the issue I'm having).
> >
> > Or both?
> >
> > Thanks,
> >
> > Yann
> >
> >
> >
> >
> >
>
>
> I queued up the patch.
> You can see it in linux-next.
>
>
> Once it lands in the mainline,
> it will be back-ported.
>
>
>
>
>
>
> masahiro@zoe:~/ref/linux-next$ git log -1 next-20220923 --
> include/linux/export-internal.h
> commit 60ecfddd7a092f9cbd2398dbc55da3abbb803ff0
> Author: Masahiro Yamada <masahiroy@kernel.org>
> Date:   Fri Sep 16 15:29:53 2022 +0900
>
>     linux/export: use inline assembler to populate symbol CRCs
>
>     Since commit 7b4537199a4a ("kbuild: link symbol CRCs at final link,
>     removing CONFIG_MODULE_REL_CRCS"), the module versioning on the
>     (non-upstreamed-yet) kvx Linux port is broken due to unexpected padding
>     for __crc_* symbols. The kvx GCC adds padding so u32 gets 8-byte
>     alignment instead of 4.
>
>     I do not know if this happens for upstream architectures in general,
>     but any compiler has the freedom to insert padding for faster access.
>
>     Use the inline assembler to directly specify the wanted data layout.
>     This is how we previously did before the breakage.
>
>     Link: https://lore.kernel.org/lkml/20220817161438.32039-1-ysionneau@kalray.eu/
>     Link: https://lore.kernel.org/linux-kbuild/31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu/
>     Fixes: 7b4537199a4a ("kbuild: link symbol CRCs at final link,
> removing CONFIG_MODULE_REL_CRCS")
>     Reported-by: Yann Sionneau <ysionneau@kalray.eu>
>     Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>     Tested-by: Yann Sionneau <ysionneau@kalray.eu>
>

I don't think we should merge this. kvm is an experimental out of tree
port, and everywhere else, we already rely heavily on array sections
constructed by the linker where it just concatenate sections from the
input objects, and assumes there will be no padding.
