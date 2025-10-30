Return-Path: <linux-arch+bounces-14427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B666C1F83E
	for <lists+linux-arch@lfdr.de>; Thu, 30 Oct 2025 11:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325541A21ABF
	for <lists+linux-arch@lfdr.de>; Thu, 30 Oct 2025 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7133B955;
	Thu, 30 Oct 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MNEEIXp3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB77351FC5
	for <linux-arch@vger.kernel.org>; Thu, 30 Oct 2025 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819920; cv=none; b=MYgsOAF/BjBOlIRWkmMaVipuM+YN3w0gA4cWuyAJXWlJYcK3UPGgO/EHGbvzIkeVh6PvtKI5X9av7+1NkJG4OySH/CSInE2oOenYhR1XgwA2YkHVC7dXwHhOq+posVQdQFAkxDb+YyvXA6wgkPMvKEIAg6ho8o4ws67fpC4B2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819920; c=relaxed/simple;
	bh=/OiTwmyjWBCx0q96Gsr9SY27ybAo0GLz8Cev2v1IhyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2aTYjeXX17n/xCM3LI+AoeCrmRtcLpd8hY1bH9bT8lY72HNXWZjIa5/0QqKm7yqqH6V1zM+82nv+qhykA+VG6R5GSkpiCUUW7N1RYU9ehYrP7z4HChkV3cF92Pk1Apwty03z5HjGQ/EwFGPLFr93tIrvh5L7fHOP7BBlsVm/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MNEEIXp3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d676a512eso14586366b.2
        for <linux-arch@vger.kernel.org>; Thu, 30 Oct 2025 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761819915; x=1762424715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTgIsc3O+wDypaKqBlwZIo86kBPQGfr40arZuVCJ75M=;
        b=MNEEIXp3U3e0BlWXVNtco0TH/amTu+TWkWbkMT7o3svpJoWGHknjv0tQvlPVZErEpb
         gttDBZ8rFQUqABpCwyEN46K67Dy70sW3C2i7qddNytI8b38Bsa2naTSVzL2l27CGHhAc
         IZa6tvQeQsVLiSlDH/LYcokupeT96buvLXhSAECt1EtD5IrHWHuAquKgCRdMvpLYxDKy
         nBBckInWtiGQZvPlCGpnEw8FdtKP09FrBU++uDTRIXmZ/Hjj0nKSPRen4hNJZqQ1OMYb
         HMLQrFZvSOfO3nOwZ+oaMtPsh9hHwmvU0DjntMRJf9wjMq/z6zjXb374d+BXtFsqSwOu
         dXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761819915; x=1762424715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTgIsc3O+wDypaKqBlwZIo86kBPQGfr40arZuVCJ75M=;
        b=wYtH4WwpDgseJfoNzH24/mJ9MO8bf8MCvS4EBtxJliXTqFWarqdNrcxNM+yUjQB5ok
         b4l0ml+7VANfjnfOrr6xhNVm0Z/EFI2zEZpiOGpeAhRP4Rct2Mrx+v9pKpw1tpikwgbN
         4EoUsAzHb6QhY5kkzQg/iLp8L60t6qsC6zynm769FMKczqVHBKlM5UD8WUvRAnWNdjNI
         CRn2mU8dNVqd/4e2rwvQi46OVH003HVeww+dfs4buYHvj32mXi/GVzv8rwYbm6D8topk
         3//FBhdCkEAg81Rip26qcBgQyHk/LIrwSitYL0PlPuj1n6EElCs6hyg51il45jl1PIb2
         MBHw==
X-Forwarded-Encrypted: i=1; AJvYcCUdgIntiQweTYOwxxtzqSpG6hTp5wxCyoU6IrrgXOCVn/23Teqf4RVzmiwWTwYFjYhQWQVVEQQPigmh@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXOFnr+A/T/UC2hEhxbZ2oLijIWknAtSJqXNS6HkHKL2Jl8zm
	2pZQ9wqPYnwDDEvGxAxocehXXkhIZYW1MKQ4gwjCtYdu11uaYVuy7K7acnG/nxa3GjE=
X-Gm-Gg: ASbGncumbuA6VdBbNU1URhuQckC2PAIntjqau0Yi9yKzWxQw4yiFkDHgfdaXX3wtWvO
	FUNDyD7gt78BM52loAZyq1rxMjr3WDxRCXaYU/hKIWDWnD83iYzYKBjyrvViuNco1D7Mbrqr2B5
	ZNnjhomPp1FsylYjb48TvGic2AAP8LhAIZf8DKmI/5pagPhAuDZBdnbNMQuzz9ptPm6c2mLt+Y2
	phhKp1C+WlybJGTVkcf9vtjfLigewWsYiR3DvUcpUdbaDs7vg55w2+bysJieB/o6mNtMVZ9hwLP
	WueczfaVzkOYEgIjM8Wvr+nCFm+D6fIBJBa6d4rbdLgaUjpB2q4T3Ma3DNLb1g2fAYcTknATWfW
	Rgf2y/j+EVGT38UEPawInNrgIW60MOWN924p8QFRMB82HZ569QAn+YnGLafSryahfiCW/UsOfTi
	NVhu5kB1BBvm+ASPEEW0FLan86Ul7TU7v8DfuxroZij+RQM7+H+RcNPLENS7g9s40QsASbVxt7h
	8DF
X-Google-Smtp-Source: AGHT+IEXsUOIqP3MBMqvuO3EOkZU6BKA34oP58piwLuVoouucxjytl3skX6Ka8nntE+ckkHO79CK6A==
X-Received: by 2002:a17:906:f586:b0:b6d:5439:e668 with SMTP id a640c23a62f3a-b703d55e454mr372826866b.8.1761819915166;
        Thu, 30 Oct 2025 03:25:15 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c549fsm1728375066b.37.2025.10.30.03.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:25:14 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:25:03 +0100
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
Message-ID: <20251030112251.5afcf9ed@mordecai>
In-Reply-To: <20251010153839.151763-7-vschneid@redhat.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
	<20251010153839.151763-7-vschneid@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2025 17:38:16 +0200
Valentin Schneider <vschneid@redhat.com> wrote:

> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Deferring a code patching IPI is unsafe if the patched code is in a
> noinstr region.  In that case the text poke code must trigger an
> immediate IPI to all CPUs, which can rudely interrupt an isolated NO_HZ
> CPU running in userspace.
> 
> If a noinstr static call only needs to be patched during boot, its key
> can be made ro-after-init to ensure it will never be patched at runtime.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/linux/static_call.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index 78a77a4ae0ea8..ea6ca57e2a829 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -192,6 +192,14 @@ extern long __static_call_return0(void);
>  	};								\
>  	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
>  
> +#define DEFINE_STATIC_CALL_RO(name, _func)				\
> +	DECLARE_STATIC_CALL(name, _func);				\
> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
> +		.func = _func,						\
> +		.type = 1,						\
> +	};								\
> +	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
> +
>  #define DEFINE_STATIC_CALL_NULL(name, _func)				\
>  	DECLARE_STATIC_CALL(name, _func);				\
>  	struct static_call_key STATIC_CALL_KEY(name) = {		\
> @@ -200,6 +208,14 @@ extern long __static_call_return0(void);
>  	};								\
>  	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
>  
> +#define DEFINE_STATIC_CALL_NULL_RO(name, _func)				\
> +	DECLARE_STATIC_CALL(name, _func);				\
> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
> +		.func = NULL,						\
> +		.type = 1,						\
> +	};								\
> +	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
> +

I think it would be a good idea to add a comment describing when these
macros are supposed to be used, similar to the explanation you wrote for
the _NOINSTR variants. Just to provide a clue for people adding a new
static key in the future, because the commit message may become a bit
hard to find if there are a few cleanup patches on top.

Just my two cents,
Petr T

