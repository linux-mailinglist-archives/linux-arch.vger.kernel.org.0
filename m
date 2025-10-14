Return-Path: <linux-arch+bounces-14088-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53627BD6D1A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 02:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2559A4EC126
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 00:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A588C11;
	Tue, 14 Oct 2025 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFSvjMUq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85DCA95E
	for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400098; cv=none; b=DB8A3PD0I4arwOQw8iwv8ePzQn5biiLt56Aba9NcpfQtQwMifjVWrF+Dhg9IfMQZGzkoDFhxNVj6eTT+sdJiN+m1Isx+MbeZq7G9jklH57j4GKDxIuU+olCtiQQ6RG8NhNcDZs+M9GPBHE1exJFEtls4iKalxaYdNiW4CDh+qsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400098; c=relaxed/simple;
	bh=30EZppTfWymzd62I2Q/lqosIjvmCAwH24sBiTejyFlw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pN3T6EWyaPBIYoqoA7g43pODY+R7iOCq0O3ni3wLH7pHhvlH4QM2lGLg61LmFBM0OASRLS8w2FnaNAd6bMSPv13Gi+wORHB+f4z+5Ek4ixGOdPzamEYp+WnG+CioVoBaIbQyNXXyoGb2nuQieQMI9vqfowNyeu2+feWPltMtvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFSvjMUq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so8977371a91.3
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 17:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760400096; x=1761004896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=60W7dGApFCGXHKlXBRGDaLpu3YLgl4WyK3JcN6QaedU=;
        b=NFSvjMUq2klOBCTmti7DH4DcdNC7CMOJwlSo1RjpkXxF3R9H69Ct/dTvIZwFVQR2Xf
         Whf+5fsmbl0P/2Ko+cWUas9w/xZNychL9Ym3NMchbnNtiycj3rh23wYzvURitxbU+DvA
         1rcm65Iu341qU2bQ+gPG1BqmbbCyWc+a2/bn8LPA6JeVxRLWCJdwSBTJbK8qluUXjCk0
         jh5r1YJEpu4ReFUtYHiaKdrkxvn2ppxU6Ws5tRRmX58ukcrReJ3NbCa04Wegu45U+1GP
         0ZXRnOtkDweU4ipy7pGneBjobiANtQ8wLPP0ls3FmwPm2tQ8af0nE4dqKEhXCIPoUzTN
         YOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400096; x=1761004896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60W7dGApFCGXHKlXBRGDaLpu3YLgl4WyK3JcN6QaedU=;
        b=N5MKjUeA5uIN3v+7Ecr4h9plepk74+U93B5VmJzwF2cNfZmqiDQNxMHpoSiJT7vTDE
         dfSzhBlh152RMg3l1kqHjg/RY0D8uY+NcrX/lLSWh5ItdbaOoRO9KX9bK4Hi/kIIPSKJ
         dl6ltgqRqiGZn6VgJpds1BIorQuvok1F9LouDk9EQceeRBa3sX1tHTHjKDCZ/L49Vc77
         CRNE6pFeRvVyeJfPT3hKBC9JX2XmnYT+0rNx1OQEfOkmws1+W6Lhh/hwaiH7nkhOqJMd
         RurvsrIz6cZA6Je48ggleYTNFGadTEcKXM86rCQoV7AT1nZcDoTtorIpSbAi3PR02Q6t
         oMsw==
X-Forwarded-Encrypted: i=1; AJvYcCXQpJ0SWuaLWGi2u/EwmkAJZxvIbdaql91B6HrSqQgAkmCtIzr9vszTK1tuQUKwoV6EY0Lqn4/3KJjP@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHygPVh7FpcCIUurPgV4rIeLLEhqG8O/hHIedk3jF5ojuNhPN
	SlUzQtGvhJE6JnvjDU7a7k45dYxcb1p7xphDE10AVTsr1MsiCnTVC7IhZT+fE77RBiuqaueDzlJ
	4WVFVvQ==
X-Google-Smtp-Source: AGHT+IHFYfnmFjxjbFQp7BMqqD83h/lwfyE6WGt5bwyArJ6H0ox9P/tbWn8NIGRGgabEk9PVFSZMkd4SLvs=
X-Received: from pjbbk16.prod.google.com ([2002:a17:90b:810:b0:339:dc19:ae5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38d2:b0:335:2eee:19dc
 with SMTP id 98e67ed59e1d1-33b5138401amr31287086a91.28.1760400096074; Mon, 13
 Oct 2025 17:01:36 -0700 (PDT)
Date: Mon, 13 Oct 2025 17:01:34 -0700
In-Reply-To: <20251010153839.151763-20-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010153839.151763-1-vschneid@redhat.com> <20251010153839.151763-20-vschneid@redhat.com>
Message-ID: <aO2S3oZwOW_UgAci@google.com>
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

On Fri, Oct 10, 2025, Valentin Schneider wrote:
> Later commits will cause objtool to warn about static keys being used in
> .noinstr sections in order to safely defer instruction patching IPIs
> targeted at NOHZ_FULL CPUs.
> 
> These keys are used in .noinstr code, and can be modified at runtime
> (/proc/kernel/vmx* write). However it is not expected that they will be
> flipped during latency-sensitive operations, and thus shouldn't be a source
> of interference wrt the text patching IPI.
>
> Mark it to let objtool know not to warn about it.

Can you elaborate in the changelog on what will happen if the key is toggle?
IIUC, smp_text_poke_batch_finish() will force IPIs if noinstr code is being
patched.  Even just a small footnote like this:

  Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
  being patched, i.e. this is purely about silencing objtool warnings.

to make it clear that there's no bug/race being introduced.

> Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index aa157fe5b7b31..dce2bd7375ec8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -204,8 +204,15 @@ module_param(pt_mode, int, S_IRUGO);
>  
>  struct x86_pmu_lbr __ro_after_init vmx_lbr_caps;
>  
> -static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
> -static DEFINE_STATIC_KEY_FALSE(vmx_l1d_flush_cond);
> +/*
> + * Both of these static keys end up being used in .noinstr sections, however
> + * they are only modified:
> + * - at init
> + * - from a /proc/kernel/vmx* write
> + * thus during latency-sensitive operations they should remain stable.
> + */
> +static DEFINE_STATIC_KEY_FALSE_NOINSTR(vmx_l1d_should_flush);
> +static DEFINE_STATIC_KEY_FALSE_NOINSTR(vmx_l1d_flush_cond);
>  static DEFINE_MUTEX(vmx_l1d_flush_mutex);
>  
>  /* Storage for pre module init parameter parsing */
> -- 
> 2.51.0
> 

