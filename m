Return-Path: <linux-arch+bounces-14851-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F38BFC669C6
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 00:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFCF94E0187
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 23:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA7C2E0B58;
	Mon, 17 Nov 2025 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pu76CTGk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4F130DEDA
	for <linux-arch@vger.kernel.org>; Mon, 17 Nov 2025 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423993; cv=none; b=tizx6vq0qYARXj5Te5v9gwapau/mmnxt2OEaucBQsk0iA6TvE2oRI3n2e/a3O4TkUiHVD3Cp3dcaG6r2SJgOrjC0tiIZOzRPcC0fvKd4fp4kuKlxYKemt5aKXr64iHuKc+mf0Zb21tZ4BZi3FOekCushr8N9i5EDmLS7aSv4nOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423993; c=relaxed/simple;
	bh=Sp7j6ej58rYd90C6uDZIjCgEWUqsEaH2spkhnJkdMG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJHWBhLc8lCaNxhadZavaxkxHf8wFV1CKH+l4zLxzuI7C9gCwwvhB7NvTp149ox3l5EWOhfC4+W2Ts4v9602gZMwERPfS9jMCuoL7NEx7fAHdWxoMU9e0Koq4zvEFxCoHoUvVSkX/5fGUuk6VMQpTK/ZMysQo/LqeY1faOED6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pu76CTGk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4edb8d6e98aso160431cf.0
        for <linux-arch@vger.kernel.org>; Mon, 17 Nov 2025 15:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763423990; x=1764028790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkUH+46jH5VgsbFoxpLj1Hw1oBiKTTQzmTA+0U0V9GM=;
        b=Pu76CTGk32dpfUjX8hW9afYKZYR99dLR39dHx+6BN8YtBVzIaD3W1dC/JHZUsyRU6G
         Vs/VaSlCitqT8ku2kkLtNAMfIMEnDIXZFzQUCotZqSChpMgAYKG0//Yz0ul0TIq05qy2
         hMtN+cHFIyM3yQWDgdaSqYC2vFlAWT1Q4OA9kjCPWO6V2AuB1MHBJBwLhALNI34LqSWt
         xfVJtA8bWdFIsVXNkUyZpWllG9/vxYEggPsKyxeDRWyqgKU7GPyvzTheKle/T66IAEHZ
         oLhInNcwBo3qgCX0NSiuLm9fT9zVJ1DwPolr0sasejt00qyxCvhdQoWmHdyJPyX2YeH+
         UsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763423990; x=1764028790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qkUH+46jH5VgsbFoxpLj1Hw1oBiKTTQzmTA+0U0V9GM=;
        b=f+Jq1k9b6q751v84VVuMgAQFAQEJsKWwml9U2wALNUVDdeYa6v2x89PLA6+N+hdXb9
         8TSUqSl26+KemIb12lHBfGG0sUNs4qwEsWjkCpnPcEI37pNeeggTLSApaju3YTMbspwM
         gbXeQ9x6J1o9UVZwWGTOhGt3eToOeNiU9S99hNch2lQw2fAoIiXy8ebCPhKeFtdmRJVz
         MqkBLTUbv+ow62Wk35KzGtlWdW6e+qN2bLOTubKwhQTDQJ9s4s9jUWo2r4dnGsMVQ5rb
         +4Shm8WmeKsUQ2SbKUG4DkazcHc/T/mq4RfHfMFgZlCGNdWRBtIzc72NTCDYOcEnd6fj
         McDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnXAzIWul2Nn7b/7P853kiWK0vqZ0elRJBkiJ6ZDWsiVp4hBRAXqbm7oCoePaY/dHfAe4ssiqbs7NK@vger.kernel.org
X-Gm-Message-State: AOJu0YyHeYH53d63CaykE33ttOysjknVVY0CVVkZ78ImN6QQ4ki09u5B
	Svw4LYEdT8hpaDkU/qzYhv6jbEfhrVhWKzmkAfiyvb6rVIaa8ItYy7FJua2vHA6JgJWBOl5AQMi
	kgDkiX1sU74KXSKiNWPX6rY6ZTYb+hVwNUfDbITbV
X-Gm-Gg: ASbGncsEEbNhAm+KuV4CJVD/ppeuuOfwD5AicBNDUn1hBi90N2lQNpZXUdPHIRCDttB
	8Sib5obxkDs9uEYyKkZPUx0zHHteupCIt00iM7sIaMoO16+Q4cs3hecdhXXezkSk2UKlq4t8qxJ
	kdHc2MwKVbcATLzCxMemaezWFoa3MkVujC71prNg8vULEOfpidOiCfxs7nbgyCOK2GNho1nii1D
	2FogSup14T9kMH3XRvsr+5RHT8uUSdTv9CjTNiTF945CbJaHfibEcDzhdiM4/tv50K6lhc=
X-Google-Smtp-Source: AGHT+IH3qxLI1NCS2WR9dbtuxf9qeLrmAMkfnduEJo1g3DDbfKJHRpsvaIlgBIzv7DA5ctyFXK9TX+TueoOyl1q8VTw=
X-Received: by 2002:a05:622a:1114:b0:4e6:eaea:af3f with SMTP id
 d75a77b69052e-4ee3265ac31mr768141cf.3.1763423990326; Mon, 17 Nov 2025
 15:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com> <20251116182839.939139-4-lrizzo@google.com>
 <87seec78yf.ffs@tglx> <87bjl06yij.ffs@tglx>
In-Reply-To: <87bjl06yij.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 18 Nov 2025 00:59:14 +0100
X-Gm-Features: AWmQ_bkXBPXivBiRq7J5OIrvAFG1-eaCPvAyInFMnvLxPT4OgRyIcKryusnowp4
Message-ID: <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 12:16=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Mon, Nov 17 2025 at 20:30, Thomas Gleixner wrote:
> > On Sun, Nov 16 2025 at 18:28, Luigi Rizzo wrote:
> >> +    ms->rounds_left--;
> >> +
> >> +    if (ms->rounds_left > 0) {
> >> +            /* Timer still alive, just call the handlers. */
> >> +            list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_n=
ode) {
> >> +                    ms->irq_count +=3D irq_mod_info.count_timer_calls=
;

> I missed this gem before. How is this supposed to calculate an interrupt
> rate when count_timer_calls is disabled?

FWIW the code is supposed to count the MSI interrupts,
which are the problematic ones.
count_timer_calls was a debugging knob, but understood that
it has no place in the upstream code.

> This polish the Google PoC hackery to death will go nowhere. It's just a
> ginormous waste of time. Not that I care about the time you waste with
> that, but I pretty much care about mine.
>
> That said, start over from scratch and take the feedback into account so

point taken.

> First of all please find some other wording than moderation. That's just
> a randomly diced word without real meaning. Pick something which
> describes what this infrastructure actually does: Adaptive polling, no?

The core feature (with timer_rounds =3D 0)  is really pure moderation:
disable+start a timer after an interrupt, enable when the timer fires,
no extra calls.

It is only timer_rounds>0 (which as implemented is clearly broken,
and will be removed) that combines moderation + N rounds of timed polling.

> There are a couple of other fundamental questions to answer upfront:
>
>    1) Is this throttle everything on a CPU the proper approach?
>
>       To me this does not make sense. The CPU hogging network adapter or
>       disk drive has no business to delay low frequency interrupts,
>       which might be important, just because.

while there is some shared fate, a low frequency source (with interrupts
more than the adaptive_delay apart) on the same CPU as a high frequency
source, will rarely if ever see any additional delay:
the first interrupt from a source is always served right away,
there is a high chance that the timer fires and the source
is re-enabled before the next interrupt from the low frequency source.

cheers
luigi

