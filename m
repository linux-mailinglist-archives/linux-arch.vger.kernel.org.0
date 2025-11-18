Return-Path: <linux-arch+bounces-14879-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79850C6AB9D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 17:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB2E03A47DD
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6DA3A1CF7;
	Tue, 18 Nov 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uu5bmUG6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FDxxNrWA"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92109266581;
	Tue, 18 Nov 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483517; cv=none; b=FfR2iZ2m8GTOcaOZHh7eLPUznJeA9TjlCow+fhuqcpExehsTPAAPBzdJjbKZvcXzLXhy9Zla9TOjDIsd5xJJ7J1UTbE/X54DJrL/Anqs30sE3r2LDvZ1ny9gCamCHmXcYfrHRAB0YxV9T+OLHC0URYCpZNyjosiSBFnJSVgtqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483517; c=relaxed/simple;
	bh=F1fNBJ3Xo6ODQbCVWkO4BF4ZUG3TS+Qn+voXLPIAqhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dGghU3TxrPw6h2CbTkk8ARREjpJxhLD2FmxLPq1SrOkez6XKEpuc4lBvtjnJK3r/6Rk6kqxX5iSTC9Kx+6v0E+b1G0emEumBPlRMJ/Rt+szEX6PR3KyGVNcoyM7unO0+jZnb5/DnokVMGSib0Weyl/7D22eQPgCKa916Ud77Kwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uu5bmUG6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FDxxNrWA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763483507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6fVg41JUcugfjcXONKbMYrQCXMNo/rMBesowKuv57c=;
	b=uu5bmUG6RxBzxAZwGqZjoZGigtos2gmtZJPgzkzOChAKSYhR0eWlyedycyuWZMpCex71H7
	kXWGy/A9tm7M/3ppef5Zur9/qUWHoxOENKQU1jPSrYW8rkaA/ORpDVvkskuhqG/799/6tl
	zDYpwjmF4aJKTpd5+Moih4crEssYvT5a1LPiOVLb/Vco5lr++vquD11jZtDcMxvMFxtmeP
	MmRQLGvkhE3nNrcn1GG6kwWGXpAr2ckAy5J+4mgwVlHQX/Ao4o7nUdfNnXbRlRZ1TLcWTx
	42xAyFTpkIISbOJRwa1A2QpShp86b15gOinKK/e1JdlwMYbo3tu6Q2tch9O5vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763483507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6fVg41JUcugfjcXONKbMYrQCXMNo/rMBesowKuv57c=;
	b=FDxxNrWAP7fw8R/ft7/AjP/Am+WSM/dQaZXOk0uh0usmwF8HqKtJtVHBDx+7+55NcLt4dz
	A77SJMNP22KgdTDA==
To: Luigi Rizzo <lrizzo@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
In-Reply-To: <CAMOZA0+K73YbPqq_vTS2sMkbV-0Fh5GSCt3ABfReV3DYk1CO2g@mail.gmail.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-4-lrizzo@google.com> <87seec78yf.ffs@tglx>
 <87bjl06yij.ffs@tglx>
 <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
 <878qg37n8p.ffs@tglx>
 <CAMOZA0+K73YbPqq_vTS2sMkbV-0Fh5GSCt3ABfReV3DYk1CO2g@mail.gmail.com>
Date: Tue, 18 Nov 2025 17:31:46 +0100
Message-ID: <87pl9fmhe5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18 2025 at 11:09, Luigi Rizzo wrote:
> On Tue, Nov 18, 2025 at 9:34=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> I understand that from a practical point of view it might not make a real
>> difference, but when you look at it conceptually, then the interrupt
>> which causes the system to slow down is the one you want to switch over
>> into polling mode. All others are harmless as they do not contribute to
>> the overall problem in a significant enough way.
>
> (I appreciate the time you are dedicating to this thread)

It's hopefully saving me time and nerves later :)

> Fully agree. The tradeoff is that the rate accounting state
> (#interrupts in the last interval, a timestamp, mod_ns, sleep_ns)
> now would have to go into the irqdesc, and the extra layer
> of per-CPU aggregation is still needed to avoid hitting too often on
> the shared state.
>
> I also want to reiterate that "polling mode" is not the core contribution
> of this patch series. There is limited polling only when timer_rounds>0,
> which is not what I envision to use, and will go away because
> as you showed it does not handle correctly the teardown path.

Ok.

>>  As a side effect of that approach the posted MSI integration then mostly
>> falls into place especially when combined with immediate masking.
>> Immediate masking is not a problem at all because in reality the high
>> frequency interrupt will be masked immediately on the next event (a few
>> microseconds later) anyway.
>
> This again has pros and cons. The posted MSI feature
> helps only when there are N>1  high rate sources
> hitting the same CPU, and in that (real) case having to
> mask N sources one by one, rather than just not rearming
> the posted_msi interrupt, means an N-fold increase in
> the interrupt rate for a given moderation delay.

That's kinda true for the per interrupt accounting, but if you look at
it from a per CPU accounting perspective then you still can handle them
individually and mask them when they arrive within or trigger a delay
window. That means:

   1) One of the PIR aggregated device interrupts triggers the delay

   2) If there are other bits active in that same posted handler
      invocation, then they will be flipped over too

   3) Devices which have not been covered by the initial switch, will
      either be not affected at all or can raise exactly _one_ interrupt
      which flips them over.

This scheme makes me way more comfortable because:

   1) The state is always consistent.

      If masked then the PIR rearm is not causing any harm because the
      device can't send an interrupt anymore.

      On unmask there is no way to screw up vs. rearming and eventually
      losing an interrupt.

      I haven't analyzed your scheme in detail, but the PIR mechanism is
      fickle and I have very little confidence that the way you
      implemented it is correct under all circumstances.

   2) It requires exactly zero lines of x86-intelism code.

   3) It keeps the mechanism exactly the same for PIR and non-PIR mode
      as you need the 'mask' on mode transition anyway to solve the
      disable/enable_irq() state inconsistency.

Please focus on making this simple and correct in the first place.

If there is still a really compelling reason to treat PIR differently,
then this can be done as a separate step once the initial dust has
settled.

Thanks,

        tglx

