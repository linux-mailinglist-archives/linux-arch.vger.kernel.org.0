Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09974297612
	for <lists+linux-arch@lfdr.de>; Fri, 23 Oct 2020 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbgJWRsc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Oct 2020 13:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbgJWRsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Oct 2020 13:48:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3DDC0613CE
        for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2020 10:48:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so1816021pgp.7
        for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2020 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHs6b4ooy0rgFnXBjoHTZU/MFzwidZAAr9PXWq9UsVk=;
        b=h9H11cgbsiLIfnCVNg9C63PczJj6klub3nyQOP7k17qHXCkM3+IiRWUf+K8onV/M6f
         cq6hpYWY5tijhMZOqe4vpxWnGOmq8cRM3qeYtsvRKEgPmJNNtDrmOS532+baO+0nsP5H
         4oTZzToITDWX/+cRTyYkk0o02ppC4ZW2srP3cde+HPF1A0gWOS7McnJYg5AziS2A8+k5
         FA/pfx2HXxsJo1PFtx/M/61rAc4BlJZES29IbLZRpqOuPDxsS+IoEvzMCqD9jME5DLTE
         nrFqzJCCPwXyQB8C7frIf3mqYooXH89m8/kypUCqoZ0QyzM52bhO/vCOCMQcptgtC5Xq
         D7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHs6b4ooy0rgFnXBjoHTZU/MFzwidZAAr9PXWq9UsVk=;
        b=tujroI0kuGO3dMHs7P9kfeeExUBJ9sZS9csEM5wNeBlHDVnbd6R4X98jxxuupeYrEv
         YwM5x+4uguNULpNv6gip3l3mskh1xLguKRPS78a0qbr1o0pICx4GBd4pm8ZckDxauV8k
         JI//Z2DC1RkYNcR3uXrfLcHfiDKxw8ELU8PxDRmanRwRek8YCDdyNxTpWEsJNWxe6mIo
         C7wUrblvbOBiP39My/oDPyXBxAMT0ktrBwB5bNZBBsQFETGT/exaolyiwiVOXcM0gAA7
         KqNasiIzghDlUVeUnKyf/GZvoK05a6tHgdS9Ul3nUyyCJbNVlKZ+PrOVaH4bsp5X5AeU
         YtqA==
X-Gm-Message-State: AOAM533aZkXD67IUWRbxla9Z9n8l/wOyeC9MT1KGE9z5cGxSymK3WfH3
        4ByTbf4QqARgTfkstoLPhduyzg==
X-Google-Smtp-Source: ABdhPJyvkbZhNi51MOK3wMCs4cSy44OvLHixOCI7o3MOo/m8861HBGG5Vdka871MDYa0ozQesghZuQ==
X-Received: by 2002:a17:90a:450d:: with SMTP id u13mr3848288pjg.148.1603475309279;
        Fri, 23 Oct 2020 10:48:29 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id w6sm2555511pgw.28.2020.10.23.10.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:48:28 -0700 (PDT)
Date:   Fri, 23 Oct 2020 10:48:22 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20201023174822.GA2696347@google.com>
References: <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
 <20201021093213.GV2651@hirez.programming.kicks-ass.net>
 <20201021212747.ofk74lugt4hhjdzg@treble>
 <20201022072553.GN2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022072553.GN2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 22, 2020 at 09:25:53AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 21, 2020 at 04:27:47PM -0500, Josh Poimboeuf wrote:
> > On Wed, Oct 21, 2020 at 11:32:13AM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 21, 2020 at 10:56:06AM +0200, Peter Zijlstra wrote:
> > > 
> > > > I do not see these in particular, although I do see a lot of:
> > > > 
> > > >   "sibling call from callable instruction with modified stack frame"
> > > 
> > > defconfig-build/vmlinux.o: warning: objtool: msr_write()+0x10a: sibling call from callable instruction with modified stack frame
> > > defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x99: (branch)
> > > defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x3e: (branch)
> > > defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x0: <=== (sym)
> > > 
> > > $ nm defconfig-build/vmlinux.o | grep msr_write
> > > 0000000000043250 t msr_write
> > > 00000000004289c0 T msr_write
> > > 0000000000003056 t msr_write.cold
> > > 
> > > Below 'fixes' it. So this is also caused by duplicate symbols.
> > 
> > There's a new linker flag for renaming duplicates:
> > 
> >   https://sourceware.org/bugzilla/show_bug.cgi?id=26391
> > 
> > But I guess that doesn't help us now.
> 
> Well, depends a bit if clang can do it; we only need this for LTO builds
> for now.

LLD doesn't seem to support -z unique-symbol.

Sami
