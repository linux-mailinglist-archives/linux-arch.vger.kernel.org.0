Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8BE1B62D
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2019 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfEMMmX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 May 2019 08:42:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbfEMMmX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 May 2019 08:42:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3F83AF79;
        Mon, 13 May 2019 12:42:21 +0000 (UTC)
Date:   Mon, 13 May 2019 14:42:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'christophe leroy' <christophe.leroy@c-s.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190513091320.GK9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon 2019-05-13 12:13:20, Andy Shevchenko wrote:
> On Mon, May 13, 2019 at 08:52:41AM +0000, David Laight wrote:
> > From: christophe leroy
> > > Sent: 10 May 2019 18:35
> > > Le 10/05/2019 à 18:24, Steven Rostedt a écrit :
> > > > On Fri, 10 May 2019 10:42:13 +0200
> > > > Petr Mladek <pmladek@suse.com> wrote:
> 
> > > >> -	if (probe_kernel_address(ptr, byte))
> > > >> +	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> > > >>   		return "(efault)";
> > 
> > "efault" looks a bit like a spellling mistake for "default".
> 
> It's a special, thus it's in parenthesis, though somebody can be
> misguided.
> 
> > > Usually, < PAGE_SIZE means NULL pointer dereference (via the member of a
> > > struct)
> > 
> > Maybe the caller should pass in a short buffer so that you can return
> > "(err-%d)"
> > or "(null+%#x)" ?

There are many vsprintf() users. I am afraid that nobody would want
to define extra buffers for error messages. It must fit into
the one for the formatted string.


> In both cases it should be limited to the size of pointer (8 or 16
> characters). Something like "(e:%4d)" would work for error codes.

I am afraid that we could get 10 different proposals from a huge
enough group of people. I wanted to start with something simple
(source code). I know that (efault) might be confused with
"default" but it is still just one string to grep.


> The "(null)" is good enough by itself and already an established
> practice..

(efault) made more sense with the probe_kernel_read() that
checked wide range of addresses. Well, I still think that
it makes sense to distinguish a pure NULL. And it still
used also for IS_ERR_VALUE().

Best Regards,
Petr
