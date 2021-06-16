Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BFE3AA50C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 22:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhFPUT2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhFPUT2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 16:19:28 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5F9C061574;
        Wed, 16 Jun 2021 13:17:21 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltbyG-0094ax-CS; Wed, 16 Jun 2021 20:17:08 +0000
Date:   Wed, 16 Jun 2021 20:17:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of
 switch_stack
Message-ID: <YMpcRKFq3YlnSs4r@zeniv-ca.linux.org.uk>
References: <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <87zgvqor7d.fsf_-_@disp2133>
 <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133>
 <87pmwlek8d.fsf_-_@disp2133>
 <87k0mtek4n.fsf_-_@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0mtek4n.fsf_-_@disp2133>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 16, 2021 at 01:31:52PM -0500, Eric W. Biederman wrote:

> +.macro	SAVE_SWITCH_STACK
> +	DO_SWITCH_STACK
> +1:	ldl_l	$1, TI_FLAGS($8)
> +	bis	$1, _TIF_ALLREGS_SAVED, $1
> +	stl_c	$1, TI_FLAGS($8)
> +	beq	$1, 2f
> +.subsection 2
> +2:	br	1b
> +.previous
> +.endm

What the hell?  *IF* you are going to go that way, at least put it into
->status, not ->flag - those are thread-synchronous and do not require that
kind of masturbation.

> +.macro	RESTORE_SWITCH_STACK
> +1:	ldl_l	$1, TI_FLAGS($8)
> +	bic	$1, _TIF_ALLREGS_SAVED, $1
> +	stl_c	$1, TI_FLAGS($8)
> +	beq	$1, 2f
> +.subsection 2
> +2:	br	1b
> +.previous
> +	UNDO_SWITCH_STACK
> +.endm

Ditto.  What do you need that flag for, anyway?

> @@ -117,7 +117,13 @@ get_reg_addr(struct task_struct * task, unsigned long regno)
>  		zero = 0;
>  		addr = &zero;
>  	} else {
> -		addr = task_stack_page(task) + regoff[regno];
> +		int off = regoff[regno];
> +		if (WARN_ON_ONCE((off < PT_REG(r0)) &&
> +				!test_ti_thread_flag(task_thread_info(task),
> +						     TIF_ALLREGS_SAVED)))
> +			addr = &zero;
> +		else
> +			addr = task_stack_page(task) + off;

A sanity check in slow path, buggering the hell out of a fast path?
