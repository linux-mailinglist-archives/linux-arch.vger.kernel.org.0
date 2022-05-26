Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D154553480C
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 03:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbiEZBYS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 21:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbiEZBYR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 21:24:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4C92D14;
        Wed, 25 May 2022 18:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C2C6B81EAA;
        Thu, 26 May 2022 01:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E43C385B8;
        Thu, 26 May 2022 01:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653528253;
        bh=h29Wpo9WNSSCClBqRvkE/1UDvwtQro2iV5ICekkFg0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lq0ShbnN+YfgeewLfidao5vTOxTotkeea5kPVa5N8KXw/v3m5XJA5kXf3aVoZRm1Q
         UJV48uuyo8r0ZeNL8knREPQ5cF3EUMNuIprAeBXur2+qIvrlYbWAYx4lG7/799Q7W5
         UTfAvGfZx0urlcekhigCkqcl5XrBkYvD6sF19dIvuY9SMGVXGy/jJ0Em37XkdA2G0V
         LZ6vZW+bGigAL8U59x8RPWBq8jwc2hBFvmhrvU/2Dj0lNfa7/GjMxzY/fSwasbLw5p
         ugwoDuIpi67X3I4pwpNe0o2bqgYqantvZFBFjydSTBrPqBUV1/dTrmpYc9UDYIo59J
         6rDABUbkg6dvA==
Received: by mail-vs1-f51.google.com with SMTP id h4so97152vsr.13;
        Wed, 25 May 2022 18:24:13 -0700 (PDT)
X-Gm-Message-State: AOAM533HUAwoFfcXgs57+wxNhr/rceqaP+8l2t0SR6KjVU6XUbRzkO7A
        +4hIbLX4P6wX1Eh0RS+5uVgTwIusM/foQ7s2ovs=
X-Google-Smtp-Source: ABdhPJzDBLXhCL5I+mYMzalA+1VZJA6Rk/32vZKSZkTuV6RAPU9mSbndplIQtMUmBRdymGunNwqmANVXOnUOInEmIS0=
X-Received: by 2002:a05:6102:151c:b0:337:d985:1764 with SMTP id
 f28-20020a056102151c00b00337d9851764mr4007910vsv.51.1653528252793; Wed, 25
 May 2022 18:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220526003339.2948309-1-guoren@kernel.org> <EC36D0A9-AE06-4C05-A31B-CC348881937D@jrtc27.com>
In-Reply-To: <EC36D0A9-AE06-4C05-A31B-CC348881937D@jrtc27.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 26 May 2022 09:24:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQvmKE5UYTmhQMd0MTF-CJm08_VHpcSqS7ik=MGtZ0Jag@mail.gmail.com>
Message-ID: <CAJF2gTQvmKE5UYTmhQMd0MTF-CJm08_VHpcSqS7ik=MGtZ0Jag@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: compat: Using seperated vdso_maps for compat_vdso_info
To:     Jessica Clarke <jrtc27@jrtc27.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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

On Thu, May 26, 2022 at 9:00 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 26 May 2022, at 01:33, guoren@kernel.org wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This is a fixup for vdso implementation which caused musl to
> > fail.
> >
> > [   11.600082] Run /sbin/init as init process
> > [   11.628561] init[1]: unhandled signal 11 code 0x1 at
> > 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
> > [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
> > 5.18.0-rc7-next-20220520 #1
> > [   11.629462] Hardware name: riscv-virtio,qemu (DT)
> > [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
> > 00ffffffc58199f0
> > [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
> > ffffffffffffffff
> > [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
> > 00ffffff8ade0cc0
> > [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
> > 00ffffffc5819a00
> > [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
> > 00ffffffc5819b00
> > [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
> > 0000000000000000
> > [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
> > 00ffffff8ade0728
> > [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
> > 00ffffffc5819e40
> > [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
> > 0000000000000000
> > [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
> > 0000000000000001
> > [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
> > [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
> > cause: 000000000000000d
> >
> > The last __vdso_init(&compat_vdso_info) replaces the data in normal
> > vdso_info. This is an obvious bug.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > Tested-by: Heiko St=C3=BCbner <heiko@sntech.de>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> > Changes in V2:
> > - Add Tested-by
> > - Rename vvar & vdso in /proc/<pid>/maps.
>
> Why? No other architecture renames it to that, and various pieces of
> software look for the magic [vdso] name, including GDB and LLDB, though
> by my count there are 57 source packages in Debian that contain the
> string literal "[vdso]" (including quotes), including Firefox,
> Android's ART, lvm2 and elfutils.
Opps, Thx for pointing this out. Abandon the version of the patch. @Palmer

>
> Jess
>
> > ---
> > arch/riscv/kernel/vdso.c | 15 +++++++++++++--
> > 1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> > index 50fe4c877603..957f164c9778 100644
> > --- a/arch/riscv/kernel/vdso.c
> > +++ b/arch/riscv/kernel/vdso.c
> > @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_in=
it =3D {
> > };
> >
> > #ifdef CONFIG_COMPAT
> > +static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init=
 =3D {
> > +     [RV_VDSO_MAP_VVAR] =3D {
> > +             .name   =3D "[compat vvar]",
> > +             .fault =3D vvar_fault,
> > +     },
> > +     [RV_VDSO_MAP_VDSO] =3D {
> > +             .name   =3D "[compat vdso]",
> > +             .mremap =3D vdso_mremap,
> > +     },
> > +};
> > +
> > static struct __vdso_info compat_vdso_info __ro_after_init =3D {
> >       .name =3D "compat_vdso",
> >       .vdso_code_start =3D compat_vdso_start,
> >       .vdso_code_end =3D compat_vdso_end,
> > -     .dm =3D &rv_vdso_maps[RV_VDSO_MAP_VVAR],
> > -     .cm =3D &rv_vdso_maps[RV_VDSO_MAP_VDSO],
> > +     .dm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
> > +     .cm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
> > };
> > #endif
> >
> > --
> > 2.36.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
