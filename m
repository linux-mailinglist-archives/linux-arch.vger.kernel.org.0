Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548161A1B5
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfEJQlB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 12:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbfEJQlB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 May 2019 12:41:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC6221479;
        Fri, 10 May 2019 16:40:59 +0000 (UTC)
Date:   Fri, 10 May 2019 12:40:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing
 addresses
Message-ID: <20190510124058.0d44b441@gandalf.local.home>
In-Reply-To: <20190510183258.1f6c4153@mschwideX1>
References: <20190510081635.GA4533@jagdpanzerIV>
        <20190510084213.22149-1-pmladek@suse.com>
        <20190510122401.21a598f6@gandalf.local.home>
        <20190510183258.1f6c4153@mschwideX1>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 10 May 2019 18:32:58 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Fri, 10 May 2019 12:24:01 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 10 May 2019 10:42:13 +0200
> > Petr Mladek <pmladek@suse.com> wrote:
> >   
> > >  static const char *check_pointer_msg(const void *ptr)
> > >  {
> > > -	char byte;
> > > -
> > >  	if (!ptr)
> > >  		return "(null)";
> > >  
> > > -	if (probe_kernel_address(ptr, byte))
> > > +	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> > >  		return "(efault)";
> > >      
> > 
> > 
> > 	< PAGE_SIZE ?
> > 
> > do you mean: < TASK_SIZE ?  
> 
> The check with < TASK_SIZE would break on s390. The 'ptr' is
> in the kernel address space, *not* in the user address space.
> Remember s390 has two separate address spaces for kernel/user
> the check < TASK_SIZE only makes sense with a __user pointer.
> 

So we allow this to read user addresses? Can't that cause a fault?

If the condition is true, we return "(efault)".

-- Steve
