Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF9B760B8F
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 09:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjGYHV3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 25 Jul 2023 03:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjGYHUp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 03:20:45 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031D12691;
        Tue, 25 Jul 2023 00:18:35 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bff89873d34so4361726276.2;
        Tue, 25 Jul 2023 00:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269514; x=1690874314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lrkzr5cvjosFI//uEK1aHD1IOI0Bz2cNenZQg3FVc4w=;
        b=fWhA9EWkD+ZEMuguAwoinNGH5j2OKtAcX8crgSN3YSu8rQqB9ekCcCWLwn/wYo1sWg
         5nS8J3BYlClh9iorqt2nRwBbOly+5qFPdM1exxr8KrZXiXTLW+q+QkPbhJJRloWVbFhn
         mQfVgi+TyrMFRX1WpeeEHgE+9cHDXPWaeqawyCEWYiBqEpRQkM1JEsjwpwSlb2jIfpEe
         ICqU70Uzl6nyEI7JTZsfpXqBEs1jfhnCPBgpYKPiog3uFj+TUxi74Z5tAZXYEJfEZ00c
         Ro9uit+6vmSpq0qHbd7B01aI+N9TVPaz8IkwCI846FjiIxN1HrQZn0P9KPg+bZLS95jR
         vf4Q==
X-Gm-Message-State: ABy/qLYOJPN++EAiPEl3aAvkRPh8Ykj6IZoirUVQa6LXDPVgny6PhPYi
        r8sR5zN+huNT/SWRjAM1dKaZps2pWfgCwzbM
X-Google-Smtp-Source: APBJJlFquI1pzW4cOH7f/kUyoqhPEI+V/dnUi9VjzK5/UaKxKuFCfZv6Ns89iB5d/mpXmnVNXJN9tg==
X-Received: by 2002:a5b:90b:0:b0:d1a:2488:5fb6 with SMTP id a11-20020a5b090b000000b00d1a24885fb6mr84600ybq.52.1690269513992;
        Tue, 25 Jul 2023 00:18:33 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id y1-20020a056902052100b00d0fe6cb4741sm1003858ybs.25.2023.07.25.00.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 00:18:31 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bff89873d34so4361683276.2;
        Tue, 25 Jul 2023 00:18:31 -0700 (PDT)
X-Received: by 2002:a25:b07:0:b0:d07:bce0:be77 with SMTP id
 7-20020a250b07000000b00d07bce0be77mr6021730ybl.61.1690269511226; Tue, 25 Jul
 2023 00:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230628230935.1196180-1-sohil.mehta@intel.com> <20230710185124.3848462-1-sohil.mehta@intel.com>
In-Reply-To: <20230710185124.3848462-1-sohil.mehta@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 09:18:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4HAMD5PA8OOsTGvx_1LuUw=Stegtcb9KQFVa-CP3T_w@mail.gmail.com>
Message-ID: <CAMuHMdX4HAMD5PA8OOsTGvx_1LuUw=Stegtcb9KQFVa-CP3T_w@mail.gmail.com>
Subject: Re: [PATCH v2] syscalls: Cleanup references to sys_lookup_dcookie()
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sergei Trofimovich <slyich@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Mon, Jul 10, 2023 at 8:52 PM Sohil Mehta <sohil.mehta@intel.com> wrote:
> commit 'be65de6b03aa ("fs: Remove dcookies support")' removed the
> syscall definition for lookup_dcookie.  However, syscall tables still
> point to the old sys_lookup_dcookie() definition. Update syscall tables
> of all architectures to directly point to sys_ni_syscall() instead.
>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org> # for perf
> ---
> v2:
> - Rebased to v6.5-rc1. No other dependencies.
> - Added acquired tags.

>  arch/m68k/kernel/syscalls/syscall.tbl               | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
