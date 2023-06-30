Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7200C74344F
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 07:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjF3FeI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 30 Jun 2023 01:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjF3FeF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 01:34:05 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE8010F8;
        Thu, 29 Jun 2023 22:34:04 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so1371845276.3;
        Thu, 29 Jun 2023 22:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688103243; x=1690695243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqe4oW6egP6ZYOUhmx0yHzT4spsp8DeajtOy9Dxl0N0=;
        b=LIl0qLBMoW2LcJe2pPURQ0ju/TOcC/ZDWK6A3oVTnmFWJS7gYfIC1bIOf1gArGxrxM
         I1boPzYZz19N5jurvtUEsZMRl9AlekP1u5fqDuB95nUo4uhTt3NgshUtNu3KfRvwzo5k
         rCkn2GPz/k93Of9GfOClAJMS3N5vv2B6eqJ0c3fYbGN42PK38YFAkqAJP8/kkthAga+s
         U1s3ENOmaKhtVza2UVdZzhHmtC883/wN8Z3t4TZ6kPVzGDnduFiMHU/jII8VFmZ8ixFn
         P8WkVY85ZdA7eJb99tEhNAjPervEYs0QXGjiLfb3/OEV3+Dv5RZYEzR4W/h2Ythp+374
         LUTg==
X-Gm-Message-State: ABy/qLZ+1tELI0GRK3KtASWIqhDTVq1zv15xBVimE0wYU6IodiN/UVGf
        XMpKUz2j7WLP6GjxWts5bkvmrtp3Sh5+2+FN1ApXPUOEo1c=
X-Google-Smtp-Source: APBJJlGsOWkMaxD3Bj5EXOi0ZRM8KsFOEr8Lg1uNKczc+6HZPSKDsYy2QxFxSi6Et+JGvnEpCG0zVQlZ9J+DNPB54vc=
X-Received: by 2002:a25:3107:0:b0:c12:29ac:1d36 with SMTP id
 x7-20020a253107000000b00c1229ac1d36mr1697430ybx.7.1688103242894; Thu, 29 Jun
 2023 22:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230628230935.1196180-1-sohil.mehta@intel.com> <08e273fc-49c5-dd09-1c9e-d85a080767f9@infradead.org>
In-Reply-To: <08e273fc-49c5-dd09-1c9e-d85a080767f9@infradead.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Jun 2023 22:33:51 -0700
Message-ID: <CAM9d7ch0GtTUjhtbph5rmCDvRBAKjLCN+25mukn_QPv4bDsjGQ@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Cleanup references to sys_lookup_dcookie()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Sohil Mehta <sohil.mehta@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
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
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sergei Trofimovich <slyich@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

Hello,

On Wed, Jun 28, 2023 at 4:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 6/28/23 16:09, Sohil Mehta wrote:
> > commit 'be65de6b03aa ("fs: Remove dcookies support")' removed the
> > syscall definition for lookup_dcookie.  However, syscall tables still
> > point to the old sys_lookup_dcookie() definition. Update syscall tables
> > of all architectures to directly point to sys_ni_syscall() instead.
> >
> > Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

I was about to say that it'd be nice if you split the tools/perf part
since it can support old kernels.  But if the syscall is only used for
oprofile then probably perf doesn't need to care about it. :)

For the perf part,
Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
