Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13732356AB6
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347164AbhDGLAb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:00:31 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:28844 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242100AbhDGLAa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:00:30 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 137B05fV001106;
        Wed, 7 Apr 2021 20:00:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 137B05fV001106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617793205;
        bh=HsHy1BlkdzgaJU7jTvUQfH1kV2wKWxfz5Llhj+2yTjo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VHdHLD6jFP5PcQTjgL8Yad0n2VtsgvTj/S8EEMqNtiYE8wHYBTIG39maLA+17/gd+
         GMryX0df5i46XfWuEXHr7cPyn6f9UH6fOFJACWPMTTZH0UmfXX9CKxbrJNnjOCwYIT
         jsJjVaYYOQ4+PWmnEBjrCRlxYArih52LSMEBushOUwxnTx4V+8slFT82zFikWqlj/r
         OExAxG3qp9MENrmj5Fb4i+HakcLCbQGjIsGn0HCQD/9W2hWllG7iVbilF/cawPEsGw
         gAwA5YPkXTU0vogq/ubP0JxCo3cDaKAx2gl32kHGtLnNyC224lVU+Gd9ZEGrK8FwJC
         9d6qmW0Ggg5qw==
X-Nifty-SrcIP: [209.85.216.46]
Received: by mail-pj1-f46.google.com with SMTP id t23so6340235pjy.3;
        Wed, 07 Apr 2021 04:00:05 -0700 (PDT)
X-Gm-Message-State: AOAM530HazePKO0vqxajMVIjDpbusVbEmPwD8C9LkpyhEoOUcx/KHVKq
        hPc5J4QrhpJH9a1x08R67i3hYWRLA0QMi82ceBU=
X-Google-Smtp-Source: ABdhPJxt2sEjfRm15g9mXgVJVkonDOiXQA+m1tavaqhpdkYlQ2CH/2eAY/ZOdFllHUsINcz1TcfbljGmPBHISia5tls=
X-Received: by 2002:a17:90a:28a1:: with SMTP id f30mr2764084pjd.198.1617793204616;
 Wed, 07 Apr 2021 04:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-3-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-3-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 19:59:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-F0axROr=D6QtnpZrau-rcu+Vk9JTjX0ad5EZfD_R_A@mail.gmail.com>
Message-ID: <CAK7LNAS-F0axROr=D6QtnpZrau-rcu+Vk9JTjX0ad5EZfD_R_A@mail.gmail.com>
Subject: Re: [PATCH 02/20] kbuild: scripts/install.sh: properly quote all variables
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
> A few variables are quoted to handle spaces in directory names, but not
> all of them.  Properly quote everything so that the kernel build can
> handle working correctly with directory names with spaces.
>
> This change makes the script "shellcheck" clean now.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  scripts/install.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/install.sh b/scripts/install.sh
> index d13ec1c38640..c183d6ddd00c 100644
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -33,21 +33,21 @@ verify "$3"
>
>  # User may have a custom install script
>
> -if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> +if [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "$@"; fi
> +if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
>
>  # Default install - same as make zlilo
>
> -if [ -f $4/vmlinuz ]; then
> -       mv $4/vmlinuz $4/vmlinuz.old
> +if [ -f "$4"/vmlinuz ]; then
> +       mv "$4"/vmlinuz "$4"/vmlinuz.old
>  fi


Another way of quoting is doing like this:

  if [ -f "$4/vmlinuz" ]; then
       mv "$4/vmlinuz" "$4/vmlinuz.old"
  fi


shellcheck is still satisfied.





Because you will add more quotes,
quoting the whole of each parameter might be cleaner.

See my comment in 07/20.








> -if [ -f $4/System.map ]; then
> -       mv $4/System.map $4/System.old
> +if [ -f "$4"/System.map ]; then
> +       mv "$4"/System.map "$4"/System.old
>  fi
>
> -cat $2 > $4/vmlinuz
> -cp $3 $4/System.map
> +cat "$2" > "$4"/vmlinuz
> +cp "$3" "$4"/System.map
>
>  if [ -x /sbin/lilo ]; then
>         /sbin/lilo
> --
> 2.31.1
>


--
Best Regards
Masahiro Yamada
