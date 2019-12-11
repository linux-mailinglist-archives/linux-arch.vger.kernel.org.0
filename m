Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1411BD09
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 20:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfLKTbr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 14:31:47 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:56131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 14:31:47 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MTAW9-1iIGzt0Vvb-00UYVV for <linux-arch@vger.kernel.org>; Wed, 11 Dec
 2019 20:31:46 +0100
Received: by mail-qv1-f44.google.com with SMTP id t7so6248632qve.4
        for <linux-arch@vger.kernel.org>; Wed, 11 Dec 2019 11:31:45 -0800 (PST)
X-Gm-Message-State: APjAAAVoi5Vti7gAgb9djrWhXUMwcQbavilLUbffdI+dUXSWrdduVHc1
        QMhnKjRJJmeSpEjzsoAy/f5QglN0srrzne60WfI=
X-Google-Smtp-Source: APXvYqxf4Xp3FM5HTNk2/2drmImAUw5dWnmacIZ0J+E8kqRJYuJMCsxwFdxNI6gooeiVMm0eDFBLHuuFTWJB+qkX2Ec=
X-Received: by 2002:a0c:893d:: with SMTP id 58mr4762571qvp.4.1576092704997;
 Wed, 11 Dec 2019 11:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com> <20191211184027.20130-13-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-13-catalin.marinas@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Dec 2019 20:31:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
Message-ID: <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
Subject: Re: [PATCH 12/22] arm64: mte: Add specific SIGSEGV codes
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gyzzMinpsdtlS/aJdZyhd3g0RErxntsPnrmZDKuHw0IWWV2AGvQ
 Vz2aeslv/ULPiyjojbLMouo/lWEeJ0VU37doyJN7sd3YvRPtPcwnaThTan//Bl4a+n+5j0R
 WhfQfp1ldUzsNz0qd9WFbuAFmX+NQkWLKA0denWh53dml1dX3YnyxCF5IXLiaxfZFLemvhI
 UnJcQBQk49AQFgiPIFbmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GFWCRoYul/s=:1OERkpQlmWlG0D6uDbU1VM
 7Ux35gApNmvs+k/NiYw25FnbNJyg2jBjux9mfUCakLKLtRhp9EYYKalEUQaByzNwS6XXw7zom
 ts89oM3/PHFgbYXS9xkPo0/DhmrR2Quoz2My4hNmk5YySHG9gJsxwTskbCgW3/ZQhjFVCe2BR
 35cY+/2srdWTeud1KYwfCauS0PbX/+U6P/gE7hkxUXTa1iOsJIPNuSQGn8yDYFC5eclOOi5n5
 8WQDXQOPUEvWPI2dxIzWcr+7t0PB5l5UCe9lSQKmOFj/2BMx5s0kRKAK+bJjk8/XR3n2Z6WYD
 dKiyTabvsNiU1p0cokrAes20ryiglT5QARHrYRHU4FVpMlzK/mhsrckxrZ2JF/yuYvbduvuvU
 yWC/tnS2pLtLnGNyj1+bCPSEfRihk+Mb9Mz9o5sK0mBf21DOV1GWysXG4KWUjPPlE3Hdrvkx8
 CCCqTFSbr8Ptx+ttDqPqj9CoTULPOaId1qQeh0VntC4xSOZYuPiTL6/qBedVn6zv2fp3kukvY
 U5CyMhbbY2xP1rxzHz+z7pF4d/JVbMeCU3tYlZbrmnaT98Fz5AufWGwbne0Ojr0ljcr2j9I/D
 hIwLECacGvJWTe3nZYwS1u88cUnnNEg/UFYFSQqS0WSUj4thDEXUe3BPyszj0sKPUfD2q8NFT
 mpagy8DNzGR4RT7HmP31mdNq4nPPXBSf3Fpvz8pLIRBx8VabcL8pYs25XIVfutJkMeiW+nJ8W
 qP0lXhl/7J914scWf8VwmcHrTg7j5xYUDyjVqC3MXaaevWzBEEWPQROzk0PX96lPlCyDgRbVW
 FWXYRX7/5c/FXLe1brpwrjpK0z5/KcTNQMADZ9hsKhrb6QfJ8vvG7r5Xmb5OME6lCStBNYC1E
 Px4ai9ov8PGDKy7drhxw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Add MTE-specific SIGSEGV codes to siginfo.h.
>
> Note that the for MTE we are reusing the same SPARC ADI codes because
> the two functionalities are similar and they cannot coexist on the same
> system.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> [catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  include/uapi/asm-generic/siginfo.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index cb3d6c267181..a5184a5438c6 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -227,8 +227,13 @@ typedef struct siginfo {
>  # define SEGV_PKUERR   4       /* failed protection key checks */
>  #endif
>  #define SEGV_ACCADI    5       /* ADI not enabled for mapped object */
> -#define SEGV_ADIDERR   6       /* Disrupting MCD error */
> -#define SEGV_ADIPERR   7       /* Precise MCD exception */
> +#ifdef __aarch64__
> +# define SEGV_MTEAERR  6       /* Asynchronous MTE error */
> +# define SEGV_MTESERR  7       /* Synchronous MTE exception */
> +#else
> +# define SEGV_ADIDERR  6       /* Disrupting MCD error */
> +# define SEGV_ADIPERR  7       /* Precise MCD exception */
> +#endif

SEGV_ADIPERR/SEGV_ADIDERR were added together with SEGV_ACCADI,
it seems a bit odd to make only two of them conditional but not the others.

I think we are generally working towards having the same constants
across architectures even for features that only exist on one of them.

Adding Al and Eric to Cc, maybe they have another suggestion on what
constants should be used.

     Arnd
