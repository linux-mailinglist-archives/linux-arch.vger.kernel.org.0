Return-Path: <linux-arch+bounces-14856-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F4DC68BED
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 11:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 885EF38159E
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA613396E8;
	Tue, 18 Nov 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyPXQS0x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743C3385A3
	for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460595; cv=none; b=MacgqoNX8jlqaJoF7frvAeyOwau0V6MwyIY/fLRY6bFVb1rlpF6d4yeGhwCJPzCFxb6T6qZ94THDzFmiWiY2g8QV/Op2MSjkLhqsF8BCIJ60W9hEdyc5tzNKPqBcZ9CzUoZp3y4TBVuk0lCrCcz0JPrAKNqwolOpxY90u9vGuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460595; c=relaxed/simple;
	bh=6aYYtVk0AwG+U0C+LbbNYj8knJWfMEhL5BUXdj7Wg1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dto3bR442uuI5gtWC93kULA2pb9sxtJIRpKsCSaeQIauNxr+tFwvSBr3VAALcRjfwjcFFG0WSzascXDuh5Lk54Hd3CW8IK9DXZP1aSt60J23fbCpZcMhozyo0AZUPGnndQaGT8ibPiyuxQO/8Hxrg54cNjsksBjUH0R9f/3uHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyPXQS0x; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4edb8d6e98aso301441cf.0
        for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 02:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763460587; x=1764065387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdVIJoJksBNtx82CwJsTIKGgLDWjttcNd4eq6E2u+m4=;
        b=UyPXQS0xLGs41uvX6G7+J3grk6oGHQ8lL62POhV+jbnWAYgDgbSXGHKgCMNpFCDCoo
         sc0WoIbEYLujlvbcjidHA0eA4ryRI/aB7vuJXRpkD9K4ahhKAUsfXCAF2EsKzzTOSA1F
         zgYso5bHnQF8f8mZ8ksfydzYFZZ+bvN2t4PPaPuFKSFPzFk/qgw4eWShQceNMt5dDzVe
         YX9vjO9QM8OTt9/PI0TW9C8qB8ChIou87szaAElnv6+u3DJy77bF3UlWTEuP1/RXT4yz
         qwcpwnMntziOMy8YHGL4+sDoO/34C/f53VKqT+8JxKLm7BGnaGvMcBjR57Qrdj0FJgGl
         cR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460587; x=1764065387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jdVIJoJksBNtx82CwJsTIKGgLDWjttcNd4eq6E2u+m4=;
        b=AbMRLJR1kRj1Jbbnd5wgGFsd3lB5ttECGOqJiZSr6F0qf9SKIRGakkW8rA3GbeAw5Y
         +4ayNMpu9q/OduqWLmyO8CTgudBSMJpl7AqNmgAUcuHJc7aevoBcw5tkpkM5Si3UHc8M
         RaAccKji0OeiigNMwnkNDXa5ng8JG3lgukLEkvCRom6Z3UbtZIxuqDVscEzIMmqb5Hv5
         l1mol7t2uoD0yZVB5izTrSMYpNROQhrGKKorhoV7bEYo1WLIyNRoWeobCf1npmxGbU9k
         VxD1jy4DpwMovYdwchfjUGNbLI7Jn9DfhzmPHHINpH3XxM+SeAudNDGdmG2oiAWlXgJw
         c0og==
X-Forwarded-Encrypted: i=1; AJvYcCW+CVELdtbtwkQTxLa/2YRws57L635VZmhCEUS+UckyjQyNiTugj6ckyiUrShTJfiAIr8YHD9C4OOTU@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcAIcmbib2YIZuB6CxBDZGNPSJ35udO+7jziZHmt5g5X0uV+c
	4MR5Uph1Uf8LdQD1cDHrLQCyeYKBGfCMaZbKSlCuFGYi8SsoteuG8EQRAgIjRqFa3usDnu/Wb5e
	YRfuILX/bkR2pZ24uKidFhX06YGeUABXBlfNAB+SU
X-Gm-Gg: ASbGnctRtbfxEntK4F3s2tv5kiAPG3Qq3jUq4tdKLA8BQfDlAXxbeus8krw3SHFWYT5
	k+JnkPexfeVwhLuobX+mF9161eTBpSoKrVUErmGXW+lQ1sdW8innRBhPacwMlz5mPJkdKH/iCto
	xl/Shj9CEkk3plpV7Yh5t2lBBOsVDv+WuFSxwZRmC0lqyfZT9oHxPVjvKOFEpl9/dXGe0PeEXWj
	9+gn3bZJbYprHfXnp1Vt7zuideryXhp2MnCEDX/VpyIyYAyuDkFE8J5DgMUZEpXHyJfPoSeLsTc
	5fthCtB97XhMo9eGrw==
X-Google-Smtp-Source: AGHT+IF8z5/L3DrHAYvRjbH0egclvlq6/dEoM7udbJlegMIWnZkaqrPLpmLwKxIKXM/v3JGjQoCyWgoT353bbLLMs7U=
X-Received: by 2002:a05:622a:46c3:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4ee3a53c32amr377751cf.7.1763460586697; Tue, 18 Nov 2025
 02:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com> <20251116182839.939139-4-lrizzo@google.com>
 <87seec78yf.ffs@tglx> <87bjl06yij.ffs@tglx> <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
 <878qg37n8p.ffs@tglx>
In-Reply-To: <878qg37n8p.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 18 Nov 2025 11:09:10 +0100
X-Gm-Features: AWmQ_bnnHGfm_IOznD1e9NqNlMmK3z5x1yaHDKjB0iIRJ4Ix7tKIHQAIJ07xBpU
Message-ID: <CAMOZA0+K73YbPqq_vTS2sMkbV-0Fh5GSCt3ABfReV3DYk1CO2g@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 9:34=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Nov 18 2025 at 00:59, Luigi Rizzo wrote:
> > On Tue, Nov 18, 2025 at 12:16=E2=80=AFAM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >> There are a couple of other fundamental questions to answer upfront:
> >>
> >>    1) Is this throttle everything on a CPU the proper approach?
> >>
> >>       To me this does not make sense. The CPU hogging network adapter =
or
> >>       disk drive has no business to delay low frequency interrupts,
> >>       which might be important, just because.
> >
> > while there is some shared fate, a low frequency source (with interrupt=
s
> > more than the adaptive_delay apart) on the same CPU as a high frequency
> > source, will rarely if ever see any additional delay:
> > the first interrupt from a source is always served right away,
> > there is a high chance that the timer fires and the source
> > is re-enabled before the next interrupt from the low frequency source.
>
> I understand that from a practical point of view it might not make a real
> difference, but when you look at it conceptually, then the interrupt
> which causes the system to slow down is the one you want to switch over
> into polling mode. All others are harmless as they do not contribute to
> the overall problem in a significant enough way.

(I appreciate the time you are dedicating to this thread)

Fully agree. The tradeoff is that the rate accounting state
(#interrupts in the last interval, a timestamp, mod_ns, sleep_ns)
now would have to go into the irqdesc, and the extra layer
of per-CPU aggregation is still needed to avoid hitting too often on
the shared state.

I also want to reiterate that "polling mode" is not the core contribution
of this patch series. There is limited polling only when timer_rounds>0,
which is not what I envision to use, and will go away because
as you showed it does not handle correctly the teardown path.

>  As a side effect of that approach the posted MSI integration then mostly
> falls into place especially when combined with immediate masking.
> Immediate masking is not a problem at all because in reality the high
> frequency interrupt will be masked immediately on the next event (a few
> microseconds later) anyway.

This again has pros and cons. The posted MSI feature
helps only when there are N>1  high rate sources
hitting the same CPU, and in that (real) case having to
mask N sources one by one, rather than just not rearming
the posted_msi interrupt, means an N-fold increase in
the interrupt rate for a given moderation delay.

Note that even under load, actual moderation delays
are typically as low as 20-40us, which are practically
unnoticeable by low rate devices (moderation does
not affect timers or system interrupts, and one
has always the option to move the latency sensitive,
low rate source to a different CPU where it would also
benefit from the jitter induced by the heavy hitters).

cheers
luigi

