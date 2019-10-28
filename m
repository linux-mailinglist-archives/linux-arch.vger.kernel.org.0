Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B5E6D34
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2019 08:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfJ1H0K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Oct 2019 03:26:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33115 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbfJ1H0K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Oct 2019 03:26:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so8678866wro.0
        for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2019 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=prOUiXWox/HxcvkYayavW/DPYzCaQqxoI6+PqjFxCYA=;
        b=cgaUkrlIhdeeD6Cr0srOiQYG2moclNeX5Rk4Pj9PNQXrjeDFRJLjMQHfnJFaW5MRmb
         J8FpiXXSoyqXJMjsuZjb0XVlpjOIhXyz50C1fEgZn1H+9TeDr8OvpzmXF4QFfYPX/xZN
         lvMKXCOpCqeQlsItZ5ZMSm/v/6GS0zDMTw6VgFMgb3kgE6bQPB/dfrSxMkYkp8TnXZS+
         OvlpmsL3/GeKh0YEwxw9s2gIgIURXg+a/rnjqYX+/HWiH9EncmjtbAfyQj+IdZ3hZ2Me
         SbBtPTrdMMSjZBMk8QdmIulBbYOA8ntvrW5+8CBZFxlU2HrKq5BlUWQcciUdqTpsCeoQ
         sYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=prOUiXWox/HxcvkYayavW/DPYzCaQqxoI6+PqjFxCYA=;
        b=FQytSWd3V+zeQFYi4/8ohv+/b0BZlfkEa22pcz6eRlTm4YALXLq2/3LkNWK9hgQ9+B
         b/7zpf9ZN25PN8whBLPzfuPaiJL7gUkDxgcuEj8kT8OJdIompD9Jwf2edS8cMKKEdkMt
         UB6GY7vy0OvB9tMjyF5eE77Cc1SlLsNGb4kXnFKsjClgxpaOaRLrjxKALB8Ri+hmKqmU
         TSwzUNAEZVIyPY7jyNi7TdrymWry+MjmJV7DnSM2kaav+TgqEkIbQf1N1OW1BE+8Tlp4
         cisTqLtwn5zhX5gItFESWg13IyHrn95qVTREdqHNx/JLBf5WmIspwWwWDeji5/Q+ZFLI
         ZUWg==
X-Gm-Message-State: APjAAAVGkeln09H48n/waKhB/bHJGIYo0x5Ho1V/oQOiXbi/yLQBmrhQ
        Gw1ZFmXf1HPKM94RQvKmmyIYKelc5g9r9dqE3MxKIYxMCmTpMA==
X-Google-Smtp-Source: APXvYqyfzXWBMruTRKGFX7mb8TpqkJiSawEwAPZNoZw6IfN/Mq1SjsqIvS9fvXPjlzp4nr8LWBSdM9R4jvbt9JQjffc=
X-Received: by 2002:adf:8289:: with SMTP id 9mr14647210wrc.0.1572247566613;
 Mon, 28 Oct 2019 00:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191019022048.28065-1-richard.henderson@linaro.org>
 <20191019022048.28065-2-richard.henderson@linaro.org> <20191024113239.GC4300@lakrids.cambridge.arm.com>
 <CAKv+Gu9uoJk8iqGASP3KvZK+4GMo=5ckD5DSzdOAmCJuOQNiUA@mail.gmail.com>
 <6e75d7b9-1c30-adab-bb74-1aaaa4e98ad4@linaro.org> <CAKv+Gu8A7vF0MQgVn6H2=Pjimnv0UUZt=1sce7aHr9BJ05_vzw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8A7vF0MQgVn6H2=Pjimnv0UUZt=1sce7aHr9BJ05_vzw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 28 Oct 2019 08:26:04 +0100
Message-ID: <CAKv+Gu8URysq6JUrXRSix=zW32JkzwkANUwoowU12PjRCOR9Pw@mail.gmail.com>
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

On Sun, 27 Oct 2019 at 19:40, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>
> On Sun, 27 Oct 2019 at 13:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 10/24/19 1:57 PM, Ard Biesheuvel wrote:
> > >>> +
> > >>> +#ifdef CONFIG_ARCH_RANDOM
> > >>> +
> > >>> +/*
> > >>> + * Note that these two interfaces, random and random_seed, are str=
ongly
> > >>> + * tied to the Intel instructions RDRAND and RDSEED.  RDSEED is th=
e
> > >>> + * "enhanced" version and has stronger guarantees.  The ARMv8.5-RN=
G
> > >>> + * instruction RNDR corresponds to RDSEED, thus we put our impleme=
ntation
> > >>> + * into the random_seed set of functions.
> > >>> + *
> > >
> > > Is that accurate? The ARM ARM says that RNDR is backed by a DRBG whic=
h
> > >
> > > ""
> > > ...is reseeded after an IMPLEMENTATION DEFINED number of random
> > > numbers has been generated and read
> > > using the RNDR register.
> > > """
> > >
> > > which means that you cannot rely on this reseeding to take place at a=
ll.
> > >
> > > So the way I read this, RNDR ~=3D RDRAND and RNDRRS ~=3D RDSEED, and =
we
> > > should wire up the functions below accordingly.
> >
> > No, that reading is not correct, and is exactly what I was trying to ex=
plain in
> > that paragraph.
> >
> > RNDR ~=3D RDSEED.
> >
> > It's a matter of standards conformance:
> >
> > RDRAND: NIST SP800-90A.
> >
> > RDSEED: NIST SP800-90B,
> >         NIST SP800-90C.
> >
> > RNDR:   NIST SP800-90A Rev 1,
> >         NIST SP800-90B,
> >         NIST SP800-22,
> >         FIPS 140-2,
> >         BSI AIS-31,
> >         NIST SP800-90C.
> >
>
> That is not what the ARM ARM says (DDI0487E.a K12.1):
>
> The *TRNG* that seeds the DRBG that backs both RNDR and RNDRRS should con=
form to
>
> =E2=80=A2 The NIST SP800-90B standard.
> =E2=80=A2 The NIST SP800-22 standard.
> =E2=80=A2 The FIPS 140-2 standard.
> =E2=80=A2 The BSI AIS-31 standard.
>
> This DRBG itself should conform to NIST SP800-90A Rev 1, and is
> reseeded at an implementation defined rate when RNDR is used, or every
> time when RNDRRS is used.
>
> So the output of the TRNG itself is not accessible directly, and both
> RNDR and RNDRRS return output generated by a DRBG. NIST SP800-90A
> suggests a minimum seed size of 440 bits, so using RNDRRS to generate
> 64-bit seeds is reasonable,

This isn't 100% accurate, but the point is that NIST SP800-90A defines
seed sizes for all DRBGs that exceed 64 bits, and so taking at most 64
bits of output from a DRBG seeded with 64+ bits of true entropy is a
reasonable approximation of using the seed directly. The downside, of
course, is that you need to call the instruction multiple times to get
a seed of the mandated size, and so from a certification POV, this may
still be problematic.

I brought this up some time ago, and suggested that we should have one
instruction to produce strong entropy, and one instruction to return
the output of the DRBG, with the ability to set the seed explicitly,
which would allow the true entropy from the first instruction to be
mixed with input from another source, in order to mitigate the trust
issues that affect RDRAND/RDSEED.


> even though it comes from a DRBG. But RNDR
> is definitely not equivalent to RDSEED.
>
