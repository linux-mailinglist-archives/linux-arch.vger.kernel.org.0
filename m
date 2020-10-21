Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C0294A2E
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 11:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437242AbgJUJIs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437186AbgJUJIr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Oct 2020 05:08:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85279C0613CE;
        Wed, 21 Oct 2020 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eb1OL+P4JmUK1jhG+vTVWpbKbq0qkyHl8thry52FTQA=; b=rtIa9spk+eGaALa7gNwT0CJsKK
        NjlQ0TaZClui6FNLaSH6sH410ckUEAUgWngz6KlxlBPFXfRsleXkZnz6ehdTlmAjGEDZ54LCQKjzW
        mVkO6Qrz9t1ONh71M5vaOQ5etGEYUyqKkVWOoiOoxp1OWMTTQymeYA9Bq+58R1K92TY9eQDNJBhMo
        j3j5B91C/arUdOUsfw/WJeofsIebuUbqnXHmWhjxv5BqEQh/x/dq8CROgLXRvJ7hEs8U3WUEjTr3U
        sxRZjkXGtDIhLFLuspHPnxp/ilX5Zbg6Dkuh7PJ6uq/ocHYjHiAPX19862wtZObxjvIsngNw8WzZa
        ycCtxeZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVA6W-00026P-MZ; Wed, 21 Oct 2020 09:08:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B5E2304BAE;
        Wed, 21 Oct 2020 11:08:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6997B2BB99C35; Wed, 21 Oct 2020 11:08:17 +0200 (CEST)
Date:   Wed, 21 Oct 2020 11:08:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
Message-ID: <20201021090817.GU2651@hirez.programming.kicks-ass.net>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com>
 <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 10:56:06AM +0200, Peter Zijlstra wrote:

> The "falls through to next function" seems to be limited to things like:
> 
>   warning: objtool: setup_vq() falls through to next function setup_vq.cold()
>   warning: objtool: e1000_xmit_frame() falls through to next function e1000_xmit_frame.cold()
> 
> So something's weird with the .cold thing on vmlinux.o runs.

Shiny, check this:

$ nm defconfig-build/vmlinux.o | grep setup_vq
00000000004d33a0 t setup_vq
00000000004d4c20 t setup_vq
000000000001edcc t setup_vq.cold
000000000001ee31 t setup_vq.cold
00000000004d3dc0 t vp_setup_vq

$ nm defconfig-build/vmlinux.o | grep e1000_xmit_frame
0000000000741490 t e1000_xmit_frame
0000000000763620 t e1000_xmit_frame
000000000002f579 t e1000_xmit_frame.cold
0000000000032b6e t e1000_xmit_frame.cold

$ nm defconfig-build/vmlinux.o | grep e1000_diag_test
000000000074c220 t e1000_diag_test
000000000075eb70 t e1000_diag_test
000000000002fc2a t e1000_diag_test.cold
0000000000030880 t e1000_diag_test.cold

I guess objtool goes sideways when there's multiple symbols with the
same name in a single object file. This obvously never happens on single
TU .o files.

Not sure what to do about that.
