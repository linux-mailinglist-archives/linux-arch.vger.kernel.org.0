Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC2E6276
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2019 13:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfJ0Mis (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Oct 2019 08:38:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55047 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJ0Mis (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Oct 2019 08:38:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so6643227wmk.4
        for <linux-arch@vger.kernel.org>; Sun, 27 Oct 2019 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O6LyMWE9tYXcmgrHLx3vYatFXBiSM7DX5IdEH59tDxA=;
        b=t/2gDG+72/qqqOL6gfsoY2A+Q8EUhTEdyf0lGyEEZeo1xafuJdvZ0gLIlNuwFv4wed
         eQFaFoY5yoGmGrE5dYFEeBQBlr5IWZ6sE5ZOOhgHUSKfTDzhayUpDewJyfHB8YAAct5U
         Agao4OCYYFp6PNwVYWHQCh3KmbwxjtYIry/bQov+XmV3TVVt6Kx6VrJTvUxGlOMRxmQN
         K7QN2kOdXvjP6HrwpP19nAk8OaRzLCa55tJ/9hLkG378q11may2tKLuIbsUrsnVxJ+Ne
         fabYVAlDHWzrKRmEwoXMwvbvtOX5yiQNFEQazfQnf3Znz9L/cQPeMAuFM3Kt+5/fFYqm
         nSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O6LyMWE9tYXcmgrHLx3vYatFXBiSM7DX5IdEH59tDxA=;
        b=EU6/zTsjlCZ7LOX0hmS3eBP/ul8LO7doSadQgEKGPIG0zWPTcPqAM5GpmFuR77nEes
         jnAwy4DtO3d3vE3DCb7AfvPI5HiCd3YfpiIAWJkbB2Hwj5wOo/fjREEpB1ZUdnqeiUHl
         WGfqWLRp1NUAqZ+mYYEhoWaSeAY3Yn6hnXTC5OOuosLBxoEYnrz3iwb+NYOW3zkm41Sx
         o7K49gh0wgYQg4tt+5+q2F3TaqdP9huGPZWAlDFp7ELSAllEgEScseE3/MbaM/OVTYNM
         6Ri9fo1voMNaB2sDKOAqDSnqgrkSc+qX/szPl/4L+slHAa5IHs61IjiShVkHvSiM4dxX
         qcrA==
X-Gm-Message-State: APjAAAU27tDeYkR248/NWBahRYyfoW5PAQ/kK5N00m1zY9Yq06PSBtdr
        FTAdZ+UsK8sFIhAJ/SFQOoW602kYhyMgUA==
X-Google-Smtp-Source: APXvYqyP+sKETBp5X/iTgiZ8j7XMiRu+sg1SlPNLrS5tKXCnTv9XGOxLcmQdnnFVTrBJzEL8m+6opw==
X-Received: by 2002:a1c:e08a:: with SMTP id x132mr11790218wmg.146.1572179925159;
        Sun, 27 Oct 2019 05:38:45 -0700 (PDT)
Received: from [10.81.2.50] ([109.190.253.14])
        by smtp.gmail.com with ESMTPSA id o6sm8082976wrx.89.2019.10.27.05.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 05:38:44 -0700 (PDT)
Subject: Re: [PATCH 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20191019022048.28065-1-richard.henderson@linaro.org>
 <20191019022048.28065-2-richard.henderson@linaro.org>
 <20191024113239.GC4300@lakrids.cambridge.arm.com>
 <CAKv+Gu9uoJk8iqGASP3KvZK+4GMo=5ckD5DSzdOAmCJuOQNiUA@mail.gmail.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6e75d7b9-1c30-adab-bb74-1aaaa4e98ad4@linaro.org>
Date:   Sun, 27 Oct 2019 13:38:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9uoJk8iqGASP3KvZK+4GMo=5ckD5DSzdOAmCJuOQNiUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/24/19 1:57 PM, Ard Biesheuvel wrote:
>>> +
>>> +#ifdef CONFIG_ARCH_RANDOM
>>> +
>>> +/*
>>> + * Note that these two interfaces, random and random_seed, are strongly
>>> + * tied to the Intel instructions RDRAND and RDSEED.  RDSEED is the
>>> + * "enhanced" version and has stronger guarantees.  The ARMv8.5-RNG
>>> + * instruction RNDR corresponds to RDSEED, thus we put our implementation
>>> + * into the random_seed set of functions.
>>> + *
> 
> Is that accurate? The ARM ARM says that RNDR is backed by a DRBG which
> 
> ""
> ...is reseeded after an IMPLEMENTATION DEFINED number of random
> numbers has been generated and read
> using the RNDR register.
> """
> 
> which means that you cannot rely on this reseeding to take place at all.
> 
> So the way I read this, RNDR ~= RDRAND and RNDRRS ~= RDSEED, and we
> should wire up the functions below accordingly.

No, that reading is not correct, and is exactly what I was trying to explain in
that paragraph.

RNDR ~= RDSEED.

It's a matter of standards conformance:

RDRAND: NIST SP800-90A.

RDSEED: NIST SP800-90B,
        NIST SP800-90C.

RNDR:   NIST SP800-90A Rev 1,
        NIST SP800-90B,
        NIST SP800-22,
        FIPS 140-2,
        BSI AIS-31,
        NIST SP800-90C.


>>> + * Note as well that Intel does not have an instruction that corresponds
>>> + * to the RNDRRS instruction, so there's no generic interface for that.
>>> + */

...

>>> +static inline bool arch_has_random(void)
>>> +{
>>> +     return false;
>>> +}
>>> +
>>> +static inline bool arch_get_random_long(unsigned long *v)
>>> +{
>>> +     return false;
>>> +}
>>> +
>>> +static inline bool arch_get_random_int(unsigned int *v)
>>> +{
>>> +     return false;
>>> +}
>>> +
>>> +static inline bool arch_has_random_seed(void)
>>> +{
>>> +     return cpus_have_const_cap(ARM64_HAS_RNG);
>>> +}
>>> +
>>> +static inline bool arch_get_random_seed_long(unsigned long *v)
>>> +{
>>> +     /* If RNDR fails, attempt to re-seed with RNDRRS.  */
>>> +     return arch_has_random_seed() && (arm_rndr(v) || arm_rndrrs(v));
>>> +}
>>
>> Here we clobber the value at v even if the reads of RNDR and RNDRRS
>> failed. Is that ok?
>>
>> Maybe we want the accessors to only assign to v upon success.
>>
> 
> I'd be more comfortable with this if arch_get_random_*() were
> annotated as __must_check, and the assignment only done conditionally.

We should probably make that change generically rather than make it arm64 specific.

>>> +static bool can_use_rng(const struct arm64_cpu_capabilities *entry, int scope)
>>> +{
>>> +     unsigned long tmp;
>>> +     int i;
>>> +
>>> +     if (!has_cpuid_feature(entry, scope))
>>> +             return false;
>>> +
>>> +     /*
>>> +      * Re-seed from the true random number source.
>>> +      * If this fails, disable the feature.
>>> +      */
>>> +     for (i = 0; i < 10; ++i) {
>>> +             if (arm_rndrrs(&tmp))
>>> +                     return true;
>>> +     }
>>
>> The ARM ARM (ARM DDI 0487E.a) says:
>>
>> | Reseeded Random Number. Returns a 64-bit random number which is
>> | reseeded from the True Random Number source at an IMPLEMENTATION
>> | DEFINED rate.
>>
>> ... and:
>>
>> | If the instruction cannot return a genuine random number in a
>> | reasonable period of time, PSTATE.NZCV is set to 0b0100 and the data
>> | value returned in UNKNOWN.
>>
>> ... so it's not clear to me if the retry logic makes sense. Naively I'd
>> expect "reasonable period of time" to include 10 attempts.
>>
>> Given we'll have to handle failure elsewhere, I suspect that it might be
>> best to assume that this works until we encounter evidence to the
>> contrary.
>>
> 
> The architecture isn't very clear about what a reasonable period of
> time is, but the fact that it can fail transiently suggests that
> trying it only once doesn't make a lot of sense. However, I'm not sure
> whether having a go at probe time is helpful in deciding whether we
> can use it at all, and I'd be inclined to drop this test altogether.
> This is especially true since we cannot stop EL0 or VMs at EL1 using
> the instruction.

As mentioned in reply to Mark specifically, the other two architectures do the
same thing.  From the comment for x86, I read this as "if something goes wrong,
it's likely completely broken and won't work the first time we check".

Yes, we can't prevent EL0 or VMs from using the insn, but we can avoid having
the kernel itself attempt to use it if the hardware self-check fails.

OTOH, given that every user of arch_get_random() checks the result, and has a
fallback for failure, I suppose we don't need to do anything special.  Just use
the insn and let Z=1 use the fallback failure path.


r~
