Return-Path: <linux-arch+bounces-10068-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA1FA2E102
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 22:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72F41612C9
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 21:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD41487D1;
	Sun,  9 Feb 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iIUdQr6H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B68248C
	for <linux-arch@vger.kernel.org>; Sun,  9 Feb 2025 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739138266; cv=none; b=Z92hGZNnB9st4CmPbTfVsJYg5KGm7ryzd/xUjNhPz08BZrVCzeeDs5qz7NTcxAcb1JJ0CG0j7u2rAq5zf5t21mFldKBceR/u5BTgy5FhZAlO+GPDLc6o/P7Gs9aEO+q2H9IVT4MIxneVTpFQZynUPzDBKrtKOMxGdmnRoyjMQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739138266; c=relaxed/simple;
	bh=1+PgwKYMyy1Uyiun2YPAegNy7jG9rxa8lMWSf+KF3FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogN0XlUUzJlif3CQqrEDNiU8nFFaKwRDAURLINhfWWKungm0bEdegtocOzEJzpDd7cYXwlXwld7ph8u/nVCy1e8WAYmzltvHiECt+hHwv5zXLESos+OdFbYbpaD2490ZAqkrvXRyxFURpDGsjKr5aoHNkst5jFIdBRTj46taPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iIUdQr6H; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7b80326cdso102709866b.3
        for <linux-arch@vger.kernel.org>; Sun, 09 Feb 2025 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739138262; x=1739743062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A2PLT/XZrOM9Aa/16QfAGDi7D1uHeStXqgrW7NE/z7I=;
        b=iIUdQr6H/UjnHe2UkzZu2+WutqkezN2utZ1BSV5hYWdicnlOPDlRSoXOrTuUMLroDt
         IGYtJIBtg+8ZzAw37kBHWQ57cbvcsPrgH1ks++Te+CMtTBswcuXajctH1GYz7a5cldrU
         Gh6yTcKv7TxM1pnGX2pQLMa/m6MpuMwGH6fsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739138262; x=1739743062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2PLT/XZrOM9Aa/16QfAGDi7D1uHeStXqgrW7NE/z7I=;
        b=choRc0yC9qaH/EBGB1YeO4+uSDxDq4gV8jZZ/QOp8RtLmqfMDehaen0AphL/KZtl7s
         gRYtaL3Y0aWVSOuLxgVG3nokkeUkChbzfPsB/33R+sCl/NPm7e2WdZWL8eM39lYbpGzc
         dmzQE7pupTLreKFjurJWWFPHQBTbIwMU7QzYcdxI9YLsd/YzkdZsU7b1Re9liEbEHuV2
         TGjJS/X+unfk0RqLIv/loviWjJS24Ag1HkqkYnZ7MWGoBS/ORnp8eF919e/u6J5AahSV
         ODuBB/5RbAlhgsLAbFo/zn9DMqjR7RfeW4PT9PfpZ+UMkNgT5b5xYphPTeOCVsRtD6ba
         AZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7EvnZCyK9bmU8kBhjRxasqEfs9Dzw/ZykUTFGac1Ffv+K6rfiaMB8asfqxKbnOPe1oqxBWp0Lpzq4@vger.kernel.org
X-Gm-Message-State: AOJu0Yznxr3Pn91Jg8fKvtWxZjWenl0a129pcjNjRfxtmlHgqG1dTffq
	U7nKVtHkZgI2O9t5ewGobDtprWGbSson5tYJ81+ufy7kru2kP513jaceT9G9/+px9D9gWyC50u7
	uHRs=
X-Gm-Gg: ASbGncsJLie0ASLjl0raIhDYEJv8nZR7xIOkpsNuXMMwj9/JRFeFoAOweKtyBFJPY6v
	JYXo6oY10ARuqa+MMlPJGDSiq+203Nbayl9ZfDZUXC6uonc/QE4zdZ8aQ02cVAGPrxjnRxRcoYS
	rFXeSN+jHvMrSpb/7wblAXXpZP/7dzhOvaRAy3KDp3M3CeGeSj9VmVG5VwbGz6auXdtS1i2nzfY
	UF0nClRhba2LDqYqjEXdIg5LHnx8LdvL8TtjqrFuScn5N9eSttJqqZJq6i8OEG4zyNYULnQLRSg
	Q8JHdTID39gQM41S+BMi8wJH2pVWobMeYWz4sSZd+ql7z/Rcw8pJr94b/tHMugMDbw==
X-Google-Smtp-Source: AGHT+IHXcCvwiq2i5batLgdKROqZsfxeujQyPFdeX8EeWYph9nUy3GZSmzLWq8niLj4lYs+gQEwrQQ==
X-Received: by 2002:a17:907:360c:b0:ab7:63fa:e4a8 with SMTP id a640c23a62f3a-ab7897b37ffmr1014860966b.0.1739138262402;
        Sun, 09 Feb 2025 13:57:42 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4690311csm5493291a12.60.2025.02.09.13.57.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 13:57:41 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so5122866a12.3
        for <linux-arch@vger.kernel.org>; Sun, 09 Feb 2025 13:57:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNcSGWBNaOh4Et/NjNmDhIHp6VVxRjU6vS9gilsixZ7/EYziaA2IGlJ3ad/+2b4KWDKOSDZPIcaKRn@vger.kernel.org
X-Received: by 2002:a05:6402:4608:b0:5de:42f5:817b with SMTP id
 4fb4d7f45d1cf-5de450b1c5dmr11409992a12.31.1739138261105; Sun, 09 Feb 2025
 13:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209191008.142153-1-david.laight.linux@gmail.com>
 <CAHk-=wiQQQ9yo84KCk=Y_61siPsrH=dF9t5LPva0Sbh_RZ0-3Q@mail.gmail.com> <20250209214047.4552e806@pumpkin>
In-Reply-To: <20250209214047.4552e806@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 13:57:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSnNEWsvDariBQ4O-mz7Nc7LbkdKUQntREVCFWiMe9zw@mail.gmail.com>
X-Gm-Features: AWEUYZlCxkYto5CUq_vVIa6_VQHZVTdppz3dRgjcGRBwEP6eBd4ulJsXEl4hnJA
Message-ID: <CAHk-=wiSnNEWsvDariBQ4O-mz7Nc7LbkdKUQntREVCFWiMe9zw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86: In x86-64 barrier_nospec can always be lfence
To: David Laight <david.laight.linux@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Andi Kleen <ak@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Feb 2025 at 13:40, David Laight <david.laight.linux@gmail.com> wrote:
>
> Any idea what the one used to synchronise rdtsc should be?
> 'lfence' is the right instruction (give or take), but it isn't
> a speculation issue.
> It really is 'wait for all memory accesses to finish' to give
> a sensible(ish) answer for cycle timing.

No, even that is actually very different.

What happened was that 'lfence' was designed and documented - and
named - as a memory fencing thing, but the *implementation* of it was
basically about the front-end pipeline.

IOW, ignore the name or the documentation. Think of "lfence" as a
"this stops the pipeline until all previous instructions have
retired". Because that is what it *is*.

So it's basically a synchronization instruction *regardless* of memory accesses.

Which is why it was then used for the rdtsc serialization - it
basically says "don't *actually* read the TSC until you've finished
everything you've started".

And which is why it ended up being used for speculation control, even
though the instructions it serializes are *not* necessarily memory
accesses at all, but things like the address conditional that precedes
it.

So the speculation control use is literally "wait for the previous
conditional branches to retire before continuing". Yes, the
"continuing" tends to be a load, but that's almost incidental.

> And on old cpu you want nothing - not a locked memory access.

Well, back in the day, those locked instructions did the same thing.

> I couldn't work out why __smp_mb() is so much stronger than the rmb()
> and wmb() forms - I presume the is history there I wasn't looking for.

So on x86, both read and write barriers are complete no-ops, because
all reads are ordered, and all writes are ordered. So those only need
compiler barriers to guarantee that the compiler itself doesn't
re-order them.

(Side note: earlier reads are also guaranteed to happen before later
writes, so it's really only writes that can be delayed past reads, but
we don't haev a barrier for that situation anyway. Also note that all
of this is not "real" ordering, but only a guarantee that the
user-visible semantics are AS IF they were actually ordered - if
things are local in cache, ordering doesn't matter because no external
CPU can *see* what the ordering was).

So basically the only memory barriers that matter on x86 are the full
"smp_mb()" that orders reads vs writes, and the ordering for
non-ordered accesses used for IO.

And then lfence is basically used for non-memory ordering too.

                Linus

