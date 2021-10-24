Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE84389E7
	for <lists+linux-arch@lfdr.de>; Sun, 24 Oct 2021 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJXPju (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Oct 2021 11:39:50 -0400
Received: from elvis.franken.de ([193.175.24.41]:37604 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhJXPjs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 24 Oct 2021 11:39:48 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mefYp-0006bc-03; Sun, 24 Oct 2021 17:37:23 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id EA281C265F; Sun, 24 Oct 2021 17:27:45 +0200 (CEST)
Date:   Sun, 24 Oct 2021 17:27:45 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Maciej Rozycki <macro@orcam.me.uk>, linux-mips@vger.kernel.org
Subject: Re: [PATCH 05/20] signal/mips: Update (_save|_restore)_fp_context to
 fail with -EFAULT
Message-ID: <20211024152745.GD4721@alpha.franken.de>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-5-ebiederm@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:51PM -0500, Eric W. Biederman wrote:
> When an instruction to save or restore a register from the stack fails
> in _save_fp_context or _restore_fp_context return with -EFAULT.  This
> change was made to r2300_fpu.S[1] but it looks like it got lost with
> the introduction of EX2[2].  This is also what the other implementation
> of _save_fp_context and _restore_fp_context in r4k_fpu.S does, and
> what is needed for the callers to be able to handle the error.
> 
> Furthermore calling do_exit(SIGSEGV) from bad_stack is wrong because
> it does not terminate the entire process it just terminates a single
> thread.
> 
> As the changed code was the only caller of arch/mips/kernel/syscall.c:bad_stack
> remove the problematic and now unused helper function.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Maciej Rozycki <macro@orcam.me.uk>
> Cc: linux-mips@vger.kernel.org
> [1] 35938a00ba86 ("MIPS: Fix ISA I FP sigcontext access violation handling")
> [2] f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
> Fixes: f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/mips/kernel/r2300_fpu.S | 4 ++--
>  arch/mips/kernel/syscall.c   | 9 ---------
>  2 files changed, 2 insertions(+), 11 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
