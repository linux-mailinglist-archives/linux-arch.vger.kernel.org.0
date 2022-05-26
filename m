Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708BD534786
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 02:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiEZAhI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 20:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345548AbiEZAfe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 20:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA3EABF79;
        Wed, 25 May 2022 17:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBFA9616B0;
        Thu, 26 May 2022 00:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD69C34117;
        Thu, 26 May 2022 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653525332;
        bh=Ub70rkaNu77ijQoyYKCRXS4Ea2ip8iV3HKvu4YbNWlM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pojJk6JMGa1thYQxtIyFREeWASDOVko4ZwaA7AyztUdQHkCA53Q2Oi3lx29yK6FT7
         34a5Dwa1a5+urSYRHq7cYmXTNcphsrutcrI2xHUOklTiIjZRHGo0cGVQI+Lz4SzmHV
         whuFCzWWG+Am5NtBTiEqKvCKacZ+lESbtUJamk2Rre4zWyI/ODaUsQfGvURB88c2xb
         HEL9J0zYjIIs4qVI07tTAJV90tKNEvD5WIur11kLmBPPDzLUbHtChIjv8UivY90nRT
         cEJzShDbYeCUggKumWO6yTsFL7Hh5OZ6kbd8D930uK5B+VPfLIVbnDP3BLGogKtR83
         frI1goyNxda8w==
Received: by mail-vs1-f52.google.com with SMTP id b7so55692vsq.1;
        Wed, 25 May 2022 17:35:32 -0700 (PDT)
X-Gm-Message-State: AOAM530L/1NPIsF1YhjAm1w2sPWc1fMI/D2J1XmQXH5PzySFoav2tzNz
        Ess1nM92eSWTLrNx+sLePZjqpBy5F3HWqjxvjjM=
X-Google-Smtp-Source: ABdhPJwVzqTYj6xG358bNh9cvbAIFKwsDdwfTwd6Q796CP21Si85Rf+f2j1K7L766fD0w3GaSopvx+HcUsV/LbeQkEI=
X-Received: by 2002:a67:c89c:0:b0:335:d83b:df76 with SMTP id
 v28-20020a67c89c000000b00335d83bdf76mr12994381vsk.51.1653525331287; Wed, 25
 May 2022 17:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <a0bffec3-cf43-417e-3804-9248325266c3@roeck-us.net> <mhng-b37ccc06-67ad-4fd8-bcdb-0e5c9e5a4750@palmer-ri-x1c9>
In-Reply-To: <mhng-b37ccc06-67ad-4fd8-bcdb-0e5c9e5a4750@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 26 May 2022 08:35:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRPPTE0uHC=6iSW7AR6aESF9Zb1==RZ9xm_JW4itjP+rw@mail.gmail.com>
Message-ID: <CAJF2gTRPPTE0uHC=6iSW7AR6aESF9Zb1==RZ9xm_JW4itjP+rw@mail.gmail.com>
Subject: Re: [PATCH] riscv: compat: Using seperated vdso_maps for compat_vdso_info
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 26, 2022 at 5:34 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 25 May 2022 14:15:03 PDT (-0700), linux@roeck-us.net wrote:
> > On 5/25/22 09:04, guoren@kernel.org wrote:
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> This is a fixup for vdso implementation which caused musl to
> >> fail.
> >>
> >> [   11.600082] Run /sbin/init as init process
> >> [   11.628561] init[1]: unhandled signal 11 code 0x1 at
> >> 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
> >> [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
> >> 5.18.0-rc7-next-20220520 #1
> >> [   11.629462] Hardware name: riscv-virtio,qemu (DT)
> >> [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
> >> 00ffffffc58199f0
> >> [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
> >> ffffffffffffffff
> >> [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
> >> 00ffffff8ade0cc0
> >> [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
> >> 00ffffffc5819a00
> >> [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
> >> 00ffffffc5819b00
> >> [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
> >> 0000000000000000
> >> [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
> >> 00ffffff8ade0728
> >> [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
> >> 00ffffffc5819e40
> >> [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
> >> 0000000000000000
> >> [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
> >> 0000000000000001
> >> [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
> >> [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
> >> cause: 000000000000000d
> >>
> >> The last __vdso_init(&compat_vdso_info) replaces the data in normal
> >> vdso_info. This is an obvious bug.
> >>
> >> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >> Signed-off-by: Guo Ren <guoren@kernel.org>
> >> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >> Cc: Heiko St=C3=BCbner <heiko@sntech.de>
> >
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> Sorry I'm a bit buried right now, this is fixing the issue you pointed
> out earlier?
I've updated patch V2, please use that, thx.
https://lore.kernel.org/linux-riscv/20220526003339.2948309-1-guoren@kernel.=
org/T/#u

>
> >
> >> ---
> >>   arch/riscv/kernel/vdso.c | 15 +++++++++++++--
> >>   1 file changed, 13 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> >> index 50fe4c877603..69b05b6c181b 100644
> >> --- a/arch/riscv/kernel/vdso.c
> >> +++ b/arch/riscv/kernel/vdso.c
> >> @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_i=
nit =3D {
> >>   };
> >>
> >>   #ifdef CONFIG_COMPAT
> >> +static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_ini=
t =3D {
> >> +    [RV_VDSO_MAP_VVAR] =3D {
> >> +            .name   =3D "[vvar]",
> >> +            .fault =3D vvar_fault,
> >> +    },
> >> +    [RV_VDSO_MAP_VDSO] =3D {
> >> +            .name   =3D "[vdso]",
> >> +            .mremap =3D vdso_mremap,
> >> +    },
> >> +};
> >> +
> >>   static struct __vdso_info compat_vdso_info __ro_after_init =3D {
> >>      .name =3D "compat_vdso",
> >>      .vdso_code_start =3D compat_vdso_start,
> >>      .vdso_code_end =3D compat_vdso_end,
> >> -    .dm =3D &rv_vdso_maps[RV_VDSO_MAP_VVAR],
> >> -    .cm =3D &rv_vdso_maps[RV_VDSO_MAP_VDSO],
> >> +    .dm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
> >> +    .cm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
> >>   };
> >>   #endif
> >>



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
