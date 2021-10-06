Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA242411B
	for <lists+linux-arch@lfdr.de>; Wed,  6 Oct 2021 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhJFPTt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Oct 2021 11:19:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50943 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhJFPTs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2021 11:19:48 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNKuI-1mAX1c2hNi-00OrM3; Wed, 06 Oct 2021 17:17:54 +0200
Received: by mail-wr1-f41.google.com with SMTP id j8so9901411wro.7;
        Wed, 06 Oct 2021 08:17:54 -0700 (PDT)
X-Gm-Message-State: AOAM532Q43ElqS2UQ23hjzSfwnj9OHkRE/+A3QS9kCMKb5NMJhd1yV6h
        3dpik9wlo4MbVO/nfyJlfMAb7zKPlzSZnBPfB6I=
X-Google-Smtp-Source: ABdhPJzzqvoHYlQk2fQWJUzRcXdqZhuq+vNm94ftkYZ7RMylClUbZjxaLkQtrEJaWxkhu1k6wukF1ikvRUsQcoSXV/M=
X-Received: by 2002:adf:b1c4:: with SMTP id r4mr28248153wra.428.1633533474265;
 Wed, 06 Oct 2021 08:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211006145859.9564-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211006145859.9564-1-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Oct 2021 17:17:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
Message-ID: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nIl25lFbfNeOMxdEthhqs0MK70ahLfP3x9ECRWZNMgCj2qfywzL
 WDhlPDN210R8SBPhm7di6dzIa+rskaw3oXzZ7uNjuJ8YD8abpemXGWJIFAyS3BZs+jnDQKH
 xhjNq3EOkJa44N/03wjzYl6dSSjr63UehjLs8n5wQDvPgsJ7iyh8oInYrwz6EQmIunsxFwA
 SYd2tb46E0WRa9EK9XZtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mtxe3FpY1yw=:JhWVhEk8cwwRWfgc4FGWD2
 JkxnfiPYNYdaLjquCNPhuYbjynIBCtWx3fdXnPslZ84EVOpa+r9zLI0xlP45HVXmfUO8uyKe7
 zvQaE9XPmnitnKg2tMkcEs/w9fzNgvPWVsnllAHr48bya5GzUG8UUtvTjastYS7KDT8/JUfWR
 YE2tCSiCbWGZMUoY7nqjiWe3kYvCncPyoZqyOj5se6jTxS8h81/xaV/E5NHxVODeY0LuhhzsR
 5UG04wZNC+P7JqKHWJDHg0shZt1hvFFeTpvFq6p3HdrdU2mDJALMkEWeuU3Tj1OiM1JdEt+A2
 SutSVenVH9lHg+r6xnAiuSp99U87tBBUDDZN+7YRnllasZAhSTBnuxxrv3EupMTHOkwd2ciN5
 NWUsEpyfbtq1tw3TZR7xtRR+FG5TQLl2vfqAyOjfZiEb6zYywelkoHL9U9vqo3Ty2wVLXeyFC
 tGRuqWK39ZRmXC6XDlYvNmU7G1dRC91NAJa+ieW2mtvcQncuSXTiAn3zmA71iBMnpnCR8RoWL
 zZEpWIc2DZZ1PvyA4uGBEc3EQ2Ooa/fhw+94i1LdVOcKSdXztsbm+YHCCKrrxvhlf/fH6G4QU
 Wzs4MceK4dJWU/VfCBMf5KXm7eKQJlNWQF6uaRkzgm9gtn3k5H5dDDX9pNnJAeBxQjffuNC27
 TRrteIsMWyDmsYV4CuTyhgrCJpuh1vgXHcV5m3roGlBROWdUEFM6qEJTzxsfhCawqPmjphsRH
 Xn68GFVhPk00Ay7KjKQf3Dz8yaCtVDRKvHEeSA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 6, 2021 at 5:00 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
> falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
> in the reference) in ./include/asm-generic/io.h.
>
> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
>
> GENERIC_DEVMEM_IS_ALLOWED
> Referencing files: include/asm-generic/io.h
>
> Correct the name of the config to the intended one.
>
> Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
