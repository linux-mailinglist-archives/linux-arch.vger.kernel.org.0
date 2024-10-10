Return-Path: <linux-arch+bounces-7963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63499862B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 14:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC21C230D6
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B2A1C579C;
	Thu, 10 Oct 2024 12:36:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D011C462B;
	Thu, 10 Oct 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563813; cv=none; b=hgAcMEk7BSuZz3sPNq9PV8yZhRHNRK4PN35apDRXQTpoNLbDVtZ6O3Ggb5qFLZhPZvdB4kUFJ/GjthY4yntO5unX5ZaGoYpbb3GkgeA6rUJ47PmYthLQ+RYtr/+tzbijDknuFnwASDc329p+xwiFkKPHVu3kNQedJK9nK+C+Q2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563813; c=relaxed/simple;
	bh=pVDSF80j0A4ume/Fqt1zcet9gPAZJsn1kBAaKuL4GE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKmVsknYoWQSm0SvUS9OLyVqq5rSFK++oJqDQeClpR960/VZNOq9iHTg5TUb8SYrbpztW0tv8tdsioMrJSrxDuqqu3vqKzEsPi3JThfqgNGUFMX/hwummr/2AwkasPft/ros5gKMb2qMrOmI9KHKcrnWJzJlQaggbWrZy1ibyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D9CA497;
	Thu, 10 Oct 2024 05:37:20 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E41783F58B;
	Thu, 10 Oct 2024 05:36:47 -0700 (PDT)
Message-ID: <97dc6f9b-f8b9-425d-9962-3a6e2831679f@arm.com>
Date: Thu, 10 Oct 2024 13:36:46 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, "Jason A . Donenfeld"
 <Jason@zx2c4.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com> <87wmihr49g.ffs@tglx>
 <87ttdlr3s5.ffs@tglx>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <87ttdlr3s5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/10/2024 11:04, Thomas Gleixner wrote:
> On Wed, Oct 09 2024 at 11:53, Thomas Gleixner wrote:
>> On Thu, Oct 03 2024 at 16:29, Vincenzo Frascino wrote:
> 
> Hit send too early.
> 
>>> +#if defined(CONFIG_PHYS_ADDR_T_64BIT)
>>> +#define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
> 
> This really wants a comment. The magic reliance on integer sign
> expansion is any thing than obvious.
> 

Sure, I will add one. Thanks.

> Thanks,
> 
>          tglx

-- 
Regards,
Vincenzo

