Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2D60280B
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiJRJOK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiJRJOC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 05:14:02 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B63AA343;
        Tue, 18 Oct 2022 02:13:49 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 29I9DVRL002761;
        Tue, 18 Oct 2022 18:13:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 29I9DVRL002761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666084412;
        bh=3pXlksKoX067wY5+EfFXWbUDydu8+P5Ey+k3BFIx0HE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tgEE65Ys9KPzyXxFvpkGI0OQo8q7Ukz7gxq5FAbsPugJpAoDsSSMMk0+Hw/nOB9Cz
         b7jLoK4cjDtEophr/R+ZtEaz2kFCsmu+ApapgMJEICk/V/kLtRx9RUwsmchKKT2qjk
         j72mDy4AC3EqTcMYf5WJq3PKKw/304scTL500NojWXurQkRKHOy6UIyyPrc11wB4eC
         oE9pupYZDNpjcwM9oN5+75eS//Ahm5sNQOm0I72mNh+zwEYwZ459IFQIbpSpQ+kRNX
         YuXzo3rgfnc11tOU9TpQw8+N3lKI7Ftal7U6sXTXqRhpIE3Vbmlpjey6s6F2aBbZea
         qXPxst5WxvjRA==
X-Nifty-SrcIP: [209.85.210.46]
Received: by mail-ot1-f46.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so7258659otu.1;
        Tue, 18 Oct 2022 02:13:32 -0700 (PDT)
X-Gm-Message-State: ACrzQf2hHhya9t6rW8cuUWOi0zOPR09iGijGl2NY+8M7CjEbx2X61RNQ
        eyOs8ezqjJjlTlPttGQWgDbX3foP7SfffSsvWYc=
X-Google-Smtp-Source: AMsMyM6/WHrDZayL0+X7b1RVI31TF7F6OSCDYccMj7Tx4f4I0BhhLPHkYSmQ8ipwEIpRc+61A3EnwI8yizPwQzCw0I8=
X-Received: by 2002:a05:6830:6384:b0:661:bee5:73ce with SMTP id
 ch4-20020a056830638400b00661bee573cemr882692otb.343.1666084411064; Tue, 18
 Oct 2022 02:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-8-masahiroy@kernel.org> <1ec14007-affc-f826-6dda-f23ee166226a@kernel.org>
In-Reply-To: <1ec14007-affc-f826-6dda-f23ee166226a@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Oct 2022 18:12:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARahN2xefEBb4EprpiA6B5-7Hakc1cC9_o+FieXr=a_pA@mail.gmail.com>
Message-ID: <CAK7LNARahN2xefEBb4EprpiA6B5-7Hakc1cC9_o+FieXr=a_pA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] kbuild: remove head-y syntax
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 18, 2022 at 5:16 PM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
> On 24. 09. 22, 20:19, Masahiro Yamada wrote:
> > Kbuild puts the objects listed in head-y at the head of vmlinux.
> > Conventionally, we do this for head*.S, which contains the kernel entry
> > point.
> >
> > A counter approach is to control the section order by the linker script.
> > Actually, the code marked as __HEAD goes into the ".head.text" section,
> > which is placed before the normal ".text" section.
> >
> > I do not know if both of them are needed. From the build system
> > perspective, head-y is not mandatory. If you can achieve the proper code
> > placement by the linker script only, it would be cleaner.
> >
> > I collected the current head-y objects into head-object-list.txt. It is
> > a whitelist. My hope is it will be reduced in the long run.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ...
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1149,10 +1149,10 @@ quiet_cmd_ar_vmlinux.a = AR      $@
> >         cmd_ar_vmlinux.a = \
> >       rm -f $@; \
> >       $(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> > -     $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $(head-y)
> > +     $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
>
> With AR=gcc-ar, the "| head -n1" results in:
> /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/bin/ar
> terminated with signal 13 [Broken pipe]
>
> I found out only with gcc-lto. But maybe we should make it silent in any
> case? I'm not sure how. This looks ugly (and needs the whole output to
> be piped):
> gcc-ar t vmlinux.a | ( head -n1; cat >/dev/null )
>
> Note the result appears to be correct, it's only that gcc-ar complains
> after printing out the very first line.


Indeed, I see the same message.


sed does not show such an error, though.


masahiro@zoe:~/ref/linux$ gcc-ar t vmlinux.a | head -n1
arch/x86/kernel/head_64.o
/usr/bin/ar terminated with signal 13 [Broken pipe]


masahiro@zoe:~/ref/linux$ gcc-ar t vmlinux.a | sed -n 1p
arch/x86/kernel/head_64.o







-- 
Best Regards
Masahiro Yamada
