Return-Path: <linux-arch+bounces-1031-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3C2812716
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 06:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8331F21A6F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07D16123;
	Thu, 14 Dec 2023 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmQyDSUg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCCFA3;
	Wed, 13 Dec 2023 21:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702532999; x=1734068999;
  h=date:from:to:cc:subject:message-id;
  bh=/tvvCXJbjyaaTjRnMR0lHnsl03e4/xREQfN7AaDv2R8=;
  b=LmQyDSUgVAAAnNhAzrS5PzWf8wrkfI6o6T6QcNJlAgibklrKa1iGcTr9
   R88WpBJSlGKLn5U9ndbPfp98ux6MHvRxeYosSVQ0Ix89l8lCuSuUv/8+4
   K8q5aVBYrJPDQUwBTIIFu7BmdgdbMJFfczrqekJjJYhB0sjqZgPRB54OB
   s7lDnOnNbpKdvBQVzPnNZW2cHZGkjt/sRuOZK8P2izINNeB9mXzCWSpD5
   W5xEhVO5LEls14qA0MTkNfzlzSivQssBtk1buj6efJOTwGSXEyDHF68VH
   OUOgf7cqJq/F7FFAj6UvLl8XjRULynplK9PH7TaKSmynGZhEBxTcSCFW9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2226163"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2226163"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 21:49:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723942102"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="723942102"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2023 21:49:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDebX-000Le1-14;
	Thu, 14 Dec 2023 05:49:51 +0000
Date: Thu, 14 Dec 2023 13:49:37 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
 ntfs3@lists.linux.dev, rcu@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 48e8992e33abf054bcc0bb2e77b2d43bb899212e
Message-ID: <202312141328.x0H6s9CL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 48e8992e33abf054bcc0bb2e77b2d43bb899212e  Add linux-next specific files for 20231213

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202312131758.NED6TvQK-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312131823.hO2NP34f-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312131907.mnyTUNnO-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312140633.nmHowPIh-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312140939.zA3tdSi2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312141227.C2h1IzfI-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/hid/hid-nintendo.c:371:13: error: initializer element is not constant
fs/afs/callback.c:106:(.text+0x308): undefined reference to `__generic_xchg_called_with_bad_pointer'
fs/afs/rotate.c:69:(.text+0x26c): undefined reference to `__generic_xchg_called_with_bad_pointer'
fs/bcachefs/btree_iter.c:1442:28: warning: variable 'path' set but not used [-Wunused-but-set-variable]
include/asm-generic/cmpxchg.h:76:(.text+0x1f6): undefined reference to `__generic_xchg_called_with_bad_pointer'
include/linux/rcupdate.h:301:(.text+0x5cb2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
kernel/rcu/tree.c:2965:(.text+0x5b44): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
ld.lld: error: undefined symbol: __bad_xchg

Unverified Error/Warning (likely false positive, please contact us if interested):

callback.c:(.text+0x214): relocation truncated to fit: R_NIOS2_CALL26 against `__generic_xchg_called_with_bad_pointer'
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:1127: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/scsi/mpi3mr/mpi3mr_app.c:1091 mpi3mr_map_data_buffer_dma() warn: returning -1 instead of -ENOMEM is sloppy
drivers/scsi/mpi3mr/mpi3mr_app.c:712 mpi3mr_bsg_build_sgl() warn: missing unwind goto?
fs/bcachefs/inode.c:1171 bch2_delete_dead_inodes() error: potentially using uninitialized 'ret'.
rotate.c:(.text+0x20c): relocation truncated to fit: R_NIOS2_CALL26 against `__generic_xchg_called_with_bad_pointer'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- arc-allmodconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- arc-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- arc-randconfig-r112-20231213
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- arc-randconfig-r131-20231212
|   `-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|-- arm-allmodconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- arm-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- csky-allmodconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- csky-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- csky-buildonly-randconfig-r005-20221115
|   |-- fs-afs-callback.c:(.text):undefined-reference-to-__generic_xchg_called_with_bad_pointer
|   |-- fs-afs-rotate.c:(.text):undefined-reference-to-__generic_xchg_called_with_bad_pointer
|   `-- include-asm-generic-cmpxchg.h:(.text):undefined-reference-to-__generic_xchg_called_with_bad_pointer
|-- csky-randconfig-002-20231213
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- csky-randconfig-r013-20230826
|   |-- include-linux-rcupdate.h:(.text):relocation-truncated-to-fit:R_CKCORE_PCREL_IMM16BY4-against-__jump_table
|   `-- kernel-rcu-tree.c:(.text):relocation-truncated-to-fit:R_CKCORE_PCREL_IMM16BY4-against-__jump_table
|-- csky-randconfig-r111-20231213
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- arch-csky-kernel-vdso-vgettimeofday.c:sparse:sparse:function-__vdso_clock_gettime-with-external-linkage-has-definition
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- csky-randconfig-r113-20231213
|   |-- arch-csky-kernel-vdso-vgettimeofday.c:sparse:sparse:function-__vdso_clock_gettime-with-external-linkage-has-definition
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- csky-randconfig-r121-20231213
|   |-- arch-csky-kernel-vdso-vgettimeofday.c:sparse:sparse:function-__vdso_clock_gettime-with-external-linkage-has-definition
|   |-- fs-bcachefs-btree_iter.c:warning:variable-path-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   |-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- i386-randconfig-014-20231213
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- i386-randconfig-015-20231213
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- i386-randconfig-016-20231213
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- loongarch-allmodconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- loongarch-randconfig-001-20231213
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- m68k-allmodconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- m68k-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- microblaze-allmodconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- microblaze-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- mips-allyesconfig
|   |-- fs-bcachefs-btree_iter.c:warning:variable-path-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- mips-decstation_r4k_defconfig
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- nios2-allmodconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- nios2-allyesconfig
|   |-- callback.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-__generic_xchg_called_with_bad_pointer
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   |-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- rotate.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-__generic_xchg_called_with_bad_pointer
|-- nios2-randconfig-001-20231213
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- nios2-randconfig-r112-20231213
|   |-- fs-afs-main.c:sparse:sparse:cast-removes-address-space-__rcu-of-expression
|   `-- fs-afs-main.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-callback_head-head-got-struct-callback_head-noderef-__rcu
|-- openrisc-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- openrisc-randconfig-r122-20231213
|   |-- fs-bcachefs-btree_iter.c:warning:variable-path-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   |-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- openrisc-randconfig-r131-20231213
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- parisc-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-tty-serial-8250_parisc.o
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- parisc-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- parisc-randconfig-002-20231213
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- powerpc64-randconfig-r132-20231213
|   |-- fs-bcachefs-btree_iter.c:warning:variable-path-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   |-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|   |-- lib-raid6-altivec4.c:sparse:incomplete-type-static-toplevel-unative_t
|   |-- lib-raid6-altivec4.c:sparse:int-static-signed-toplevel-__preempt_count_sub(-...-)
|   |-- lib-raid6-altivec4.c:sparse:int-static-signed-toplevel-disable_kernel_altivec(-...-)
|   |-- lib-raid6-altivec4.c:sparse:int-static-toplevel-unative_t
|   |-- lib-raid6-altivec8.c:sparse:incomplete-type-static-toplevel-unative_t
|   |-- lib-raid6-altivec8.c:sparse:int-static-signed-toplevel-__preempt_count_sub(-...-)
|   |-- lib-raid6-altivec8.c:sparse:int-static-signed-toplevel-disable_kernel_altivec(-...-)
|   |-- lib-raid6-altivec8.c:sparse:int-static-toplevel-unative_t
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- powerpc64-randconfig-r133-20231213
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- riscv-allmodconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- riscv-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- s390-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_diag_mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_eckd_mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_fba_mod.o
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- s390-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- s390-defconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- s390-randconfig-001-20231213
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- sh-allmodconfig
|   |-- fs-bcachefs-btree_iter.c:warning:variable-path-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- sh-allyesconfig
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- sparc-allnoconfig
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-randconfig-001-20231213
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-randconfig-002-20231213
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   |-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_register
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_unregister
|   `-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ns87303_lock
|-- sparc-randconfig-r123-20231213
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   |-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|   |-- fs-ntfs3-ntfs.h:sparse:sparse:static-assertion-failed:sizeof(struct-ATTR_LIST_ENTRY)
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- sparc-sparc32_defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-sparc64_defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- sparc64-allyesconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- sparc64-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-randconfig-001-20231213
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- fs-bcachefs-btree_iter.c:warning:variable-path-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- sparc64-randconfig-002-20231213
|   |-- fs-bcachefs-btree_iter.c:warning:variable-path-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|-- x86_64-allnoconfig
|   `-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-display-panel-synaptics-r63353.yaml
|-- x86_64-randconfig-016-20231214
|   `-- drivers-hid-hid-nintendo.c:error:initializer-element-is-not-constant
|-- x86_64-randconfig-122-20231213
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- x86_64-randconfig-123-20231213
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   |-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- x86_64-randconfig-161-20231214
|   |-- drivers-scsi-mpi3mr-mpi3mr_app.c-mpi3mr_bsg_build_sgl()-warn:missing-unwind-goto
|   `-- drivers-scsi-mpi3mr-mpi3mr_app.c-mpi3mr_map_data_buffer_dma()-warn:returning-instead-of-ENOMEM-is-sloppy
|-- xtensa-randconfig-001-20231213
|   |-- fs-bcachefs-btree_iter.c:warning:variable-path-set-but-not-used
|   |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
|   `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
`-- xtensa-randconfig-002-20231213
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
    |-- fs-bcachefs-btree_iter.c:warning:variable-path-set-but-not-used
    |-- fs-bcachefs-chardev.c:warning:function-run_thread_with_file-might-be-a-candidate-for-gnu_printf-format-attribute
    `-- fs-bcachefs-super.c:warning:function-__bch2_print-might-be-a-candidate-for-gnu_printf-format-attribute
clang_recent_errors
|-- arm-defconfig
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_poweroff_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|   `-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_shdwc_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|-- arm-randconfig-003-20231213
|   `-- ld.lld:error:undefined-symbol:__bad_xchg
|-- arm64-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- arm64-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- hexagon-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- hexagon-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- i386-allmodconfig
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-allyesconfig
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-buildonly-randconfig-001-20231213
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-buildonly-randconfig-002-20231213
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-randconfig-001-20231213
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-randconfig-002-20231213
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-randconfig-003-20231213
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-randconfig-004-20231213
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-randconfig-006-20231213
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-randconfig-054-20231213
|   `-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|-- i386-randconfig-062-20231213
|   |-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- i386-randconfig-063-20231213
|   |-- fs-ntfs3-ntfs.h:error:static-assertion-failed-due-to-requirement-sizeof(struct-ATTR_LIST_ENTRY):sizeof(struct-ATTR_LIST_ENTRY)
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- i386-randconfig-141-20231213
|   |-- lib-zstd-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   `-- lib-zstd-decompress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting
|-- powerpc-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- powerpc-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- powerpc-randconfig-003-20231213
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- x86_64-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- x86_64-buildonly-randconfig-002-20231213
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
`-- x86_64-randconfig-161-20231213
    |-- fs-bcachefs-inode.c-bch2_delete_dead_inodes()-error:potentially-using-uninitialized-ret-.
    |-- lib-zstd-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
    |-- lib-zstd-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
    |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
    |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros64()-warn:inconsistent-indenting
    |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
    |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting
    |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
    `-- lib-zstd-decompress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting

elapsed time: 1477m

configs tested: 178
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231213   gcc  
arc                   randconfig-002-20231213   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                         lpc18xx_defconfig   gcc  
arm                   randconfig-001-20231213   clang
arm                   randconfig-002-20231213   clang
arm                   randconfig-003-20231213   clang
arm                   randconfig-004-20231213   clang
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231213   clang
arm64                 randconfig-002-20231213   clang
arm64                 randconfig-003-20231213   clang
arm64                 randconfig-004-20231213   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231213   gcc  
csky                  randconfig-002-20231213   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231213   clang
hexagon               randconfig-002-20231213   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231213   clang
i386         buildonly-randconfig-002-20231213   clang
i386         buildonly-randconfig-003-20231213   clang
i386         buildonly-randconfig-004-20231213   clang
i386         buildonly-randconfig-005-20231213   clang
i386         buildonly-randconfig-006-20231213   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231213   clang
i386                  randconfig-002-20231213   clang
i386                  randconfig-003-20231213   clang
i386                  randconfig-004-20231213   clang
i386                  randconfig-005-20231213   clang
i386                  randconfig-006-20231213   clang
i386                  randconfig-011-20231213   gcc  
i386                  randconfig-012-20231213   gcc  
i386                  randconfig-013-20231213   gcc  
i386                  randconfig-014-20231213   gcc  
i386                  randconfig-015-20231213   gcc  
i386                  randconfig-016-20231213   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231213   gcc  
loongarch             randconfig-002-20231213   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231213   gcc  
nios2                 randconfig-002-20231213   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231213   gcc  
parisc                randconfig-002-20231213   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20231213   clang
powerpc               randconfig-002-20231213   clang
powerpc               randconfig-003-20231213   clang
powerpc                     tqm8541_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc64             randconfig-001-20231213   clang
powerpc64             randconfig-002-20231213   clang
powerpc64             randconfig-003-20231213   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231213   clang
riscv                 randconfig-002-20231213   clang
riscv                          rv32_defconfig   clang
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231213   gcc  
s390                  randconfig-002-20231213   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231213   gcc  
sh                    randconfig-002-20231213   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231213   gcc  
sparc64               randconfig-002-20231213   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231213   clang
um                    randconfig-002-20231213   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231213   clang
x86_64       buildonly-randconfig-002-20231213   clang
x86_64       buildonly-randconfig-003-20231213   clang
x86_64       buildonly-randconfig-004-20231213   clang
x86_64       buildonly-randconfig-005-20231213   clang
x86_64       buildonly-randconfig-006-20231213   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231213   gcc  
x86_64                randconfig-002-20231213   gcc  
x86_64                randconfig-003-20231213   gcc  
x86_64                randconfig-004-20231213   gcc  
x86_64                randconfig-005-20231213   gcc  
x86_64                randconfig-006-20231213   gcc  
x86_64                randconfig-011-20231213   clang
x86_64                randconfig-012-20231213   clang
x86_64                randconfig-013-20231213   clang
x86_64                randconfig-014-20231213   clang
x86_64                randconfig-015-20231213   clang
x86_64                randconfig-016-20231213   clang
x86_64                randconfig-071-20231213   clang
x86_64                randconfig-072-20231213   clang
x86_64                randconfig-073-20231213   clang
x86_64                randconfig-074-20231213   clang
x86_64                randconfig-075-20231213   clang
x86_64                randconfig-076-20231213   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231213   gcc  
xtensa                randconfig-002-20231213   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

