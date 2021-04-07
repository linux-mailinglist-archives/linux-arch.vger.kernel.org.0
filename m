Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828AF356CDE
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352584AbhDGNEN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 09:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352571AbhDGNEL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 09:04:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FDFF6124B;
        Wed,  7 Apr 2021 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617800642;
        bh=nThm+R6dMYSqhG181+GtVpThubpwnwPwK0c5mCLI0kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iavD/CG+FWohxaAuelhrZ4/MZsgySf5Qa7RUOa/UoK6YRgYGI3FlNzbPB5+8578n4
         MAi4pTTeHKCEKwHiwkV7b2hHdsGOwdvdHOD9cLtek81iuqsn3seZy4QvJedVoHm65H
         Q1OrBnM2X+XcgNIDxcB6fKKP5yQK4hltKwXLtf9s=
Date:   Wed, 7 Apr 2021 15:03:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/20] kbuild: scripts/install.sh: allow for the version
 number
Message-ID: <YG2tvk010wRkIVSX@kroah.com>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-8-gregkh@linuxfoundation.org>
 <CAK7LNASbZ4hY8ypd8TegnRpxQUM-HB84n2VHUmu=k_RxwCnpXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASbZ4hY8ypd8TegnRpxQUM-HB84n2VHUmu=k_RxwCnpXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 08:05:23PM +0900, Masahiro Yamada wrote:
> On Wed, Apr 7, 2021 at 2:35 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Some architectures put the version number by default at the end of the
> > files that are copied, so add support for this to be set by arch type.
> >
> > Odds are one day we should change this for x86, but let's not break
> > anyone's systems just yet.
> >
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  scripts/install.sh | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/install.sh b/scripts/install.sh
> > index 72dc4c81013e..934619f81119 100644
> > --- a/scripts/install.sh
> > +++ b/scripts/install.sh
> > @@ -60,8 +60,19 @@ else
> >         base=vmlinux
> >  fi
> >
> > -install "$2" "$4"/"$base"
> > -install "$3" "$4"/System.map
> > +# Some architectures name their files based on version number, and
> > +# others do not.  Call out the ones that do not to make it obvious.
> > +case "${ARCH}" in
> > +       x86)
> > +               version=""
> > +               ;;
> > +       *)
> > +               version="-${1}"
> > +               ;;
> > +esac
> > +
> > +install "$2" "$4"/"$base""$version"
> 
> 
> Too many quotes are eye sore.
> 
> 
>     install "$2" "$4/$base$version"
> 
> looks cleaner in my opinion.
> 
> Shell correctly understands the end of each
> variable because a slash or a dollar
> cannot be a part of a variable name.

Good idea, I usually just default to "quote everything!" when dealing
with bash variables.  I'll fix this up.

Oh, any preference for "$2" vs. "${2}"?  I don't care either way but I
couldn't tell what is the normal kernel style these days.

thanks for all of the review, much appreciated!

greg k-h
