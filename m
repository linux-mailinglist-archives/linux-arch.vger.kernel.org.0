Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67EB22B1DC
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGWOxt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWOxt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 10:53:49 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294CC0619DC;
        Thu, 23 Jul 2020 07:53:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jycbO-000zNa-Hu; Thu, 23 Jul 2020 14:53:42 +0000
Date:   Thu, 23 Jul 2020 15:53:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Message-ID: <20200723145342.GH2786714@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
 <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
 <20200722155452.GF2786714@ZenIV.linux.org.uk>
 <a55679c8d4dc4fb08d1e1782b5fc572c@AcuMS.aculab.com>
 <20200722173903.GG2786714@ZenIV.linux.org.uk>
 <02938acd78fd40beb02ffc5a1b803d85@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02938acd78fd40beb02ffc5a1b803d85@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 23, 2020 at 01:54:47PM +0000, David Laight wrote:
> From: Al Viro
> > Sent: 22 July 2020 18:39
> > I would love to see your patch, anyway, along with the testcases and performance
> > comparison.
> 
> See attached program.
> Compile and run (as root): csum_iov 1
> 
> Unpatched (as shipped) 16 vectors of 1 byte take ~430 clocks on my haswell cpu.
> With dsl_patch defined they take ~393.
> 
> The maximum throughput is ~1.16 clocks/word for 16 vectors of 1k.
> For longer vectors the data gets lost from the cache between the iterations.
> 
> On an older Ivy Bridge cpu it never goes faster than 2 clocks/word.
> (Due to the implementation of ADC.)
> 
> The absolute limit is 1 clock/word - limited by the memory write.
> I suspect that is achievable on Haswell with much less loop unrolling.
> 
> I had to replace the ror32() with __builtin_bswap32().
> The kernel object do contain the 'ror' instruction - even though I
> didn't find the asm for it.

First of all,
;  git grep -n -w ror32|grep '\.h:'
include/linux/bitops.h:109: * ror32 - rotate a 32-bit value right
include/linux/bitops.h:113:static inline __u32 ror32(__u32 word, unsigned int shift)
include/net/checksum.h:81:              sum = ror32(sum, 8);
; grep -A3 ror32 include/linux/bitops.h 
 * ror32 - rotate a 32-bit value right
 * @word: value to rotate
 * @shift: bits to roll
 */
static inline __u32 ror32(__u32 word, unsigned int shift)
{
        return (word >> (shift & 31)) | (word << ((-shift) & 31));
}
; cat >/tmp/a.c <<'EOF'
unsigned f(unsigned n)
{
        return (n >> 8) | (n << 24);
}
EOF
; gcc -c -O2 /tmp/a.c -o /tmp/a.o
; objdump /tmp/a.o
/tmp/a.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <f>:
   0:   89 f8                   mov    %edi,%eax
   2:   c1 c8 08                ror    $0x8,%eax
   5:   c3                      retq   
;
which ought to cover _that_ question.  Takes a couple of minutes, but that's
a trivial side issue.

Said that, what you've printed for 1-byte segments (and that's going to be
seriously affected by the setup costs in csum-copy.S, sensitive to calling
convention changes) is time to run the 16-iteration loop divided by 1 * 16 / 8;
IOW, your difference for 16 iterations here is 37*2 = 74 cycles.  With
per-iteration diff being a bit under 5 cycles.  Which is not implausible,
but
	1) extrapolating to other compiler versions, flags, etc. is not obvious
	2) the effects of calling convention changes need to be taken into account
	3) for copying to/from userland the effects of calling convention changes
are be even larger, and kernel is certainly not going to issue kvec iters of _that_
sort, TYVM.
