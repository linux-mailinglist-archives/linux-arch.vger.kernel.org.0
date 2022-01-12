Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32FF48C7E2
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 17:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354939AbiALQJl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 11:09:41 -0500
Received: from verein.lst.de ([213.95.11.211]:46710 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354957AbiALQJk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jan 2022 11:09:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3EE0868AFE; Wed, 12 Jan 2022 17:09:36 +0100 (CET)
Date:   Wed, 12 Jan 2022 17:09:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Guo Ren <guoren@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 4/5] uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64
 in fcntl.h
Message-ID: <20220112160935.GA3684@lst.de>
References: <20220111083515.502308-1-hch@lst.de> <20220111083515.502308-5-hch@lst.de> <CAK8P3a0mHC5=OOGV=sGnC9JqZWxzsJyZbTefnCtryQU3o3PY_g@mail.gmail.com> <20220112075609.GA4854@lst.de> <CAK8P3a1ONn=FiPU3669MjBMntS-1K5bgX4pHforUsYJ7yhwZ-g@mail.gmail.com> <f86483fca8b0dc68ce243ba47998ff3296a3b6f8.camel@kernel.org> <CAK8P3a3FgHQ+w+Sj00yOERRLWfVhx7NYsGJ1NBAXQ0=is3G=Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3FgHQ+w+Sj00yOERRLWfVhx7NYsGJ1NBAXQ0=is3G=Kg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 12, 2022 at 01:08:24PM +0100, Arnd Bergmann wrote:
> > I don't have a strong opinion here. If we were taking symbols away that
> > were previously visible to userland it would be one thing, but since
> > we're just adding symbols that may not have been there before, this
> > seems less likely to break anything.
> 
> Changing
> 
> #ifndef CONFIG_64BIT
> 
> to
> 
> #if __BITS_PER_LONG==32 || defined(__KERNEL__),
> 
> would take symbols away, since the CONFIG_64BIT macro is never
> set in user space.

Yes.

> > I probably lean toward Christoph's original solution instead of keeping
> > the conditional definitions. It's hard to imagine there are many
> > programs that care whether these other symbols are defined or not.
> >
> > You can add this to the original patch:
> >
> > Acked-by: Jeff Layton <jlayton@kernel.org>
> 
> Sounds good, thanks

So should we go ahead with the series as-is?  Or respin it?  Or add
the above change ontop?
