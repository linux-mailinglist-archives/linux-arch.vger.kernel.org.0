Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CF830A02
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 10:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfEaIQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 04:16:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40675 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIQt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:16:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id c70so5673745qkg.7;
        Fri, 31 May 2019 01:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30RVgFLbkHlG89EQk6x8p2INAuD+G0BGcR1Z9jL2rCQ=;
        b=hlSO5RJqIRpe1PZ7TpsmMQo44ovugU1khiJZzOhJJaLKDuWfCwGbJ85DVqTKJvE0Gy
         sLg/RT/wxWni08tLKY6EbIL4nLZGgoIt4Y+Ymv4FBYFJRtXw90vZxo91yaSs7gqyk+lT
         fY00OXuIPojXT4axXV4Ok6QbjWwDM3+z4bzQ0t1qG49kEM6jW0otSE+LN6HG0puanyCu
         dmoskc6YtZrVhVfqRhVVtlGh2L9ieXPudQxe5sI/2bBDk2/jQaYAqohNJIZsBo0Zn13N
         vd69a7dHLZplmMoblzrtfHbe5dnT4+6feWRXqVeO2pJQfECYihdPNo8lS1KRtMSA3rlN
         LSbw==
X-Gm-Message-State: APjAAAW3owH4bZGfsEtkBaE1u6gjAzMGFLPzhCW/J1UMcsUnAx5h93nj
        H3pLiMkGLKXHN03u2cFOFEEPdQQZCLR0UKsIgwU=
X-Google-Smtp-Source: APXvYqygpXWKDUKmI3iwxPslA26zY8qzu12QphPXeLnYQv/mQEzWW3Ndpgpw/HREzaYL1eIfi/Csyx1vKJTBNYEnwFg=
X-Received: by 2002:a05:620a:1085:: with SMTP id g5mr7427087qkk.182.1559290608936;
 Fri, 31 May 2019 01:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-2-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-2-vincenzo.frascino@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 10:16:32 +0200
Message-ID: <CAK8P3a3EnvkLND2RJdZtEY64PhK5g0sbbuytQro=f0cPur2g9g@mail.gmail.com>
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> + * vdso_data will be accessed by 64 bit and compat code at the same time
> + * so we should be careful before modifying this structure.
> + */
> +struct vdso_data {
> +       u32                     seq;
> +
> +       s32                     clock_mode;
> +       u64                     cycle_last;
> +       u64                     mask;
> +       u32                     mult;
> +       u32                     shift;
> +
> +       struct vdso_timestamp   basetime[VDSO_BASES];
> +
> +       s32                     tz_minuteswest;
> +       s32                     tz_dsttime;
> +       u32                     hrtimer_res;
> +};

The structure contains four padding bytes at the end, which is
something we try to avoid, at least if this ends up being used as
an ABI. Maybe add "u32 __unused" at the end?

     Arnd
