Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CFD3D7C58
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 19:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhG0Rkf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 13:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhG0Rkf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 13:40:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6F4C60FD8;
        Tue, 27 Jul 2021 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627407634;
        bh=PrLaVhJtnv8oDcD5hqybwz9YD9godDZatvRa/JhR9M0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=riMxmf/dvTU1hsiSKcoJ+WSIQNPHXeV+hqeXTH2OUTRPYzLKb9j4cnM1BcbEXRnuE
         jN2rxmHRCaJTDsHvxWPWBBOVAKmNoE94I3BOILUILCqWTChKj0mp3PjVawv1wkhHf/
         tTs5v16S61BPAvtwC/lVATzCerShaYn9n/W7G0vnRtOrOxVtkEoczgL1i8oAKAA28u
         372rOdIIWyiFU+DgtS1Avpu5Zv2si7xK4ueSbRYcbooZbBakZA0sKOT5PgJGqdh+Qf
         AaT1Mk6zQfipgEzaEXKqjuHs32RYGm4woOKqrmStF/NVBUGNazEM0LaB0Wz4HcLM3d
         +HbR57EMZ1Iqg==
Received: by mail-wr1-f49.google.com with SMTP id c16so6292586wrp.13;
        Tue, 27 Jul 2021 10:40:34 -0700 (PDT)
X-Gm-Message-State: AOAM530EYyiFjLb5Mwkk/dBfZ2g36HGylI7keaFk+yTSokVvfMOhPaJS
        Jl88YiDW6hCN9SGG7DZSFe8tnhCjeVFqf4SuqxA=
X-Google-Smtp-Source: ABdhPJwS3rT+yAdjePDzQkl1JqnECPTPxX9jMsyrg697T6BrM+4lIuGtTERdp1j5XGkArSly5ovA2pWeExL5zNS/vV0=
X-Received: by 2002:adf:f446:: with SMTP id f6mr13242430wrp.361.1627407622867;
 Tue, 27 Jul 2021 10:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210727144859.4150043-1-arnd@kernel.org> <20210727144859.4150043-5-arnd@kernel.org>
 <YQBB9yteAwtG2xyp@osiris>
In-Reply-To: <YQBB9yteAwtG2xyp@osiris>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Jul 2021 19:40:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3itgCyc4jDBodTOcwG+XXsDYspZqQVBmy88cGXevY5Yw@mail.gmail.com>
Message-ID: <CAK8P3a3itgCyc4jDBodTOcwG+XXsDYspZqQVBmy88cGXevY5Yw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] mm: simplify compat numa syscalls
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
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
        Linux-MM <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 7:27 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Tue, Jul 27, 2021 at 04:48:57PM +0200, Arnd Bergmann wrote:
> > ---
> >  include/linux/compat.h |  17 ++--
> >  mm/mempolicy.c         | 175 +++++++++++++----------------------------
> >  2 files changed, 63 insertions(+), 129 deletions(-)
> ...
> > +static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
> > +                   unsigned long maxnode)
> > +{
> > +     unsigned long nlongs = BITS_TO_LONGS(maxnode);
> > +     int ret;
> > +
> > +     if (in_compat_syscall())
> > +             ret = compat_get_bitmap(mask,
> > +                                     (const compat_ulong_t __user *)nmask,
> > +                                     maxnode);
>
> compat_ptr() conversion for e.g. nmask is missing with the next patch
> which removes the compat system calls.
> Is that intended or am I missing something?

I don't think it's needed here, since the pointer comes from the system
call argument, which has the compat_ptr() conversion applied in
arch/s390/include/asm/syscall_wrapper.h, not from a compat_uptr_t
that gets passed indirectly. The compat_get_bitmap() conversion
is only needed for byte order adjustment, not for converting pointers.

It's also possible that I'm the one who's missing something.

        Arnd
