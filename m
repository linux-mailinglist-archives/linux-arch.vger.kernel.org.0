Return-Path: <linux-arch+bounces-2990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6E87B8FE
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 08:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B72284DA3
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C515CDF0;
	Thu, 14 Mar 2024 07:58:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620B5CDD0;
	Thu, 14 Mar 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403080; cv=none; b=UM9nFDWnkkZ5FwXTkxsLnVCFWd+hQ6knS4j5zNm+e9ZUZzD56Ob53e4F3emFVM5PCtIEDmhb9uOs9e7hBu04qjsU7VOFRwo+22kD0q6i5pHWNLI55v+QYkqoF1mzdT7X8uYVsbh8WhVoo8GWKSugh54/Uox4ALKC1tjws6BBZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403080; c=relaxed/simple;
	bh=GdqPCgNgGmabZKEFpqVELT68B4Ci/C3EGXs0bq1Jxn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BR8fLGSuZssgWH/23WXU0GWHn1P6ZbVe5x+x99/L7qSKLbcC+hB/7xKiySql/xqzjVEwoOBSksp6Lwh3fCDR0rixEcvPeM0XGIFIPEy7vohRJ/x/2mCRwpbqK6kEjN4vr6I1Tko6huhMWAggai3Zbox4StgN/vspkshCgRrjR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60cbcd04de9so7169477b3.2;
        Thu, 14 Mar 2024 00:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710403077; x=1711007877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kd7vHFr5fszcwgfp701zhW6bd0WPIDQKlsKOb1KQCg=;
        b=lMe1DXW0WrWCpubE+3C5xY2IzSQ5NIFMB7yJcy59XNxNtiDWhS0IWkIi6OA4wlyEmo
         OTAU5X8PnJV0CvNID0DZRildiKvxEtlA2bswMzMeD41ITtgS8VYVOumGb1FW8khYCY5H
         CD3EnTR32pSlPBREkANXiLGilv+J9HREZ0EqDcaRORGgfMDfIofVBT9A0BYMjKAT+ISM
         pe7fqRjPnhx0nXJE7oO1a4W4Ftk3ydAHG+NCB6jELOykInahVpfJ7vSpfaPKRCbtJIGv
         Rkeqk8MwJdAeeNnSEDkuoDU03UCHqdVGtTWVRxLItH682hKUm4/TUdGGlApLp06e4bKK
         dcVw==
X-Forwarded-Encrypted: i=1; AJvYcCUyBq0dQZjHir8vdPngXIiQvW1JHCxsS06B4J19EXPL/2dKM/XP4R2MiFK4808Iz+t1APlMaiHfH3w6MUhUvmPpsqcW2zMGG2KH/wnGVgkChpZb/2iVwSsCfBPM8DOhNEMcRLW9Zo1LDgfRcTq2h3YhnEDUsbQwUoZTyWZQ3g+JgYWdYY5JZMQL/mKNOAiTaLZhbnvvVBVtxir4+XD90ufpDgKMHajHdsdLDXY/p1dlYkFvVJbtJ24kzqtDZ3KAglQqMZjOX9yLC8V6KNo2Ay5nlveOm2LgnQ==
X-Gm-Message-State: AOJu0YxMtpFprSlsV82qvRMyPBygDyBXNtrI15NkZjNTYOYwqZimq0Bz
	5Zh/h6IEj6NW3Jq7bP4E4CFCLkaH3liwo/J5iQQX/3eLbIXW+mVpq1QsJOgVQF0=
X-Google-Smtp-Source: AGHT+IEZFYhzEtoQw3tAL/5lmIa7kFpXxibw5TyrBGKAQ/5uRwdUFocJWz6+3q1/7sg0ctuSNtoK7g==
X-Received: by 2002:a81:6fc5:0:b0:608:2b27:9e6d with SMTP id k188-20020a816fc5000000b006082b279e6dmr938672ywc.28.1710403077438;
        Thu, 14 Mar 2024 00:57:57 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id m85-20020a0dca58000000b00607ad76d855sm175127ywd.67.2024.03.14.00.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 00:57:57 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a15449303so8187117b3.0;
        Thu, 14 Mar 2024 00:57:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhnKJQSoKtCulOFOpM2dzulvMxAbkZTvxcVLriv6WivpmxhG87fYEFsewjpRhaPDI28/z65+qxHDXVXJWwMwsk8c1OSvY4MFgxPYtZJTnPQgo5ZUEBXHZlwV6vWlh01qQYKnVYWpETC2XCfiu0hUB2/aLJ4tZtc0agGynKH0+fCCB9y/WXywXojV2/mJuBZfd6qdJ04mCaKcpXlRKoVKYtl2qn/eo0jGutHXW1p4s6RC3SPtc/4i730Rc8RdBFCzUJccb99ul55gE2PfMbj4406QSUA6YAIg==
X-Received: by 2002:a0d:ea4c:0:b0:609:239a:d0fc with SMTP id
 t73-20020a0dea4c000000b00609239ad0fcmr990474ywe.38.1710403077141; Thu, 14 Mar
 2024 00:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312170309.2546362-1-linux@roeck-us.net> <20240312170309.2546362-12-linux@roeck-us.net>
In-Reply-To: <20240312170309.2546362-12-linux@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 08:57:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXHKfd8agPGx+MjvC4cjW5F6DEeVec3Moe-=LLkrT3CXQ@mail.gmail.com>
Message-ID: <CAMuHMdXHKfd8agPGx+MjvC4cjW5F6DEeVec3Moe-=LLkrT3CXQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] s390: Add support for suppressing warning backtraces
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, 
	Arthur Grillo <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, netdev@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

On Tue, Mar 12, 2024 at 6:06=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> Add name of functions triggering warning backtraces to the __bug_table
> object section to enable support for suppressing WARNING backtraces.
>
> To limit image size impact, the pointer to the function name is only adde=
d
> to the __bug_table section if both CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBO=
SE
> are enabled. Otherwise, the __func__ assembly parameter is replaced with =
a
> (dummy) NULL parameter to avoid an image size increase due to unused
> __func__ entries (this is necessary because __func__ is not a define but =
a
> virtual variable).
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks for your patch!

> --- a/arch/s390/include/asm/bug.h
> +++ b/arch/s390/include/asm/bug.h
> @@ -8,19 +8,30 @@
>
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +# define HAVE_BUG_FUNCTION
> +# define __BUG_FUNC_PTR        "       .long   %0-.\n"
> +# define __BUG_FUNC    __func__
> +#else
> +# define __BUG_FUNC_PTR
> +# define __BUG_FUNC    NULL
> +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> +
>  #define __EMIT_BUG(x) do {                                     \
>         asm_inline volatile(                                    \
>                 "0:     mc      0,0\n"                          \
>                 ".section .rodata.str,\"aMS\",@progbits,1\n"    \
>                 "1:     .asciz  \""__FILE__"\"\n"               \
>                 ".previous\n"                                   \
> -               ".section __bug_table,\"awM\",@progbits,%2\n"   \
> +               ".section __bug_table,\"awM\",@progbits,%3\n"   \

This change conflicts with commit 3938490e78f443fb ("s390/bug:
remove entry size from __bug_table section") in linus/master.
I guess it should just be dropped?

>                 "2:     .long   0b-.\n"                         \
>                 "       .long   1b-.\n"                         \
> -               "       .short  %0,%1\n"                        \
> -               "       .org    2b+%2\n"                        \
> +               __BUG_FUNC_PTR                                  \
> +               "       .short  %1,%2\n"                        \
> +               "       .org    2b+%3\n"                        \
>                 ".previous\n"                                   \
> -               : : "i" (__LINE__),                             \
> +               : : "i" (__BUG_FUNC),                           \
> +                   "i" (__LINE__),                             \
>                     "i" (x),                                    \
>                     "i" (sizeof(struct bug_entry)));            \
>  } while (0)

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

