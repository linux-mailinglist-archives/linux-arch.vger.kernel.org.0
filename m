Return-Path: <linux-arch+bounces-9966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100B0A2570B
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 11:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C659F1885581
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 10:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE443201011;
	Mon,  3 Feb 2025 10:35:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63725200BBF;
	Mon,  3 Feb 2025 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578946; cv=none; b=m7UY05zweRptcIADuBAOER0P5qmwATFM6irugu/jttJkpdv1VJuvgG602Wv0KSmt8jmaXHS65f4kqisI19NJS0yzh6Lt46NqBMdIsspqRPh+yvhf1bQIju4ng5jw0jhuozDrzZIPAo0ohUgrI3tNXxHVIegVw3zQrpJjELc70kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578946; c=relaxed/simple;
	bh=D5Jv3FPUdrdfdsx4anIJHNUlSFE+deaFBpMQvm/GgIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCgF66EDFeJqSh0HHe4Yz/PdcAnb7/12EcJtOr2TntGtyaesDN/fKDItSBa2Ws8omv0vbiN/VSPCTmmKwSYy2Zti7IrfTfi/feNZ+BlrYNMCgb2WFyy8ze5CwiSmlVauMq0MtK0zClhexqRqjWwSboGh5bic43t+GHiq/RP+In8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 35C8572C8F5;
	Mon,  3 Feb 2025 13:35:43 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 1956F7CCB3A; Mon,  3 Feb 2025 12:35:43 +0200 (IST)
Date: Mon, 3 Feb 2025 12:35:43 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-snps-arc@lists.infradead.org, Rich Felker <dalias@libc.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
	linux-kselftest@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
	WANG Xuerui <kernel@xen0n.name>, linux-api@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Mike Frysinger <vapier@gentoo.org>,
	Davide Berardi <berardi.dav@gmail.com>,
	Renzo Davoli <renzo@cs.unibo.it>, linux-um@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>, strace-devel@lists.strace.io,
	Charlie Jenkins <charlie@rivosinc.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-m68k@lists.linux-m68k.org, Borislav Petkov <bp@alien8.de>,
	loongarch@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Stafford Horne <shorne@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-arm-kernel@lists.infradead.org,
	Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-parisc@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Oleg Nesterov <oleg@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Gladkov <legion@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 0/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
Message-ID: <20250203103542.GA16165@strace.io>
References: <20250203065849.GA14120@strace.io>
 <Z6CMgVm8QKEMRf8L@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CMgVm8QKEMRf8L@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Mon, Feb 03, 2025 at 10:29:37AM +0100, Alexander Gordeev wrote:
> On Mon, Feb 03, 2025 at 08:58:49AM +0200, Dmitry V. Levin wrote:
> 
> Hi Dmitry,
> 
> > PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
> > PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
> > system calls the tracee is blocked in.
> ...
> 
> FWIW, I am getting these on s390:
> 
> # ./tools/testing/selftests/ptrace/set_syscall_info 
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> #  RUN           global.set_syscall_info ...
> # set_syscall_info.c:87:set_syscall_info:Expected exp_entry->nr (-1) == info->entry.nr (65535)
> # set_syscall_info.c:88:set_syscall_info:wait #3: PTRACE_GET_SYSCALL_INFO #2: syscall nr mismatch
> # set_syscall_info: Test terminated by assertion
> #          FAIL  global.set_syscall_info
> not ok 1 global.set_syscall_info
> # FAILED: 0 / 1 tests passed.
> # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> I remember one of the earlier versions (v1 or v2) was working for me.
> 
> Thanks!

In v3, this test was extended to check whether PTRACE_GET_SYSCALL_INFO
called immediately after PTRACE_SET_SYSCALL_INFO returns the same syscall
number, and on s390 it apparently doesn't, thanks to its implementation
of syscall_get_nr() that returns 0xffff in this case.

To workaround this, we could either change syscall_get_nr() to return -1
in this case, or add an #ifdef __s390x__ exception to the test.

What would you prefer?


-- 
ldv

