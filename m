Return-Path: <linux-arch+bounces-1282-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E3A8242AE
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 14:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB956287976
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 13:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B530224C9;
	Thu,  4 Jan 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aEis+rWB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F022323
	for <linux-arch@vger.kernel.org>; Thu,  4 Jan 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55539cac143so622485a12.0
        for <linux-arch@vger.kernel.org>; Thu, 04 Jan 2024 05:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704374819; x=1704979619; darn=vger.kernel.org;
        h=content-transfer-encoding:to:references:message-id:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NLOEEKOHl1K8SwVg4x8l8DROTucqom/M/VF0VUr2O4=;
        b=aEis+rWBVmAFnwYH1KnpAEWQOawFoxikwA+gwAxWCYppwkK9b3WsKd0uaDmSAmjd0U
         GX8lSD4NAGWmsvIpLBL2gpCOXJxIzfwgtGdoGzUOgynOq3VHP8eevg89/kKLPW8jaEr9
         rT/fhKVeQk5yPQrp/rHBsacZ1x/0qxmpDYJT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704374819; x=1704979619;
        h=content-transfer-encoding:to:references:message-id:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NLOEEKOHl1K8SwVg4x8l8DROTucqom/M/VF0VUr2O4=;
        b=U2Vd9PJR2TgJYhixQtydANGJa1bf/ZRHivOQIv9g2g7n1w+3fl7kALdUGdRTHdM+kk
         nd5rRY6+WTiwus1olOTfVh+liVR58QASKuYCfm38rVbjuT8TbL2V+etV3O5gl7Wpu/Bq
         th0wNrvG0DSAbo8zC7b2kI4wdEfKCJB5OU8UkG5c6EJSzqmdnkvTeknS13cuNJ7HtOW9
         zB2aXiKEgLbtOXeMFus/1YTaTXoggIPW3lYNoiFY8IcAP9CmDxPutxQLm7auRjstPBgN
         tjQSa8x1TbbWcO+utroHqoe7RrTEX12+6hIxGmxhguA9lrlIDWkwjUSlJyNQUIxDv4OU
         723w==
X-Gm-Message-State: AOJu0YxsyLiWEdmpR3LjoQ7Jxg8x6l/IdAvJQv5K6X6RDKCUoPHh2q7k
	zktttvCJ+tLuifF9xgm0/S/B3lfnAL0ppMKbCkvjm0C4x/FlcaYZd/HhM79/BuZCRI8zH6+GGFJ
	rGnoaXofDbM/3RSDBglo=
X-Google-Smtp-Source: AGHT+IHd/WpwPLyNONTm9ogjAA99SQMYsTaEZ3qlb+1RX3wQIK/T9BGDoHBAKS8TMe2iuAmaxN1MUA==
X-Received: by 2002:a50:c35d:0:b0:557:183b:9028 with SMTP id q29-20020a50c35d000000b00557183b9028mr8478edb.65.1704374819165;
        Thu, 04 Jan 2024 05:26:59 -0800 (PST)
Received: from smtpclient.apple ([132.69.236.92])
        by smtp.gmail.com with ESMTPSA id ef7-20020a05640228c700b00556cf2545desm2249504edb.16.2024.01.04.05.26.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 05:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 1/2] mm/tlb: fix fullmm semantics
From: Nadav Amit <nadav.amit@broadcom.com>
In-Reply-To: <ZZN35DTJTNExCNXW@xhacker>
Date: Thu, 4 Jan 2024 15:26:43 +0200
Cc: Will Deacon <will@kernel.org>,
 Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
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
Message-Id: <0468E994-273E-4A8B-A521-150723DA9774@broadcom.com>
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-2-jszhang@kernel.org>
 <204B6410-2EFA-462B-9DF7-64CC5F1D3AD2@broadcom.com>
 <ZZN35DTJTNExCNXW@xhacker>
To: Jisheng Zhang <jszhang@kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



> On Jan 2, 2024, at 4:41=E2=80=AFAM, Jisheng Zhang <jszhang@kernel.org> wr=
ote:
>=20
> On Sat, Dec 30, 2023 at 11:54:02AM +0200, Nadav Amit wrote:
>=20
>>=20
>> My knowledge of arm64 is a bit limited, but the code does not seem
>> to match the comment, so if it is correct (which I strongly doubt),
>> the comment should be updated.
>=20
> will do if the above change is accepted by arm64

Jisheng, I expected somebody with arm64 knowledge to point it out, and
maybe I am wrong, but I really don=E2=80=99t understand something about the
correctness, if you can please explain.

In the following code:

--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -62,7 +62,10 @@ static inline void tlb_flush(struct mmu_gather *tlb)
	 * invalidating the walk-cache, since the ASID allocator won't
	 * reallocate our ASID without invalidating the entire TLB.
	 */
-	if (tlb->fullmm) {
+	if (tlb->fullmm)
+		return;

You skip flush if fullmm is on. But if page-tables are freed, you may
want to flush immediately and not wait for ASID to be freed to avoid
speculative page walks; these walks at least on x86 caused a mess.

No?


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

