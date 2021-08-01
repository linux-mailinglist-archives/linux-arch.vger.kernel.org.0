Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8CB3DCC2A
	for <lists+linux-arch@lfdr.de>; Sun,  1 Aug 2021 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhHAO4j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Aug 2021 10:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbhHAO4j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 1 Aug 2021 10:56:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54A17610A1;
        Sun,  1 Aug 2021 14:56:28 +0000 (UTC)
Date:   Sun, 1 Aug 2021 07:56:25 -0700
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH v5 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20210801145623.GA28489@arm.com>
References: <20210719164536.19143-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719164536.19143-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 19, 2021 at 05:45:32PM +0100, Mark Brown wrote:
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

One last call on this series as I'd like to at least have it in -next
for a few weeks if we are to upstream it. Adding people that have been
involved on the previous longer discussion:

https://lore.kernel.org/r/8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com

The glibc issue has been solved in the sense that if mprotect() fails,
the error is ignored and we end up with BTI disabled for the main
executable.

This series aims to change the responsibility for PROT_BTI on the main
(dynamic) executable from the dynamic linker to the kernel. It doesn't
come without risks though. Suppose that the dynamic linker in the future
decides that it's not safe to mix BTI/non-BTI for some objects, it won't
have a way to disable BTI on the main executable if MDWX is enabled.

It's a trade-off between the risks introduced by this series vs
the benefits of MDWX. If the risk is non-negligible, the next step is
assessing the importance of MDWX vs BTI on arm64 and whether we should
look for alternatives to MDWX in the future (ideally which don't involve
new flags to mprotect()).

Thanks.

-- 
Catalin
