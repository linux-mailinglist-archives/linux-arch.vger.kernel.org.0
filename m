Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDAE1E8648
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgE2SIf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2SIe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 14:08:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09494C03E969;
        Fri, 29 May 2020 11:08:34 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y5so265567iob.12;
        Fri, 29 May 2020 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBxonZa+a8HmmqoaxQG5prp/pzcmielzsXGIvHjMUO4=;
        b=hjbljFC2rIeHgx3mx8WI8CBoGWJ/0fGPTD1Z6Bcp8+joYwROpRpoZC7kg1vgqB1r64
         1jQ/OR7fecgfKR45zGnef2172YV/LQ/E/De6dbaIClgDKC3PZVdYRaIAmGE6kAIskCSV
         2iT+zAA5+56ZPCYaY8BeRDNxYg8k/909K3eNYx6WoLdp0yKZKk/LgeKX3HGfKEyLnZs5
         hJEgAGMSYJ+wJ9ChBcbP14Kj7E6xGKn4LRBM/HzqGsKTV/tgfzMQdsqsvFea5gbDSNgL
         qqTo0ur8BFOOhmaqUBHtmToUD6GirqeHpGLty4f/v2dNox+jL0FtthOI5dkBey+XOSTH
         oeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBxonZa+a8HmmqoaxQG5prp/pzcmielzsXGIvHjMUO4=;
        b=ZKzC38nfEKOyPfLvg+PU4GEUcJrMhWF/8/dsXXy8mwoM8of53t6D3b5kCGt3pHKrEZ
         nxHSvS4w48eU76iUdYikaTZc+y3iyRp3AJ/2skNOVsCduHF75nNfSSlM8fSnvCDZnG4P
         Ns8SkA1bSuhp5u0g40XxpAgWfTaWMh/+x/JqZfHtPjT75rgahsrwPRbNLzaG4DZ6DqPS
         8dSDgpWPM0Sa97MqB4vEtO+hjfwtgEHQGuW7PdLsxxYr35M843nbyC6CnKnFmc6saPLV
         xlx+N3SwuF4VVT51DlU2jHE2HBISkW5Byye5EK2usQbj0fL4ubXrZHYx6+pJnov/Q0MS
         XSLg==
X-Gm-Message-State: AOAM531x2VR0zOa+VGScK3Yy2Rg4uw50/OVMemzq5ezuBvsCtMXdeu1c
        MDERVjjIInyZ4ISCZMgzm1utUgvJxPI1wi1pMq8=
X-Google-Smtp-Source: ABdhPJxYhP52S4YjP1Ba85IxT8NKbgpo5mj8GIn7+bVmjcb468m4nhIi87Sf62JOz5BOm6G+ODCQMeYBeXeoTPTXrh8=
X-Received: by 2002:a05:6638:54:: with SMTP id a20mr6357708jap.3.1590775713182;
 Fri, 29 May 2020 11:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com>
In-Reply-To: <202005242236.NtfLt1Ae%lkp@intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 29 May 2020 23:38:18 +0530
Message-ID: <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     kbuild test robot <lkp@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Syed,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce]
>
> url:    https://github.com/0day-ci/linux/commits/Syed-Nayyar-Waris/Introduce-the-for_each_set_clump-macro/20200524-130931
> base:    b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build):
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> In file included from include/asm-generic/atomic-instrumented.h:20:0,
> from arch/x86/include/asm/atomic.h:265,
> from include/linux/atomic.h:7,
> from include/linux/crypto.h:15,
> from arch/x86/kernel/asm-offsets.c:9:
> include/linux/bitmap.h: In function 'bitmap_get_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bitmap.h: In function 'bitmap_set_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> --
> In file included from include/linux/bits.h:23:0,
> from include/linux/bitops.h:5,
> from include/linux/kernel.h:12,
> from include/asm-generic/bug.h:19,
> from arch/x86/include/asm/bug.h:83,
> from include/linux/bug.h:5,
> from include/linux/mmdebug.h:5,
> from include/linux/gfp.h:5,
> from arch/x86/mm/init.c:1:
> include/linux/bitmap.h: In function 'bitmap_get_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bitmap.h: In function 'bitmap_set_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> arch/x86/mm/init.c: At top level:
> arch/x86/mm/init.c:469:21: warning: no previous prototype for 'init_memory_mapping' [-Wmissing-prototypes]
> unsigned long __ref init_memory_mapping(unsigned long start,
> ^~~~~~~~~~~~~~~~~~~
> arch/x86/mm/init.c:711:13: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
> void __init poking_init(void)
> ^~~~~~~~~~~
> arch/x86/mm/init.c:860:13: warning: no previous prototype for 'mem_encrypt_free_decrypted_mem' [-Wmissing-prototypes]
> void __weak mem_encrypt_free_decrypted_mem(void) { }
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
> In file included from include/linux/bits.h:23:0,
> from include/linux/bitops.h:5,
> from include/linux/kernel.h:12,
> from include/asm-generic/bug.h:19,
> from arch/x86/include/asm/bug.h:83,
> from include/linux/bug.h:5,
> from include/linux/mmdebug.h:5,
> from include/linux/mm.h:9,
> from include/linux/memblock.h:13,
> from arch/x86/mm/ioremap.c:10:
> include/linux/bitmap.h: In function 'bitmap_get_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bitmap.h: In function 'bitmap_set_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> arch/x86/mm/ioremap.c: At top level:
> arch/x86/mm/ioremap.c:484:12: warning: no previous prototype for 'arch_ioremap_p4d_supported' [-Wmissing-prototypes]
> int __init arch_ioremap_p4d_supported(void)
> ^~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/ioremap.c:489:12: warning: no previous prototype for 'arch_ioremap_pud_supported' [-Wmissing-prototypes]
> int __init arch_ioremap_pud_supported(void)
> ^~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/ioremap.c:498:12: warning: no previous prototype for 'arch_ioremap_pmd_supported' [-Wmissing-prototypes]
> int __init arch_ioremap_pmd_supported(void)
> ^~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/ioremap.c:737:17: warning: no previous prototype for 'early_memremap_pgprot_adjust' [-Wmissing-prototypes]
> pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
> In file included from include/linux/bits.h:23:0,
> from include/linux/bitops.h:5,
> from include/linux/kernel.h:12,
> from arch/x86/include/asm/percpu.h:45,
> from arch/x86/include/asm/current.h:6,
> from include/linux/sched.h:12,
> from include/linux/uaccess.h:5,
> from arch/x86/mm/extable.c:3:
> include/linux/bitmap.h: In function 'bitmap_get_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bitmap.h: In function 'bitmap_set_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> arch/x86/mm/extable.c: At top level:
> arch/x86/mm/extable.c:26:16: warning: no previous prototype for 'ex_handler_default' [-Wmissing-prototypes]
> __visible bool ex_handler_default(const struct exception_table_entry *fixup,
> ^~~~~~~~~~~~~~~~~~
> arch/x86/mm/extable.c:36:16: warning: no previous prototype for 'ex_handler_fault' [-Wmissing-prototypes]
> __visible bool ex_handler_fault(const struct exception_table_entry *fixup,
> ^~~~~~~~~~~~~~~~
> arch/x86/mm/extable.c:57:16: warning: no previous prototype for 'ex_handler_fprestore' [-Wmissing-prototypes]
> __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
> ^~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/extable.c:72:16: warning: no previous prototype for 'ex_handler_uaccess' [-Wmissing-prototypes]
> __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
> ^~~~~~~~~~~~~~~~~~
> arch/x86/mm/extable.c:83:16: warning: no previous prototype for 'ex_handler_rdmsr_unsafe' [-Wmissing-prototypes]
> __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
> ^~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/extable.c:100:16: warning: no previous prototype for 'ex_handler_wrmsr_unsafe' [-Wmissing-prototypes]
> __visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
> ^~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/extable.c:116:16: warning: no previous prototype for 'ex_handler_clear_fs' [-Wmissing-prototypes]
> __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
> ^~~~~~~~~~~~~~~~~~~
> --
> In file included from include/linux/bits.h:23:0,
> from include/linux/bitops.h:5,
> from include/linux/kernel.h:12,
> from include/asm-generic/bug.h:19,
> from arch/x86/include/asm/bug.h:83,
> from include/linux/bug.h:5,
> from include/linux/mmdebug.h:5,
> from include/linux/mm.h:9,
> from arch/x86/mm/mmap.c:15:
> include/linux/bitmap.h: In function 'bitmap_get_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> >> include/linux/bitmap.h:590:35: note: in expansion of macro 'GENMASK'
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bitmap.h: In function 'bitmap_set_value':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> ^~~~~~~~~~~~~~~~~~~
> include/linux/bitmap.h:630:11: note: in expansion of macro 'GENMASK'
> value &= GENMASK(nbits - 1, 0);
> ^~~~~~~
> arch/x86/mm/mmap.c: At top level:
> arch/x86/mm/mmap.c:75:15: warning: no previous prototype for 'arch_mmap_rnd' [-Wmissing-prototypes]
> unsigned long arch_mmap_rnd(void)
> ^~~~~~~~~~~~~
> arch/x86/mm/mmap.c:216:5: warning: no previous prototype for 'valid_phys_addr_range' [-Wmissing-prototypes]
> int valid_phys_addr_range(phys_addr_t addr, size_t count)
> ^~~~~~~~~~~~~~~~~~~~~
> arch/x86/mm/mmap.c:222:5: warning: no previous prototype for 'valid_mmap_phys_addr_range' [-Wmissing-prototypes]
> int valid_mmap_phys_addr_range(unsigned long pfn, size_t count)
> ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ..
>
> vim +/GENMASK +590 include/linux/bitmap.h
>
>    569
>    570  /**
>    571   * bitmap_get_value - get a value of n-bits from the memory region
>    572   * @map: address to the bitmap memory region
>    573   * @start: bit offset of the n-bit value
>    574   * @nbits: size of value in bits
>    575   *
>    576   * Returns value of nbits located at the @start bit offset within the @map
>    577   * memory region.
>    578   */
>    579  static inline unsigned long bitmap_get_value(const unsigned long *map,
>    580                                                unsigned long start,
>    581                                                unsigned long nbits)
>    582  {
>    583          const size_t index = BIT_WORD(start);
>    584          const unsigned long offset = start % BITS_PER_LONG;
>    585          const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
>    586          const unsigned long space = ceiling - start;
>    587          unsigned long value_low, value_high;
>    588
>    589          if (space >= nbits)
>  > 590                  return (map[index] >> offset) & GENMASK(nbits - 1, 0);
>    591          else {
>    592                  value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
>    593                  value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
>    594                  return (value_low >> offset) | (value_high << space);
>    595          }
>    596  }
>    597
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Hi William, Andy and All,

Regarding the above compilation warnings. All the warnings are because
of GENMASK usage in my patch.
The warnings are coming because of sanity checks present for 'GENMASK'
macro in include/linux/bits.h.

Taking the example statement (in my patch) where compilation warning
is getting reported:
return (map[index] >> offset) & GENMASK(nbits - 1, 0);

'nbits' is of type 'unsigned long'.
In above, the sanity check is comparing '0' with unsigned value. And
unsigned value can't be less than '0' ever, hence the warning.
But this warning will occur whenever there will be '0' as one of the
'argument' and an unsigned variable as another 'argument' for GENMASK.

This warning is getting cleared if I cast the 'nbits' to 'long'.

Let me know if I should submit a next patch with the casts applied.
What do you guys think?

Regards
Syed Nayyar Waris
