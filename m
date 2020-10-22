Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9529590B
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508494AbgJVH0W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 03:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508492AbgJVH0W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Oct 2020 03:26:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C3C0613CE;
        Thu, 22 Oct 2020 00:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h+rKHFkcR5k6QSt8CeK8lSdFFr+MaETwBr6Mxg4PDmU=; b=aUN68SfzWTPeVbTNit8fy/ZXb0
        rRAYaTV5InvSpscM+g5V5UNuxxMIOSNNjdTrr9zBJwTDnIr7HB4kAtF5eelSvpZSzfzi0XB65k49y
        fMhVyhLkrBDvMABUemD6zpOEa+Q8IzTJx4IZksVwvVIaYHLDJx476sb1mRX2HLMmaKAybchSbXO5G
        h2Y+yNlzpY2780AC98N7ePm2EJ79MCEo33CoAfryNdBPReXIr4iTyNLwA3Ag8rPF1QkdzEXKCnmAv
        01B8rB6S0TBGhXUXekjoFY4MHksCyJY7O4ahmGFdB9hvjhmJ+hNdIUNrUYqknMjnfiTaSOjgjEbDG
        qxHU9c4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVUyy-0002dT-Ax; Thu, 22 Oct 2020 07:25:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E3203010D2;
        Thu, 22 Oct 2020 09:25:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DE3B21463180; Thu, 22 Oct 2020 09:25:53 +0200 (CEST)
Date:   Thu, 22 Oct 2020 09:25:53 +0200
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
Message-ID: <20201022072553.GN2628@hirez.programming.kicks-ass.net>
References: <20201013003203.4168817-23-samitolvanen@google.com>
 <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
 <20201021093213.GV2651@hirez.programming.kicks-ass.net>
 <20201021212747.ofk74lugt4hhjdzg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021212747.ofk74lugt4hhjdzg@treble>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 04:27:47PM -0500, Josh Poimboeuf wrote:
> On Wed, Oct 21, 2020 at 11:32:13AM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 21, 2020 at 10:56:06AM +0200, Peter Zijlstra wrote:
> > 
> > > I do not see these in particular, although I do see a lot of:
> > > 
> > >   "sibling call from callable instruction with modified stack frame"
> > 
> > defconfig-build/vmlinux.o: warning: objtool: msr_write()+0x10a: sibling call from callable instruction with modified stack frame
> > defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x99: (branch)
> > defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x3e: (branch)
> > defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x0: <=== (sym)
> > 
> > $ nm defconfig-build/vmlinux.o | grep msr_write
> > 0000000000043250 t msr_write
> > 00000000004289c0 T msr_write
> > 0000000000003056 t msr_write.cold
> > 
> > Below 'fixes' it. So this is also caused by duplicate symbols.
> 
> There's a new linker flag for renaming duplicates:
> 
>   https://sourceware.org/bugzilla/show_bug.cgi?id=26391
> 
> But I guess that doesn't help us now.

Well, depends a bit if clang can do it; we only need this for LTO builds
for now.

> I don't have access to GCC 10 at the moment so I can't recreate it.
> Does this fix it?

Doesn't seem to do the trick :/ I'll try and have a poke later.
