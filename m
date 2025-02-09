Return-Path: <linux-arch+bounces-10066-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD2FA2E039
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 20:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF277A28A2
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F6C1DFD87;
	Sun,  9 Feb 2025 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TTt79j06"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566951DE895
	for <linux-arch@vger.kernel.org>; Sun,  9 Feb 2025 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739129574; cv=none; b=QXYSufjOesVcRHdEYXzpOn/c0GZPKQqBovzkgHzFODUfJWphJ/nKy8Fa8dVB1V1HY8ufQqAV63mHP58uJtbPHLqtcosbq8mgteWxcmd0a+be8N9koxvvX3EWigsQyxFuz7hssRRzJLhkEG6WFTMf3TN6S4fUHF9fJpTGCwQ/l3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739129574; c=relaxed/simple;
	bh=Hw5Jj54lHlKsvWdyOciOtY61GHLLyD922U2Ybh/FkBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeSJjNjuxA6SfDkz4KAPmbxnUlgZndgixgKVItWGCxbIjwU8q8vKhlnFG7f9XsUNkfbOnCjcMb+BIx8PeLrySXbR4Og2+w7803HFqy7FifXl3yGUlm/ZMJ34xF+EsWf0tkyOoJHPM/UnBIrflBYiXmF45GjSHjE+o3EgU3r5h4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TTt79j06; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec111762bso902705466b.2
        for <linux-arch@vger.kernel.org>; Sun, 09 Feb 2025 11:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739129570; x=1739734370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3OYZn6iFxER/JL2avDuYDbzyExRqovS2QnLbQ0tqh0Y=;
        b=TTt79j06V5N7kpMsJ9dmNP0lmMwZIhiGlpk8+4q1Yg+vP4C69Z+hdPJeDBaa4KpYxI
         p8nbrw1KPz5KI1NRHmM+J1E22S9m/X0I+3alhh7tmJ0fXEbyJ6f7ThGhRiQ1tRNSt+bq
         SOHHAphYQFPlcknHJCkorRGWPtFmrSpu38h9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739129570; x=1739734370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OYZn6iFxER/JL2avDuYDbzyExRqovS2QnLbQ0tqh0Y=;
        b=vXTWilB2v3UFe1RJpLWK/LKEVTI74PquhX7P6CwT9v47oxPl2/0ThEfoDYpT8TQP8J
         NZ/6U6CnUeLcZbPlmtkppIlGK0zfZXIZMGZX/8nOka2CgBf12ygn9payWPim9fRabErT
         4yHME61JDyuso6xSj0FfgHVyvLxIA5NU70ULeQSdE0uRzYKqHxrjPpCwxuW7LTuwnfvN
         OWE0E9CTHTIg3eXa5Pn/XPKJvpsBp3iQvboaL6eFR3vAKQR75xPVfELWmQMtFNi+WTlQ
         EBe6joiMqaPWfN7SPEBT7WjVmdiehIw/TKtI7NEgS87J4VGxY4qmBZC2vQ3uO3hTZT7z
         ADbg==
X-Forwarded-Encrypted: i=1; AJvYcCVmns8kVT8UY9ohJSGwVmd2HPD3jTRVdqYdES4Qi+ezV7gZTvpCZjzstetbdfPIxbk+UUmLv8SekH7c@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMLcSU8dL32+lTVSczbDHoW4bXIjwk4BdyL803L+jRCCpEbJa
	PAI0MuYxRa1zcli5+bAVEhpsfEUf95F05hiN8jLCUxmu8fWcZMKxefKHc4rBRUfY7Q86PARI5uR
	9Smc=
X-Gm-Gg: ASbGncuzt6UcGmNozn0tfLJAKPQI5NQ1M6sVIvIqu+ZobP1eTFESqgrFGxTdwHSiTiY
	87m1DbKpDi5rzVIziA7NgOr8zs32wEBRRFIO2OHoxPtoXth3oBgZqD+mGcXVpC8adsAP30RZpgg
	Q+G4RKmDVp/BNNhn02nVNbU4HTBzRWF2C9Dx43a6P4Csth5BcGEW1Q4AgiJyyJsV21LPmaXDFfN
	r9R0ecOR/nPWjXSIRw8AS/xovlL80mYt2/4muEYOqMjfGctFiLa4ppkxh7JEfffPQttlp+IYLH1
	FrR8zcJ4yvG6lK4NbbeNw7no+c787FDqkpGoUoNtwJv1NaO0qQZ9jITBLzOgAy14Vg==
X-Google-Smtp-Source: AGHT+IFsBS2XJc96KyYsDA/asD4Jmg5quvRnwedPfm5TwgdjKxKP8U7Wz68KHNYmsQRMRgjxkGuctA==
X-Received: by 2002:a17:907:1b0f:b0:ab2:b84b:2dab with SMTP id a640c23a62f3a-ab789b9c605mr1352385866b.30.1739129570175;
        Sun, 09 Feb 2025 11:32:50 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f8436dsm726380866b.54.2025.02.09.11.32.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 11:32:49 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so682772366b.3
        for <linux-arch@vger.kernel.org>; Sun, 09 Feb 2025 11:32:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNQGxKGWDy9wPkd8uNGNVNueqG6A7phvV4eaAEyeHX3SiwLdgWotnGyW1xvKg/ICX+nJV/bO/CGQAA@vger.kernel.org
X-Received: by 2002:a17:907:7e92:b0:aaf:c259:7f6 with SMTP id
 a640c23a62f3a-ab789c627e1mr1220851466b.45.1739129569271; Sun, 09 Feb 2025
 11:32:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209191008.142153-1-david.laight.linux@gmail.com>
In-Reply-To: <20250209191008.142153-1-david.laight.linux@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 11:32:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQQQ9yo84KCk=Y_61siPsrH=dF9t5LPva0Sbh_RZ0-3Q@mail.gmail.com>
X-Gm-Features: AWEUYZkIEyygdjdtgqEM9UjeSXpn0CystKuNI2lg08YFjtDgCkT1DG_hRzS76Rc
Message-ID: <CAHk-=wiQQQ9yo84KCk=Y_61siPsrH=dF9t5LPva0Sbh_RZ0-3Q@mail.gmail.com>
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

On Sun, 9 Feb 2025 at 11:10, David Laight <david.laight.linux@gmail.com> wrote:
>
> +#define barrier_nospec() __rmb()

This is one of those "it happens to work, but it's wrong" things.

Just make it explicit that it's "lfence" in the current implementation.

Is __rmb() also an lfence? Yes. And that's actually very confusing too
too. Because on x86, a regular read barrier is a no-op, and the "main"
rmb definition is actually this:

  #define __dma_rmb()     barrier()
  #define __smp_rmb()     dma_rmb()

so that it's only a compiler barrier.

And yes, __rmb() exists as the architecture-specific helper for "I
need to synchronize with unordered IO accesses" and is purely about
driver IO.

We should have called it "relaxed_rmb()" or "io_rmb()" or something
like that, but the IO memory ordering issues actually came up before
the modern SMP ordering issues, so due to that historical thing,
"rmb()" ends up being about the IO ordering.

It's confusing, I know. And historical. And too painful to change
because it all works and lots of people know the rules (except looking
around, it seems possibly the sunrpc code is confused, and uses
"rmb()" for SMP synchronization)

But basically a barrier_nospec() is not a IO read barrier, and an IO
read barrier is not a barrier_nospec().

They just happen to be implemented using the same instruction because
an existing instruction - that nobody uses in normal situations -
ended up effectively doing what that nospec barrier needed to do.

And some day in the future, maybe even that implementation equivalence
ends up going away again, and we end up with new barrier instructions
that depend on new CPU capabilities (or fake software capabilities:
kernel bootup flags that say "don't bother with the nospec
barriers").,

So please keep the __rmb() and the barrier_nospec() separate, don't
tie them together. They just have *soo* many differences, both
conceptual and practical.

             Linus

