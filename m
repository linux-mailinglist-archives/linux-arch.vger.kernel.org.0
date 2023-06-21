Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B54739083
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 22:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjFUUFZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 16:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFUUFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 16:05:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CBD186;
        Wed, 21 Jun 2023 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687377921; x=1718913921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aUFm6KPq9IvsRQ99jHoURsxZubS26tpLZrj0RUPfm1A=;
  b=Dw/r+95vAPQb/612qh6H962Pc39UWLCphyNp7tXQ5aZcO72Qxc3v8Zro
   Cup2sIbCNzzcbO2fL8ruEMTm3/YpUwbmNSE00etDWzchCs25dYLvhtCrO
   5030O09CXcPMRwWDoFcEC4i8L5ZWsKiBXofHnU6jZ+EnbcvcImM8Xt4dh
   L0O3+UF+i3dAhNj1Rw5SonU6niDeXDuDyqTdORxmcCbjebtPG6T6qi7Fr
   G75WQ9MQQzYYLUTLYYcOwCu6YnFhsSKiDXe/gVyozCKBiUFjM20ljLn2z
   0r+oIuUjAXjyWjkpo/nJiCLlxMno0NUO2K9IdnM2/XtO8+SsG6oImaODC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="350016589"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="350016589"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 13:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="859129494"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="859129494"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2023 13:05:18 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qC44r-00074B-20;
        Wed, 21 Jun 2023 20:05:17 +0000
Date:   Thu, 22 Jun 2023 04:04:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 1/2] asm-generic: Unify uapi bitsperlong.h for arm64,
 riscv and loongarch
Message-ID: <202306220334.C80BpATp-lkp@intel.com>
References: <1687336748-4898-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687336748-4898-2-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tiezhu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on soc/for-next arm64/for-next/core linus/master v6.4-rc7 next-20230621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/asm-generic-Unify-uapi-bitsperlong-h-for-arm64-riscv-and-loongarch/20230621-172223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/1687336748-4898-2-git-send-email-yangtiezhu%40loongson.cn
patch subject: [PATCH v2 1/2] asm-generic: Unify uapi bitsperlong.h for arm64, riscv and loongarch
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230622/202306220334.C80BpATp-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306220334.C80BpATp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306220334.C80BpATp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from lib/kunit/test.c:9:
   In file included from include/kunit/resource.h:12:
   In file included from include/kunit/test.h:12:
   In file included from include/kunit/assert.h:12:
   In file included from include/linux/err.h:5:
   In file included from include/linux/compiler.h:246:
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1:
   In file included from include/asm-generic/rwonce.h:26:
   In file included from include/linux/kasan-checks.h:5:
   In file included from include/linux/types.h:6:
   In file included from include/uapi/linux/types.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   1 warning generated.
--
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined], err: false
--
   In file included from lib/decompress_inflate.c:21:
   In file included from include/linux/zutil.h:17:
   In file included from include/linux/string.h:5:
   In file included from include/linux/compiler.h:246:
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1:
   In file included from include/asm-generic/rwonce.h:26:
   In file included from include/linux/kasan-checks.h:5:
   In file included from include/linux/types.h:6:
   In file included from include/uapi/linux/types.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   lib/decompress_inflate.c:42:17: warning: no previous prototype for function '__gunzip' [-Wmissing-prototypes]
   STATIC int INIT __gunzip(unsigned char *buf, long len,
                   ^
   lib/decompress_inflate.c:42:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   STATIC int INIT __gunzip(unsigned char *buf, long len,
          ^
          static 
   2 warnings generated.
--
   In file included from lib/decompress_unxz.c:107:
   In file included from include/linux/decompress/mm.h:79:
   In file included from include/linux/kernel.h:16:
   In file included from include/linux/limits.h:6:
   In file included from include/linux/types.h:6:
   In file included from include/uapi/linux/types.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   lib/decompress_unxz.c:251:17: warning: no previous prototype for function 'unxz' [-Wmissing-prototypes]
   STATIC int INIT unxz(unsigned char *in, long in_size,
                   ^
   lib/decompress_unxz.c:251:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   STATIC int INIT unxz(unsigned char *in, long in_size,
          ^
          static 
   2 warnings generated.
--
   In file included from lib/decompress_unzstd.c:74:
   In file included from include/linux/decompress/mm.h:79:
   In file included from include/linux/kernel.h:16:
   In file included from include/linux/limits.h:6:
   In file included from include/linux/types.h:6:
   In file included from include/uapi/linux/types.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   lib/decompress_unzstd.c:331:17: warning: no previous prototype for function 'unzstd' [-Wmissing-prototypes]
   STATIC int INIT unzstd(unsigned char *buf, long len,
                   ^
   lib/decompress_unzstd.c:331:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   STATIC int INIT unzstd(unsigned char *buf, long len,
          ^
          static 
   2 warnings generated.
--
   In file included from lib/maple_tree.c:54:
   In file included from include/linux/maple_tree.h:11:
   In file included from include/linux/kernel.h:16:
   In file included from include/linux/limits.h:6:
   In file included from include/linux/types.h:6:
   In file included from include/uapi/linux/types.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   lib/maple_tree.c:331:21: warning: unused function 'mte_set_full' [-Wunused-function]
   static inline void *mte_set_full(const struct maple_enode *node)
                       ^
   lib/maple_tree.c:336:21: warning: unused function 'mte_clear_full' [-Wunused-function]
   static inline void *mte_clear_full(const struct maple_enode *node)
                       ^
   lib/maple_tree.c:341:20: warning: unused function 'mte_has_null' [-Wunused-function]
   static inline bool mte_has_null(const struct maple_enode *node)
                      ^
   4 warnings generated.
--
   In file included from lib/radix-tree.c:12:
   In file included from include/linux/bitmap.h:8:
   In file included from include/linux/bitops.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   lib/radix-tree.c:288:6: warning: no previous prototype for function 'radix_tree_node_rcu_free' [-Wmissing-prototypes]
   void radix_tree_node_rcu_free(struct rcu_head *head)
        ^
   lib/radix-tree.c:288:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void radix_tree_node_rcu_free(struct rcu_head *head)
   ^
   static 
   lib/radix-tree.c:1134:50: warning: parameter 'slot' set but not used [-Wunused-but-set-parameter]
   void __rcu **radix_tree_iter_resume(void __rcu **slot,
                                                    ^
   3 warnings generated.
--
   In file included from lib/zstd/compress/huf_compress.c:23:
   In file included from lib/zstd/compress/../common/zstd_deps.h:29:
   In file included from include/linux/limits.h:6:
   In file included from include/linux/types.h:6:
   In file included from include/uapi/linux/types.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   lib/zstd/compress/huf_compress.c:471:16: warning: unused function 'HUF_isSorted' [-Wunused-function]
   MEM_STATIC int HUF_isSorted(nodeElt huffNode[], U32 const maxSymbolValue1) {
                  ^
   2 warnings generated.
--
   In file included from lib/zstd/compress/zstd_lazy.c:11:
   In file included from lib/zstd/compress/zstd_compress_internal.h:21:
   In file included from lib/zstd/compress/../common/zstd_internal.h:23:
   In file included from lib/zstd/compress/../common/cpu.h:19:
   In file included from lib/zstd/compress/../common/mem.h:18:
   In file included from ./arch/x86/include/generated/asm/unaligned.h:1:
   In file included from include/asm-generic/unaligned.h:9:
   In file included from include/linux/unaligned/packed_struct.h:4:
   In file included from include/linux/types.h:6:
   In file included from include/uapi/linux/types.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   lib/zstd/compress/zstd_lazy.c:835:16: warning: unused function 'ZSTD_isAligned' [-Wunused-function]
   MEM_STATIC int ZSTD_isAligned(void const* ptr, size_t align) {
                  ^
   2 warnings generated.
--
   In file included from arch/x86/kernel/cpu/common.c:5:
   In file included from include/linux/memblock.h:11:
   In file included from include/linux/init.h:5:
   In file included from include/linux/build_bug.h:5:
   In file included from include/linux/compiler.h:246:
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1:
   In file included from include/asm-generic/rwonce.h:26:
   In file included from include/linux/kasan-checks.h:5:
   In file included from include/linux/types.h:6:
   In file included from include/uapi/linux/types.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   arch/x86/kernel/cpu/common.c:366:19: warning: unused function 'flag_is_changeable_p' [-Wunused-function]
   static inline int flag_is_changeable_p(u32 flag)
                     ^
   2 warnings generated.
--
   In file included from lib/mpi/mpi-inv.c:20:
   In file included from lib/mpi/mpi-internal.h:20:
   In file included from include/linux/module.h:12:
   In file included from include/linux/list.h:5:
   In file included from include/linux/container_of.h:5:
   In file included from include/linux/build_bug.h:5:
   In file included from include/linux/compiler.h:246:
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1:
   In file included from include/asm-generic/rwonce.h:26:
   In file included from include/linux/kasan-checks.h:5:
   In file included from include/linux/types.h:6:
   In file included from include/uapi/linux/types.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   In file included from include/asm-generic/int-ll64.h:11:
   In file included from include/uapi/asm-generic/int-ll64.h:12:
   In file included from arch/x86/include/uapi/asm/bitsperlong.h:11:
   In file included from include/asm-generic/bitsperlong.h:5:
>> include/uapi/asm-generic/bitsperlong.h:13:9: warning: '__BITS_PER_LONG' macro redefined [-Wmacro-redefined]
   #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
           ^
   arch/x86/include/uapi/asm/bitsperlong.h:6:10: note: previous definition is here
   # define __BITS_PER_LONG 64
            ^
   lib/mpi/mpi-inv.c:34:15: warning: variable 'k' set but not used [-Wunused-but-set-variable]
           unsigned int k;
                        ^
   2 warnings generated.
..


vim +/__BITS_PER_LONG +13 include/uapi/asm-generic/bitsperlong.h

     4	
     5	/*
     6	 * In order to keep safe and avoid regression, only unify uapi
     7	 * bitsperlong.h for some archs which are using newer toolchains
     8	 * that have the definitions of __CHAR_BIT__ and __SIZEOF_LONG__.
     9	 * See the following link for more info:
    10	 * https://lore.kernel.org/linux-arch/b9624545-2c80-49a1-ac3c-39264a591f7b@app.fastmail.com/
    11	 */
    12	#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
  > 13	#define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
    14	#else
    15	/*
    16	 * There seems to be no way of detecting this automatically from user
    17	 * space, so 64 bit architectures should override this in their
    18	 * bitsperlong.h. In particular, an architecture that supports
    19	 * both 32 and 64 bit user space must not rely on CONFIG_64BIT
    20	 * to decide it, but rather check a compiler provided macro.
    21	 */
    22	#ifndef __BITS_PER_LONG
    23	#define __BITS_PER_LONG 32
    24	#endif
    25	#endif
    26	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
