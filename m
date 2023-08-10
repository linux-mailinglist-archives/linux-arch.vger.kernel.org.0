Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D3776E95
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 05:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjHJDeo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Aug 2023 23:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjHJDeo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Aug 2023 23:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941BE2100;
        Wed,  9 Aug 2023 20:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ECCA64DF7;
        Thu, 10 Aug 2023 03:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E909C433C7;
        Thu, 10 Aug 2023 03:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691638482;
        bh=rCOsgCbjaN827PPhM108Ek17mZMzkYk4jK2hnYfjYGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u47TIKeQiYlW2h4dgQKzh2rhWoHUFehCYA2RbBa7G/bT+CYjln4MKbyIjd3Q1B1Tv
         WdsiL4723pydlG+c7Oxrh+OciI/Ri73/ubezvm8FLdNZ66Eq/TGJ7uakVzm7RqG27j
         l0MI74RoAO2FTxV0iGqgSw8uoBQ9x/bO0qjjQyyBIBtH4pYxODNed9Y+6x7QMtYHIo
         j9VQBGMgsrK9Raw+AJs+WcwDr9cAL1JA/fSJu8gJ8FBYPk3TglqaF6FgcYNNISNbwB
         HE8Oi7KmFAoexiMT/14omAq8anI0LgvXahGFVUWye5e//voka6Lz9W7Gct/xqSLRkx
         40riAQBHo9k9A==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99c47ef365cso73865666b.0;
        Wed, 09 Aug 2023 20:34:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YwDWnOt6O3pm+sV7uw62STWsjkFQvP2I/M3yw44g9fdgkZGpgAJ
        c0sG8wo8AJaZvspzLTN2EZIn2WuhndMhxV6QYtA=
X-Google-Smtp-Source: AGHT+IH4mh1PIEDd6c+RuRp0h/3nwRj+w9MI/I3Wh2+WOG9MPDgLeyrPpbCFsg9EYOxSnWd+vaJdDVME7oBLX9OxlPA=
X-Received: by 2002:a17:906:dc:b0:99b:c8db:d92f with SMTP id
 28-20020a17090600dc00b0099bc8dbd92fmr1018081eji.69.1691638480735; Wed, 09 Aug
 2023 20:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230710050024.2519893-1-chenhuacai@loongson.cn>
 <ce4cee2d76340d1776560c124c1894080ded13bb.camel@xry111.site> <292e6aa6b9399c8dd53562f51237090bcd6d19c5.camel@xry111.site>
In-Reply-To: <292e6aa6b9399c8dd53562f51237090bcd6d19c5.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 10 Aug 2023 11:34:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6JTbuK+ypvrUi21KOYcTOWmTKbwxK_D8M5y9XaXfJK4A@mail.gmail.com>
Message-ID: <CAAhV-H6JTbuK+ypvrUi21KOYcTOWmTKbwxK_D8M5y9XaXfJK4A@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Fix module relocation error with binutils 2.41
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        WANG Xuerui <git@xen0n.name>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ruoyao,

On Thu, Aug 10, 2023 at 11:21=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> On Thu, 2023-08-10 at 11:20 +0800, Xi Ruoyao wrote:
> > Can we backport this patch into stable?  It fixes a build error with
> > binutils >=3D 2.41.
>
> Correction: not a build error, but all modules won't load if built with
> binutils >=3D 2.41 without the patch.
Generally we can backport, but I don't think there are users who use
the old kernels. :)

Huacai
>
> > On Mon, 2023-07-10 at 13:00 +0800, Huacai Chen wrote:
> > > Binutils 2.41 enables linker relaxation by default, but the kernel
> > > module loader doesn't support that, so just disable it. Otherwise we
> > > get such an error when loading modules:
> > >
> > > "Unknown relocation type 102"
> > >
> > > As an alternative, we could add linker relaxation support in the kern=
el
> > > module loader. But it is relatively large complexity that may or may =
not
> > > bring a similar gain, and we don't really want to include this linker
> > > pass in the kernel.
> > >
> > > Reviewed-by: WANG Xuerui <git@xen0n.name>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  arch/loongarch/Makefile | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > > index 09ba338a64de..7466d3b15db8 100644
> > > --- a/arch/loongarch/Makefile
> > > +++ b/arch/loongarch/Makefile
> > > @@ -68,6 +68,8 @@ LDFLAGS_vmlinux                       +=3D -static =
-n -nostdlib
> > >  ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
> > >  cflags-y                       +=3D $(call cc-option,-mexplicit-relo=
cs)
> > >  KBUILD_CFLAGS_KERNEL           +=3D $(call cc-option,-mdirect-extern=
-access)
> > > +KBUILD_AFLAGS_MODULE           +=3D $(call cc-option,-mno-relax) $(c=
all cc-option,-Wa$(comma)-mno-relax)
> > > +KBUILD_CFLAGS_MODULE           +=3D $(call cc-option,-mno-relax) $(c=
all cc-option,-Wa$(comma)-mno-relax)
> > >  else
> > >  cflags-y                       +=3D $(call cc-option,-mno-explicit-r=
elocs)
> > >  KBUILD_AFLAGS_KERNEL           +=3D -Wa,-mla-global-with-pcrel
> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
