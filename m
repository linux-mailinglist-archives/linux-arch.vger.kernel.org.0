Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C13D2D3012
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 17:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgLHQoF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 11:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgLHQoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2020 11:44:04 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7780C061794
        for <linux-arch@vger.kernel.org>; Tue,  8 Dec 2020 08:43:18 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id w66so2200182vka.3
        for <linux-arch@vger.kernel.org>; Tue, 08 Dec 2020 08:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/l23vYzjhD/UMOBSQH+RJul+Bc4oeAA+Y4sxIdjxioI=;
        b=RAfcD6E7qB/m1g1h+JuwuaF/uflP8i26lZi2phJ6ivM8bTCfjLivQI5OCQ8w6QpWtz
         GhVbzW0KThpwLDlWvoq6XvuUahnRfW3XWYFEP3/KfbbcE6Mt0xbOSz4rsOQD6EhU4ccb
         VgjGN1rWqxhd0C0yDGCAAFPp62C56jQyUmdWbq0BO+l5ksMgtWC/hcVK5I++oQFHI7TD
         XTg5FqhImVrlmWEKuWWtjpLEzGXazHJq+Y3ZsMs6xviYy+OURLB+T+cRV4zeKAJEWHxV
         mb8QfrCr9XZREmLpj3q8g1+b/aiqk3TuelL46dokcNrd8oTPrJGo9iUQrKDPY1BNYMDM
         rA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/l23vYzjhD/UMOBSQH+RJul+Bc4oeAA+Y4sxIdjxioI=;
        b=m/YhlE+4y7MmAeix7PR5ycq0hlF1oH0sFZVCIA2Kz4pn4oAluYgQAhZaIvCaf2wycu
         4++tzER3/w4uq84frU0cTtZTICHKwJeo11A61kyy9Ht7Hgs+hg+7uh9fnU7e/uAmV7Ob
         BjILBvEohuNH2UL9heQj+DSD7MLhktvQ2/cA7XukU6zrIKsqJnCP01ZPuaFnMozcAFil
         R2VBgJWGv+HHGALapSeMK/5xlRZ4DADscAdALO/fR4+OdIAolMQ/dpecr2V8MrikIjgI
         UtuLIcY1BN0rlwAHrudCn1k0oIJlwAB2Cl0NXJVy7Baqsbnb61mbKTd3Tv7sV0KWh118
         E7fw==
X-Gm-Message-State: AOAM530yZJc3MlFSpn0FFtezbORZU4oOoguFyhXm8aVtcOuGLY7RlYtA
        qmBW4bmHX832jwGv/4vBtXmCjHIHn+bcQ6fmzu/BoQ==
X-Google-Smtp-Source: ABdhPJzj58Nc2qNmGYOW78LxSHKIESqV6GNFn6VDhGIrOTLcDC2d6Ia7wDNo0+77MjZ0A6JkVLbP9FXkxnngbqbRKfM=
X-Received: by 2002:a1f:304a:: with SMTP id w71mr17359481vkw.3.1607445797616;
 Tue, 08 Dec 2020 08:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com> <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
In-Reply-To: <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 8 Dec 2020 08:43:06 -0800
Message-ID: <CABCJKueCHo2RYfx_A21m+=d1gQLR9QsOOxCsHFeicCqyHkb-Kg@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 8, 2020 at 4:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Dec 1, 2020 at 10:37 PM 'Sami Tolvanen' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > This patch series adds support for building the kernel with Clang's
> > Link Time Optimization (LTO). In addition to performance, the primary
> > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI)
> > to be used in the kernel. Google has shipped millions of Pixel
> > devices running three major kernel versions with LTO+CFI since 2018.
> >
> > Most of the patches are build system changes for handling LLVM
> > bitcode, which Clang produces with LTO instead of ELF object files,
> > postponing ELF processing until a later stage, and ensuring initcall
> > ordering.
> >
> > Note that arm64 support depends on Will's memory ordering patches
> > [1]. I will post x86_64 patches separately after we have fixed the
> > remaining objtool warnings [2][3].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
> > [2] https://lore.kernel.org/lkml/20201120040424.a3wctajzft4ufoiw@treble/
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-vmlinux
> >
> > You can also pull this series from
> >
> >   https://github.com/samitolvanen/linux.git lto-v8
>
> I've tried pull this into my randconfig test tree to give it a spin.

Great, thank you for testing this!

> So far I have
> not managed to get a working build out of it, the main problem so far being
> that it is really slow to build because the link stage only uses one CPU.
> These are the other issues I've seen so far:

You may want to limit your testing only to ThinLTO at first, because
full LTO is going to be extremely slow with larger configs, especially
when building arm64 kernels.

> - one build seems to take even longer to link. It's currently at 35GB RAM
>   usage and 40 minutes into the final link, but I'm worried it might
> not complete
>   before it runs out of memory.  I only have 128GB installed, and google-chrome
>   uses another 30GB of that, and I'm also doing some other builds in parallel.
>   Is there a minimum recommended amount of memory for doing LTO builds?

When building arm64 defconfig, the maximum memory usage I measured
with ThinLTO was 3.5 GB, and with full LTO 20.3 GB. I haven't measured
larger configurations, but I believe LLD can easily consume 3-4x that
much with full LTO allyesconfig.

> - One build failed with
>  ld.lld -EL -maarch64elf -mllvm -import-instr-limit=5 -r -o vmlinux.o
> -T .tmp_initcalls.lds --whole-archive arch/arm64/kernel/head.o
> init/built-in.a usr/built-in.a arch/arm64/built-in.a kernel/built-in.a
> certs/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a
> security/built-in.a crypto/built-in.a block/built-in.a
> arch/arm64/lib/built-in.a lib/built-in.a drivers/built-in.a
> sound/built-in.a net/built-in.a virt/built-in.a --no-whole-archive
> --start-group arch/arm64/lib/lib.a lib/lib.a
> ./drivers/firmware/efi/libstub/lib.a --end-group
>   "ld.lld: error: arch/arm64/kernel/head.o: invalid symbol index"
>   after about 30 minutes

That's interesting. Did you use LLVM_IAS=1?

> - CONFIG_CPU_BIG_ENDIAN doesn't seem to work with lld, and LTO
>   doesn't work with ld.bfd.
>   I've added a CPU_LITTLE_ENDIAN dependency to
>   ARCH_SUPPORTS_LTO_CLANG{,THIN}

Ah, good point. I'll fix this in v9.

[...]
> Not sure if these are all known issues. If there is one you'd like me try
> take a closer look at for finding which config options break it, I can try

No, none of these are known issues. I would be happy to take a closer
look if you can share configs that reproduce these.

Sami
