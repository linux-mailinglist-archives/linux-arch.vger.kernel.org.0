Return-Path: <linux-arch+bounces-27-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E877D7E36CC
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254F21C209F9
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EC42913;
	Tue,  7 Nov 2023 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVEDJbxo"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852C28F7
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 08:38:22 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB5113;
	Tue,  7 Nov 2023 00:38:21 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-542d654d03cso8893319a12.1;
        Tue, 07 Nov 2023 00:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699346300; x=1699951100; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6dvthR2+uXXaKtZhfu19I8uRaF5Ucp/hKjGsFNZse0=;
        b=ZVEDJbxoG1cS+KXLakjHKi1Wvnew4GghZa5ENLiGXYwhNB0917zW3Isid4c5aWvHgt
         JXxZV3jpqfKgU5tKRUYe8MVcTUxjekvuq5N0l0w+8wNeUqCP0SZKFk4lNN+IUeDa28pj
         KUVoREzkMHad7reegxHZcl4nQVhg/Tb2YmF7kYNOdmg6PppDg/VyeZ4hcCG6GeaVnZx2
         LZ8nOc/fXnbxfDK1kxTVnef1XXFyU2nd1CQFhdao0CBvzTVyKpx0K6ErXfh/Js8Jrzq+
         0C44p7phCvskaWM+7VOo9JljK9t4tnxEXiWZ1B+lpF/9YPh6+W2NwnfwZXw+C2QI1SFQ
         Z6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699346300; x=1699951100;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6dvthR2+uXXaKtZhfu19I8uRaF5Ucp/hKjGsFNZse0=;
        b=cBKMdk/ga3x2dKHlulTTpYWAlJgrKYrgBTFBU9MBo5zxNxPReU0qL0Ze8IcN9dgS8p
         YjN3wEujtG8fdeRMliZI7ne6IJ48rEvc4bcaonIq4sm7q0f19BxvABSyT0QqFfV6NGzK
         CrFKN1t4/hEd5oIJaaZIv2TzV6V8vZCFogMR7hwdMwZGWqvb6adiA4gTzOd2WjgmIr7/
         fzE8rMt27omf21hZgiiCcYKo9acTchiz9TgS+d3CiRbS4MsnyW0e9/uMsGCoHxDTq9XB
         WPfMLMP3C+FwiTeZ6LENGTWKK6nS+ccJIET+Dc9XhzB+VD/oJkbrKr30hhYeBSYYi3DT
         GWLQ==
X-Gm-Message-State: AOJu0YyTfM9kDRv9UbJ2htdm6CshGjgfPS9ABRGh4+4tA1w4GoN8yfPS
	9u7YOucfmT20ugna/vFEHGA=
X-Google-Smtp-Source: AGHT+IFAT164A5+0+DDOFocrTagB32BVc9/FCJDm9227j7/4JmRH7adGpr3sTfoKn2svR2FIqdu2QQ==
X-Received: by 2002:a05:6402:28b3:b0:540:118:e8f with SMTP id eg51-20020a05640228b300b0054001180e8fmr25487702edb.24.1699346299233;
        Tue, 07 Nov 2023 00:38:19 -0800 (PST)
Received: from smtpclient.apple ([132.69.236.77])
        by smtp.gmail.com with ESMTPSA id r15-20020aa7cfcf000000b0053e469f6505sm5095738edy.26.2023.11.07.00.38.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Nov 2023 00:38:17 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v6 0/4] riscv: tlb flush improvements
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <mhng-4e3e3fa7-5e25-494c-a3ad-6ef7ec78cf20@palmer-ri-x1c9a>
Date: Tue, 7 Nov 2023 10:38:01 +0200
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Vincent Chen <vincent.chen@sifive.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 linux-arch@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>,
 linux-riscv@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Lad Prabhakar <prabhakar.csengg@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1DBDDD4-9B6A-40EA-993E-FF6CF02A2668@gmail.com>
References: <mhng-4e3e3fa7-5e25-494c-a3ad-6ef7ec78cf20@palmer-ri-x1c9a>
To: Palmer Dabbelt <palmer@dabbelt.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)



> On Nov 7, 2023, at 9:00=E2=80=AFAM, Palmer Dabbelt =
<palmer@dabbelt.com> wrote:
>=20
> On Mon, 30 Oct 2023 07:01:48 PDT (-0700), nadav.amit@gmail.com wrote:
>>=20
>>> On Oct 30, 2023, at 3:30 PM, Alexandre Ghiti =
<alexghiti@rivosinc.com> wrote:
>>> + on_each_cpu_mask(cmask,
>>> + __ipi_flush_tlb_range_asid,
>>> + &ftd, 1);
>>=20
>> Unrelated, but having fed
>=20
> Do you mean `ftd`?
>=20
> If so I'm not all that convinced that's a problem: sure it's 4x`long`, =
so we pass it on the stack instead of registers, but otherwise we'd need =
another `on_each_cpu_mask()` callback to shim stuff through via =
registers.

I have no idea why you need to move stuff through the registers.

>> Actually, it is best not to put it on the stack, if possible to =
reduce
>> cache traffic.
>=20
> Sorry if I'm just missing something, but I'm not convinced this is a =
measurable performance problem.

I am not going to try to convince you (I ran the numbers on x86 a long
time ago).

There is a cost of bouncing cache-lines (because multiple cores access
the stack), TLB-miss on remote cores (which is mostly avoidable if ftd
is global).

Having said that, the optimizations you added now and intend to add in
the next steps are definitely more important for performance.


