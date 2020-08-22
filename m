Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C54124E5D8
	for <lists+linux-arch@lfdr.de>; Sat, 22 Aug 2020 08:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgHVGTn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Aug 2020 02:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHVGTm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Aug 2020 02:19:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D11EC061573;
        Fri, 21 Aug 2020 23:19:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so1862050plp.4;
        Fri, 21 Aug 2020 23:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=PblRPEGAT0C+6tOsDi0KRY1ArJHFg2XN9AI1EkGg0K8=;
        b=rtF1ldy5so/nzQ8/SPLedGY3zQ40t0XoYPZSE6Ytcf6nmz32/q9iIktTSMznTDmqiK
         aRY6bRROqtZ4QGf3eZ5OADvUu4ZopGs8W8pszhj94nUgdOCUG6nfpLKsTKtLe3iAqFTW
         YEkbXdewtmUmfmMpOk0JY02r9ib8znFEMX0zGnCyuH0wYxZtox6qJ4ZP4eRzvC6bx3Oe
         FR1K62CDgaEc0k0o5iA9W98zxinU/aZTNoRAqq/rAkbSEaJ08I+7AbWGjzCWneMBa0mn
         P5MbtNKE9GleFmZ+UVWmMSpJhn/keCluwjqHtE1LrbD4wF9aMV8yPBmD1QFYTUpozuTX
         U1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=PblRPEGAT0C+6tOsDi0KRY1ArJHFg2XN9AI1EkGg0K8=;
        b=dXv9QtxtGEIRbijHOh3aIB7DuxCDvrIbJ6gZu+gn674iZ68gDZtfmYRlZipbjCbuP1
         U00QN3gHd2Mv2ct923l0l0tfDd/KN+g8rN4tEr3SojRv30igTqfMyCxC4OUZgp/QyYLw
         yBHld9nkts9ZPU9ErU9BKwffZ16kCNamT0JwO2DWQ/LV3tec6nlxqElh9cM9pWjjtex5
         MrqUMd8FrqDF7BT8d2tiVKInmxr+jB0h4P9Jyy3qZ0mMctwQgFA1zNWol2sTYl78v+kZ
         9sbmM86lKDHkxyNkRX68DiqXkFUE6GFYafBQs5n9rJddUaV/OYwekqh2pH9f0tPpeYfD
         UYqw==
X-Gm-Message-State: AOAM531ySgClYB8MVQ0d1pJ9tyxbzQUV6JPoLch5RK/r4YmGcQU8Bm0b
        SMylVNno91+x/7FH/gQ+q/k=
X-Google-Smtp-Source: ABdhPJxzKfvPimC5XsjK1SiY4pVEhFXl/uaO+fM2LDcxVLAeKHgpOzZoOIrDChRrA+uZfYrczeCWuQ==
X-Received: by 2002:a17:902:301:: with SMTP id 1mr5189010pld.198.1598077180882;
        Fri, 21 Aug 2020 23:19:40 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id g129sm4485554pfb.33.2020.08.21.23.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 23:19:40 -0700 (PDT)
Date:   Sat, 22 Aug 2020 16:19:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [mm] 8e63b8bbd7: WARNING:at_mm/memory.c:#__apply_to_page_range
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>, lkp@lists.01.org
References: <20200821232401.GO18179@shao2-debian>
In-Reply-To: <20200821232401.GO18179@shao2-debian>
MIME-Version: 1.0
Message-Id: <1598077021.bqkt40qgqa.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from kernel test robot's message of August 22, 2020 9:24 am:
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-9):
>=20
> commit: 8e63b8bbd7d17f64ced151cebd151a2cd9f63c64 ("[PATCH v5 2/8] mm: app=
ly_to_pte_range warn and fail if a large pte is encountered")
> url: https://github.com/0day-ci/linux/commits/Nicholas-Piggin/huge-vmallo=
c-mappings/20200821-124543
> base: https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git next
>=20
> in testcase: boot
>=20
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 8G
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
> +-----------------------------------------------+------------+-----------=
-+
> |                                               | 185311995a | 8e63b8bbd7=
 |
> +-----------------------------------------------+------------+-----------=
-+
> | boot_successes                                | 4          | 0         =
 |
> | boot_failures                                 | 0          | 4         =
 |
> | WARNING:at_mm/memory.c:#__apply_to_page_range | 0          | 4         =
 |
> | RIP:__apply_to_page_range                     | 0          | 4         =
 |
> +-----------------------------------------------+------------+-----------=
-+
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> [    0.786159] WARNING: CPU: 0 PID: 0 at mm/memory.c:2269 __apply_to_page=
_range+0x537/0x9c0

Hmm, I wonder if that's WARN_ON_ONCE(pmd_bad(*pmd))), which would be
odd. I don't know x86 asm well enough to see what the *pmd value would
be there.

I'll try to reproduce and work out what's going on.

Thanks,
Nick

=09
> [    0.786675] Modules linked in:
> [    0.786888] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc1-00002-=
g8e63b8bbd7d17f #2
> [    0.787402] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.12.0-1 04/01/2014
> [    0.787935] RIP: 0010:__apply_to_page_range+0x537/0x9c0
> [    0.788280] Code: 8b 5c 24 50 48 39 5c 24 38 0f 84 6b 03 00 00 4c 8b 7=
4 24 38 e9 63 fb ff ff 84 d2 0f 84 ba 01 00 00 48 8b 1c 24 e9 3c fe ff ff <=
0f> 0b 45 84 ed 0f 84 08 01 00 00 48 89 ef e8 8f 8f 02 00 48 89 e8
> [    0.789467] RSP: 0000:ffffffff83e079d0 EFLAGS: 00010293
> [    0.789805] RAX: 0000000000000000 RBX: fffff52000001000 RCX: 000ffffff=
fe00000
> [    0.790260] RDX: 0000000000000000 RSI: 000ffffffffff000 RDI: 000000000=
0000000
> [    0.790724] RBP: ffff888107408000 R08: 0000000000000001 R09: 000000010=
7408000
> [    0.791179] R10: ffffffff840dcb5b R11: fffffbfff081b96b R12: fffff5200=
01fffff
> [    0.791634] R13: 0000000000000001 R14: fffff52000000000 R15: dffffc000=
0000000
> [    0.792090] FS:  0000000000000000(0000) GS:ffff8881eae00000(0000) knlG=
S:0000000000000000
> [    0.792607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.792977] CR2: ffff88823ffff000 CR3: 0000000003e14000 CR4: 000000000=
00406b0
> [    0.793433] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [    0.793889] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [    0.794344] Call Trace:
> [    0.794517]  ? memset+0x40/0x40
> [    0.794745]  alloc_vmap_area+0x7a9/0x2280
> [    0.795054]  ? trace_hardirqs_on+0x4f/0x2e0
> [    0.795354]  ? _raw_spin_unlock_irqrestore+0x39/0x60
> [    0.795682]  ? free_vmap_area+0x1a20/0x1a20
> [    0.795959]  ? __kasan_kmalloc+0xbf/0xe0
> [    0.796292]  __get_vm_area_node+0xd1/0x300
> [    0.796605]  get_vm_area_caller+0x2d/0x40
> [    0.796872]  ? acpi_os_map_iomem+0x3c3/0x4e0
> [    0.797155]  __ioremap_caller+0x1d8/0x480
> [    0.797486]  ? acpi_os_map_iomem+0x3c3/0x4e0
> [    0.797770]  ? iounmap+0x160/0x160
> [    0.798002]  ? __kasan_kmalloc+0xbf/0xe0
> [    0.798335]  acpi_os_map_iomem+0x3c3/0x4e0
> [    0.798612]  acpi_tb_acquire_table+0xb3/0x1c5
> [    0.798910]  acpi_tb_validate_table+0x68/0xbf
> [    0.799199]  acpi_tb_verify_temp_table+0xa1/0x640
> [    0.799512]  ? __down_trylock_console_sem+0x7a/0xa0
> [    0.799833]  ? acpi_tb_validate_temp_table+0x9d/0x9d
> [    0.800159]  ? acpi_ut_init_stack_ptr_trace+0xaa/0xaa
> [    0.800490]  ? vprintk_emit+0x10b/0x2a0
> [    0.800748]  ? acpi_ut_acquire_mutex+0x1d7/0x32f
> [    0.801056]  acpi_reallocate_root_table+0x339/0x385
> [    0.801377]  ? acpi_tb_parse_root_table+0x5a5/0x5a5
> [    0.801700]  ? dmi_matches+0xc6/0x120
> [    0.801968]  acpi_early_init+0x116/0x3ae
> [    0.802230]  start_kernel+0x2f7/0x39f
> [    0.802477]  secondary_startup_64+0xa4/0xb0
> [    0.802770] irq event stamp: 5137
> [    0.802992] hardirqs last  enabled at (5145): [<ffffffff81295652>] con=
sole_unlock+0x632/0xa00
> [    0.803539] hardirqs last disabled at (5152): [<ffffffff81295100>] con=
sole_unlock+0xe0/0xa00
> [    0.804082] softirqs last  enabled at (4430): [<ffffffff81b5152f>] irq=
_read_recursion_soft_321+0xcf/0x160
> [    0.804694] softirqs last disabled at (4428): [<ffffffff81b5152f>] irq=
_read_recursion_soft_321+0xcf/0x160
> [    0.805311] ---[ end trace 1234c082d7e7fd6f ]---
>=20
>=20
> To reproduce:
>=20
>         # build kernel
> 	cd linux
> 	cp config-5.9.0-rc1-00002-g8e63b8bbd7d17f .config
> 	make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Dx86_64 olddefconfig prepare module=
s_prepare bzImage
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in =
this email
>=20
>=20
>=20
> Thanks,
> lkp
>=20
>=20
