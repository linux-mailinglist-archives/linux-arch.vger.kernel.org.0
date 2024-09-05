Return-Path: <linux-arch+bounces-7061-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E1996D87A
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 14:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6567C1C22241
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA919D8BF;
	Thu,  5 Sep 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEYnInWP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326219B580;
	Thu,  5 Sep 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539111; cv=none; b=gopexHNsT4Z1x/LyiGu5MuHVX8qFugASWN78bmxA7luIkn4nzSgVwETMvsJ5MK+R7NNvD6feYE7dGQAWGd9rfDzNn6rc/v78+QvHM3eMUw+5cFryBRfOMsDMr35Au4y/+3Fk5U45enN3s3FqaA15SnEQUrq5n4IMIZgzEX+0aa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539111; c=relaxed/simple;
	bh=+P20f2/lA6FyDhXA4/LRi61DPB0GFC1v6U7/x0C+lJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s9bUgSQKA0hoAGK5N7xDOi9EN+gnXafCcgIGBZieb1nhFkzfjymhsSwk6lPXtP4QIQICbIlKSc6tQiGwnfGLDe/1+9IB9lnrAGV7xH3pbA7Fn9jyvAwabxgG2MjdCPZ0NQQ5r00KWU1wJXFFYnre3Gu40Pt7XWkHGD4lR0tAA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEYnInWP; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-846bdc20098so174725241.3;
        Thu, 05 Sep 2024 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725539108; x=1726143908; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec2nsMBqzxzvelNvMAldupgf12S8fKDigkxZKpeq0bY=;
        b=cEYnInWPXuxYY8fk6m/adFw88PLbTgDkz7TS6KvEyFFwZuWHiq0RJDrKXWcAwdMHwE
         mPE1govveicWP6UTcitjURgVpWL0JnSAZ6fdIwoMPTjLTr/Y56XBgzf5ubvZUe2vuvJ7
         psztGIuUOFnKpuheBI+EXh6hTU3U18hmoj0eBjpu4R1Btfj2jVIMJovecDPrGQyLJz/k
         957ASy92OrRq6uqhQ/8XvviJ8xuo4dBLwQ1V7gPMQFHQmskXzZ9sslP5n3Z90BXwzJ6l
         1oWaWWiacJc/dDIbzTn6Ql9YddrclcYTt1+cEFO4J3IHqqzs6SQypnWv5M9XOe1shilH
         HARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539108; x=1726143908;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec2nsMBqzxzvelNvMAldupgf12S8fKDigkxZKpeq0bY=;
        b=TJmQJMXuS8zafCCH7RH83Z2iIWcQaKJnKdI1CYjWQuCGOAJ/KY11+HxJBc8uQlp4Xq
         1SEoEn1LHW+2D2AMNnBpqWCcTpYsN0oOTkI3aUOmTZNeeEU/Fj6fH09W+afRL30mDMpw
         ej9ccAKjFnEKjZC1iz28YweP3gm/V7vRONgEz+h52NKWCXUmthhkGYXVBeFyC+AzP2qe
         LiQnm2iqA4zrCj3Fch7d1kq+n6JD76idVIfZ6aC5yMMueDxMsZ2OBbbi7VvxWB4IHejX
         4u2UYWF48GNW6/jgtRtyemvQ/2Wh3nSPmYn5x3ou2C+7dWwlZ10Kc/CumWQYOu+hK3Um
         uIpA==
X-Forwarded-Encrypted: i=1; AJvYcCU1SSMI6EhCrdT4vmmEzyD7ezGMkGFpd5KP6iZhKUWgLckCEFdiaJqA9WjM2Gagcmq3KvHWBRO6irHG@vger.kernel.org, AJvYcCUyaNOS/i0FBqjsbn4iijFvocrK7dzTfo4w2c40vpREvAqo9PB+HRyxAEWQBQw60rzdNBfddJTLL/gn7ZFr@vger.kernel.org, AJvYcCVo/1VbXlWY+XfT5pwIfcwCtToC6ksdSeoViUA9e8pWQgabfPJa4GwGf6jecILEZaAbmo8hLP0G9Vqcwmlz@vger.kernel.org, AJvYcCX+6wdmaLIbEqRDMSxAjuAHG7pgx2KpDviB54vw0j5cnX89IWB0fvTcJ5ZRVnwE5lesp9HHxLuhvWvl@vger.kernel.org, AJvYcCXzgRBpULrZUL9iwwp1SPGPQ85Kv+6FzhVLe4+TXkj+hbFMFBCgT6srO2kWF48CgHFC+NvgpWE6qW+CHPKoI+d5obax@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKquJ4/NOGq9X7ZhSXY7mvQQvyyXJyzXIJeLoSJvZ3IQBQS2h
	ta2vgJE0c4N+VItwlZH5Tj5FyRRPOfZV/5kzmcmayF7SJfx5Vx3A7SCo5TfiWpiLnOC6/GaZMZ5
	/dQuVEZMV0kgG2WuXYscSOJyzi3/QvQ==
X-Google-Smtp-Source: AGHT+IHZEJjH8/gtSsjvQASanUqSRmY2T9fuhxa/99968SgqrDbqt8oSvB+k03KFDIu4+Was3fpAxP6x6xR2pHe87fk=
X-Received: by 2002:a05:6102:5107:b0:494:3a8d:c793 with SMTP id
 ada2fe7eead31-49a775f23e8mr20798867137.28.1725539108252; Thu, 05 Sep 2024
 05:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu> <20240905114140.GN4723@noisy.programming.kicks-ass.net>
 <BN0P110MB1785427A8771BD53DADB2E4DAB9DA@BN0P110MB1785.NAMP110.PROD.OUTLOOK.COM>
 <BN0P110MB1785CA856C1898EEC22ACD7EAB9DA@BN0P110MB1785.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <BN0P110MB1785CA856C1898EEC22ACD7EAB9DA@BN0P110MB1785.NAMP110.PROD.OUTLOOK.COM>
From: Steve VanderLeest <steven.h.vanderleest@gmail.com>
Date: Thu, 5 Sep 2024 08:24:56 -0400
Message-ID: <CAKq3nP32+AR3gLY00p0KaGx_zGXTxSC6wOr08NP_zaUGU1zKGg@mail.gmail.com>
Subject: Re: FW: [EXTERNAL] Re: [PATCH v2 0/4] Enable measuring the kernel's
 Source-based Code Coverage and MC/DC with Clang
To: "llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending as plain text so that lists can accept.

On Thu, Sep 5, 2024 at 8:21=E2=80=AFAM Vanderleest (US), Steven H
<steven.h.vanderleest@boeing.com> wrote:
>
> From: Vanderleest (US), Steven H <steven.h.vanderleest@boeing.com>
> Date: Thursday, September 5, 2024 at 8:13=E2=80=AFAM
> To: Peter Zijlstra <peterz@infradead.org>, Wentao Zhang <wentaoz5@illinoi=
s.edu>
> Cc: Kelly (US), Matt <Matt.Kelly2@boeing.com>, akpm@linux-foundation.org =
<akpm@linux-foundation.org>, Oppelt (US), Andrew J <andrew.j.oppelt@boeing.=
com>, anton.ivanov@cambridgegreys.com <anton.ivanov@cambridgegreys.com>, ar=
db@kernel.org <ardb@kernel.org>, arnd@arndb.de <arnd@arndb.de>, bhelgaas@go=
ogle.com <bhelgaas@google.com>, bp@alien8.de <bp@alien8.de>, Wolber (US), C=
huck <chuck.wolber@boeing.com>, dave.hansen@linux.intel.com <dave.hansen@li=
nux.intel.com>, dvyukov@google.com <dvyukov@google.com>, hpa@zytor.com <hpa=
@zytor.com>, jinghao7@illinois.edu <jinghao7@illinois.edu>, johannes@sipsol=
utions.net <johannes@sipsolutions.net>, jpoimboe@kernel.org <jpoimboe@kerne=
l.org>, justinstitt@google.com <justinstitt@google.com>, kees@kernel.org <k=
ees@kernel.org>, kent.overstreet@linux.dev <kent.overstreet@linux.dev>, lin=
ux-arch@vger.kernel.org <linux-arch@vger.kernel.org>, linux-efi@vger.kernel=
.org <linux-efi@vger.kernel.org>, linux-kbuild@vger.kernel.org <linux-kbuil=
d@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.=
org>, linux-trace-kernel@vger.kernel.org <linux-trace-kernel@vger.kernel.or=
g>, linux-um@lists.infradead.org <linux-um@lists.infradead.org>, llvm@lists=
.linux.dev <llvm@lists.linux.dev>, luto@kernel.org <luto@kernel.org>, marin=
ov@illinois.edu <marinov@illinois.edu>, masahiroy@kernel.org <masahiroy@ker=
nel.org>, maskray@google.com <maskray@google.com>, mathieu.desnoyers@effici=
os.com <mathieu.desnoyers@efficios.com>, Weber (US), Matthew L <matthew.l.w=
eber3@boeing.com>, mhiramat@kernel.org <mhiramat@kernel.org>, mingo@redhat.=
com <mingo@redhat.com>, morbo@google.com <morbo@google.com>, nathan@kernel.=
org <nathan@kernel.org>, ndesaulniers@google.com <ndesaulniers@google.com>,=
 oberpar@linux.ibm.com <oberpar@linux.ibm.com>, paulmck@kernel.org <paulmck=
@kernel.org>, richard@nod.at <richard@nod.at>, rostedt@goodmis.org <rostedt=
@goodmis.org>, samitolvanen@google.com <samitolvanen@google.com>, Sarkisian=
 (US), Samuel <samuel.sarkisian@boeing.com>, tglx@linutronix.de <tglx@linut=
ronix.de>, tingxur@illinois.edu <tingxur@illinois.edu>, tyxu@illinois.edu <=
tyxu@illinois.edu>, x86@kernel.org <x86@kernel.org>
> Subject: Re: [EXTERNAL] Re: [PATCH v2 0/4] Enable measuring the kernel's =
Source-based Code Coverage and MC/DC with Clang
>
> I=E2=80=99ll answer Peter=E2=80=99s last question: =E2=80=9CWhat is the i=
mpact on certification of not covering the noinstr code.=E2=80=9D
>
>
>
> Any code in the target image that is not executed by a test (and thus not=
 covered) must be analyzed and justified as an exception. For example, defe=
nsive code is often impossible to exercise by test, but can be included in =
the image with a justification to the regulatory authority such as the Fede=
ral Aviation Administration (FAA). In practice, this means the number of un=
ique instances of non-instrumented code needs to be manageable.  I say =E2=
=80=9Cunique instances=E2=80=9D because there may be many instances of a pa=
rticular category, but justified by the same analysis/rationale. Where we s=
pecifically mark a section of code with noinstr, it is typically because th=
e instrumentation would change the behavior of the code, perturbing the tes=
t results. With some analysis for each distinct category of this issue, we =
could then write justification(s) to show the overall coverage is sufficien=
t.
>
>
>
> Regards,
>
> Steve
>
>
>
>
>
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thursday, September 5, 2024 at 7:42=E2=80=AFAM
> To: Wentao Zhang <wentaoz5@illinois.edu>
> Cc: Kelly (US), Matt <Matt.Kelly2@boeing.com>, akpm@linux-foundation.org =
<akpm@linux-foundation.org>, Oppelt (US), Andrew J <andrew.j.oppelt@boeing.=
com>, anton.ivanov@cambridgegreys.com <anton.ivanov@cambridgegreys.com>, ar=
db@kernel.org <ardb@kernel.org>, arnd@arndb.de <arnd@arndb.de>, bhelgaas@go=
ogle.com <bhelgaas@google.com>, bp@alien8.de <bp@alien8.de>, Wolber (US), C=
huck <chuck.wolber@boeing.com>, dave.hansen@linux.intel.com <dave.hansen@li=
nux.intel.com>, dvyukov@google.com <dvyukov@google.com>, hpa@zytor.com <hpa=
@zytor.com>, jinghao7@illinois.edu <jinghao7@illinois.edu>, johannes@sipsol=
utions.net <johannes@sipsolutions.net>, jpoimboe@kernel.org <jpoimboe@kerne=
l.org>, justinstitt@google.com <justinstitt@google.com>, kees@kernel.org <k=
ees@kernel.org>, kent.overstreet@linux.dev <kent.overstreet@linux.dev>, lin=
ux-arch@vger.kernel.org <linux-arch@vger.kernel.org>, linux-efi@vger.kernel=
.org <linux-efi@vger.kernel.org>, linux-kbuild@vger.kernel.org <linux-kbuil=
d@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.=
org>, linux-trace-kernel@vger.kernel.org <linux-trace-kernel@vger.kernel.or=
g>, linux-um@lists.infradead.org <linux-um@lists.infradead.org>, llvm@lists=
.linux.dev <llvm@lists.linux.dev>, luto@kernel.org <luto@kernel.org>, marin=
ov@illinois.edu <marinov@illinois.edu>, masahiroy@kernel.org <masahiroy@ker=
nel.org>, maskray@google.com <maskray@google.com>, mathieu.desnoyers@effici=
os.com <mathieu.desnoyers@efficios.com>, Weber (US), Matthew L <matthew.l.w=
eber3@boeing.com>, mhiramat@kernel.org <mhiramat@kernel.org>, mingo@redhat.=
com <mingo@redhat.com>, morbo@google.com <morbo@google.com>, nathan@kernel.=
org <nathan@kernel.org>, ndesaulniers@google.com <ndesaulniers@google.com>,=
 oberpar@linux.ibm.com <oberpar@linux.ibm.com>, paulmck@kernel.org <paulmck=
@kernel.org>, richard@nod.at <richard@nod.at>, rostedt@goodmis.org <rostedt=
@goodmis.org>, samitolvanen@google.com <samitolvanen@google.com>, Sarkisian=
 (US), Samuel <samuel.sarkisian@boeing.com>, Vanderleest (US), Steven H <st=
even.h.vanderleest@boeing.com>, tglx@linutronix.de <tglx@linutronix.de>, ti=
ngxur@illinois.edu <tingxur@illinois.edu>, tyxu@illinois.edu <tyxu@illinois=
.edu>, x86@kernel.org <x86@kernel.org>
> Subject: [EXTERNAL] Re: [PATCH v2 0/4] Enable measuring the kernel's Sour=
ce-based Code Coverage and MC/DC with Clang
>
> EXT email: be mindful of links/attachments.
>
>
>
> On Wed, Sep 04, 2024 at 11:32:41PM -0500, Wentao Zhang wrote:
> > From: Wentao Zhang <zhangwt1997@gmail.com>
> >
> > This series adds support for building x86-64 kernels with Clang's Sourc=
e-
> > based Code Coverage[1] in order to facilitate Modified Condition/Decisi=
on
> > Coverage (MC/DC)[2] that provably correlates to source code for all lev=
els
> > of compiler optimization.
> >
> > The newly added kernel/llvm-cov/ directory complements the existing gco=
v
> > implementation. Gcov works at the object code level which may better
> > reflect actual execution. However, Gcov lacks the necessary information=
 to
> > correlate coverage measurement with source code location when compiler
> > optimization level is non-zero (which is the default when building the
> > kernel). In addition, gcov reports are occasionally ambiguous when
> > attempting to compare with source code level developer intent.
> >
> > In the following gcov example from drivers/firmware/dmi_scan.c, an
> > expression with four conditions is reported to have six branch outcomes=
,
> > which is not ideally informative in many safety related use cases, such=
 as
> > automotive, medical, and aerospace.
> >
> >         5: 1068:      if (s =3D=3D e || *e !=3D '/' || !month || month =
> 12) {
> > branch  0 taken 5 (fallthrough)
> > branch  1 taken 0
> > branch  2 taken 5 (fallthrough)
> > branch  3 taken 0
> > branch  4 taken 0 (fallthrough)
> > branch  5 taken 5
> >
> > On the other hand, Clang's Source-based Code Coverage instruments at th=
e
> > compiler frontend which maintains an accurate mapping from coverage
> > measurement to source code location. Coverage reports reflect exactly h=
ow
> > the code is written regardless of optimization and can present advanced
> > metrics like branch coverage and MC/DC in a clearer way. Coverage repor=
t
> > for the same snippet by llvm-cov would look as follows:
> >
> >  1068|      5|        if (s =3D=3D e || *e !=3D '/' || !month || month =
> 12) {
> >   ------------------
> >   |  Branch (1068:6): [True: 0, False: 5]
> >   |  Branch (1068:16): [True: 0, False: 5]
> >   |  Branch (1068:29): [True: 0, False: 5]
> >   |  Branch (1068:39): [True: 0, False: 5]
> >   ------------------
> >
> > Clang has added MC/DC support as of its 18.1.0 release. MC/DC is a fine=
-
> > grained coverage metric required by many automotive and aviation indust=
rial
> > standards for certifying mission-critical software [3].
> >
> > In the following example from arch/x86/events/probe.c, llvm-cov gives t=
he
> > MC/DC measurement for the compound logic decision at line 43.
> >
> >    43|     12|                        if (msr[bit].test && !msr[bit].te=
st(bit, data))
> >   ------------------
> >   |---> MC/DC Decision Region (43:8) to (43:50)
> >   |
> >   |  Number of Conditions: 2
> >   |     Condition C1 --> (43:8)
> >   |     Condition C2 --> (43:25)
> >   |
> >   |  Executed MC/DC Test Vectors:
> >   |
> >   |     C1, C2    Result
> >   |  1 { T,  F  =3D F      }
> >   |  2 { T,  T  =3D T      }
> >   |
> >   |  C1-Pair: not covered
> >   |  C2-Pair: covered: (1,2)
> >   |  MC/DC Coverage for Decision: 50.00%
> >   |
> >   ------------------
> >    44|      5|                                continue;
> >
> > As the results suggest, during the span of measurement, only condition =
C2
> > (!msr[bit].test(bit, data)) is covered. That means C2 was evaluated to =
both
> > true and false, and in those test vectors C2 affected the decision outc=
ome
> > independently. Therefore MC/DC for this decision is 1 out of 2 (50.00%)=
.
> >
> > To do a full kernel measurement, instrument the kernel with
> > LLVM_COV_KERNEL_MCDC enabled, and optionally set a
> > LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS value (the default is six). Run the
> > testsuites, and collect the raw profile data under
> > /sys/kernel/debug/llvm-cov/profraw. Such raw profile data can be merged=
 and
> > indexed, and used for generating coverage reports in various formats.
> >
> >   $ cp /sys/kernel/debug/llvm-cov/profraw vmlinux.profraw
> >   $ llvm-profdata merge vmlinux.profraw -o vmlinux.profdata
> >   $ llvm-cov show --show-mcdc --show-mcdc-summary                      =
   \
> >              --format=3Dtext --use-color=3Dfalse -output-dir=3Dcoverage=
_reports \
> >              -instr-profile vmlinux.profdata vmlinux
> >
> > The first two patches enable the llvm-cov infrastructure, where the fir=
st
> > enables source based code coverage and the second adds MC/DC support. T=
he
> > next patch disables instrumentation for curve25519-x86_64.c for the sam=
e
> > reason as gcov. The final patch enables coverage for x86-64.
> >
> > The choice to use a new Makefile variable LLVM_COV_PROFILE, instead of
> > reusing GCOV_PROFILE, was deliberate. More work needs to be done to
> > determine if it is appropriate to reuse the same flag. In addition, giv=
en
> > the fundamentally different approaches to instrumentation and the resul=
ting
> > variation in coverage reports, there is a strong likelihood that covera=
ge
> > type will need to be managed separately.
> >
> > This work reuses code from a previous effort by Sami Tolvanen et al. [4=
].
> > Our aim is for source-based *code coverage* required for high assurance
> > (MC/DC) while [4] focused more on performance optimization.
> >
> > This initial submission is restricted to x86-64. Support for other
> > architectures would need a bit more Makefile & linker script modificati=
on.
> > Informally we've confirmed that arm64 works and more are being tested.
> >
> > Note that Source-based Code Coverage is Clang-specific and isn't compat=
ible
> > with Clang's gcov support in kernel/gcov/. Currently, kernel/gcov/ is n=
ot
> > able to measure MC/DC without modifying CFLAGS_GCOV and it would face t=
he
> > same issues in terms of source correlation as gcov in general does.
> >
> > Some demo and results can be found in [5]. We will talk about this patc=
h
> > series in the Refereed Track at LPC 2024 [6].
> >
> > Known Limitations:
> >
> > Kernel code with logical expressions exceeding
> > LVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce a compiler warning.
> > Expressions with up to 47 conditions are found in the Linux kernel sour=
ce
> > tree (as of v6.11), but 46 seems to be the max value before the build f=
ails
> > due to kernel size. As of LLVM 19 the max number of conditions possible=
 is
> > 32767.
> >
> > As of LLVM 19, certain expressions are still not covered, and will prod=
uce
> > build warnings when they are encountered:
> >
> > "[...] if a boolean expression is embedded in the nest of another boole=
an
> >  expression but separated by a non-logical operator, this is also not
> >  supported. For example, in x =3D (a && b && c && func(d && f)), the d =
&& f
> >  case starts a new boolean expression that is separated from the other
> >  conditions by the operator func(). When this is encountered, a warning
> >  will be generated and the boolean expression will not be
> >  instrumented." [7]
> >
>
> What does this actually look like in the generated code?
>
> Where is the modification to noinstr ?
>
> What is the impact on certification of not covering the noinstr code.

