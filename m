Return-Path: <linux-arch+bounces-11360-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15746A82A55
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408D49A528C
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54EB266F05;
	Wed,  9 Apr 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D77ojHRc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305A17C219;
	Wed,  9 Apr 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211761; cv=none; b=WjghopzTuEkZd6LZdocm3xp1cvqSU/lAzq9zZjdIjJEnYQUT9bzuIntfM1kFIJ6X3vpH0SnhQH7zk+UuzFFvZFl4MeivGuL8+wc/MpCAYGHJ6+I47/GQm5Fj3GPVW7KhgOQAZdW+XvH16wxK08Hw5F5SVZER6Kv+aFdVA4W6iYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211761; c=relaxed/simple;
	bh=JD3UCsEmPQ64i5dIKbrJePQ8znLynqiSwHlAm2gAgCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U69+aWzguGwIvadfz38H1wkqw0gTeziYYdESvydP17yTf8xUeJHFzevRK1X2DsWfo86XefRGIEDsXcYLfbOmseYnFVU9DzbzUHM1P6BKlHByTVLbNG+AqGmW/UbPm3HVMPS7sfenoQYYeJ54wX7j71MiTTsuKuvJBHfZQMkDN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D77ojHRc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30f30200b51so26823751fa.3;
        Wed, 09 Apr 2025 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744211758; x=1744816558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0/uW4jPxHZ/GoeUPgM6M/7DEGndKYYoe9YilYwKUUw=;
        b=D77ojHRcAPC/+VwuhJBDFcYByjy75HJ9AABXFZ6gWGYBjoVjijMdGbV664GfG7NBAV
         OI0Ogi9rqj6/j7ieAHFkhkb3CmG2ErDfyhuzkQccMddOe8H5b/S0XWY2sQCxw+iqVutd
         pLu0Zo/G70ImbMSMY6hc0oz9l2ZG6vyJdeRgOaO6kiamXxihBNGn7cMVvViPh1JW8v2m
         xUd3FERpeI3GWtrUDMdxB/jKT6Ybcv+KNe15qy6LmBQPLIBPWQ/7AmlXONKRfnK+EhF8
         daYK9mhU+rQLJVod8rDYqjhBL18IAfZTJw9C3eA7RmoWDElp/ibb69+b7PcIF9fdo5vm
         KMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744211758; x=1744816558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0/uW4jPxHZ/GoeUPgM6M/7DEGndKYYoe9YilYwKUUw=;
        b=fF7zqbK9FQzJJFlSLk6I5JjTozJJHqTetcxe21fdcbOANlHuA5VN59yuGXL0H383ty
         qh52AcOxL81tMVxOG8XAwaV2Ftw7F9B+1H0DGFNmGoHz+peyo+Y88rLVew91qP+kW2rM
         qb9y20xhCxmtzlZXGa7MMApG+zhLg6DFHnPiD8VSCzzwoWbimSv9a4fBmaLryVhgXpzo
         bv0A4ZONKriglJkG/Ics/aZzF2gk3fGAwO2gjTw6iqteNeyL8mNihU/A6+3nayeLq+mj
         S8fumyUp4forkIN+02LQZvLyVEAEy5mHAs8aWsSRjHa/tadSTzELy72pYLwNNBRRtxNH
         HE+w==
X-Forwarded-Encrypted: i=1; AJvYcCUTNOMwholhzz/+L39W8sSlCUTgLSFH4ej7DFMtyxaIMqQ+AqUXVWroIKTBvU75Py6fXdlmDjFc1kojoP93@vger.kernel.org, AJvYcCVnvmYSEyAonjENSANy8Xp6I3RdQQxk8e51GLMsQivBRrHDwVTxWx3MKGUdQB+ppJ8xmXAkmpzVMYkB@vger.kernel.org, AJvYcCWgaRgUNinHx8FDoSNUaxPdhnW3YiE9/6x6g0zXSAM6LziPzS0waEtxiA21QPYqtkeWNZeSHyWHUdQHi/vEcGI=@vger.kernel.org, AJvYcCX1zFFgpwFgzCbSWkKyDbAM79CX3K2bR3u2HbrDH8h6z3eEjTuaq4qGDz28jSICEawivlElOYX+@vger.kernel.org
X-Gm-Message-State: AOJu0YxxP4jmO2U0ybFTaIWrLk0eDQspuu04jjrWMlZAZMQA2GPYgtfp
	+UUYeOJTCzTRJvvCsaaZRsu8xjdRUHwXTyqg8CliOY9w0hvjdG0RNuCQMDfQq0bxLv4XX5hfQeo
	JShmwsblMg9QzirnqnKJLL/e3vcQ=
X-Gm-Gg: ASbGncs4DhoibiclLIfL7PQIWVvLteWhgoWDM4hYA0GzL/El/sHESdOmFX9lGPI/2y+
	KZZjLvKMvkMow0bN4zkfvmEzcNmHzD9ZdT1KlyVrl3XiZudD7e14li+o+anPXAeoKI13nf7z308
	6xvkLqhMs6vDu8wKF577WmgA==
X-Google-Smtp-Source: AGHT+IGNIwqxn5mFZL5/yjjNE/1+c0Q5XXczzTx4ISCw+fSAPDJR88uRUs5CfplseOFx7Y7BUJqkOOXlpJ/JHLnOpnI=
X-Received: by 2002:a05:651c:1475:b0:308:e5e8:9d4c with SMTP id
 38308e7fff4ca-30f43894d5cmr14376751fa.28.1744211757664; Wed, 09 Apr 2025
 08:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127160709.80604-1-ubizjak@gmail.com> <20250127160709.80604-7-ubizjak@gmail.com>
 <66e54eb9-58b3-4559-af32-66a77fe1ea01@kernel.org> <CAFULd4YiYRhqu7mGWMN9pAsV-Nc6a97+EgiTCR34iaYDvXjDwQ@mail.gmail.com>
 <77B3F3ED-102D-4759-98F1-622629EBF9AF@zytor.com>
In-Reply-To: <77B3F3ED-102D-4759-98F1-622629EBF9AF@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 9 Apr 2025 17:15:45 +0200
X-Gm-Features: ATxdqUFXaMouhTV-LvYcXiA_EezjmjAt_Olprrf1g0qki_J08Ltm70ceNO6A5E4
Message-ID: <CAFULd4ahm3-r66eBJSHV4NfBpnFLUpK2hRak42whuJJeui+B+Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] percpu/x86: Enable strict percpu checks via named
 AS qualifiers
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	Nadav Amit <nadav.amit@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:09=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On April 9, 2025 4:43:27 AM PDT, Uros Bizjak <ubizjak@gmail.com> wrote:
> >On Wed, Apr 9, 2025 at 1:07=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org>=
 wrote:
> >>
> >> On 27. 01. 25, 17:05, Uros Bizjak wrote:
> >> > This patch declares percpu variables in __seg_gs/__seg_fs named AS
> >> > and keeps them named AS qualified until they are dereferenced with
> >> > percpu accessor. This approach enables various compiler check
> >> > for cross-namespace variable assignments.
> >>
> >> So this causes modpost to fail to version some symbols:
> >>
> >> > WARNING: modpost: EXPORT symbol "xen_vcpu_id" [vmlinux] version gene=
ration failed, symbol will not be versioned.
> >> > Is "xen_vcpu_id" prototyped in <asm/asm-prototypes.h>?
> >> > WARNING: modpost: EXPORT symbol "irq_stat" [vmlinux] version generat=
ion failed, symbol will not be versioned.
> >> > Is "irq_stat" prototyped in <asm/asm-prototypes.h>?
> >> > WARNING: modpost: EXPORT symbol "fred_rsp0" [vmlinux] version genera=
tion failed, symbol will not be versioned.
> >> > Is "fred_rsp0" prototyped in <asm/asm-prototypes.h>?
> >> > WARNING: modpost: EXPORT symbol "cpu_dr7" [vmlinux] version generati=
on failed, symbol will not be versioned.
> >> > Is "cpu_dr7" prototyped in <asm/asm-prototypes.h>?
> >> > WARNING: modpost: EXPORT symbol "cpu_tss_rw" [vmlinux] version gener=
ation failed, symbol will not be versioned.
> >> > Is "cpu_tss_rw" prototyped in <asm/asm-prototypes.h>?
> >> > WARNING: modpost: EXPORT symbol "__tss_limit_invalid" [vmlinux] vers=
ion generation failed, symbol will not be versioned.
> >> > Is "__tss_limit_invalid" prototyped in <asm/asm-prototypes.h>?
> >> > WARNING: modpost: EXPORT symbol "irq_fpu_usable" [vmlinux] version g=
eneration failed, symbol will not be versioned.
> >> > Is "irq_fpu_usable" prototyped in <asm/asm-prototypes.h>?
> >> > WARNING: modpost: EXPORT symbol "cpu_info" [vmlinux] version generat=
ion failed, symbol will not be versioned.
> >> > Is "cpu_info" prototyped in <asm/asm-prototypes.h>?
> >> > WARNING: modpost: EXPORT symbol "gdt_page" [vmlinux] version generat=
ion failed, symbol will not be versioned.
> >> > Is "gdt_page" prototyped in <asm/asm-prototypes.h>?
> >>  > ...
> >>
> >> That happens both with 6.15-rc1 and today's -next. Ideas?
> >
> >https://lore.kernel.org/lkml/20250404102535.705090-1-ubizjak@gmail.com/

> A lot of those seem to be things that definitely shouldn't be expected...

These symbols are just declared with an extra __seg_gs that genksyms
doesn't understand, e.g.:

extern __seg_gs __attribute__((section(".data..percpu" "..hot.."
"this_cpu_off"))) __typeof__(unsigned long) this_cpu_off;

The workaround falls back when __GENKSYMS__ is defined to:

extern __attribute__((section(".data..percpu" "..hot.."
"this_cpu_off"))) __typeof__(unsigned long) this_cpu_off;

which is what genksyms processes without problems.

Uros.

