Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7FF19947
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 10:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfEJIGF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 04:06:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726899AbfEJIGF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 May 2019 04:06:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 718D5AD69;
        Fri, 10 May 2019 08:06:03 +0000 (UTC)
Date:   Fri, 10 May 2019 10:06:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190510080602.mdfk54f6lpyg6unw@pathway.suse.cz>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190510043200.GC15652@jagdpanzerIV>
 <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com>
 <20190510050709.GA1831@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510050709.GA1831@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri 2019-05-10 14:07:09, Sergey Senozhatsky wrote:
> On (05/09/19 21:47), Linus Torvalds wrote:
> >    [ Sorry about html and mobile crud, I'm not at the computer right now ]
> >    How about we just undo the whole misguided probe_kernel_address() thing?
> 
> But the problem will remain - %pS/%pF on PPC (and some other arch-s)
> do dereference_function_descriptor(), which calls probe_kernel_address().
> So if probe_kernel_address() starts to dump_stack(), then we are heading
> towards stack overflow. Unless I'm totally missing something.

That is true. On the other hand, %pS/%pF uses
dereference_function_descriptor() only on three architectures.
And these modifiers are used only rarely (ok, in dump_stack()
but still).

On the other hand, any infinite loop in vsprintf() via
probe_kernel_address() would break any printk(). And would be
hard to debug.

I tend to agree with Linus. probe_kernel_address() is too complicated.
It is prone to these infinite loops and should not be used in
the default printk() path.

It would be nice to have a lightweight and safe alternative. But
I can't find any. And I think that it is not worth any huge
complexity. It was just a nice to have idea...


I am going to send a patch replacing probe_kernel_address() with
a simple check:

	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
		return "(efault)";

The original patch still makes sense because it adds the check
into more locations and replaces some custom variants.

Best Regards,
Petr
