Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1EE63BD09
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 10:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiK2Jfl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Nov 2022 04:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiK2Jfl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 04:35:41 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DBA4B999;
        Tue, 29 Nov 2022 01:35:39 -0800 (PST)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2AT9ZGvg004300;
        Tue, 29 Nov 2022 18:35:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2AT9ZGvg004300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669714517;
        bh=Q7xi3f1N/meKASk0USS2l24LMBp1S+Lf4JZEEmqBqZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iu8wmfQ9D9rAAP7mWoxw8h2LRApApWINFKiihUGcgIGNK6jfBtoHWQSIZUwKwnOzw
         irqBc87cUAgwfQsoXxDTNDKChTNvOgC2zN9AyEIG2+SrZMU6IrkURbPJduSqZzTB/o
         oW8JeTFZM181JJ9lApleFQO0De+uRb+LMneWY270NsVUqAjcnskpvP4jwAYAFT5NaF
         uqypyS06NXu8ZhU4bbr7J1fxnJ2CPjLsJSMa1Ap4zgT/D2YWQaLWFANo0VQWnS6zzv
         yqsK0FhWsh2tC5qBcCTQnCOyb6/mZTH0S3p4pEc2qXLrPLa9h62jvbb1yBmqluoBHO
         9oAa/hU17XPbg==
X-Nifty-SrcIP: [209.85.160.46]
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1432a5f6468so16306544fac.12;
        Tue, 29 Nov 2022 01:35:16 -0800 (PST)
X-Gm-Message-State: ANoB5pmHVCvNIno/pewCzRQEttFs7J+F+I64adixn0BU6fkQ2GhmmQr5
        fUACLT+3zeFst3kQNG/r4NOdFQDBBEKwFBIhvQU=
X-Google-Smtp-Source: AA0mqf6J+oTxURdJK5Agpkp0/EJAXlORqpOujR9dCeA/lWt4niw0dV/3a7s/MpqS4A7v0PXydp7QwqhjqqWdkA57n28=
X-Received: by 2002:a05:6870:ea8e:b0:13b:a31f:45fd with SMTP id
 s14-20020a056870ea8e00b0013ba31f45fdmr33753310oap.194.1669714515803; Tue, 29
 Nov 2022 01:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20221126051002.123199-1-linux@weissschuh.net> <20221126051002.123199-2-linux@weissschuh.net>
 <03859890-bf90-4ad0-1926-4b8cb8dbfa57@csgroup.eu> <8f8b12fd-2e25-49e4-a1fa-247f08f56454@t-8ch.de>
 <87r0xoatrg.fsf@mpe.ellerman.id.au>
In-Reply-To: <87r0xoatrg.fsf@mpe.ellerman.id.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 29 Nov 2022 18:34:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjaVerkr8GFVFQwqGnjC1Jz23E+C5f9+0LTLhX4gNmZA@mail.gmail.com>
Message-ID: <CAK7LNATjaVerkr8GFVFQwqGnjC1Jz23E+C5f9+0LTLhX4gNmZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc/book3e: remove #include <generated/utsrelease.h>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 28, 2022 at 7:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
>
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:
> > On 2022-11-26 07:36+0000, Christophe Leroy wrote:
> >> Le 26/11/2022 =C3=A0 06:10, Thomas Wei=C3=9Fschuh a =C3=A9crit :
> >>> Commit 7ad4bd887d27 ("powerpc/book3e: get rid of #include <generated/=
compile.h>")
> >>> removed the usage of the define UTS_VERSION but forgot to drop the
> >>> include.
> >>
> >> What about:
> >> arch/powerpc/platforms/52xx/efika.c
> >> arch/powerpc/platforms/amigaone/setup.c
> >> arch/powerpc/platforms/chrp/setup.c
> >> arch/powerpc/platforms/powermac/bootx_init.c
> >>
> >> I believe you can do a lot more than what you did in your series.
> >
> > The commit messages are wrong.
> > They should have said UTS_RELEASE instead of UTS_VERSION.
> >
> > Could the maintainers fix this up when applying?
> > I also changed it locally so it will be fixed for v2.
>
> I'll take this patch, but not the others.
>
> cheers


Okay, I applied 1/3 and 3/3 to the kbuild tree.




--=20
Best Regards
Masahiro Yamada
