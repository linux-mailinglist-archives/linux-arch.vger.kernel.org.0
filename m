Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FE448BCEB
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 03:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348253AbiALCI7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 21:08:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37244 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348241AbiALCI6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 21:08:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E72CFB81DAC;
        Wed, 12 Jan 2022 02:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4960C36AF7;
        Wed, 12 Jan 2022 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641953335;
        bh=00jqOo/HIGe5aQsScbRyEcP5fhzEdEEb5a/Ce7t3cpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dr+fOp8wi/DQiF30YWSyDTO/X/gY2KuY68uhH1bbSr9L4LCWtzdsmA1/2FVgH6Yui
         JAWtdZN3+qVuyTH8g7AWcIBoPboWqU5NEOBJY3Qi2lQYpTEjvY17r0McmIXxiQGXjy
         vMb/2FSp+DWz/rMXSgh25TUrsAEIDTZ/nrgIfBaLqltrBBD10mPo/jp96cQ+uhKTVZ
         t/CRg13JBexnPXx/8lXSOSAHOwES426B7kTOWti7Bnc9HE8lsIaWa7rd+tvu1aEfg1
         xp9S5v0O07CBLJ8tI8dJHISW+bnA5ZRD+Ol48fLpo9kJtTe3dTBYie/PALeVEuaDAh
         NJnD0tFre3L5A==
Received: by mail-ua1-f53.google.com with SMTP id p37so2079833uae.8;
        Tue, 11 Jan 2022 18:08:55 -0800 (PST)
X-Gm-Message-State: AOAM533Opp9zIVvjJvrCfV1tuThm/QSh3Qw6TB1NDwGtqr4KjtW3Orua
        FxNU4CMZS4MtUeRvMA53FtR5PXMJItklfSsdFzE=
X-Google-Smtp-Source: ABdhPJwDjcWqNqYbbEwXXTZv6pYv1AFZouP6oGIFcDRCp67/dn6q+IWJLxLbMTSk+FCyEJgyv6a7C0pY5YW8GYdxT6U=
X-Received: by 2002:a67:fd64:: with SMTP id h4mr3438011vsa.8.1641953334235;
 Tue, 11 Jan 2022 18:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20220111083515.502308-1-hch@lst.de> <20220111083515.502308-5-hch@lst.de>
 <CAK8P3a0mHC5=OOGV=sGnC9JqZWxzsJyZbTefnCtryQU3o3PY_g@mail.gmail.com>
In-Reply-To: <CAK8P3a0mHC5=OOGV=sGnC9JqZWxzsJyZbTefnCtryQU3o3PY_g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 12 Jan 2022 10:08:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS81o1bsAGj=016F=Nw7MszhsYa95cw6JLThjwW50YRpw@mail.gmail.com>
Message-ID: <CAJF2gTS81o1bsAGj=016F=Nw7MszhsYa95cw6JLThjwW50YRpw@mail.gmail.com>
Subject: Re: [PATCH 4/5] uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 11, 2022 at 11:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jan 11, 2022 at 9:35 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The fcntl F_GETLK64/F_SETLK64/F_SETLKW64 are only implemented for the
> > 32-bit syscall APIs, but we also need them for compat handling on 64-bit
> > builds.  Redefining them is error prone (as shown by the example that
> > parisc gets it wrong currently), so we should use the same defines for
> > both case.  In theory we could try to hide them from userspace, but
> > given that only MIPS actually gets that right, while the asm-generic
> > version used by most architectures relies on a Kconfig symbol that can't
> > be relied on to be set properly by userspace is a clear indicator to not
> > bother.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
>
> > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> > index 98f4ff165b776..43d7c44031be0 100644
> > --- a/include/uapi/asm-generic/fcntl.h
> > +++ b/include/uapi/asm-generic/fcntl.h
> > @@ -116,13 +116,11 @@
> >  #define F_GETSIG       11      /* for sockets. */
> >  #endif
> >
> > -#ifndef CONFIG_64BIT
> >  #ifndef F_GETLK64
> >  #define F_GETLK64      12      /*  using 'struct flock64' */
> >  #define F_SETLK64      13
> >  #define F_SETLKW64     14
> >  #endif
> > -#endif
> >
> >  #ifndef F_SETOWN_EX
> >  #define F_SETOWN_EX    15
>
> This is a very subtle change to the exported UAPI header contents:
> On 64-bit architectures, the three unusable numbers are now always
> shown, rather than depending on a user-controlled symbol.
>
> This is probably what we want here for compatibility reasons, but I think
> it should be explained in the changelog text, and I'd like Jeff or Bruce
> to comment on it as well: the alternative here would be to make the
> uapi definition depend on __BITS_PER_LONG==32, which is

__BITS_PER_LONG==32 || __KERNEL__  just for kernel use in compat.

> technically the right thing to do but more a of a change.
>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
