Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFBB5347BD
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 03:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbiEZBAz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 21:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbiEZBAw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 21:00:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE85B69CF7
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 18:00:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e2so289100wrc.1
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 18:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5TA2OkBhz4fpZ+xneLnEgQmjFfE9fpDr0ZbY4GJw0ZQ=;
        b=ngjsDrz/yXO+HZIkkuhS2JJUxmT3ktjUn6eljHR4XmffVXt5jrXCSTTSgsKbfi6Oe8
         JVBB11OTWoE93S5+sJxfHN82ZfWCnSjdakYKPMLRBcDEephAbzm6w/vAfCM6tvHou+bY
         vIlaEq3fftA4+gNfiQN2N51CUWAnT1lbgdCLfopkfG2HNhDd6SG6dASl41YkNbhGbZwO
         qbggID4XYAuShraxgUDiMdYtL9HgzC3hPzowZ2J4C0FC4oR8ZNwOk/JGzX1lvtMzvWpY
         FH5qoQSlqMMrUB3AyOY8r6RA6molqT2tOwvmPP8foHwZlMm2PwKcRSUKjwGr0KJalr7x
         c4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5TA2OkBhz4fpZ+xneLnEgQmjFfE9fpDr0ZbY4GJw0ZQ=;
        b=50YgMtKNsbSOE7K8etaXVT8LVgiqmiPiizK052tAEMYk8XwuzP2GaCt1K3Ru8AIT+B
         jVmoiYwDhyQLwC0MTDLp86Dy6br4+8fcDTyQQ5EbDXUQq+idhAIQhB3EDnywjQlcJOu0
         SmsRqRjcAN/KA8AaUoe/Kk0BGW0Y7aZMUHwe+rvrR7An0W9EMXLbtu2hL83XLHkF/q5+
         ASAJ7eSZ8kM03d9eMxUjtalmdN/+HncrlkWXN4Qgdh1aGYOYFrrtJPmpSZzPPy4cZDO+
         3AK/8oJQAcC7RhrgNvC86fwgScd7/SJHQ4Ht+V+RMDMxW17OCy64punw++dLjJanTK5c
         0rVA==
X-Gm-Message-State: AOAM532c/Wh5WfxkccXk/rq+FMAkj1k72a0XUo59EEbH89dcRrMeqEcb
        aUKIq7Bliahl4646b8cX42qW+w==
X-Google-Smtp-Source: ABdhPJwrr5kdZD/ajpIquLCdox7ixE/4glrnxGMAf06db+1JZf7fpvikkIUX1ABOhaXULz4UbDL58w==
X-Received: by 2002:a5d:4601:0:b0:20d:53a:2f39 with SMTP id t1-20020a5d4601000000b0020d053a2f39mr28779139wrq.347.1653526850400;
        Wed, 25 May 2022 18:00:50 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id v23-20020a7bcb57000000b003958af7d0c8sm213205wmj.45.2022.05.25.18.00.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 May 2022 18:00:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH V2] riscv: compat: Using seperated vdso_maps for
 compat_vdso_info
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220526003339.2948309-1-guoren@kernel.org>
Date:   Thu, 26 May 2022 02:00:49 +0100
Cc:     palmer@rivosinc.com, arnd@arndb.de, linux@roeck-us.net,
        palmer@dabbelt.com, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC36D0A9-AE06-4C05-A31B-CC348881937D@jrtc27.com>
References: <20220526003339.2948309-1-guoren@kernel.org>
To:     guoren@kernel.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 26 May 2022, at 01:33, guoren@kernel.org wrote:
>=20
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> This is a fixup for vdso implementation which caused musl to
> fail.
>=20
> [   11.600082] Run /sbin/init as init process
> [   11.628561] init[1]: unhandled signal 11 code 0x1 at
> 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
> [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
> 5.18.0-rc7-next-20220520 #1
> [   11.629462] Hardware name: riscv-virtio,qemu (DT)
> [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
> 00ffffffc58199f0
> [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
> ffffffffffffffff
> [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
> 00ffffff8ade0cc0
> [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
> 00ffffffc5819a00
> [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
> 00ffffffc5819b00
> [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
> 0000000000000000
> [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
> 00ffffff8ade0728
> [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
> 00ffffffc5819e40
> [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
> 0000000000000000
> [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
> 0000000000000001
> [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
> [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
> cause: 000000000000000d
>=20
> The last __vdso_init(&compat_vdso_info) replaces the data in normal
> vdso_info. This is an obvious bug.
>=20
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Heiko St=C3=BCbner <heiko@sntech.de>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> ---
> Changes in V2:
> - Add Tested-by
> - Rename vvar & vdso in /proc/<pid>/maps.

Why? No other architecture renames it to that, and various pieces of
software look for the magic [vdso] name, including GDB and LLDB, though
by my count there are 57 source packages in Debian that contain the
string literal "[vdso]" (including quotes), including Firefox,
Android's ART, lvm2 and elfutils.

Jess

> ---
> arch/riscv/kernel/vdso.c | 15 +++++++++++++--
> 1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 50fe4c877603..957f164c9778 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info =
__ro_after_init =3D {
> };
>=20
> #ifdef CONFIG_COMPAT
> +static struct vm_special_mapping rv_compat_vdso_maps[] =
__ro_after_init =3D {
> +	[RV_VDSO_MAP_VVAR] =3D {
> +		.name   =3D "[compat vvar]",
> +		.fault =3D vvar_fault,
> +	},
> +	[RV_VDSO_MAP_VDSO] =3D {
> +		.name   =3D "[compat vdso]",
> +		.mremap =3D vdso_mremap,
> +	},
> +};
> +
> static struct __vdso_info compat_vdso_info __ro_after_init =3D {
> 	.name =3D "compat_vdso",
> 	.vdso_code_start =3D compat_vdso_start,
> 	.vdso_code_end =3D compat_vdso_end,
> -	.dm =3D &rv_vdso_maps[RV_VDSO_MAP_VVAR],
> -	.cm =3D &rv_vdso_maps[RV_VDSO_MAP_VDSO],
> +	.dm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
> +	.cm =3D &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
> };
> #endif
>=20
> --=20
> 2.36.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

