Return-Path: <linux-arch+bounces-7114-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1C96F3AC
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 13:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301291C2441B
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6281CC171;
	Fri,  6 Sep 2024 11:52:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E771CC147;
	Fri,  6 Sep 2024 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623579; cv=none; b=bK31wh/r2RLors3SGupwrfwC20rUpq6UZjSS0KD9MNe8pLeWU5k+x5tlKz9WNeX31OOjkAhZ3BVY3xsmCNHRO/MyTfokruvW2krCFl6YZal+HBoTbf8Y37hQ2wvRDO3Hellxd+JnHnnlPvh3nxwKFtp+jXiK05ay+eMu1Nqb+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623579; c=relaxed/simple;
	bh=IKrZnhFDxnXq31XmUBrR57Qz8ZUzXA7i1uyXXW3VBPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIO/zIzLEvLo5B9MmZqt/6kKq/Mxesu6zarXx1yNzWWFIrfCba+mx4HAfld6WUMF5FwER/5yHyywMNHfTbwT+RNycX0kOoIyvrSd30tm8M4+oBbVzTwG3WExTgEuvJFbgLHl603CIRDj/eFQ+P7VfvVBp6s8rFpQqS5q24wyqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34291113E;
	Fri,  6 Sep 2024 04:53:24 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 612893F73B;
	Fri,  6 Sep 2024 04:52:54 -0700 (PDT)
Message-ID: <72f3d6cf-a03b-4a16-9983-77d3dd70b0ea@arm.com>
Date: Fri, 6 Sep 2024 12:52:52 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vdso: Modify getrandom to include the correct
 namespace
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-10-vincenzo.frascino@arm.com>
 <b899bce8-8704-4288-9f32-bcb2fa0d29a8@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <b899bce8-8704-4288-9f32-bcb2fa0d29a8@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/09/2024 18:26, Christophe Leroy wrote:
> 
> 
> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
...

> 
> Now build fails on powerpc because struct vgetrandom_opaque_params is unknown.
> 
> x86 get it by chance via the following header inclusion chain:
> 
> In file included from ./include/linux/random.h:10,
>                  from ./include/linux/nodemask.h:98,
>                  from ./include/linux/mmzone.h:18,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/xarray.h:16,
>                  from ./include/linux/radix-tree.h:21,
>                  from ./include/linux/idr.h:15,
>                  from ./include/linux/kernfs.h:12,
>                  from ./include/linux/sysfs.h:16,
>                  from ./include/linux/kobject.h:20,
>                  from ./include/linux/of.h:18,
>                  from ./include/linux/clocksource.h:19,
>                  from ./include/clocksource/hyperv_timer.h:16,
>                  from ./arch/x86/include/asm/vdso/gettimeofday.h:21,
>                  from ./include/vdso/datapage.h:164,
>                  from arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:7,
>                  from arch/x86/entry/vdso/vgetrandom.c:7:
> 
> 
> 
> 

This tells me very little ;)

Can you please provide more details? e.g. What is the error you are getting? How
do I reproduce it?

I am happy to include the required change as part of this series.

Overall, the reason why I am doing this exercise it to sanitize the headers for
all the architectures so that in future we do not have issues. It is good we
find problems now.

-- 
Regards,
Vincenzo

