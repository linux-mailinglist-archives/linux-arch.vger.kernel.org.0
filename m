Return-Path: <linux-arch+bounces-4155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41718BA402
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 01:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5481F23893
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 23:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21A1D69E;
	Thu,  2 May 2024 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b0WScEK7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09B1CD1B
	for <linux-arch@vger.kernel.org>; Thu,  2 May 2024 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692777; cv=none; b=Qm83Y4PekF3OVmRRepKQl6W3vYdjBOHe4Nh4AJvuUmBMUPg1Gm8raYv1IWa057ket1hB6jyFDhCoPoODn4wViDt4gTeSEeQgZty2YgyQcDvNi+Nl+zP+ubg9x7vMZ/33J1s9ixXiyCXFt3SkXmuJ9aT+BcKZyugZTDYzntt4Txc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692777; c=relaxed/simple;
	bh=BZ52Tcx3eQkXrtn3fFvtEmKqc76WYA0oPdpNw2t/Pqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqwJIS4qD2n6T3Fy8DpXB0/JkhAwbY1749Kn7fVSF0uReQbNdgEHb2e9LNYjgf3ItKzDEWWfR0F+4dEszjGFCdq4fBiJGMpjuwG5Xz5oG4jzoGpzzWHG2UpmJEoxZD+QiAq+3zeoh6d747gCXjf5M9g5S8ET+xTaP44skN2g4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b0WScEK7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34da35cd01cso2666036f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2024 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714692774; x=1715297574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1CFOJ/4TKYJEMM9t2wMqQPhhUvH4D3HXIbUI8k+tY+E=;
        b=b0WScEK7eqgWZ+bW3n1GeLpuoH9anxP5PNUtwu8tkw2jUtAkvNDlbABIlaFprHIsIn
         aeiZzXjWFkpQyTgFDWVe7znGYClIK43Z7R9Ese7Y91LW8iM04V18g+9ui5RMd9dVjt48
         d0xwvOvBQNjUYyFu0cbjX5BEGs3QKKZfp3WTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692774; x=1715297574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CFOJ/4TKYJEMM9t2wMqQPhhUvH4D3HXIbUI8k+tY+E=;
        b=k1gIN+J7MsRcUn2hoEj3JT28Qrn/3dwISJr10/y6W0rhf+vVZcHJWbuKn1GReunNq3
         xPUkbP6vc3JbMzpAWF/L3oqteIXQSHb5JMmxLD6YquJ6jCCTxBxXF+2+BQFnpWcNWdQ2
         rTMNgasQLrGvuwrRe52bu2oFrfHssQ9H4oy8CmfWReF43ggPIS+izdOYRC6DSu9ePZbm
         UoXa0kKvW1VB7YgIq8wLOGSjPQWXzDnTiet71hoNMAvJbrQtgN9W6rMQLIm4TlallQdk
         uFVcoiabhmNi/A8NjMyWEIkQA+M7CXIoV2/Gkc4ec+q7+P9Rh+j3IVtQztuhmI3ki21P
         3sVw==
X-Forwarded-Encrypted: i=1; AJvYcCXjeIQO9M6QDIbhp5pwcUXarIIbZdBTPI1aqDjVe4LiuVZkkGL+82vZ1twUhIUNagcYV7DVbwe8SUQl9p4rqzBgZdXleci/fRpxhA==
X-Gm-Message-State: AOJu0YzUfyiWYqJ3VqenMMRwpKeJ2SdaYQ7TCTuBSk2Mpij6zPaXaRwA
	U3m6FDWimmPdcXIW1Bmo+vop7AEcKzmDA6V220VANmTQcEc43eDPwtvgPMcgeG+xwDmGhcGIrxt
	oHyyJfw==
X-Google-Smtp-Source: AGHT+IGN1R5DwUVt7tPiqsR2aOiNrkeuqp/Q521qAuuEe47owQ0dfNXWvxUPBrPf0Xkd4LKpQdvoHw==
X-Received: by 2002:a05:6000:112:b0:34c:fd73:55d with SMTP id o18-20020a056000011200b0034cfd73055dmr960634wrx.70.1714692773855;
        Thu, 02 May 2024 16:32:53 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id lo23-20020a170906fa1700b00a5992249bdesm13249ejb.101.2024.05.02.16.32.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 16:32:53 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b782405d5so74160825e9.2
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2024 16:32:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkHE+U8AkWUmj7YRhVG58nWWIxv/YtvKQBheueBt2v/gY6Z0MfDCXdUQ/e3RzYxb0AlG++M/yqGwVL5cqNBU7nTQxzi/NQViw6/w==
X-Received: by 2002:a05:600c:1ca0:b0:418:4aac:a576 with SMTP id
 k32-20020a05600c1ca000b004184aaca576mr1051475wms.39.1714692772592; Thu, 02
 May 2024 16:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org> <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop> <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop> <20240502205345.GK2118490@ZenIV>
 <0a429959-935d-4800-8d0c-4e010951996d@paulmck-laptop> <20240502220757.GL2118490@ZenIV>
 <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
In-Reply-To: <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 May 2024 16:32:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaCSxengJHP82WUwrjKjYsVeD_zEN_We+gmyHpJJayoQ@mail.gmail.com>
Message-ID: <CAHk-=whaCSxengJHP82WUwrjKjYsVeD_zEN_We+gmyHpJJayoQ@mail.gmail.com>
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
To: paulmck@kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, arnd@arndb.de, kernel-team@meta.com, 
	Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 16:12, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> One of RCU's state machines uses smp_store_release() to start the
> state machine (only one task gets to do this) and cmpxchg() to update
> state beyond that point.  And the state is 8 bits so that it and other
> state fits into 32 bits to allow a single check for multiple conditions
> elsewhere.

Note that since alpha lacks the release-acquire model, it's always
going to be a full memory barrier before the store.

And then the store turns into a load-mask-store for older alphas.

So it's going to be a complete mess from a performance standpoint regardless.

Happily, I doubt anybody really cares.

I've occasionally wondered if we have situations where the
"smp_store_release()" only cares about previous *writes* being ordered
(ie a "smp_wmb()+WRITE_ONCE" would be sufficient).

It makes no difference on x86 (all stores are relases), power64 (wmb
and store_release are both LWSYNC) or arm64 (str is documentated to be
cheaper than DMB).

On alpha, smp_wmb()+WRITE_ONCE() is cheaper than smp_store_release(),
but nobody sane cares.

But *if* we have a situation where the "smp_store_release()" might be
just a "previous writes need to be visible" rather than ordering
previous reads too, we could maybe introduce that kind of op. I
_think_ the RCU writes tend to be of that kind?

                    Linus

