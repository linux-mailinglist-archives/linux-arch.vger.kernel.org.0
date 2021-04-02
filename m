Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC6535300D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhDBT6e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 15:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235256AbhDBT6c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 15:58:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D2936100A;
        Fri,  2 Apr 2021 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617393510;
        bh=ZmypXT5QWZhLfO1w0TNje8DzGvklWLetR3aotVqFWag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghy83sUY5PVW9xvx8hOSWoSm/OjCo7i955NFdJaK2R987UBepj6zIIqrKjZn6eaZD
         6fvGsM9WNNtHIhsJPglfSsYm8xbRCn5TvT4/qzb+JsBUWEq00XWIWEA3lvbHgskR/Y
         vcNMIlx8uI4Ew0pfKI9LL1E/XcIQ0dIIJiV9i3VZ57dtopfVDql6dhtF3Hybdl3v8Z
         iVQIG00XFjfFE53pdeTTovmhy52doUv9sK1HjpHcI9s0X3FfKQCpBOh9sLUWNXB+y4
         5fewh2XgGXr9eK1b8p6WJ+6yFteyLPpzyyiwjiap0djM1zBY1t5d4kt268sFdbVnxB
         B/6sixAw1Pimw==
Date:   Fri, 2 Apr 2021 12:58:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5 00/18] Add support for Clang CFI
Message-ID: <20210402195823.huphtlhluqjgrw26@archlinux-ax161>
References: <20210401233216.2540591-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 04:31:58PM -0700, Sami Tolvanen wrote:
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
>   https://github.com/samitolvanen/linux.git cfi-v5
> 
> ---
> Changes in v5:
>  - Changed module.lds.S to only include <asm/page.h> when CFI is
>    enabled to fix the MIPS build.
>  - Added a patch that fixes dynamic ftrace with CFI on arm64.
> 
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
> Sami Tolvanen (18):
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
>   arm64: ftrace: use function_nocfi for ftrace_call
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
>  arch/arm64/kernel/ftrace.c                    |   2 +-
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
>  scripts/module.lds.S                          |  19 +-
>  75 files changed, 759 insertions(+), 113 deletions(-)
>  create mode 100644 include/linux/cfi.h
>  create mode 100644 kernel/cfi.c
> 
> 
> base-commit: 6905b1dc3c32a094f0da61bd656a740f0a97d592
> -- 
> 2.31.0.208.g409f899ff0-goog
> 


Hi Sami,

I booted this series on Equinix's c1.large.arm (2x Cavium ThunderX
CN8890) and c2.large.arm (1x Ampere eMAG 8180) servers [1] and my
Raspberry Pi 4B. I ran them through LTP's read_all test case on both
/proc and /sys and a few compile workloads, only uncovering one issue [2].

Consider this series:

Tested-by: Nathan Chancellor <nathan@kernel.org>

[1]: https://metal.equinix.com/developers/docs/servers/
[2]: https://lore.kernel.org/r/20210402195241.gahc5w25gezluw7p@archlinux-ax161/

Cheers,
Nathan
