Return-Path: <linux-arch+bounces-14188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE0BEBF66
	for <lists+linux-arch@lfdr.de>; Sat, 18 Oct 2025 00:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F742356AEE
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF7723D7E7;
	Fri, 17 Oct 2025 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEZLflOS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CD215043;
	Fri, 17 Oct 2025 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760741854; cv=none; b=UG68j2kAdYx0vK2H0bTLS86OLQqxbk/uCewr1PGwkgabNipT86X0RAnTaqiTaF6c17o236FcYhG3NZj1CdT+7HJJDH8zEv3UdE6hMKS7OMDoBWtWo2Lh2ydFBqqqqKbmFjgem/GMBOHgB9I+T4Zu5Qny7uzdN38EUOe2pVJlJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760741854; c=relaxed/simple;
	bh=svjWuiZmHBkfKvpc+w6Z947Rrjkp/USyCf/FaWKrfgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2fP6piJ7+aV2EaoQolJpm4VITiMgfpqJGoa/tchF8iPu+sF2j51qXZSXVqCaqc5bsvYOyt4AJTU/OPA1zLLeUalPnvk0v4RfbDZjr9gMlvBufoT1qfnHIp5PEiJULu2c7Yp6mZzzm49JiBxWAjWmZM0TWT/V38HZVIVwI+T7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEZLflOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BF2C4CEE7;
	Fri, 17 Oct 2025 22:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760741854;
	bh=svjWuiZmHBkfKvpc+w6Z947Rrjkp/USyCf/FaWKrfgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEZLflOSs1zo/q+mt+9o9TpDYslgVwcu+w5YXUB5biXPts/NjEkeUC/NK1162hdXV
	 xqsfGOUht9rp93spTqqJpSH6uoG86EoYSA24OQjr56LBQ4OsAd84WuXxQ/I9xH0A2e
	 RiIrukaPdBqSjCyzM5yNnfXREsElWpv354e1ERzh+bdo0+BLhDHbPCfZgfKzlo/SFH
	 ff/m0en0KPFqmqTOhULg2HC75ya0lp+iY2nfw8RmhI02zHEhmmda1k3utYRW3Wbtdx
	 7amreqZKt7jueW4aEU6kGE9Het351jL8JLdbHksR6dH0sJ+9C0D79Y3wIXWZHakiKf
	 kCVQfXY+pVSFg==
Date: Fri, 17 Oct 2025 22:57:32 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v3 0/6] Hyper-V: Implement hypervisor core collection
Message-ID: <20251017225732.GC632885@liuwe-devbox-debian-v2.local>
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
 <20251017223300.GB632885@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017223300.GB632885@liuwe-devbox-debian-v2.local>

On Fri, Oct 17, 2025 at 10:33:00PM +0000, Wei Liu wrote:
> On Mon, Oct 06, 2025 at 03:42:02PM -0700, Mukesh Rathor wrote:
> [...]
> > Mukesh Rathor (6):
> >   x86/hyperv: Rename guest crash shutdown function
> >   hyperv: Add two new hypercall numbers to guest ABI public header
> >   hyperv: Add definitions for hypervisor crash dump support
> >   x86/hyperv: Add trampoline asm code to transition from hypervisor
> >   x86/hyperv: Implement hypervisor RAM collection into vmcore
> >   x86/hyperv: Enable build of hypervisor crashdump collection files
> > 
> 
> Applied to hyperv-next. Thanks.

This breaks i386 build.

/work/linux-on-hyperv/linux.git/arch/x86/hyperv/hv_init.c: In function ‘hyperv_init’:
/work/linux-on-hyperv/linux.git/arch/x86/hyperv/hv_init.c:557:17: error: implicit declaration of function ‘hv_root_crash_init’ [-Werror=implicit-function-declaration]
  557 |                 hv_root_crash_init();
      |                 ^~~~~~~~~~~~~~~~~~

That's because CONFIG_MSHV_ROOT is only available on x86_64. And the
crash feature is guarded by CONFIG_MSHV_ROOT.

Applying the following diff fixes the build.

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e28737ec7054..c1300339d2eb 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -554,7 +554,9 @@ void __init hyperv_init(void)
                memunmap(src);

                hv_remap_tsc_clocksource();
+#ifdef CONFIG_X86_64
                hv_root_crash_init();
+#endif
        } else {
                hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
                wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);

> 
> >  arch/x86/hyperv/Makefile        |   6 +
> >  arch/x86/hyperv/hv_crash.c      | 642 ++++++++++++++++++++++++++++++++
> >  arch/x86/hyperv/hv_init.c       |   1 +
> >  arch/x86/hyperv/hv_trampoline.S | 101 +++++
> >  arch/x86/include/asm/mshyperv.h |  13 +
> >  arch/x86/kernel/cpu/mshyperv.c  |   5 +-
> >  include/hyperv/hvgdk_mini.h     |   2 +
> >  include/hyperv/hvhdk_mini.h     |  55 +++
> >  8 files changed, 823 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/x86/hyperv/hv_crash.c
> >  create mode 100644 arch/x86/hyperv/hv_trampoline.S
> > 
> > -- 
> > 2.36.1.vfs.0.0
> > 

