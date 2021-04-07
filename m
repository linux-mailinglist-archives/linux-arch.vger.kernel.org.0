Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBBE356ACB
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347256AbhDGLFt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:05:49 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:46111 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245453AbhDGLFs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:05:48 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 137B5MdS005291;
        Wed, 7 Apr 2021 20:05:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 137B5MdS005291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617793523;
        bh=1nUmjYdnqxPNkZapQpt2ld77/Yb7CC5oogHeqt5wGDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JqNiPqauUTdSMclLAzQ7kSuwu4MNlImUeT6y56ybu+cCrxtRybft5ioUMEG8jM0Sb
         UIxYL8Ameji/9tbKsvDQ0ZRh77hLZlpFZGOrQxzrE3H+damm/vZEM4lrYgb7Txo5tm
         HwpbhPN37tM8Kr2F1TmTrZ4ZXcesZEfzd8PQlzZlYst2IZLyaXzJQxz83GNErDNy9F
         KooMGSpm4/j41+J8NcvPyT2gfMp0oeYO1HQh90u9tumsiB+wiWfttE5Kvu6HR4OphR
         BDVBCZB6S4UtkJvP8j2zPCvheZeBoY4GND+rMecNQrJcFR+6U2JvSLD4Xfi1RF8FjJ
         onmerkvuTW0iQ==
X-Nifty-SrcIP: [209.85.214.180]
Received: by mail-pl1-f180.google.com with SMTP id a6so5813176pls.1;
        Wed, 07 Apr 2021 04:05:23 -0700 (PDT)
X-Gm-Message-State: AOAM532zquxMDq1Qzq0azxKYpG15ry8z6nq6gdUoyV6uRWbimfMSwXG8
        s32KXP6dQVZ59BgMK0HK7+txEn6Q5C2Xzd463x0=
X-Google-Smtp-Source: ABdhPJxQTzam8O0Pu8ZzGVd9EhrLcZMpIjLVCpLc7/adO3RPef5tswuXmzqd85la42HrPxTl5jap7TpGJtTN/hF6kCQ=
X-Received: by 2002:a17:90a:1056:: with SMTP id y22mr2583522pjd.153.1617793522326;
 Wed, 07 Apr 2021 04:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-7-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-7-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 20:04:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARwOOLZT3TQo+TgGyOLwh8_TsafQ4RDkTJosp6UMY+dcg@mail.gmail.com>
Message-ID: <CAK7LNARwOOLZT3TQo+TgGyOLwh8_TsafQ4RDkTJosp6UMY+dcg@mail.gmail.com>
Subject: Re: [PATCH 06/20] kbuild: scripts/install.sh: handle
 compressed/uncompressed kernel images
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
> For x86, the default kernel image is compressed, but other architectures
> allowed both compressed and uncompressed kernel images to be built.  Add
> a test to detect which one this is, and either name the output file
> "vmlinuz" for a compressed image, or "vmlinux" for an uncompressed
> image.
>
> For x86 this change is a no-op, but other architectures depend on this.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  scripts/install.sh | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/install.sh b/scripts/install.sh
> index 2adcb993efa2..72dc4c81013e 100644
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -49,8 +49,18 @@ verify "$3"
>  if [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "$@"; fi
>  if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
>
> -# Default install - same as make zlilo
> -install "$2" "$4"/vmlinuz
> +base=$(basename "$2")
> +if [ "$base" = "bzImage" ]; then
> +       # Compressed install
> +       echo "Installing compressed kernel"



After applying this series, I think the excessive
"Installing ..." messages are a bit annoying.


masahiro@grover:~/workspace/linux-kbuild$ make INSTALL_PATH=~/foo install
sh ./scripts/install.sh 5.12.0-rc3+ arch/x86/boot/bzImage \
System.map "/home/masahiro/foo"
Installing compressed kernel
installing 'arch/x86/boot/bzImage' to '/home/masahiro/foo/vmlinuz'
installing 'System.map' to '/home/masahiro/foo/System.map'
Cannot find LILO, ensure your bootloader knows of the new kernel image.



Since 03/20 added a new log in the 'install' function,
can we drop this "Installing compressed kernel" message?




> +       base=vmlinuz
> +else
> +       # Normal install
> +       echo "Installing normal kernel"


Same here.

This message tends to be wrong.
For example, arch/arm/boot/uImage is gzip-compressed,
but it says "Installing normal kernel".







> +       base=vmlinux
> +fi
> +
> +install "$2" "$4"/"$base"
>  install "$3" "$4"/System.map
>  sync
>
> --
> 2.31.1
>


--
Best Regards

Masahiro Yamada
