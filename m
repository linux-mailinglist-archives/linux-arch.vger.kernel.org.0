Return-Path: <linux-arch+bounces-3651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FD8A3BFC
	for <lists+linux-arch@lfdr.de>; Sat, 13 Apr 2024 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9EFB217F1
	for <lists+linux-arch@lfdr.de>; Sat, 13 Apr 2024 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D6E24A0E;
	Sat, 13 Apr 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MjH6/odP"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA74A33;
	Sat, 13 Apr 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713001131; cv=none; b=H1lJi7TBTNOvkl96TPMOX6VtjXw0hcI2hZyik1Kff/Y7Z/4x1VhpPcd9xFYjfZlm1TQ1NHzmvAyvJ0E7tK1h4dn+btPKFKN69QMRTzq8Bqxy8jsCZy965P5W1matFi6P14yD9ihpn7pzgYM1jTLTyJV79cnsO/VQeRY/5Xu2YF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713001131; c=relaxed/simple;
	bh=Et+IhBjd7PuuxJ8wSo2dfIX801FnHMjyZhnA43uxaLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sb0Apn+oH02AdB5/LENvRHuRxKcyykBp9xd3R5Gid/wdBoGCJpYC5g40CVcUyXo7HnwBaJtuB88fEiSl864f6Hfdce5aZwS9J6haaEXOSbPPh0+iKTQpDSxwat/RR/DAVUUmPIoXiwwPwJJUHK3O/hGhll975ykZtljrq6GOYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MjH6/odP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713001128;
	bh=jPYPpXrOTdq14zbY1a5WM5rZP3IYtTcbIcNsjXlJspk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MjH6/odPeFgoAEfNG2rNSGt2thn4S+aADBoSLF86JXfv/dzzX80RNdWPYVPLWA4km
	 WABN2/vhWdwd4HsPSsxQNyWLQDu6QVoZfSOqmsukC9DZaJ0tj27yUlx4bgXQqGe+F6
	 7vE+canYaQukx6oxuedLYuJav6633yNYphxX7VCQoyIkzH+qRF7Pg0GQTWkWvhtGeC
	 TipxPPhkh9hRKBh6VFWbs16RXSaOOGQavzY0JWXgyoXZn8kw6AWo1ianMcDg4HVZWG
	 bMW6Uy37rKrath0YVIVn6h6nF4qu8QXvzFbrGlTW+nzI3LSrKdXLIihEZkUVcNx7C2
	 Znym4ghrFREwQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VGpKM2sTsz4wb2;
	Sat, 13 Apr 2024 19:38:47 +1000 (AEST)
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
In-Reply-To: <87edb9d33r.fsf@mail.lhotse>
References: <20240409175108.1512861-1-seanjc@google.com>
 <20240409175108.1512861-2-seanjc@google.com>
 <20240413115324.53303a68@canb.auug.org.au> <87edb9d33r.fsf@mail.lhotse>
Date: Sat, 13 Apr 2024 19:38:47 +1000
Message-ID: <87bk6dd2l4.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
...
>> On Tue,  9 Apr 2024 10:51:05 -0700 Sean Christopherson <seanjc@google.com> wrote:
...
>>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>>> index 8f6affd051f7..07ad53b7f119 100644
>>> --- a/kernel/cpu.c
>>> +++ b/kernel/cpu.c
>>> @@ -3207,7 +3207,8 @@ enum cpu_mitigations {
>>>  };
>>>  
>>>  static enum cpu_mitigations cpu_mitigations __ro_after_init =
>>> -	CPU_MITIGATIONS_AUTO;
>>> +	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
>>> +						     CPU_MITIGATIONS_OFF;
>>>  
>>>  static int __init mitigations_parse_cmdline(char *arg)
>>>  {

I think a minimal workaround/fix would be:

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..290be2f9e909 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -191,6 +191,10 @@ config GENERIC_CPU_AUTOPROBE
 config GENERIC_CPU_VULNERABILITIES
        bool

+config SPECULATION_MITIGATIONS
+       def_bool y
+       depends on !X86
+
 config SOC_BUS
        bool
        select GLOB

cheers

