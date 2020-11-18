Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3899B2B8889
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 00:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgKRXmU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 18:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgKRXmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 18:42:19 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35651C061A48
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 15:42:18 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id i8so2625676pfk.10
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 15:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wc0yNJXcZws+WRwhlcA3oBkHhr2WzmzBrEHEaOZzgXc=;
        b=IclJMrJ5opPwCE1rcdJf4I1hVcoa1v9GarCIyOZzoGXdL8EK93b5DecDyW/5Li0ZuO
         pFHos7s4G2KiBuUV/rqU8ftvuuh/wH/Z3tMjjFAUGX/BVS4jjId6+0JGL3TmEpI80vHO
         BASC+2TbtDk7cT/XSOjzilJ55GHnsPdaDuUI73vTuM6zHKiXJ6VSCa6Ud9kSPotuedA7
         B+Lt2CGHGO7QTceBkb25zm0C3UbDab5TPqDbWPdQKztDIZCp90rzzlLQHUMkxifdzAj6
         EOE55PrNGpj79f5v2Gl50MCuAJSuKJ5153VqIsHVliX9P+Aa+Iqc/e4SxgcRDTQnn1v3
         GBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wc0yNJXcZws+WRwhlcA3oBkHhr2WzmzBrEHEaOZzgXc=;
        b=dDS6iOKLdYuzdyYIF/qNJ8Rel0eKVT/Lk5+c5bN1P1OJMzP0DJy+j6DPFEi1xtChZ4
         8wpj4RxZHWagvPlQeezGiY52iVjzor0SgeTCFVJpCfqx7g4Ccs9cyYTBy3/Q1SJbXe1G
         JShDF2NZbexIaRDN4BetvKnTfTPH7BZdxWpetvVEzEZOP1IQbstdySIK4D8XGZBx7yO2
         sP7/QlfnqPDNnxuutF05THtASqJ8vccrSwK/f1XkZp7WzJOUWK2afKXdg9oN7bmNcpn+
         muhpa4kfEhN6dobUdQoC64UwCr5ytPZPp0MO+L+GlwuCSXBzGwpZn77FapBwpFxFnHpl
         ql7Q==
X-Gm-Message-State: AOAM531Ul1aCL6To8aJAwOHQzCjSTA3NQCULFjr2JMGrKMJECwKjpCVc
        PjKc2dNLWkf2CMrDR1ldegLeMQPLtf5LbVg7iWczSw==
X-Google-Smtp-Source: ABdhPJxcOWPX+u5MiJTivd9DIhdri4QSEH+qEts8glczJpZeUd9rmQ+KPTuGSQ3hl2iDg12MMXMBxFIsnSVwVTMw3Ls=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr1413363pjj.101.1605742937385;
 Wed, 18 Nov 2020 15:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 18 Nov 2020 15:42:05 -0800
Message-ID: <CAKwvOd=5PhCTZ-yHr08gPYNEsGEjZa=rDY0-unhkhofjXhqwLQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
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
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 18, 2020 at 2:07 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This patch series adds support for building the kernel with Clang's
> Link Time Optimization (LTO). In addition to performance, the primary
> motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> be used in the kernel. Google has shipped millions of Pixel devices
> running three major kernel versions with LTO+CFI since 2018.
>
> Most of the patches are build system changes for handling LLVM bitcode,
> which Clang produces with LTO instead of ELF object files, postponing
> ELF processing until a later stage, and ensuring initcall ordering.
>
> Note that v7 brings back arm64 support as Will has now staged the
> prerequisite memory ordering patches [1], and drops x86_64 while we work
> on fixing the remaining objtool warnings [2].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
> [2] https://lore.kernel.org/lkml/20201114004911.aip52eimk6c2uxd4@treble/
>
> You can also pull this series from
>
>   https://github.com/samitolvanen/linux.git lto-v7

Thanks for continuing to drive this series Sami.  For the series,

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

I did virtualized boot tests with the series applied to aarch64
defconfig without CONFIG_LTO, with CONFIG_LTO_CLANG, and a third time
with CONFIG_THINLTO.  If you make changes to the series in follow ups,
please drop my tested by tag from the modified patches and I'll help
re-test.  Some minor feedback on the Kconfig change, but I'll post it
off of that patch.

>
> ---
> Changes in v7:
>
>   - Rebased to master again.
>
>   - Added back arm64 patches as the prerequisites are now staged,
>     and dropped x86_64 support until the remaining objtool issues
>     are resolved.
>
>   - Dropped ifdefs from module.lds.S.
>
> Changes in v6:
>
>   - Added the missing --mcount flag to patch 5.
>
>   - Dropped the arm64 patches from this series and will repost them
>     later.
>
> Changes in v5:
>
>   - Rebased on top of tip/master.
>
>   - Changed the command line for objtool to use --vmlinux --duplicate
>     to disable warnings about retpoline thunks and to fix .orc_unwind
>     generation for vmlinux.o.
>
>   - Added --noinstr flag to objtool, so we can use --vmlinux without
>     also enabling noinstr validation.
>
>   - Disabled objtool's unreachable instruction warnings with LTO to
>     disable false positives for the int3 padding in vmlinux.o.
>
>   - Added ANNOTATE_RETPOLINE_SAFE annotations to the indirect jumps
>     in x86 assembly code to fix objtool warnings with retpoline.
>
>   - Fixed modpost warnings about missing version information with
>     CONFIG_MODVERSIONS.
>
>   - Included Makefile.lib into Makefile.modpost for ld_flags. Thanks
>     to Sedat for pointing this out.
>
>   - Updated the help text for ThinLTO to better explain the trade-offs.
>
>   - Updated commit messages with better explanations.
>
> Changes in v4:
>
>   - Fixed a typo in Makefile.lib to correctly pass --no-fp to objtool.
>
>   - Moved ftrace configs related to generating __mcount_loc to Kconfig,
>     so they are available also in Makefile.modfinal.
>
>   - Dropped two prerequisite patches that were merged to Linus' tree.
>
> Changes in v3:
>
>   - Added a separate patch to remove the unused DISABLE_LTO treewide,
>     as filtering out CC_FLAGS_LTO instead is preferred.
>
>   - Updated the Kconfig help to explain why LTO is behind a choice
>     and disabled by default.
>
>   - Dropped CC_FLAGS_LTO_CLANG, compiler-specific LTO flags are now
>     appended directly to CC_FLAGS_LTO.
>
>   - Updated $(AR) flags as KBUILD_ARFLAGS was removed earlier.
>
>   - Fixed ThinLTO cache handling for external module builds.
>
>   - Rebased on top of Masahiro's patch for preprocessing modules.lds,
>     and moved the contents of module-lto.lds to modules.lds.S.
>
>   - Moved objtool_args to Makefile.lib to avoid duplication of the
>     command line parameters in Makefile.modfinal.
>
>   - Clarified in the commit message for the initcall ordering patch
>     that the initcall order remains the same as without LTO.
>
>   - Changed link-vmlinux.sh to use jobserver-exec to control the
>     number of jobs started by generate_initcall_ordering.pl.
>
>   - Dropped the x86/relocs patch to whitelist L4_PAGE_OFFSET as it's
>     no longer needed with ToT kernel.
>
>   - Disabled LTO for arch/x86/power/cpu.c to work around a Clang bug
>     with stack protector attributes.
>
> Changes in v2:
>
>   - Fixed -Wmissing-prototypes warnings with W=1.
>
>   - Dropped cc-option from -fsplit-lto-unit and added .thinlto-cache
>     scrubbing to make distclean.
>
>   - Added a comment about Clang >=11 being required.
>
>   - Added a patch to disable LTO for the arm64 KVM nVHE code.
>
>   - Disabled objtool's noinstr validation with LTO unless enabled.
>
>   - Included Peter's proposed objtool mcount patch in the series
>     and replaced recordmcount with the objtool pass to avoid
>     whitelisting relocations that are not calls.
>
>   - Updated several commit messages with better explanations.
>
>
> Sami Tolvanen (17):
>   tracing: move function tracer options to Kconfig
>   kbuild: add support for Clang LTO
>   kbuild: lto: fix module versioning
>   kbuild: lto: limit inlining
>   kbuild: lto: merge module sections
>   kbuild: lto: remove duplicate dependencies from .mod files
>   init: lto: ensure initcall ordering
>   init: lto: fix PREL32 relocations
>   PCI: Fix PREL32 relocations for LTO
>   modpost: lto: strip .lto from module names
>   scripts/mod: disable LTO for empty.c
>   efi/libstub: disable LTO
>   drivers/misc/lkdtm: disable LTO for rodata.o
>   arm64: vdso: disable LTO
>   KVM: arm64: disable LTO for the nVHE directory
>   arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
>   arm64: allow LTO_CLANG and THINLTO to be selected
>
>  .gitignore                            |   1 +
>  Makefile                              |  45 +++--
>  arch/Kconfig                          |  74 +++++++
>  arch/arm64/Kconfig                    |   4 +
>  arch/arm64/kernel/vdso/Makefile       |   3 +-
>  arch/arm64/kvm/hyp/nvhe/Makefile      |   4 +-
>  drivers/firmware/efi/libstub/Makefile |   2 +
>  drivers/misc/lkdtm/Makefile           |   1 +
>  include/asm-generic/vmlinux.lds.h     |  11 +-
>  include/linux/init.h                  |  79 +++++++-
>  include/linux/pci.h                   |  19 +-
>  kernel/trace/Kconfig                  |  16 ++
>  scripts/Makefile.build                |  50 ++++-
>  scripts/Makefile.lib                  |   6 +-
>  scripts/Makefile.modfinal             |   9 +-
>  scripts/Makefile.modpost              |  25 ++-
>  scripts/generate_initcall_order.pl    | 270 ++++++++++++++++++++++++++
>  scripts/link-vmlinux.sh               |  70 ++++++-
>  scripts/mod/Makefile                  |   1 +
>  scripts/mod/modpost.c                 |  16 +-
>  scripts/mod/modpost.h                 |   9 +
>  scripts/mod/sumversion.c              |   6 +-
>  scripts/module.lds.S                  |  24 +++
>  23 files changed, 677 insertions(+), 68 deletions(-)
>  create mode 100755 scripts/generate_initcall_order.pl
>
>
> base-commit: 0fa8ee0d9ab95c9350b8b84574824d9a384a9f7d
> --
> 2.29.2.299.gdc1121823c-goog
>


-- 
Thanks,
~Nick Desaulniers
