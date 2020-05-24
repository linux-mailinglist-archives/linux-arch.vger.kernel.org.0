Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D701DFF72
	for <lists+linux-arch@lfdr.de>; Sun, 24 May 2020 16:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbgEXOpc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 May 2020 10:45:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:2034 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbgEXOpc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 24 May 2020 10:45:32 -0400
IronPort-SDR: D2dJLGWiSIq6Qptl6/NbHChfZ5s0KeQHZgMrm2TTvwa/bif81iw5CwFzPYXNCB714ClLh0jzEp
 IARcqexnDzzQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 07:45:31 -0700
IronPort-SDR: YDamSKfOZF3S3LQf5z+MJMzs7cAfzoINnTVHJ44pNKf//0cwlPY6hiFcHKv2BcOZoJmDpVITpo
 uUibGEUMqj2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,430,1583222400"; 
   d="gz'50?scan'50,208,50";a="265914211"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2020 07:45:28 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jcrsV-00017x-Ce; Sun, 24 May 2020 22:45:27 +0800
Date:   Sun, 24 May 2020 22:44:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>, linus.walleij@linaro.org,
        akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, andriy.shevchenko@linux.intel.com,
        vilhelm.gray@gmail.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Message-ID: <202005242236.NtfLt1Ae%lkp@intel.com>
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Syed,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce]

url:    https://github.com/0day-ci/linux/commits/Syed-Nayyar-Waris/Introduce-the-for_each_set_clump-macro/20200524-130931
base:    b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

In file included from include/asm-generic/atomic-instrumented.h:20:0,
from arch/x86/include/asm/atomic.h:265,
from include/linux/atomic.h:7,
from include/linux/crypto.h:15,
from arch/x86/kernel/asm-offsets.c:9:
include/linux/bitmap.h: In function 'bitmap_get_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bitmap.h: In function 'bitmap_set_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
--
In file included from include/linux/bits.h:23:0,
from include/linux/bitops.h:5,
from include/linux/kernel.h:12,
from include/asm-generic/bug.h:19,
from arch/x86/include/asm/bug.h:83,
from include/linux/bug.h:5,
from include/linux/mmdebug.h:5,
from include/linux/gfp.h:5,
from arch/x86/mm/init.c:1:
include/linux/bitmap.h: In function 'bitmap_get_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bitmap.h: In function 'bitmap_set_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
arch/x86/mm/init.c: At top level:
arch/x86/mm/init.c:469:21: warning: no previous prototype for 'init_memory_mapping' [-Wmissing-prototypes]
unsigned long __ref init_memory_mapping(unsigned long start,
^~~~~~~~~~~~~~~~~~~
arch/x86/mm/init.c:711:13: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
void __init poking_init(void)
^~~~~~~~~~~
arch/x86/mm/init.c:860:13: warning: no previous prototype for 'mem_encrypt_free_decrypted_mem' [-Wmissing-prototypes]
void __weak mem_encrypt_free_decrypted_mem(void) { }
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
In file included from include/linux/bits.h:23:0,
from include/linux/bitops.h:5,
from include/linux/kernel.h:12,
from include/asm-generic/bug.h:19,
from arch/x86/include/asm/bug.h:83,
from include/linux/bug.h:5,
from include/linux/mmdebug.h:5,
from include/linux/mm.h:9,
from include/linux/memblock.h:13,
from arch/x86/mm/ioremap.c:10:
include/linux/bitmap.h: In function 'bitmap_get_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bitmap.h: In function 'bitmap_set_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
arch/x86/mm/ioremap.c: At top level:
arch/x86/mm/ioremap.c:484:12: warning: no previous prototype for 'arch_ioremap_p4d_supported' [-Wmissing-prototypes]
int __init arch_ioremap_p4d_supported(void)
^~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/ioremap.c:489:12: warning: no previous prototype for 'arch_ioremap_pud_supported' [-Wmissing-prototypes]
int __init arch_ioremap_pud_supported(void)
^~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/ioremap.c:498:12: warning: no previous prototype for 'arch_ioremap_pmd_supported' [-Wmissing-prototypes]
int __init arch_ioremap_pmd_supported(void)
^~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/ioremap.c:737:17: warning: no previous prototype for 'early_memremap_pgprot_adjust' [-Wmissing-prototypes]
pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
In file included from include/linux/bits.h:23:0,
from include/linux/bitops.h:5,
from include/linux/kernel.h:12,
from arch/x86/include/asm/percpu.h:45,
from arch/x86/include/asm/current.h:6,
from include/linux/sched.h:12,
from include/linux/uaccess.h:5,
from arch/x86/mm/extable.c:3:
include/linux/bitmap.h: In function 'bitmap_get_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bitmap.h: In function 'bitmap_set_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
arch/x86/mm/extable.c: At top level:
arch/x86/mm/extable.c:26:16: warning: no previous prototype for 'ex_handler_default' [-Wmissing-prototypes]
__visible bool ex_handler_default(const struct exception_table_entry *fixup,
^~~~~~~~~~~~~~~~~~
arch/x86/mm/extable.c:36:16: warning: no previous prototype for 'ex_handler_fault' [-Wmissing-prototypes]
__visible bool ex_handler_fault(const struct exception_table_entry *fixup,
^~~~~~~~~~~~~~~~
arch/x86/mm/extable.c:57:16: warning: no previous prototype for 'ex_handler_fprestore' [-Wmissing-prototypes]
__visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
^~~~~~~~~~~~~~~~~~~~
arch/x86/mm/extable.c:72:16: warning: no previous prototype for 'ex_handler_uaccess' [-Wmissing-prototypes]
__visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
^~~~~~~~~~~~~~~~~~
arch/x86/mm/extable.c:83:16: warning: no previous prototype for 'ex_handler_rdmsr_unsafe' [-Wmissing-prototypes]
__visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
^~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/extable.c:100:16: warning: no previous prototype for 'ex_handler_wrmsr_unsafe' [-Wmissing-prototypes]
__visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
^~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/extable.c:116:16: warning: no previous prototype for 'ex_handler_clear_fs' [-Wmissing-prototypes]
__visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
^~~~~~~~~~~~~~~~~~~
--
In file included from include/linux/bits.h:23:0,
from include/linux/bitops.h:5,
from include/linux/kernel.h:12,
from include/asm-generic/bug.h:19,
from arch/x86/include/asm/bug.h:83,
from include/linux/bug.h:5,
from include/linux/mmdebug.h:5,
from include/linux/mm.h:9,
from arch/x86/mm/mmap.c:15:
include/linux/bitmap.h: In function 'bitmap_get_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
>> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
return (map[index] >> offset) & GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bitmap.h: In function 'bitmap_set_value':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
__builtin_constant_p((l) > (h)), (l) > (h), 0)))
^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
^~~~~~~~~~~~~~~~~~~
include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
value &= GENMASK(nbits - 1, 0);
^~~~~~~
arch/x86/mm/mmap.c: At top level:
arch/x86/mm/mmap.c:75:15: warning: no previous prototype for 'arch_mmap_rnd' [-Wmissing-prototypes]
unsigned long arch_mmap_rnd(void)
^~~~~~~~~~~~~
arch/x86/mm/mmap.c:216:5: warning: no previous prototype for 'valid_phys_addr_range' [-Wmissing-prototypes]
int valid_phys_addr_range(phys_addr_t addr, size_t count)
^~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/mmap.c:222:5: warning: no previous prototype for 'valid_mmap_phys_addr_range' [-Wmissing-prototypes]
int valid_mmap_phys_addr_range(unsigned long pfn, size_t count)
^~~~~~~~~~~~~~~~~~~~~~~~~~
..

vim +/GENMASK +590 include/linux/bitmap.h

   569	
   570	/**
   571	 * bitmap_get_value - get a value of n-bits from the memory region
   572	 * @map: address to the bitmap memory region
   573	 * @start: bit offset of the n-bit value
   574	 * @nbits: size of value in bits
   575	 *
   576	 * Returns value of nbits located at the @start bit offset within the @map
   577	 * memory region.
   578	 */
   579	static inline unsigned long bitmap_get_value(const unsigned long *map,
   580						      unsigned long start,
   581						      unsigned long nbits)
   582	{
   583		const size_t index = BIT_WORD(start);
   584		const unsigned long offset = start % BITS_PER_LONG;
   585		const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
   586		const unsigned long space = ceiling - start;
   587		unsigned long value_low, value_high;
   588	
   589		if (space >= nbits)
 > 590			return (map[index] >> offset) & GENMASK(nbits - 1, 0);
   591		else {
   592			value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
   593			value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
   594			return (value_low >> offset) | (value_high << space);
   595		}
   596	}
   597	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--GvXjxJ+pjyke8COw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
X0U1Qq82aAAA

--GvXjxJ+pjyke8COw--
