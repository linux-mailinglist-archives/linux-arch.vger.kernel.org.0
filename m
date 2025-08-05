Return-Path: <linux-arch+bounces-13063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C0B1B008
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 10:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F7017AE57
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEB2459F7;
	Tue,  5 Aug 2025 08:13:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191124502D;
	Tue,  5 Aug 2025 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754381593; cv=none; b=AtyHyoOcrJBdJbfs9gVtraV6zIyw2T2EJN87nkBuAVfHYQvzX0/RRi88ykLK2s8mpmnfyJPdjKKMS7IqxYN+6AUDTvE2hzjsGscx0Hwgp9DQp7XAg2itZxHYxhketsRfixLPxLH06RO8TTsVovK2vSjwzNuNnmfsYWmgktGsm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754381593; c=relaxed/simple;
	bh=XY5X8rTqj6KCB7z+WOowtTK7MrFk016Y1kqMLEFIi1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0h7DJK0xgp290RvVwaOAmVZiHicoP+4EMXQQxkSGYiVtBv+1S78+XK8kuzoeJTPO76IwebepqXdOXlETV9D0HX+GuS/Mq6cGneanRGYeAMT9hWfoTMknx/Dgk6Vegedfz4yVzZvUl3TO370asMz5M2DZfhoawH4H041VsPgJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4fc18de8e1bso1597728137.0;
        Tue, 05 Aug 2025 01:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754381589; x=1754986389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYbREyEF6GDi+6BqzkUaervyY8mSRtfMj7JERduR6Tc=;
        b=obqFiUzJ2OPsKkHd0eqTl3a3iv5hfIiUxuCpyjCe/m0Jm0RbWDoMx8Tvx24TjGGopD
         bh6aT16071W7O0SWwPDOar9xtihYS8bJtfBlrszDuo0aJOBFhjLwq2/HbIUqso40Rh75
         H97pP8R8amKfQr43DSwZWs5LPcnC+9ZgQFP24BjB6XcwV1Zq6CKSS+sKOITjuknnzTja
         7cpO+E2jNYIxK01Qys5+8d300u8dN7EA4o5ylOO/OF8/mbeXopzX7nSvcRws1ouWk4UK
         Ufx7Jbn3yzHpk2PrOP54RV4D1iBYa34EkR2zok/KcI28FTM1IY9+EHvaJwz84FI7H1qc
         IjuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7VXLaRmS9abg7Bp2VG8ACV21ytilyLmvSxoJA1QPkk1rhSWNiDPHKszYrLNuPaAZVp3KdChlMtQxyDg==@vger.kernel.org, AJvYcCUFd8DZl9/8VZ33zhxmpqdBShGS/kznRF7qwx/XG+18AyVDA8UPJV8tKzXHkJvfyOjgKINZsFphTI9QZg==@vger.kernel.org, AJvYcCUrq2ay9MJs0o522tTld/NBRUE5wkWEGYVe38ZR0vVL0U50jAQjF8PuTRc5iUBtydcOWEe9OeEMg0NXQNmL@vger.kernel.org, AJvYcCVhU5tJRl6ifN0WMd5qlx2qM+C+IYPH7zTwh+F05q6fKiqdHq+tiDU4JlIodweE7RSfKrunFkmjhIYfUw==@vger.kernel.org, AJvYcCVlsDVrc3elU6LwNlte/z1r9+75FvCAf7401WmJQ4/t65YzDnRj+s3dTdaregTn+Ip09MEz1BVnfCr5NqAl@vger.kernel.org, AJvYcCWUFzlnMUMFuxWoIssTZ3uoOG2J0cWMFUuuS2SW7p3RThnfPha2LaBJT6mkymMk1LbsGbpPK/G2hNI=@vger.kernel.org, AJvYcCWUM17ywiUSewmsi6e9mWpDjpAtjTTKIhv1U9El1HiEM28iKZWPEVdswVEzPYEO3aq4qVT2Hx8ZTCx+wA==@vger.kernel.org, AJvYcCX/DMi7GixA3rz58ntY9BJyEgDC6Wb+humsIllUOyL1Id3JnYoTxMCjvGW42WkdI4/kz6J724VidcnCPGeIDA==@vger.kernel.org, AJvYcCXRGoxkZVoirASvhObE6uODdKwiFtho6jHLh/jGscZD8pcvoox4xpBTuPA+mNfMq9IBa4FXsArjvJjc+Q==@vger.kernel.org, AJvYcCXZ2zlYcIlo
 2ke1JnWD5puPRnUeZc9GxMTnZ7Tnnuwm4gGpXM1V7BWWSfSZlptf6c6vc7hnA7AlnMHegGd6WvO9@vger.kernel.org, AJvYcCXjBtlSaqBN4rrAnhmuLIPy0Hq4fuv9p4kp72s3WNVlkwPyxZa7NUtCRY6/ohB8AT9e55Pk6w9iH4LBxSpRl30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Uplx/rjI1GwQN3tLF+QP5AaqwiAXKoGUDQixv2wS6Eo9lK+f
	KmPfJDwQqNFdp3EYq88fKEtaZRX8IzLaJtnkx5xNBw15MmxsTqkrj6VUpXTASBWd
X-Gm-Gg: ASbGncvzB1ek0gQb8B52vu9wO0P0ByoequieyX+O5BL0HqnkH96QYKMLZIG/5dWgLpr
	JUlOqWQTBSUztykQP4V11G0WwZ6fGFxZUiZTuwYqcivzRd+z8OxtB8cLjiAwNMykT8DyZ8Eaphk
	1C53YForWLfj3n4zXe0rd6aIgwn7SV78jBrhQEEqUJnap0wRkBhMnsDNx50ARsUfan0CR9bq92p
	F+RaAzHNIuK5UNSZfb+aP74FKkwKfC04AE3LOm1gR6HSin2PgDBjVis1j+54HOJsGOnWBcMgJKq
	UpCj5Tl4mDYL9peaGkzUEFYn+ss21o1kW17cosB/KQYn8V97EJ7utCzO3bVT+CfT/rsT6IvrtaD
	Athc1TCBUyHpg7sqMHoYNbQjWGey3j0lEYRhaTOPLSNLTNhcnmKKC90gRHrWKv+De7oF1uPE=
X-Google-Smtp-Source: AGHT+IFdOe61nFJIUOcSEnlYcSchsWN/94QrRyWLlS24zFBUOfKImNT6AdVPffIk52sInJJy1DiPRg==
X-Received: by 2002:a05:6102:6cc:b0:4e5:9426:f9e6 with SMTP id ada2fe7eead31-4fdc480e1cbmr4690428137.23.1754381588930;
        Tue, 05 Aug 2025 01:13:08 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f3f016dsm2687418241.15.2025.08.05.01.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 01:13:08 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-88bbfe763ecso1192580241.3;
        Tue, 05 Aug 2025 01:13:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3qh6UCKMGE7jnkUHkVkzHp4TN4Wfv2ZGwkNTduyZHYnn4utOUPisL0iK0G8QhknqhZ+6zQ9C1l6SgYg==@vger.kernel.org,
 AJvYcCUL4a4H1opxEDW1HuK6XpL8gNKGsMhuWHDKu71TjooXNzA8UuzcrYDTw2mI/a7OwMjpqkpLIuZaad32XkPC8g==@vger.kernel.org,
 AJvYcCUnQjrQVqx1urB49quzXXxpEgU0cwa4XPBQB38Z5e/OcIwrnSUBfwf/uO3ay/8NxNXYns7BNbR2UGvAD4kaX5s=@vger.kernel.org,
 AJvYcCUx40Oiprm67hf9rZSqss4NPrLnptaoZx/jRQQ3UWhbEhrRl0AzoystuV56RnIxGzS2KRoDisEVvJ8=@vger.kernel.org,
 AJvYcCV9WkuIaaPAdVumcqLOVtZcZUWYtOCr99IOZ2vnggBt3srZHb0lVmtd6MugieQwltYxvIQlVzpcsDNBDg==@vger.kernel.org,
 AJvYcCVQPy0vnqWfFSMztPIJJdDhA3RcWX79I9OrNOB/NFm+U6lXmGfbnwT9aAl0z8oy28UCvKV6LU/J4Swk+Q==@vger.kernel.org,
 AJvYcCWdroWswvftkvg8FTzX+tfXLXSO3Vm0WDM7fVmmzQJHqE5f5AxR4k83hYwnzT5IoWOAP0/25qrcGkfjAUmk@vger.kernel.org,
 AJvYcCWgyPjJLJwMAxIJcq8Hqmnwe+2UliWdvG/gLBEg+W7axJ21fU7r/NxTIbh9PU7F/T6l6vDVk5CT60IRMA==@vger.kernel.org,
 AJvYcCWj9H2OperikDSa80G76TUkt4FxIVqEQ99k+B4ckW012p6G2gxEiBp9gWTizDxUvMcCfo5W3e7V6pNMFjjr@vger.kernel.org,
 AJvYcCXOVbbF3haTd6plu5a/9/jHhttGkwXNF43NMhgnwQaGr5LMXDS7nvWTlyQPyE4kJueRUeUTajoK8QLdpQ==@vger.kernel.org,
 AJvYcCXTAUjwr3JWn203O4e3bPaLB1UAVXFJ+13HzLJt/y8CfLELYC0WjISTK9vYJL4PTDOY2MxNXBdrrQKY3Z5CW326@vger.kernel.org
X-Received: by 2002:a05:6102:3a0b:b0:4d7:11d1:c24e with SMTP id
 ada2fe7eead31-4fdc480dc77mr4806207137.21.1754381587163; Tue, 05 Aug 2025
 01:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804163910.work.929-kees@kernel.org> <20250804164417.1612371-11-kees@kernel.org>
In-Reply-To: <20250804164417.1612371-11-kees@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Aug 2025 10:12:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWRAxGqLxPY0eZkrg4zMr4qY5KUcTqPjNXEKOTeNYGc8A@mail.gmail.com>
X-Gm-Features: Ac12FXxoASDmKZziFEtov1BZOWBk9xds-hH6z1CBqhINtQO4YVRNUk0c1YQzJUM
Message-ID: <CAMuHMdWRAxGqLxPY0eZkrg4zMr4qY5KUcTqPjNXEKOTeNYGc8A@mail.gmail.com>
Subject: Re: [PATCH 11/17] m68k: Add __attribute_const__ to ffs()-family implementations
To: Kees Cook <kees@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 18:44, Kees Cook <kees@kernel.org> wrote:
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
>
> Add missing __attribute_const__ annotations to M68K's implementations
> of ffs(), __ffs(), fls(), __fls(), and ffz() functions. These are
> pure mathematical functions that always return the same result for
> the same input with no side effects, making them eligible for compiler
> optimization.
>
> Build tested ARCH=m68k defconfig with GCC m68k-linux-gnu 14.2.0.
>
> Link: https://github.com/KSPP/linux/issues/364 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

# ffs: pass:9 fail:0 skip:0 total:9

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

