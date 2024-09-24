Return-Path: <linux-arch+bounces-7387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295F984856
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 17:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AF31C21634
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 15:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517F1AAE2E;
	Tue, 24 Sep 2024 15:14:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509F1AAE24;
	Tue, 24 Sep 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190893; cv=none; b=bJHLr8FvQOMFyhssJ2v7CnlohjMr4ZV3Sv6m5yGv5MP3JJPdiE4eOHE6eQgmTUz9k3l1aFbTtCrXpo/O+S1X2YPArcJWXU69nh6trhRuraTj0beN5n+2OhOzQhpHyV6iNnPEZrgWLJ/IrTp1CsET1aqGULRvDvr9rH2gaIgYBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190893; c=relaxed/simple;
	bh=u3/C3kjkTmbS3zJ5uEvA7TiiRFA4ThNxCMyf1wIv2+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RI55d+uiExsBo+9Sfmz9tTmFigKsbx8GP2dLC5m9naD18pFs+CbXfWqfoVa7clhz3CDgvwBHOb0nQhrGvbhMYmGgHKzGnNQUwLEZjKJbgiyy4TbXfAt7RVhMXspCYGYlihsCcaYavqPSIHOsXuVNo3ZtTWOiIlEGFateg/4oZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A053DA7;
	Tue, 24 Sep 2024 08:15:20 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CEDE3F528;
	Tue, 24 Sep 2024 08:14:48 -0700 (PDT)
Message-ID: <64d9b7af-0b5f-4164-a97f-3b6f6792e84e@arm.com>
Date: Tue, 24 Sep 2024 16:14:46 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] vdso: Introduce uapi/vdso/random.h
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-8-vincenzo.frascino@arm.com>
 <ZvH1KKOJeq772enV@zx2c4.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <ZvH1KKOJeq772enV@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/09/2024 00:09, Jason A. Donenfeld wrote:
> On Mon, Sep 23, 2024 at 03:19:42PM +0100, Vincenzo Frascino wrote:
>> --- a/include/uapi/linux/random.h
>> +++ b/include/uapi/linux/random.h
>> @@ -44,30 +44,6 @@ struct rand_pool_info {
>>  	__u32	buf[];
>>  };
>>  
>> -/*
>> - * Flags for getrandom(2)
>> - *
>> - * GRND_NONBLOCK	Don't block and return EAGAIN instead
>> - * GRND_RANDOM		No effect
>> - * GRND_INSECURE	Return non-cryptographic random bytes
>> - */
>> -#define GRND_NONBLOCK	0x0001
>> -#define GRND_RANDOM	0x0002
>> -#define GRND_INSECURE	0x0004
>> -
>> -/**
>> - * struct vgetrandom_opaque_params - arguments for allocating memory for vgetrandom
>> - *
>> - * @size_per_opaque_state:	Size of each state that is to be passed to vgetrandom().
>> - * @mmap_prot:			Value of the prot argument in mmap(2).
>> - * @mmap_flags:			Value of the flags argument in mmap(2).
>> - * @reserved:			Reserved for future use.
>> - */
>> -struct vgetrandom_opaque_params {
>> -	__u32 size_of_opaque_state;
>> -	__u32 mmap_prot;
>> -	__u32 mmap_flags;
>> -	__u32 reserved[13];
>> -};
>> +#include <vdso/random.h>
>>  
>>  #endif /* _UAPI_LINUX_RANDOM_H */
>> diff --git a/include/uapi/vdso/random.h b/include/uapi/vdso/random.h
>> new file mode 100644
>> index 000000000000..5c80995129c2
>> --- /dev/null
>> +++ b/include/uapi/vdso/random.h
>> @@ -0,0 +1,38 @@
>> +
> 
> I really do not like this. This is UAPI, and it's linux/something.h
> style of UAPI. What does moving it to vdso/ accomplish except confusion
> for people looking where the code is and then polluting users'
> /usr/include with extra directories that aren't meaningful?
> 
> A change like this makes me think the approach taken by this patchset
> might not be the right one.

The rationale was explained in my comment on patch 1/8. If you do not like the
vdso/ namespace in uapi/ could you please let me know what is your preference is
isolating the parts needed by the vdso library?

-- 
Regards,
Vincenzo

