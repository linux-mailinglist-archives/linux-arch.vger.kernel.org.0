Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF634C12FE
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 13:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiBWMnH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 07:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiBWMnG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 07:43:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CE535DED;
        Wed, 23 Feb 2022 04:42:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B910761179;
        Wed, 23 Feb 2022 12:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F58BC340F1;
        Wed, 23 Feb 2022 12:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645620158;
        bh=vfHK+gkNDrAvQXi1VtrHdfwiLvh+3euoD4Z2MIR/0m0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O/3TthIL4XfWE4YBU4n+//W2s9Oow3MOp0B72JrNSWI9KdK60Fxzenp1OHUXkcfNg
         wQ7nSn9LwIWUM+G3FYGfPJNfyAsXufq6P/hrN4O65dMg+sODhN+Eq+xESdDU6kkZPn
         KGWyOsXBMn0QXs3d1k/784mt2AhszZ2hGQ24pD0l+ywIQ8PdW3Lv6NpsT3QhFcby8J
         IgUqm/pVBKu3CC3PrhVeIq9ZhkFShwNCPKjC2XoyoUGEOvbYj6krNNEmELypMGKImn
         A7z8e4rFe7arHT49oeRXRQiNaNFWqRLSlQSuF6qDCG+RKV0Sg8fWcV0Xrgo04qcTyl
         ivzYRC93uGpoA==
Received: by mail-vk1-f174.google.com with SMTP id x62so4366408vkg.6;
        Wed, 23 Feb 2022 04:42:38 -0800 (PST)
X-Gm-Message-State: AOAM531YwYtI9iDBDvlNUPjT8kU2y9b/HaDU8fp3bGlb95NKjgDCUCzW
        Y6qqFfmi2jzk7G1tB2c8rrU6pXWyD/UtnapWBGs=
X-Google-Smtp-Source: ABdhPJwiS2/TnUZj6eqhOkeNucJDlHqkwMwsfsk+suYlfmqT0vHvdSP7AQRVGgao7f8HjSLljPJQRV0WirIw6+DTixk=
X-Received: by 2002:a05:6122:887:b0:332:699e:7e67 with SMTP id
 7-20020a056122088700b00332699e7e67mr1166442vkf.35.1645620157156; Wed, 23 Feb
 2022 04:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20220201150545.1512822-1-guoren@kernel.org> <20220201150545.1512822-18-guoren@kernel.org>
 <4379941.LvFx2qVVIh@eto.sf-tec.de>
In-Reply-To: <4379941.LvFx2qVVIh@eto.sf-tec.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 23 Feb 2022 20:42:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRcfvd6Sin=3Dv91WZO6DxLsUsB=ap+F1WehKb6=w5fkA@mail.gmail.com>
Message-ID: <CAJF2gTRcfvd6Sin=3Dv91WZO6DxLsUsB=ap+F1WehKb6=w5fkA@mail.gmail.com>
Subject: Re: [PATCH V5 17/21] riscv: compat: vdso: Add setup additional pages implementation
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 8:19 PM Rolf Eike Beer <eb@emlix.com> wrote:
>
> > @@ -66,35 +68,35 @@ static int vdso_mremap(const struct vm_special_mapp=
ing
> > *sm, return 0;
> >  }
> >
> > -static int __init __vdso_init(void)
> > +static int __init __vdso_init(struct __vdso_info *vdso_info)
> >  {
> >       unsigned int i;
> >       struct page **vdso_pagelist;
> >       unsigned long pfn;
> >
> > -     if (memcmp(vdso_info.vdso_code_start, "\177ELF", 4)) {
> > +     if (memcmp(vdso_info->vdso_code_start, "\177ELF", 4)) {
> >               pr_err("vDSO is not a valid ELF object!\n");
> >               return -EINVAL;
> >       }
> >
>
> Does anyone actually guarantee that this is at least this 4 bytes long?

You can ref:
arch/arm64/kernel/vdso.c
arch/arm/kernel/vdso.c
arch/nds32/kernel/vdso.c

and in arch/powerpc/boot/elf.h:
arch/powerpc/kernel/fadump.c:   memcpy(elf->e_ident, ELFMAG, SELFMAG);
arch/powerpc/boot/elf.h:#define ELFMAG0         0x7f    /* EI_MAG */
arch/powerpc/boot/elf.h:#define ELFMAG1         'E'
arch/powerpc/boot/elf.h:#define ELFMAG2         'L'
arch/powerpc/boot/elf.h:#define ELFMAG3         'F'
arch/powerpc/boot/elf.h:#define ELFMAG          "\177ELF"
arch/powerpc/boot/elf.h:#define SELFMAG         4


>
> Eike
> --
> Rolf Eike Beer, emlix GmbH, https://www.emlix.com
> Fon +49 551 30664-0, Fax +49 551 30664-11
> Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
> Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 31=
60
> Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-Id=
Nr.: DE 205 198 055
>
> emlix - smart embedded open source



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
