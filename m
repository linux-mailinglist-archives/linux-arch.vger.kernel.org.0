Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262392D2A8A
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 13:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgLHMQa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 07:16:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbgLHMQa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 07:16:30 -0500
X-Gm-Message-State: AOAM531pCNf3+pt4/gxI7ev0HTiugt+kVRX+mWEA0Xc3ccWL5NzuNlxw
        Q5DMJzmliyrBsBbl/PytXnxnVlcQgL24/EPkz3M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607429749;
        bh=K94MQ6q50UGiEvhj+VB0lG6N0jZujxUWTttppsr8gwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ns4p/v7H7ScAMGSZF+uiL0GLrzuK92X4fsakgAnSLuAme/K5fEsEi38bY3jw803Wy
         audkXq/WYB7RTMZ3yOuTK6onrxqVBtnoYqkkvLnvpNRPrQxrYcO6XAo70lbZp3Wa4T
         9qu4teHx4OR4D7tI19aZUR6LPG7nQ4wU5rtl2vcxyqBk81XPqwKBpVKsGaiwHXIJuy
         PuNNq9XDDyWTO1GKhaqTq1XoK2qrf9wdaOmxVotAI6FaDwC0nVzQIN5BYHWvkh+7Pl
         TIDC46XqhgPtl/QkCcf02gs7jdiOHkHzlufEr692R+gOJKVmFAwvvzdy3POnIF8teL
         9TV0RUdUG0tPw==
X-Google-Smtp-Source: ABdhPJwYXzEbw5wojirREdrWvTDFdS68u6lSRc1TxQHV80oZ08BdPpLLWGJpTl+WAoAqOweiNLoKVC/CXI7Rr5nYmRU=
X-Received: by 2002:a05:6808:9a9:: with SMTP id e9mr2451121oig.4.1607429748222;
 Tue, 08 Dec 2020 04:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 8 Dec 2020 13:15:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
Message-ID: <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
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

On Tue, Dec 1, 2020 at 10:37 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> This patch series adds support for building the kernel with Clang's
> Link Time Optimization (LTO). In addition to performance, the primary
> motivation for LTO is to allow Clang's Control-Flow Integrity (CFI)
> to be used in the kernel. Google has shipped millions of Pixel
> devices running three major kernel versions with LTO+CFI since 2018.
>
> Most of the patches are build system changes for handling LLVM
> bitcode, which Clang produces with LTO instead of ELF object files,
> postponing ELF processing until a later stage, and ensuring initcall
> ordering.
>
> Note that arm64 support depends on Will's memory ordering patches
> [1]. I will post x86_64 patches separately after we have fixed the
> remaining objtool warnings [2][3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
> [2] https://lore.kernel.org/lkml/20201120040424.a3wctajzft4ufoiw@treble/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-vmlinux
>
> You can also pull this series from
>
>   https://github.com/samitolvanen/linux.git lto-v8

I've tried pull this into my randconfig test tree to give it a spin.
So far I have
not managed to get a working build out of it, the main problem so far being
that it is really slow to build because the link stage only uses one CPU.
These are the other issues I've seen so far:

- one build seems to take even longer to link. It's currently at 35GB RAM
  usage and 40 minutes into the final link, but I'm worried it might
not complete
  before it runs out of memory.  I only have 128GB installed, and google-chrome
  uses another 30GB of that, and I'm also doing some other builds in parallel.
  Is there a minimum recommended amount of memory for doing LTO builds?

- One build failed with
 ld.lld -EL -maarch64elf -mllvm -import-instr-limit=5 -r -o vmlinux.o
-T .tmp_initcalls.lds --whole-archive arch/arm64/kernel/head.o
init/built-in.a usr/built-in.a arch/arm64/built-in.a kernel/built-in.a
certs/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a
security/built-in.a crypto/built-in.a block/built-in.a
arch/arm64/lib/built-in.a lib/built-in.a drivers/built-in.a
sound/built-in.a net/built-in.a virt/built-in.a --no-whole-archive
--start-group arch/arm64/lib/lib.a lib/lib.a
./drivers/firmware/efi/libstub/lib.a --end-group
  "ld.lld: error: arch/arm64/kernel/head.o: invalid symbol index"
  after about 30 minutes

- CONFIG_CPU_BIG_ENDIAN doesn't seem to work with lld, and LTO
  doesn't work with ld.bfd.
  I've added a CPU_LITTLE_ENDIAN dependency to
  ARCH_SUPPORTS_LTO_CLANG{,THIN}

- one build failed with
  "ld.lld: error: Never resolved function from blockaddress (Producer:
'LLVM12.0.0' Reader: 'LLVM 12.0.0')"
  Not sure how to debug this

- one build seems to have dropped all symbols the string operations
from vmlinux,
  so while the link goes through, modules cannot be loaded:
 ERROR: modpost: "memmove" [drivers/media/rc/rc-core.ko] undefined!
 ERROR: modpost: "memcpy" [net/wireless/cfg80211.ko] undefined!
 ERROR: modpost: "memcpy" [net/8021q/8021q.ko] undefined!
 ERROR: modpost: "memset" [net/8021q/8021q.ko] undefined!
 ERROR: modpost: "memcpy" [net/unix/unix.ko] undefined!
 ERROR: modpost: "memset" [net/sched/cls_u32.ko] undefined!
 ERROR: modpost: "memcpy" [net/sched/cls_u32.ko] undefined!
 ERROR: modpost: "memset" [net/sched/sch_skbprio.ko] undefined!
 ERROR: modpost: "memcpy" [net/802/garp.ko] undefined!
 I first thought this was related to a clang-12 bug I saw the other day, but
 this also happens with clang-11

- many builds complain about thousands of duplicate symbols in the kernel, e.g.
  ld.lld: error: duplicate symbol: qrtr_endpoint_post
 >>> defined in net/qrtr/qrtr.lto.o
 >>> defined in net/qrtr/qrtr.o
 ld.lld: error: duplicate symbol: init_module
 >>> defined in crypto/842.lto.o
 >>> defined in crypto/842.o
 ld.lld: error: duplicate symbol: init_module
 >>> defined in net/netfilter/nfnetlink_log.lto.o
 >>> defined in net/netfilter/nfnetlink_log.o
 ld.lld: error: duplicate symbol: vli_from_be64
 >>> defined in crypto/ecc.lto.o
 >>> defined in crypto/ecc.o
 ld.lld: error: duplicate symbol: __mod_of__plldig_clk_id_device_table
 >>> defined in drivers/clk/clk-plldig.lto.o
 >>> defined in drivers/clk/clk-plldig.o

Not sure if these are all known issues. If there is one you'd like me try
take a closer look at for finding which config options break it, I can try

     Arnd
