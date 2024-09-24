Return-Path: <linux-arch+bounces-7383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2365B98475A
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528961C22AA3
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2931A76AE;
	Tue, 24 Sep 2024 14:11:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39D1B85D5;
	Tue, 24 Sep 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187066; cv=none; b=KoT7WDvCznj8gfZQX2ubWTGCSKUcyZdWsIJcHK6un2SvhGl5FBA3aDqh7XhqPwjhjbHDT3Mgr1Xgbbx3gWHHIbXeeSCra5UDOEU+a9cEM1oz575BtzoMVObjAOkJhTJFxe5UCm6LG51krxjzsIYf0RyNC5dK33y5hgEb+NBArbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187066; c=relaxed/simple;
	bh=i5rmoElxEjHeqYioWgetey9pZgrZWLg5GZgY/JXJrpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm/xsNR28KXEJRJ7a9KlgmtQo6D5DqgD+SqI/O2+Ynw05kcFh5tWsHAZqXTwbFOpfc7RiAcIap8TcH1FCsoZU2bRBtRWKAerNxPaqOh3/7jAuAUJFLMuljp+z5kWiEJI4hHUjf1F3Knuy2oUrPuwDEQpp1REXLYbDdZnPmF8xoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D09F8DA7;
	Tue, 24 Sep 2024 07:11:31 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 149F13F528;
	Tue, 24 Sep 2024 07:10:59 -0700 (PDT)
Message-ID: <645e5f3f-debf-4f68-ad75-4fb749b07a5b@arm.com>
Date: Tue, 24 Sep 2024 15:10:58 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] vdso: Introduce vdso/page.h
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <f8256ade-c17f-46d1-bd4a-4d01235be5a0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/09/2024 17:54, Arnd Bergmann wrote:
> On Mon, Sep 23, 2024, at 14:19, Vincenzo Frascino wrote:
>> The VDSO implementation includes headers from outside of the
>> vdso/ namespace.
>>
>> Introduce vdso/page.h to make sure that the generic library
>> uses only the allowed namespace.
>>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Thanks for the new version. This looks all good, just some
> very minor ideas for how to possibly improve the new version:
> 

Thanks Arnd.

>> +/* PAGE_SHIFT determines the page size */
>> +#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>> +
>> +#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
>> +
>> +#if defined(CONFIG_PHYS_ADDR_T_64BIT) && !defined(CONFIG_X86_64)
>> +#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
>> +#else
>> +#define PAGE_MASK	(~(PAGE_SIZE-1))
>> +#endif
> 
> I would open-code the CONFIG_PAGE_SHIFT in PAGE_SIZE
> and PAGE_MASK, just to avoid the extra indirection in the
> preprocessor. This mainly has the benefit of slightly
> shorter compiler warnings when all the macros get
> traced back but can also slightly improve compile speed
> in case this is used in deeply nested macros.
> 

I will fix it in the next iteration.

> Without a comment, the special case for CONFIG_X86_64
> not very clear, and probably not needed. If you are
> worried about introducing an architecture specific
> regression, I would suggest instead explaining the
> possible issue in the patch description but using the
> more generic and simpler #ifdef check.
> 

If I do not add the #ifdef, it does not build. But you are right, I should have
put a comment in the commit message.

Regression below:

drivers/gpu/drm/i915/gt/intel_gt_print.h:29:36: error: format ‘%lx’ expects
argument of type ‘long unsigned int’, but argument 6 has type ‘u32’ {aka
‘unsigned int’} [-Werror=format=]
   29 |         drm_dbg(&(_gt)->i915->drm, "GT%u: " _fmt, (_gt)->info.id,
##__VA_ARGS__)
      |                                    ^~~~~~~~
include/drm/drm_print.h:424:39: note: in definition of macro ‘drm_dev_dbg’
  424 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
      |                                       ^~~
include/drm/drm_print.h:524:33: note: in expansion of macro ‘drm_dbg_driver’
  524 | #define drm_dbg(drm, fmt, ...)  drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
      |                                 ^~~~~~~~~~~~~~
linux/drivers/gpu/drm/i915/gt/intel_gt_print.h:29:9: note: in expansion of macro
‘drm_dbg’
   29 |         drm_dbg(&(_gt)->i915->drm, "GT%u: " _fmt, (_gt)->info.id,
##__VA_ARGS__)
      |         ^~~~~~~
drivers/gpu/drm/i915/gt/intel_gt.c:310:25: note: in expansion of macro ‘gt_dbg’
  310 |                         gt_dbg(gt, "Unexpected fault\n"
      |                         ^~~~~~

I am open to alternative suggestions.

>       Arnd

-- 
Regards,
Vincenzo

