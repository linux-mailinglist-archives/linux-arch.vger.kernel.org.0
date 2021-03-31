Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1C3509B7
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCaVqV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhCaVqL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:46:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5889C061762
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:46:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so1912154pjh.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=esAh+eFc7x1e4muSLkstj3Ic+kmZW4D/uno+GAwyPqg=;
        b=NzeLyJir6d1KwpiZ3RmekcvSne/weQo4YA0Uu7Q89IkbPP0+5tkV6E7R5TuBWawoMg
         idGZp8zqhG+5HVjnv+msYLiZQ9S7h9tCa6GvjbE5b83fycdA9pvVk1tDXnlDajKP2SLi
         74sdgQx/uoB7+AwHV0v7j226PbBND6y7yHvDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=esAh+eFc7x1e4muSLkstj3Ic+kmZW4D/uno+GAwyPqg=;
        b=CgTecljSGudtHP+mEsAU7VDWvDlIaEPL4o9UPpB1WzpPSD+NsuOPTyvv4FVHsHIFUs
         M8jaEVz38OrFPPfapud2U1pnfVQ4XWStknfx+i4EJcgd3lhLMRTqXph0iEv7YdKMvDfo
         uLRHqkv2uKjB8dfhAQHB4nASN4uqXZjzJZv90JBlQ/WaiQuT3SW21KjiPJa+KdYcrZun
         kqZL6D85VVmGoWCeqP+3aQtAL1EyOcM/z8SbD7Y0jE1I8yIeGWS/w8zTUEL3+YG7wJ4v
         Nk7m9ETM3YXe7xHFaVggthLT4/guzNAGmpx8orlyL0FsjnsJJiSwMudAW2brjDUBcNHv
         C/6A==
X-Gm-Message-State: AOAM532/aYvjCSiA3NcTPmOm03ZBY4v/A1HQoi2qY0jvvlOjmQXugInb
        DQqqoBy+FYiCfRSqylzIqC2tni7raWESyQ==
X-Google-Smtp-Source: ABdhPJyc6xYrPp/zlyE7RCl/S1V/S62i7LtVAPCykyeZ+e4UWpT04Q1Ln+T2FDOVuAGVX7rqBciSng==
X-Received: by 2002:a17:90a:be0e:: with SMTP id a14mr5187306pjs.131.1617227170242;
        Wed, 31 Mar 2021 14:46:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id iq6sm3106930pjb.31.2021.03.31.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 14:46:09 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:46:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 00/17] Add support for Clang CFI
Message-ID: <202103311442.FDB6E8223@keescook>
References: <20210331212722.2746212-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 02:27:04PM -0700, Sami Tolvanen wrote:
> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking. With CFI, the compiler injects a runtime check before each
> indirect function call to ensure the target is a valid function with
> the correct static type. This restricts possible call targets and
> makes it more difficult for an attacker to exploit bugs that allow the
> modification of stored function pointers. For more details, see:
> 
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> The first patch contains build system changes and error handling,
> and implements support for cross-module indirect call checking. The
> remaining patches address issues caused by the compiler
> instrumentation. These include fixing known type mismatches, as well
> as issues with address space confusion and cross-module function
> address equality.
> 
> These patches add support only for arm64, but I'll post patches also
> for x86_64 after we address the remaining issues there, including
> objtool support.
> 
> You can also pull this series from
> 
>   https://github.com/samitolvanen/linux.git cfi-v4

Thanks for the updates! I think this is ready to land in -next.

Will, Mark, Catalin: would you prefer this go via arm64 or via my LTO
tree? (Or does anyone see other stuff they'd like fixed first?)

-Kees

> ---
> Changes in v4:
>  - Per Mark's suggestion, dropped __pa_function() and renamed
>    __va_function() to function_nocfi().
>  - Added a comment to function_nocfi() to explain what it does.
>  - Updated the psci patch to use an intermediate variable for
>    the physical address for clarity.
> 
> Changes in v3:
>  - Added a patch to change list_sort() callers treewide to use
>    const pointers instead of simply removing the internal casts.
>  - Changed cleanup_symbol_name() to return bool.
>  - Changed module.lds.S to drop the .eh_frame section only with
>    CONFIG_CFI_CLANG.
>  - Switched to synchronize_rcu() in update_shadow().
> 
> Changes in v2:
>  - Fixed .text merging in module.lds.S.
>  - Added WARN_ON_FUNCTION_MISMATCH() and changed kernel/thread.c
>    and kernel/workqueue.c to use the macro instead.
> 
> 
> Sami Tolvanen (17):
>   add support for Clang CFI
>   cfi: add __cficanonical
>   mm: add generic function_nocfi macro
>   module: ensure __cfi_check alignment
>   workqueue: use WARN_ON_FUNCTION_MISMATCH
>   kthread: use WARN_ON_FUNCTION_MISMATCH
>   kallsyms: strip ThinLTO hashes from static functions
>   bpf: disable CFI in dispatcher functions
>   treewide: Change list_sort to use const pointers
>   lkdtm: use function_nocfi
>   psci: use function_nocfi for cpu_resume
>   arm64: implement function_nocfi
>   arm64: use function_nocfi with __pa_symbol
>   arm64: add __nocfi to functions that jump to a physical address
>   arm64: add __nocfi to __apply_alternatives
>   KVM: arm64: Disable CFI for nVHE
>   arm64: allow CONFIG_CFI_CLANG to be selected
> 
>  Makefile                                      |  17 +
>  arch/Kconfig                                  |  45 +++
>  arch/arm64/Kconfig                            |   1 +
>  arch/arm64/include/asm/memory.h               |  15 +
>  arch/arm64/include/asm/mmu_context.h          |   4 +-
>  arch/arm64/kernel/acpi_parking_protocol.c     |   3 +-
>  arch/arm64/kernel/alternative.c               |   4 +-
>  arch/arm64/kernel/cpu-reset.h                 |  10 +-
>  arch/arm64/kernel/cpufeature.c                |   4 +-
>  arch/arm64/kernel/psci.c                      |   3 +-
>  arch/arm64/kernel/smp_spin_table.c            |   3 +-
>  arch/arm64/kvm/hyp/nvhe/Makefile              |   6 +-
>  arch/arm64/kvm/vgic/vgic-its.c                |   8 +-
>  arch/arm64/kvm/vgic/vgic.c                    |   3 +-
>  block/blk-mq-sched.c                          |   3 +-
>  block/blk-mq.c                                |   3 +-
>  drivers/acpi/nfit/core.c                      |   3 +-
>  drivers/acpi/numa/hmat.c                      |   3 +-
>  drivers/clk/keystone/sci-clk.c                |   4 +-
>  drivers/firmware/psci/psci.c                  |   7 +-
>  drivers/gpu/drm/drm_modes.c                   |   3 +-
>  drivers/gpu/drm/i915/gt/intel_engine_user.c   |   3 +-
>  drivers/gpu/drm/i915/gvt/debugfs.c            |   2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |   3 +-
>  drivers/gpu/drm/radeon/radeon_cs.c            |   4 +-
>  .../hw/usnic/usnic_uiom_interval_tree.c       |   3 +-
>  drivers/interconnect/qcom/bcm-voter.c         |   2 +-
>  drivers/md/raid5.c                            |   3 +-
>  drivers/misc/lkdtm/usercopy.c                 |   2 +-
>  drivers/misc/sram.c                           |   4 +-
>  drivers/nvme/host/core.c                      |   3 +-
>  .../controller/cadence/pcie-cadence-host.c    |   3 +-
>  drivers/spi/spi-loopback-test.c               |   3 +-
>  fs/btrfs/raid56.c                             |   3 +-
>  fs/btrfs/tree-log.c                           |   3 +-
>  fs/btrfs/volumes.c                            |   3 +-
>  fs/ext4/fsmap.c                               |   4 +-
>  fs/gfs2/glock.c                               |   3 +-
>  fs/gfs2/log.c                                 |   2 +-
>  fs/gfs2/lops.c                                |   3 +-
>  fs/iomap/buffered-io.c                        |   3 +-
>  fs/ubifs/gc.c                                 |   7 +-
>  fs/ubifs/replay.c                             |   4 +-
>  fs/xfs/scrub/bitmap.c                         |   4 +-
>  fs/xfs/xfs_bmap_item.c                        |   4 +-
>  fs/xfs/xfs_buf.c                              |   6 +-
>  fs/xfs/xfs_extent_busy.c                      |   4 +-
>  fs/xfs/xfs_extent_busy.h                      |   3 +-
>  fs/xfs/xfs_extfree_item.c                     |   4 +-
>  fs/xfs/xfs_refcount_item.c                    |   4 +-
>  fs/xfs/xfs_rmap_item.c                        |   4 +-
>  include/asm-generic/bug.h                     |  16 +
>  include/asm-generic/vmlinux.lds.h             |  20 +-
>  include/linux/bpf.h                           |   4 +-
>  include/linux/cfi.h                           |  41 +++
>  include/linux/compiler-clang.h                |   3 +
>  include/linux/compiler_types.h                |   8 +
>  include/linux/init.h                          |   6 +-
>  include/linux/list_sort.h                     |   7 +-
>  include/linux/mm.h                            |  10 +
>  include/linux/module.h                        |  13 +-
>  include/linux/pci.h                           |   4 +-
>  init/Kconfig                                  |   2 +-
>  kernel/Makefile                               |   4 +
>  kernel/cfi.c                                  | 329 ++++++++++++++++++
>  kernel/kallsyms.c                             |  55 ++-
>  kernel/kthread.c                              |   3 +-
>  kernel/module.c                               |  43 +++
>  kernel/workqueue.c                            |   2 +-
>  lib/list_sort.c                               |  17 +-
>  lib/test_list_sort.c                          |   3 +-
>  net/tipc/name_table.c                         |   4 +-
>  scripts/Makefile.modfinal                     |   2 +-
>  scripts/module.lds.S                          |  20 +-
>  74 files changed, 759 insertions(+), 112 deletions(-)
>  create mode 100644 include/linux/cfi.h
>  create mode 100644 kernel/cfi.c
> 
> 
> base-commit: d19cc4bfbff1ae72c3505a00fb8ce0d3fa519e6c
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 

-- 
Kees Cook
