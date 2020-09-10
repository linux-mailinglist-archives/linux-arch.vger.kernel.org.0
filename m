Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F0264F76
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgIJToP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 15:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbgIJPdi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 11:33:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5443AC061364
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 08:17:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m15so1072653pls.8
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tPQ89cuIIRpR65Gxj5ecjevE7KdkPR+rkFKg2EWJ1Wo=;
        b=DChiCwzeZGIWq9/ed/gKC6HSdKRqhEs7Cl7tIqKCGERK9KOYJoH5HR7PeRQFbOp0ZQ
         khZeS1vnyB3+LRhvPvqPzg1++dxbQ65OlIG3+zElXCaofAPycZykfEboSqoECnwgYkc8
         MjBJnNXFCtUW2Ff6DrHl+sxDflI9XbnpK+uT5XCk1aFiT5HbdZScO79bQK/bPprVs9ke
         AKI0Gc5Gmjyb5KEUqFWbhTCjq+hID3NQ5SFYjD5nGdby6rdJDucAdfiBRYrvqN5RUvSp
         a/e3IDc7KLOgC5+PLCtG+ltNKm9AU2kQQzP0O8rhwbvaICVCr6rc7DiwJMJDGG5odV8E
         t8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tPQ89cuIIRpR65Gxj5ecjevE7KdkPR+rkFKg2EWJ1Wo=;
        b=DHRI5cOiwUUZVw+TH2cuF5j8XgqHTi5orwWIVMpUSyHBw96AZIHhPX6dY9lHH2P7Bc
         a5UWX8JBiDhu6JZ8jPK3tRbrSHajB3NhKq0s5RTneRpvYVkbH0oBRQ2TaibJrE5t7Hqa
         Rfi3euEcTUNwKSyBKaNNfWBpOIKvEjQ0CrtFjFMcOB7JfNUSMGpON7rM+0sk3KPvfXNm
         FamsnljlQlR8UdlmFIkS7h/dVy+olUZXPXqNw0qcCuh/xrU+hhQd/EVFjICtPSnwXTux
         Bwt4bEQ8dt08r28pSjHJVbwrnJ0WDv9ymg5RG4OgK1mNHCmKHp1QwlaMNYHM2ZhCqvOp
         vpwg==
X-Gm-Message-State: AOAM5333k1O2La2wCC+g43u2sB5hKubFsUwTIOpBIWqMG3LX+SGm3uMn
        gZdWccCNSP4fd8DKPFVbfhfT8A==
X-Google-Smtp-Source: ABdhPJzN/GMDnhYVZz/m1t04YSzXdezukOM0X0fLu2KC5nqmbsead/T/1/lyPGlr1z5YJ1TUoUk/HA==
X-Received: by 2002:a17:90b:1915:: with SMTP id mp21mr407790pjb.116.1599751042106;
        Thu, 10 Sep 2020 08:17:22 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id z23sm5241512pgv.57.2020.09.10.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:17:20 -0700 (PDT)
Date:   Thu, 10 Sep 2020 08:17:15 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2 00/28] Add support for Clang LTO
Message-ID: <20200910151715.GB2041735@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <CAK7LNASDUkyJMDD0a5K_HT=1q5NEc6dcN4=FUb330yK0BCKcTw@mail.gmail.com>
 <20200908234643.GF1060586@google.com>
 <CAK7LNAR9zzP0ZU3b__PZv8gRtKrwz6-8GE1zG5UyFx1wDpOBzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR9zzP0ZU3b__PZv8gRtKrwz6-8GE1zG5UyFx1wDpOBzQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 10, 2020 at 10:18:05AM +0900, Masahiro Yamada wrote:
> On Wed, Sep 9, 2020 at 8:46 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Sun, Sep 06, 2020 at 09:24:38AM +0900, Masahiro Yamada wrote:
> > > On Fri, Sep 4, 2020 at 5:30 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > > >
> > > > This patch series adds support for building x86_64 and arm64 kernels
> > > > with Clang's Link Time Optimization (LTO).
> > > >
> > > > In addition to performance, the primary motivation for LTO is
> > > > to allow Clang's Control-Flow Integrity (CFI) to be used in the
> > > > kernel. Google has shipped millions of Pixel devices running three
> > > > major kernel versions with LTO+CFI since 2018.
> > > >
> > > > Most of the patches are build system changes for handling LLVM
> > > > bitcode, which Clang produces with LTO instead of ELF object files,
> > > > postponing ELF processing until a later stage, and ensuring initcall
> > > > ordering.
> > > >
> > > > Note that patches 1-4 are not directly related to LTO, but are
> > > > needed to compile LTO kernels with ToT Clang, so I'm including them
> > > > in the series for your convenience:
> > > >
> > > >  - Patches 1-3 are required for building the kernel with ToT Clang,
> > > >    and IAS, and patch 4 is needed to build allmodconfig with LTO.
> > > >
> > > >  - Patches 3-4 are already in linux-next, but not yet in 5.9-rc.
> > > >
> > >
> > >
> > > I still do not understand how this patch set works.
> > > (only me?)
> > >
> > > Please let me ask fundamental questions.
> > >
> > >
> > >
> > > I applied this series on top of Linus' tree,
> > > and compiled for ARCH=arm64.
> > >
> > > I compared the kernel size with/without LTO.
> > >
> > >
> > >
> > > [1] No LTO  (arm64 defconfig, CONFIG_LTO_NONE)
> > >
> > > $ llvm-size   vmlinux
> > >    text    data     bss     dec     hex filename
> > > 15848692 10099449 493060 26441201 19375f1 vmlinux
> > >
> > >
> > >
> > > [2] Clang LTO  (arm64 defconfig + CONFIG_LTO_CLANG)
> > >
> > > $ llvm-size   vmlinux
> > >    text    data     bss     dec     hex filename
> > > 15906864 10197445 490804 26595113 195cf29 vmlinux
> > >
> > >
> > > I compared the size of raw binary, arch/arm64/boot/Image.
> > > Its size increased too.
> > >
> > >
> > >
> > > So, in my experiment, enabling CONFIG_LTO_CLANG
> > > increases the kernel size.
> > > Is this correct?
> >
> > Yes. LTO does produce larger binaries, mostly due to function
> > inlining between translation units, I believe. The compiler people
> > can probably give you a more detailed answer here. Without -mllvm
> > -import-instr-limit, the binaries would be even larger.
> >
> > > One more thing, could you teach me
> > > how Clang LTO optimizes the code against
> > > relocatable objects?
> > >
> > >
> > >
> > > When I learned Clang LTO first, I read this document:
> > > https://llvm.org/docs/LinkTimeOptimization.html
> > >
> > > It is easy to confirm the final executable
> > > does not contain foo2, foo3...
> > >
> > >
> > >
> > > In contrast to userspace programs,
> > > kernel modules are basically relocatable objects.
> > >
> > > Does Clang drop unused symbols from relocatable objects?
> > > If so, how?
> >
> > I don't think the compiler can legally drop global symbols from
> > relocatable objects, but it can rename and possibly even drop static
> > functions.
> 
> 
> Compilers can drop static functions without LTO.
> Rather, it is a compiler warning
> (-Wunused-function), so the code should be cleaned up.
> 
> 
> 
> > This is why we need global wrappers for initcalls, for
> > example, to have stable symbol names.
> >
> > Sami
> 
> 
> 
> At first, I thought the motivation of LTO
> was to remove unused global symbols, and
> to perform further optimization.
> 
> 
> It is true for userspace programs.
> In fact, the example of
> https://llvm.org/docs/LinkTimeOptimization.html
> produces a smaller binary.
> 
> 
> In contrast, this patch set produces a bigger kernel
> because LTO cannot remove any unused symbol.
> 
> So, I do not understand what the benefit is.
> 
> 
> Is inlining beneficial?
> I am not sure.
> 
> 
> Documentation/process/coding-style.rst
> "15) The inline disease"
> mentions that inlining is not always
> a good thing.
> 
> 
> As a whole, I still do not understand
> the motivation of this patch set.

Clang produces faster code with LTO even if unused functions are not
removed, and I'm not sure how many unused globals there really are in
the kernel that aren't exported for modules. However, as I mentioned in
the cover letter, we also need LTO for Control-Flow Integrity (CFI),
which we have used in Pixel kernels for a couple of years now, and plan
to use in more Android devices in future:

  https://clang.llvm.org/docs/ControlFlowIntegrity.html

Sami
