Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999833AF5BD
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 20:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhFUTB3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhFUTB3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 15:01:29 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6D2C061574;
        Mon, 21 Jun 2021 11:59:14 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvP8P-00AvlT-GG; Mon, 21 Jun 2021 18:59:01 +0000
Date:   Mon, 21 Jun 2021 18:59:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
Message-ID: <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133>
 <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 21, 2021 at 01:54:56PM +0000, Al Viro wrote:
> On Tue, Jun 15, 2021 at 02:58:12PM -0700, Linus Torvalds wrote:
> 
> > And I think our horrible "kernel threads return to user space when
> > done" is absolutely horrifically nasty. Maybe of the clever sort, but
> > mostly of the historical horror sort.
> 
> How would you prefer to handle that, then?  Separate magical path from
> kernel_execve() to switch to userland?  We used to have something of
> that sort, and that had been a real horror...
> 
> As it is, it's "kernel thread is spawned at the point similar to
> ret_from_fork(), runs the payload (which almost never returns) and
> then proceeds out to userland, same way fork(2) would've done."
> That way kernel_execve() doesn't have to do anything magical.
> 
> Al, digging through the old notes and current call graph...

	There's a large mess around do_exit() - we have a bunch of
callers all over arch/*; if nothing else, I very much doubt that really
want to let tracer play with a thread in the middle of die_if_kernel()
or similar.

We sure as hell do not want to arrange for anything on the kernel
stack in such situations, no matter what's done in exit(2)...
