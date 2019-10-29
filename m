Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89567E831F
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 09:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfJ2IVS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 04:21:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39016 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfJ2IVS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 04:21:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so12556985wra.6
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbGqWabkO+qsmDE6Dovu8KQsQ8ImSSqPf6QwQRVth5s=;
        b=i6xKbxwS8JScMMcfWs747aiWLNwFekNIEHU/F7et809rV0fTf2Z1etP2smdRIclPMa
         lhDElPf8v5ti/cVsD+at74gPj+57ePpHY3fNLUN0gidqm1w/D5T8/11fD7aJaNSIRMGI
         oVZhfCiO0XfG6E8Ht8f7ScI6dapi7d+rOzFagYFrDCEcdijn99gGrGp8bZGVf1UL0JUB
         TqBWqpQkCwC1zPXC6yj50TRQeTxTLqGspPZJeaI8A7ZkyROqnqwLoKnAVEIHL2stqE3B
         o6xh9qilu4XKU/bF8Fj7I36FoMpYauUPR8LgHu7wjhJoe4VGr7qwDm/0wrvw5VhuFFmR
         K/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbGqWabkO+qsmDE6Dovu8KQsQ8ImSSqPf6QwQRVth5s=;
        b=cbpW/+WRGRfQFYBUwMXP33tGTCnc7tU2fX7KkEe5OuKzESXWd4uI62lslJANPmc61I
         VBzHtgiiFfapOXQXYtccHpPZBSFMzLikD9RzsVlk0DkC6XdMeWVnutmFY0TlZHwkP3eD
         7QlUXWp78chZ59Id/xvUvA3J0bxcX+bROxI4iMuEz+6Lwsz0sWgB7Rqq4t3stp3lDH3e
         qz+Hug/9yKFuv/LRniT49S7mEK57RizIbNyk1zGBhiasa8xoAxuex/VnbyEiyS0If6IH
         d473JLnp0bA8gYqdfKwH3u9mjedKxXTc94o8bxP8NcKd6eMwvxYZI6NpcNFeytuMjW3s
         aXUg==
X-Gm-Message-State: APjAAAWgiZ7DT9pgLLS2YFzoU8uWMGOU/vUHMMJpnoz2JmlcU6MI2p79
        JRjBifKveM8aC1r0sVvzNW3mlkPzjc1iYzwQK1f0U+aljEOhHw==
X-Google-Smtp-Source: APXvYqxq7fhyaYGafFtbCO5SV4r6hSp9ssGtNlWV8f9IBcuiRL8birbPQx/oxQqtKKJJITJiIZPwCyiQWkaM9VdkHCE=
X-Received: by 2002:adf:fd88:: with SMTP id d8mr12239490wrr.200.1572337275488;
 Tue, 29 Oct 2019 01:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191028210559.8289-1-rth@twiddle.net> <20191028210559.8289-2-rth@twiddle.net>
In-Reply-To: <20191028210559.8289-2-rth@twiddle.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 29 Oct 2019 09:21:03 +0100
Message-ID: <CAKv+Gu9iW341X8FLBedO1Lhr0H-XcA7jDp3bh3nQh7f7N_M0eA@mail.gmail.com>
Subject: Re: [PATCH 1/6] random: Mark CONFIG_ARCH_RANDOM functions __must_check
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Oct 2019 at 22:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We cannot use the pointer output without validating the
> success of the random read.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-arch@vger.kernel.org
> ---
>  include/linux/random.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/random.h b/include/linux/random.h
> index f189c927fdea..84947b489649 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -167,11 +167,11 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
>  #ifdef CONFIG_ARCH_RANDOM
>  # include <asm/archrandom.h>
>  #else
> -static inline bool arch_get_random_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_long(unsigned long *v)
>  {
>         return 0;

For symmetry with the other cleanups, you should probably change these
into 'return false' as well

>  }
> -static inline bool arch_get_random_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
>  {
>         return 0;
>  }
> @@ -179,11 +179,11 @@ static inline bool arch_has_random(void)
>  {
>         return 0;
>  }
> -static inline bool arch_get_random_seed_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  {
>         return 0;
>  }
> -static inline bool arch_get_random_seed_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  {
>         return 0;
>  }
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
