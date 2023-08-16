Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF777ED91
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 01:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347059AbjHPXBx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244027AbjHPXBW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 19:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0250413E;
        Wed, 16 Aug 2023 16:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8983B65891;
        Wed, 16 Aug 2023 23:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F34DC433CC;
        Wed, 16 Aug 2023 23:01:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jXokpT8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1692226871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJ+exFyMwxf+Sp/aWFmN/k274aR2STKWbu8odcAPWm8=;
        b=jXokpT8HHm9bHv6hIJ3T3CMHWSwvmBYeqbPj7fjD4Ezxvigmdm/fXPxtKXDXtXiveMyEy2
        K2zo2MO6Jx19/zc76sU6x7FN12g49ex3CRn9eKlZgLZMkYTlRh8PLwi9EYMp443CajZ7FT
        H+k/S7W81nftL8bDVz+/B0+KLWJPGLw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 598949e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Aug 2023 23:01:10 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-79414715edeso1459494241.0;
        Wed, 16 Aug 2023 16:01:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxcwh35R/0Ner5l4oPPLmekSzhwnYWcQU82HFTrav4OM8vLDKZT
        2JSmLNPtBDrGKjIokzc8ouVW9HG/85iwCCht4Jg=
X-Google-Smtp-Source: AGHT+IFdKTop/dTzxxplY5bDLsdLZZ0m1tGPXQJd6rkmBy2Wm4exC645Mb9rMUW6TK7Pnh6+pZhH7oflLvX5KYDSdqc=
X-Received: by 2002:a67:e211:0:b0:443:c87f:ebb1 with SMTP id
 g17-20020a67e211000000b00443c87febb1mr2517297vsa.29.1692226866965; Wed, 16
 Aug 2023 16:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230816055010.31534-1-rdunlap@infradead.org>
In-Reply-To: <20230816055010.31534-1-rdunlap@infradead.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 17 Aug 2023 00:58:18 +0200
X-Gmail-Original-Message-ID: <CAHmME9pxC_e6Ftj1MJ4H2skhhKfNubd=7OwcH9xepCxjkDxpkg@mail.gmail.com>
Message-ID: <CAHmME9pxC_e6Ftj1MJ4H2skhhKfNubd=7OwcH9xepCxjkDxpkg@mail.gmail.com>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, wireguard@lists.zx2c4.com,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 16, 2023 at 7:50=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> There is only one Kconfig user of CONFIG_EMBEDDED and it can be
> switched to EXPERT or "if !ARCH_MULTIPLATFORM" (suggested by Arnd).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: wireguard@lists.zx2c4.com
> Cc: linux-arch@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> diff -- a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/te=
sting/selftests/wireguard/qemu/kernel.config
> --- a/tools/testing/selftests/wireguard/qemu/kernel.config
> +++ b/tools/testing/selftests/wireguard/qemu/kernel.config
> @@ -41,7 +41,6 @@ CONFIG_KALLSYMS=3Dy
>  CONFIG_BUG=3Dy
>  CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
>  CONFIG_JUMP_LABEL=3Dy
> -CONFIG_EMBEDDED=3Dn
>  CONFIG_BASE_FULL=3Dy
>  CONFIG_FUTEX=3Dy
>  CONFIG_SHMEM=3Dy

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
