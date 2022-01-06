Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28601486970
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 19:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiAFSNp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 13:13:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51594 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiAFSNo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 13:13:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 998CEB822E2
        for <linux-arch@vger.kernel.org>; Thu,  6 Jan 2022 18:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885EDC36AEB;
        Thu,  6 Jan 2022 18:13:40 +0000 (UTC)
Date:   Thu, 6 Jan 2022 18:13:37 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <YdcxUZ06f60UQMKM@arm.com>
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com>
 <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 06, 2022 at 10:09:35AM -0600, Jeremy Linton wrote:
> On 1/6/22 05:00, Catalin Marinas wrote:
> > On Wed, Jan 05, 2022 at 04:42:01PM -0600, Jeremy Linton wrote:
> > > So, mentally i'm having a hard time balancing the hypothetical problem laid
> > > out, as it should only really exist in an environment similar to the MDWE
> > > one, since AFAIK, its possible today to just flip it back off unless MDWE
> > > stops that from happening.
> > 
> > That's a user ABI change and given that the first attempt was shown to
> > break with some combination of old loader and new main executable (or
> > the other way around), I'd rather keep things as they are.
> 
> This should only change the behavior for for binaries which conform to the
> new ABI containing the BTI note. So outside of the tiny window of things
> built with BTI, but run on !BTI hardware or older kernel+glibc, this
> shouldn't be a problem. (Unless i'm missing something) Put another way, now
> is the time to make a change, before there is a legacy BTI ecosystem we have
> to deal with.

The concern is that the loader may decide in the future to not enable
(or turn off) BTI for some reason (e.g. mixed libraries, old glibc on
BTI hardware). If we force BTI on the main executable, we'd take this
option away. Note also that it's not only glibc here, there are other
loaders.

> > AFAICT MDWX wants (one of the filters) to prevent a previously writable
> > mapping from becoming executable through mprotect(PROT_EXEC). How common
> > is mprotect(PROT_EXEC|PROT_BTI) outside of the dynamic loader? I doubt
> > it is, especially in an MDWX environment. So can we not change the
> > filter to allow PROT_EXEC|PROT_BTI? If your code is already exploitable
> > to allow random syscalls, all bets are off anyway.
> 
> I would expect JITs to be twittling EXEC|BTI but, those wouldn't be able to
> trivially run under MDWE anyway. So rarely?
> 
> Changing the filter to allow PROT_EXEC|PROT_BTI defeats the purpose because
> the hypothetical exploit would just add the BTI tags and turn BTI on as
> well. The filter, as is, also provides additional BTI protections because it
> makes it more difficult to disable BTI. Without that filter it seems likely
> someone could come up with a way to use an existing PROT_EXEC as a gadget to
> disable BTI anywhere they choose.

To me, MDWX is more about protecting against making some (previously)
writable buffers executable (either inadvertently or as a programmer
decision). It's not meant to prevent the hijacking of the instruction
flow or data corruption that ends up as an mprotect(PROT_EXEC|PROT_BTI)
call. If that's possible, the MDWX mitigation is really negligible.

That said, the programmer may learn that passing PROT_BTI avoids the
filter and start using it, though it's not trivial due to the need for
landing pads.

> So, to your point before, BTI+MDWE are complementary, the combination seems
> considerably more robust than either by itself.

Before we come up with a better solution, I find allowing PROT_BTI an
acceptable compromise. I don't think we lose much with the current
codebase.

As for a better solution, we need to track the state of a memory range
as BPF denying PROT_EXEC anywhere is a pretty big hammer. We could add a
VM_WAS_WRITE flag and, in combination with a prctl() to opt in to the
feature, prevent mprotect(PROT_EXEC) on such vmas. No need for seccomp
bpf filters.

-- 
Catalin
