Return-Path: <linux-arch+bounces-332-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5707F3B5F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 02:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77051C21010
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938254401;
	Wed, 22 Nov 2023 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwCsdM2z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A6C12C;
	Tue, 21 Nov 2023 17:41:14 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cbb71c3020so264777b3a.1;
        Tue, 21 Nov 2023 17:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700617273; x=1701222073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZkVnSThHSQ0nduxa23VteQPHRdj2Ex/elZXOf6IRxQ=;
        b=hwCsdM2zxxJ5EjZy88b7OGh/WAkqreYdl2vZV+JsgrpGgSlXRKlRhKwf/GqMIAyvjx
         mLORQM7zVddznURZsWaMQIseNG6TfCoGpxBj7yX7hyJJocFFymkOuLm1Rw4Uxat/URow
         bhSpbMHmEKubjYyetZGQFZQkiP0P1tPR8z1lIu3MIMn7+cdyJKnvPpLVZdFe4NFBb03D
         ngic5VpYtEal4ixYE/Efms/RTOi0fQUbywZ/ASoQqDiWL+7SBXtjuTzGuYgY6dDqX0q8
         Idlyk69apU5YfCijVxUCslEjDgUf5gdvQL7K+BqnnTc3KbqaeigrQpMPjndgBKv7Inhr
         2oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700617273; x=1701222073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZkVnSThHSQ0nduxa23VteQPHRdj2Ex/elZXOf6IRxQ=;
        b=gDL3CQKpHqZVKAcj/YZao+1+wtjq7cJ59cG6HKi3H5x9+OD7Dbv2m1KtMd6/YFoQff
         daJFlym0J8nZY5eomy1Gp/wUTwENPuNhgvwKn8T/RQXPbA+QzuUqVecVDmSc/30y1h8M
         rrWzXPNSnGG/oxgfW9heSBOHYHtY+9rpEUWNfAl1jCvKckzSieLyqs/msYijnNReJ+89
         m2FCp+6CpMgI0kItLhcoXqi2JLcSEA2Z3gjsD5/jSdsFAd33OelyhxJlbg3ghs5zGWU9
         2+PiA4XdFeXHCcEH3camGIitmWkhJAbYkbeTY4hDmp5FlHU8sC8C1OUAj4YC9XRK0uWZ
         Lt9g==
X-Gm-Message-State: AOJu0YxVszJF+4pNlTco84lW9YGkHVAIgr4lNdbGPNNq7dZyHgxnn5Xw
	NBirWT0nr5dGEZ8ooKMxcyg=
X-Google-Smtp-Source: AGHT+IHAMbcH80Qv38sfnNHrOUL21YxFpmpRBj4ZbJPJ09PEy1rp7PPEr4++1O5WoMpvW2iMsf+Omg==
X-Received: by 2002:a05:6a21:a59b:b0:187:962d:746b with SMTP id gd27-20020a056a21a59b00b00187962d746bmr1839947pzc.9.1700617273489;
        Tue, 21 Nov 2023 17:41:13 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:da69])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78504000000b006cb884c0362sm5005865pfn.87.2023.11.21.17.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 17:41:12 -0800 (PST)
Date: Tue, 21 Nov 2023 17:41:07 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	davem@davemloft.net, dsahern@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	samitolvanen@google.com, keescook@chromium.org, nathan@kernel.org,
	ndesaulniers@google.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, jpoimboe@kernel.org, joao@overdrivepizza.com,
	mark.rutland@arm.com
Subject: Re: [PATCH 0/2] x86/bpf: Fix FineIBT vs eBPF
Message-ID: <20231122014107.p5zf4o6kjanypla4@macbook-pro-49.dhcp.thefacebook.com>
References: <20231120144642.591358648@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144642.591358648@infradead.org>

On Mon, Nov 20, 2023 at 03:46:42PM +0100, Peter Zijlstra wrote:
> Hi!
> 
> There's a problem with FineIBT and eBPF using __nocfi when
> CONFIG_BPF_JIT_ALWAYS_ON=n, in which case the __nocfi indirect call can target
> a normal function like __bpf_prog_run32().

The lack (or partially broken) cfi in the kernel built with
CONFIG_BPF_JIT_ALWAYS_ON=n is probably the last of people security concerns.
We introduced CONFIG_BPF_JIT_ALWAYS_ON=y to remove the interpreter,
since mere presence of _any_ interpreter in the kernel (bpf and any other)
is an attack vector. As it was demonstrated during spectre days an interpreter
sitting in executable part of vmlinux .text tremendously helps to craft
a speculative execution exploit.

Anyway, motivation aside, more comments in the patch 2...

> Specifically the various preambles look like:
> 
>    FineIBT				JIT
> 
>    __cfi_foo:
>       endbr64
>       subl	$hash, %r10d
>       jz	1f
>       ud2
>    1: nop
>    foo:					foo:
>       osp nop3				   endbr64
>       ...				   ...
> 
> So while bpf_dispatcher_*_func() does a __nocfi call to foo()+0 and this
> matches what the JIT generates, it does not work for regular FineIBT functions,
> since their +0 endbr got poisoned and things go *boom*.
> 
> Cure this by teaching the BPF JIT about all the various CFI forms. Notably this
> removes the last __nocfi call on x86.
> 
> If the BPF folks agree (and the robots don't find fail) I'd like to take this
> through the x86 tree, because I have a few more patches that turn the non-fatal
> 'osp nop3' poison into a 4 byte ud1 instruction which is rather fatal. As a
> result this problem will also surface on !IBT hardware.
> 

