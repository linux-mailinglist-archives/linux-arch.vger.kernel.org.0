Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA711D1036
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgEMKtA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:49:00 -0400
Received: from foss.arm.com ([217.140.110.172]:43210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgEMKs6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 06:48:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 084221FB;
        Wed, 13 May 2020 03:48:58 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 454D23F71E;
        Wed, 13 May 2020 03:48:56 -0700 (PDT)
Date:   Wed, 13 May 2020 11:48:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luis Machado <luis.machado@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Alan Hayward <Alan.Hayward@arm.com>,
        Omair Javaid <omair.javaid@linaro.org>
Subject: Re: [PATCH v3 19/23] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Message-ID: <20200513104849.GC2719@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-20-catalin.marinas@arm.com>
 <a7569985-eb85-497b-e3b2-5dce0acb1332@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7569985-eb85-497b-e3b2-5dce0acb1332@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Luis,

On Tue, May 12, 2020 at 04:05:15PM -0300, Luis Machado wrote:
> On 4/21/20 11:25 AM, Catalin Marinas wrote:
> > Add support for bulk setting/getting of the MTE tags in a tracee's
> > address space at 'addr' in the ptrace() syscall prototype. 'data' points
> > to a struct iovec in the tracer's address space with iov_base
> > representing the address of a tracer's buffer of length iov_len. The
> > tags to be copied to/from the tracer's buffer are stored as one tag per
> > byte.
> > 
> > On successfully copying at least one tag, ptrace() returns 0 and updates
> > the tracer's iov_len with the number of tags copied. In case of error,
> > either -EIO or -EFAULT is returned, trying to follow the ptrace() man
> > page.
> > 
> > Note that the tag copying functions are not performance critical,
> > therefore they lack optimisations found in typical memory copy routines.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Alan Hayward <Alan.Hayward@arm.com>
> > Cc: Luis Machado <luis.machado@linaro.org>
> > Cc: Omair Javaid <omair.javaid@linaro.org>
> > ---
> > 
> > Notes:
> >      New in v3.
> > 
> >   arch/arm64/include/asm/mte.h         |  17 ++++
> >   arch/arm64/include/uapi/asm/ptrace.h |   3 +
> >   arch/arm64/kernel/mte.c              | 127 +++++++++++++++++++++++++++
> >   arch/arm64/kernel/ptrace.c           |  15 +++-
> >   arch/arm64/lib/mte.S                 |  50 +++++++++++
> >   5 files changed, 211 insertions(+), 1 deletion(-)
> > 
> I started working on MTE support for GDB and I'm wondering if we've already
> defined a way to check for runtime MTE support (as opposed to a HWCAP2-based
> check) in a traced process.
> 
> Originally we were going to do it via empty-parameter ptrace calls, but you
> had mentioned something about a proc-based method, if I'm not mistaken.

We could expose more information via proc_pid_arch_status() but that
would be the tagged address ABI and tag check fault mode and intended
for human consumption mostly. We don't have any ptrace interface that
exposes HWCAPs. Since the gdbserver runs on the same machine as the
debugged process, it can check the HWCAPs itself, they are the same for
all processes.

BTW, in my pre-v4 patches (hopefully I'll post v4 this week), I changed
the ptrace tag access slightly to return an error (and no tags copied)
if the page has not been mapped with PROT_MTE. The other option would
have been read-as-zero/write-ignored as per the hardware behaviour.
Either option is fine by me but I thought the write-ignored part would
be more confusing for the debugger. If you have any preference here,
please let me know.

-- 
Catalin
