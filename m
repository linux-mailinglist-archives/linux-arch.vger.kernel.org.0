Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C89DE8966
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbfJ2NYi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 09:24:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41003 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbfJ2NYi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 09:24:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id p26so5445815pfq.8
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=agBQg3hokpEDCA+5ypathVVcPR8JeMxOWdM5pD1vdDk=;
        b=TrOSRYkSgaYuSKiCgDaU15gZjZDUYotaZzKqMu2F8RK8gTrmuWL20FeYbA4KXJ3knN
         OvcPsfUQ7+sinyKas+FD8LK5cBHpFCZ2We5tTMg4cDcfYevPKgdw6fshB0FI0Knmuiz4
         AJivLs8afNcJ3EYvOsWXz0PJFuGJIQipugzhhxtyw//da1hckEnZTipWWK19ViJI+4T6
         AOoK+5eIReB/0LiFFAlq67r4rYxXihO/WHr2kn/XL6JEN6LdvwyMnbCOt+EUI4b7n5W7
         CYllX3PSmIeXuSZ1WgBW/oInAQpDblwRnyZScLLRz5p8eLmJ/WOZqKdGHXYKi1SXd8AU
         2qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=agBQg3hokpEDCA+5ypathVVcPR8JeMxOWdM5pD1vdDk=;
        b=TUPE+ZOX7SuMt0PtwtYnDhOgiDokhpo26viGsltri3E9jUyXjPTPeQ5AZg5iL5PTxc
         oWZLuP5lnoi0d9N2lEyzlK/0P7NSpz0BPUAX7G8chHG2XsLEut/xb+C7H6ImKmyUQciG
         SbZUyPsvYSmSk0JVesAZcaD5H/w1BNuGTDv7jJKegMHO9qJEjfgkELn9esjKf7l6WeRp
         YbNrDU4EGoehs3oshZGGTUPMIuD06eu8/Cr0dXpKmuHj+UUEiYWQ74ueNTn8rC40VUo0
         YMNy10UH6lEP+WjgWWR2EVSBO+4rCCan4SpOasca/ugtR6JwESnTaOblNoz7x8/ajsPO
         XeAQ==
X-Gm-Message-State: APjAAAWTzvhp5D8PizYZEllIczDvu33Oyv2CMBqSpDcZeBWosqf/Q06h
        Iv1Gu030KOzVA+vkgtIz7vECKw==
X-Google-Smtp-Source: APXvYqyBw9EuF2wA7EpWIyA4yR+S/tQc38xv6kLvb7CVNeXKvseSgzNPRoDaFui1dmABxAQdONo+eQ==
X-Received: by 2002:a63:c411:: with SMTP id h17mr27117887pgd.360.1572355477251;
        Tue, 29 Oct 2019 06:24:37 -0700 (PDT)
Received: from [192.168.43.94] ([172.58.27.50])
        by smtp.gmail.com with ESMTPSA id d14sm16439173pfh.36.2019.10.29.06.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 06:24:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, Dave.Martin@arm.com
References: <20191028203254.7152-1-richard.henderson@linaro.org>
 <20191028203254.7152-2-richard.henderson@linaro.org>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bfda9074-a866-d5d6-7f2a-3d91258a7113@linaro.org>
Date:   Tue, 29 Oct 2019 14:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028203254.7152-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/28/19 9:32 PM, richard.henderson@linaro.org wrote:
> +bool arch_get_random_long(unsigned long *v)
> +{
> +	bool ok;
> +
> +	preempt_disable_notrace();
> +
> +	ok = this_cpu_has_cap(ARM64_HAS_RNG);
> +	if (ok) {
> +		/*
> +		 * Reads of RNDR set PSTATE.NZCV to 0b0000 on success,
> +		 * and set PSTATE.NZCV to 0b0100 otherwise.
> +		 */
> +		asm volatile(
> +			__mrs_s("%0", SYS_RNDR_EL0) "\n"
> +		"	cset %w1, ne\n"
> +		: "=r"(*v), "=r"(ok)
> +		:
> +		: "cc");
> +
> +		if (unlikely(!ok)) {
> +			pr_warn_ratelimited("cpu%d: sys_rndr failed\n",
> +					    read_cpuid_id());
> +		}
> +	}
> +
> +	preempt_enable_notrace();
> +	return ok;
> +}
...
> +bool arch_get_random_seed_long(unsigned long *v)
> +{
> +	preempt_disable_notrace();
> +
> +	if (this_cpu_has_cap(ARM64_HAS_RNG)) {
> +		unsigned long ok, val;
> +
> +		/*
> +		 * Reads of RNDRRS set PSTATE.NZCV to 0b0000 on success,
> +		 * and set PSTATE.NZCV to 0b0100 otherwise.
> +		 */
> +		asm volatile(
> +			__mrs_s("%0", SYS_RNDRRS_EL0) "\n"
> +		"	cset %1, ne\n"
> +		: "=r"(val), "=r"(ok)
> +		:
> +		: "cc");
> +
> +		if (likely(ok)) {
> +			*v = val;
> +			preempt_enable_notrace();
> +			return true;
> +		}
> +
> +		pr_warn_ratelimited("cpu%d: sys_rndrrs failed\n",
> +				    read_cpuid_id());
> +	}
> +
> +	preempt_enable_notrace();
> +	return false;
> +}

Ho hum.  The difference in form between these two functions is unintentional.
I had peeked at the assembly for arch_get_random_long, tweaked the structure a
bit, and meant to copy the result to arch_get_random_seed_long, but forgot.

The first form above produces fewer register spills from gcc8.  I'll use that
for both for v3, supposing there are further comments to be addressed in review.


r~
