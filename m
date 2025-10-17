Return-Path: <linux-arch+bounces-14187-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6C9BEBED3
	for <lists+linux-arch@lfdr.de>; Sat, 18 Oct 2025 00:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67C3D4ED70E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 22:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982D22DF99;
	Fri, 17 Oct 2025 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T175oJAm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF05354AEA;
	Fri, 17 Oct 2025 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760740382; cv=none; b=nFmTzVy63zEkyWZkoOf/diINLx3MMDQDDFB4/qoaJIxj3GiBypsIHZPNSAgSBifoxBRlgLnk85gi5Cj+zWbOhQTLiZIzy/tDHGGJ4pio9xL2qcJxDW9e5zF3pP8CTMqezocwv5StiE+z7tsDDbAunWXQ89rI11CC+j53MTTeCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760740382; c=relaxed/simple;
	bh=nlCO+kBfcVlCQ2VZ3wQCeZqCVn7zxJEtRAWM2dzn8qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZxQijDMpIlsdmz6an9xbew9/IRJLA7nPabmjDLAblCfO2bVNLNTMVIznnTkVSCjR0TZrGVTU4a59oPiL3oeL9ObZjv2G/b9ufQuDMWW7vDoJSWAllpBC9ibKCKddmN8kKEzwzTIF0Dl9dr7XRPuM82TAvH6TrhTAYdSfslAjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T175oJAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DDAC4CEE7;
	Fri, 17 Oct 2025 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760740382;
	bh=nlCO+kBfcVlCQ2VZ3wQCeZqCVn7zxJEtRAWM2dzn8qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T175oJAmn9OLZStM0Q6oEncixzNUfsg4s2doGLjQNoIgzT/hLslZQD/JYhLz1SVYb
	 MxOMSUR4NrnYenIwwWoXkQQufXxk6HjFVQpvHjQFLV5UwG1y5RSbqbWzc1XVw3LI0I
	 +v4abW7ixTQMWGGt+FZF3tUNg5jBbsmb1Z66O8/CdI0S/EtPyvwEaxM9PzllZhjckw
	 mfPUEWKj3ZczQm/DtTunj4Z8Ut/LhQDtn1ds9QvF3O2M+HgL1Z8J4LlWgHtyVw0LLI
	 WbZ7zp0yeh9ArQ423GW8xtDAih0Me/SWCCGrjGalJkc7ArM1EF7KzKgky862nsbvfx
	 /fw+FIejgJ7Lg==
Date: Fri, 17 Oct 2025 22:33:00 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v3 0/6] Hyper-V: Implement hypervisor core collection
Message-ID: <20251017223300.GB632885@liuwe-devbox-debian-v2.local>
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006224208.1060990-1-mrathor@linux.microsoft.com>

On Mon, Oct 06, 2025 at 03:42:02PM -0700, Mukesh Rathor wrote:
[...]
> Mukesh Rathor (6):
>   x86/hyperv: Rename guest crash shutdown function
>   hyperv: Add two new hypercall numbers to guest ABI public header
>   hyperv: Add definitions for hypervisor crash dump support
>   x86/hyperv: Add trampoline asm code to transition from hypervisor
>   x86/hyperv: Implement hypervisor RAM collection into vmcore
>   x86/hyperv: Enable build of hypervisor crashdump collection files
> 

Applied to hyperv-next. Thanks.

>  arch/x86/hyperv/Makefile        |   6 +
>  arch/x86/hyperv/hv_crash.c      | 642 ++++++++++++++++++++++++++++++++
>  arch/x86/hyperv/hv_init.c       |   1 +
>  arch/x86/hyperv/hv_trampoline.S | 101 +++++
>  arch/x86/include/asm/mshyperv.h |  13 +
>  arch/x86/kernel/cpu/mshyperv.c  |   5 +-
>  include/hyperv/hvgdk_mini.h     |   2 +
>  include/hyperv/hvhdk_mini.h     |  55 +++
>  8 files changed, 823 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/hyperv/hv_crash.c
>  create mode 100644 arch/x86/hyperv/hv_trampoline.S
> 
> -- 
> 2.36.1.vfs.0.0
> 

