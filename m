Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367E846DAF9
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 19:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbhLHS1W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 13:27:22 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41372 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbhLHS1W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 13:27:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CCE1DCE2321
        for <linux-arch@vger.kernel.org>; Wed,  8 Dec 2021 18:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1114AC341C8;
        Wed,  8 Dec 2021 18:23:43 +0000 (UTC)
Date:   Wed, 8 Dec 2021 18:23:40 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <YbD4LKiaxG2R0XxN@arm.com>
References: <20211115152714.3205552-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115152714.3205552-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 15, 2021 at 03:27:10PM +0000, Mark Brown wrote:
> Deployments of BTI on arm64 have run into issues interacting with
> systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> linked executables the kernel will only handle architecture specific
> properties like BTI for the interpreter, the expectation is that the
> interpreter will then handle any properties on the main executable.
> For BTI this means remapping the executable segments PROT_EXEC |
> PROT_BTI.
> 
> This interacts poorly with MemoryDenyWriteExecute since that is
> implemented using a seccomp filter which prevents setting PROT_EXEC on
> already mapped memory and lacks the context to be able to detect that
> memory is already mapped with PROT_EXEC.  This series resolves this by
> handling the BTI property for both the interpreter and the main
> executable.
> 
> This does mean that we may get more code with BTI enabled if running on
> a system without BTI support in the dynamic linker, this is expected to
> be a safe configuration and testing seems to confirm that. It also
> reduces the flexibility userspace has to disable BTI but it is expected
> that for cases where there are problems which require BTI to be disabled
> it is more likely that it will need to be disabled on a system level.

Given the silence on this series over the past months, I propose we drop
it. It's a bit unfortunate that systemd's MemoryDenyWriteExecute cannot
work with BTI but I also think the former is a pretty blunt hardening
mechanism (rejecting any mprotect(PROT_EXEC) regardless of the previous
attributes).

I'm not a security expert to assess whether MDWX is more important than
BTI (hardware availability also influences the distros decision). My
suggestion would be to look at a better way to support the MDWX on the
long run that does not interfere with BTI.

-- 
Catalin
