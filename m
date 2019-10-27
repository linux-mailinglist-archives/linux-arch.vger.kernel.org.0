Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E48E626A
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2019 13:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfJ0MOY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Oct 2019 08:14:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36339 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfJ0MOY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Oct 2019 08:14:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so6372874wmd.1
        for <linux-arch@vger.kernel.org>; Sun, 27 Oct 2019 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qBQMo15u4akqQ8NWGQMhJU3k9VWFJohiyePtcxAYFI0=;
        b=m+Ns1PWK3MtMBikb5UwssCdVywszYbdnMhaTRgL8sKmYeGT6RE9fiyhf3J/MDr5RfA
         BaArednT0VMLOUBKv7PfKn1qhFaWiRvXClzeLEkFq+zajN4GJWHqIrwFcZbubjD49cP3
         FAhqGdvROVaC1HyFsFzY+x+gmcRVk6tSPTrTKiK5upsEjpxOvLKQwbj5d3+Z5Dd6Vk/T
         1XXVvuk7boKDC3IjZ6tValvymLwPX6zsUoKrCY6qHlq8g8wD8uC/y4IfvdVzUZrxN4hW
         sBVxYzmfTtJu0D9FkyXtCv40hw28GPned5lzWmSM8mfPSlER0Fc3VMHfNqDEiTmO5OXw
         /Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qBQMo15u4akqQ8NWGQMhJU3k9VWFJohiyePtcxAYFI0=;
        b=nKxiwkVZkdcHXrQrgl23mZTdIHNYhpPsWIR2hjPQREjjnmKxRM5B8cud4FJa0YVnxq
         lRybizD2COlU88rc9cfb5+tywJqcJShBhvOQQI59XnoQjbFjH5jkQof3HC5URdqKwEbZ
         ju35Evq4/5TpjPRkP4skycL/de+o15i2wo6scasxCzeGGfIc6sIsR+qCicKrjJiNa+gd
         vG7Wmh0woXxZDSA2PzoB+OrhHxQ2FNtfyFOaurLBzhjM0IUA38eJdy22lfzNHqGrVpEy
         ecByHUdtdvjz0k5M0W4gkibvVQq344A3wjitIPz3ZA/pPEe9Kwjvvy2RAlAsjr6nQMW3
         92qw==
X-Gm-Message-State: APjAAAV0xtI8M0KbGC3b6yn8udP4lN1uHkw/wgE4WTedphe28w460quS
        /WMFQloMV74W4BbdMVJvb+7J6w==
X-Google-Smtp-Source: APXvYqzLaPnNvQm7J7MkxUO5AQPa6wp4y6EGKcMQmUZZ/UL7FmT2DLzKfGvffaK5m6eXeVZY4xvogw==
X-Received: by 2002:a05:600c:2212:: with SMTP id z18mr12347054wml.154.1572178459930;
        Sun, 27 Oct 2019 05:14:19 -0700 (PDT)
Received: from [10.81.2.50] ([109.190.253.14])
        by smtp.gmail.com with ESMTPSA id 74sm9397558wrm.92.2019.10.27.05.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 05:14:19 -0700 (PDT)
Subject: Re: [PATCH 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, Dave.Martin@arm.com, linux-arch@vger.kernel.org,
        ard.biesheuvel@linaro.org
References: <20191019022048.28065-1-richard.henderson@linaro.org>
 <20191019022048.28065-2-richard.henderson@linaro.org>
 <20191024113239.GC4300@lakrids.cambridge.arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bdadd4bf-1848-bef1-89c3-2d594cf3be16@linaro.org>
Date:   Sun, 27 Oct 2019 13:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024113239.GC4300@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/24/19 1:32 PM, Mark Rutland wrote:
> Please give this a menmoic in <asm/sysreg.h>, i.e.
> 
> #define SYS_RNDR	sys_reg(3, 3, 2, 4, 0)
> 
> ... and make this function:
> 
> static inline bool read_rndr(unsigned long *v)
> {
> 	unsigned long pass;
> 
> 	/*
> 	 * Reads of RNDR set PSTATE.NZCV to 0b0000 upon success, and set
> 	 * PSTATE.NZCV to 0b0100 otherwise.
> 	 */
> 	asm volatile(
> 		__mrs_s("%0", SYS_RNDR) "\n"
> 	"	cset %1, ne\n"
> 	: "=r" (*v), "=r" (pass);
> 	:
> 	: "cc");
> 
> 	return pass;
> }

Done.

> #define SYS_RNDRRS	sys_reg(3, 3, 2, 4, 1)
> 
> ...and here have:
> 
> static inline bool read_rndrrs(unsigned long *v)
> {
> 	unsigned long pass;
> 
> 	/*
> 	 * Reads of RNDRRS set PSTATE.NZCV to 0b0000 upon success, and
> 	 * set PSTATE.NZCV to 0b0100 otherwise.
> 	 */
> 	asm volatile (
> 		__mrs_s("%0", SYS_RNDRRS) "\n"
> 	"	cset %w1, ne\n"
> 	: "=r" (*v), "=r" (pass)
> 	:
> 	: "cc");
> 
> 	return pass;
> }

Done.

>> +static inline bool arch_get_random_seed_long(unsigned long *v)
>> +{
>> +	/* If RNDR fails, attempt to re-seed with RNDRRS.  */
>> +	return arch_has_random_seed() && (arm_rndr(v) || arm_rndrrs(v));
>> +}
> 
> Here we clobber the value at v even if the reads of RNDR and RNDRRS
> failed. Is that ok?

The x86 inline asm does, so I should think it is ok.

>> +#ifdef CONFIG_ARCH_RANDOM
>> +static bool can_use_rng(const struct arm64_cpu_capabilities *entry, int scope)
>> +{
>> +	unsigned long tmp;
>> +	int i;
>> +
>> +	if (!has_cpuid_feature(entry, scope))
>> +		return false;
>> +
>> +	/*
>> +	 * Re-seed from the true random number source.
>> +	 * If this fails, disable the feature.
>> +	 */
>> +	for (i = 0; i < 10; ++i) {
>> +		if (arm_rndrrs(&tmp))
>> +			return true;
>> +	}
> 
> The ARM ARM (ARM DDI 0487E.a) says:
> 
> | Reseeded Random Number. Returns a 64-bit random number which is
> | reseeded from the True Random Number source at an IMPLEMENTATION
> | DEFINED rate.
> 
> ... and:
> 
> | If the instruction cannot return a genuine random number in a
> | reasonable period of time, PSTATE.NZCV is set to 0b0100 and the data
> | value returned in UNKNOWN.
> 
> ... so it's not clear to me if the retry logic makes sense. Naively I'd
> expect "reasonable period of time" to include 10 attempts.
> 
> Given we'll have to handle failure elsewhere, I suspect that it might be
> best to assume that this works until we encounter evidence to the
> contrary.

Compare arch/x86/kernel/cpu/rdrand.c (x86_init_rdrand) and
arch/powerpc/platforms/powernv/rng.c (initialize_darn).

Both existing implementations have a small loop testing to see of the hardware
passes its own self-check at startup.  Perhaps it's simply paranoia, but it
didn't seem untoward to check.


>> +#ifdef CONFIG_ARCH_RANDOM
>> +	{
>> +		.desc = "Random Number Generator",
>> +		.capability = ARM64_HAS_RNG,
>> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
> 
> I strongly suspect we're going to encounter systems where this feature
> is mismatched, such that this can't be a boto CPU feature.
> 
> If we need entropy early in boot, we could detect if the boot CPU had
> the feature, and seed the pool using it, then later make use of a
> system-wide capability.

In the meantime, what do you suggest I place here and in
arch_has_random_seed(), so that it's at least detected early enough for the
boot cpu, but does not require support from all cpus?


r~
