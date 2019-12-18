Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAFD12469D
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 13:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLRMRX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Dec 2019 07:17:23 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33197 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfLRMRX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 07:17:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47dDXb27H3z9sS6;
        Wed, 18 Dec 2019 23:17:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1576671439;
        bh=nwZUJvsHJoteMMjLAMbyeGibq43+npiZP1GzGw6OdMg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FWwsdBB2+MZf8NVXIEjf8tR9dv+exTyvKS6elRrzIyN27dQh8eHzQNjJQHpQveSml
         xoqXnvuT7c7nNs/ravK1bS5c7m/ql9XqGyxIjCBb9LoTFcnX8uhdTy+mQ57DOmM6tT
         jJrlgpKZIt+799SUTrRBAWBSnrCJeJigPRc+P3Wzs7L/pejGxlV/TrV3IGQ/xI0OgR
         XXHNPaPI3u6gbCNEbb0rl01jngUdmk+TBgvV5caOxjJRye8oEKVEhT4t9oxE8bWblp
         cZ3NCYARcHRFSLNOYnjjOWRrd/e6rntCX82fGi65iP2qQ6A8ajaxzCPHF68byUvpSu
         l2M3qvgekM/QQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
In-Reply-To: <CAHk-=wjNLxSZZs+A0tyb-MnJ2YU-sqTAfy0-X+9vxjXfs_O4zA@mail.gmail.com>
References: <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net> <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com> <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com> <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com> <20191217170719.GA869@willie-the-truck> <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com> <CAHk-=wjNLxSZZs+A0tyb-MnJ2YU-sqTAfy0-X+9vxjXfs_O4zA@mail.gmail.com>
Date:   Wed, 18 Dec 2019 23:17:13 +1100
Message-ID: <87zhfpn7zq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Tue, Dec 17, 2019 at 10:04 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Let me think about it.
>
> How about we just get rid of the union entirely, and just use
> 'unsigned long' or 'unsigned long long' depending on the size.
>
> Something like the attached patch - it still requires that it be an
> arithmetic type, but now because of the final cast.
>
> But it might still be a cast to a volatile type, of course. Then the
> result will be volatile, but at least now READ_ONCE() won't be taking
> the address of a volatile variable on the stack - does that at least
> fix some of the horrible code generation. Hmm?

Yes it seems to fix it for me.

There's no unnecessary stack protector gunk, and no store/load to the
stack variable.

This is my previous example of ext4_resize_begin(), hacked to use a copy
of the generic version of test_and_set_bit_lock(), which in turn was
hacked to use a local version of your READ_ONCE().

  c000000000534390 <ext4_resize_begin_generic>:
  c000000000534390:       19 01 4c 3c     addis   r2,r12,281
  c000000000534394:       70 c3 42 38     addi    r2,r2,-15504
  c000000000534398:       a6 02 08 7c     mflr    r0
  c00000000053439c:       4d 98 b3 4b     bl      c00000000006dbe8 <_mcount>
  c0000000005343a0:       a6 02 08 7c     mflr    r0
  c0000000005343a4:       f8 ff e1 fb     std     r31,-8(r1)
  c0000000005343a8:       f0 ff c1 fb     std     r30,-16(r1)
  c0000000005343ac:       78 1b 7f 7c     mr      r31,r3
  c0000000005343b0:       18 00 60 38     li      r3,24
  c0000000005343b4:       10 00 01 f8     std     r0,16(r1)
  c0000000005343b8:       91 ff 21 f8     stdu    r1,-112(r1)
  c0000000005343bc:       98 03 df eb     ld      r30,920(r31)
  c0000000005343c0:       d9 d3 c0 4b     bl      c000000000141798 <capable+0x8>
  c0000000005343c4:       00 00 00 60     nop
  c0000000005343c8:       00 00 a3 2f     cmpdi   cr7,r3,0
  c0000000005343cc:       a4 00 9e 41     beq     cr7,c000000000534470 <ext4_resize_begin_generic+0xe0>
  c0000000005343d0:       98 03 3f e9     ld      r9,920(r31)
  c0000000005343d4:       60 00 5e e9     ld      r10,96(r30)
  c0000000005343d8:       54 00 fe 80     lwz     r7,84(r30)
  c0000000005343dc:       68 00 09 e9     ld      r8,104(r9)
  c0000000005343e0:       18 00 4a e9     ld      r10,24(r10)
  c0000000005343e4:       14 00 08 81     lwz     r8,20(r8)
  c0000000005343e8:       36 3c 4a 7d     srd     r10,r10,r7
  c0000000005343ec:       00 40 aa 7f     cmpd    cr7,r10,r8
  c0000000005343f0:       b8 00 9e 40     bne     cr7,c0000000005344a8 <ext4_resize_begin_generic+0x118>
  c0000000005343f4:       a0 00 49 a1     lhz     r10,160(r9)
  c0000000005343f8:       02 00 4a 71     andi.   r10,r10,2
  c0000000005343fc:       84 00 82 40     bne     c000000000534480 <ext4_resize_begin_generic+0xf0>
  c000000000534400:       30 02 49 e9     ld      r10,560(r9)						# simple load of EXT4_SB(sb)->s_ext4_flags
  c000000000534404:       01 00 4a 71     andi.   r10,r10,1
  c000000000534408:       48 00 82 40     bne     c000000000534450 <ext4_resize_begin_generic+0xc0>
  c00000000053440c:       30 02 e9 38     addi    r7,r9,560
  c000000000534410:       01 00 00 39     li      r8,1
  c000000000534414:       a8 38 40 7d     ldarx   r10,0,r7
  c000000000534418:       78 53 06 7d     or      r6,r8,r10
  c00000000053441c:       ad 39 c0 7c     stdcx.  r6,0,r7
  c000000000534420:       f4 ff c2 40     bne-    c000000000534414 <ext4_resize_begin_generic+0x84>
  c000000000534424:       2c 01 00 4c     isync
  c000000000534428:       01 00 49 71     andi.   r9,r10,1
  c00000000053442c:       00 00 60 38     li      r3,0
  c000000000534430:       20 00 82 40     bne     c000000000534450 <ext4_resize_begin_generic+0xc0>
  c000000000534434:       70 00 21 38     addi    r1,r1,112
  c000000000534438:       10 00 01 e8     ld      r0,16(r1)
  c00000000053443c:       f0 ff c1 eb     ld      r30,-16(r1)
  c000000000534440:       f8 ff e1 eb     ld      r31,-8(r1)
  c000000000534444:       a6 03 08 7c     mtlr    r0
  c000000000534448:       20 00 80 4e     blr
  c00000000053444c:       00 00 00 60     nop
  c000000000534450:       70 00 21 38     addi    r1,r1,112
  c000000000534454:       f0 ff 60 38     li      r3,-16
  c000000000534458:       10 00 01 e8     ld      r0,16(r1)
  c00000000053445c:       f0 ff c1 eb     ld      r30,-16(r1)
  c000000000534460:       f8 ff e1 eb     ld      r31,-8(r1)
  c000000000534464:       a6 03 08 7c     mtlr    r0
  c000000000534468:       20 00 80 4e     blr
  c00000000053446c:       00 00 00 60     nop
  c000000000534470:       ff ff 60 38     li      r3,-1
  c000000000534474:       c0 ff ff 4b     b       c000000000534434 <ext4_resize_begin_generic+0xa4>
  c000000000534478:       00 00 00 60     nop
  c00000000053447c:       00 00 00 60     nop
  c000000000534480:       8a ff c2 3c     addis   r6,r2,-118
  c000000000534484:       74 ff 82 3c     addis   r4,r2,-140
  c000000000534488:       78 fb e3 7f     mr      r3,r31
  c00000000053448c:       7c 00 a0 38     li      r5,124
  c000000000534490:       a8 75 c6 38     addi    r6,r6,30120
  c000000000534494:       f8 0b 84 38     addi    r4,r4,3064
  c000000000534498:       d1 a4 01 48     bl      c00000000054e968 <__ext4_warning+0x8>
  c00000000053449c:       00 00 00 60     nop
  c0000000005344a0:       ff ff 60 38     li      r3,-1
  c0000000005344a4:       90 ff ff 4b     b       c000000000534434 <ext4_resize_begin_generic+0xa4>
  c0000000005344a8:       60 00 29 e9     ld      r9,96(r9)
  c0000000005344ac:       8a ff c2 3c     addis   r6,r2,-118
  c0000000005344b0:       74 ff 82 3c     addis   r4,r2,-140
  c0000000005344b4:       78 fb e3 7f     mr      r3,r31
  c0000000005344b8:       72 00 a0 38     li      r5,114
  c0000000005344bc:       78 75 c6 38     addi    r6,r6,30072
  c0000000005344c0:       f8 0b 84 38     addi    r4,r4,3064
  c0000000005344c4:       18 00 e9 e8     ld      r7,24(r9)
  c0000000005344c8:       a1 a4 01 48     bl      c00000000054e968 <__ext4_warning+0x8>
  c0000000005344cc:       00 00 00 60     nop
  c0000000005344d0:       ff ff 60 38     li      r3,-1
  c0000000005344d4:       60 ff ff 4b     b       c000000000534434 <ext4_resize_begin_generic+0xa4>
  c0000000005344d8:       00 00 00 60     nop
  c0000000005344dc:       00 00 00 60     nop


cheers
