Return-Path: <linux-arch+bounces-14853-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4570C6838B
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 09:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30B9C4E3F14
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECF4286426;
	Tue, 18 Nov 2025 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MrikxA5n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BbiJKia"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47591286416;
	Tue, 18 Nov 2025 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454874; cv=none; b=d6jcgAT2nQYNNJXMz563n/hSEuFNZqFOa9i7iRhTcK7ea8aGEVacNEDD6CflZfefJ13J9N/Oon0Nn76nE3zNOgXOfiIUtRz3YLxxwlZqW4bya+EvYS/XhFNro2FY5HZAoHgXZRdZhf+kL3YWZuG4yWcJ+HnJXuip9yMbgXZnugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454874; c=relaxed/simple;
	bh=+UkXUldZhS7OH3ei76zl28BftWIhKmYFz6YAazB1+IA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMw0Zz8QPUCi9kl6BlEOLG667CcZWWAHmn+7h9UBR6XQ9CCBxOQdHlMfqj6f6+zBESQsXRg9aRsowhcVyUH9tZ36NYwWNhFnWCLgosgjpdBPcxXcQP09zsIVDtMMa2bLuO0dnmT2HjNuTrXm/1uaEGLSrDkZjqn6eoUxdAObYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MrikxA5n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BbiJKia; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763454871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/zFe3SWZEi0SweZS3H2azgoFtp7Ae9avNxjjKOqfWc=;
	b=MrikxA5nXJTM1MyMYzmSsSY/moBNV3p/xLA7LxeYdSSuXC2l5L52ZcxLJwzwgBu7Mni1LX
	zA38nXp+0Nb4w/5eLrtzgQjgsyWFpvkHPiyWNy5OZ81mioeOUb2ExeQ3ZnumK7W83z1H4c
	RNMsEjMjEBEkg6Ty1c2Ookfgj5Drt7o7IW85a6CGPeOB+udZYgRuNf4NjDzQY21UG9Ikzk
	0d18R2jbjVntA0guErHtaggwq11/1mKTRofn9xTAhb4tv4ZNakMRN+/ifiYIq17OYMd5mZ
	HWUTHxpvGTkgz7DgHIiRYeFAeeu3fs4Sp0Hod/YKi/UBP4w9HI/x5rdYWc/lig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763454871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/zFe3SWZEi0SweZS3H2azgoFtp7Ae9avNxjjKOqfWc=;
	b=4BbiJKiayNkjraSVBM2Mv3zyC9F8PR4B1GazrReOcJVP/KyotbqAsaG46CelCZ/aTupZx2
	IvceY28QvLcIGsAw==
To: Luigi Rizzo <lrizzo@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
In-Reply-To: <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-4-lrizzo@google.com> <87seec78yf.ffs@tglx>
 <87bjl06yij.ffs@tglx>
 <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
Date: Tue, 18 Nov 2025 09:34:30 +0100
Message-ID: <878qg37n8p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18 2025 at 00:59, Luigi Rizzo wrote:
> On Tue, Nov 18, 2025 at 12:16=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>> There are a couple of other fundamental questions to answer upfront:
>>
>>    1) Is this throttle everything on a CPU the proper approach?
>>
>>       To me this does not make sense. The CPU hogging network adapter or
>>       disk drive has no business to delay low frequency interrupts,
>>       which might be important, just because.
>
> while there is some shared fate, a low frequency source (with interrupts
> more than the adaptive_delay apart) on the same CPU as a high frequency
> source, will rarely if ever see any additional delay:
> the first interrupt from a source is always served right away,
> there is a high chance that the timer fires and the source
> is re-enabled before the next interrupt from the low frequency source.

I understand that from a practical point of view it might not make a real
difference, but when you look at it conceptually, then the interrupt
which causes the system to slow down is the one you want to switch over
into polling mode. All others are harmless as they do not contribute to
the overall problem in a significant enough way.

As a side effect of that approach the posted MSI integration then mostly
falls into place especially when combined with immediate masking.
Immediate masking is not a problem at all because in reality the high
frequency interrupt will be masked immediately on the next event (a few
microseconds later) anyway.

Thanks,

        tglx


