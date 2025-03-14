Return-Path: <linux-arch+bounces-10816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD3A60BC3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 09:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41C51891694
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99311DDC37;
	Fri, 14 Mar 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WUschdFu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CC1D86F6
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941222; cv=none; b=YLY3Au9l/v5iRECC1iwHNS2Nxm0fMW/WGom7pmio7Rp7c4hsWIlrMhLp0xWTxoJFmvTQp6FC7L/bZxycTI8B1K2oFH819+/hf4BT67o9p4jc/QjGBp6ASF/ep+UL6s5TzhMhaKeYfm61g+9pSIU3pYkd4kKwMhDJnssyyX+6Kz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941222; c=relaxed/simple;
	bh=GNsFr3kIUBzgxKoerzPqlzGOHhsTXODm7ZdSlMqxcV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzDNFkSYL1f+yobGTv+4YUDddlQ/pkX2+h4E9y/by2xNQm68Tn3VPKMKdfSKju2D+IPVrQ6DSYwhYkqY8ywAygwYkrI6LKsnmuXquXtAzRjqMllfGMcP4KszhuxMsWxdPvvREL8cT0aru160P4d6SsepCjMZuUWxrT2991fLwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WUschdFu; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85afd2b911aso68429639f.2
        for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741941220; x=1742546020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3jAuDyoIpEjI6tmCAFMHNvaGApFy5lgmMv+wfDZUXs=;
        b=WUschdFutx8pHR6dsuEPpXis2xwUAbuNrEXs+ENYYOfFpIpb70BmBG1DrgITh6S1Ml
         EPDJYBht9ympcefeDSBoS0TWyy/vQCOyNLkGevAiFXEA2StVKQjKHFr0mUV1GbX9J7cF
         YHOYLKX8wyOFqKMeXQ+crFqG1pzgqKLthGcJKGRMSJyVhsgvffrPVu5eUk8yw2M6vuwn
         wiYX26WHd+tAFzYmJPw19fobySVPljyLKdlSTPVgqCmLTQ2ygx7HbdUDuOoAGYufA6aj
         ZtSsgn6U9lgoZ2fAG1nZ1GbxaRQYxwBalrwW1dYlkOHt5EdH+CHvpmbJEc1AJS5iem8q
         9fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941220; x=1742546020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3jAuDyoIpEjI6tmCAFMHNvaGApFy5lgmMv+wfDZUXs=;
        b=UjF1IUdoPWgeTRcSJoKi/HZTDgNQfXZ4nl8N/EWMctbm7Iw50q9XjyUJB3oRM1L2Zm
         tITu3v774bDrTbt1LRGojKrZG1WUK336cQMT7mwP3S/9OtslPPeHnF6CXeK5jWcApEqB
         l0XUZ6wOSN3yIG1OKO7rD09nGcXTFjoAMxJd89QH70WqXc866mjUFcrMGue0FWYGzLb7
         1xjwwQe/GMtMOloeIxTrZedBc51VXi+b7WJOsXlVnr+Cu5TYwdkhLGmH37LZSMCfdmnB
         okEzf6VCe/X79K71CbWG+CuMglInmyYpniJJy7tQIaDobyePDss0A5e5oeIeFYEFYGH4
         UU9w==
X-Forwarded-Encrypted: i=1; AJvYcCUiVk6Nq2aCeoc0S+LEEb4zukw5LSVdQjA5+4oFcDssfajhPbBKdtwlBF2RF06GhL6HxEBZaidh7NGj@vger.kernel.org
X-Gm-Message-State: AOJu0YxRclUD6NzzryOuOVX9/CwH4/HQmCJOnTc6By6ACOMdm/Rifdjw
	f034loBpAvr80x2ZDIriHkbMcUuw4D4HmhmTiCi3tKfZn+GR/Z7pIaLCZTyxukxMrhhRlwUi5AS
	CCqiFDmgDnT3vzdWPmsjN1oY5Dk3u40wlDu87tQ==
X-Gm-Gg: ASbGncvRbDKzvyF6drY+Yqp1C1O8tZQNhl3Rm5IFCo0F2iMxW+RHjmzICTqqJToO7Y1
	jCtfm5ABMOIkntOrGF7GoSa2bgS8G2RVJQT2QKQEqqxvAXgxogUjP65e5/Yz3++KqYRUb2Gngsi
	6vam/NsCA0bjj04XwOdglPAqHKqnY=
X-Google-Smtp-Source: AGHT+IH3RGw0jAf3q6yyU3iBbuO4gdAuJlF6nM/gQmt2SaEbu2yJTY3PhHfv/TRxHNt2wY+YZrVn7xw2NK+5svg0PTM=
X-Received: by 2002:a05:6602:3983:b0:85d:b054:6eb9 with SMTP id
 ca18e2360f4ac-85dc48c650bmr200895439f.14.1741941220156; Fri, 14 Mar 2025
 01:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-24-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-24-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:33:28 +0800
X-Gm-Features: AQ5f1Jq9VtRi-a7yZrBf9Dkd8SyU6WoszDfJNK4kl56yJIBZAJsMP2Zbo_BuGRQ
Message-ID: <CANXhq0p3UKhL-+Qo5UouwCV0rWpanM7rcnJjLHXhn9jL-MJLgA@mail.gmail.com>
Subject: Re: [PATCH v11 24/27] riscv: create a config for shadow stack and
 landing pad instr support
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

On Mon, Mar 10, 2025 at 11:44=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> This patch creates a config for shadow stack support and landing pad inst=
r
> support. Shadow stack support and landing instr support can be enabled by
> selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wire=
s
> up path to enumerate CPU support and if cpu support exists, kernel will
> support cpu assisted user mode cfi.
>
> If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
> `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7612c52e9b1e..0a2e50f056e8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -250,6 +250,26 @@ config ARCH_HAS_BROKEN_DWARF5
>         # https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5a=
c9322e22e5471cc5e4a77
>         depends on LD_IS_LLD && LLD_VERSION < 180000
>
> +config RISCV_USER_CFI
> +       def_bool y
> +       bool "riscv userspace control flow integrity"
> +       depends on 64BIT && $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zic=
fiss)
> +       depends on RISCV_ALTERNATIVE
> +       select ARCH_HAS_USER_SHADOW_STACK
> +       select ARCH_USES_HIGH_VMA_FLAGS
> +       select DYNAMIC_SIGFRAME
> +       help
> +         Provides CPU assisted control flow integrity to userspace tasks=
.
> +         Control flow integrity is provided by implementing shadow stack=
 for
> +         backward edge and indirect branch tracking for forward edge in =
program.
> +         Shadow stack protection is a hardware feature that detects func=
tion
> +         return address corruption. This helps mitigate ROP attacks.
> +         Indirect branch tracking enforces that all indirect branches mu=
st land
> +         on a landing pad instruction else CPU will fault. This mitigate=
s against
> +         JOP / COP attacks. Applications must be enabled to use it, and =
old user-
> +         space does not get protection "for free".
> +         default y
> +
>  config ARCH_MMAP_RND_BITS_MIN
>         default 18 if 64BIT
>         default 8
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

