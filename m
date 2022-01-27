Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC349E24D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 13:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiA0MYW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jan 2022 07:24:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33480 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiA0MYV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jan 2022 07:24:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F45261A17
        for <linux-arch@vger.kernel.org>; Thu, 27 Jan 2022 12:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1264EC340E4;
        Thu, 27 Jan 2022 12:24:17 +0000 (UTC)
Date:   Thu, 27 Jan 2022 12:24:14 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <YfKO7r5l7AUvd8r/@arm.com>
References: <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
 <YdcxUZ06f60UQMKM@arm.com>
 <Ydc+AuagOD9GSooP@sirena.org.uk>
 <YdgrjWVxRGRtnf5b@arm.com>
 <YeWtRk0H30q38eM8@arm.com>
 <20220118110255.GC3294453@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118110255.GC3294453@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(Mark posted another series but I'm replying here to clarify some
aspects)

On Tue, Jan 18, 2022 at 11:02:55AM +0000, Szabolcs Nagy wrote:
> The 01/17/2022 17:54, Catalin Marinas wrote:
> > On Fri, Jan 07, 2022 at 12:01:17PM +0000, Catalin Marinas wrote:
> > > I think we can look at this from two angles:
> > > 
> > > 1. Ignoring MDWE, should whoever does the original mmap() also honour
> > >    PROT_BTI? We do this for static binaries but, for consistency, should
> > >    we extend it to dynamic executable?
> > > 
> > > 2. A 'simple' fix to allow MDWE together with BTI.
> > 
> > Thinking about it, (1) is not that different from the kernel setting
> > PROT_EXEC on the main executable when the dynamic loader could've done
> > it as well. There is a case for making this more consistent: whoever
> > does the mmap() should use the full attributes.
> 
> Yeah that was my original idea that it should be consistent.
> One caveat is that protection flags are normally specified
> in the program header, but the BTI marking is in
> PT_GNU_PROPERTY which is harder to get to, so glibc does not
> try to get it right for the initial mapping either: it has
> to re-mmap or mprotect. (In principle we could use read
> syscalls to parse the ELF headers and notes before mmap,
> but that's more complicated with additional failure modes.)
> 
> i.e. if (2) is fixed then mprotect can be used for library
> mapping too which is simpler than re-mmap.

I lost track of the userspace fixes here, was glibc changed to attempt a
re-mmap of the dynamic libraries instead of mprotect()?

It looks like (2) is a simpler fix and (1) could still be added for
consistency, it's complementary.

> > Question for the toolchain people: would the compiler ever generate
> > relocations in the main executable that the linker needs to resolve via
> > an mprotect(READ|WRITE) followed by mprotect(READ|EXEC)? If yes, we'd
> > better go for a proper MDWE implementation in the kernel.
> 
> There is some support for text relocations in glibc, but it's not
> expected to be common (e.g. it is a bug if a distro binary has it).

Thanks for the clarification.

-- 
Catalin
