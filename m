Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25697B6F8C
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbjJCRTy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 3 Oct 2023 13:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjJCRTy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 13:19:54 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B51A3;
        Tue,  3 Oct 2023 10:19:50 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d84f18e908aso1245292276.1;
        Tue, 03 Oct 2023 10:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353590; x=1696958390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDlx4Wu9l39McbXAmxr/aQafR9CqgRAFRsdqHoaziys=;
        b=u3TzJQVHs2TyvUbttO8WzzrdBlie/xcE1zaSK5/+w7CWrluwn4sTXLpeNJ2uaxsPV2
         s4F8CxAC4LvhidYIZwOmZHgyFbVFi1PY+UMa28XdQbQEmrLLdU4ymN0raz72rKgMxCoS
         AyDMWlEqrZ2pDUhObtqykTQND70Npumrx/vw0P0NRZ6uHCL3dukLOM0PQQeZIAgaBJ3X
         sMU0dBY6WaOXetVWq6lUuFECgKsQeqxOxnwS75upyCUDRMK6VOJa+qzQWhY38DiVZwL2
         aVp01VzxydtYck3vrjIqOi0kqjbqy8T5kchgGgAG7QE5K5Mt/+1S6V/0GNjcuGll5XD3
         PEYw==
X-Gm-Message-State: AOJu0Yws6aDGR6Q6DJkGzmuDu0kV3ujCyFxEiM3yug5UNKZWbhplMu3V
        7njiSLUhvbcMaBDGpjJByBn3rqEndnBqwA==
X-Google-Smtp-Source: AGHT+IGqmgXkbkTaf+6EtgFJ/h0X0E+OPsMzs3fneex+WjZKmz+aewZPW0qOLo2vl5CreZHC7XbNxQ==
X-Received: by 2002:a25:3042:0:b0:d81:7041:9520 with SMTP id w63-20020a253042000000b00d8170419520mr12551329ybw.56.1696353589811;
        Tue, 03 Oct 2023 10:19:49 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id x62-20020a254a41000000b00bcd91bb300esm520301yba.54.2023.10.03.10.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 10:19:49 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a24b03e22eso14897427b3.0;
        Tue, 03 Oct 2023 10:19:49 -0700 (PDT)
X-Received: by 2002:a81:a14b:0:b0:583:6db3:a007 with SMTP id
 y72-20020a81a14b000000b005836db3a007mr272837ywg.17.1696353588829; Tue, 03 Oct
 2023 10:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230914185804.2000497-1-sohil.mehta@intel.com>
In-Reply-To: <20230914185804.2000497-1-sohil.mehta@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Oct 2023 19:19:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDho+vRAnQ3_AWjLcGgrNKNhWGmpdpjipq53QjvRrUJw@mail.gmail.com>
Message-ID: <CAMuHMdWDho+vRAnQ3_AWjLcGgrNKNhWGmpdpjipq53QjvRrUJw@mail.gmail.com>
Subject: Re: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
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
        Arnd Bergmann <arnd@arndb.de>,
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
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 8:59 PM Sohil Mehta <sohil.mehta@intel.com> wrote:
> commit c35559f94ebc ("x86/shstk: Introduce map_shadow_stack syscall")
> recently added support for map_shadow_stack() but it is limited to x86
> only for now. There is a possibility that other architectures (namely,
> arm64 and RISC-V), that are implementing equivalent support for shadow
> stacks, might need to add support for it.
>
> Independent of that, reserving arch-specific syscall numbers in the
> syscall tables of all architectures is good practice and would help
> avoid future conflicts. map_shadow_stack() is marked as a conditional
> syscall in sys_ni.c. Adding it to the syscall tables of other
> architectures is harmless and would return ENOSYS when exercised.
>
> Note, map_shadow_stack() was assigned #453 during the merge process
> since #452 was taken by fchmodat2().
>
> For Powerpc, map it to sys_ni_syscall() as is the norm for Powerpc
> syscall tables.
>
> For Alpha, map_shadow_stack() takes up #563 as Alpha still diverges from
> the common syscall numbering system in the other architectures.
>
> Link: https://lore.kernel.org/lkml/20230515212255.GA562920@debug.ba.rivosinc.com/
> Link: https://lore.kernel.org/lkml/b402b80b-a7c6-4ef0-b977-c0f5f582b78a@sirena.org.uk/
>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
