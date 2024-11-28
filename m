Return-Path: <linux-arch+bounces-9179-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEB9DB947
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 15:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FDB20AA1
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A01AA786;
	Thu, 28 Nov 2024 14:10:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692E145A0F;
	Thu, 28 Nov 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803050; cv=none; b=MfIo8drNPQNGdF2E7uf1jIEkDJYnFfPo/UDXgy8+1ImB/3FCPj8lY6QxF/2esvHw60tRgUSzsR7L04B9dyhfG7ZUQW0OXmZWeS5tfYY5QlBN6SbU3THU1PbePeJMj57bz6teLD6SQn+KAs4QN8xXqT5wPA06V3wYfAsT/sOTd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803050; c=relaxed/simple;
	bh=TPkj8f0whqyLQuQTvYnvccsf/vxHrPGNeb4NS+LUtcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhnRn4l5+DbBTIELMVAU95AiyqrAJdvbJdYJvgmyjBHNVWvwrp7kiRbqWIT8ntVFv/xmJtqgZ6DHZAX65gvBuflBhGkKjU4LK6SQtJ0ii0yvyqnYimj+Hn/5zllQIcoGkfTiwvnZtvb53BKg9yDStQ75jwEoY0T2vA9RMY+8nUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d41dbf6cfbso7143806d6.3;
        Thu, 28 Nov 2024 06:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732803046; x=1733407846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcNeZHrwbqkxcgrPCAgiwFwsNQS+3ExgxT8WA27fqnE=;
        b=qFGdxPcgywZyHeyHn7wofjXjrVvN/VdOTx7ig6u+qfDfpBxz9KmkVZX36tGwBeRiNc
         Ua+Nw4QSqrhP0npwLNgz+FvDKGb/cuBS1NpMMk0gRjyO3bmx6Zkem03smvClAMPyUROk
         VA6agrWsBOsob+tcl7epGFzFnJn14CDeyYw+y6gR5RHkRU+OehoMVjtDLAY41qQQSmrG
         BPrykluLfqEAEkBSB9Cu/9mRL+RioA4pJhpaI843rE20WDP8cAVC56YsEq7CBwsbfJ0P
         L8ZaSqO1i6jQ7aEQ4BGlfKZh0ghP08eqd1fi93zbNYnDUXBeAO04yICO8wkXci+Pdx/2
         ZZUg==
X-Forwarded-Encrypted: i=1; AJvYcCUYTgEoSgXVlhXPWL6OGhLKd8r3ZvlM/SMGFa+8AZmmCeh6yjvvkERunmq9r75EodD1Df8LVhMmhHU0IYqG/g==@vger.kernel.org, AJvYcCUfjqx4DmTVaYBVN4WG3FoazpDVl1pRigbWMqCa/bpTL1B/0U5DlPq/mJEoLaIkHjd2yreG9mccl+ClN2UE@vger.kernel.org, AJvYcCWybBIlE4I6kflwtObW73QgxQNb6aOOEJOlM2HcekbXAfMxj/Ne0k+kj1MqPPt9OR7bkrXvQ19b4OdD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vBaWnSgaLLuUnj7aDJZn/6U9hRYj2VSKm0yfpc2GKI7e/P1a
	S7kFCjeSP6JoH0bvvmfG4jmnRhwcT09U2jKDQRofY8HWFPFCwbB91P4wwxdOVVg=
X-Gm-Gg: ASbGncvp9U6DST190vi5+kC5CTrpSfiBckT1n0EQOeDxTgmYFUQsVXq+EgE7sdWQvE1
	i+p5xg6qMjVZkIAdhe8RagFmaEZtJ/XBx4IiYD1qv0VjwWJpMZqcV1DxVy/Yfef7Zwctu24vjmU
	C+NDR92FbDyiuDiAApYhDthHD20V8MhNYYdLevUu5BhBLuvU5ffAdpvhn7Zp0LkUcxYWi0uDKdM
	VqWuRRKM2lnJV8tjaM7tUdlVZBhDf9z/UYO5LmyElSHjMalmvSy9F7r5yoUyUKxurkvVFNX/t7K
	I5BgDt7MZnSYEVZ3
X-Google-Smtp-Source: AGHT+IGvG2w9z0wELJhi1eSPfAZxIEDUfytCfcGHHrZl1keh+xOvpqvYA3ngSf9W5Faki32hbNC3WA==
X-Received: by 2002:a05:6214:2123:b0:6d3:dcce:a2d3 with SMTP id 6a1803df08f44-6d864db33a3mr127644726d6.47.1732803046495;
        Thu, 28 Nov 2024 06:10:46 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8752224d1sm6743966d6.98.2024.11.28.06.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 06:10:46 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4668486df76so8086101cf.3;
        Thu, 28 Nov 2024 06:10:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSuSrEaRSU4ffqDaZKGiN1i90V/z3qhV7HplqVxWQrujxaj+KZX7iokt7187L9KhpY0Hck1r3Nj1FSMsFtgw==@vger.kernel.org, AJvYcCXK/A0RhN5mbxKWqGTh6vj42MMaVovNAYx6kpAm9KYM77ExoCXmU6sk3nCMg4X3fYHZaXBWXPjjBGJhsA6X@vger.kernel.org, AJvYcCXlcroRLRVrTYOatJIkp+DHx019D8XhuK8RASu6fuWCCxAOcPPhQ2VHHeDrMU1OpGqwA65nehC9E4M8@vger.kernel.org
X-Received: by 2002:a05:620a:2902:b0:7ac:c348:6a52 with SMTP id
 af79cd13be357-7b67c30c5cfmr1013596985a.34.1732803045800; Thu, 28 Nov 2024
 06:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021193310.2014131-1-mcgrof@kernel.org>
In-Reply-To: <20241021193310.2014131-1-mcgrof@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Nov 2024 15:10:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVG3Z63BruhrnQtSadCnaKZ+hpwFDJDnitXST8fRNYoLQ@mail.gmail.com>
Message-ID: <CAMuHMdVG3Z63BruhrnQtSadCnaKZ+hpwFDJDnitXST8fRNYoLQ@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: add new kallsyms selftests
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com, 
	masahiroy@kernel.org, deller@gmx.de, linux-arch@vger.kernel.org, 
	live-patching@vger.kernel.org, kris.van.hees@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Mon, Oct 21, 2024 at 9:33=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
> We lack find_symbol() selftests, so add one. This let's us stress test
> improvements easily on find_symbol() or optimizations. It also inherently
> allows us to test the limits of kallsyms on Linux today.
>
> We test a pathalogical use case for kallsyms by introducing modules
> which are automatically written for us with a larger number of symbols.
> We have 4 kallsyms test modules:
>
> A: has KALLSYSMS_NUMSYMS exported symbols
> B: uses one of A's symbols
> C: adds KALLSYMS_SCALE_FACTOR * KALLSYSMS_NUMSYMS exported
> D: adds 2 * the symbols than C
>
> By using anything much larger than KALLSYSMS_NUMSYMS as 10,000 and
> KALLSYMS_SCALE_FACTOR of 8 we segfault today. So we're capped at
> around 160000 symbols somehow today. We can inpsect that issue at
> our leasure later, but for now the real value to this test is that
> this will easily allow us to test improvements on find_symbol().
>
> We want to enable this test on allyesmodconfig builds so we can't
> use this combination, so instead just use a safe value for now and
> be informative on the Kconfig symbol documentation about where our
> thresholds are for testers. We default then to KALLSYSMS_NUMSYMS of
> just 100 and KALLSYMS_SCALE_FACTOR of 8.
>
> On x86_64 we can use perf, for other architectures we just use 'time'
> and allow for customizations. For example a future enhancements could
> be done for parisc to check for unaligned accesses which triggers a
> special special exception handler assembler code inside the kernel.
> The negative impact on performance is so large on parisc that it
> keeps track of its accesses on /proc/cpuinfo as UAH:
>
> IRQ:       CPU0       CPU1
> 3:       1332          0         SuperIO  ttyS0
> 7:    1270013          0         SuperIO  pata_ns87415
> 64:  320023012  320021431             CPU  timer
> 65:   17080507   20624423             CPU  IPI
> UAH:   10948640      58104   Unaligned access handler traps
>
> While at it, this tidies up lib/ test modules to allow us to have
> a new directory for them. The amount of test modules under lib/
> is insane.
>
> This should also hopefully showcase how to start doing basic
> self module writing code, which may be more useful for more complex
> cases later in the future.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks for your patch, which is now commit 84b4a51fce4ccc66
("selftests: add new kallsyms selftests") upstream.

> @@ -2903,6 +2903,111 @@ config TEST_KMOD
>
>           If unsure, say N.
>
> +config TEST_RUNTIME
> +       bool
> +
> +config TEST_RUNTIME_MODULE
> +       bool
> +
> +config TEST_KALLSYMS
> +       tristate "module kallsyms find_symbol() test"
> +       depends on m
> +       select TEST_RUNTIME
> +       select TEST_RUNTIME_MODULE
> +       select TEST_KALLSYMS_A
> +       select TEST_KALLSYMS_B
> +       select TEST_KALLSYMS_C
> +       select TEST_KALLSYMS_D
> +       help
> +         This allows us to stress test find_symbol() through the kallsym=
s
> +         used to place symbols on the kernel ELF kallsyms and modules ka=
llsyms
> +         where we place kernel symbols such as exported symbols.
> +
> +         We have four test modules:
> +
> +         A: has KALLSYSMS_NUMSYMS exported symbols
> +         B: uses one of A's symbols
> +         C: adds KALLSYMS_SCALE_FACTOR * KALLSYSMS_NUMSYMS exported
> +         D: adds 2 * the symbols than C
> +
> +         We stress test find_symbol() through two means:
> +
> +         1) Upon load of B it will trigger simplify_symbols() to look fo=
r the
> +         one symbol it uses from the module A with tons of symbols. This=
 is an
> +         indirect way for us to have B call resolve_symbol_wait() upon m=
odule
> +         load. This will eventually call find_symbol() which will eventu=
ally
> +         try to find the symbols used with find_exported_symbol_in_secti=
on().
> +         find_exported_symbol_in_section() uses bsearch() so a binary se=
arch
> +         for each symbol. Binary search will at worst be O(log(n)) so th=
e
> +         larger TEST_MODULE_KALLSYSMS the worse the search.
> +
> +         2) The selftests should load C first, before B. Upon B's load t=
owards
> +         the end right before we call module B's init routine we get
> +         complete_formation() called on the module. That will first chec=
k
> +         for duplicate symbols with the call to verify_exported_symbols(=
).
> +         That is when we'll force iteration on module C's insane symbol =
list.
> +         Since it has 10 * KALLSYMS_NUMSYMS it means we can first test
> +         just loading B without C. The amount of time it takes to load C=
 Vs
> +         B can give us an idea of the impact growth of the symbol space =
and
> +         give us projection. Module A only uses one symbol from B so to =
allow
> +         this scaling in module C to be proportional, if it used more sy=
mbols
> +         then the first test would be doing more and increasing just the
> +         search space would be slightly different. The last module, modu=
le D
> +         will just increase the search space by twice the number of symb=
ols in
> +         C so to allow for full projects.
> +
> +         tools/testing/selftests/module/find_symbol.sh
> +
> +         The current defaults will incur a build delay of about 7 minute=
s
> +         on an x86_64 with only 8 cores. Enable this only if you want to
> +         stress test find_symbol() with thousands of symbols. At the sam=
e
> +         time this is also useful to test building modules with thousand=
s of
> +         symbols, and if BTF is enabled this also stress tests adding BT=
F
> +         information for each module. Currently enabling many more symbo=
ls
> +         will segfault the build system.

Despite the warning, I gave this a try on m68k (cross-compiled on i7 ;-).
However, I didn't notice any extra-ordinary build times.

Also, when running the test manually on ARAnyM, everything runs
in the blink of an eye.  I didn't use the script, but ran all commands
manually.  I tried insmodding a/b/c/d, c/a/b, a/c/d/b.

Is this expected?
Thanks!

$ wc -l lib/tests/module/test_kallsyms_*.c
   233 lib/tests/module/test_kallsyms_a.c
    22 lib/tests/module/test_kallsyms_a.mod.c
    35 lib/tests/module/test_kallsyms_b.c
    21 lib/tests/module/test_kallsyms_b.mod.c
  1633 lib/tests/module/test_kallsyms_c.c
    21 lib/tests/module/test_kallsyms_c.mod.c
  3233 lib/tests/module/test_kallsyms_d.c
    21 lib/tests/module/test_kallsyms_d.mod.c
  5219 total

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

