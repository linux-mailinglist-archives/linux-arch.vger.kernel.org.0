Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBEC19B75
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEJKVH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 10 May 2019 06:21:07 -0400
Received: from ozlabs.org ([203.11.71.1]:44463 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfEJKVH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 May 2019 06:21:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 450mSt2tmqz9sD4;
        Fri, 10 May 2019 20:21:02 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Michal =?utf-8?Q?Such=C3=A1ne?= =?utf-8?Q?k'?= 
        <msuchanek@suse.de>, Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-s390\@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: RE: [PATCH] vsprintf: Do not break early boot with probing addresses
In-Reply-To: <8ad8bb83b7034f7e92df12040fb8c2c2@AcuMS.aculab.com>
References: <20190509121923.8339-1-pmladek@suse.com> <20190509153829.06319d0c@kitsune.suse.cz> <8ad8bb83b7034f7e92df12040fb8c2c2@AcuMS.aculab.com>
Date:   Fri, 10 May 2019 20:21:02 +1000
Message-ID: <87ef56vcdt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:
> From: Michal Suchánek
>> Sent: 09 May 2019 14:38
> ...
>> > The problem is the combination of some new code called via printk(),
>> > check_pointer() which calls probe_kernel_read(). That then calls
>> > allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
>> > (before we've patched features).
>> 
>> There is early_mmu_has_feature for this case. mmu_has_feature does not
>> work before patching so parts of kernel that can run before patching
>> must use the early_ variant which actually runs code reading the
>> feature bitmap to determine the answer.
>
> Does the early_ variant get patched so the it is reasonably
> efficient after the 'patching' is done?

No they don't get patched ever. The name is a bit misleading I guess.

> Or should there be a third version which gets patched across?

For a case like this it's entirely safe to just skip the code early in
boot, so if it was a static_key_false everything would just work.

Unfortunately the way the code is currently written we would have to
change all MMU features to static_key_false and that risks breaking
something else.

We have a long standing TODO to rework all our feature logic and unify
CPU/MMU/firmware/etc. features. Possibly as part of that we can come up
with a scheme where the default value is per-feature bit.

Having said all that, in this case the overhead of the test and branch
is small compared to the cost of writing to the SPR which controls user
access and then doing an isync, so it's all somewhat premature
optimisation.

cheers
