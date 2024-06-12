Return-Path: <linux-arch+bounces-4852-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C4905B3D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 20:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14711C2081D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D6947F6B;
	Wed, 12 Jun 2024 18:41:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD84F1F8;
	Wed, 12 Jun 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217702; cv=none; b=lFIhXsKVvQCzTinFXpF4IXRR94mia9Q19LbktKsYg/BmPLISAfTSp04oixkeCRvaawTuZU4fUXiIF2iBx7QUVvF9cSWrofTo7pH4+ZAv6UHU6LZwP4uubu7cjWxA/fOHyxgCdaohon4UXZi0AAZRYUXygSmCZ3HkVQSFjdNSsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217702; c=relaxed/simple;
	bh=Si0NRG+Ce+hMN4fzIgccyq5264dCl0c7kRaWJDnjgZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSzngqgxUdfeQy8mf3SR+RJ60p2kuLwEi/olJwgbubb7+4GdgK3ysm6ybYK2pAHR5rmlrBPMpqZ9nxxjorFnEcWcu6gO9LsvGnoesWPKMDs1957i0VWBuXNAykykEQuhak+98Yo/wZ1dW5hPcym2KE4DPygQ11QYG3CGd/8tUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1DF31042;
	Wed, 12 Jun 2024 11:42:03 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6240E3F64C;
	Wed, 12 Jun 2024 11:41:37 -0700 (PDT)
Date: Wed, 12 Jun 2024 19:41:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 0/7] arm64 / x86-64: low-level code generation issues
Message-ID: <Zmnr3BjBkV4JxsIj@J2N7QTR9R3.cambridge.arm.com>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610204821.230388-1-torvalds@linux-foundation.org>

On Mon, Jun 10, 2024 at 01:48:14PM -0700, Linus Torvalds wrote:
> The last three patches are purely arm64-specific, and just fix up some
> nasty code generation in the user access functions.  I just noticed that
> I will need to implement 'user_access_save()' for KCSAN now that I do
> the unsafe user access functions. 
> 
> Anyway, that 'user_access_save/restore()' issue only shows up with
> KCSAN.  And it would be a no-op thanks to arm64 doing SMAP the right way
> (pet peeve: arm64 did what I told the x86 designers to do originally,
> but they claimed was too hard, so we ended up with that CLAC/STAC
> instead)... 
> 
> Sadly that "no-op for KCSAN" would is except for the horrid
> CONFIG_ARM64_SW_TTBR0_PAN case, which is why I'm not touching it.  I'm
> hoping some hapless^Whelpful arm64 person is willing to tackle this (or
> maybe make KCSAN and ARM64_SW_TTBR0_PAN incompatible in the Kconfig). 

Given how badly things go when we get this wrong (e.g. TLB corruption), I'd
like to say "just mark it incompatible", applying to all instrumentation, not
just KCSAN.

Any new microarchitecture since ~2014 has real HW PAN, and IIUC it's really
only Cortex-{A53,A57,A72} that don't have it, so I think it'd be fair to say
don't use sanitizers with SW PAN on those CPUs.

Otherwise, I came up with the below (untested). It's a bit horrid because we
could have instrumentation in the middle of __uaccess_ttbr0_{enable,disable}(),
and so we aways need the ISB just in case, and TBH I'm not sure that we use
user_access_{save,restore}() in all the places we should.

Mark.

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 30e2f8fa87a4..83301400ec4c 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -92,6 +92,38 @@ static inline void __uaccess_ttbr0_enable(void)
        local_irq_restore(flags);
 }
 
+static inline unsigned long user_access_ttbr0_save(void)
+{
+       if (!system_uses_ttbr0_pan())
+               return 0;
+
+       /*
+        * If TTBR1 has an ASID other than the reserved ASID, then we have an
+        * active user TTBR0 or are part-way through enabling/disabling TTBR0
+        * access.
+        */
+       if (read_sysreg(ttbr1_el1) & TTBR_ASID_MASK) {
+               __uaccess_ttbr0_disable();
+               return 1;
+       }
+
+       /*
+        * Instrumentation could fire during __uaccess_ttbr0_disable() between
+        * the final write to TTBR1 and before the trailing ISB. We need an ISB
+        * to ensure that we don't continue to use the old ASID.
+        */
+       isb();
+       return 0;
+}
+
+static inline void user_access_ttbr0_restore(unsigned long enabled)
+{
+       if (!system_uses_ttbr0_pan() || !enabled)
+               return;
+
+       __uaccess_ttbr0_enable();
+}
+
 static inline bool uaccess_ttbr0_disable(void)
 {
        if (!system_uses_ttbr0_pan())
@@ -117,8 +149,20 @@ static inline bool uaccess_ttbr0_enable(void)
 {
        return false;
 }
+
+static inline unsigned long user_access_ttbr0_save(void)
+{
+       return 0;
+}
+
+static inline void user_access_ttbr0_restore(unsigned long)
+{
+}
 #endif
 
+#define user_access_save       user_access_ttbr0_save
+#define user_access_restore    user_access_ttbr0_restore
+
 static inline void __uaccess_disable_hw_pan(void)
 {
        asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,

