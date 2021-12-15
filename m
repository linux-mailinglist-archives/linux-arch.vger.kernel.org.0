Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B023475AEB
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 15:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbhLOOnp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 09:43:45 -0500
Received: from foss.arm.com ([217.140.110.172]:53888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243531AbhLOOnd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E3D61FB;
        Wed, 15 Dec 2021 06:43:33 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 648A33F774;
        Wed, 15 Dec 2021 06:43:28 -0800 (PST)
Date:   Wed, 15 Dec 2021 14:43:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/43] kcsan: clang: retire CONFIG_KCSAN_KCOV_BROKEN
Message-ID: <Ybn/DZb32ujokTnJ@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-13-glider@google.com>
 <Ybnuup0eMnhrwp8e@FVFF77S0Q05N>
 <CANpmjNNLG0F9WzNnQkJX+QEqdxnhWstuag_9jrid7zdJgivHyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNLG0F9WzNnQkJX+QEqdxnhWstuag_9jrid7zdJgivHyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 15, 2021 at 02:39:43PM +0100, Marco Elver wrote:
> On Wed, 15 Dec 2021 at 14:33, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Dec 14, 2021 at 05:20:19PM +0100, Alexander Potapenko wrote:
> > > kcov used to be broken prior to Clang 11, but right now that version is
> > > already the minimum required to build with KCSAN, that is why we don't
> > > need KCSAN_KCOV_BROKEN anymore.
> >
> > Just to check, how is that requirement enforced?
> 
> HAVE_KCSAN_COMPILER will only be true with Clang 11 or later, due to
> no prior compiler having "-tsan-distinguish-volatile=1".

I see -- could we add wording to that effect into the commit messge?

> > I see the core Makefiles enforce 10.0.1+, but I couldn't spot an explicit
> > version dependency in Kconfig.kcsan.
> >
> > Otherwise, this looks good to me!
> 
> I think 5.17 will be Clang 11 only, so we could actually revert
> ea91a1d45d19469001a4955583187b0d75915759:
> https://lkml.kernel.org/r/Yao86FeC2ybOobLO@archlinux-ax161
> 
> I should resend that to be added to the -kbuild tree.

FWIW, that also works for me.

Thanks,
Mark.
