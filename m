Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2130B83A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 08:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhBBHDA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 02:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhBBHCx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 02:02:53 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E46C06174A;
        Mon,  1 Feb 2021 23:02:12 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y19so20238774iov.2;
        Mon, 01 Feb 2021 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/vE6H9tBdWiMXkK4UDJQ/N6ntssNpMzghYvjYaKGYw=;
        b=CKYQ6M0wBup+qmYTdCUvStzwLWWYDi/x5pBXia/lAE22sm08rdQ9YHjIshbhtrwMSa
         3hNzAF6z0NYikzyOl/M5FkT2Kb+MRXGa9YgYc48YTFeVOexdOmQxlLQLyLaTtI4Zqduv
         cv4FVxPKOms6H6zf6JhgN0WdrErteav2HLkVPfzzErkVHzo1fvRzq6v9cjN/l33DimFo
         lMy41GgN55FupmUBzS4Vf6X4LPFXVoBwH2zGB2TQAAiXX1P/tBejDkS5F2vTV23Y+O2q
         9tin5F4r0no2qxijuozsSXdiS6+w0oI7RPGipGSoE8nphDoiiAiBs9XPJHztHRyJZQOQ
         t6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/vE6H9tBdWiMXkK4UDJQ/N6ntssNpMzghYvjYaKGYw=;
        b=do4w+DO40ZOOnD8y3Q96WYxJTT5YhoDpEXoU8rAmzWe4NghxYRh5IJTkVGs2jNn4uL
         4zr2lTTDkmNyFDUqgWhvRb46rO1opNCTozjla8j26ZmF+IE7QbTy3gu5LMxr5qEbCC+h
         GFaSw1JHocV1ttPrNBQXmXGppnj1/hYXoWGoWW4xV771zjwwkRlL0kaY+wFwfJK4D78U
         3hlI+x+7nFSKLxRqHONdzTi/K1BgETDv5DsYNJxTwn96pOPK+2zve3hn4rgmH/e2zCL4
         ytwUL3wQogYwSlxoojsYASDuQedC2mApSkLeoy7qN0IFkO7/kcf0UugOM5oVVgI4IbYf
         fY9Q==
X-Gm-Message-State: AOAM530/DcoCQQn0vesNxJO8ZM7Q3PaJQR3TCxzgYiPBbxPfK2Z/CIv4
        g778FlKTpKFluOqqOvk18bdcqDW7XI25jX4JtYI=
X-Google-Smtp-Source: ABdhPJxL69rtdMAx/+UALNBu9r0iXKUyf0tOm35xvqAgELcQWDHyRFMFTzCRjAQVm0Re54HeC/16HviXr0g9elgd5Hs=
X-Received: by 2002:a6b:d804:: with SMTP id y4mr14707920iob.141.1612249331923;
 Mon, 01 Feb 2021 23:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20210130191719.7085-1-yury.norov@gmail.com> <20210130191719.7085-8-yury.norov@gmail.com>
 <YBgG35UTDLpVSYWV@smile.fi.intel.com> <e9c66d506a614a7e95d039bea325c241@AcuMS.aculab.com>
 <YBgqwwrfWqU8wx+s@smile.fi.intel.com>
In-Reply-To: <YBgqwwrfWqU8wx+s@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 1 Feb 2021 23:02:00 -0800
Message-ID: <CAAH8bW-Cm9MSkicAwbY3qYzLaYi6jbqx96zdb_pVi6L8dFtnWQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] lib: add fast path for find_next_*_bit()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[ CC Alexey Klimov, andRasmus Villemoes as they also may be interested ]

On Mon, Feb 1, 2021 at 8:22 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Feb 01, 2021 at 04:02:30PM +0000, David Laight wrote:
> > From: Andy Shevchenko
> > > Sent: 01 February 2021 13:49
> > > On Sat, Jan 30, 2021 at 11:17:18AM -0800, Yury Norov wrote:
> > > > Similarly to bitmap functions, find_next_*_bit() users will benefit
> > > > if we'll handle a case of bitmaps that fit into a single word. In the
> > > > very best case, the compiler may replace a function call with a
> > > > single ffs or ffz instruction.
> > >
> > > Would be nice to have the examples how it reduces the actual code size (based
> > > on the existing code in kernel, especially in widely used frameworks /
> > > subsystems, like PCI).
>>
> > I bet it makes the kernel bigger but very slightly faster.
> > But the fact that the wrappers end up in the i-cache may
> > mean that inlining actually makes it slower for some calling
> > sequences.
>
> > If a bitmap fits in a single word (as a compile-time constant)
> > then you should (probably) be using different functions if
> > you care about performance.
>
> Isn't this patch series exactly about it?

Probably, David meant something like find_first_bit_fast_path().
Not sure that this approach would be better than pure inlining.

Addressing questions above.

My arm64 build for qemu:
Before:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .head.text    00010000  ffff800010000000  ffff800010000000  00010000  2**16
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .text         011603a8  ffff800010010000  ffff800010010000  00020000  2**16
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .got.plt      00000018  ffff8000111703a8  ffff8000111703a8  011803a8  2**3
                  CONTENTS, ALLOC, LOAD, DATA
  3 .rodata       007a29b2  ffff800011180000  ffff800011180000  01190000  2**12
                  CONTENTS, ALLOC, LOAD, DATA
  4 .pci_fixup    000025f0  ffff8000119229c0  ffff8000119229c0  019329c0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 __ksymtab     000100d4  ffff800011924fb0  ffff800011924fb0  01934fb0  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 __ksymtab_gpl 000147cc  ffff800011935084  ffff800011935084  01945084  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 __ksymtab_strings 0003b0be  ffff800011949850  ffff800011949850
01959850  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  8 __param       00003e58  ffff800011984910  ffff800011984910  01994910  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  9 __modver      00000678  ffff800011988768  ffff800011988768  01998768  2**3
                  CONTENTS, ALLOC, LOAD, DATA
 10 __ex_table    00002270  ffff800011988de0  ffff800011988de0  01998de0  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 11 .notes        0000003c  ffff80001198b050  ffff80001198b050  0199b050  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 12 .init.text    0007b09c  ffff8000119a0000  ffff8000119a0000  019a0000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 13 .exit.text    00004120  ffff800011a1b09c  ffff800011a1b09c  01a1b09c  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
...

After:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .head.text    00010000  ffff800010000000  ffff800010000000  00010000  2**16
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .text         011613a8  ffff800010010000  ffff800010010000  00020000  2**16
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .got.plt      00000018  ffff8000111713a8  ffff8000111713a8  011813a8  2**3
                  CONTENTS, ALLOC, LOAD, DATA
  3 .rodata       007a26b2  ffff800011180000  ffff800011180000  01190000  2**12
                  CONTENTS, ALLOC, LOAD, DATA
  4 .pci_fixup    000025f0  ffff8000119226c0  ffff8000119226c0  019326c0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 __ksymtab     000100bc  ffff800011924cb0  ffff800011924cb0  01934cb0  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 __ksymtab_gpl 000147cc  ffff800011934d6c  ffff800011934d6c  01944d6c  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 __ksymtab_strings 0003b09b  ffff800011949538  ffff800011949538
01959538  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  8 __param       00003e58  ffff8000119845d8  ffff8000119845d8  019945d8  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  9 __modver      00000678  ffff800011988430  ffff800011988430  01998430  2**3
                  CONTENTS, ALLOC, LOAD, DATA
 10 __ex_table    00002270  ffff800011988aa8  ffff800011988aa8  01998aa8  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 11 .notes        0000003c  ffff80001198ad18  ffff80001198ad18  0199ad18  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 12 .init.text    0007b1a8  ffff8000119a0000  ffff8000119a0000  019a0000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 13 .exit.text    00004120  ffff800011a1b1a8  ffff800011a1b1a8  01a1b1a8  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE

The size of  .text is increased by 0x1000 bytes, or 0.02%
The size of .rodata is decreased by 0x300 bytes, or 0.06%
The size of  __ksymtab is decreased by 24 bytes, or 0.018%

So the cost of this fast path is ~3.3K.

Regarding code generation, this is the quite typical find_bit() user:

unsigned int cpumask_next(int n, const struct cpumask *srcp)
{
        /* -1 is a legal arg here. */
        if (n != -1)
                cpumask_check(n);
        return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
}
EXPORT_SYMBOL(cpumask_next);

Before:
0000000000000000 <cpumask_next>:
   0:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
   4:   11000402        add     w2, w0, #0x1
   8:   aa0103e0        mov     x0, x1
   c:   d2800401        mov     x1, #0x40                       // #64
  10:   910003fd        mov     x29, sp
  14:   93407c42        sxtw    x2, w2
  18:   94000000        bl      0 <find_next_bit>
  1c:   a8c17bfd        ldp     x29, x30, [sp], #16
  20:   d65f03c0        ret
  24:   d503201f        nop

After:
0000000000000140 <cpumask_next>:
 140:   11000400        add     w0, w0, #0x1
 144:   93407c00        sxtw    x0, w0
 148:   f100fc1f        cmp     x0, #0x3f
 14c:   54000168        b.hi    178 <cpumask_next+0x38>  // b.pmore
 150:   f9400023        ldr     x3, [x1]
 154:   92800001        mov     x1, #0xffffffffffffffff         // #-1
 158:   9ac02020        lsl     x0, x1, x0
 15c:   52800802        mov     w2, #0x40                       // #64
 160:   8a030001        and     x1, x0, x3
 164:   dac00020        rbit    x0, x1
 168:   f100003f        cmp     x1, #0x0
 16c:   dac01000        clz     x0, x0
 170:   1a800040        csel    w0, w2, w0, eq  // eq = none
 174:   d65f03c0        ret
 178:   52800800        mov     w0, #0x40                       // #64
 17c:   d65f03c0        ret

find_next_bit() call is removed with the cost of 6 instructions.
(And I suspect we can improve the GENMASK() for better code generation.)
find_next_bit() itself is 41 instructions, so I believe this fast path
would bring
value for many users.

On the other hand, if someone is limited with I-cache and wants to avoid
generating fast paths, I think it's worth to make SMALL_CONST() configurable,
which would also disable fast paths in lib/bitmap.c. We may rely on -Os flag, or
enable fast path in config explicitly:

diff --git a/include/asm-generic/bitsperlong.h
b/include/asm-generic/bitsperlong.h
index 0eeb77544f1d..209e531074c1 100644
--- a/include/asm-generic/bitsperlong.h
+++ b/include/asm-generic/bitsperlong.h
@@ -23,6 +23,10 @@
 #define BITS_PER_LONG_LONG 64
 #endif

+#ifdef CONFIG_FAST_PATH
 #define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n)
< BITS_PER_LONG)
+#else
+#define SMALL_CONST(n) (0)
+#endif

 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/lib/Kconfig b/lib/Kconfig
index a38cc61256f1..c9629b3ebce8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -39,6 +39,14 @@ config PACKING

          When in doubt, say N.

+config FAST_PATH
+       bool "Enable fast path code generation"
+       default y
+       help
+         This option enables fast path optimization with the cost
+         of increasing the text section.
+
 config BITREVERSE
        tristate

> With Best Regards,
> Andy Shevchenko
