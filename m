Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7AA12B91
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 12:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfECKhP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 May 2019 06:37:15 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:53170 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfECKhP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 06:37:15 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x43AbBq2016654;
        Fri, 3 May 2019 19:37:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x43AbBq2016654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556879832;
        bh=nx8pRpSymsndYyxiLURa2CmLp1S0V3DIvOeXzS6J2dI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z9DJFCMs9SiG0ydN+PixilbR52yYIyY2zfsPB4K9H9YDIZeaiO0+73EV37BI4dbKT
         RIwY8tmNwZeXEt9//bhIvkYWIhfW2IkzzH771aRBvscTu9GEHoQzcpjJ2/mceswuyA
         UoYtEVm+7rpwbX9TsIqHs2aB8WSYzGo289mkk2MluGxo+kQWlVOI55hY8Uc1/aDk5X
         VYekSVunoIfpqxu37gsIlPVBJYa9z5MOVA54gyFomljDwfKI1uhys53T6nwrTJ2nVq
         QylcF8PTyIHK9LgKR9vf+WBxHVRuogdZ50YluV2ZhEOzEo2Cd+9/7v8nhX6EqBk386
         v5ePSyPvmuTQQ==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id z145so3291977vsc.0;
        Fri, 03 May 2019 03:37:12 -0700 (PDT)
X-Gm-Message-State: APjAAAUcb1r14WV2VMX5meLM6hz5ZlDcxSX13qDP/jbuq8f9E19kt8PS
        6+vaO35sWVd8P44+AacBfclE9BU2bj5eVDYJjBs=
X-Google-Smtp-Source: APXvYqwW2Xu7GuqfKtmc5UNaxfQ7dLxglJaqeji2MUglK/C6WjCbAXsTf0Y6inBC5zIGxhOWML+vIGWkcTtVvMWlajs=
X-Received: by 2002:a67:ee98:: with SMTP id n24mr4943708vsp.155.1556879831230;
 Fri, 03 May 2019 03:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-6-yamada.masahiro@socionext.com> <20190502161346.07c15187@xps13>
In-Reply-To: <20190502161346.07c15187@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 3 May 2019 19:36:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQH8v8_HG6-cytT4qe05W9iiYwEP1mud4zG2NxxYcFptQ@mail.gmail.com>
Message-ID: <CAK7LNAQH8v8_HG6-cytT4qe05W9iiYwEP1mud4zG2NxxYcFptQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 05/11] mtd: rawnand: vf610_nfc: add initializer
 to avoid -Wmaybe-uninitialized
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>, X86 ML <x86@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Miquel,

On Thu, May 2, 2019 at 11:14 PM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 23 Apr
> 2019 12:49:53 +0900:
>
> > This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> > place. We need to eliminate potential issues beforehand.
> >
> > Kbuild test robot has never reported -Wmaybe-uninitialized warning
> > for this probably because vf610_nfc_run() is inlined by the x86
> > compiler's inlining heuristic.
> >
> > If CONFIG_OPTIMIZE_INLINING is enabled for a different architecture
> > and vf610_nfc_run() is not inlined, the following warning is reported:
> >
> > drivers/mtd/nand/raw/vf610_nfc.c: In function =E2=80=98vf610_nfc_cmd=E2=
=80=99:
> > drivers/mtd/nand/raw/vf610_nfc.c:455:3: warning: =E2=80=98offset=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
> >    vf610_nfc_rd_from_sram(instr->ctx.data.buf.in + offset,
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >             nfc->regs + NFC_MAIN_AREA(0) + offset,
> >             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >             trfr_sz, !nfc->data_access);
> >             ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> IMHO this patch has no dependencies with this series.


This patch is the prerequisite for 11/11.
https://lore.kernel.org/patchwork/patch/1064959/


Without the correct patch order,
the kbuild test robot reports the warning.


> Would you mind sending it alone with the proper Fixes tag?


I do not think Fixes is necessary.

Nobody has noticed this potential issue before.
Without 11/11, probably we cannot reproduce this warning.


BTW, this series has been for a while in linux-next.


>
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Changes in v3: None
> > Changes in v2:
> >   - split into a separate patch
> >
> >  drivers/mtd/nand/raw/vf610_nfc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf=
610_nfc.c
> > index a662ca1970e5..19792d725ec2 100644
> > --- a/drivers/mtd/nand/raw/vf610_nfc.c
> > +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> > @@ -364,7 +364,7 @@ static int vf610_nfc_cmd(struct nand_chip *chip,
> >  {
> >       const struct nand_op_instr *instr;
> >       struct vf610_nfc *nfc =3D chip_to_nfc(chip);
> > -     int op_id =3D -1, trfr_sz =3D 0, offset;
> > +     int op_id =3D -1, trfr_sz =3D 0, offset =3D 0;
> >       u32 col =3D 0, row =3D 0, cmd1 =3D 0, cmd2 =3D 0, code =3D 0;
> >       bool force8bit =3D false;
> >
>
> Thanks,
> Miqu=C3=A8l
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--
Best Regards

Masahiro Yamada
