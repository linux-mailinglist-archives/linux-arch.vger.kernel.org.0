Return-Path: <linux-arch+bounces-661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CCA804497
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB451C20A05
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6629546AF;
	Tue,  5 Dec 2023 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fzAz3umh"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1340BB4;
	Mon,  4 Dec 2023 18:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EEu1JQzPR+aQ2DPOZEiFw30XYWpIDeqUkY6qQHrbRV4=; b=fzAz3umhgaI9QVoUzvSuygd0cx
	YhEQCqm7nmiIGD2HNouUK23uCJ2QG8Uvf7LIcAVwJEjHAvch41V6UoGb4+2exQIpWg6yd8y1fYPqJ
	coU4LqngyafNl30XzwKk2Mm4m8UTqBMmDYynYP+mfJuCa34QS08Ftg5GCZCVV2LKSutlgvS8ALE27
	vOAFMtj/JDE07ZcqKtYmB2RSkTMFSdSn8ecw1SWWX4Hu7RZ4ECXF2BM+XjCZqebUYFfVkM4kPlSgB
	bA/8LNGUiqH8LfbC+FI63ktuFETe9CYY0yrY+pdhWMDn8IGvzVv9KSmB0sI/iuTydJoxePfwm8Ifw
	kzwsphvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL3U-0078xn-30;
	Tue, 05 Dec 2023 02:21:01 +0000
Date: Tue, 5 Dec 2023 02:21:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: gus Gusenleitner Klaus <gus@keba.com>, Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: [RFC][PATCHES v2] checksum stuff
Message-ID: <20231205022100.GB1674809@ZenIV>
References: <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <20231022194020.GA972254@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022194020.GA972254@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

We need a way for csum_and_copy_{from,to}_user() to report faults.
The approach taken back in 2020 (avoid 0 as return value by starting
summing from ~0U, use 0 to report faults) had been broken; it does
yield the right value modulo 2^16-1, but the case when data is
entirely zero-filled is not handled right.  It almost works, since
for most of the codepaths we have a non-zero value added in
and there 0 is not different from anything divisible by 0xffff.
However, there are cases (ICMPv4 replies, for example) where we
are not guaranteed that.

In other words, we really need to have those primitives return 0
on filled-with-zeroes input.  So let's make them return a 64bit
value instead; we can do that cheaply (all supported architectures
do that via a couple of registers) and we can use that to report
faults without disturbing the 32bit csum.

New type: __wsum_fault.  64bit, returned by csum_and_copy_..._user().
Primitives:
        * CSUM_FAULT representing the fault
        * to_wsum_fault() folding __wsum value into that
        * from_wsum_fault() extracting __wsum value
        * wsum_is_fault() checking if it's a fault value

Representation depends upon the target.
        CSUM_FAULT: ~0ULL
        to_wsum_fault(v32): (u64)v32 for 64bit and 32bit l-e,
(u64)v32 << 32 for 32bit b-e.

Rationale: relationship between the calling conventions for returning 64bit
and those for returning 32bit values.  On 64bit architectures the same
register is used; on 32bit l-e the lower half of the value goes in the
same register that is used for returning 32bit values and the upper half
goes into additional register.  On 32bit b-e the opposite happens -
upper 32 bits go into the register used for returning 32bit values and
the lower 32 bits get stuffed into additional register.

So with this choice of representation we need minimal changes on the
asm side (zero an extra register in 32bit case, nothing in 64bit case),
and from_wsum_fault() is as cheap as it gets.

Sum calculation is back to "start from 0".

The rest of the series consists of cleaning up assorted asm/checksum.h.

Branch lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.csum
Individual patches in followups.  Help with review and testing would
be very welcome.

Al Viro (18):
      make net/checksum.h self-contained
      get rid of asm/checksum.h includes outside of include/net/checksum.h and arch
      make net/checksum.h the sole user of asm/checksum.h
      Fix the csum_and_copy_..._user() idiocy
      bits missing from csum_and_copy_{from,to}_user() unexporting.
      consolidate csum_tcpudp_magic(), take default variant into net/checksum.h
      consolidate default ip_compute_csum()
      alpha: pull asm-generic/checksum.h
      mips: pull include of asm-generic/checksum.h out of #if
      nios2: pull asm-generic/checksum.h
      x86: merge csum_fold() for 32bit and 64bit
      x86: merge ip_fast_csum() for 32bit and 64bit
      x86: merge csum_tcpudp_nofold() for 32bit and 64bit
      amd64: saner handling of odd address in csum_partial()
      x86: optimized csum_add() is the same for 32bit and 64bit
      x86: lift the extern for csum_partial() into checksum.h
      x86_64: move csum_ipv6_magic() from csum-wrappers_64.c to csum-partial_64.c
      uml/x86: use normal x86 checksum.h

 arch/alpha/include/asm/asm-prototypes.h   |   2 +-
 arch/alpha/include/asm/checksum.h         |  68 ++----------
 arch/alpha/lib/csum_partial_copy.c        |  74 ++++++-------
 arch/arm/include/asm/checksum.h           |  27 +----
 arch/arm/kernel/armksyms.c                |   3 +-
 arch/arm/lib/csumpartialcopygeneric.S     |   3 +-
 arch/arm/lib/csumpartialcopyuser.S        |   8 +-
 arch/hexagon/include/asm/checksum.h       |   4 +-
 arch/hexagon/kernel/hexagon_ksyms.c       |   1 -
 arch/hexagon/lib/checksum.c               |   1 +
 arch/m68k/include/asm/checksum.h          |  24 +---
 arch/m68k/lib/checksum.c                  |   8 +-
 arch/microblaze/kernel/microblaze_ksyms.c |   2 +-
 arch/mips/include/asm/asm-prototypes.h    |   2 +-
 arch/mips/include/asm/checksum.h          |  32 ++----
 arch/mips/lib/csum_partial.S              |  12 +-
 arch/nios2/include/asm/checksum.h         |  13 +--
 arch/openrisc/kernel/or32_ksyms.c         |   2 +-
 arch/parisc/include/asm/checksum.h        |  21 ----
 arch/powerpc/include/asm/asm-prototypes.h |   2 +-
 arch/powerpc/include/asm/checksum.h       |  27 +----
 arch/powerpc/lib/checksum_32.S            |   6 +-
 arch/powerpc/lib/checksum_64.S            |   4 +-
 arch/powerpc/lib/checksum_wrappers.c      |  14 +--
 arch/s390/include/asm/checksum.h          |  18 ---
 arch/s390/kernel/ipl.c                    |   2 +-
 arch/s390/kernel/os_info.c                |   2 +-
 arch/sh/include/asm/checksum_32.h         |  32 +-----
 arch/sh/kernel/sh_ksyms_32.c              |   2 +-
 arch/sh/lib/checksum.S                    |   6 +-
 arch/sparc/include/asm/asm-prototypes.h   |   2 +-
 arch/sparc/include/asm/checksum_32.h      |  63 ++++++-----
 arch/sparc/include/asm/checksum_64.h      |  21 +---
 arch/sparc/lib/checksum_32.S              |   2 +-
 arch/sparc/lib/csum_copy.S                |   4 +-
 arch/sparc/lib/csum_copy_from_user.S      |   2 +-
 arch/sparc/lib/csum_copy_to_user.S        |   2 +-
 arch/x86/include/asm/asm-prototypes.h     |   2 +-
 arch/x86/include/asm/checksum.h           | 177 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/checksum_32.h        | 141 ++----------------------
 arch/x86/include/asm/checksum_64.h        | 172 +----------------------------
 arch/x86/lib/checksum_32.S                |  20 +++-
 arch/x86/lib/csum-copy_64.S               |   6 +-
 arch/x86/lib/csum-partial_64.c            |  41 ++++---
 arch/x86/lib/csum-wrappers_64.c           |  43 ++------
 arch/x86/um/asm/checksum.h                | 119 --------------------
 arch/x86/um/asm/checksum_32.h             |  38 -------
 arch/x86/um/asm/checksum_64.h             |  19 ----
 arch/xtensa/include/asm/asm-prototypes.h  |   2 +-
 arch/xtensa/include/asm/checksum.h        |  33 +-----
 arch/xtensa/lib/checksum.S                |   6 +-
 drivers/net/ethernet/brocade/bna/bnad.h   |   2 -
 drivers/net/ethernet/lantiq_etop.c        |   2 -
 drivers/net/vmxnet3/vmxnet3_int.h         |   1 -
 drivers/s390/char/zcore.c                 |   2 +-
 include/asm-generic/checksum.h            |  15 +--
 include/net/checksum.h                    |  81 ++++++++++++--
 include/net/ip6_checksum.h                |   1 -
 lib/checksum_kunit.c                      |   2 +-
 net/core/datagram.c                       |   8 +-
 net/core/skbuff.c                         |   8 +-
 net/ipv6/ip6_checksum.c                   |   1 -
 62 files changed, 501 insertions(+), 959 deletions(-)

Part 1: sorting out the includes.
	We have asm/checksum.h and net/checksum.h; the latter pulls
the former.  A lot of things would become easier if we could move
the things from asm/checksum.h to net/checksum.h; for that we need to
make net/checksum.h the only file that pulls asm/checksum.h.

1/18) make net/checksum.h self-contained
right now it has an implicit dependency upon linux/bitops.h (for the
sake of ror32()).

2/18) get rid of asm/checksum.h includes outside of include/net/checksum.h and arch
In almost all cases include is redundant; zcore.c and checksum_kunit.c
are the sole exceptions and those got switched to net/checksum.h

3/18) make net/checksum.h the sole user of asm/checksum.h
All other users (all in arch/* by now) can pull net/checksum.h.

Part 2: fix the fault reporting.

4/18) Fix the csum_and_copy_..._user() idiocy

Fix the breakage introduced back in 2020 - see above for details.

Part 3: trimming related crap

5/18) bits missing from csum_and_copy_{from,to}_user() unexporting.
6/18) consolidate csum_tcpudp_magic(), take default variant into net/checksum.h
7/18) consolidate default ip_compute_csum()
... and take it into include/net/checksum.h
8/18) alpha: pull asm-generic/checksum.h
9/18) mips: pull include of asm-generic/checksum.h out of #if
10/18) nios2: pull asm-generic/checksum.h

Part 4: trimming x86 crap
11/18) x86: merge csum_fold() for 32bit and 64bit
identical...
12/18) x86: merge ip_fast_csum() for 32bit and 64bit
Identical, except that 32bit version uses asm volatile where 64bit
one uses plain asm.  The former had become pointless when memory
clobber got added to both versions...
13/18) x86: merge csum_tcpudp_nofold() for 32bit and 64bit
identical...
14/18) amd64: saner handling of odd address in csum_partial()
all we want there is to have return value congruent to result * 256
modulo 0xffff; no need to convert from 32bit to 16bit (i.e. take it
modulo 0xffff) first - cyclic shift of 32bit value by 8 bits (in either
direction) will work.
Kills the from32to16() helper and yields better code...
15/18) x86: optimized csum_add() is the same for 32bit and 64bit
16/18) x86: lift the extern for csum_partial() into checksum.h
17/18) x86_64: move csum_ipv6_magic() from csum-wrappers_64.c to csum-partial_64.c
... and make uml/amd64 use it.
18/18) uml/x86: use normal x86 checksum.h
The only difference left is that UML really does *NOT* want the
csum-and-uaccess combinations; leave those in 
arch/x86/include/asm/checksum_{32,64}, move the rest into
arch/x86/include/asm/checksum.h (under ifdefs) and that's 
pretty much it.


