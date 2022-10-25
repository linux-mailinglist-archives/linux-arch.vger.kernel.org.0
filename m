Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA160C1C5
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 04:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJYChL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 22:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJYChK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 22:37:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C97264BA;
        Mon, 24 Oct 2022 19:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D16061712;
        Tue, 25 Oct 2022 02:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CC5C43150;
        Tue, 25 Oct 2022 02:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666665427;
        bh=JA84N9WO2TmET99sX5eCB++lHmqV7Efj8StS7V4zZrE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D3OuhF34gR5RgDg2U60zsEBErN9HIETg1Rf/pWQXpywrPyt9e9CyR6lMIaoooUNPb
         hBEJzjLEKtaVeO8ua8TNszqaOqlJZm1k8nOrs9qSgnU1zBM8zFIMIf0+qwQ0fSGwDS
         Lo/6ffITsfoveHLpafnRWJ9YuCV5+0FA5kHTXJjSR5KkDXrphTGwG79aqS/jj49631
         WRPFBKGlOgdMoU9cOLXGhr2kR5zKsqEMjlYW0Jrq6/iMW230SvsMv1JSXQIO4MAyc/
         ZP05LuEVMjfASExdgIs1GcHWYZPjgh3UMmow7affjM6+ea9WcLHsNhsSOi2Gn0vRue
         H3+Ncm1wbhpOA==
Received: by mail-oo1-f51.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so1651752oop.3;
        Mon, 24 Oct 2022 19:37:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf1KtJIMA6h3AV0f6JyCySlBmqlRFV4JZVA2GB26LrwfaGhDLkNB
        k3CJVrzih2HWvnCESXcY64LyYeQVWrVBXaTtmKQ=
X-Google-Smtp-Source: AMsMyM5IoTpxXuNt5TpA0kB/nNR4wZxH/vqFwOrKOI+KR3Vs1NONL8jFM/czimrMdFZ5XFBgHPX+HjIY2v8RdsoAcXE=
X-Received: by 2002:a4a:2144:0:b0:481:a4:d2b0 with SMTP id u65-20020a4a2144000000b0048100a4d2b0mr8825891oou.48.1666665426275;
 Mon, 24 Oct 2022 19:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221002012451.2351127-1-guoren@kernel.org> <20221002012451.2351127-2-guoren@kernel.org>
 <f0785930-8f2a-9d09-4dbf-545d11994cbe@huawei.com>
In-Reply-To: <f0785930-8f2a-9d09-4dbf-545d11994cbe@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 25 Oct 2022 10:36:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQLBycxqXfguWpSeNANiJ2ReMraNp_jaCd2UtWT8Oknqw@mail.gmail.com>
Message-ID: <CAJF2gTQLBycxqXfguWpSeNANiJ2ReMraNp_jaCd2UtWT8Oknqw@mail.gmail.com>
Subject: Re: [PATCH V6 01/11] riscv: elf_kexec: Fixup compile warning
To:     "liaochang (A)" <liaochang1@huawei.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 25, 2022 at 9:20 AM liaochang (A) <liaochang1@huawei.com> wrote=
:
>
>
>
> =E5=9C=A8 2022/10/2 9:24, guoren@kernel.org =E5=86=99=E9=81=93:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > If CRYTPO or CRYPTO_SHA256 or KEXE_FILE is not enabled, then:
> >
> > COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross W=
=3D1
> > O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash arch/riscv/
> >
> > ../arch/riscv/kernel/elf_kexec.c: In function 'elf_kexec_load':
> > ../arch/riscv/kernel/elf_kexec.c:185:23: warning: variable
> > 'kernel_start' set but not used [-Wunused-but-set-variable]
> >   185 |         unsigned long kernel_start;
> >       |                       ^~~~~~~~~~~~
> >
> > Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  arch/riscv/kernel/elf_kexec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexe=
c.c
> > index 0cb94992c15b..4b9264340b78 100644
> > --- a/arch/riscv/kernel/elf_kexec.c
> > +++ b/arch/riscv/kernel/elf_kexec.c
> > @@ -198,7 +198,7 @@ static void *elf_kexec_load(struct kimage *image, c=
har *kernel_buf,
> >       if (ret)
> >               goto out;
> >       kernel_start =3D image->start;
> > -     pr_notice("The entry point of kernel at 0x%lx\n", image->start);
> > +     pr_notice("The entry point of kernel at 0x%lx\n", kernel_start);
> >
> >       /* Add the kernel binary to the image */
> >       ret =3D riscv_kexec_elf_load(image, &ehdr, &elf_info,
>
> LGTM
>
> Reviewed-by: Liao Chang <liaochang1@huawei.com>
Thx

>
> --
> BR,
> Liao, Chang



--=20
Best Regards
 Guo Ren
