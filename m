Return-Path: <linux-arch+bounces-3650-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F1A8A3BEB
	for <lists+linux-arch@lfdr.de>; Sat, 13 Apr 2024 11:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AD21C20DDE
	for <lists+linux-arch@lfdr.de>; Sat, 13 Apr 2024 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50FA24A0D;
	Sat, 13 Apr 2024 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BRz/xMje"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359F1DFF5;
	Sat, 13 Apr 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713000465; cv=none; b=KSHA4bxpAL+69sXkpLUF1AXCfJWYAkV2brSJXBSjZBIg0IP2xilP63PG64j2pGGexpgQwD34dtvczmnp8uAE4T+xs0dqRLq+L330xJufnAym9jTBrfGpcePh0dW+gig1AlGm0bfb/ibHQBVbEgyUCI2+GdG337WgU5MPppYlV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713000465; c=relaxed/simple;
	bh=rsDou3yig95tjaZU/ZRDjjcvRLMm27lPOIafPxdw5B4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kfM9O4xOU5GL3bIufM4qyPq/SDOTCYexSYagci/qqRhjsPXnKegF8OmVFjuo/1WG0TpmE7No4q2M67Ti5wdEqFsCkj+wcM9K65+Piktj4Vz0nSDYXg/odcDyy4RGosjkdE44YuUMyZ3XHdO7wyhQkeoL8Lblmjzj+CvnNE0lVHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=BRz/xMje; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713000459;
	bh=3aewD2oJ5lCGPTd/q9AbSX1ze3K0D7ZipcutTcBOOjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BRz/xMjewXr7BMy3kMWgkeZJOsjd+wKW1GyUv4bUGLosF97Jk7ABL1DhG7HQ9+Hop
	 all7poKtpvnaLLCkzwXzF3QqmcT//I4w88f5Y0uuSF4Qtgvj6fxNSiI7IIqkhfgWKA
	 XVR2eRlygS8QCiNLOSJujhnLiHqR9Bd/9aGwlflun9+VojsvezdzXrMXjXstI0ufYz
	 eJmsRV64sfSRlHpd+Q4JbhyAbrR+pQknoEdCEHAzOrmCqyYARIFBUseRZebMjOWIyV
	 4PxwPqpeeWnR01lcwV9em2FoQpBmjoayJYUYNLDRMTuXfnpUB6VBHGTFajRBMht3fC
	 5drB7aG9b+pmA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VGp4T3FZBz4wyV;
	Sat, 13 Apr 2024 19:27:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Sean Christopherson
 <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
 <daniel.sneddon@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 1/3] x86/cpu: Actually turn off mitigations by default
 for SPECULATION_MITIGATIONS=n
In-Reply-To: <20240413115324.53303a68@canb.auug.org.au>
References: <20240409175108.1512861-1-seanjc@google.com>
 <20240409175108.1512861-2-seanjc@google.com>
 <20240413115324.53303a68@canb.auug.org.au>
Date: Sat, 13 Apr 2024 19:27:36 +1000
Message-ID: <87edb9d33r.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi Sean,
>
> I noticed this commit in linux-next.
>
> On Tue,  9 Apr 2024 10:51:05 -0700 Sean Christopherson <seanjc@google.com=
> wrote:
>>
>> Initialize cpu_mitigations to CPU_MITIGATIONS_OFF if the kernel is built
>> with CONFIG_SPECULATION_MITIGATIONS=3Dn, as the help text quite clearly
>> states that disabling SPECULATION_MITIGATIONS is supposed to turn off all
>> mitigations by default.
>>=20
>>   =E2=94=82 If you say N, all mitigations will be disabled. You really
>>   =E2=94=82 should know what you are doing to say so.
>>=20
>> As is, the kernel still defaults to CPU_MITIGATIONS_AUTO, which results =
in
>> some mitigations being enabled in spite of SPECULATION_MITIGATIONS=3Dn.
>>=20
>> Fixes: f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>  kernel/cpu.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 8f6affd051f7..07ad53b7f119 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -3207,7 +3207,8 @@ enum cpu_mitigations {
>>  };
>>=20=20
>>  static enum cpu_mitigations cpu_mitigations __ro_after_init =3D
>> -	CPU_MITIGATIONS_AUTO;
>> +	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
>> +						     CPU_MITIGATIONS_OFF;
>>=20=20
>>  static int __init mitigations_parse_cmdline(char *arg)
>>  {
>> --=20
>> 2.44.0.478.gd926399ef9-goog
>>=20
>
> I noticed because it turned off all mitigations for my PowerPC qemu
> boot tests - probably because CONFIG_SPECULATION_MITIGATIONS only
> exists in arch/x86/Kconfig ... thus for other architectures that have
> cpu mitigations, this will always default them to off, right?

Yep.

The patch has the effect of changing the default for non-x86 arches from
auto to off.

I see at least powerpc, arm64 and s390 use cpu_mitigations_off() and
will be affected.

cheers

