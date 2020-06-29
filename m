Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACA220DEEC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 23:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgF2Uaj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 16:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbgF2Uah (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 16:30:37 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E53C061755;
        Mon, 29 Jun 2020 13:30:36 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq0Q8-002Jaj-5k; Mon, 29 Jun 2020 20:30:28 +0000
Date:   Mon, 29 Jun 2020 21:30:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
Message-ID: <20200629203028.GB2786714@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
 <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 12:23:34PM -0700, Linus Torvalds wrote:
> On Mon, Jun 29, 2020 at 11:28 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > ->get2() takes task+regset+buffer, returns the amount of free space
> > left in the buffer on success and -E... on error.
> 
> Can we please give it a better name than "get2"?
> 
> That's not a great name to begin with, and it's a completely
> nonsensical name by the end of this series when you've removed the
> original "get" function.
> 
> So either:
> 
>  (a) add one final patch to rename "get2" all back to "get" after you
> got rid of the old "get"

Bad idea, IMO...

>  (b) or just call it something better to begin with. Maybe just
> "get_regset" instead?

<nod>

Frankly, other field names there are also nasty - 'set' is not
fun to grep for, but there are 'n' and 'size' as well.  There's
also 'bias'  and 'align' (both completely unused)...

> I'd prefer (b) just because I think it will be a lot clearer if we
> ever end up having old patches forward-ported (or, more likely,
> newpatches back-ported), so having a "get" function that changed
> semantics but got back the old name sounds bad to me.
> 
> Other than that, I can't really argue with the numbers:
> 
>  41 files changed, 1368 insertions(+), 2347 deletions(-)
> 
> looks good to me, and the code seems more understandable.

FWIW, there's also ->set() side of that thing.  Tons of boilerplate
in those; I hadn't seriously looked into that part, but I suspect
that "do copyin in the caller, pass the kernel buffer to the
method, always start at offset 0" would also trim a lot of crap.
I'd rather leave that one for later - this series had been painful
enough.

Other things in the same area: conversion of fdpic coredumps to
regset (fairly easy, I've a patch series doing that in the local
tree), conversion of the few remaining non-regset architectures
to regset-based coredump (kill a large chunk of rotting code in
fs/binfmt_elf.c, along with quite a few pieces of old per-arch
coredump helpers), unification of compat ELF (done locally,
mipsn32/mipso32 gone, all compat done via compat_binfmt_elf.c,
x32 horrors sanitized - IMO
#define PRSTATUS_SIZE \
       (test_thread_flag(TIF_X32) \
               ? sizeof(struct compat_elf_prstatus) \
               : sizeof(struct i386_elf_prstatus))
#define SET_PR_FPVALID(S) \
       (*(test_thread_flag(TIF_X32) \
               ? &(S)->pr_fpvalid      \
               : &((struct i386_elf_prstatus *)(S))->pr_fpvalid) = 1)
is much better than
#define PRSTATUS_SIZE(S, R) (R != sizeof(S.pr_reg) ? 144 : 296)
#define SET_PR_FPVALID(S, V, R) \
  do { *(int *) (((void *) &((S)->pr_reg)) + R) = (V); } \
  while (0)
) and a bunch of assorted cleanups that got trimmed from the
regset series...

I'll probably post fdpic and compat series tonight and get
back to uaccess and VFS stuff.
