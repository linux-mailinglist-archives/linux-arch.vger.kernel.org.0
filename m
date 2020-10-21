Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3BB294AC8
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441518AbgJUJwC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441517AbgJUJwB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Oct 2020 05:52:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B85C0613CE;
        Wed, 21 Oct 2020 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TTonoSMC9Qr/U6/6E+qiLczLqU7QnBRx2AW/ar8m2XI=; b=th0SHZXYoGIMeeNQk+cXXn3ZRf
        4eqHsJyAUeQKe0z/FZOgQg3ZKafZO/IAdXuUjcIsQI8/EwkTubleigyQhAvFkH6ILAyudw/+ETGLV
        SwMchF/jLJeFRNuNJQT/hJXEogvS6OyuEE65LokfdM2FJXRIpXQP4HwCDwqnt85mQHh+Aj/8SZs9x
        QdDJ9xPOSco262ZobeHTh85BDuNYKoZ35/lPHthqt9nJ4G5zuO+YXBqmgzGyyudm59MOtmHyP1/TO
        DJ0+eaqlHK1IGczOA12VYkWgY/8r/3psr144sr2lv6QAgtPP5mpwF9GWLwdmfjUcNz63fCjQIBaIf
        OLe/XMig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVAmN-0004m8-56; Wed, 21 Oct 2020 09:51:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 055A73035D4;
        Wed, 21 Oct 2020 11:51:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7CA2214528C1; Wed, 21 Oct 2020 11:51:33 +0200 (CEST)
Date:   Wed, 21 Oct 2020 11:51:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Jann Horn <jannh@google.com>,
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
Message-ID: <20201021095133.GA2628@hirez.programming.kicks-ass.net>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com>
 <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020185217.ilg6w5l7ujau2246@treble>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 20, 2020 at 01:52:17PM -0500, Josh Poimboeuf wrote:
> > arch/x86/lib/retpoline.S:
> > __x86_retpoline_rdi()+0x10: return with modified stack frame
> > __x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=7+8
> > __x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=-1+0
> 
> Is this with upstream?  I thought we fixed that with
> UNWIND_HINT_RET_OFFSET.

I can't reproduce this one either; but I do get different warnings:

gcc (Debian 10.2.0-13) 10.2.0, x86_64-defconfig:

defconfig-build/vmlinux.o: warning: objtool: __x86_indirect_thunk_rax() falls through to next function __x86_retpoline_rax()
defconfig-build/vmlinux.o: warning: objtool:   .altinstr_replacement+0x1063: (branch)
defconfig-build/vmlinux.o: warning: objtool:   __x86_indirect_thunk_rax()+0x0: (alt)
defconfig-build/vmlinux.o: warning: objtool:   __x86_indirect_thunk_rax()+0x0: <=== (sym)

(for every single register, not just rax)

Which is daft as well, because the retpoline.o run is clean. It also
doesn't make sense because __x86_retpoline_rax isn't in fact STT_FUNC,
so WTH ?!
