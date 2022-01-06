Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9BB48635D
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 12:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiAFLBD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 06:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiAFLBC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 06:01:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ED5C061245
        for <linux-arch@vger.kernel.org>; Thu,  6 Jan 2022 03:01:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF8B2B82042
        for <linux-arch@vger.kernel.org>; Thu,  6 Jan 2022 11:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78E5C36AF3;
        Thu,  6 Jan 2022 11:00:57 +0000 (UTC)
Date:   Thu, 6 Jan 2022 11:00:54 +0000
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
Message-ID: <YdbL5kIzi0xqVTVd@arm.com>
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com>
 <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jeremy,

On Wed, Jan 05, 2022 at 04:42:01PM -0600, Jeremy Linton wrote:
> On 1/4/22 11:32, Mark Brown wrote:
> > On Thu, Dec 09, 2021 at 11:10:48AM +0000, Szabolcs Nagy wrote:
> > > The 12/08/2021 18:23, Catalin Marinas wrote:
> > > > On Mon, Nov 15, 2021 at 03:27:10PM +0000, Mark Brown wrote:
> > > > > memory is already mapped with PROT_EXEC.  This series resolves this by
> > > > > handling the BTI property for both the interpreter and the main
> > > > > executable.
> > > > 
> > > > Given the silence on this series over the past months, I propose we drop
> > > > it. It's a bit unfortunate that systemd's MemoryDenyWriteExecute cannot
> > > > work with BTI but I also think the former is a pretty blunt hardening
> > > > mechanism (rejecting any mprotect(PROT_EXEC) regardless of the previous
> > > > attributes).
> > > 
> > > i still think it would be better if the kernel dealt with
> > > PROT_BTI for the exe loaded by the kernel.
> > 
> > The above message from Catalin isn't quite the full story here - my
> > understanding from backchannel is that there's concern from others that
> > we might be creating future issues by enabling PROT_BTI, especially in
> > the case where the same permissions issue prevents the dynamic linker
> > disabling PROT_BTI.  They'd therefore rather stick with the status quo
> > and not create any new ABI.  Unfortunately that's not something people
> > have been willing to say on the list, hopefully the above captures the
> > thinking well enough.
> > 
> > Personally I'm a bit ambivalent on this, I do see the potential issue
> > but I'm having trouble constructing an actual scenario and my instinct
> > is that since we handle PROT_EXEC we should also handle PROT_BTI for
> > consistency.
> 
> I'm hardly a security expert, but it seems to me that BTI hardens against a
> wider set of possible exploits than MDWE.

They are complementary features.

> Yet, we are silently turning it
> off for systemd services which are considered some of the most security
> critical things in the machine right now (ex:logind, etc). So despite
> 'systemd-analyze secuirty` flagging those services as the most secure ones
> on a system, they might actually be less secure.

Well, that's a distro decision. MDWE/MDWX is not something imposed by
the kernel but rather a seccomp bpf filter set up by systemd.

> It also seems that getting BTI turned on earlier, as this patch is doing is
> itself a win.
> 
> So, mentally i'm having a hard time balancing the hypothetical problem laid
> out, as it should only really exist in an environment similar to the MDWE
> one, since AFAIK, its possible today to just flip it back off unless MDWE
> stops that from happening.

That's a user ABI change and given that the first attempt was shown to
break with some combination of old loader and new main executable (or
the other way around), I'd rather keep things as they are.

> What are the the remaining alternatives? A new syscall? But that is by
> definition a new ABI,

A new ABI is better than changing the current ABI.

> and wouldn't benefit from having BTI turned on as early as this patch
> is doing.

In the absence of MDWX, it's not relevant how early the kernel turns BTI
on for the main executable. The dynamic loader would do this with an
mprotect() before actually executing any of the main code. Of course, we
assume there are no security bugs in the dynamic loader.

> Should we disable MDWE on a BTI machine? I'm
> not sure that is a good look, particularly if MDWE happens to successfully
> stop some exploit. AFAIK, MDWE+BTI are a good strong combination, it seems a
> shame if we can't get them both working together.

AFAICT MDWX wants (one of the filters) to prevent a previously writable
mapping from becoming executable through mprotect(PROT_EXEC). How common
is mprotect(PROT_EXEC|PROT_BTI) outside of the dynamic loader? I doubt
it is, especially in an MDWX environment. So can we not change the
filter to allow PROT_EXEC|PROT_BTI? If your code is already exploitable
to allow random syscalls, all bets are off anyway.

> I hesitate to suggest it, but maybe this patch should be conditional
> somehow, that way !systemd/MDWE machines can behave as they do today, and
> systemd/MDWE machines can request BTI be turned on by the kernel
> automatically?

That would be some big knob sysctl but I'm still not keen on toggling
the ABI like this.

-- 
Catalin
