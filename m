Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47B42BBCA0
	for <lists+linux-arch@lfdr.de>; Sat, 21 Nov 2020 04:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgKUDON (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 22:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgKUDOM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 22:14:12 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4CCC0613CF;
        Fri, 20 Nov 2020 19:14:12 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id e10so1289579qte.4;
        Fri, 20 Nov 2020 19:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MnceUBKO5CKDULZmr15ARJRXunPRBIoWz0MuHJiULrg=;
        b=gsNR/CpmvNQ3U+ijqCwO8esji7bm1QnpPb+gjcQIHmOVilGJtCH7wljw5OuoR2+ByD
         Eu3ArHbg0KOX4QqUwemDaTkU/zaCmVz9NXecmCRSJQykGNIqev281MSCPFW6iyFfCalh
         OXU5NgKpKUUxeSGcDHdTDiB+8xUj7RQbdjIsa52m2B9JAVMTC4wE43lynK1gJnIiNcfD
         9l3VbICmSeaGwxXVG1ypIdI92hsCdUXBe06U+zSDwzqwaBADLFUpJVMg61p6t8YeCIac
         RAunoKa4yJRKwIKPoTystOV6bK3iAFZIuzfr8A4Wxoe8TDYQp/m8PUNb++rax2JElIaq
         lP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MnceUBKO5CKDULZmr15ARJRXunPRBIoWz0MuHJiULrg=;
        b=EgbDUOfMxzfU4Cj+0mbak3nJaclCFNOiwP1R5ABmxMSKucFyaViGAZsqXmZj5pgiJL
         R0l0ePWME+9XeTbwBclsEevSzCB3FuN8okiwSI5xt/htcgjjEfzOFKn7lhXK9ZOjOmde
         qCPy4+lwCSzfJvK+/rOHIy9t7Ic5QQCd2Do29dH9co8QEYAK9N1WbusYoj1R6JizEM6t
         P1+XRpLwhSftomTz5OioeRzqDSwyEXXY+rlg/micHbnciLX3L69l1chOP28von0uyKAy
         ncwp1gwjghzYth7T0IOq+af9GG3Y/UIFZey65Oun6wL2AiRNksR+LT/9TJWKRRdrA4YE
         /cfw==
X-Gm-Message-State: AOAM532N2ds0qWRc/xPpf9pcEIxG35BVEqWzsmLBLROllNi7gE25wdm6
        RvnbzrdEwpHO55J7RdNIbOU=
X-Google-Smtp-Source: ABdhPJwFM1Zex8JyH4dWcYr9Ean4nPf9JBfv8fPcfexg+IsjIR+dtwfqcokR9OMKLw5/d/3ypGQmrg==
X-Received: by 2002:a05:622a:1cd:: with SMTP id t13mr19064421qtw.39.1605928451613;
        Fri, 20 Nov 2020 19:14:11 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id o9sm3406683qte.35.2020.11.20.19.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 19:14:10 -0800 (PST)
Date:   Fri, 20 Nov 2020 20:14:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
Message-ID: <20201121031409.GA2282710@ubuntu-m3-large-x86>
References: <20201118220731.925424-1-samitolvanen@google.com>
 <CAKwvOd=5PhCTZ-yHr08gPYNEsGEjZa=rDY0-unhkhofjXhqwLQ@mail.gmail.com>
 <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 20, 2020 at 11:29:51AM +0100, Ard Biesheuvel wrote:
> On Thu, 19 Nov 2020 at 00:42, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Wed, Nov 18, 2020 at 2:07 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > This patch series adds support for building the kernel with Clang's
> > > Link Time Optimization (LTO). In addition to performance, the primary
> > > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> > > be used in the kernel. Google has shipped millions of Pixel devices
> > > running three major kernel versions with LTO+CFI since 2018.
> > >
> > > Most of the patches are build system changes for handling LLVM bitcode,
> > > which Clang produces with LTO instead of ELF object files, postponing
> > > ELF processing until a later stage, and ensuring initcall ordering.
> > >
> > > Note that v7 brings back arm64 support as Will has now staged the
> > > prerequisite memory ordering patches [1], and drops x86_64 while we work
> > > on fixing the remaining objtool warnings [2].
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
> > > [2] https://lore.kernel.org/lkml/20201114004911.aip52eimk6c2uxd4@treble/
> > >
> > > You can also pull this series from
> > >
> > >   https://github.com/samitolvanen/linux.git lto-v7
> >
> > Thanks for continuing to drive this series Sami.  For the series,
> >
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I did virtualized boot tests with the series applied to aarch64
> > defconfig without CONFIG_LTO, with CONFIG_LTO_CLANG, and a third time
> > with CONFIG_THINLTO.  If you make changes to the series in follow ups,
> > please drop my tested by tag from the modified patches and I'll help
> > re-test.  Some minor feedback on the Kconfig change, but I'll post it
> > off of that patch.
> >
> 
> When you say 'virtualized" do you mean QEMU on x86? Or actual
> virtualization on an AArch64 KVM host?
> 
> The distinction is important here, given the potential impact of LTO
> on things that QEMU simply does not model when it runs in TCG mode on
> a foreign host architecture.

I have booted this series on my Raspberry Pi 4 (ARCH=arm64 defconfig).

$ uname -r
5.10.0-rc4-00108-g830200082c74

$ zgrep LTO /proc/config.gz
CONFIG_LTO=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_THINLTO=y
CONFIG_THINLTO=y
# CONFIG_LTO_NONE is not set
CONFIG_LTO_CLANG=y
# CONFIG_HID_WALTOP is not set

and I have taken that same kernel and booted it under QEMU with
'-enable-kvm' without any visible issues.

I have tested four combinations:

clang 12 @ f9f0a4046e11c2b4c130640f343e3b2b5db08c1:
    * CONFIG_THINLTO=y
    * CONFIG_THINLTO=n

clang 11.0.0
    * CONFIG_THINLTO=y
    * CONFIG_THINLTO=n

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Cheers,
Nathan
