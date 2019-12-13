Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A311E34E
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 13:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLMMIE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Dec 2019 07:08:04 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfLMMIE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Dec 2019 07:08:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Z8Z75M69z9sNH;
        Fri, 13 Dec 2019 23:07:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1576238880;
        bh=T73UbJx6DhmwQ1N/iNMIavMt3Lbs62DgCQLGRpz+/FM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WXZ8TIT/18VCusfv0/4GxMXeLZyG9e/dxQn9uQb2kX1dBzq4bQQLvVRkSqv62BI6A
         nf6xFtNVGbDVzJg55Mx3ZN+XCZC54kP7PVy2cg0VJSy4UAVirl9uhRJIUPUJpTjHiN
         yOmNGNyXzg0i/vEoHp21xNf+AI3vCnFO5xIGtk7Ad+ndOIhFeluKeH/27NOg3+/kxb
         7eiRc8TEh2W/q52qnAy4vz7t5QWgeFUNxAj9klDYnCPW4CsplJ9n6gZ0E1nTvhAcQ3
         uv4xbOfhW0ZmA6C3Z8wDOrRZlJtjMuQfNXEdv2MzNXfL+Qr9T+DJvXS4fpvy2LZgGS
         ccnL2ZE0DQeew==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@c-s.fr, linux-arch@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
In-Reply-To: <20191212104610.GW2827@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net> <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net> <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
Date:   Fri, 13 Dec 2019 23:07:55 +1100
Message-ID: <87pngso2ck.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, Dec 12, 2019 at 10:07:56AM +0000, Will Deacon wrote:
>
>> > So your proposed change _should_ be fine. Will, I'm assuming you never
>> > saw this on your ARGH64 builds when you did this code ?
>> 
>> I did see it, but (a) looking at the code out-of-line makes it look a lot
>> worse than it actually is (so the ext4 example is really helpful -- thanks
>> Michael!) and (b) I chalked it up to a crappy compiler.
>> 
>> However, see this comment from Arnd on my READ_ONCE series from the other
>> day:
>> 
>> https://lore.kernel.org/lkml/CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com
>> 
>> In which case, I'm thinking that we should be doing better in READ_ONCE()
>> for non-buggy compilers which would also keep the KCSAN folks happy for this
>> code (and would help with [1] too).
>
> So something like this then? Although I suppose that should be moved
> into compiler-gcc.h and then guarded by #ifndef READ_ONCE or so.

I tried this:

> @@ -295,6 +296,23 @@ void __write_once_size(volatile void *p, void *res, int size)
>   */
>  #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
>  
> +#else /* GCC_VERSION < 40800 */
> +
> +#define READ_ONCE_NOCHECK(x)						\
> +({									\
> +	typeof(x) __x = *(volatile typeof(x))&(x);			\

Didn't compile, needed:

	typeof(x) __x = *(volatile typeof(&x))&(x);			\


> +	smp_read_barrier_depends();					\
> +	__x;
> +})


And that works for me. No extra stack check stuff.

I guess the question is does that version of READ_ONCE() implement the
read once semantics. Do we have a good way to test that?

The only differences are because of the early return in the generic
test_and_set_bit_lock():

   1 <ext4_resize_begin_generic>:                            1 <ext4_resize_begin_ppc>:
   2         addis   r2,r12,281                              2         addis   r2,r12,281
   3         addi    r2,r2,-22368                            3         addi    r2,r2,-22064
   4         mflr    r0                                      4         mflr    r0
   5         bl      <_mcount>                               5         bl      <_mcount>
   6         mflr    r0                                      6         mflr    r0
   7         std     r31,-8(r1)                              7         std     r31,-8(r1)
   8         std     r30,-16(r1)                             8         std     r30,-16(r1)
   9         mr      r31,r3                                  9         mr      r31,r3
  10         li      r3,24                                  10         li      r3,24
  11         std     r0,16(r1)                              11         std     r0,16(r1)
  12         stdu    r1,-128(r1)                            12         stdu    r1,-112(r1)
  13         ld      r30,920(r31)                           13         ld      r30,920(r31)
  14         bl      <capable+0x8>                          14         bl      <capable+0x8>
  15         nop                                            15         nop
  16         cmpdi   cr7,r3,0                               16         cmpdi   cr7,r3,0
  17         beq     cr7,<ext4_resize_begin_generic+0xf0>   17         beq     cr7,<ext4_resize_begin_ppc+0xc0>
  18         ld      r9,920(r31)                            18         ld      r9,920(r31)
  19         ld      r10,96(r30)                            19         ld      r10,96(r30)
  20         lwz     r7,84(r30)                             20         lwz     r7,84(r30)
  21         ld      r8,104(r9)                             21         ld      r8,104(r9)
  22         ld      r10,24(r10)                            22         ld      r10,24(r10)
  23         lwz     r8,20(r8)                              23         lwz     r8,20(r8)
  24         srd     r10,r10,r7                             24         srd     r10,r10,r7
  25         cmpd    cr7,r10,r8                             25         cmpd    cr7,r10,r8
  26         bne     cr7,<ext4_resize_begin_generic+0x128>  26         bne     cr7,<ext4_resize_begin_ppc+0xf8>
  27         lhz     r10,160(r9)                            27         lhz     r10,160(r9)
  28         andi.   r10,r10,2                              28         andi.   r10,r10,2
  29         bne     <ext4_resize_begin_generic+0x100>
  30         ld      r10,560(r9)
  31         std     r10,104(r1)
  32         ld      r10,104(r1)
  33         andi.   r10,r10,1
  34         bne     <ext4_resize_begin_generic+0xd0>       29         bne     <ext4_resize_begin_ppc+0xd0>
  35         addi    r7,r9,560                              30         addi    r9,r9,560
  36         li      r8,1                                   31         li      r10,1
  37         ldarx   r10,0,r7                               32         ldarx   r3,0,r9,1
  38         or      r6,r8,r10                              33         or      r8,r3,r10
  39         stdcx.  r6,0,r7                                34         stdcx.  r8,0,r9
  40         bne-    <ext4_resize_begin_generic+0x8c>       35         bne-    <ext4_resize_begin_ppc+0x78>
  41         isync                                          36         isync
                                                            37         clrldi  r3,r3,63
  42         andi.   r9,r10,1                               38         addi    r3,r3,-1
  43         li      r3,0                                   39         rlwinm  r3,r3,0,27,27
  44         bne     <ext4_resize_begin_generic+0xd0>       40         addi    r3,r3,-16
  45         addi    r1,r1,128                              41         addi    r1,r1,112
  46         ld      r0,16(r1)                              42         ld      r0,16(r1)
  47         ld      r30,-16(r1)                            43         ld      r30,-16(r1)
  48         ld      r31,-8(r1)                             44         ld      r31,-8(r1)
  49         mtlr    r0                                     45         mtlr    r0
  50         blr                                            46         blr
  51         nop                                            47         nop
  52         nop                                            48         nop
  53         nop                                            49         nop
  54         addi    r1,r1,128
  55         li      r3,-16
  56         ld      r0,16(r1)
  57         ld      r30,-16(r1)
  58         ld      r31,-8(r1)
  59         mtlr    r0
  60         blr
  61         nop
  62         li      r3,-1                                  50         li      r3,-1
  63         b       <ext4_resize_begin_generic+0xac>       51         b       <ext4_resize_begin_ppc+0x9c>
  64         nop                                            52         nop
  65         nop                                            53         nop
  66         addis   r6,r2,-117                             54         addis   r6,r2,-117
  67         addis   r4,r2,-140                             55         addis   r4,r2,-140
  68         mr      r3,r31                                 56         mr      r3,r31
  69         li      r5,146                                 57         li      r5,83
  70         addi    r6,r6,-32736                           58         addi    r6,r6,-32736
  71         addi    r4,r4,3088                             59         addi    r4,r4,3064
  72         bl      <__ext4_warning+0x8>                   60         bl      <__ext4_warning+0x8>
  73         nop                                            61         nop
  74         li      r3,-1                                  62         li      r3,-1
  75         b       <ext4_resize_begin_generic+0xac>       63         b       <ext4_resize_begin_ppc+0x9c>
  76         ld      r9,96(r9)                              64         ld      r9,96(r9)
  77         addis   r6,r2,-118                             65         addis   r6,r2,-118
  78         addis   r4,r2,-140                             66         addis   r4,r2,-140
  79         mr      r3,r31                                 67         mr      r3,r31
  80         li      r5,136                                 68         li      r5,73
  81         addi    r6,r6,32752                            69         addi    r6,r6,32752
  82         addi    r4,r4,3088                             70         addi    r4,r4,3064
  83         ld      r7,24(r9)                              71         ld      r7,24(r9)
  84         bl      <__ext4_warning+0x8>                   72         bl      <__ext4_warning+0x8>
  85         nop                                            73         nop
  86         li      r3,-1                                  74         li      r3,-1
  87         b       <ext4_resize_begin_generic+0xac>       75         b       <ext4_resize_begin_ppc+0x9c>


cheers
