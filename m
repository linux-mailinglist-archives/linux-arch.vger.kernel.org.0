Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78987191F2
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 06:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjFAEnR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 00:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFAEnQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 00:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1348BD1;
        Wed, 31 May 2023 21:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BAE664096;
        Thu,  1 Jun 2023 04:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB09C433A4;
        Thu,  1 Jun 2023 04:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685594593;
        bh=glxEErfBF3rHdX2Urzd+1Qp5ZZmjQW4jC0j3rig2bd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eJppZiLfpsup79yOmIoJDe2feYX0jjKFJgJ9XoDNWkX2xBnQmQWwOId5NiG1+K93q
         lyFC1cwabbl0+RfyypvfRuKmrZSAaHfH4IwQXQglE2N4MQ0hnUYd8mfbyOwQjuyPze
         ky0RlW+lKBET4OIwuGJPa3cC/l6uri0Yec/mKviXt3gL2TcMB26kiYu9il4yoOEbzv
         TmxJwzPVcUAxTSFxMKKDmY0zIq8hLR+aeX1CSZ5vjG/g8yfWonEHLUtrkAraaw/AYk
         bsNju0GBVzFj/UZ2SraPiSeNCMlcrhkF8HRPnlJlM2PXAgsA7KnuVxO3rCdxd3Ml3p
         DuU7JLbQrT1aQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso799013a12.0;
        Wed, 31 May 2023 21:43:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDycyF8FE2N83BVIgUdGqcNwLChYNXHnTHMk/AtSpDaU18XJNOgk
        W83bgP9lHV1XLy/vmZOj7ft0ZW1GjvImLoWWOpQ=
X-Google-Smtp-Source: ACHHUZ7WYfywbSzqGOxvRRYAxq7nURM10ufCPK0jjetP4TSKkDNLozvsGovCGYbXJafAZ1bgYgshJ3tbcnwZI3XfxrM=
X-Received: by 2002:a05:6402:14c9:b0:514:9423:65a5 with SMTP id
 f9-20020a05640214c900b00514942365a5mr5538713edx.19.1685594592071; Wed, 31 May
 2023 21:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230523165502.2592-1-jszhang@kernel.org> <20230523165502.2592-3-jszhang@kernel.org>
In-Reply-To: <20230523165502.2592-3-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 1 Jun 2023 12:43:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS1EcEw0VWGgd-bezKh=s7zPnFBdyuJc1wuH_SXEwoXbA@mail.gmail.com>
Message-ID: <CAJF2gTS1EcEw0VWGgd-bezKh=s7zPnFBdyuJc1wuH_SXEwoXbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] riscv: vmlinux-xip.lds.S: remove .alternative section
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, May 24, 2023 at 1:10=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> ALTERNATIVE mechanism can't work on XIP, and this is also reflected by
> below Kconfig dependency:
>
> RISCV_ALTERNATIVE
>         ...
>         depends on !XIP_KERNEL
>         ...
>
> So there's no .alternative section at all for XIP case, remove it.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/kernel/vmlinux-xip.lds.S |   6 ------
>  1 files changed, 6 deletions(-)
>
> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmli=
nux-xip.lds.S
> index eab9edc3b631..50767647fbc6 100644
> --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> @@ -98,12 +98,6 @@ SECTIONS
>                 __soc_builtin_dtb_table_end =3D .;
>         }
>
> -       . =3D ALIGN(8);
> -       .alternative : {
> -               __alt_start =3D .;
> -               *(.alternative)
> -               __alt_end =3D .;
> -       }
>         __init_end =3D .;
>
>         . =3D ALIGN(16);
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren
