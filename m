Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F322A1863
	for <lists+linux-arch@lfdr.de>; Sat, 31 Oct 2020 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgJaPDI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 31 Oct 2020 11:03:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:41607 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbgJaPDI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 31 Oct 2020 11:03:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CNj930Clbz9vCxd;
        Sat, 31 Oct 2020 16:03:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id McRUnAiLxW8A; Sat, 31 Oct 2020 16:03:02 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CNj925qDJz9vCxc;
        Sat, 31 Oct 2020 16:03:02 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 41AC91774; Sat, 31 Oct 2020 16:05:39 +0100 (CET)
Received: from 37-170-67-121.coucou-networks.fr
 (37-170-67-121.coucou-networks.fr [37.170.67.121]) by messagerie.c-s.fr
 (Horde Framework) with HTTP; Sat, 31 Oct 2020 16:05:39 +0100
Date:   Sat, 31 Oct 2020 16:05:39 +0100
Message-ID: <20201031160539.Horde.n5yNbG9LoUSWqtuPQW_h3w1@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Nick Hu <nickhu@andestech.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michal Simek <monstr@monstr.eu>,
        Chris Zankel <chris@zankel.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul McKenney <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>, Mel Gorman <mgorman@suse.de>,
        David Airlie <airlied@linux.ie>,
        Christoph Hellwig <hch@lst.de>, linux-csky@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Ben Segall <bsegall@google.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-xtensa@linux-xtensa.org, Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic
 & friends
References: <20201029221806.189523375@linutronix.de>
 <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com>
 <87pn50ob0s.fsf@nanos.tec.linutronix.de>
 <87blgknjcw.fsf@nanos.tec.linutronix.de>
 <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com>
 <87sg9vl59i.fsf@nanos.tec.linutronix.de>
 <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com>
 <CAK8P3a3FyKTHDSAPCyP8e7UA0LN3OvAatNK_vQ3tnBsdbou4sA@mail.gmail.com>
In-Reply-To: <CAK8P3a3FyKTHDSAPCyP8e7UA0LN3OvAatNK_vQ3tnBsdbou4sA@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> There are also some users on 10+ year old 32-bit netbooks or
> business laptops, both x86 and Apple G4.
> The longest-lived 32-bit embedded systems with large memory
> (other than Arm) are probably NXP QorIQ P20xx/P40xx used in
> military VME bus systems, and low-end embedded systems based
> on Vortex86.
> I'm less worried about all of these because upstream kernel
> support for ppc32 and x86-32 is already bitrotting and they will
> likely get stuck on the last working kernel before the
> TI/Renesas/NXP Arm systems do.
>

Upstream kernel support for ppc32 is bitrotting, seriously ? What do  
you mean exactly ?

ppc32 is actively supported, with recent addition of support of  
hugepages, kasan, uaccess protection, VMAP stack, etc ...

Christophe


