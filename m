Return-Path: <linux-arch+bounces-10808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1096DA60B86
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 09:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B5B7AC083
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748FB1C8611;
	Fri, 14 Mar 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bgBIEsjy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC41C84D2
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940977; cv=none; b=OwD2rRh+4I++g+L1Pgq80vvNn4RXcy55ZI67WiOfqCLCrmMLoVpw1c7fiLc98e+IGZWFMc1PDnwUeVqPMLWZ+OXgDKZXVWOLlKonIZVMQsAxRCdAS/QSYz/l6nV2P/5iR65nCQaxVryCQBm/wnhLddpFQjCvqOiv/jN2QgDeJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940977; c=relaxed/simple;
	bh=zeAw9lVBUMyfwLEjWIc5KzsievKb3epRlLJGohlAyOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn6XJEJTegyn77xfYAZOj/BzadyU7905/Sc/ct6DBnBNWjO4h1rQX2Q74m9rElbChFk144qPJ3BgZz4rtTDNGb729TDVWTaF3M868p44q4oCSD9SlnxUHFquQPQqbzVT4nehnuzb7ziwN5JJL9d1wmp2ySAdzwbOGwUZ5Bzcu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bgBIEsjy; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d0465a8d34so17086895ab.0
        for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741940974; x=1742545774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5fOLOajSrBR6ZehlHGaviL9PwTdryjms/axPqZeS40=;
        b=bgBIEsjyZ00w5VghdPkwz4KRFENfsmvZvB6m/410YfBDyT9nybsjt+EZx8eJMdlKcV
         ZqzFfi0c1QJGm2ihX+6qRGTMk7wN0hUnhmi5ymK9a2i/S02ZVGegctdpEwws9JJqekaz
         ksPlVDHSubMyU5dWjGUbZizG9PG0zA/C/qm8AmXKnpxgOvf0bqcbV6VINEytVKJidAiV
         O2W8ViZ4kEBq//3Rtf5oTv25H4P+chvfLi8q4l+YWr5MENWp6xSH4sjDy83iPXrbfFOC
         ueZ6SPEmJf1+IbYy1CNJva75HA/Jt/9XcFvadbwjojGDtrnulv7sQDgOfMW5NE5UHCDc
         lpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940974; x=1742545774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5fOLOajSrBR6ZehlHGaviL9PwTdryjms/axPqZeS40=;
        b=k1fhCKajTcoukh3eNevpBaGxYzdBTrtOi5ZFcow6WD4wBwEPemhh0nvgh/2PshbWjD
         q7xebsn0xoNfAGNcUXT37LeDTxVEyoW53QI+O3A2nT1W7lUQ24/h3sH2w5Fug1bV6y2i
         4GYM7DZR35L08KLtvkzb8kAoeDgvZrFuqkzRrKo39P3fYaISYcnoKoAd0hw+QjUMkKhi
         rsBAFEXCQNjStSB+pQMKnfPAwAx84QbUS60t0gJYqtfk/0z2oTWsWqiIApjXI66aeD8f
         okMfpfvqLLmNPGV6+Yv+XuB9TH70gMGaDYz57xoxIURM9T7Otgx1OmfAoVfGCSJcLMUy
         bDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQSAhv3B86yL4RzfPLei6rFSoMz348qYGrNZVE+f8Cjj9oekQHIiQFerdL8YX9YOjHkjkmZuzggxZG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AHxBakb9Ie7B8n8iUPLv75jZX1QeYCpTVo9GUXfN6oRlpjYD
	iS5Z1KC+11F0ke8jqKXNxDSBJ0D0pp8E9fwjRbC+K5YOxdRuMDo6PSp6eMB491ZXHR8qObvzdlM
	dWCtBy9+PAF3Aar/lTGiGSEhODMHOyIxzDUAbEA==
X-Gm-Gg: ASbGncvqv+NGaXCEda/YjqZEVdGXFBtDlxMlpCFar97jS/fFlJZPAfonBk6sJVaM5UI
	VHfZuLroHgz86gCWrh6wgyutolZtZzYiVZsNz4TK/dlHaTD8pXBdJdMRmmvlXNiSel6f7QeXHaP
	JepVER1tFu/vguDItQ5+Qix4i+fqGmZL5ECKG4qw==
X-Google-Smtp-Source: AGHT+IF1IzeFSXc5t6kVVWv8i8rDzaqUJRpsZnVqf/BXWhjXn8Eu2b32nuMauWmsFnxhdPq/tzqKBzKTgmPHDPPhvSg=
X-Received: by 2002:a05:6e02:1fc4:b0:3d4:70ab:f96f with SMTP id
 e9e14a558f8ab-3d483a09d1cmr11887495ab.8.1741940974641; Fri, 14 Mar 2025
 01:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-8-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-8-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:29:24 +0800
X-Gm-Features: AQ5f1JohKPAVxeH34lYpuQcdUL49PMtbCo3vcu197rMCUGQtnZKVNP3QmOtRhiI
Message-ID: <CANXhq0qfX4M_F61fdHb-vQBUtw__1RNWvw7ePJsE8RJBc-6+-w@mail.gmail.com>
Subject: Re: [PATCH v11 08/27] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:42=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
> Underlying arch can have two types of writeable mappings. One that can be
> written using regular store instructions. Another one that can only be
> written using specialized store instructions (like shadow stack stores).
> pte_mkwrite can select write PTE encoding based on VMA range (i.e.
> VM_SHADOW_STACK)
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/pgtable.h |  7 +++++++
>  arch/riscv/mm/pgtable.c          | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index ede43185ffdf..ccd2fa34afb8 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -416,6 +416,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
>
>  /* static inline pte_t pte_mkread(pte_t pte) */
>
> +struct vm_area_struct;
> +pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
> +#define pte_mkwrite pte_mkwrite
> +
>  static inline pte_t pte_mkwrite_novma(pte_t pte)
>  {
>         return __pte(pte_val(pte) | _PAGE_WRITE);
> @@ -749,6 +753,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
>         return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
>  }
>
> +pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
> +#define pmd_mkwrite pmd_mkwrite
> +
>  static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
>  {
>         return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
> diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
> index 4ae67324f992..be5d38546bb3 100644
> --- a/arch/riscv/mm/pgtable.c
> +++ b/arch/riscv/mm/pgtable.c
> @@ -155,3 +155,20 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma=
,
>         return pmd;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
> +{
> +       if (vma->vm_flags & VM_SHADOW_STACK)
> +               return pte_mkwrite_shstk(pte);
> +
> +       return pte_mkwrite_novma(pte);
> +}
> +
> +pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
> +{
> +       if (vma->vm_flags & VM_SHADOW_STACK)
> +               return pmd_mkwrite_shstk(pmd);
> +
> +       return pmd_mkwrite_novma(pmd);
> +}
> +
>
LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

