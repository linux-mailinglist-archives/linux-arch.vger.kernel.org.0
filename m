Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376E2356ABE
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbhDGLCu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:02:50 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:53568 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbhDGLCu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:02:50 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 137B24Tv023666;
        Wed, 7 Apr 2021 20:02:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 137B24Tv023666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617793325;
        bh=/AJ00JPGT/P/0HrVBZa/+phO7AM3OfqEyfNeG+0qOho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rh+Rj4Y1wZlL3vsup52LPEPJsXhPFCQI5D13W2BIUr7AzsTE3AaR8KnVMathvLBmF
         WNkdzE5gRwCFQ8oDzBpwXTn/r6NePjuyWWqgphgMxGEC6CNe3Tw1TyUXR654zOrN7I
         rarVCLoKnjLgPcNvPBq5lRSMN1vVIdoxVzUb+7+NS1TPibFY0fYBOZzAPpR4S89gCN
         jWoYNbF7V8V/Z18RgK3KGupEtWlVfq/cB+6ed0dxt9VEmIbKMWziNRbZD6MhuhW4Av
         DEY62h9xLoWbzPxxMtwFtoXGJwqLr4kYLR1oibfNd8V5krCHQADv0L+oCwr/Zqbter
         5XOyuLUm8loXQ==
X-Nifty-SrcIP: [209.85.214.174]
Received: by mail-pl1-f174.google.com with SMTP id p10so4009719pld.0;
        Wed, 07 Apr 2021 04:02:05 -0700 (PDT)
X-Gm-Message-State: AOAM532Vcjc16M9DfGRmwGyYBGLfxOy4mJguPzc1ukb+S2RItIJYRFBe
        5vUSEFne78T1zabPdIHbz18D0h7TRqHGb0SOt5o=
X-Google-Smtp-Source: ABdhPJxX64blu3IjkJJ4l2Qdlp7CBcg26GG4ZfbXOUjpMXipRF3l/0e8VzCr9jb0GHAPl9qew8Vr1RVBgHaRtYofzFA=
X-Received: by 2002:a17:90a:f68a:: with SMTP id cl10mr2726619pjb.87.1617793324371;
 Wed, 07 Apr 2021 04:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-4-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-4-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 20:01:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARm=SQyue3mpYjLs=RFG087_SpyM=YZuCOmeyya4ppmUw@mail.gmail.com>
Message-ID: <CAK7LNARm=SQyue3mpYjLs=RFG087_SpyM=YZuCOmeyya4ppmUw@mail.gmail.com>
Subject: Re: [PATCH 03/20] kbuild: scripts/install.sh: provide a "install" function
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
> Instead of open-coding the "test for file, if present make a backup,
> then copy the file to the new location" in multiple places, make a
> single function, install(), to do all of this in one place.
>
> Note, this does change the default x86 kernel map file saved name from
> "System.old" to "System.map.old".  This brings it into unification with
> the other architectures as to what they call their backup file for the
> kernel map file.  As this is a text file, and nothing parses this from a
> backup file, there should not be any operational differences.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  scripts/install.sh | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/install.sh b/scripts/install.sh
> index c183d6ddd00c..af36c0a82f01 100644
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -27,6 +27,19 @@ verify () {
>         fi
>  }
>
> +install () {
> +       install_source=${1}
> +       install_target=${2}



You double-quoted all variables in 02/20.

For consistency and safety here,

           install_source="${1}"

or

           install_source="$1"


so that it will work even if $1 contains spaces.





> +
> +       echo "installing '${install_source}' to '${install_target}'"
> +
> +       # if the target is already present, move it to a .old filename
> +       if [ -f "${install_target}" ]; then
> +               mv "${install_target}" "${install_target}".old
> +       fi
> +       cat "${install_source}" > "${install_target}"
> +}
> +
>  # Make sure the files actually exist
>  verify "$2"
>  verify "$3"
> @@ -37,17 +50,8 @@ if [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "$@"; fi
>  if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
>
>  # Default install - same as make zlilo
> -
> -if [ -f "$4"/vmlinuz ]; then
> -       mv "$4"/vmlinuz "$4"/vmlinuz.old
> -fi
> -
> -if [ -f "$4"/System.map ]; then
> -       mv "$4"/System.map "$4"/System.old
> -fi
> -
> -cat "$2" > "$4"/vmlinuz
> -cp "$3" "$4"/System.map
> +install "$2" "$4"/vmlinuz
> +install "$3" "$4"/System.map
>
>  if [ -x /sbin/lilo ]; then
>         /sbin/lilo
> --
> 2.31.1
>


--
Best Regards

Masahiro Yamada
