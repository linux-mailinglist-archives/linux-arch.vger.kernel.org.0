Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7576356AC6
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbhDGLEW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:04:22 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:56250 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351781AbhDGLEV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:04:21 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 137B3t0L024427;
        Wed, 7 Apr 2021 20:03:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 137B3t0L024427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617793436;
        bh=FpQlEZxI5UBjZfh486NBfPjf7fVd6igI2DJa+H+guV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UmAuuNQwM3avYafqnciKMZ7TQ4gF8L3tEIZTvTsccyPNXbktnGdEEQ95/OVA0pw/l
         XuFKsrcRsvv89AsSQQFiCme7gTM+SWYGzRmtF/kwD3wKStzqCTZPIP3ik8XAV657+S
         IzgkYlTPMevnsuKQVZTSJ51Hyt6/6JC+V4eL7Vwv/Z1i5JK5bBPzaaWoUXxyCGib7G
         eHjgeFz6mL/aMCyEba100/kHIYDU0wl74OHoXlFTZYmmGvoKS9trAjURlZIfx15Vwn
         F+X0uT5H0yO/idrUKDoUSQ4psaI2JY7pB4J+eE2lEmz+v70kbKTRqEmR6WcdrCq0Y+
         8u0RPaQfW5klA==
X-Nifty-SrcIP: [209.85.210.177]
Received: by mail-pf1-f177.google.com with SMTP id c204so8885292pfc.4;
        Wed, 07 Apr 2021 04:03:55 -0700 (PDT)
X-Gm-Message-State: AOAM530+XjWYu+QeF+prXrOq5AMKdnX8uyoHaE0EBHZPMWfPjdI8FcTB
        LceZC3Z+0uptufk1HLUDHhHl70+K1CwyV+DlcC4=
X-Google-Smtp-Source: ABdhPJwcKEp1tbeLhACK+LXIrQD4xvOVABt2bhyKSxt5NPEmlLsUX6lRIKbqoRPAL1F5SfWYFk85T6FQdqPdDDEYlcU=
X-Received: by 2002:aa7:8814:0:b029:21d:d2ce:7be with SMTP id
 c20-20020aa788140000b029021dd2ce07bemr2305518pfo.80.1617793435008; Wed, 07
 Apr 2021 04:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-5-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-5-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 20:03:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4ar1gM1+08EXUZYHvt38Bt_D+NZdhRyH8hfjecw2vEg@mail.gmail.com>
Message-ID: <CAK7LNAQ4ar1gM1+08EXUZYHvt38Bt_D+NZdhRyH8hfjecw2vEg@mail.gmail.com>
Subject: Re: [PATCH 04/20] kbuild: scripts/install.sh: call sync before
 calling the bootloader installer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 7, 2021 at 2:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> It's good to ensure that the files are written out before calling the
> bootloader installer, as other architectures do, so call sync after
> doing the copying of the kernel and system map files.


I see 3 architectures that call 'sync' from install.sh

masahiro@grover:~/ref/linux$ find . -name install.sh  | xargs grep sync
./arch/nios2/boot/install.sh:sync
./arch/x86/boot/install.sh:       sync
./arch/m68k/install.sh:sync


As for nios2 and m68k, they do not call
any bootloader-specific setups.



> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  scripts/install.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/install.sh b/scripts/install.sh
> index af36c0a82f01..92d0d2ade414 100644
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -52,12 +52,12 @@ if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
>  # Default install - same as make zlilo
>  install "$2" "$4"/vmlinuz
>  install "$3" "$4"/System.map
> +sync
>
>  if [ -x /sbin/lilo ]; then
>         /sbin/lilo
>  elif [ -x /etc/lilo/install ]; then
>         /etc/lilo/install
>  else
> -       sync
>         echo "Cannot find LILO."
>  fi
> --
> 2.31.1
>

Why do we need 'sync' before lilo invocation?



If you want to ensure everything is flushed
to a disk before this scripts exits,
adding 'sync' at the end of the script
makes more sense, in my opinion.



   if [ -x /sbin/lilo ]; then
          /sbin/lilo
   elif [ -x /etc/lilo/install ]; then
          /etc/lilo/install
   else
         echo "Cannot find LILO."
   fi

   sync




This goes aligned with nios2 and m68k.



--
Best Regards

Masahiro Yamada
