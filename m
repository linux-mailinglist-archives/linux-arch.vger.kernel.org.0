Return-Path: <linux-arch+bounces-7384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42F9847A9
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F111C20A0C
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927911AAE1A;
	Tue, 24 Sep 2024 14:28:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993711AAE02;
	Tue, 24 Sep 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188105; cv=none; b=O2wRf8l17yHAi5mfpOp03tuvs6UZU0UKMee9g5yzseEdKNiLqBwqvNiLeXeOMY8r9uKOoBTGNdzMHSJL2dJVxKfac3Y4bV8+zjB5gfmN72lWgPODrDdYQEwnigA7UHR8tRLvK53Yof+yPLRUIGlcEjo7cAEpe9Cdil9b9Qs3DuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188105; c=relaxed/simple;
	bh=OMUtjr1Eu/jtX+GjVHvZet0AuJ7uPpMTCBj+4eqFAa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USH0KT95LLQ+7gyPNJJiqmw7h39YFVXQ8vfSZkpNpoIzqk+OQk1skZ321WZJNH5/c79c7YPK7B+5lQluVi1z8vxIVcUyQOqg3az1tWfi+zjUYS3xp8PWPvMd/x3MBkn2gZfBxb4pUGhNab35zzmKCcspZzfOtIUckPDtC7+V+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XChzg06DTz9sSZ;
	Tue, 24 Sep 2024 16:28:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ki0JqHY4FxX6; Tue, 24 Sep 2024 16:28:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XChzf6GBFz9sSK;
	Tue, 24 Sep 2024 16:28:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BC2948B76E;
	Tue, 24 Sep 2024 16:28:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id T3IA0DH180bA; Tue, 24 Sep 2024 16:28:14 +0200 (CEST)
Received: from [192.168.232.31] (unknown [192.168.232.31])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DE98B8B763;
	Tue, 24 Sep 2024 16:28:13 +0200 (CEST)
Message-ID: <bfd5cc30-f5fd-465a-b2d8-f0b35c018cda@csgroup.eu>
Date: Tue, 24 Sep 2024 16:28:13 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] vdso: Introduce vdso/page.h
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <645e5f3f-debf-4f68-ad75-4fb749b07a5b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/09/2024 à 16:10, Vincenzo Frascino a écrit :
> 
> 
> On 23/09/2024 17:54, Arnd Bergmann wrote:
>> On Mon, Sep 23, 2024, at 14:19, Vincenzo Frascino wrote:
>>> The VDSO implementation includes headers from outside of the
>>> vdso/ namespace.
>>>
>>> Introduce vdso/page.h to make sure that the generic library
>>> uses only the allowed namespace.
>>>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>> Thanks for the new version. This looks all good, just some
>> very minor ideas for how to possibly improve the new version:
>>
> 
> Thanks Arnd.
> 
>>> +/* PAGE_SHIFT determines the page size */
>>> +#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>>> +
>>> +#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
>>> +
>>> +#if defined(CONFIG_PHYS_ADDR_T_64BIT) && !defined(CONFIG_X86_64)
>>> +#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
>>> +#else
>>> +#define PAGE_MASK	(~(PAGE_SIZE-1))
>>> +#endif
>>
>> I would open-code the CONFIG_PAGE_SHIFT in PAGE_SIZE
>> and PAGE_MASK, just to avoid the extra indirection in the
>> preprocessor. This mainly has the benefit of slightly
>> shorter compiler warnings when all the macros get
>> traced back but can also slightly improve compile speed
>> in case this is used in deeply nested macros.
>>
> 
> I will fix it in the next iteration.
> 
>> Without a comment, the special case for CONFIG_X86_64
>> not very clear, and probably not needed. If you are
>> worried about introducing an architecture specific
>> regression, I would suggest instead explaining the
>> possible issue in the patch description but using the
>> more generic and simpler #ifdef check.
>>
> 
> If I do not add the #ifdef, it does not build. But you are right, I should have
> put a comment in the commit message.
> 
> Regression below:
> 
> drivers/gpu/drm/i915/gt/intel_gt_print.h:29:36: error: format ‘%lx’ expects
> argument of type ‘long unsigned int’, but argument 6 has type ‘u32’ {aka
> ‘unsigned int’} [-Werror=format=]
>     29 |         drm_dbg(&(_gt)->i915->drm, "GT%u: " _fmt, (_gt)->info.id,
> ##__VA_ARGS__)
>        |                                    ^~~~~~~~
> include/drm/drm_print.h:424:39: note: in definition of macro ‘drm_dev_dbg’
>    424 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
>        |                                       ^~~
> include/drm/drm_print.h:524:33: note: in expansion of macro ‘drm_dbg_driver’
>    524 | #define drm_dbg(drm, fmt, ...)  drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
>        |                                 ^~~~~~~~~~~~~~
> linux/drivers/gpu/drm/i915/gt/intel_gt_print.h:29:9: note: in expansion of macro
> ‘drm_dbg’
>     29 |         drm_dbg(&(_gt)->i915->drm, "GT%u: " _fmt, (_gt)->info.id,
> ##__VA_ARGS__)
>        |         ^~~~~~~
> drivers/gpu/drm/i915/gt/intel_gt.c:310:25: note: in expansion of macro ‘gt_dbg’
>    310 |                         gt_dbg(gt, "Unexpected fault\n"
>        |                         ^~~~~~
> 
> I am open to alternative suggestions.
> 


'fault' is an 'u32' and 'mask' should be agnostic so the format should 
be %x not %lx I think:

diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c 
b/drivers/gpu/drm/i915/gt/intel_gt.c
index a6c69a706fd7..352ef5e1c615 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -308,7 +308,7 @@ static void gen6_check_faults(struct intel_gt *gt)
  		fault = GEN6_RING_FAULT_REG_READ(engine);
  		if (fault & RING_FAULT_VALID) {
  			gt_dbg(gt, "Unexpected fault\n"
-			       "\tAddr: 0x%08lx\n"
+			       "\tAddr: 0x%08x\n"
  			       "\tAddress space: %s\n"
  			       "\tSource ID: %d\n"
  			       "\tType: %d\n",


Christophe

