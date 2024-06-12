Return-Path: <linux-arch+bounces-4854-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD2905C7A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 22:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3207D1F23C6F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342CF25762;
	Wed, 12 Jun 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SHemm3eN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE452F62
	for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2024 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222588; cv=none; b=nyzPcygSrPZDS2W8axsobmzWMfqfF+9UaCENjxuSVhFfzkkS5LxVvvszvg55mbL+NZqQetYm7zfdG/stacyZFQox/WiOWnnei5NpdWqqOOeLtHkHrPWQGqxSCMtU5IMNj8k3XB87nAGimIDGaebph7suPvZHKCMzgq3bSGWWjoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222588; c=relaxed/simple;
	bh=w/o2R21tISON7AeW7xqO04EQQBhuvCqb/XqvhfIneTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndpiKF1boMUTTrdXeZtn7VC+DQH0WqH4uUBQHyabHD0C6dTcjqfW8iVJRfe3Qj2yAhMo23Vc2Uz7tCBqa+E5sJS90XH8+dHbt4k5ppVnSMRAm60IA/hh0+6V2hA1zHFgsgOQ5Vikzv2dMgZ+Z49r4q3Q8zp/OZEH18J5y9fV6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SHemm3eN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so443472e87.0
        for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2024 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718222584; x=1718827384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jI1wFJ2/rQkEuEG+RRwVArfSwVy/ehph3H3jTP2hkeg=;
        b=SHemm3eN+IlgZtN20vEsTB4EoqcU0mh7ATBf52hshyVHBtPA9XpkEHlxb0AYAKdq56
         AwuimggQMRsXPY/OgIR1NvJKuYsWm5pWx9Ex/VzWJU+y4g4ZGPpDIzDlGpkF4vXOB8Mv
         o2wpIa+scj3mwFKwQ+85tjTpKPFB4j2p8R9+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718222584; x=1718827384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jI1wFJ2/rQkEuEG+RRwVArfSwVy/ehph3H3jTP2hkeg=;
        b=eRikgcmPQZp8Qx7tqUt0K4N3SQ8xEM3sLveL4smI3JJsoUhJtz4dJjItCHClCiFVJT
         1ib7qLJKt4e1xjoVYSNKKhq6YJBv2rrHdDWxmuRU6ZTgf5ao+JZhoKb/JT0t4Znyg8EH
         kzh3woPqORA+oc0xFsjojk16x2Z1KHnOXUHEbfFCNM/Hs05rnLnW4UQvqUjTp/FyVY7O
         YGXW1RHXBIHGJkwo7uz9Vo0EfdLQ0nYs96A8FjC18AQr8mjlu4volIIUMlWozO8ruhsH
         pcomWFWwTBCTnbPGCd3DeXLq6MQ9BLgvvRsGF5sycRFWXEA6nH4zcTqxhXihHuBfRHG6
         FNXA==
X-Forwarded-Encrypted: i=1; AJvYcCUuXIdPbP6R9sSEdAueokkOgtjIu9zbzDrqZMl8d8u6kCHVbhZufRk5gf4Ho9oau4acIQ4wu9MRXKeR1u3fcTp3lwgT9aXv6f/fMg==
X-Gm-Message-State: AOJu0Yxo0BBSbfblTe86z2e24SJybrxwofZ2/rHITP+zmFXwRMWhzTQ5
	39TD3oTYxxXgglGTTZxWi/uaEhmGHAoEAmB25iKM9bRPLH7fZyJgQt1j63VYXPBbW+9fPlrAmi7
	jeeyfcw==
X-Google-Smtp-Source: AGHT+IHSmPBeZosS+2J66GIOJGPCb/RI/dW8cAXWWKLJC2WfEpJ+zhFkskvkKNWP+WTCMWMtgHIvWQ==
X-Received: by 2002:a05:6512:31c7:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-52c9a403655mr2695154e87.55.1718222584389;
        Wed, 12 Jun 2024 13:03:04 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c7fbc21bcsm1961722e87.143.2024.06.12.13.03.02
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 13:03:02 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c82101407so529333e87.3
        for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2024 13:03:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxhEWMO+7linHP+2OAIZo+nTSuOerDsOB+mPmUFuysKkortZoDko3pJjEjb9fzgHSbL0BbM2ppCDLKMn8oLHP8tkcjdNVO0lsUsw==
X-Received: by 2002:a05:6512:3f10:b0:52c:8a11:cb4a with SMTP id
 2adb3069b0e04-52c9a4033b1mr2648787e87.46.1718222582015; Wed, 12 Jun 2024
 13:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org> <Zmnr3BjBkV4JxsIj@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Zmnr3BjBkV4JxsIj@J2N7QTR9R3.cambridge.arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2024 13:02:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1AffeA6HLwZG9gbnFUACuzT-pyzao6BfQeZiCFt752Q@mail.gmail.com>
Message-ID: <CAHk-=wg1AffeA6HLwZG9gbnFUACuzT-pyzao6BfQeZiCFt752Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64 / x86-64: low-level code generation issues
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 11:41, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Given how badly things go when we get this wrong (e.g. TLB corruption), I'd
> like to say "just mark it incompatible", applying to all instrumentation, not
> just KCSAN.

Ack. I'll start out with just KCSAN (since that's the actual technical
issue right now). But since the SW PAN support is hopefully not
something that we should worry about going forward, I wouldn't mind it
being de-emphasized.

It's not like PAN is something that should necessarily be everywhere.
The real advantage of SMAP on x86 (and then PAN on arm) is that it
catches wild kernel pointers. As long as the HW support is common
enough, people will find bugs on those platforms.

So I think the advantage of SW PAN was "it will find issues early
before HW PAN is widely available". It might be time to lay SW PAN
entirely to rest now.

I'll send out a new version of the arm64 patches with the KCSAN build
failure fixed (with the simple no-op save/restore functions by making
KCSAN and SW PAN mutually incompatible), and with the virtual address
fix you pointed out in the other email.

              Linus

