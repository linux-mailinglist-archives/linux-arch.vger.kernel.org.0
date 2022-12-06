Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA1643C70
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 05:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiLFEkB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 23:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiLFEjc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 23:39:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDEDB46;
        Mon,  5 Dec 2022 20:39:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD84AB8169B;
        Tue,  6 Dec 2022 04:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8296AC4314A;
        Tue,  6 Dec 2022 04:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670301560;
        bh=Zi2TCrzV+lX+8o+6WmgyVR7dIbJ2bTSv5zbEP5K7Wdk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iDOGgKfh/Zzn6a+o1rB7sY2CO5hofYYcTk0ON4hrdw+ul8WIwKVFKmL3YELda0IOv
         GcIPQkCZVP1mgKOd4iHVJEeYxQ3VglNFpalDlnYCKez4+coQjGvYtH2WiweYxM8xWv
         UrGameoEwlLnmhdlg0P7zoxcYXdjgrWCrizqyZ7OCHk7Pb2F+A1yjyQjxSOBE4nLlS
         WtXj+E0TZUvunpL7Zb6XmaUUUGlhs6v9VMO4d/HGKMk39gkU9CO9Mt+5G3T8aRIFXP
         hFGq4Vzv1N1R8iy9xUChVT4+U8ilKe39cYPfIWgEzed0WBKv1HzY5wSWPV2dl1DEhL
         zLOsmFwfGszsQ==
Received: by mail-ej1-f54.google.com with SMTP id gh17so3361089ejb.6;
        Mon, 05 Dec 2022 20:39:20 -0800 (PST)
X-Gm-Message-State: ANoB5pnXUBbUjYo/fker113K4B4nSyIZyAOJluE6Bc0HzPhmMXIXxkPG
        zoVZmchDPtpX39OCGYJqtmAVwChHOqXrKHe29SY=
X-Google-Smtp-Source: AA0mqf4Cb25u2Un1Ox5XVVHNByWvhjp8cPyEPeNr0q4kwrVeEqYk1+Z15oDhYHUyijoAX5GuFOohSrGZy+x7dj+AIw0=
X-Received: by 2002:a17:906:b213:b0:7c0:f7af:7c5e with SMTP id
 p19-20020a170906b21300b007c0f7af7c5emr5607481ejz.406.1670301558699; Mon, 05
 Dec 2022 20:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20221103075047.1634923-1-guoren@kernel.org> <20221103075047.1634923-3-guoren@kernel.org>
 <87iliq9psg.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87iliq9psg.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Dec 2022 12:39:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT2mZePK4cmFqi-E8=R7g9kmnPqnYg-kNewqaEUDXMXUQ@mail.gmail.com>
Message-ID: <CAJF2gTT2mZePK4cmFqi-E8=R7g9kmnPqnYg-kNewqaEUDXMXUQ@mail.gmail.com>
Subject: Re: [PATCH -next V8 02/14] riscv: elf_kexec: Fixup compile warning
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
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

On Mon, Dec 5, 2022 at 5:13 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
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
>
> This patch shouldn't be part of the generic entry series. It's just a
> generic fix! Please have this as a separate patch.
Okay

>


--=20
Best Regards
 Guo Ren
