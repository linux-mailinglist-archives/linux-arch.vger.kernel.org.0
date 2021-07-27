Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3113D7F63
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 22:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhG0Umg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 16:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhG0Umg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 16:42:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6DC060FA0;
        Tue, 27 Jul 2021 20:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627418555;
        bh=d4JjFlDfF7N2eBt3m9sdZRk+eRhA4ZhBMt2Pq1TZ0cw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZKlOgZHSGjAmEnyaCwMuVKafYPWKeXil2Iiwo9tfWrDpXPrP+nIx5u3FkbHHx9hE7
         f/+uSzSaAFLY8z0zPS4rMNMGD3DTUb7OLkYFi3ipPjtLYS72UjSrIEZWHsniKmxxZK
         Le59cWQyoKcdNBRC2NnQPaYKcr4Sl5SxpzzeT6TBVgHinsKuWcX4k1BjDbOE4supyn
         HiZ19DR0bU/awUHcX41Rjheo1w+obLAaQrJ8Rjja+UBSy51OODPf7/DV6wZKbPG4vd
         wTF3Um9UkJV8uDOE8zSUVipLRKY8TGL5cXoV09GMyL2Tz2E7xssC3kDmiC7uClw3Me
         O9bSVwy2lubCA==
Received: by mail-wm1-f48.google.com with SMTP id m38-20020a05600c3b26b02902161fccabf1so2791363wms.2;
        Tue, 27 Jul 2021 13:42:35 -0700 (PDT)
X-Gm-Message-State: AOAM532e/tUB7+Yevh5XKbWHbmLJ44fqx2jx8R5yJ6m8/z1ANBb4cKI8
        EgRq50X0XEK5e2xk7awNte+MLSMqp1CiNR3aWK8=
X-Google-Smtp-Source: ABdhPJzIeHa1hycZO5ufjXaaYbpY3YdQw4oHXjfZp2KwEfMcEIfJ5hSLrfTaLF7iY7hnR3dqnN2Y1Sv0AKkyrN9dOFM=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr6005968wmk.84.1627418543998;
 Tue, 27 Jul 2021 13:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210727144859.4150043-1-arnd@kernel.org> <YQAfa6iObAwwIpzb@infradead.org>
 <20210727131017.f151a81fc69db8f45f81a2b3@linux-foundation.org>
In-Reply-To: <20210727131017.f151a81fc69db8f45f81a2b3@linux-foundation.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Jul 2021 22:42:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2S4Oct4+a8u=ottrW1b+iRf-tRSJb0DvaLNR3CZARmTQ@mail.gmail.com>
Message-ID: <CAK8P3a2S4Oct4+a8u=ottrW1b+iRf-tRSJb0DvaLNR3CZARmTQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] compat: remove compat_alloc_user_space
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Feng Tang <feng.tang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 10:11 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 27 Jul 2021 15:59:55 +0100 Christoph Hellwig <hch@infradead.org> wrote:
>
> > On Tue, Jul 27, 2021 at 04:48:53PM +0200, Arnd Bergmann wrote:
> > > Since these patches are now all that remains, it would be nice to
> > > merge it all through Andrew's Linux-mm tree, which is already based
> > > on top of linux-next.
> >
> > Is it?
>
> the -mm tree is structured as
>
> <90% of stuff>
> linux-next.patch
> <the other 10% of stuff>
>
> So things like Arnd's series which have a dependency on linux-next
> material get added to the "other 10%" and are merged behind the
> linux-next material and all is good.
>
> If possible I'll queue things ahead of linux-next.patch.  Those few
> things which have dependencies on linux-next material get sent to Linus
> after the required linux-next material is merged into mainline.

The first five patches in my series should apply cleanly on mainline
kernels and make sense by themselves, the last patch is the one that
depends on this series as well as another series in the netdev tree,
so that has to go behind linux-next.

I suppose I could also merge the first five through my asm-generic tree
and send you the last one if you prefer, but then again two of the patches
are actually memory management stuff.

         Arnd
