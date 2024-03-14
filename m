Return-Path: <linux-arch+bounces-2995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F57987BDD1
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 14:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F4B20F1F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 13:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3F75BAFC;
	Thu, 14 Mar 2024 13:37:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC6A4691;
	Thu, 14 Mar 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423429; cv=none; b=K5lQNPg2Mm9aRrqlPzJJ3GPmqOxFeOpSpnkd/C/+mC6O82qY+9uJRM8UkJSK9oMc4jlTaKbZm8Eqj/pyhtrnceN4rwAVuXiXu5c217yuAWc1mZ3x64P/QpAxxS7Ome0eZd3xh1K7TDvVdAlb69dMhaW504T3gVUXjhwHkWitPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423429; c=relaxed/simple;
	bh=Or0S+WGOwSC7Ncr7HBViZVdDj7Z438Sy1P38x9okT/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbT9qmaVXQokfULjrlaeqp+DSIZha9VX6+3QEJr+MjPevSpIZvbNFWT7CYJ+UH2m3nkRfSNI25l5HeoKWBNA56QR5CkypK1o+VKtmbqAZi78nsXTGphpxnX3WlfjGbGKFJJ2H6TOlFvhoiFMWv48MR0bg3CrOdQImBBY5jHRQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60cbcd04de8so7768937b3.0;
        Thu, 14 Mar 2024 06:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710423426; x=1711028226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDiARA/24cHYG8FRrouoTvUxwp5WbH/hNpGJ/9ezCCU=;
        b=s5JPDoZeDGE/oGf4oYHWBqKGgczx8RjbET7PsqqVtjXwo0vfz0ufbDy6yp7Ehf+23b
         T/ERoUCgoQzRhuwWRMGFSW/zgOq5ofSA0ikZyasRnERlG3RKO+FQDx/c4nqrLfiNBfud
         Cs4SoT7xJpnzTzwNTELWh8/64X/jzbXYzYPHUqcw9iTTSe82JIUu7GVDiULbBQ0UWHWt
         q51Ay2zjkvagRLKlTryz3BzG8bk0zCPKfZGw2qbEg/P20okk1S5hmHragNUrb8NSppPR
         PrOGhbT5bmwHg3iy1pV6slnrfF5htbWW9K0EcNxheQud+0KabVHmrtsXTqlgKUGY/2vb
         RXBg==
X-Forwarded-Encrypted: i=1; AJvYcCVNh6DgcTTxhwkthKfAOSeu46OAeOlhlexg4rfOMAVW7j0Kmie2JQvsQwmrm5qtmV0zLEt/VGFhSsGobfIDnjDzNV7y+SLe23K60bZKAiO0CanP6EJ4Dacooob9WhgOtCAEKPnTCu46JwKs7VANWSDJC1ZwnSQTfmWcWy7Wx3xJBjOEunF7R6RiOz5akQVTo5ZjrL6CqSW0F9iu6OYNhaU7i/8xt+Zq6eZVkaZLJclfvA6npr7+taO6Ldtuvz3fnYkeaWdTiW3QraerJinW1SCS1Rdzs6PGGA==
X-Gm-Message-State: AOJu0YwwXzwZA32OVxZHf4BBJ5QyQHBprtt8uEMJTBqLqsIRH7jlY9OI
	YhAFUI3PSWQn4kSzAJMbkTgcnjlgdcH8ivED/9yhN4VePuPrS1GNic9gBoxCkd0=
X-Google-Smtp-Source: AGHT+IHpbRdqhvkeW3yEZiafjfhXDt8oLhV8fyLnuqyM3qDFXm4ih/lEQNaxgFvSfyhIP3k4ZgIwYw==
X-Received: by 2002:a0d:f7c2:0:b0:60c:d640:33b3 with SMTP id h185-20020a0df7c2000000b0060cd64033b3mr124473ywf.13.1710423425769;
        Thu, 14 Mar 2024 06:37:05 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id l64-20020a815743000000b006040d34e58csm276913ywb.74.2024.03.14.06.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:37:04 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60a0a54869bso8984367b3.1;
        Thu, 14 Mar 2024 06:37:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzbzvJtnG/So4NbXl0uO6e1Sah/zc6LKF/hm2221JU8Xh1+RdPa+w3oLqPpQQhg1zqvE51N0N1gBd9yqWhTi2Hdplo8R49KvlfSygsv0SLdc5xg0SZm6Y9gKfE4kkPBJ7hB2KV3nsnhLLeE3ArpnrwGENL++tu32X7+C/YbXn3A1nIc/0CZBq9mdlpLK2t2/MyCgortevYHCSt+ENGfkH/sO0Kt9Jl6MhqzkC5pJsb+2uRc7eAiY6GBd7Hgs+rHsheJmJW5YEpdUoxyw3547G9pHaVs6wK1g==
X-Received: by 2002:a0d:fe04:0:b0:60a:4930:5bb1 with SMTP id
 o4-20020a0dfe04000000b0060a49305bb1mr1000757ywf.5.1710423424398; Thu, 14 Mar
 2024 06:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312170309.2546362-1-linux@roeck-us.net>
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 14:36:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkvagJVEfnhq=Nx2jnmdS0Ax+zy1CvyN0k7k1EwUpu+g@mail.gmail.com>
Message-ID: <CAMuHMdUkvagJVEfnhq=Nx2jnmdS0Ax+zy1CvyN0k7k1EwUpu+g@mail.gmail.com>
Subject: Re: [PATCH 00/14] Add support for suppressing warning backtraces
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

On Tue, Mar 12, 2024 at 6:03=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
>
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons.
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad-hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
>
> One option to address problem would be to add messages such as "expected
> warning backtraces start / end here" to the kernel log.  However, that
> would again require filter scripts, it might result in missing real
> problematic warning backtraces triggered while the test is running, and
> the irrelevant backtrace(s) would still clog the kernel log.
>
> Solve the problem by providing a means to identify and suppress specific
> warning backtraces while executing test code. Support suppressing multipl=
e
> backtraces while at the same time limiting changes to generic code to the
> absolute minimum. Architecture specific changes are kept at minimum by
> retaining function names only if both CONFIG_DEBUG_BUGVERBOSE and
> CONFIG_KUNIT are enabled.
>
> The first patch of the series introduces the necessary infrastructure.
> The second patch introduces support for counting suppressed backtraces.
> This capability is used in patch three to implement unit tests.
> Patch four documents the new API.
> The next two patches add support for suppressing backtraces in drm_rect
> and dev_addr_lists unit tests. These patches are intended to serve as
> examples for the use of the functionality introduced with this series.
> The remaining patches implement the necessary changes for all
> architectures with GENERIC_BUG support.

Thanks for your series!

I gave it a try on m68k, just running backtrace-suppression-test,
and that seems to work fine.

> Design note:
>   Function pointers are only added to the __bug_table section if both
>   CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE are enabled to avoid image
>   size increases if CONFIG_KUNIT=3Dn. There would be some benefits to
>   adding those pointers all the time (reduced complexity, ability to
>   display function names in BUG/WARNING messages). That change, if
>   desired, can be made later.

Unfortunately this also increases kernel size in the CONFIG_KUNIT=3Dm
case (ca. 80 KiB for atari_defconfig), making it less attractive to have
kunit and all tests enabled as modules in my standard kernel.

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

