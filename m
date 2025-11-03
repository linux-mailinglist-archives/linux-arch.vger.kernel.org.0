Return-Path: <linux-arch+bounces-14461-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA63EC2A96E
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D80B4E3468
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C962E0917;
	Mon,  3 Nov 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mnf5ROZP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53702D5922
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159061; cv=none; b=ERKSKAUVLw3oGq5S4bbZXKG8SefNAulpkY0Eu0SA9/Q/xsGcMW/fBK+YdbpTpA10zIUdEqYojzskk1YKgZNteLNYbzas3Z4Wz7FhN6pg27zajmKesIORskLQPbweKXPbbWzdzMXHlgLcLQbXcV+mAnLWlWjYgJXshLkHNUK08SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159061; c=relaxed/simple;
	bh=VPQocaf6gUl8BS3pejlUrKCB/3VeiYl/8q6ahm5+LvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTk+mAbcO98R7auPKyPcC23J8BcsGsWmmHjaqIoo2+yitPidSL4lemsAemCIA0jMPosuHIX6pf5Ygp4va1RqELuw6gXlZuI2x5KasxUTizu7/Zy/gG+ruX9ptAFuLS0eEAmcIfGSX2qzCEJfwXQu3GjNaMggc3LEp4l16ecCaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mnf5ROZP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6409cb34fe0so344866a12.3
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 00:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762159057; x=1762763857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6+8IBdXCcTU6eZ4JMuY2we8/fQYN6+oBue210uWprk=;
        b=Mnf5ROZPFeEGjQSTjLFS78Z4bYSK7xLjDs/P/VGFnqiJ8Qdu1iKEE4VBPyh5IansPP
         atAMh0tHLmBey2Pja9dgn9J6wHuOJo88+eBrZuyzmcpDa5Ab1lhGl4FFmVf1mBvwIuEK
         ngoK2Rooxz3Bx2hoOsmaOjExYVs18lLjzvwOPL7kJ+Frc+MKmJNZ5Gfcu4mk7zr3b0QB
         SGt1n+1Pv0lejRv1kmnwo9icAZpKLf0wtKrn8Mbu1qE7JqnPLPsMYNjhJF74mk7BZ0nO
         Zvy+68ys66H2zy0xJLl5iuw6/u3MTtW1G2lJu6G3vzjXDwvgYGbokGRlDrdvO8qygvF6
         oTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159057; x=1762763857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6+8IBdXCcTU6eZ4JMuY2we8/fQYN6+oBue210uWprk=;
        b=bkXwT7kBc3Up4MhzqXSX7hh3vFI8XfgCt2HJVH6PTy8JfbCxpwMRIDr6uXbNaQdwpN
         /b/KVTedi3IYyQUeD+RKzxN2ihxpNwdMBsU0NHK9lAjWHUD7l+2mBmFyYRA3NozfAH5Q
         eGDjbU44Kq6qeAOVKsf1rlOfrE5kAgLEilgIPsytjQK+ox7BIgwmcLHS/Uv7mBKKjx2V
         swvFBby/t/xMElYUZVP3sHbVMn7CpsL2nY6HJP9Knyovyc0CjAOFAKNU58iKacE6+e5m
         x1K00wTEFL9+Rl8JK4udNaUbBICX1lU7VOpYKLeXPiXlt+PKtqPmBSDgGWZNMHBDiD46
         GgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXRvE7xvXfdo5ws2sKJkPn87AvCwVKqr3QtKPvK8qmXS4nHXjKft6FBFaDKHcTXOOxgcixuGWlTcx7@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHIRUqvTt+CQbg6cWftv8yTeztKTRBTpIj1Vrc+gqgLcbXCIB
	rE3mycT/cbV01jj+XL6yvr8sMcvFp7ZG3Dotj4PdJfWu5v1lriDZqdAHmcU04bskBBY=
X-Gm-Gg: ASbGncvUl9plOUfnIAYsQZOpb9DQPXnTtqhG3/wzKJi23ydXGm9o8DYzP/7SLnZK1il
	J0Z7T92nkBCwqYPTNHm412o9CCa3z5FhiCyGa9/+yDn0Ldnm6CrEeo0xIdFY5DgZLUjDPx8wWhE
	OGCB7Ot8MVr5Y0X16s7rRO5rK5fNgyW8oUS5Yf0ZoT4X85JfWLH6d/fVp10ewUqyYQnVamBbMRm
	fxe0Xt4pxNBj/7m2Skmdn6cbRQ9MO6qqFud2r6oon6J09cM1P68h0lIg05ddBzn8tHDMX+3fibK
	0AVERcQ6hosSGhga/8isSx/D9MtEGHwo/ByPy89jp/MNGWEFnP4oQq2rYaeMlsnsKpFGGWl61Ua
	6uGRUAfpszda2Z/8O9Q1OQgySp2uVC4ENcLAPuXplwOVXGFtmxZk14YZEFA0rR388NmEJJ8eaOX
	d8+jjrAh4zm3yr7g6uIXSw+z6vN0QtMsbKpLJX+MPZh6HJiJZzjSfBAvO28n/K7o//nBiogAwfl
	mD1
X-Google-Smtp-Source: AGHT+IEXAMzB4Q3iZseWqc5EI+3z01yD/lkzyZQiHdGqXZRiWGSYaalZ7FPGcsDnEnqBbvKYbK1akQ==
X-Received: by 2002:a05:6402:27d3:b0:640:9eb3:3683 with SMTP id 4fb4d7f45d1cf-6409eb34460mr3244974a12.1.1762159057100;
        Mon, 03 Nov 2025 00:37:37 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b428119sm9012005a12.24.2025.11.03.00.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:37:36 -0800 (PST)
Date: Mon, 3 Nov 2025 09:37:28 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
 <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, "David S.
 Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn
 <jannh@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, Oleg Nesterov
 <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Clark Williams
 <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v6 06/29] static_call: Add read-only-after-init static
 calls
Message-ID: <20251103093728.031042d0@mordecai>
In-Reply-To: <xhsmhqzujp9t3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
	<20251010153839.151763-7-vschneid@redhat.com>
	<20251030112251.5afcf9ed@mordecai>
	<xhsmhqzujp9t3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 12:52:56 +0100
Valentin Schneider <vschneid@redhat.com> wrote:

> On 30/10/25 11:25, Petr Tesarik wrote:
> > On Fri, 10 Oct 2025 17:38:16 +0200
> > Valentin Schneider <vschneid@redhat.com> wrote:
> >  
> >> From: Josh Poimboeuf <jpoimboe@kernel.org>
> >>
> >> Deferring a code patching IPI is unsafe if the patched code is in a
> >> noinstr region.  In that case the text poke code must trigger an
> >> immediate IPI to all CPUs, which can rudely interrupt an isolated NO_HZ
> >> CPU running in userspace.
> >>
> >> If a noinstr static call only needs to be patched during boot, its key
> >> can be made ro-after-init to ensure it will never be patched at runtime.
> >>
> >> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> >> ---
> >>  include/linux/static_call.h | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> >> index 78a77a4ae0ea8..ea6ca57e2a829 100644
> >> --- a/include/linux/static_call.h
> >> +++ b/include/linux/static_call.h
> >> @@ -192,6 +192,14 @@ extern long __static_call_return0(void);
> >>      };								\
> >>      ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
> >>
> >> +#define DEFINE_STATIC_CALL_RO(name, _func)				\
> >> +	DECLARE_STATIC_CALL(name, _func);				\
> >> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
> >> +		.func = _func,						\
> >> +		.type = 1,						\
> >> +	};								\
> >> +	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
> >> +
> >>  #define DEFINE_STATIC_CALL_NULL(name, _func)				\
> >>      DECLARE_STATIC_CALL(name, _func);				\
> >>      struct static_call_key STATIC_CALL_KEY(name) = {		\
> >> @@ -200,6 +208,14 @@ extern long __static_call_return0(void);
> >>      };								\
> >>      ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
> >>
> >> +#define DEFINE_STATIC_CALL_NULL_RO(name, _func)				\
> >> +	DECLARE_STATIC_CALL(name, _func);				\
> >> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
> >> +		.func = NULL,						\
> >> +		.type = 1,						\
> >> +	};								\
> >> +	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
> >> +  
> >
> > I think it would be a good idea to add a comment describing when these
> > macros are supposed to be used, similar to the explanation you wrote for
> > the _NOINSTR variants. Just to provide a clue for people adding a new
> > static key in the future, because the commit message may become a bit
> > hard to find if there are a few cleanup patches on top.
> >  
> 
> I was about to write such a comment but I had another take; The _NOINSTR
> static key helpers are special and only relevant to IPI deferral; whereas
> the _RO helpers actually change the backing storage for the keys and as a
> bonus are used by the IPI deferral instrumentation.
> 
> IMO it's the same here for the static calls, it makes sense to mark the
> relevant ones as _RO regardless of IPI deferral.
> 
> I could however add a comment to ANNOTATE_NOINSTR_ALLOWED() itself,
> something like:
> 
> ```
> /*
>  * This is used to tell objtool that a given static key is safe to be used
>  * within .noinstr code, and it doesn't need to generate a warning about it.
>  *
>  * For more information, see tools/objtool/Documentation/objtool.txt,
>  * "non-RO static key usage in noinstr code"
>  */
> #define ANNOTATE_NOINSTR_ALLOWED(key) __ANNOTATE_NOINSTR_ALLOWED(key)
> ```

I agree, this makes more sense. Thank you!

Petr T

