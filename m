Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E62E11C58E
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 06:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLLFmW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 00:42:22 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41907 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfLLFmW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 00:42:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47YN3W5hTfz9sPL;
        Thu, 12 Dec 2019 16:42:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1576129338;
        bh=O++zJuVq/umtcNrYXf5LhasAFc6eMDvjl5VA+AjA2+I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nOpPdrjPzPCDNQrHjnZ7q2qw7WWDHHNICSgRUrjZBFxCHxoi5qb+ZFkLrI2Sv6kBm
         tyNhlMWLzGjL3RJ8jzNTLnFNOejZeyORlNsX2fYynbewuk9iwNzdjkFFNWWXrQF38F
         TQWScHI4JaWHJsRP/pCx2PqIttsAEszJ8wzmhua80EuYYRwFOMZIcqc8v2offuMCJy
         vwSay/WBom0mokybMVtsMzjFD8hEU3GE5LodA5sTiwAh3tzRFbgajTrwUOMvXtWvjF
         EuFRlyOhMv6DPKziq4bOpsHe96F3euxVzqEq46kpW8oe8ZdFVvtCQ399L3B0q1iFx9
         wKCIfGudgJ7wA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@c-s.fr, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
In-Reply-To: <20191206131650.GM2827@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
Date:   Thu, 12 Dec 2019 16:42:13 +1100
Message-ID: <875zimp0ay.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[ trimmed CC a bit ]

Peter Zijlstra <peterz@infradead.org> writes:
> On Fri, Dec 06, 2019 at 11:46:11PM +1100, Michael Ellerman wrote:
...
> you write:
>
>   "Currently bitops-instrumented.h assumes that the architecture provides
> atomic, non-atomic and locking bitops (e.g. both set_bit and __set_bit).
> This is true on x86 and s390, but is not always true: there is a
> generic bitops/non-atomic.h header that provides generic non-atomic
> operations, and also a generic bitops/lock.h for locking operations."
>
> Is there any actual benefit for PPC to using their own atomic bitops
> over bitops/lock.h ? I'm thinking that the generic code is fairly
> optimal for most LL/SC architectures.

Yes and no :)

Some of the generic versions don't generate good code compared to our
versions, but that's because READ_ONCE() is triggering stack protector
to be enabled.

For example, comparing an out-of-line copy of the generic and ppc
versions of test_and_set_bit_lock():

   1 <generic_test_and_set_bit_lock>:           1 <ppc_test_and_set_bit_lock>:
   2         addis   r2,r12,361
   3         addi    r2,r2,-4240
   4         stdu    r1,-48(r1)
   5         rlwinm  r8,r3,29,3,28
   6         clrlwi  r10,r3,26                   2         rldicl  r10,r3,58,6
   7         ld      r9,3320(r13)
   8         std     r9,40(r1)
   9         li      r9,0
  10         li      r9,1                        3         li      r9,1
                                                 4         clrlwi  r3,r3,26
                                                 5         rldicr  r10,r10,3,60
  11         sld     r9,r9,r10                   6         sld     r3,r9,r3
  12         add     r10,r4,r8                   7         add     r4,r4,r10
  13         ldx     r8,r4,r8
  14         and.    r8,r9,r8
  15         bne     34f
  16         ldarx   r7,0,r10                    8         ldarx   r9,0,r4,1
  17         or      r8,r9,r7                    9         or      r10,r9,r3
  18         stdcx.  r8,0,r10                   10         stdcx.  r10,0,r4
  19         bne-    16b                        11         bne-    8b
  20         isync                              12         isync
  21         and     r9,r7,r9                   13         and     r3,r3,r9
  22         addic   r7,r9,-1                   14         addic   r9,r3,-1
  23         subfe   r7,r7,r9                   15         subfe   r3,r9,r3
  24         ld      r9,40(r1)
  25         ld      r10,3320(r13)
  26         xor.    r9,r9,r10
  27         li      r10,0
  28         mr      r3,r7
  29         bne     36f
  30         addi    r1,r1,48
  31         blr                                16         blr
  32         nop
  33         nop
  34         li      r7,1
  35         b       24b
  36         mflr    r0
  37         std     r0,64(r1)
  38         bl      <__stack_chk_fail+0x8>


If you squint, the generated code for the actual logic is pretty similar, but
the stack protector gunk makes a big mess. It's particularly bad here
because the ppc version doesn't even need a stack frame.

I've also confirmed that even when test_and_set_bit_lock() is inlined
into an actual call site the stack protector logic still triggers.

eg, if I make two versions of ext4_resize_begin() which call the generic or ppc
version of test_and_set_bit_lock(), the generic version gets a bunch of extra
stack protector code.

   1 c0000000005336e0 <ext4_resize_begin_generic>:           1 c0000000005335b0 <ext4_resize_begin_ppc>:
   2         addis   r2,r12,281                              2         addis   r2,r12,281
   3         addi    r2,r2,-12256                            3         addi    r2,r2,-11952
   4         mflr    r0                                      4         mflr    r0
   5         bl      <_mcount>                               5         bl      <_mcount>
   6         mflr    r0                                      6         mflr    r0
   7         std     r31,-8(r1)                              7         std     r31,-8(r1)
   8         std     r30,-16(r1)                             8         std     r30,-16(r1)
   9         mr      r31,r3                                  9         mr      r31,r3
  10         li      r3,24                                  10         li      r3,24
  11         std     r0,16(r1)                              11         std     r0,16(r1)
  12         stdu    r1,-128(r1)                            12         stdu    r1,-112(r1)
  13         ld      r9,3320(r13)
  14         std     r9,104(r1)
  15         li      r9,0
  16         ld      r30,920(r31)                           13         ld      r30,920(r31)
  17         bl      <capable+0x8>                          14         bl      <capable+0x8>
  18         nop                                            15         nop
  19         cmpdi   cr7,r3,0                               16         cmpdi   cr7,r3,0
  20         beq     cr7,<ext4_resize_begin_generic+0xf0>   17         beq     cr7,<ext4_resize_begin_ppc+0xc0>
  21         ld      r9,920(r31)                            18         ld      r9,920(r31)
  22         ld      r10,96(r30)                            19         ld      r10,96(r30)
  23         lwz     r7,84(r30)                             20         lwz     r7,84(r30)
  24         ld      r8,104(r9)                             21         ld      r8,104(r9)
  25         ld      r10,24(r10)                            22         ld      r10,24(r10)
  26         lwz     r8,20(r8)                              23         lwz     r8,20(r8)
  27         srd     r10,r10,r7                             24         srd     r10,r10,r7
  28         cmpd    cr7,r10,r8                             25         cmpd    cr7,r10,r8
  29         bne     cr7,<ext4_resize_begin_generic+0x128>  26         bne     cr7,<ext4_resize_begin_ppc+0xf8>
  30         lhz     r10,160(r9)                            27         lhz     r10,160(r9)
  31         andi.   r10,r10,2                              28         andi.   r10,r10,2
  32         bne     <ext4_resize_begin_generic+0x100>
  33         ld      r10,560(r9)
  34         andi.   r10,r10,1
  35         bne     <ext4_resize_begin_generic+0xe0>       29         bne     <ext4_resize_begin_ppc+0xd0>
  36         addi    r7,r9,560                              30         addi    r9,r9,560
  37         li      r8,1                                   31         li      r10,1
  38         ldarx   r10,0,r7                               32         ldarx   r3,0,r9,1
  39         or      r6,r8,r10                              33         or      r8,r3,r10
  40         stdcx.  r6,0,r7                                34         stdcx.  r8,0,r9
  41         bne-    <ext4_resize_begin_generic+0x90>       35         bne-    <ext4_resize_begin_ppc+0x78>
  42         isync                                          36         isync
                                                            37         clrldi  r3,r3,63
  43         andi.   r9,r10,1                               38         addi    r3,r3,-1
  44         li      r3,0                                   39         rlwinm  r3,r3,0,27,27
  45         bne     <ext4_resize_begin_generic+0xe0>       40         addi    r3,r3,-16
  46         ld      r9,104(r1)
  47         ld      r10,3320(r13)
  48         xor.    r9,r9,r10
  49         li      r10,0
  50         bne     <ext4_resize_begin_generic+0x158>
  51         addi    r1,r1,128                              41         addi    r1,r1,112
  52         ld      r0,16(r1)                              42         ld      r0,16(r1)
  53         ld      r30,-16(r1)                            43         ld      r30,-16(r1)
  54         ld      r31,-8(r1)                             44         ld      r31,-8(r1)
  55         mtlr    r0                                     45         mtlr    r0
  56         blr                                            46         blr
  57         nop                                            47         nop
  58         li      r3,-16
  59         b       <ext4_resize_begin_generic+0xb0>
  60         nop                                            48         nop
  61         nop                                            49         nop
  62         li      r3,-1                                  50         li      r3,-1
  63         b       <ext4_resize_begin_generic+0xb0>       51         b       <ext4_resize_begin_ppc+0x9c>
  64         nop                                            52         nop
  65         nop                                            53         nop
  66         addis   r6,r2,-118                             54         addis   r6,r2,-118
  67         addis   r4,r2,-140                             55         addis   r4,r2,-140
  68         mr      r3,r31                                 56         mr      r3,r31
  69         li      r5,97                                  57         li      r5,46
  70         addi    r6,r6,30288                            58         addi    r6,r6,30288
  71         addi    r4,r4,3064                             59         addi    r4,r4,3040
  72         bl      <__ext4_warning+0x8>                   60         bl      <__ext4_warning+0x8>
  73         nop                                            61         nop
  74         li      r3,-1                                  62         li      r3,-1
  75         b       <ext4_resize_begin_generic+0xb0>       63         b       <ext4_resize_begin_ppc+0x9c>
  76         ld      r9,96(r9)                              64         ld      r9,96(r9)
  77         addis   r6,r2,-118                             65         addis   r6,r2,-118
  78         addis   r4,r2,-140                             66         addis   r4,r2,-140
  79         mr      r3,r31                                 67         mr      r3,r31
  80         li      r5,87                                  68         li      r5,36
  81         addi    r6,r6,30240                            69         addi    r6,r6,30240
  82         addi    r4,r4,3064                             70         addi    r4,r4,3040
  83         ld      r7,24(r9)                              71         ld      r7,24(r9)
  84         bl      <__ext4_warning+0x8>                   72         bl      <__ext4_warning+0x8>
  85         nop                                            73         nop
  86         li      r3,-1                                  74         li      r3,-1
  87         b       <ext4_resize_begin_generic+0xb0>       75         b       <ext4_resize_begin_ppc+0x9c>
  88         bl      <__stack_chk_fail+0x8>


If I change the READ_ONCE() in test_and_set_bit_lock():

	if (READ_ONCE(*p) & mask)
		return 1;

to a regular pointer access:

	if (*p & mask)
		return 1;

Then the generated code looks more or less the same, except for the extra early
return in the generic version of test_and_set_bit_lock(), and different handling
of the return code by the compiler.

   1 <ext4_resize_begin_generic>:                            1 <ext4_resize_begin_ppc>:
   2         addis   r2,r12,281                              2         addis   r2,r12,281
   3         addi    r2,r2,-12256                            3         addi    r2,r2,-11952
   4         mflr    r0                                      4         mflr    r0
   5         bl      <_mcount>                               5         bl      <_mcount>
   6         mflr    r0                                      6         mflr    r0
   7         std     r31,-8(r1)                              7         std     r31,-8(r1)
   8         std     r30,-16(r1)                             8         std     r30,-16(r1)
   9         mr      r31,r3                                  9         mr      r31,r3
  10         li      r3,24                                  10         li      r3,24
  11         std     r0,16(r1)                              11         std     r0,16(r1)
  12         stdu    r1,-112(r1)                            12         stdu    r1,-112(r1)
  13         ld      r30,920(r31)                           13         ld      r30,920(r31)
  14         bl      <capable+0x8>                          14         bl      <capable+0x8>
  15         nop                                            15         nop
  16         cmpdi   cr7,r3,0                               16         cmpdi   cr7,r3,0
  17         beq     cr7,<ext4_resize_begin_generic+0xe0>   17         beq     cr7,<ext4_resize_begin_ppc+0xc0>
  18         ld      r9,920(r31)                            18         ld      r9,920(r31)
  19         ld      r10,96(r30)                            19         ld      r10,96(r30)
  20         lwz     r7,84(r30)                             20         lwz     r7,84(r30)
  21         ld      r8,104(r9)                             21         ld      r8,104(r9)
  22         ld      r10,24(r10)                            22         ld      r10,24(r10)
  23         lwz     r8,20(r8)                              23         lwz     r8,20(r8)
  24         srd     r10,r10,r7                             24         srd     r10,r10,r7
  25         cmpd    cr7,r10,r8                             25         cmpd    cr7,r10,r8
  26         bne     cr7,<ext4_resize_begin_generic+0x118>  26         bne     cr7,<ext4_resize_begin_ppc+0xf8>
  27         lhz     r10,160(r9)                            27         lhz     r10,160(r9)
  28         andi.   r10,r10,2                              28         andi.   r10,r10,2
  29         bne     <ext4_resize_begin_generic+0xf0>       29         bne     <ext4_resize_begin_ppc+0xd0>
  30         ld      r10,560(r9)
  31         andi.   r10,r10,1
  32         bne     <ext4_resize_begin_generic+0xc0>
  33         addi    r7,r9,560                              30         addi    r9,r9,560
  34         li      r8,1                                   31         li      r10,1
  35         ldarx   r10,0,r7                               32         ldarx   r3,0,r9,1
  36         or      r6,r8,r10                              33         or      r8,r3,r10
  37         stdcx.  r6,0,r7                                34         stdcx.  r8,0,r9
  38         bne-    <ext4_resize_begin_generic+0x84>       35         bne-    <ext4_resize_begin_ppc+0x78>
  39         isync                                          36         isync
                                                            37         clrldi  r3,r3,63
  40         andi.   r9,r10,1                               38         addi    r3,r3,-1
  41         li      r3,0                                   39         rlwinm  r3,r3,0,27,27
  42         bne     <ext4_resize_begin_generic+0xc0>       40         addi    r3,r3,-16
  43         addi    r1,r1,112                              41         addi    r1,r1,112
  44         ld      r0,16(r1)                              42         ld      r0,16(r1)
  45         ld      r30,-16(r1)                            43         ld      r30,-16(r1)
  46         ld      r31,-8(r1)                             44         ld      r31,-8(r1)
  47         mtlr    r0                                     45         mtlr    r0
  48         blr                                            46         blr
  49         nop                                            47         nop
  50         addi    r1,r1,112                              48         nop
  51         li      r3,-16
  52         ld      r0,16(r1)
  53         ld      r30,-16(r1)
  54         ld      r31,-8(r1)
  55         mtlr    r0
  56         blr
  57         nop                                            49         nop
  58         li      r3,-1                                  50         li      r3,-1
  59         b       <ext4_resize_begin_generic+0xa4>       51         b       <ext4_resize_begin_ppc+0x9c>
  60         nop                                            52         nop
  61         nop                                            53         nop
  62         addis   r6,r2,-118                             54         addis   r6,r2,-118
  63         addis   r4,r2,-140                             55         addis   r4,r2,-140
  64         mr      r3,r31                                 56         mr      r3,r31
  65         li      r5,97                                  57         li      r5,46
  66         addi    r6,r6,30288                            58         addi    r6,r6,30288
  67         addi    r4,r4,3064                             59         addi    r4,r4,3040
  68         bl      <__ext4_warning+0x8>                   60         bl      <__ext4_warning+0x8>
  69         nop                                            61         nop
  70         li      r3,-1                                  62         li      r3,-1
  71         b       <ext4_resize_begin_generic+0xa4>       63         b       <ext4_resize_begin_ppc+0x9c>
  72         ld      r9,96(r9)                              64         ld      r9,96(r9)
  73         addis   r6,r2,-118                             65         addis   r6,r2,-118
  74         addis   r4,r2,-140                             66         addis   r4,r2,-140
  75         mr      r3,r31                                 67         mr      r3,r31
  76         li      r5,87                                  68         li      r5,36
  77         addi    r6,r6,30240                            69         addi    r6,r6,30240
  78         addi    r4,r4,3064                             70         addi    r4,r4,3040
  79         ld      r7,24(r9)                              71         ld      r7,24(r9)
  80         bl      <__ext4_warning+0x8>                   72         bl      <__ext4_warning+0x8>
  81         nop                                            73         nop
  82         li      r3,-1                                  74         li      r3,-1
  83         b       <ext4_resize_begin_generic+0xa4>       75         b       <ext4_resize_begin_ppc+0x9c>


So READ_ONCE() + STACKPROTECTOR_STRONG is problematic. The root cause is
presumably that READ_ONCE() does an access to an on-stack variable,
which triggers the heuristics in the compiler that the stack needs
protecting.

It seems like a compiler "mis-feature" that a constant-sized access to the stack
triggers the stack protector logic, especially when the access is eventually
optimised away. But I guess that's probably what we get for doing tricks like
READ_ONCE() in the first place :/

I tried going back to the version of READ_ONCE() that doesn't use a
union, ie. effectively reverting dd36929720f4 ("kernel: make READ_ONCE()
valid on const arguments") to get:

#define READ_ONCE(x)							\
	({ typeof(x) __val; __read_once_size(&x, &__val, sizeof(__val)); __val; })

But it makes no difference, the stack protector stuff still triggers. So
I guess it's simply taking the address of a stack variable that triggers
it.

There seems to be a function attribute to enable stack protector for a
function, but not one to disable it:
  https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/Common-Function-Attributes.html#index-stack_005fprotect-function-attribute

That may not be a good solution even if it did exist, because it would
potentially disable stack protector in places where we do want it
enabled.

cheers
