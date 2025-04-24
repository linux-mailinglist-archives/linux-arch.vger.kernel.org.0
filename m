Return-Path: <linux-arch+bounces-11556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64485A9AD10
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11D01897FFE
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 12:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941D230D0E;
	Thu, 24 Apr 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Wsmpr30p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310122D780
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496997; cv=none; b=TlyMMLPHXier87bfrKc6J5GVnu7rv828mIjssGudqLvjsUvyCHVNL4sNN2rER6Fso7TfAahrOn6E8vr+nMjhi4TwACCbWF6x+owp0RcJGc+HJEA85vEijA/fsa4mbKkCMscqRHqBKkx+i7/OI9SshisWorgKb+mrlP2b/MskRmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496997; c=relaxed/simple;
	bh=Uyv4cF6roX/rqkabZ8AOPchJ7yqQ3BZD7UJEcGbUnSY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=HYN82DU6o5OzkhPqSPINbBuaaRTpjZDS9srjpHbDbzSFCZnk2Tz+kx8DODFEokIMYpAi7ZsoxNlblJ6EwRFdMI8xdQdWdaA69AX+javzOr2MweEIORK0Iezok4u7a2kvihgvMcPixzrtxKC1CYEnMrawLQ97bmVe8/jfbFuJKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Wsmpr30p; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913290f754so122562f8f.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745496993; x=1746101793; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byLZxcTmkHUnhPkEGnhkt8kzHy94FpcWiEA8cXwsuq0=;
        b=Wsmpr30poYCAfYRyzPvB/UKdx7aMJQxZiKrY6+7Fc+wqkXq2JKC92pP40TNuGLyznO
         J0k6TPUycyj4xKJygrOkgJk/JNY0LqKpStnlGWO/IlKB/P+X7otxfD+C0HW2Tj3FcThj
         frwGBAfNIV9V+6ueHR8SSBmJRwFoeyxh5WmOpqNqXukH7UUrWVf3aIC6chBZnN8yuZV6
         wLqVhy7qbDlMLeBgCohY47FBJCuCpkhev4pydU2sbHWCx+kdbE6mmKpZFtnb1feB3NaE
         P293PgLgv1M6vw2Ik/rc0f7Ed7209rI3ZW3YyQUm3KzBOsACaPukRZ78rCU3jE20BX2B
         /UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496993; x=1746101793;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=byLZxcTmkHUnhPkEGnhkt8kzHy94FpcWiEA8cXwsuq0=;
        b=NmVoKegmiqnBSXZUjGPCCxsB6TRyX/poYNUBVQNhkEnVl6OVFSvQGyDIgA0V1gIGlp
         gTjSRZEMTmq8vsdvXZmq0I7nqLuiKwWwmhoqSG9bmB1fvnXnQg5SAink6yfN5lMmjQ18
         3czUcITPtdi3+lOpqe6NKiH1BURFhX+TLpyI9NaYbeScPhkMzQHqzc4YWvq+Ilclt7GY
         8wOHZU3UXIa1xe106HtUVxONyMt3lUFldcl7mAcuZQAb9PHLe+MlEAWKWisg8GDJXYkR
         lwfIboKVnlE3tGuNhSlOpQ7bc34c4kMr47/2vWPLxOQSpr6iW/hT7K7BqDZmEMTAnDaO
         wWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIb8ko9vjhG9btrU+doBCKzbvO7OYjOPaomxog1pFzICXVePl4mUwgF95DErGrDFCEMGObZqpl/iBx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0Z2y6MtZzestZ/SQ3Ii/EYtQOo71noI0BzCj+K1Eh50N+kcG
	KHrBiZbkqE070Ra/R6hi9zhfvB6cx8erpkAzKsUxJ3BOTft7Pldrk3p9AYE+8vE=
X-Gm-Gg: ASbGncvqj1izrFF5oA0S7k9jo0Gt6zm5BMLqGjdhEiU5s0vQJz4VJM58tEtaebaSLo6
	zvrqNjQ5L+urD1i71uAV7S2V3VwWlPb1z/+crtHmEUpcWxymU8ySQFhSuE1C0bAe+O/t+Fym7R7
	gmX+JLPbzeh8PQssDk4YkgyB/mmq129c647v6gfuJHrIcFXFaRZHeKlBLBKODbyLljZUgayWJbu
	mAKwsN/yDufO8YlzTnGU1lZVXFh7maIkgMceeApy8Pekt0RQFaZx44QmovCD0KBm2mcL2MjeBBa
	avE0F/Lw3pMyZSWO6dwxXDsEUBfvg256IMQMnZIpDORE+NYQ
X-Google-Smtp-Source: AGHT+IERZA3DYVew3V/bn5OiODM5GwUm1JM3y/BJyY+6CSbEdsIoN7nn+jjX5wED4r1h6h8dKZG5oA==
X-Received: by 2002:a05:6000:40da:b0:39c:12ce:697 with SMTP id ffacd0b85a97d-3a06cf5cb78mr706514f8f.7.1745496993026;
        Thu, 24 Apr 2025 05:16:33 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:b30c:ee4d:9e10:6a46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d5326casm1929903f8f.64.2025.04.24.05.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 14:16:32 +0200
Message-Id: <D9EV1K8ZQQJR.20CRTYLQBN9UE@ventanamicro.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and
 save/restore of CSR_SSP on trap entry/exit
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
 <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
 <aAmEnK0vSgZZOORL@debug.ba.rivosinc.com>
In-Reply-To: <aAmEnK0vSgZZOORL@debug.ba.rivosinc.com>

2025-04-23T17:23:56-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Apr 10, 2025 at 01:04:39PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>>2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
>>>
>>>  	REG_L s0, TASK_TI_USER_SP(tp)
>>>  	csrrc s1, CSR_STATUS, t0
>>> +	/*
>>> +	 * If previous mode was U, capture shadow stack pointer and save it a=
way
>>> +	 * Zero CSR_SSP at the same time for sanitization.
>>> +	 */
>>> +	ALTERNATIVE("nop; nop; nop; nop",
>>> +				__stringify(			\
>>> +				andi s2, s1, SR_SPP;	\
>>> +				bnez s2, skip_ssp_save;	\
>>> +				csrrw s2, CSR_SSP, x0;	\
>>> +				REG_S s2, TASK_TI_USER_SSP(tp); \
>>> +				skip_ssp_save:),
>>> +				0,
>>> +				RISCV_ISA_EXT_ZICFISS,
>>> +				CONFIG_RISCV_USER_CFI)
>>
>>(I'd prefer this closer to the user_sp and kernel_sp swap, it's breaking
>> the flow here.  We also already know if we've returned from userspace
>> or not even without SR_SPP, but reusing the information might tangle
>> the logic.)
>
> If CSR_SCRATCH was 0, then we would be coming from kernel else flow goes
> to `.Lsave_context`. If we were coming from kernel mode, then eventually
> flow merges to `.Lsave_context`.
>
> So we will be saving CSR_SSP on all kernel -- > kernel trap handling. Tha=
t
> would be unnecessary. IIRC, this was one of the first review comments in
> early RFC series of these patch series (to not touch CSR_SSP un-necessari=
ly)
>
> We can avoid that by ensuring when we branch by determining if we are com=
ing
> from user to something like `.Lsave_ssp` which eventually merges into
> ".Lsave_context". And if we were coming from kernel then we would branch =
to
> `.Lsave_context` and thus skipping ssp save logic. But # of branches it
> introduces in early exception handling is equivalent to what current patc=
hes
> do. So I don't see any value in doing that.
>
> Let me know if I am missing something.

Right, it's hard to avoid the extra branches.

I think we could modify the entry point (STVEC), so we start at
different paths based on kernel/userspace trap and only jump once to the
common code, like:

  SYM_CODE_START(handle_exception_kernel)
    /* kernel setup magic */
    j handle_exception_common
  SYM_CODE_START(handle_exception_user)
    /* userspace setup magic */
  handle_exception_common:

This is not a suggestion for this series.  I would be perfectly happy
with just a cleaner code.

Would it be possible to hide the ALTERNATIVE ugliness behind a macro and
move it outside the code block that saves pt_regs?

Thanks.

