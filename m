Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF673A83D8
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFOPZP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 11:25:15 -0400
Received: from foss.arm.com ([217.140.110.172]:38298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFOPZO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 11:25:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7EE9D6E;
        Tue, 15 Jun 2021 08:23:09 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B17323F70D;
        Tue, 15 Jun 2021 08:23:08 -0700 (PDT)
Date:   Tue, 15 Jun 2021 16:22:06 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, libc-alpha@sourceware.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20210615152203.GR4187@arm.com>
References: <20210604112450.13344-1-broonie@kernel.org>
 <43e67d7b-aab9-db1f-f74b-a87ba7442d47@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e67d7b-aab9-db1f-f74b-a87ba7442d47@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 10, 2021 at 11:28:12AM -0500, Jeremy Linton via Libc-alpha wrote:
> Hi,
> 
> On 6/4/21 6:24 AM, Mark Brown wrote:
> >Deployments of BTI on arm64 have run into issues interacting with
> >systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> >linked executables the kernel will only handle architecture specific
> >properties like BTI for the interpreter, the expectation is that the
> >interpreter will then handle any properties on the main executable.
> >For BTI this means remapping the executable segments PROT_EXEC |
> >PROT_BTI.
> >
> >This interacts poorly with MemoryDenyWriteExecute since that is
> >implemented using a seccomp filter which prevents setting PROT_EXEC on
> >already mapped memory and lacks the context to be able to detect that
> >memory is already mapped with PROT_EXEC.  This series resolves this by
> >handling the BTI property for both the interpreter and the main
> >executable.
> 
> I've got a Fedora34 system booting in qemu or a model with BTI enabled. On
> that system I took the systemd-resolved executable, which is one of the
> services with MDWE enabled, and replaced a number of the bti's with nops. I
> expect the service to continue to work with the fedora or mainline 5.13
> kernel and it does. If instead I boot with MDWE=no for the service, it
> should fail to start given either of those kernels, and it does.
> 
> Thus, I expect that with his patch applied to 5.13 the service will fail to
> start regardless of the state of MDWE, but it seems to continue starting
> when I set MDWE=yes. Same behavior with v1 FWTW.
> 
> Of course, there is a good chance I've messed something up or i'm missing
> something. I should really validate the /lib/ld-linux behavior itself too. I
> guess this could just as well be a glibc issue (f34 has glibc 2.33-5 which
> appears to have the re-mmap on failure patch). Either way, systemd-resolved
> is a LSB PIE, with /lib/ld-linux as its interpreter. I've not dug too deep
> into debugging this, cause I've got a couple other things I need to deal
> with in the next couple days, and I strongly dislike booting a full
> debug+system on the model. chuckle, sorry...

[...]

If the failure we're trying to detect is that BTI is undesirably left
off for the main executable, surely replacing BTIs with NOPs will make
no differenece?  The behaviour with PROT_BTI clear is strictly more
permissive than with PROT_BTI set, so I'm not sure we can test the
behaviour this way.

Maybe I'm missing sometihng / confused myself somewhere.

Looking at /proc/<pid>/maps after the process starts up may be a more
reliable approach, so see what the actual prot value is on the main
executable's text pages.

Cheers
---Dave
