Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45FB213ABD
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCNSv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 09:18:51 -0400
Received: from foss.arm.com ([217.140.110.172]:33310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgGCNSu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 09:18:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0951B31B;
        Fri,  3 Jul 2020 06:18:50 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 263D13F73C;
        Fri,  3 Jul 2020 06:18:48 -0700 (PDT)
Date:   Fri, 3 Jul 2020 14:18:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luis Machado <luis.machado@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Omair Javaid <omair.javaid@linaro.org>
Subject: Re: [PATCH v5 19/25] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Message-ID: <20200703123117.GC14950@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-20-catalin.marinas@arm.com>
 <7fd536af-f9fa-aa10-a4c3-001e80dd7d7b@linaro.org>
 <20200701171549.GF5191@gaia>
 <8fa5c891-0f4a-c925-679e-94c41a546490@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa5c891-0f4a-c925-679e-94c41a546490@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 01, 2020 at 02:32:43PM -0300, Luis Machado wrote:
> On 7/1/20 2:16 PM, Catalin Marinas wrote:
> > On Thu, Jun 25, 2020 at 02:10:10PM -0300, Luis Machado wrote:
> > > I have one point below I wanted to clarify regarding
> > > PEEKMTETAGS/POKEMTETAGS.
> > > 
> > > But before that, I've pushed v2 of the MTE series for GDB here:
> > > 
> > > https://sourceware.org/git/?p=binutils-gdb.git;a=shortlog;h=refs/heads/users/luisgpm/aarch64-mte-v2
> > > 
> > > That series adds sctlr and gcr registers to the NT_ARM_MTE (still using a
> > > dummy value of 0x407) register set. It would be nice if the Linux Kernel and
> > > the debuggers were in sync in terms of supporting this new register set. GDB
> > > assumes the register set exists if HWCAP2_MTE is there.
> > > 
> > > So, if we want to adjust the register set, we should probably consider doing
> > > that now. That prevents the situation where debuggers would need to do
> > > another check to confirm NT_ARM_MTE is exported. I'd rather avoid that.
> > 
> > I'm happy to do this before merging, though we need to agree on the
> > semantics.
> > 
> > Do you need both read and write access? Also wondering whether the
> 
> If I recall the previous discussion correctly, Kevin thought access to both
> of these would be interesting to the user. It sounded like having read-only
> access was enough. If so,...
> 
> > prctl() value would be a better option than the raw register bits (well,
> > not entirely raw, masking out the irrelevant part).
> 
> ... then exposing the most useful bits to the user would be better, and up
> to you to define.
> 
> I can tweak the GDB patches to turn the sctlr and gcr values into flag
> fields. Then GDB can just show those in a more meaningful way. I just need
> to know what the bits would look like.

We may have some software only behaviour added to these bits at some
point (e.g. deliver signal on return from syscall for faults on the
uaccess routines). They would not be represented in the SCTLR/GCR
registers.

> I'd rather not make these values writable if we don't think there is a good
> use case for it. Better avoid giving developers more knobs than they need?

There's the CRIU use-case for restoring this but I don't think we do it
for other prctl() controls.

-- 
Catalin
