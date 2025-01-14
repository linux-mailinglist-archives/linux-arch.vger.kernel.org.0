Return-Path: <linux-arch+bounces-9782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C585A11010
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 19:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33272161507
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0961FBC9B;
	Tue, 14 Jan 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KFBFTQuv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230141FAC50
	for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879367; cv=none; b=hmLmuGvuDzYHbp2my5gW995EECgt1Up5o8aNRiNevFTq5l8DQWhHsg6A42ZwhgqxQaY7A59/2Xm2y5KLylUVFfCEBJ1k4y2af85Jo+S0yvJri6qa66Dn+gRaGuncne75gLC0Z+Z8/2Zh+0uonMOuK8SeeK62UXYBkl0zYMp3u9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879367; c=relaxed/simple;
	bh=jsa0CovMO5ZT70pqhIrCF6Xwrs9x8fVebY2Xd/EYn6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty/SALo0vFH45WMXZAfwvXe7CVrA6ymzWeeWOOTq9LxZOMtX4XLWt2hULPvKmW34IGSbeJ5IrTO4sEdsG3lVSAWFlVVkjDskmr8cwoAS+kIMG9cix6PhtL9wgkTtIHlunS5wV98nX69/x8LbRQm+FftwB+O82o3G31ACeHUdQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KFBFTQuv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so9848501a12.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 10:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736879362; x=1737484162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+L6x2g4BC/d/+jfoDGOj0pMskOpzz9VGXCLG5E4WwRY=;
        b=KFBFTQuv4suEhQgFHTC00K5qiQ3Jw2kiLcP2Ut9JBRBrS6MG3+DcQWnTJ2OvOmD2ET
         VmAoHdL2GNwADncv1A6R63Igi6HrsrO4q0Iy0Tf0ktWX9MhkhZAWTt4DFpf39SgVrvcn
         goB1HrkuDsZ6EUUMHyn+nRAXkfPC0D6r+s8all1P1Tni6YRXh8p/Hn56TaO13lf8p0o+
         e8waI5tHtQROzxqeDrKmwdFRhQ/JWlNMRBEbvpsdANDX4sa5h9naV2GPaEWOaWIvEYUT
         GOIozzsliRXxnLRPkM//8kc56luukRtxY3CL4EKdxIA1Jd9xtXGcUDyU6uX7Lky9U82N
         XglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879362; x=1737484162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L6x2g4BC/d/+jfoDGOj0pMskOpzz9VGXCLG5E4WwRY=;
        b=fuwXyyXJtRzDqtnBO02om5OKK/5DmfUWqLofALRwaTu3O5ghRaJzZM03N3rWCQgfAY
         bPcE+jWUMuNOpBmisfUNNVrVgK5GBIF1NDenGPb9PBjK8nWXf5d12IWivLaOe4M9qcKf
         HIcKqaVNqzkhiCkM6bbf44n/2Kv3sTgY08zrVzYoehXzjqHItcngQQ/6QmlenI0njceX
         9MzkLlWZb6MQkp5KUhOua8XVdFfBsSRiudIerrYYHl3+Y48qaQaoWV5/z1WmPO1EZT5e
         ehch/9Oah7yv9Nqw7U3vhN/3NnlMVgS150kwEiXmsj6kqB2h4ARObStVxg0Fe6vCIfNl
         sHMA==
X-Forwarded-Encrypted: i=1; AJvYcCUkCF474mZ7ccYk5iXM56Xhi+YXETwRZAguEB1JFPzFmWFAbAyObZyTyszNwlOygSLV9Hg8FihaJtR4@vger.kernel.org
X-Gm-Message-State: AOJu0YxnsDp1uQhT7dfvjwaDHzaHBoJzXb+BrXdqv2fK/hhGZeornt6B
	VuNIwZPpQr9WlOp/zKFFejyq5RAp30ktNBdAI0smiMIEMBUkYgH4ldSWQUXnSwE=
X-Gm-Gg: ASbGnctuU+Df6k0+sN9cGqDeh+/rOp5X6t4pK1tqZtZVDBqpCRTQrLcasGTZJ1MrwbR
	veCTFiVZFnr+IMD8TBCRB93Q4Csc+d5hJ/lY6awkhpLPx4IP25ZqXUuOD8l4GOI/szbVM2s4XT1
	HdNLGW0C/Qj3pCYlOiQ0f9pDpqei5mp8NtnSwqplcAq/9Orhznhy/4frg5kPuJ2Yc03UPDIUFJq
	8R3mGyrEHtZo7fKVSKhpNJm0m/dNfPVPTkqevZlLlYBq4pepfMgsrB7oRDJsvYgPDMKnwzOA4vZ
	LcTj54PGexg83as6MKDBszYr6te04uCwpoYDbN/hIw==
X-Google-Smtp-Source: AGHT+IElLRyBSSFsvDLttv+1rxbirlHss1/zCBNTWvitDc/Y1ed9oUs4kNSXL7wHp3+sai4oSrFAlg==
X-Received: by 2002:a17:907:96a7:b0:aa6:2c18:aaa2 with SMTP id a640c23a62f3a-ab2ab73e7dbmr2340049566b.27.1736879362392;
        Tue, 14 Jan 2025 10:29:22 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905f04fsm659166066b.27.2025.01.14.10.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:29:21 -0800 (PST)
Date: Tue, 14 Jan 2025 19:29:21 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 10/30] riscv/paravirt: Mark pv_steal_clock static call
 as __ro_after_init
Message-ID: <20250114-7fc0ed577ee91b6813f92806@orel>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-11-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114175143.81438-11-vschneid@redhat.com>

On Tue, Jan 14, 2025 at 06:51:23PM +0100, Valentin Schneider wrote:
> The static call is only ever updated in:
> 
>   __init pv_time_init()
>   __init xen_time_setup_guest()
> 
> so mark it appropriately as __ro_after_init.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  arch/riscv/kernel/paravirt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
> index fa6b0339a65de..dfe8808016fd8 100644
> --- a/arch/riscv/kernel/paravirt.c
> +++ b/arch/riscv/kernel/paravirt.c
> @@ -30,7 +30,7 @@ static u64 native_steal_clock(int cpu)
>  	return 0;
>  }
>  
> -DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
> +DEFINE_STATIC_CALL_RO(pv_steal_clock, native_steal_clock);
>  
>  static bool steal_acc = true;
>  static int __init parse_no_stealacc(char *arg)
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

