Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5E356D36
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 15:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhDGNXM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 09:23:12 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:17968 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhDGNXK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 09:23:10 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 137DMab6004819;
        Wed, 7 Apr 2021 22:22:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 137DMab6004819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617801756;
        bh=Usra8KcBYgGZoqiKSYtDpYF/LC0cwPSDqgPA0XLdu0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kf/VzT3qMbMcvWtm2f4X35CJ2YRHwIRNAR+wfKuAd2HPMTg2UqpLg+3vczEjyvQ17
         lC03gDJdWN7SPtrw2xBkJKVfnThUHZxSmHo1O701c7vh2e55L6YXdUiCAjYW1K7WxZ
         08Ld4ItN6MzcVqe13Rp2CdP+WqL05VNEyrcVAWZWteR++jCWtgMrrTd3vdBTNeKH+G
         lRumuXWlo3Du9++4rN2GAN/Z9SC4wgbRVLVq4Q2TzrfEniUmnx1UqK2XmoC7ThkuA/
         jkz+56D3P0qntBmoybHbd/oVYydmR/0k5BW+PU2iCvneRLzkZ0nub4y8oVH1PqcZP9
         a5yfGYOLypjmg==
X-Nifty-SrcIP: [209.85.215.172]
Received: by mail-pg1-f172.google.com with SMTP id t22so5903083pgu.0;
        Wed, 07 Apr 2021 06:22:36 -0700 (PDT)
X-Gm-Message-State: AOAM532Qql37xHrpMq5+gApKeaa5P59Zgyln4dYYtPbek+m9U2JNpwLQ
        SD6WuSlFBrzHrlu3KM5RVbSXcbTDeElMuXrh5qI=
X-Google-Smtp-Source: ABdhPJwk9qS0BMUYh5/qdYqoHXSyq4h3xksMbErCbs90p3+A591ceXgm4FOBcMs5kvsm1Qs6lHOiJttPXHcA8V+G7cw=
X-Received: by 2002:a65:428b:: with SMTP id j11mr3299165pgp.47.1617801755787;
 Wed, 07 Apr 2021 06:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-8-gregkh@linuxfoundation.org> <CAK7LNASbZ4hY8ypd8TegnRpxQUM-HB84n2VHUmu=k_RxwCnpXg@mail.gmail.com>
 <YG2tvk010wRkIVSX@kroah.com>
In-Reply-To: <YG2tvk010wRkIVSX@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 22:21:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARewRB3JENY1vXecz23W+XtOuO4MP4MNTPUx1KKRLKQGA@mail.gmail.com>
Message-ID: <CAK7LNARewRB3JENY1vXecz23W+XtOuO4MP4MNTPUx1KKRLKQGA@mail.gmail.com>
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

On Wed, Apr 7, 2021 at 10:04 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 07, 2021 at 08:05:23PM +0900, Masahiro Yamada wrote:
> > On Wed, Apr 7, 2021 at 2:35 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > Some architectures put the version number by default at the end of the
> > > files that are copied, so add support for this to be set by arch type.
> > >
> > > Odds are one day we should change this for x86, but let's not break
> > > anyone's systems just yet.
> > >
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  scripts/install.sh | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/install.sh b/scripts/install.sh
> > > index 72dc4c81013e..934619f81119 100644
> > > --- a/scripts/install.sh
> > > +++ b/scripts/install.sh
> > > @@ -60,8 +60,19 @@ else
> > >         base=vmlinux
> > >  fi
> > >
> > > -install "$2" "$4"/"$base"
> > > -install "$3" "$4"/System.map
> > > +# Some architectures name their files based on version number, and
> > > +# others do not.  Call out the ones that do not to make it obvious.
> > > +case "${ARCH}" in
> > > +       x86)
> > > +               version=""
> > > +               ;;
> > > +       *)
> > > +               version="-${1}"
> > > +               ;;
> > > +esac
> > > +
> > > +install "$2" "$4"/"$base""$version"
> >
> >
> > Too many quotes are eye sore.
> >
> >
> >     install "$2" "$4/$base$version"
> >
> > looks cleaner in my opinion.
> >
> > Shell correctly understands the end of each
> > variable because a slash or a dollar
> > cannot be a part of a variable name.
>
> Good idea, I usually just default to "quote everything!" when dealing
> with bash variables.  I'll fix this up.
>
> Oh, any preference for "$2" vs. "${2}"?  I don't care either way but I
> couldn't tell what is the normal kernel style these days.


I do not see a well-defined coding style guideline
for shell scripts.

If you want to know my personal preference,
I use "$2" without braces.


Thanks.


>
> thanks for all of the review, much appreciated!

My pleasure.

>
> greg k-h



-- 
Best Regards
Masahiro Yamada
