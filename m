Return-Path: <linux-arch+bounces-14099-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05306BDAFED
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 21:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D87219A3C12
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 19:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5A29ACF7;
	Tue, 14 Oct 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9mTlzH3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C0235072
	for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468796; cv=none; b=gaaFpcZp9KYB/brlKl4fy3VxqPRrrt5sr+Pm1+VuDsoGMAMiG/ZNWu/1zjXjJtQBQcJl26rFI85ZWD9r7arkOoAuaN5mwMkSYXQieg6YTkXmAR9z7eh+DJL8vr7xCZKrQqNLrGbpCNpmiNQ6uG70XDonR/JuqZFN7xQ8CTULgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468796; c=relaxed/simple;
	bh=YHkoBXMGobkLQ8o+PhxXHefddsG1ieCfaB2d71pVtoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rjJNuepkyonJ56TPSDwJ/p6VOaCmZMI0TxA8atV3eJ04C0KZBe8q6pLdY/wHIaJJFkOmagYeqZ2/QFiM2UQE7WqPthHNBfsMXcuKK7x9SwuuE54nWaVeXclrs6ipfncaSPG6uKwofhOvLXthSyNVvcMS5JBCzjW32K7nWeor4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9mTlzH3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-339d5dbf58aso22048153a91.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760468794; x=1761073594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJxlV+oNDwXk+z+h9rw/7gmtAEVoUIc/lNQpO7FKflY=;
        b=c9mTlzH33TKdq7MgxgmTSkLCArSuZg7B4e0qDn3gZNHjLLvsabhQeY6mzURYf+WPgU
         U5647dVwI4KzZYLv9uRGibfg6//ulkcGUwpkewXvmBp0ti2ZSUhZZt4Q21c0qwyRqJ82
         xH93ynUJSLEwrYwZJHpUa9kS/B9OpxVbHi6GPzsPwo4FJbawEnCwPPqnNLfFRLM72280
         GuEdjZ+duAelDUVm7l4HTRBCPcKwPwfFyRYHGzO4jfuRnNcAI8H7uugBYKRRe1A3LC0T
         JvPeqkkloEWlAOFkXO1ADiaKT4lsbmdrsQx6ptNtgnT51oOA0TZXe9CTALm9IR5uyo0V
         BMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760468794; x=1761073594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJxlV+oNDwXk+z+h9rw/7gmtAEVoUIc/lNQpO7FKflY=;
        b=i4SGit1PTTWggUb2mepozsZ2JJRVN0fZwK6aGN8t2aovEvWvp0nsLYgH91sb5B2kTa
         A//tqSdvgi0tfBk103hv60tXG08mMnu97UDyhCzqC4OhiF2dIpx9d6NBj6mDy92t5rPs
         8oGZoGWjxYCVkpYCZvnP1i7VhL8xyH19CMJg97kYuiUEv6Xz/E1QehF9wDqgQLYBAxll
         xO30oUZAOZaf4TJxBTqbeFRGW1fY7crtgiIcimuVusmBCy2yFdVNpuoEYqpiTffENQgK
         0fdz9496U73znikQgfDgW41NSsm9cLKgov1YNCHBFrw48Sa+tU4Al4JHVJD9u4twp5UW
         7FCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQt1ozGBLOOllxQ3Ke0EmqkOzrGnYeEqYN4Efp6kq+anareEurGoUSmr/d33nBsTuCQ2oxAX55OSfM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61lk4LwwWAjCVCjf1jDjCKYL/frSVg3hsyWPMqY/WZevVTe8C
	Ocp8I6QT7D8zzFbE8OxkRqZ17tccunbUBCxy5FBWaOS3JcMzjp8ROUcnkJPMyiKSIXEMYDKMtS9
	dWAbQog==
X-Google-Smtp-Source: AGHT+IG9Zd3t+86XRNhfr6MOl3z2x5n36Sr6uReq0nGSm2P7jNviBzkfzWGC0x9bWFlsxNGdGfsNX6JxluA=
X-Received: from pjuj14.prod.google.com ([2002:a17:90a:d00e:b0:32b:95bb:dbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec5:b0:327:e018:204a
 with SMTP id 98e67ed59e1d1-33b50f85081mr35201870a91.0.1760468794156; Tue, 14
 Oct 2025 12:06:34 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:06:32 -0700
In-Reply-To: <xhsmhwm4xpwyt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010153839.151763-1-vschneid@redhat.com> <20251010153839.151763-20-vschneid@redhat.com>
 <aO2S3oZwOW_UgAci@google.com> <xhsmhwm4xpwyt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Message-ID: <aO6fOM-XydknM6NJ@google.com>
Subject: Re: [PATCH v6 19/29] KVM: VMX: Mark vmx_l1d_should flush and
 vmx_l1d_flush_cond keys as allowed in .noinstr
From: Sean Christopherson <seanjc@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, 
	Yair Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 14, 2025, Valentin Schneider wrote:
> On 13/10/25 17:01, Sean Christopherson wrote:
> > On Fri, Oct 10, 2025, Valentin Schneider wrote:
> >> Later commits will cause objtool to warn about static keys being used in
> >> .noinstr sections in order to safely defer instruction patching IPIs
> >> targeted at NOHZ_FULL CPUs.
> >>
> >> These keys are used in .noinstr code, and can be modified at runtime
> >> (/proc/kernel/vmx* write). However it is not expected that they will be
> >> flipped during latency-sensitive operations, and thus shouldn't be a source
> >> of interference wrt the text patching IPI.
> >>
> >> Mark it to let objtool know not to warn about it.
> >
> > Can you elaborate in the changelog on what will happen if the key is toggle?
> > IIUC, smp_text_poke_batch_finish() will force IPIs if noinstr code is being
> > patched.
> 
> Right!
> 
> > Even just a small footnote like this:
> >
> >   Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
> >   being patched, i.e. this is purely about silencing objtool warnings.
> >
> > to make it clear that there's no bug/race being introduced.
> 
> Good point. How about:
> 
> """
> Later commits will cause objtool to warn about static keys being used in
> .noinstr sections in order to safely defer instruction patching IPIs
> targeted at NOHZ_FULL CPUs.
> 
> The VMX keys are used in .noinstr code, and can be modified at runtime
> (/proc/kernel/vmx* write). However it is not expected that they will be
> flipped during latency-sensitive operations, and thus shouldn't be a source
> of interference for NOHZ_FULL CPUs wrt the text patching IPI.
> 
> Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
> being patched, i.e. this is purely to tell objtool we're okay with updates
> to that key causing IPIs and to silence the associated objtool warning.
> """

LGTM.  With the updated changelog,

Acked-by: Sean Christopherson <seanjc@google.com>

