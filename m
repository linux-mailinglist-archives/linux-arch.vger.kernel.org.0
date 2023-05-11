Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF776FEC29
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 09:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbjEKHCH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 11 May 2023 03:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbjEKHBx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 03:01:53 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979247693;
        Thu, 11 May 2023 00:01:32 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so39792341276.0;
        Thu, 11 May 2023 00:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788490; x=1686380490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv6cvH2UY+DsSAH/1SoTqLLUBTfL/OySbHO2647mvDo=;
        b=YSFeEw+oPbFPNLK+U1LrJBjV9cAtbQ1gZAdHP8vNNY+qSL8bLENLyfOQfNcpWeqFdi
         I2ja7IfGexPmiwIsdW+URPTNBZYeZClHLXsOPo/wWFaJ5/9FepPWOEMGqpJqbe8aLEz2
         pEJjHqemnI36IBtKUUzcfQEUxsKe0yvy4Tf2dxTmQSJj3DeH3czW9+iCMYaC1aSQc31/
         2gh+egSqehlss7E1ZjQHULznuDcMGW2T4eFQa5t1Lem5eZ7furc60P/Nam3sNAFuZrnp
         NKQo30Jv3Kv7L4qkB4Rx7HnBksK5Ag5i+GyWFUM/CSixUQa5Mm2EadyfXaLuEOy5lrl0
         5mMQ==
X-Gm-Message-State: AC+VfDzSY5Wi6rVOd2r5i5H98hwTy/TgUgw4V2JCxTCjxvsyu7mCSpHi
        29qqCqKTlJzul7xLuTVS0LLZ8jHu6UWPgQ==
X-Google-Smtp-Source: ACHHUZ56BgLhcyTlh6N481WRk5gE2H9r1OLJbQXV+JI6bC01RnyTH3u69sOL+dz0hrJ/hDyZgi/3Rw==
X-Received: by 2002:a81:78c2:0:b0:55d:9f32:f6c with SMTP id t185-20020a8178c2000000b0055d9f320f6cmr19467435ywc.15.1683788490577;
        Thu, 11 May 2023 00:01:30 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id v2-20020a816102000000b0055db91a6ddfsm4094793ywb.73.2023.05.11.00.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 00:01:29 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so39725924276.1;
        Thu, 11 May 2023 00:01:29 -0700 (PDT)
X-Received: by 2002:a25:1342:0:b0:b25:a1e1:5b65 with SMTP id
 63-20020a251342000000b00b25a1e15b65mr22072246ybt.5.1683788488909; Thu, 11 May
 2023 00:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230510195806.2902878-1-nphamcs@gmail.com>
In-Reply-To: <20230510195806.2902878-1-nphamcs@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 May 2023 09:01:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=PNCb1VYfUkEb9rPwGVB=1tkwvm-XBqECyhHR4SNGKg@mail.gmail.com>
Message-ID: <CAMuHMdV=PNCb1VYfUkEb9rPwGVB=1tkwvm-XBqECyhHR4SNGKg@mail.gmail.com>
Subject: Re: [PATCH] cachestat: wire up cachestat for other architectures
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, kernel-team@meta.com,
        linux-arch@vger.kernel.org, hannes@cmpxchg.org,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, monstr@monstr.eu,
        tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, davem@davemloft.net,
        chris@zankel.net, jcmvbkbc@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nat,

On Wed, May 10, 2023 at 9:58 PM Nhat Pham <nphamcs@gmail.com> wrote:
> cachestat is previously only wired in for x86 (and architectures using
> the generic unistd.h table):
>
> https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com/
>
> This patch wires cachestat in for all the other architectures.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
>  arch/arm/tools/syscall.tbl                  | 1 +

Looking at the last addition of a syscall (commit 21b084fdf2a49ca1
("mm/mempolicy: wire up syscall set_mempolicy_home_node"), it looks
like you forgot to update arm64 in compat mode? Or is that not needed?

>  arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
>  arch/s390/kernel/syscalls/syscall.tbl       | 1 +
>  arch/sh/kernel/syscalls/syscall.tbl         | 1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
>  14 files changed, 14 insertions(+)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
