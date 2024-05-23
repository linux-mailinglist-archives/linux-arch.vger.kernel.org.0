Return-Path: <linux-arch+bounces-4497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F888CCF52
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 11:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D8BFB20806
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B2C13C9BD;
	Thu, 23 May 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyMk/sgC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF1446AE;
	Thu, 23 May 2024 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456723; cv=none; b=fuI7Ng5I5T3iRlHYE20eXuC2WVrO84SJUFK2il8OGMjMK69p0D1aIMrO5z/8T/BnyFJon5X9ySE/e/H4e3knB0tHB9byXReXB29V5cVOZmkZ3Y+WUr36YZRZ1hSbqe/hOWeapdTqR2TN8MnU5NM6eQ52K0oCO8mWn6lhosQvm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456723; c=relaxed/simple;
	bh=cX95jCA9O9tZPPJJ58l7jYy+M8WwvnaiJK+eob7aWZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isz0nXBtIxQqRLtB8GCUar5U+Q+3iSiG7QZB5U8cxeb0P9qVPYd673JA8RUOGHBs7gxEWBRnuPNfR/XqICGkAv2oYENawPlvlnCwHcMvkeeQrFLOPyntWTphKVRJkwzNV2fR7MYl5EsH8VrY3otEtpJVFF36dKyX+VO7tzD1J88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyMk/sgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C1AC32789;
	Thu, 23 May 2024 09:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716456722;
	bh=cX95jCA9O9tZPPJJ58l7jYy+M8WwvnaiJK+eob7aWZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MyMk/sgCm4Q27fBluf6XB5lx0hpYaSEIPIpXLanxP5xeatHdBIy2u26ExI5w1HW6Q
	 utLVTkmDRCuAAudcNK3H28LxRpTI1Ri/C7htoqGBahyHoBWr5rjHnrME4rcmK7d7UF
	 4CRf8+YKUqsixfD/3bvUxtiu1VvQsqxIbXygbNkSWO4NkpX4c+QPB1nCeFXiOS0vxC
	 xuUdznkt6Ucbb3MWHR6H2wv0i4RvWux768VtrOJHZgxoWT2J36BdFZyC36M7NKUCdt
	 fEnk+CIq2NDLJmvhBq8V62012iaIp4PMssjvhWreTbZt8Xsf7G2LSVmoK0Y8VkXx74
	 BTx5EpywBkuVA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e724bc466fso57252431fa.3;
        Thu, 23 May 2024 02:32:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfLjblEv+gN2/eBWQjcglhfs7RKhksCbPrFBxmcYTg+bNfnHB04RJEZvvPfZIZE3UWWOwxqAmhq+M92VWGsFdE4vCyKZAhaiwls10/sIu/+q2NNcRbBpCiqsvHe8p/EoLsybX47Pky/kXBHFqk+f8+siAsnPUug4Auw4REmA==
X-Gm-Message-State: AOJu0Yyg1Rt54kZL+dNzlG/LC+8faMQF3J1b79B8hidgqkJBHDKwu37R
	mpqbdXNNGxw8/O+7B0it9d/u4BnsxzFxDyzQ9odlp+NKwIqMNNG/6RLih1Mknjz8cwLF0xam9iR
	wQh5eMbVbiFniklGiCYS9ncQwHzQ=
X-Google-Smtp-Source: AGHT+IHqpQAHZywXcdOOBq3HuHn8WSR7/eN+fpGHKcdJVZzoWrlOpapeJsSx+A82sHWTBHqOUYj9QhP+mCcn3nBDWro=
X-Received: by 2002:a05:651c:216:b0:2e1:f338:d228 with SMTP id
 38308e7fff4ca-2e9494cf3d6mr39701131fa.20.1716456720722; Thu, 23 May 2024
 02:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522114755.318238-1-masahiroy@kernel.org> <20240522114755.318238-3-masahiroy@kernel.org>
In-Reply-To: <20240522114755.318238-3-masahiroy@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 23 May 2024 11:31:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHwEMxAhj=zCBRCAxE8MXhzT95CTtAin+fPQr3DSJ46fA@mail.gmail.com>
Message-ID: <CAMj1kXHwEMxAhj=zCBRCAxE8MXhzT95CTtAin+fPQr3DSJ46fA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: remove PROVIDE() for kallsyms symbols
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 May 2024 at 13:48, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This reimplements commit 951bcae6c5a0 ("kallsyms: Avoid weak references
> for kallsyms symbols").
>
> I am not a big fan of PROVIDE() because it always satisfies the linker
> even in situations that should result in a link error. In other words,
> it can potentially shift a compile-time error into a run-time error.
>

I don't disagree. However, I did realize that, in this particular
case, we could at least make the preliminary symbol definitions
conditional on CONFIG_KALLSYMS rather than always providing them.

This approach is also fine with me, though.


> Duplicating kallsyms_* in vmlinux.lds.h also reduces maintainability.
>
> As an alternative solution, this commit prepends one more kallsyms step.
>
>     KSYMS   .tmp_vmlinux.kallsyms0.S          # added
>     AS      .tmp_vmlinux.kallsyms0.o          # added
>     LD      .tmp_vmlinux.btf
>     BTF     .btf.vmlinux.bin.o
>     LD      .tmp_vmlinux.kallsyms1
>     NM      .tmp_vmlinux.kallsyms1.syms
>     KSYMS   .tmp_vmlinux.kallsyms1.S
>     AS      .tmp_vmlinux.kallsyms1.o
>     LD      .tmp_vmlinux.kallsyms2
>     NM      .tmp_vmlinux.kallsyms2.syms
>     KSYMS   .tmp_vmlinux.kallsyms2.S
>     AS      .tmp_vmlinux.kallsyms2.o
>     LD      vmlinux
>
> Step 0 takes /dev/null as input, and generates .tmp_vmlinux.kallsyms0.o,
> which has a valid kallsyms format with the empty symbol list, and can be
> linked to vmlinux. Since it is really small, the added compile-time cost
> is negligible.
>

OK, so the number of linker invocations is the same, right? The
difference is that the kallsyms symbol references are satisfied by a
dummy object?

That seems reasonable to me.

For the series,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

