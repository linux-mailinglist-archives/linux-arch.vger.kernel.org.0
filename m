Return-Path: <linux-arch+bounces-1209-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9F0820436
	for <lists+linux-arch@lfdr.de>; Sat, 30 Dec 2023 10:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EF9282198
	for <lists+linux-arch@lfdr.de>; Sat, 30 Dec 2023 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DB35239;
	Sat, 30 Dec 2023 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d1w1OrxQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67B522D
	for <linux-arch@vger.kernel.org>; Sat, 30 Dec 2023 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-554e9f51522so4826963a12.2
        for <linux-arch@vger.kernel.org>; Sat, 30 Dec 2023 01:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703930058; x=1704534858; darn=vger.kernel.org;
        h=content-transfer-encoding:to:references:message-id:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abUTt15ozYHOLG/fk60Lc57aa9WtZ24J7IwER8hUXeE=;
        b=d1w1OrxQSL/PEmBYJoZE4VTCpsv6fck5HKO6c46JnAR8GE5mtXbL/rPyuRcjk5KF/2
         v2CDieeJkgZ0VzOjaTSuK6ATFDK2IsqDErlIWH68xZTiT0dcazKphxUHgAzYOD6A12O8
         JcMBABm7/194Lg/YTOLGmJUSJVj9E3zv9rtWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703930058; x=1704534858;
        h=content-transfer-encoding:to:references:message-id:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abUTt15ozYHOLG/fk60Lc57aa9WtZ24J7IwER8hUXeE=;
        b=CJ/fxTsoptifJPbMaRxiByV6QMrAwjmVm2Z5lPjhcjBFF6+0maJRSNi22gSB3ziawo
         sr1obv5tUDAkVwJUv6HXN5pKrHvYKHUch2yJbx8YW3WUYFBvbnVLeVvnLRz/FeOXbEU6
         SC50gKrMjRwEqjfb5D4Azgz8B5voP1VecK4w+5I9jEHfYzMuBrAU9GobIDhcFfpejo3O
         5ry20E0VbahpF6vqtyDSDb6hvY0mdZWTaa9fl71LXpOvs5+2JFYCekt18WaP44eMLJLN
         c1j38tHGY6XSe5gGejOD5NC4Dv7+GQjId1DO4B+P5bTNWBIFwsFPkn8k1dL86ZANLTFz
         sm2Q==
X-Gm-Message-State: AOJu0YwGpyo7+0G3XR61DPhw7WsR0Hf19kIwBB4RxjlFSr6BH1fiqL6z
	3sC4VBkGPFGecEZv+oPVOQe4ELgHmp+RLjtvGkmn0f1tUmepJMJx9lM9PLbmdJq5Y7pCfSI5wKN
	GHEOX4sLIpy5dTQRFmDc=
X-Google-Smtp-Source: AGHT+IGK1uGrlady2TpLBMfqqY9A7tHn9+lcZGtpiYGeIBTdCURXuQcXKU0VKUNz5G0qW4/zkYvz4w==
X-Received: by 2002:a05:6402:ca3:b0:54c:9dbe:5c03 with SMTP id cn3-20020a0564020ca300b0054c9dbe5c03mr5290445edb.40.1703930057752;
        Sat, 30 Dec 2023 01:54:17 -0800 (PST)
Received: from smtpclient.apple ([132.69.236.92])
        by smtp.gmail.com with ESMTPSA id m9-20020aa7c2c9000000b00552666f4745sm12089039edp.22.2023.12.30.01.54.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Dec 2023 01:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 1/2] mm/tlb: fix fullmm semantics
From: Nadav Amit <nadav.amit@broadcom.com>
In-Reply-To: <20231228084642.1765-2-jszhang@kernel.org>
Date: Sat, 30 Dec 2023 11:54:02 +0200
Cc: Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>,
 linux-arm-kernel@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org,
 Nadav Amit <namit@vmware.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Yu Zhao <yuzhao@google.com>,
 the arch/x86 maintainers <x86@kernel.org>
Message-Id: <204B6410-2EFA-462B-9DF7-64CC5F1D3AD2@broadcom.com>
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-2-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



> On Dec 28, 2023, at 10:46=E2=80=AFAM, Jisheng Zhang <jszhang@kernel.org> =
wrote:
>=20
> From: Nadav Amit <namit@vmware.com>
>=20
> fullmm in mmu_gather is supposed to indicate that the mm is torn-down
> (e.g., on process exit) and can therefore allow certain optimizations.
> However, tlb_finish_mmu() sets fullmm, when in fact it want to say that
> the TLB should be fully flushed.
>=20
> Change tlb_finish_mmu() to set need_flush_all and check this flag in
> tlb_flush_mmu_tlbonly() when deciding whether a flush is needed.
>=20
> At the same time, bring the arm64 fullmm on process exit optimization bac=
k.
>=20
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: x86@kernel.org
> ---
> arch/arm64/include/asm/tlb.h | 5 ++++-
> include/asm-generic/tlb.h    | 2 +-
> mm/mmu_gather.c              | 2 +-
> 3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index 846c563689a8..6164c5f3b78f 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -62,7 +62,10 @@ static inline void tlb_flush(struct mmu_gather *tlb)
> 	 * invalidating the walk-cache, since the ASID allocator won't
> 	 * reallocate our ASID without invalidating the entire TLB.
> 	 */
> -	if (tlb->fullmm) {
> +	if (tlb->fullmm)
> +		return;
> +
> +	if (tlb->need_flush_all) {
> 		if (!last_level)
> 			flush_tlb_mm(tlb->mm);
> 		return;
>=20

Thanks for pulling my patch out of the abyss, but the chunk above
did not come from my old patch.

My knowledge of arm64 is a bit limited, but the code does not seem
to match the comment, so if it is correct (which I strongly doubt),
the comment should be updated.

[1] https://lore.kernel.org/all/20210131001132.3368247-2-namit@vmware.com/


--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

