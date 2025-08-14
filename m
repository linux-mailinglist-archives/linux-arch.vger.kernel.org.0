Return-Path: <linux-arch+bounces-13166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC8B25E2D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 09:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C6166529
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5712D63E0;
	Thu, 14 Aug 2025 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz1/mLef"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA05253920;
	Thu, 14 Aug 2025 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158349; cv=none; b=cMZ+5C/7lb5kZWnymjpabPUQyK6emD0nGyx/SDvss7buuNEicWEjRtCbIxw1CAv5LgfCz9MoiLtUyYZYOgt0RLk4t+bgAQKtUG7FEOp5RWq4cA2MdThIjNoCK4By2EAmnyXJQC16fnlkh+TiKlVT0CkW1iyU+w7nnJkKjELiTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158349; c=relaxed/simple;
	bh=zoZ7WUquG8cMMyU1NBK2nNB+7xnTYVek1voJ48AoqJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vsk4mwWbQPoetLtkaA2yGh7J9LRcXr1czd0UajHJZcR00y24SNkolOX3X3Kl3grLg6VgiWw71oJDWCurenapm3n0BLfCcTYxytpVwe8P9xCpsr21au85EuBaAz1eg9nH8C0BfGBxGyodeA3fruUKkvUcloT0AfJTgPC+X0crfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz1/mLef; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4716f46a2eso414057a12.0;
        Thu, 14 Aug 2025 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755158346; x=1755763146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoZ7WUquG8cMMyU1NBK2nNB+7xnTYVek1voJ48AoqJ8=;
        b=mz1/mLef7yphnGaDGhRRk6mxUsc5fbrNWTCmlPf/mq9RJjj16mmrsIcXwBLBhzbHdJ
         ixcxH/awi2SnJkCp6kaoeJLFBn5/qf27wiugnJdzFgABCfqTWk4Fn/BjlrO8ow4jcBqf
         J2Yqd6yYN6W3/rccMCHCypeESxtzdQSfXsMx92cR3PWOAmpciqjIAjAtwSO8Jj9/QcM0
         +jffiz2ff0AQ0yHLnw4EhZT9V4C4KWMZggFRdgjb+diibCrtkIyRa67P+LcAqBPVerZG
         HF3fciBe1MIg9wkTtjppDb2gtFqxcUHpFWHEm/VZMrj5s4n3z7DLM8SbmZlUArRFjhUX
         MjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755158346; x=1755763146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoZ7WUquG8cMMyU1NBK2nNB+7xnTYVek1voJ48AoqJ8=;
        b=VMmentwGGnafqSFpiq17tayQEzEHOCQKHk2P6Kna1jGqPh93BZH8phqrYfaDhnucCj
         B7aF5/Oc+JjiyGA31sh2hMpt7B1FmXNbTnEA+97Qj22UT7Fcr57jtDw2i4x58nwaMJZt
         Y+FWS2D/6FoVM4Sb6Ea2GuoXBrjH3XW9DQoLjhLM8Bbg1w7IbpSMemmKuTBus2t6PLG9
         sSg9yjtoTIHft77pRFxRELI+JvGqr6Qao2Zqa06d0lpg1opXjIs4CmVSKNNMNoM3zUS+
         JARxGwXjvmivPWAx8QqspAJZTW/QrIuEO5myiEjMYl2rBvqh7GmTK8JYQGLfmVNyE2OK
         J2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7TzxjO3ITZtCFoEREPpRMZ+P+QdaWMAhOOyYlTIQtpBAYoOvWPoawqU8u7OCEkD2vdRkwUZk9pUl2c9le@vger.kernel.org, AJvYcCUjk/PDKBCEvdUAgwthMrK5xDAxXsuKXruF2nH/2M/BTthDgt5Rqz0QrshGMwluhlCSnAblsdpldfkqrLWj@vger.kernel.org, AJvYcCUn3yxj1S29RzvU/WY3raTpyJwxymcYIZsiX2R48MOudaZ927EJzm60DOGmNTxd3F8gzW+zvXeCwF8V@vger.kernel.org, AJvYcCWxfFTBzIm5OM1BRoOVWMpjL6HSqT6MD8bGw79biC4r4ZWbl/QCNGskLyRCLDyk/LLiK5/Dezvjk9Ml@vger.kernel.org
X-Gm-Message-State: AOJu0YwgpOHnXK6gLNpc9+OR/0UowkIaLnqpZRcwb+Ph+OYwEHw1QhRE
	399+zHPyloIazQwxEtV6bpHvhj3NL96OP9y8eOB8XF4UbWxzWGfPomnrRV1CiZC1XES8G8dIW5E
	OziBDcAlQASHZPzLYYW/z1Tysl2nnmjhHHPW1GaM=
X-Gm-Gg: ASbGncvO7jVa8CINOzNTEYTfa+m3Ep75FHWJhwyBIHzhT7d8g7gtJ+m9luVOnl8zcLR
	nSjva6qXVqUHCRKs1BTfj9MrbaaJ+sT0bHmHNpRDrrWN9rMP97UikSDGi4L/k4fWVM1YMOMC7Pr
	laXso61EKLyUi0UJSywJsfKwt7pKITiTufRciAQnLJZHX+wh48iAg8NtvM1n8G13tgG0YRgHxaY
	3fbcIpFGw==
X-Google-Smtp-Source: AGHT+IEQbGhvLjbk/PZuRzmUAAbKmg5zyek9g1zSctsavo1Plx+EvyZnlkXlE79ToNcU1q9KIzOPCpQOjM4oqgmqIUc=
X-Received: by 2002:a17:903:288:b0:23f:b112:2eaa with SMTP id
 d9443c01a7336-244586d1e0emr29323375ad.41.1755158345945; Thu, 14 Aug 2025
 00:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718045545.517620-1-mhklinux@outlook.com> <20250718045545.517620-2-mhklinux@outlook.com>
In-Reply-To: <20250718045545.517620-2-mhklinux@outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 14 Aug 2025 15:58:28 +0800
X-Gm-Features: Ac12FXwvr78CteVVQOMblTNIWydAz9zx3iAXMtyYSKDeoJxC3p3jC9XRhyn1SE4
Message-ID: <CAMvTesCFzy_Yt01Xz-GrG68_JGWf+yJzn2Nx7UJo2hLMarYJrQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] Drivers: hv: Introduce hv_setup_*() functions for
 hypercall arguments
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, lpieralisi@kernel.org, 
	kw@linux.com, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	arnd@arndb.de, x86@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 12:56=E2=80=AFPM <mhkelley58@gmail.com> wrote:
>
> From: Michael Kelley <mhklinux@outlook.com>
>
> Current code allocates the "hyperv_pcpu_input_arg", and in
> some configurations, the "hyperv_pcpu_output_arg". Each is a 4 KiB
> page of memory allocated per-vCPU. A hypercall call site disables
> interrupts, then uses this memory to set up the input parameters for
> the hypercall, read the output results after hypercall execution, and
> re-enable interrupts. The open coding of these steps leads to
> inconsistencies, and in some cases, violation of the generic
> requirements for the hypercall input and output as described in the
> Hyper-V Top Level Functional Spec (TLFS)[1].
>
> To reduce these kinds of problems, introduce a family of inline
> functions to replace the open coding. The functions provide a new way
> to manage the use of this per-vCPU memory that is usually the input and
> output arguments to Hyper-V hypercalls. The functions encapsulate
> key aspects of the usage and ensure that the TLFS requirements are
> met (max size of 1 page each for input and output, no overlap of
> input and output, aligned to 8 bytes, etc.). Conceptually, there
> is no longer a difference between the "per-vCPU input page" and
> "per-vCPU output page". Only a single per-vCPU page is allocated, and
> it provides both hypercall input and output memory. All current
> hypercalls can fit their input and output within that single page,
> though the new code allows easy changing to two pages should a future
> hypercall require a full page for each of the input and output.
>
> The new functions always zero the fixed-size portion of the hypercall
> input area so that uninitialized memory is not inadvertently passed
> to the hypercall. Current open-coded hypercall call sites are
> inconsistent on this point, and use of the new functions addresses
> that inconsistency. The output area is not zero'ed by the new code
> as it is Hyper-V's responsibility to provide legal output.
>
> When the input or output (or both) contain an array, the new functions
> calculate and return how many array entries fit within the per-vCPU
> memory page, which is effectively the "batch size" for the hypercall
> processing multiple entries. This batch size can then be used in the
> hypercall control word to specify the repetition count. This
> calculation of the batch size replaces current open coding of the
> batch size, which is prone to errors. Note that the array portion of
> the input area is *not* zero'ed. The arrays are almost always 64-bit
> GPAs or something similar, and zero'ing that much memory seems
> wasteful at runtime when it will all be overwritten. The hypercall
> call site is responsible for ensuring that no part of the array is
> left uninitialized (just as with current code).
>
> The new functions are realized as a single inline function that
> handles the most complex case, which is a hypercall with input
> and output, both of which contain arrays. Simpler cases are mapped to
> this most complex case with #define wrappers that provide zero or NULL
> for some arguments. Several of the arguments to this new function
> must be compile-time constants generated by "sizeof()"
> expressions. As such, most of the code in the new function can be
> evaluated by the compiler, with the result that the code paths are
> no longer than with the current open coding. The one exception is
> new code generated to zero the fixed-size portion of the input area
> in cases where it is not currently done.
>
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/t=
lfs/tlfs
>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

