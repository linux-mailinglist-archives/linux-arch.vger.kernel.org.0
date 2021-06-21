Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE6E3AE1A4
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 04:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFUCaV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Jun 2021 22:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhFUCaU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Jun 2021 22:30:20 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21FAC061574;
        Sun, 20 Jun 2021 19:28:07 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lv9fE-00AfVg-W3; Mon, 21 Jun 2021 02:27:53 +0000
Date:   Mon, 21 Jun 2021 02:27:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <YM/5KAlgTtR6ncOl@zeniv-ca.linux.org.uk>
References: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <87zgvqor7d.fsf_-_@disp2133>
 <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133>
 <87pmwlek8d.fsf_-_@disp2133>
 <87k0mtek4n.fsf_-_@disp2133>
 <393c37de-5edf-effc-3d06-d7e63f34a317@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393c37de-5edf-effc-3d06-d7e63f34a317@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 21, 2021 at 02:01:18PM +1200, Michael Schmitz wrote:
> Hi Eric,
> 
> instrumenting get_reg on m68k and using a similar patch to yours to warn
> when unsaved registers are accessed on the switch stack, I get a hit from
> getegid and getegid32, just by running a simple ptrace on ls.
> 
> Going to wack those two moles now ...

Explain, please.  get_reg() is called by tracer; whose state are you checking?
Because you are *not* accessing the switch stack of the caller of get_reg().
And tracee should be in something like syscall_trace() or do_notify_resume();
both have SAVE_SWITCH_STACK done by the glue...
