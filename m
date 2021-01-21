Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540422FEA23
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 13:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbhAUMcq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 07:32:46 -0500
Received: from foss.arm.com ([217.140.110.172]:34770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731060AbhAUMcl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 07:32:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88F9811B3;
        Thu, 21 Jan 2021 04:31:46 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.35.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29BEC3F66E;
        Thu, 21 Jan 2021 04:31:43 -0800 (PST)
Date:   Thu, 21 Jan 2021 12:31:40 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Fatal signal handling within uaccess faults
Message-ID: <20210121123140.GD48431@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

Arch maintainers, if you are Cc'd I believe your architecture has a
user-triggerable livelock; please see below for details. Apologies in
advance if I am mistaken!

I believe the following architectures ARE affected:

	alpha, hexagon, ia64, m68k, microblaze, mips, nios2, openrisc,
	parisc, riscv, sparc (32 & 64), xtensa

I believe the following architectures ARE NOT affected:

	arc, arm, arm64, c6x, h8300, nds32, powerpc, s390, sh, x86

... and csky has a fix pending as of today.

The issue is that in the fault handling path, architectures have a check
with the shape:

| if (fault_signal_pending(fault, regs))
|         return;

... where if a uaccess (e.g. get_user()) triggers a fault and there's a
fault signal pending, the handler will return to the uaccess without
having performed a uaccess fault fixup, and so the CPU will immediately
execute the uaccess instruction again, whereupon it will livelock
bouncing between that instruction and the fault handler.

The architectures (with an MMU) which are not affected apply the uaccess
fixup, and so return to the error handler for the uaccess, and make
forward progress. Usually, this looks something like:

| if (fault_signal_pending(fault, regs)) {
|         if (!user_mode(regs))
|                 goto no_context; // or fixup_exception(...), etc
|         return;
| }

I believe similar changes need to be made to each of the architectures
I've listed as affected above.

This was previously reported back in July 2017:

https://lore.kernel.org/lkml/20170822102527.GA14671@leverpostej/

... but it looks like it looks like that wasn't sufficiently visible, so
I'm poking folk explicitly this time around.

I believe that this can be triggered with the test case below,
duplicated from the previous posting. If the architecture is affected,
it will not be possible to kill the test program with any signal.

Thanks,
Mark.

---->8----
#include <errno.h>
#include <linux/userfaultfd.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/vfs.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
        void *mem;
        long pagesz;
        int uffd, ret;
        struct uffdio_api api = {
                .api = UFFD_API
        };
        struct uffdio_register reg;

        pagesz = sysconf(_SC_PAGESIZE);
        if (pagesz < 0) {
        return errno;
        }

        mem = mmap(NULL, pagesz, PROT_READ | PROT_WRITE,
        	   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if (mem == MAP_FAILED)
                return errno;

        uffd = syscall(__NR_userfaultfd, 0);
        if (uffd < 0)
                return errno;

        ret = ioctl(uffd, UFFDIO_API, &api);
        if (ret < 0)
                return errno;

        reg = (struct uffdio_register) {
                        .range = {
                        .start = (unsigned long)mem,
                        .len = pagesz
                },
                .mode = UFFDIO_REGISTER_MODE_MISSING
        };

        ret = ioctl(uffd, UFFDIO_REGISTER, &reg);
        if (ret < 0)
                return errno;

        /*
         * Force an arbitrary uaccess to memory monitored by the userfaultfd.
         * This will block, but when a SIGKILL is sent, will consume all
         * available CPU time without being killed, and may inhibit forward
         * progress of the system.
         */
        ret = fstatfs(0, (struct statfs *)mem);

        return 0;
}
