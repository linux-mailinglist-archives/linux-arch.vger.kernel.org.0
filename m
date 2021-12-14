Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0347497D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 18:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhLNReC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 12:34:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49840 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhLNReB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 12:34:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE3A61639;
        Tue, 14 Dec 2021 17:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AF7C34606;
        Tue, 14 Dec 2021 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639503240;
        bh=a14UGs1HcGFj82qfqT6BrA/2RMCLBg5mQx9AVEK4VpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlNfM5dbjGpaDzMXebg0TsJnfkA5Czsy+vca92OsqdJw0F5cjEpoJo01rPHq/3rrJ
         fuW0NaLq+vFPwBn5y4KGLJi7jFsGXAmEkMaF9RuphWRETj7RucU3CpLTqB4osHXdNL
         UN20De1UpptLO/bPtLRtxHSyQ83o9UJY3Qwi2Is8=
Date:   Tue, 14 Dec 2021 18:33:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
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
Subject: Re: [PATCH 41/43] security: kmsan: fix interoperability with
 auto-initialization
Message-ID: <YbjVhSbd+wkvihfm@kroah.com>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-42-glider@google.com>
 <YbjIbpFRqMac/X8s@kroah.com>
 <CAG_fn=XSMbgyJZnivZCh30M3JYQsJZZ0yL+5z074B_WrEBkRDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XSMbgyJZnivZCh30M3JYQsJZZ0yL+5z074B_WrEBkRDQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 06:00:41PM +0100, Alexander Potapenko wrote:
> On Tue, Dec 14, 2021 at 5:38 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > > @@ -124,6 +125,7 @@ choice
> > >       config INIT_STACK_ALL_ZERO
> > >               bool "zero-init everything (strongest and safest)"
> > >               depends on CC_HAS_AUTO_VAR_INIT_ZERO
> > > +             depends on !KMSAN
> >
> > So this means KMSAN is a developer debugging feature only and should
> > never be turned on on a real device/server that has users?
> 
> 100% correct. KMSAN is way slower than KASAN, it also eats 2/3 of your
> memory to store the metadata.
> I thought it was sort of self-evident, but I can surely mention this
> explicitly in the cover letter.

Please mention it here and in the Kconfig option for it as well (don't
know if it was there or not.)

Also you might want to print out very large "DO NOT USE THIS ON A REAL
MACHINE" to the kernel log when booting, like other kernel options are
starting to do that should not be enabled.

thanks,

greg k-h
