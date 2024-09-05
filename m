Return-Path: <linux-arch+bounces-7082-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4696E18A
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 20:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185741F2531A
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1218B17ADE7;
	Thu,  5 Sep 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="XRn3JJ/w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66C15ADB4
	for <linux-arch@vger.kernel.org>; Thu,  5 Sep 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559708; cv=none; b=XWQQzSUn/BT1f/yxL4m99l0utmnByAM/qnzhgYZ5/YAdLGX8A9ydCWdaUpSbiHR+z5KSlnXs0+OMhTyUhI5rSBLGsUHK8VAlb60aM1p5zQX1SUG0WUq7LVypkg37nt/k8b5DGHYWUGG6nKTjQW3wTnc7VDKKTtsKvGlcAMOgWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559708; c=relaxed/simple;
	bh=yTjFB74aYheCz0jzkiyD05MEqttD3cBEB16TrrKu6ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTzZmeFFy/ZgbB/o5q6fvrJgC0kFlnF/UIqWZrRS+8bhXzarpmC6dEuI6wEELF3WxwjFAWavwiMUukELIetBvkX0VYi/NEetZKwSeHK8WaXuPtuq56eoOVowyqJy/DbpRI+l2MLzkY/1shkKw0BX1YxK9/ZDoKfeSrZa3ulN7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=XRn3JJ/w; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-5e172cc6d66so675413eaf.2
        for <linux-arch@vger.kernel.org>; Thu, 05 Sep 2024 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1725559705; x=1726164505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaax2KMv1pfmqcinOyW9AJBjnAW5CoEYUzGnm6PN3kM=;
        b=XRn3JJ/wxpgAJg5u1rMyafvgZEmDo7OAiVDkihVTT8nRzySm3XGHQa8dTttx8Q2mrz
         zrBiTyglFkD23YNZrK7UI6JzGwg4C8YDuiI9YZN0FKILglmGUNagWAOUtgdOOFyN9ofn
         mhG3t9/zkXZIsjgOi8Ubh/IVnm8FBr0afGdu/wjWDYAwgd5KImf+oYh87z6Cb3uPigAw
         p054fXDJTZ3cWXcOSRHN/7nNaTGD9G9QzdpzN58nGiorqQCfcTL2nqiNZ2uQ4r1fGbXh
         x1XsxCtjB/hzs3JkmPFA9mG1c+ikwNxJIEguHghXfvCNaL4SAVgPOpisq8YUcz/GiPg7
         xfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559705; x=1726164505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaax2KMv1pfmqcinOyW9AJBjnAW5CoEYUzGnm6PN3kM=;
        b=PGy8TCcBiLADpk+260ndCCKKCywYwMla3uLh+LJ6aDNe//6OfKfGiQiCVY9scyV/uo
         BUIsc+ydfxvnoLwGjhBfNx260CilypBC3/hB69T+mlLERDFlQx5rT4oNopBrvZ0xPVwD
         Xfu6nWBLcACrlZfNfLH7IuNH6NJCGwDNJJ1RDFJNFo/8X4KqnhBWoDS6/5gzAoDNzjT9
         5wGD67+41HVmLIYIOXjyOPpzHgo2jwxlOtVmcBNjeLXwSAZ9XejcSMKlE3vRz/+NCvp4
         oRpYGPUiR6z9gKhihdxVJiHENPEjIo7TpUrmHq4Be81b6OJC/jbHErtf47EeJLY5nO4c
         gpFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfJY7J9LijHLreyVTtQpkElJVoDCy624xpI5dbTNsW7IJvkB80jobAQh93FZSs9/JkqN40jG7gY76u@vger.kernel.org
X-Gm-Message-State: AOJu0YzErayzrE8Fb6NvQ1Z16d3CnWylA/boqkZaBvUUoTHJOzOAtkYV
	W6Tlevba1L3N3u1RTjrJbHG/NH/LX9Jnp1GxWPgawMXai9WaixWHHPfEQ4rn/w==
X-Google-Smtp-Source: AGHT+IElODMM0rQh4mddrzv/F5ovRuzJwZcdSq8FKd1lAPOBIO5XJpe1dPGMgoqhRfT//mb9dwT12Q==
X-Received: by 2002:a05:6358:3123:b0:1b5:fc87:f033 with SMTP id e5c5f4694b2df-1b8385d965amr10429755d.11.1725559704945;
        Thu, 05 Sep 2024 11:08:24 -0700 (PDT)
Received: from node0.kernel3.linux-mcdc-pg0.utah.cloudlab.us ([128.110.218.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201e43dasm9566796d6.46.2024.09.05.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:08:24 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: peterz@infradead.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code Coverage and MC/DC with Clang
Date: Thu,  5 Sep 2024 13:07:58 -0500
Message-ID: <20240905180758.1396234-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905114140.GN4723@noisy.programming.kicks-ass.net>
References: <20240905114140.GN4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024-09-05 06:41, Peter Zijlstra wrote:
> On Wed, Sep 04, 2024 at 11:32:41PM -0500, Wentao Zhang wrote:
>> From: Wentao Zhang <zhangwt1997@gmail.com>
>>
>> This series adds support for building x86-64 kernels with Clang's Source-
>> based Code Coverage[1] in order to facilitate Modified Condition/Decision
>> Coverage (MC/DC)[2] that provably correlates to source code for all levels
>> of compiler optimization.
>>
>> The newly added kernel/llvm-cov/ directory complements the existing gcov
>> implementation. Gcov works at the object code level which may better
>> reflect actual execution. However, Gcov lacks the necessary information to
>> correlate coverage measurement with source code location when compiler
>> optimization level is non-zero (which is the default when building the
>> kernel). In addition, gcov reports are occasionally ambiguous when
>> attempting to compare with source code level developer intent.
>>
>> In the following gcov example from drivers/firmware/dmi_scan.c, an
>> expression with four conditions is reported to have six branch outcomes,
>> which is not ideally informative in many safety related use cases, such as
>> automotive, medical, and aerospace.
>>
>>          5: 1068:	if (s == e || *e != '/' || !month || month > 12) {
>> branch  0 taken 5 (fallthrough)
>> branch  1 taken 0
>> branch  2 taken 5 (fallthrough)
>> branch  3 taken 0
>> branch  4 taken 0 (fallthrough)
>> branch  5 taken 5
>>
>> On the other hand, Clang's Source-based Code Coverage instruments at the
>> compiler frontend which maintains an accurate mapping from coverage
>> measurement to source code location. Coverage reports reflect exactly how
>> the code is written regardless of optimization and can present advanced
>> metrics like branch coverage and MC/DC in a clearer way. Coverage report
>> for the same snippet by llvm-cov would look as follows:
>>
>>   1068|      5|	if (s == e || *e != '/' || !month || month > 12) {
>>    ------------------
>>    |  Branch (1068:6): [True: 0, False: 5]
>>    |  Branch (1068:16): [True: 0, False: 5]
>>    |  Branch (1068:29): [True: 0, False: 5]
>>    |  Branch (1068:39): [True: 0, False: 5]
>>    ------------------
>>
>> Clang has added MC/DC support as of its 18.1.0 release. MC/DC is a fine-
>> grained coverage metric required by many automotive and aviation industrial
>> standards for certifying mission-critical software [3].
>>
>> In the following example from arch/x86/events/probe.c, llvm-cov gives the
>> MC/DC measurement for the compound logic decision at line 43.
>>
>>     43|     12|			if (msr[bit].test && !msr[bit].test(bit, data))
>>    ------------------
>>    |---> MC/DC Decision Region (43:8) to (43:50)
>>    |
>>    |  Number of Conditions: 2
>>    |     Condition C1 --> (43:8)
>>    |     Condition C2 --> (43:25)
>>    |
>>    |  Executed MC/DC Test Vectors:
>>    |
>>    |     C1, C2    Result
>>    |  1 { T,  F  = F      }
>>    |  2 { T,  T  = T      }
>>    |
>>    |  C1-Pair: not covered
>>    |  C2-Pair: covered: (1,2)
>>    |  MC/DC Coverage for Decision: 50.00%
>>    |
>>    ------------------
>>     44|      5|				continue;
>>
>> As the results suggest, during the span of measurement, only condition C2
>> (!msr[bit].test(bit, data)) is covered. That means C2 was evaluated to both
>> true and false, and in those test vectors C2 affected the decision outcome
>> independently. Therefore MC/DC for this decision is 1 out of 2 (50.00%).
>>
>> To do a full kernel measurement, instrument the kernel with
>> LLVM_COV_KERNEL_MCDC enabled, and optionally set a
>> LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS value (the default is six). Run the
>> testsuites, and collect the raw profile data under
>> /sys/kernel/debug/llvm-cov/profraw. Such raw profile data can be merged and
>> indexed, and used for generating coverage reports in various formats.
>>
>>    $ cp /sys/kernel/debug/llvm-cov/profraw vmlinux.profraw
>>    $ llvm-profdata merge vmlinux.profraw -o vmlinux.profdata
>>    $ llvm-cov show --show-mcdc --show-mcdc-summary                         \
>>               --format=text --use-color=false -output-dir=coverage_reports \
>>               -instr-profile vmlinux.profdata vmlinux
>>
>> The first two patches enable the llvm-cov infrastructure, where the first
>> enables source based code coverage and the second adds MC/DC support. The
>> next patch disables instrumentation for curve25519-x86_64.c for the same
>> reason as gcov. The final patch enables coverage for x86-64.
>>
>> The choice to use a new Makefile variable LLVM_COV_PROFILE, instead of
>> reusing GCOV_PROFILE, was deliberate. More work needs to be done to
>> determine if it is appropriate to reuse the same flag. In addition, given
>> the fundamentally different approaches to instrumentation and the resulting
>> variation in coverage reports, there is a strong likelihood that coverage
>> type will need to be managed separately.
>>
>> This work reuses code from a previous effort by Sami Tolvanen et al. [4].
>> Our aim is for source-based *code coverage* required for high assurance
>> (MC/DC) while [4] focused more on performance optimization.
>>
>> This initial submission is restricted to x86-64. Support for other
>> architectures would need a bit more Makefile & linker script modification.
>> Informally we've confirmed that arm64 works and more are being tested.
>>
>> Note that Source-based Code Coverage is Clang-specific and isn't compatible
>> with Clang's gcov support in kernel/gcov/. Currently, kernel/gcov/ is not
>> able to measure MC/DC without modifying CFLAGS_GCOV and it would face the
>> same issues in terms of source correlation as gcov in general does.
>>
>> Some demo and results can be found in [5]. We will talk about this patch
>> series in the Refereed Track at LPC 2024 [6].
>>
>> Known Limitations:
>>
>> Kernel code with logical expressions exceeding
>> LVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce a compiler warning.
>> Expressions with up to 47 conditions are found in the Linux kernel source
>> tree (as of v6.11), but 46 seems to be the max value before the build fails
>> due to kernel size. As of LLVM 19 the max number of conditions possible is
>> 32767.
>>
>> As of LLVM 19, certain expressions are still not covered, and will produce
>> build warnings when they are encountered:
>>
>> "[...] if a boolean expression is embedded in the nest of another boolean
>>   expression but separated by a non-logical operator, this is also not
>>   supported. For example, in x = (a && b && c && func(d && f)), the d && f
>>   case starts a new boolean expression that is separated from the other
>>   conditions by the operator func(). When this is encountered, a warning
>>   will be generated and the boolean expression will not be
>>   instrumented." [7]
>>
> 
> What does this actually look like in the generated code?
> 

Example 1: https://godbolt.org/z/PT6ssxdv1 (Taken from Message-ID:
<20210614153545.GA68749@worktop.programming.kicks-ass.net>) where counter
updates look like "inc qword ptr [rip + .L__profc_instr(int)]".

Example 2 with MC/DC: https://godbolt.org/z/ronMc578z where bitmap updates
look like "or byte ptr [rip + .L__profbm_instr(int)], 8".

> Where is the modification to noinstr ?
>

In both two examples the compiler is respecting
"__no_profile_instrument_function__" attribute, which is part of
"__no_profile" macro, which is in turn part of "noinstr" macro.

> What is the impact on certification of not covering the noinstr code.
> 
> 

Allow me to reformat Steve's <steven.h.vanderleest@boeing.com> reply below:

  -------------------------------------------------------------------------
  I'll answer Peter's last question: "What is the impact on certification
  of not covering the noinstr code."
 
  Any code in the target image that is not executed by a test (and thus not
  covered) must be analyzed and justified as an exception. For example,
  defensive code is often impossible to exercise by test, but can be
  included in the image with a justification to the regulatory authority
  such as the Federal Aviation Administration (FAA). In practice, this
  means the number of unique instances of non-instrumented code needs to be
  manageable.  I say "unique instances" because there may be many instances
  of a particular category, but justified by the same analysis/rationale.
  Where we specifically mark a section of code with noinstr, it is
  typically because the instrumentation would change the behavior of the
  code, perturbing the test results. With some analysis for each distinct
  category of this issue, we could then write justification(s) to show
  the overall coverage is sufficient.
 
  Regards,
  Steve
  -------------------------------------------------------------------------

Thanks,
Wentao


