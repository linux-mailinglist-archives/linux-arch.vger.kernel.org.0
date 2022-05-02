Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE25168F4
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 02:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356196AbiEBAFK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 20:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEBAFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 20:05:09 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAE162FC;
        Sun,  1 May 2022 17:01:42 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id c62so12314720vsc.10;
        Sun, 01 May 2022 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Td4oiGEn76YE86E1aORkuCrqQirCdqspkzlKcZCyrY=;
        b=fU4yq50q2lQ3XuLdj/qGGDFPc8g3IoPe3R2fNAkZYkADZWlCeJmGai2z8oB95Enj+b
         OAzgPYD1lDelMiSIQF4I3d2B4Yuq17YQOZmcgwWc1WtWrNe4O2rH0dWEvYZhkPw6m6PG
         69a6QFQxB8lOvHNxX/Ekl5xo1FNp0BdDP2y+9oOzmzq+KlMPxk1JK2Y0uve70rsaeLG+
         e3z6JWucbF9VjgBbKKGxAoSjDoC9cg58D8NwJSw6Hsccu5cvBQQo3qKdww8iAiAtoXnR
         VevmJKMpGDEhaAHxqQSjDAbyNAkcAW9mvgZtvAqUGOyazA7ML4VAegw68uB3Rserr6Va
         4AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Td4oiGEn76YE86E1aORkuCrqQirCdqspkzlKcZCyrY=;
        b=IJYVS+x28iBgXfCAU+Mll9cx1wOsMZq8vhS2bgAFyBRvVh1KuR5rnclTHXRjETUunF
         8tYjPFw+tmnbudLiVWcpcKnqUc9OEFZQP1k/UJn9x71oZMVjo61TMaoFOVKM7DyGiDFQ
         osGbHGPXkhZWy5T8oLGGlerapi4Pu3pd5xoItl0udeg/ExJM0jKGGiHGPmxnF4MtrOi1
         qU1O4Mj22dvwB/hg2uc270+Z0x06oZRq+i/fE9D9/ITGVtp/0Qa5rlMRUYId2sDzGxO6
         Vz72aPPgEJfOyt9vJQKT2cg6koUT4lMHCgq3Gmm7qzEZw4UzF3PAakpB0TOci5IytAw/
         Qlqg==
X-Gm-Message-State: AOAM532ifm8zagSPZqsqkNhzQWy7V3rmVyo/zAq2utjwwuq2IgKSDOpG
        UzfGaqGV7O2EKp0Y8vKXwFJzcXdeTNALiOhdvpE=
X-Google-Smtp-Source: ABdhPJx1LTNtGjC4S/dJvwCxmfi42wRxvYaWkAkZZY1UkYum9sFJturAmVyB2ut7y9HxV6wtSJLcf6hlza0EMjoIuyE=
X-Received: by 2002:a67:be0b:0:b0:32c:d82f:6723 with SMTP id
 x11-20020a67be0b000000b0032cd82f6723mr2711106vsq.67.1651449701274; Sun, 01
 May 2022 17:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-11-chenhuacai@loongson.cn> <4dd26d88b807c967dbbc81a7b2e5f4084d9603d7.camel@mengyan1223.wang>
 <2a534c89b3c905a34f947fb2739d58c9373bb915.camel@mengyan1223.wang>
In-Reply-To: <2a534c89b3c905a34f947fb2739d58c9373bb915.camel@mengyan1223.wang>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 2 May 2022 08:01:31 +0800
Message-ID: <CAAhV-H5vviww-h7BuhCitHVGeExjMOuWaap=iAc9ekqJzppgwQ@mail.gmail.com>
Subject: Re: [PATCH V9 10/24] LoongArch: Add exception/interrupt handling
To:     Xi Ruoyao <xry111@mengyan1223.wang>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ruoyao,

On Mon, May 2, 2022 at 1:08 AM Xi Ruoyao <xry111@mengyan1223.wang> wrote:
>
> On Mon, 2022-05-02 at 00:27 +0800, Xi Ruoyao wrote:
> > On Sat, 2022-04-30 at 17:05 +0800, Huacai Chen wrote:
> > > +struct acpi_madt_lio_pic;
> > > +struct acpi_madt_eio_pic;
> > > +struct acpi_madt_ht_pic;
> > > +struct acpi_madt_bio_pic;
> > > +struct acpi_madt_msi_pic;
> > > +struct acpi_madt_lpc_pic;
> >
> > Where are those defined?  I can't find them and the compilation fails
> > with:
> >
> > arch/loongarch/kernel/irq.c: In function =E2=80=98find_pch_pic=E2=80=99=
:
> > arch/loongarch/kernel/irq.c:48:32: error: invalid use of undefined
> > type =E2=80=98struct acpi_madt_bio_pic=E2=80=99
> >    48 |                 start =3D irq_cfg->gsi_base;
> >       |                                ^~
> > arch/loongarch/kernel/irq.c:49:32: error: invalid use of undefined
> > type =E2=80=98struct acpi_madt_bio_pic=E2=80=99
> >    49 |                 end   =3D irq_cfg->gsi_base + irq_cfg->size;
> >       |                                ^~
> > arch/loongarch/kernel/irq.c:49:52: error: invalid use of undefined
> > type =E2=80=98struct acpi_madt_bio_pic=E2=80=99
> >    49 |                 end   =3D irq_cfg->gsi_base + irq_cfg->size;
> >       |                                                    ^~
>
> Alright, my bad... I didn't realize the LoongArch patches are splitted
> into multiple series for multiple lists.  But is this the SOP of kernel
> patch reviewing?  Would it be easier to just send one series and CC all
> relevent lists?
The acpi stuff should go to acpica project first, then Rafael sync the
code to the kernel. The current status is acpica has merged LoongArch
support, but hasn't yet gone to the kernel.
ACPI: Add LoongArch-related definitions by chenhuacai =C2=B7 Pull Request
#757 =C2=B7 acpica/acpica =C2=B7 GitHub

Huacai
>
> --
> Xi Ruoyao <xry111@mengyan1223.wang>
> School of Aerospace Science and Technology, Xidian University
