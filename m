Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD42D39FE
	for <lists+linux-arch@lfdr.de>; Wed,  9 Dec 2020 05:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLIE4m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 23:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgLIE4j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2020 23:56:39 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F1C061794
        for <linux-arch@vger.kernel.org>; Tue,  8 Dec 2020 20:55:59 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q22so209282pfk.12
        for <linux-arch@vger.kernel.org>; Tue, 08 Dec 2020 20:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yNxPOOK8GUbsNe5moby382MnhA6+vA6WAhboDqo7Axs=;
        b=gVlT6d0N/3N0A44YyPBRrdAxvqWSB7tInBfZYe89aKi6EzHIs7gP38E5CuWbaquJ9Q
         lC1TB2BxZUYHFRIwXjsuezaszTqBj7bKmpzzgY40z0e7LLAFdthLmtnn3YPf/IEXMkLc
         uuaBS0tglR6qOsch4B7MSYVIDFITtcPTJxHeU5A6u96w8NBHLL2cRAa1oSHG0o+gDjES
         LRBnSQST8QVgjW7urPuaJ13hoWEbi3iuyJLUcTkEcPCwBaydpA8W9h+RHDRqv/3BC5QO
         aT3Tn0QBJmvAL3K/fKFdgT/IIZVcAKEdJKnXkXMb7a2aG8QVPIhjtldRqQ/aGIBinoxs
         9hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yNxPOOK8GUbsNe5moby382MnhA6+vA6WAhboDqo7Axs=;
        b=HsW5zrQoXde3q/zgsY4FfWwoc5X6qLCrR8jZAk6JXCrPknwCeySvT78vdH8ox7xeEr
         fLkBlvYIwDv2/qYWWGat/KdBP/72JjkjXlRObdyChZNTqGLddAJj5OuoK8BePXPb75qK
         g1bZBs1ZArUNhFblms5FgUkt5aBsz5HpDc9NKuc/XeZ2FufwC+50InH0vyR6yyp6Rawf
         dDSd1xuHNXDgpevo/lkghp08f67dZXs/BJ9riCCrR6TbOgrYeCVBDQVx6JacEH9zMrxu
         YkdoIT+fNj6okm3AV1Qkmzki4J1thh+2/+Eb52CkvsJQ/2IdQGG0RVnS9I6PvdWlZwEb
         usfg==
X-Gm-Message-State: AOAM5318QTWLqS/1VzJt9U2v/vYm0e/Eh1KipAK88ksNtq0sneSDSgHh
        sZOETv3/TG7J02vVPgcxgfPLBg==
X-Google-Smtp-Source: ABdhPJyVhevtlV182GztPlTk2U6DWLN8px/r+M03xp8sndkyhgLZY0CoPxIqSa+brsrwqARmVo17sA==
X-Received: by 2002:a63:494f:: with SMTP id y15mr405121pgk.364.1607489758368;
        Tue, 08 Dec 2020 20:55:58 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id s17sm508448pge.37.2020.12.08.20.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 20:55:57 -0800 (PST)
Date:   Tue, 8 Dec 2020 20:55:54 -0800
From:   Fangrui Song <maskray@google.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
Message-ID: <20201209045554.fxlzrmxknakl2gdr@google.com>
References: <20201201213707.541432-1-samitolvanen@google.com>
 <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
 <CABCJKueCHo2RYfx_A21m+=d1gQLR9QsOOxCsHFeicCqyHkb-Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABCJKueCHo2RYfx_A21m+=d1gQLR9QsOOxCsHFeicCqyHkb-Kg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2020-12-08, 'Sami Tolvanen' via Clang Built Linux wrote:
>On Tue, Dec 8, 2020 at 4:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> On Tue, Dec 1, 2020 at 10:37 PM 'Sami Tolvanen' via Clang Built Linux
>> <clang-built-linux@googlegroups.com> wrote:
>> >
>> > This patch series adds support for building the kernel with Clang's
>> > Link Time Optimization (LTO). In addition to performance, the primary
>> > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI)
>> > to be used in the kernel. Google has shipped millions of Pixel
>> > devices running three major kernel versions with LTO+CFI since 2018.
>> >
>> > Most of the patches are build system changes for handling LLVM
>> > bitcode, which Clang produces with LTO instead of ELF object files,
>> > postponing ELF processing until a later stage, and ensuring initcall
>> > ordering.
>> >
>> > Note that arm64 support depends on Will's memory ordering patches
>> > [1]. I will post x86_64 patches separately after we have fixed the
>> > remaining objtool warnings [2][3].
>> >
>> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
>> > [2] https://lore.kernel.org/lkml/20201120040424.a3wctajzft4ufoiw@treble/
>> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-vmlinux
>> >
>> > You can also pull this series from
>> >
>> >   https://github.com/samitolvanen/linux.git lto-v8
>>
>> I've tried pull this into my randconfig test tree to give it a spin.
>
>Great, thank you for testing this!
>
>> So far I have
>> not managed to get a working build out of it, the main problem so far being
>> that it is really slow to build because the link stage only uses one CPU.
>> These are the other issues I've seen so far:

ld.lld ThinLTO uses the number of (physical cores enabled by affinity) by default.

>You may want to limit your testing only to ThinLTO at first, because
>full LTO is going to be extremely slow with larger configs, especially
>when building arm64 kernels.
>
>> - one build seems to take even longer to link. It's currently at 35GB RAM
>>   usage and 40 minutes into the final link, but I'm worried it might
>> not complete
>>   before it runs out of memory.  I only have 128GB installed, and google-chrome
>>   uses another 30GB of that, and I'm also doing some other builds in parallel.
>>   Is there a minimum recommended amount of memory for doing LTO builds?
>
>When building arm64 defconfig, the maximum memory usage I measured
>with ThinLTO was 3.5 GB, and with full LTO 20.3 GB. I haven't measured
>larger configurations, but I believe LLD can easily consume 3-4x that
>much with full LTO allyesconfig.
>
>> - One build failed with
>>  ld.lld -EL -maarch64elf -mllvm -import-instr-limit=5 -r -o vmlinux.o
>> -T .tmp_initcalls.lds --whole-archive arch/arm64/kernel/head.o
>> init/built-in.a usr/built-in.a arch/arm64/built-in.a kernel/built-in.a
>> certs/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a
>> security/built-in.a crypto/built-in.a block/built-in.a
>> arch/arm64/lib/built-in.a lib/built-in.a drivers/built-in.a
>> sound/built-in.a net/built-in.a virt/built-in.a --no-whole-archive
>> --start-group arch/arm64/lib/lib.a lib/lib.a
>> ./drivers/firmware/efi/libstub/lib.a --end-group
>>   "ld.lld: error: arch/arm64/kernel/head.o: invalid symbol index"
>>   after about 30 minutes
>
>That's interesting. Did you use LLVM_IAS=1?

May be worth checking which relocation or (SHT_GROUP section's sh_info) in arch/arm64/kernel/head.o is incorrect.

>> - CONFIG_CPU_BIG_ENDIAN doesn't seem to work with lld, and LTO
>>   doesn't work with ld.bfd.
>>   I've added a CPU_LITTLE_ENDIAN dependency to
>>   ARCH_SUPPORTS_LTO_CLANG{,THIN}
>
>Ah, good point. I'll fix this in v9.

Full/Thin LTO should work with GNU ld and gold with LLVMgold.so built from
llvm-project (https://llvm.org/docs/GoldPlugin.html ). You'll need to make sure
that LLVMgold.so is newer than clang. (Newer clang may introduce bitcode
attributes which are unrecognizable by older LLVMgold.so/ld.lld)

>[...]
>> Not sure if these are all known issues. If there is one you'd like me try
>> take a closer look at for finding which config options break it, I can try
>
>No, none of these are known issues. I would be happy to take a closer
>look if you can share configs that reproduce these.
>
>Sami
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CABCJKueCHo2RYfx_A21m%2B%3Dd1gQLR9QsOOxCsHFeicCqyHkb-Kg%40mail.gmail.com.
