Return-Path: <linux-arch+bounces-7385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BD69847BA
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E281AB22EB6
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566181A76BD;
	Tue, 24 Sep 2024 14:32:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B2E3FE55;
	Tue, 24 Sep 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188349; cv=none; b=tIFYLVcQYZl1+eZMcNgen0my1YP2+K58UQCLCtaYNpyAcBbpXsiR5XI26OOIL/Q7JgjLyixpY+gD5Oe3w7pu0m9xgTYI2e7Myh9fyxxObDhnFzqqunnL0uqUDOUCgg1rM/MuXyQ94hCEnPfwL86k+Ns0j0XLjdZAHJ3tEJ22Sm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188349; c=relaxed/simple;
	bh=VaD/K3IXPoK+9i0CWDj73cl+KkPmR/f+7dcSIDVd+F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opt0BCQtc3qmCYQVQ1XIdM56cpG/Zgw+/atN0fILIxoG9I6hpn6Nps4djVtmIeMHdrRWSvOq4XwRBkC5C4bTv493PvHvpH5R5r3eD3pgcUyF1C0bTRHnUCSCZGP0+VfaoV+VfnufH/jF0ovai2Co3dsL8eesfiUrzPQcSjrAdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FD93DA7;
	Tue, 24 Sep 2024 07:32:56 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E4BC3F528;
	Tue, 24 Sep 2024 07:32:23 -0700 (PDT)
Message-ID: <90be383e-8177-45fb-9fe1-bf8adfcf5088@arm.com>
Date: Tue, 24 Sep 2024 15:32:22 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] vdso: Introduce vdso/page.h
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-5-vincenzo.frascino@arm.com>
 <f8256ade-c17f-46d1-bd4a-4d01235be5a0@app.fastmail.com>
 <645e5f3f-debf-4f68-ad75-4fb749b07a5b@arm.com>
 <bfd5cc30-f5fd-465a-b2d8-f0b35c018cda@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <bfd5cc30-f5fd-465a-b2d8-f0b35c018cda@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/09/2024 15:28, Christophe Leroy wrote:
> 'fault' is an 'u32' and 'mask' should be agnostic so the format should 
> be %x not %lx I think:
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c
> b/drivers/gpu/drm/i915/gt/intel_gt.c
> index a6c69a706fd7..352ef5e1c615 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt.c
> @@ -308,7 +308,7 @@ static void gen6_check_faults(struct intel_gt *gt)
>   		fault = GEN6_RING_FAULT_REG_READ(engine);
>   		if (fault & RING_FAULT_VALID) {
>   			gt_dbg(gt, "Unexpected fault\n"
> - "\tAddr: 0x%08lx\n"
> + "\tAddr: 0x%08x\n"
>   			       "\tAddress space: %s\n"
>   			       "\tSource ID: %d\n"
>   			       "\tType: %d\n",

Good catch Christoph. It makes sense, I did not notice the "l". I will add it to
my series.

-- 
Regards,
Vincenzo

