Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8B73D7DF9
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhG0SuJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 14:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0SuJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 14:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18F3260FE3;
        Tue, 27 Jul 2021 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627411809;
        bh=FEnwgSbKVXqz/f02D+yC03c3XbgdHc6UQnZBnRvCJ/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aTvhKIKZ1ioo9DG0Ec9o/GHguV1Ls8Zpgym6pDWcFaNRWivLNiLs3OTCrstGNfOKs
         GYBakEdIJ12kYhkUhqg+tOIolcIb5CzQ6OTuCoADjYmLiI25p4cgat6MWKirxMzBn/
         352r/ZmRWn/7CQHJO+JzH27w1AHj9B1xK/Nn0TewFpaj1y7GxvPnDYLkim5VS64g0V
         06QFD449q6vX6wKDDryuRrutXpXvt77m9GnAp5mB+Al7hIqJmEj1teWUskJ7YYwsIn
         N+imzTNgxUezFzNwky77iBsCOYrkNrnlOcsOxOnroPd5ezkMaL9zUmOn/CumedaEML
         +L3MG8J2lY+Mw==
Received: by mail-lf1-f51.google.com with SMTP id z2so23497586lft.1;
        Tue, 27 Jul 2021 11:50:09 -0700 (PDT)
X-Gm-Message-State: AOAM532heSb7RK5bbGEQzFPUHQM1OAir3WbFsEk2kNDQHm009XvpN27z
        wn4NChedsuO829eBRGx5DPkgTp0dph5Ei8wAMqw=
X-Google-Smtp-Source: ABdhPJyJoGfE0vjMAu17Dx3oLfkZN1O26Yflb54n4xga3o5XuLKsejT/cbFSiPGK2CJQqQHqBmqSL7vlY8Dk6BlYaZM=
X-Received: by 2002:adf:e107:: with SMTP id t7mr26004543wrz.165.1627411796641;
 Tue, 27 Jul 2021 11:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210727144859.4150043-1-arnd@kernel.org> <20210727144859.4150043-5-arnd@kernel.org>
 <YQBB9yteAwtG2xyp@osiris> <CAK8P3a3itgCyc4jDBodTOcwG+XXsDYspZqQVBmy88cGXevY5Yw@mail.gmail.com>
 <YQBSpxZR4P/Phpf1@osiris>
In-Reply-To: <YQBSpxZR4P/Phpf1@osiris>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Jul 2021 20:49:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0WT36Lg4nRBWx_kqb9yKj0mHx8gTdzCsDfrx1tQSEqbA@mail.gmail.com>
Message-ID: <CAK8P3a0WT36Lg4nRBWx_kqb9yKj0mHx8gTdzCsDfrx1tQSEqbA@mail.gmail.com>
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

On Tue, Jul 27, 2021 at 8:38 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> -268  common    mbind                   sys_mbind                       compat_sys_mbind
> -269  common    get_mempolicy           sys_get_mempolicy               compat_sys_get_mempolicy
> -270  common    set_mempolicy           sys_set_mempolicy               compat_sys_set_mempolicy
> +268  common    mbind                   sys_mbind                       sys_mbind
> +269  common    get_mempolicy           sys_get_mempolicy               sys_get_mempolicy
> +270  common    set_mempolicy           sys_set_mempolicy               sys_set_mempolicy
>
> would remove compat_ptr() conversion from nmask above if I'm not mistaken.

Maybe I'm misremembering how compat syscalls work on s390. Doesn't
SYSCALL_DEFINEx(sys_mbind) still create two entry points __s390x_sys_mbind()
and __s390_sys_mbind() with different argument conversion (__SC_CAST vs
__SC_COMPAT_CAST)? I thought that was the whole point of the macros.

        Arnd
