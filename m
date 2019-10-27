Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A32E64EC
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2019 19:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfJ0SkK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Oct 2019 14:40:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfJ0SkK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Oct 2019 14:40:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1so136105wra.10
        for <linux-arch@vger.kernel.org>; Sun, 27 Oct 2019 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nWu85K/T7faCoglcFkP8fhjv7AQwKz42mtCuJHoWABs=;
        b=o/SKcafrYjc9Ziwf3n/OF2yhvTVI1388bAbiE1auE6FqZ1KPwZVebQmtnxVHPy+MLk
         lrf8Sr2kKkf+wyEyF22MKkZPtJXzs1aNVOj2zVgWUEPJbQ2x0u7odRBr2Z47nGmtIZbN
         tGAOsu6X7H5HrI1GvhC3I7GeVPkAvxQcsYkmOy5XKNYtfOsk2fF7ScLSvkSn0Lcy42U7
         tCjxqYF2QxWVfv2zX6rc84ELVDvyJ2YxFhFAqNoGwY9Mjb7xKYMMLuoOc7d6fkl/9A2G
         A8k/QcAXnGkNiS/7oC5+yzZmVz6f76hROd3x66rpamO6OXDm2Q7vQAmxpM5d+gUKgNty
         a7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nWu85K/T7faCoglcFkP8fhjv7AQwKz42mtCuJHoWABs=;
        b=Y07PcML6Vs35LBjoEiBkNTiZUjMfpyLKBUtr7KxX6oD9InOZ2RidpSdC0BOqGWU7d8
         4ZdLZqxASRzbF9ul7tZkTUjBK9SicfR5gxtPa1LTawf/SsLYvUuCrBXmvNR818Tpomd7
         ElMhhAWVNbQh0/mSWnBxo/eH9PhC2v+xHCxcaSKM5s8EnWSeefSCAeAZb0Oc2N2ZnXhb
         LaQDbRjp6jfOEju3nh0U3GAyZRNXOBTs0SGZPsEZFJUG5B26Np0VZhZUv+K+ppxNSQh1
         lYpiKjyOA/YXw58RR/IcWeapDzZjxOBldStPTdhdoTCFEsGvYWM0MIA842hcobryElup
         Q04w==
X-Gm-Message-State: APjAAAXGayZS8wq4p2lZ+gRlI98TWyS1j+YFhnubdTbJkKIvGHQvIiKr
        ddqEdzYXT3cGL61teOIGH3QKvrj/9M4G3guOc+3hQA==
X-Google-Smtp-Source: APXvYqzmoq0uExSNf010u9g+jeVlTGfR6fQ3vSZv8tPViwMredyuiKXF+74wI4Q5olyoRBtw8T/qW0Oj9iKXG+13JlQ=
X-Received: by 2002:adf:9f08:: with SMTP id l8mr11413768wrf.325.1572201606366;
 Sun, 27 Oct 2019 11:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191019022048.28065-1-richard.henderson@linaro.org>
 <20191019022048.28065-2-richard.henderson@linaro.org> <20191024113239.GC4300@lakrids.cambridge.arm.com>
 <CAKv+Gu9uoJk8iqGASP3KvZK+4GMo=5ckD5DSzdOAmCJuOQNiUA@mail.gmail.com> <6e75d7b9-1c30-adab-bb74-1aaaa4e98ad4@linaro.org>
In-Reply-To: <6e75d7b9-1c30-adab-bb74-1aaaa4e98ad4@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 27 Oct 2019 19:40:04 +0100
Message-ID: <CAKv+Gu8A7vF0MQgVn6H2=Pjimnv0UUZt=1sce7aHr9BJ05_vzw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 27 Oct 2019 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/24/19 1:57 PM, Ard Biesheuvel wrote:
> >>> +
> >>> +#ifdef CONFIG_ARCH_RANDOM
> >>> +
> >>> +/*
> >>> + * Note that these two interfaces, random and random_seed, are stron=
gly
> >>> + * tied to the Intel instructions RDRAND and RDSEED.  RDSEED is the
> >>> + * "enhanced" version and has stronger guarantees.  The ARMv8.5-RNG
> >>> + * instruction RNDR corresponds to RDSEED, thus we put our implement=
ation
> >>> + * into the random_seed set of functions.
> >>> + *
> >
> > Is that accurate? The ARM ARM says that RNDR is backed by a DRBG which
> >
> > ""
> > ...is reseeded after an IMPLEMENTATION DEFINED number of random
> > numbers has been generated and read
> > using the RNDR register.
> > """
> >
> > which means that you cannot rely on this reseeding to take place at all=
.
> >
> > So the way I read this, RNDR ~=3D RDRAND and RNDRRS ~=3D RDSEED, and we
> > should wire up the functions below accordingly.
>
> No, that reading is not correct, and is exactly what I was trying to expl=
ain in
> that paragraph.
>
> RNDR ~=3D RDSEED.
>
> It's a matter of standards conformance:
>
> RDRAND: NIST SP800-90A.
>
> RDSEED: NIST SP800-90B,
>         NIST SP800-90C.
>
> RNDR:   NIST SP800-90A Rev 1,
>         NIST SP800-90B,
>         NIST SP800-22,
>         FIPS 140-2,
>         BSI AIS-31,
>         NIST SP800-90C.
>

That is not what the ARM ARM says (DDI0487E.a K12.1):

The *TRNG* that seeds the DRBG that backs both RNDR and RNDRRS should confo=
rm to

=E2=80=A2 The NIST SP800-90B standard.
=E2=80=A2 The NIST SP800-22 standard.
=E2=80=A2 The FIPS 140-2 standard.
=E2=80=A2 The BSI AIS-31 standard.

This DRBG itself should conform to NIST SP800-90A Rev 1, and is
reseeded at an implementation defined rate when RNDR is used, or every
time when RNDRRS is used.

So the output of the TRNG itself is not accessible directly, and both
RNDR and RNDRRS return output generated by a DRBG. NIST SP800-90A
suggests a minimum seed size of 440 bits, so using RNDRRS to generate
64-bit seeds is reasonable, even though it comes from a DRBG. But RNDR
is definitely not equivalent to RDSEED.



>
> >>> + * Note as well that Intel does not have an instruction that corresp=
onds
> >>> + * to the RNDRRS instruction, so there's no generic interface for th=
at.
> >>> + */
>
> ...
>
> >>> +static inline bool arch_has_random(void)
> >>> +{
> >>> +     return false;
> >>> +}
> >>> +
> >>> +static inline bool arch_get_random_long(unsigned long *v)
> >>> +{
> >>> +     return false;
> >>> +}
> >>> +
> >>> +static inline bool arch_get_random_int(unsigned int *v)
> >>> +{
> >>> +     return false;
> >>> +}
> >>> +
> >>> +static inline bool arch_has_random_seed(void)
> >>> +{
> >>> +     return cpus_have_const_cap(ARM64_HAS_RNG);
> >>> +}
> >>> +
> >>> +static inline bool arch_get_random_seed_long(unsigned long *v)
> >>> +{
> >>> +     /* If RNDR fails, attempt to re-seed with RNDRRS.  */
> >>> +     return arch_has_random_seed() && (arm_rndr(v) || arm_rndrrs(v))=
;
> >>> +}
> >>
> >> Here we clobber the value at v even if the reads of RNDR and RNDRRS
> >> failed. Is that ok?
> >>
> >> Maybe we want the accessors to only assign to v upon success.
> >>
> >
> > I'd be more comfortable with this if arch_get_random_*() were
> > annotated as __must_check, and the assignment only done conditionally.
>
> We should probably make that change generically rather than make it arm64=
 specific.
>
> >>> +static bool can_use_rng(const struct arm64_cpu_capabilities *entry, =
int scope)
> >>> +{
> >>> +     unsigned long tmp;
> >>> +     int i;
> >>> +
> >>> +     if (!has_cpuid_feature(entry, scope))
> >>> +             return false;
> >>> +
> >>> +     /*
> >>> +      * Re-seed from the true random number source.
> >>> +      * If this fails, disable the feature.
> >>> +      */
> >>> +     for (i =3D 0; i < 10; ++i) {
> >>> +             if (arm_rndrrs(&tmp))
> >>> +                     return true;
> >>> +     }
> >>
> >> The ARM ARM (ARM DDI 0487E.a) says:
> >>
> >> | Reseeded Random Number. Returns a 64-bit random number which is
> >> | reseeded from the True Random Number source at an IMPLEMENTATION
> >> | DEFINED rate.
> >>
> >> ... and:
> >>
> >> | If the instruction cannot return a genuine random number in a
> >> | reasonable period of time, PSTATE.NZCV is set to 0b0100 and the data
> >> | value returned in UNKNOWN.
> >>
> >> ... so it's not clear to me if the retry logic makes sense. Naively I'=
d
> >> expect "reasonable period of time" to include 10 attempts.
> >>
> >> Given we'll have to handle failure elsewhere, I suspect that it might =
be
> >> best to assume that this works until we encounter evidence to the
> >> contrary.
> >>
> >
> > The architecture isn't very clear about what a reasonable period of
> > time is, but the fact that it can fail transiently suggests that
> > trying it only once doesn't make a lot of sense. However, I'm not sure
> > whether having a go at probe time is helpful in deciding whether we
> > can use it at all, and I'd be inclined to drop this test altogether.
> > This is especially true since we cannot stop EL0 or VMs at EL1 using
> > the instruction.
>
> As mentioned in reply to Mark specifically, the other two architectures d=
o the
> same thing.  From the comment for x86, I read this as "if something goes =
wrong,
> it's likely completely broken and won't work the first time we check".
>
> Yes, we can't prevent EL0 or VMs from using the insn, but we can avoid ha=
ving
> the kernel itself attempt to use it if the hardware self-check fails.
>
> OTOH, given that every user of arch_get_random() checks the result, and h=
as a
> fallback for failure, I suppose we don't need to do anything special.  Ju=
st use
> the insn and let Z=3D1 use the fallback failure path.
>
>
> r~
