Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9224DD890
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 11:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiCRK72 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 06:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiCRK7Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 06:59:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00809B1F;
        Fri, 18 Mar 2022 03:58:01 -0700 (PDT)
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mow06-1nswK946us-00qVSx; Fri, 18 Mar 2022 11:58:00 +0100
Received: by mail-wr1-f50.google.com with SMTP id x15so11180933wru.13;
        Fri, 18 Mar 2022 03:57:59 -0700 (PDT)
X-Gm-Message-State: AOAM530nLpnRw2lh8d/XGlJxSUVMv738a8Eef1fXYP1aJ8QUgkzCHN0S
        Jp8oUXVwRj6oG0FTEAzA/Ovd6hsKeaClilFWToQ=
X-Google-Smtp-Source: ABdhPJygvqeb8CKahN9tA6vLmPaz+02mK9I2rCGgT2X4jCD85oC9ykdBR8OhrX8VXnQE2mrZbs3glcwYUGyMCAmx2KA=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr7518786wrq.192.1647601079616; Fri, 18
 Mar 2022 03:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220318083421.2062259-1-guoren@kernel.org>
In-Reply-To: <20220318083421.2062259-1-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Mar 2022 11:57:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0NMPVGVw7===uEOtNnu1hr1GqimMbZT+Kea1CUxRvPmw@mail.gmail.com>
Message-ID: <CAK8P3a0NMPVGVw7===uEOtNnu1hr1GqimMbZT+Kea1CUxRvPmw@mail.gmail.com>
Subject: Re: [PATCH] csky: Move to generic ticket-spinlock
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bqnkdYmcXFrf1DzpYk9XzTVJPnWQH3Mt3pH+fe4KYxq9t6N47rW
 VeS3iUvTeI8rb2z5JN0/tmZuYHM0Nx8taeiEjeegyQMc385wFUKeyNpQIRCC9XK7mjq6Tgs
 iMiA7ZWeLk4gs1lHTJCCm8+XGDQcgvRxwaZXtk0hLNWcwJlXgTkj6Y8tMePyjCqiJ60JlcK
 JdhurD+XY9hNw4AWcukXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fqN8OxJdcMQ=:uzws4P4sO+VIVhvDlqAfXt
 pFRqJxcPBHoot2Ex6x6Xr3LGO1DCaKHCfCe4x/kiR4IkiySc8q3fkF4py8CcPNAlpnnq2hYyT
 F/1GVQheRObYsXz+sTIdD/K3lLeebR7XzK+ITpt2HybgnhUE09Yy56Uxvo3gZayHesCxzMOCq
 pfjW/k93Ujtq7av1V8GhbllyJd0zN0o/kT9A7GXxfrASZJw7xMNBKdYrW70mo7XJ3fd2aUO3B
 8SfuAvaDgwomRx9OWjuurJ3g+JFviBkYzw0sFhkpFBLKVNv1FrpCOVIkYwITNle1HEjGoh2j8
 cSbs2d1mtQaabbqs0+XHIrdWhmJp7NdHsaAuyxSooNPQjZ4SY+4tLFPygb9MATkgdVEc3PCrR
 PUsiUja6+6/7i00r7dOevu20zrgebvGcnI6UnbtTiHPW9SDFDna6VoMdFzIW3TRnDqazsmbpq
 nbDH3Ii4soTob+PwtJTcTpHuFx/EXQp+vREyvDJXjcL0cDcwhV0qaUQFv/V6G99uWdaTA3bL6
 07l+A5Rlfu6SsDnxWyxThqGhEs/ropBj6nKOhIGfl2tbduSL3b93tMipL+/K2CSHn+F6DqGTp
 7qcFQkXhAyJLHeILIDWnS+S4mL4VlOCoYQ5FOjPxOBTHUKDbCDM9erOzhfLxqJ1spSf7QwzBC
 YxlpwOHUwpEhxfuTWilZosO8q6HLVrzXn042xdSpaods6f9dWMdKuOqkVMOdQOO86IEE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 18, 2022 at 9:34 AM <guoren@kernel.org> wrote:
> @@ -3,6 +3,8 @@ generic-y += asm-offsets.h
>  generic-y += extable.h
>  generic-y += gpio.h
>  generic-y += kvm_para.h
> +generic-y += ticket-lock.h
> +generic-y += ticket-lock-types.h
>  generic-y += qrwlock.h
>  generic-y += user.h
>  generic-y += vmlinux.lds.h

If these headers are not included from architecture-independent code,
they should
not be marked as generic-y, same as for the qrwlock.h header

> +#include <asm/ticket-lock.h>
>  #include <asm/qrwlock.h>
>
> ...
> +#include <asm/ticket-lock-types.h>
>  #include <asm-generic/qrwlock_types.h>
>

So these should all become

#include <asm-generic/...h>

It would however make sense to have the trivial two-line version
of the two header files and put them into asm-generic/spinlock.h
and asm-generic/spinlock-types.h, replacing the current version.

If you do that, then you need a 'generic-y' line for spinlock.h,
but not for the other ones.

       Arnd
