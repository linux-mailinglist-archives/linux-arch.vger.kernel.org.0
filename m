Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A4D6C78B0
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 08:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCXHTO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 03:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCXHTN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 03:19:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFE19BA;
        Fri, 24 Mar 2023 00:19:12 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g18so741795ljl.3;
        Fri, 24 Mar 2023 00:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679642350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxovThApevwims1d/uyTbtFdKD78MsUDwDytaLqWWyQ=;
        b=meDyMuK4AKtB7G75lOHCDEFXanUAZYCqRRlZxdSRLZp5Nqg1ozFRi7UbmVDDTPGxTe
         ozhBB09MNMGA28nc8q7Whc4fvp1zMc/6A9flaRFVqEn6el+l870OFVfnh4r/8ph3Tj4+
         31yJ27xLWhZKLx5kip+qonOzOgKSNdiPKEb/DXDL23v6Nba0CpdN3IKRWbKzqnNzSsIO
         kHC215XrEtJx1OMV56dHtk8iCgX07kfA5yVY6xakelapue2N0FV6JItDi4r3Sf+nFnGJ
         mhQ0ks4ugg1TV4ZkfewPKsDRy1krwVie/Tk5jEYQHSUrZWIKliGHXkoNfb0uElEbCzLn
         snTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxovThApevwims1d/uyTbtFdKD78MsUDwDytaLqWWyQ=;
        b=iVykoEWGiYO+m25KAixZeUemV5XHpbTpzFcDdWeMe+irrbVas8EmIHdLKyik5F7LAN
         6fh16AaRPVa4zZihS0/6zJy1vI48NqKgndelouqC28HpMG9VkheAs4txm2JwaA9AHDfl
         V4zjwsQLpHceTVoXLwMvjEH6MkPq/R0jftyF4gDjuj/SL4WrjOKFZYrrJT+QZ9ALwuyB
         4IqZq2axk9eMeX33SauE+y8K1ij+zRTDKhiH08NbD4d4yp9LOkNW5yvaXDHIV3NrOcbN
         B2H3jC/gDnESuTtVvQlG+zNP3NHJKbHzo7l96NXnU4Z0UvAEUMpha9OmUs4nSItGJOW9
         wVpA==
X-Gm-Message-State: AAQBX9dj4Un0dNDJ7sHq/+Nir2eC6yhYxy62mUnxy6cth/5eWinaE8nh
        y/DkYwtm86tX1hM7n6JygAQc8EYsmucxB4VSc7g=
X-Google-Smtp-Source: AKy350ZmOa+xSBA3KdLPC1TZGAe6iXd1pKFjVEv+tZuOIp9NH7Xo/9Fe8GLkoulUpAJ1GZKORTX1WmjSeUN+AUnPlA0=
X-Received: by 2002:a2e:240b:0:b0:29c:9226:33f7 with SMTP id
 k11-20020a2e240b000000b0029c922633f7mr556512ljk.1.1679642350532; Fri, 24 Mar
 2023 00:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230323221948.352154-1-corbet@lwn.net> <20230323221948.352154-6-corbet@lwn.net>
 <271b00b7-fa10-fc2c-3929-c533a41bb22a@loongson.cn>
In-Reply-To: <271b00b7-fa10-fc2c-3929-c533a41bb22a@loongson.cn>
From:   Alex Shi <seakeel@gmail.com>
Date:   Fri, 24 Mar 2023 15:18:34 +0800
Message-ID: <CAJy-Am=BWE5fHg038tShduXQ4SaxqzRVUiWjYyj0ngxSH+JxFg@mail.gmail.com>
Subject: Re: [PATCH 5/6] docs: move openrisc documentation under Documentation/arch/
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, Alex Shi <alexs@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 9:43=E2=80=AFAM Yanteng Si <siyanteng@loongson.cn> =
wrote:
>
>
> =E5=9C=A8 3/24/23 06:19, Jonathan Corbet =E5=86=99=E9=81=93:
> > Architecture-specific documentation is being moved into Documentation/a=
rch/
> > as a way of cleaning up the top-level documentation directory and makin=
g
> > the docs hierarchy more closely match the source hierarchy.  Move
> > Documentation/openrisc into arch/ and fix all in-tree references.
> >
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Alex Shi <alexs@kernel.org>
> > Cc: Yanteng Si <siyanteng@loongson.cn>
> > Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Thanks for taking care!

Acked-by: Alex Shi <alexs@kernel.org>

>
>
> Thanks,
>
> Yanteng
>
> > ---
> >   Documentation/arch/index.rst                                  | 2 +-
> >   Documentation/{ =3D> arch}/openrisc/features.rst                | 0
> >   Documentation/{ =3D> arch}/openrisc/index.rst                   | 0
> >   Documentation/{ =3D> arch}/openrisc/openrisc_port.rst           | 0
> >   Documentation/{ =3D> arch}/openrisc/todo.rst                    | 0
> >   Documentation/translations/zh_CN/arch/index.rst               | 2 +-
> >   .../translations/zh_CN/{ =3D> arch}/openrisc/index.rst          | 4 +=
+--
> >   .../translations/zh_CN/{ =3D> arch}/openrisc/openrisc_port.rst  | 4 +=
+--
> >   Documentation/translations/zh_CN/{ =3D> arch}/openrisc/todo.rst | 4 +=
+--
> >   MAINTAINERS                                                   | 2 +-
> >   10 files changed, 9 insertions(+), 9 deletions(-)
> >   rename Documentation/{ =3D> arch}/openrisc/features.rst (100%)
> >   rename Documentation/{ =3D> arch}/openrisc/index.rst (100%)
> >   rename Documentation/{ =3D> arch}/openrisc/openrisc_port.rst (100%)
> >   rename Documentation/{ =3D> arch}/openrisc/todo.rst (100%)
> >   rename Documentation/translations/zh_CN/{ =3D> arch}/openrisc/index.r=
st (79%)
> >   rename Documentation/translations/zh_CN/{ =3D> arch}/openrisc/openris=
c_port.rst (97%)
> >   rename Documentation/translations/zh_CN/{ =3D> arch}/openrisc/todo.rs=
t (88%)
> >
> > diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rs=
t
> > index 792f58e30f25..65945daa40fe 100644
> > --- a/Documentation/arch/index.rst
> > +++ b/Documentation/arch/index.rst
> > @@ -17,7 +17,7 @@ implementation.
> >      ../m68k/index
> >      ../mips/index
> >      ../nios2/index
> > -   ../openrisc/index
> > +   openrisc/index
> >      ../parisc/index
> >      ../powerpc/index
> >      ../riscv/index
> > diff --git a/Documentation/openrisc/features.rst b/Documentation/arch/o=
penrisc/features.rst
> > similarity index 100%
> > rename from Documentation/openrisc/features.rst
> > rename to Documentation/arch/openrisc/features.rst
> > diff --git a/Documentation/openrisc/index.rst b/Documentation/arch/open=
risc/index.rst
> > similarity index 100%
> > rename from Documentation/openrisc/index.rst
> > rename to Documentation/arch/openrisc/index.rst
> > diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/a=
rch/openrisc/openrisc_port.rst
> > similarity index 100%
> > rename from Documentation/openrisc/openrisc_port.rst
> > rename to Documentation/arch/openrisc/openrisc_port.rst
> > diff --git a/Documentation/openrisc/todo.rst b/Documentation/arch/openr=
isc/todo.rst
> > similarity index 100%
> > rename from Documentation/openrisc/todo.rst
> > rename to Documentation/arch/openrisc/todo.rst
> > diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Document=
ation/translations/zh_CN/arch/index.rst
> > index aa53dcff268e..7e59af567331 100644
> > --- a/Documentation/translations/zh_CN/arch/index.rst
> > +++ b/Documentation/translations/zh_CN/arch/index.rst
> > @@ -11,7 +11,7 @@
> >      ../mips/index
> >      ../arm64/index
> >      ../riscv/index
> > -   ../openrisc/index
> > +   openrisc/index
> >      ../parisc/index
> >      ../loongarch/index
> >
> > diff --git a/Documentation/translations/zh_CN/openrisc/index.rst b/Docu=
mentation/translations/zh_CN/arch/openrisc/index.rst
> > similarity index 79%
> > rename from Documentation/translations/zh_CN/openrisc/index.rst
> > rename to Documentation/translations/zh_CN/arch/openrisc/index.rst
> > index 9ad6cc600884..da21f8ab894b 100644
> > --- a/Documentation/translations/zh_CN/openrisc/index.rst
> > +++ b/Documentation/translations/zh_CN/arch/openrisc/index.rst
> > @@ -1,8 +1,8 @@
> >   .. SPDX-License-Identifier: GPL-2.0
> >
> > -.. include:: ../disclaimer-zh_CN.rst
> > +.. include:: ../../disclaimer-zh_CN.rst
> >
> > -:Original: Documentation/openrisc/index.rst
> > +:Original: Documentation/arch/openrisc/index.rst
> >
> >   :=E7=BF=BB=E8=AF=91:
> >
> > diff --git a/Documentation/translations/zh_CN/openrisc/openrisc_port.rs=
t b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
> > similarity index 97%
> > rename from Documentation/translations/zh_CN/openrisc/openrisc_port.rst
> > rename to Documentation/translations/zh_CN/arch/openrisc/openrisc_port.=
rst
> > index b8a67670492d..cadc580fa23b 100644
> > --- a/Documentation/translations/zh_CN/openrisc/openrisc_port.rst
> > +++ b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
> > @@ -1,6 +1,6 @@
> > -.. include:: ../disclaimer-zh_CN.rst
> > +.. include:: ../../disclaimer-zh_CN.rst
> >
> > -:Original: Documentation/openrisc/openrisc_port.rst
> > +:Original: Documentation/arch/openrisc/openrisc_port.rst
> >
> >   :=E7=BF=BB=E8=AF=91:
> >
> > diff --git a/Documentation/translations/zh_CN/openrisc/todo.rst b/Docum=
entation/translations/zh_CN/arch/openrisc/todo.rst
> > similarity index 88%
> > rename from Documentation/translations/zh_CN/openrisc/todo.rst
> > rename to Documentation/translations/zh_CN/arch/openrisc/todo.rst
> > index 63c38717edb1..1f6f95616633 100644
> > --- a/Documentation/translations/zh_CN/openrisc/todo.rst
> > +++ b/Documentation/translations/zh_CN/arch/openrisc/todo.rst
> > @@ -1,6 +1,6 @@
> > -.. include:: ../disclaimer-zh_CN.rst
> > +.. include:: ../../disclaimer-zh_CN.rst
> >
> > -:Original: Documentation/openrisc/todo.rst
> > +:Original: Documentation/arch/openrisc/todo.rst
> >
> >   :=E7=BF=BB=E8=AF=91:
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cf4eb913ea12..64ea94536f4c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15638,7 +15638,7 @@ S:    Maintained
> >   W:  http://openrisc.io
> >   T:  git https://github.com/openrisc/linux.git
> >   F:  Documentation/devicetree/bindings/openrisc/
> > -F:   Documentation/openrisc/
> > +F:   Documentation/arch/openrisc/
> >   F:  arch/openrisc/
> >   F:  drivers/irqchip/irq-ompic.c
> >   F:  drivers/irqchip/irq-or1k-*
>
