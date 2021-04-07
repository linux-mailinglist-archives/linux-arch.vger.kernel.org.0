Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD2E356ACE
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347238AbhDGLGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:06:49 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:60733 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245453AbhDGLGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:06:48 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 137B61H9025647;
        Wed, 7 Apr 2021 20:06:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 137B61H9025647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617793561;
        bh=HUJZbBelCWkZXR85yxxhkbKhJ4b2CGDQh5YdLukw8dw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2Cqs+qia3sMZxy4IQBh8xc2LND8RWVebSS/ssdclG8bMkZi1LQNTdwMcxho3jcY9l
         7iPIZeyenq57Iri0pfsk7DOKfoLJPTF9juqYxcR+AYRep/Eto3gvA1/JcjAampl9CC
         F3q0P1aCzA8bf+KlsypNP9O3Ldf3DNw8iDeerNIIkcXzZCZs29vuFQgSHHJjlumhN/
         tKwWZFRNy2yYJOwIHhfdOD5Vnk0Ve8cO26nYx00xGUzdYKa0J7ziPToRoalK/JIDQQ
         kiKJ9OmlT8tn9wIUXMts81O/Se9ejqzMYT6AO8pGoBJ4ywp1iBVDSDJquA478Ltfix
         Il2ObKIsVOrzA==
X-Nifty-SrcIP: [209.85.210.169]
Received: by mail-pf1-f169.google.com with SMTP id n38so2966983pfv.2;
        Wed, 07 Apr 2021 04:06:01 -0700 (PDT)
X-Gm-Message-State: AOAM5334p489YyGLfdDwK+xanGcIyBiHjXwAs/tUP7sXE709XdZfCmVr
        +FvocDl5aXC17Mc2+ioekrOCme0W6bMcoYImHeY=
X-Google-Smtp-Source: ABdhPJxsJ/L1xUi1dCOyIy6EygtWi6Rb4RNd8aUw7duUGBuHZVbuniR2CoRjlJTf4rsJKgHCUbq6veZgFd92ndRBaTY=
X-Received: by 2002:a65:428b:: with SMTP id j11mr2784761pgp.47.1617793560694;
 Wed, 07 Apr 2021 04:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-8-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-8-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 20:05:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASbZ4hY8ypd8TegnRpxQUM-HB84n2VHUmu=k_RxwCnpXg@mail.gmail.com>
Message-ID: <CAK7LNASbZ4hY8ypd8TegnRpxQUM-HB84n2VHUmu=k_RxwCnpXg@mail.gmail.com>
Subject: Re: [PATCH 07/20] kbuild: scripts/install.sh: allow for the version number
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 7, 2021 at 2:35 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Some architectures put the version number by default at the end of the
> files that are copied, so add support for this to be set by arch type.
>
> Odds are one day we should change this for x86, but let's not break
> anyone's systems just yet.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  scripts/install.sh | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/install.sh b/scripts/install.sh
> index 72dc4c81013e..934619f81119 100644
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -60,8 +60,19 @@ else
>         base=vmlinux
>  fi
>
> -install "$2" "$4"/"$base"
> -install "$3" "$4"/System.map
> +# Some architectures name their files based on version number, and
> +# others do not.  Call out the ones that do not to make it obvious.
> +case "${ARCH}" in
> +       x86)
> +               version=""
> +               ;;
> +       *)
> +               version="-${1}"
> +               ;;
> +esac
> +
> +install "$2" "$4"/"$base""$version"


Too many quotes are eye sore.


    install "$2" "$4/$base$version"

looks cleaner in my opinion.

Shell correctly understands the end of each
variable because a slash or a dollar
cannot be a part of a variable name.







> +install "$3" "$4"/System.map"$version"
>  sync
>
>  # Some architectures like to call specific bootloader "helper" programs:
> --
> 2.31.1
>


--
Best Regards

Masahiro Yamada
