Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00156474831
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhLNQeH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbhLNQeH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:34:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAADC061574;
        Tue, 14 Dec 2021 08:34:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF64612FF;
        Tue, 14 Dec 2021 16:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AE6C34601;
        Tue, 14 Dec 2021 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639499645;
        bh=y9Tsf9OdTgQ1kMcJ/PUzR3f3WRy9zX8FGn4p772Rqxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cem+MBYsmw3h/iOiG9hzHtrjGv9dTWO4AuNK0GROz1f2ChQbtSx4x27m1N4FRNlSr
         lUZdkVcdmebi4sWJC3EbA3fvJm+96jGmFyIpijLHmBSyBC8RKlzHgzv5GoGSVy2vi9
         Bnp25aHWWpPAetVN26ZiedYmVNPwyBFGy5rT7YSc=
Date:   Tue, 14 Dec 2021 17:34:02 +0100
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
Subject: Re: [PATCH 13/43] kmsan: add KMSAN runtime core
Message-ID: <YbjHerrHit/ZqXYs@kroah.com>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-14-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-14-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:20PM +0100, Alexander Potapenko wrote:
> This patch adds the core parts of KMSAN runtime and associated files:
> 
>   - include/linux/kmsan-checks.h: user API to poison/unpoison/check
>     the kernel memory;
>   - include/linux/kmsan.h: declarations of KMSAN hooks to be referenced
>     outside of KMSAN runtime;
>   - lib/Kconfig.kmsan: CONFIG_KMSAN and related declarations;
>   - Makefile, mm/Makefile, mm/kmsan/Makefile: boilerplate Makefile code;
>   - mm/kmsan/annotations.c: non-inlineable implementation of KMSAN_INIT();
>   - mm/kmsan/core.c: core functions that operate with shadow and origin
>     memory and perform checks, utility functions;
>   - mm/kmsan/hooks.c: KMSAN hooks for kernel subsystems;
>   - mm/kmsan/init.c: KMSAN initialization routines;
>   - mm/kmsan/instrumentation.c: functions called by KMSAN instrumentation;
>   - mm/kmsan/kmsan.h: internal KMSAN declarations;
>   - mm/kmsan/shadow.c: routines that encapsulate metadata creation and
>     addressing;
>   - scripts/Makefile.kmsan: CFLAGS_KMSAN
>   - scripts/Makefile.lib: KMSAN_SANITIZE and KMSAN_ENABLE_CHECKS macros


That's an odd way to write a changelog, don't you think?

You need to describe what you are doing here and why you are doing it.
Not a list of file names, we can see that in the diffstat.

Also, you don't mention you are doing USB stuff here at all.  And why
are you doing it here?  That should be added in a later patch.

Break this up into smaller, logical, pieces that add the infrastructure
and build on it.  Don't just chop your patches up on a logical-file
boundry, as you are adding stuff in this patch that you do not need for
many more later on, which means it was not needed here.

thanks,

greg k-h
