Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9F58D22F
	for <lists+linux-arch@lfdr.de>; Tue,  9 Aug 2022 04:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiHIC6a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 22:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiHIC63 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 22:58:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3DC615D;
        Mon,  8 Aug 2022 19:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8A0FB81148;
        Tue,  9 Aug 2022 02:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92357C4347C;
        Tue,  9 Aug 2022 02:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660013906;
        bh=vY5ylUkzROKwy6ry3674cLxiF3l1xgYFwsMymQ3/CTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R8BvOq/2UB9nvzN0NTUl0Ua9w1FdnAGpPjzhHZajA4xbD3NrKkwByj3aeAQ37TVrX
         stsuOdxBc6zfiTAVYLi+5we5azJSs55v0zRZALYRKQttF5/P44aEBZvT1NpykBDCcT
         OCDcFnx3hFLOHtZwNokPc84wgz1lhYH1rTMXlYpbe0v25AfC589E/2LqB/eLEAp5IC
         o66iwu2s++KkUVIpL47K+iX/WyMJ2+GZPfJlYwTUmVfS0HsPeSrn8zKqi7VLWJhwzd
         Kq4LDTOvA08REc/NqzmcRGcxaL+S4DWwJaEDExZZlukJNb4ZHwSfEHqYJpT854i3x2
         qK0DFeZlO8ouw==
Received: by mail-ot1-f43.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso7729782otv.3;
        Mon, 08 Aug 2022 19:58:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo2+4nnoJmtGJ1KsNqwZ3j9jIPIiAT7AtkQgWJWf3JZb7eWU37bc
        tjQTCB/DP79cSaATE1sZgxBzAYo6rR9i6YD25no=
X-Google-Smtp-Source: AA6agR5lND1hBBqkzDW8S6KaZCUwopF2Nn6/QDh4BK6hrBv+XTSLq99vu0sFJBLe9j6l/fXE+mioK2Jp5R7Gv07KeoQ=
X-Received: by 2002:a9d:b95:0:b0:637:9c9:864a with SMTP id 21-20020a9d0b95000000b0063709c9864amr606716oth.140.1660013905660;
 Mon, 08 Aug 2022 19:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220808080600.3346843-1-guoren@kernel.org> <20220808080600.3346843-2-guoren@kernel.org>
 <alpine.DEB.2.22.394.2208081119230.411952@gentwo.de>
In-Reply-To: <alpine.DEB.2.22.394.2208081119230.411952@gentwo.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 9 Aug 2022 10:58:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQhLYCtuLwjXREPG5ibL+biGEgFQaE6x+9MXRG_8F_+WA@mail.gmail.com>
Message-ID: <CAJF2gTQhLYCtuLwjXREPG5ibL+biGEgFQaE6x+9MXRG_8F_+WA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] vmstat: percpu: Rename HAVE_CMPXCHG_LOCAL to HAVE_CMPXCHG_PERCPU_BYTE
To:     Christoph Lameter <cl@gentwo.de>
Cc:     tj@kernel.org, palmer@dabbelt.com, will@kernel.org,
        catalin.marinas@arm.com, peterz@infradead.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 8, 2022 at 5:31 PM Christoph Lameter <cl@gentwo.de> wrote:
>
> On Mon, 8 Aug 2022, guoren@kernel.org wrote:
>
> > The name HAVE_CMPXCHG_LOCAL is confused with using cmpxchg_local, but
> > vmstat needs this_cpu_cmpxchg_1. Rename would clarify the meaning, and
> > maybe we could remove cmpxchg(64)_local API (Only drivers/iommu/intel
> > used) in the future.
>
> HAVE_CMPXCHG_LOCAL indicates that cmpxchg_local() is available.
>
> The term LOCAL is important because that has traditionally signified an
> operation that has an atomic nature that only works on the local core.
>
> cmpxchg local is used in slub too in the form of this_cpu_cmpxchg_double.
1. raw_cpu_generic_cmpxchg_double don't use cmpxchg(64)_local.
2. x86 and s390 implement this_cpu_cmpxchg_double with direct asm
code, no relationship to cmpxchg local.
3. Only arm64 using cmpxchg_double_local internal, but we could remove
the relationship from generic cmpxchg_double_local. It's a fake usage.
So maybe it's time to remove cmpxchg(64)_local in Linux and replace
them by this_cpu_cmpxchg & cmpxchg_relaxed.

>
> But there is the other naming using this_cpu.....
>
> Maybe rename to
>
>         HAVE_THIS_CPU_CMPXCHG ?
I think we should keep 1/BYTE as a suffix because riscv only
implements 4bytes & 8bytes size cmpxchg. But vmstat needs 1Byte.

>
> and clean up all the other mentions of "local" in the source too?
Good point, I would try. How we deal with drivers/iommu/intel/iommu.c:
tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);

Change "cmpxchg64_local -> cmpxchg64_relaxed" would make them happy? I
think they are cmpxchg_local & cmpxchg_sync users.


>
> There is also a local.h header around somewhere
Yes, thx for mentioning, I missed that. The alpha, loongarch, MIPS,
PowerPC and x86 make local_cmpxchg -> cmpxchg_local. Most of them are
copy-paste guys, not real users.


--
Best Regards
 Guo Ren
