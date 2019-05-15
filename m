Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E6F1E974
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 09:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEOHxn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 May 2019 03:53:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:57100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfEOHxm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 May 2019 03:53:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8FDD9AF3F;
        Wed, 15 May 2019 07:53:40 +0000 (UTC)
Date:   Wed, 15 May 2019 09:53:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@aculab.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190515075339.7biocrjfpxj77l3b@pathway.suse.cz>
References: <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
 <20190514020730.GA651@jagdpanzerIV>
 <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com>
 <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
 <20190514143751.48e81e05@oasis.local.home>
 <CAMuHMdUhy3uB+G23uXh__F2Y_Jsam5uS1Q5jJC95kWAOEM8WRA@mail.gmail.com>
 <20190514153503.6b7faaa7@oasis.local.home>
 <CAMuHMdUFEwxwQUWg0HNUiz75hP6S7TVGSx7fWXnsQ_3qsVfotQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUFEwxwQUWg0HNUiz75hP6S7TVGSx7fWXnsQ_3qsVfotQ@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed 2019-05-15 09:23:05, Geert Uytterhoeven wrote:
> Hi Steve,
> 
> On Tue, May 14, 2019 at 9:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 14 May 2019 21:13:06 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > Do we care about the value? "(-E%u)"?
> > > >
> > > > That too could be confusing. What would (-E22) be considered by a user
> > > > doing an sprintf() on some string. I know that would confuse me, or I
> > > > would think that it was what the %pX displayed, and wonder why it
> > > > displayed it that way. Whereas "(fault)" is quite obvious for any %p
> > > > use case.
> > >
> > > I would immediately understand there's a missing IS_ERR() check in a
> > > function that can return  -EINVAL, without having to add a new printk()
> > > to find out what kind of bogus value has been received, and without
> > > having to reboot, and trying to reproduce...
> >
> > I have to ask. Has there actually been a case that you used a %pX and
> > it faulted, and you had to go back to find what the value of the
> > failure was?
> 
> If it faulted, the bad pointer value is obvious from the backtrace.
> If the code avoids the fault by verifying the pointer and returning
> "(efault)" instead, the bad pointer value is lost.
> 
> Or am I missing something?

Should buggy printk() crash the system?

Another problem is that vsprintf() is called in printk() under
lockbuf_lock. The messages are stored into printk_safe per CPU
buffers. It allows to see the nested messages. But there is still
a bigger risk of missing them than with a "normal" fault.

Finally, various variants of these checks were already used
in "random" printf formats. The only change is that we are
using them consistently everywhere[*] a pointer is accessed.

[*] Just the top level pointer is checked. Some pointer modifiers
are accessing ptr->ptr->val. The lower level pointers are not
checked to avoid too much complexity.

Best Regards,
Petr
