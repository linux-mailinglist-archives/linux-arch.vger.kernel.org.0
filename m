Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCA78DC6D
	for <lists+linux-arch@lfdr.de>; Wed, 30 Aug 2023 20:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjH3Spp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Aug 2023 14:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242727AbjH3JY6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Aug 2023 05:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B71B0;
        Wed, 30 Aug 2023 02:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C465F61A9D;
        Wed, 30 Aug 2023 09:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C5BC433C9;
        Wed, 30 Aug 2023 09:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693387494;
        bh=GVexAVl4OXlwgEx8i1Zo3IUowkonsKdunPkIpyXWO70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XWx4zqL8rCazfDLsB5arh2mcK+z0o0adJN47V14OnYHB+Dz7qsazZF1B0Rvt0etTe
         UWdxXt3TB3wVoviMkxbdDS5g3oZhY3GEErPMA6HP06fxX69sE7ZBqOEgjIZBNSq34K
         iamDkf2vzprYJyyv/qho8haqz3lCWhsC+Gag8XNkp/oXBDpaOXKeTEb4l9GIb/Gyy0
         KsDC9U3DUj0Ppnh2hVB9aL4r9eNMjhOA6fzaTXaWz7mVoy2/fHan7+keFyU6/+MAy/
         iSyID1+frNH+Sz6zKqnDDEoA3CcpudliNM7cJ2liQPDPyH5sSvC4gChbo4a1BQdEA2
         Twyt5RVhsSmAg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52a3ec08d93so6985143a12.2;
        Wed, 30 Aug 2023 02:24:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwgiQ++vP2kXeCHkSchQa7Frsjp5dbgAGADd0h6UvabDrVmoHNL
        CtBmt1+CNKNK5cCIpN3eJbmyOxHe7XQQ+ZiYlcY=
X-Google-Smtp-Source: AGHT+IGudNBEaDGxRoD/rFIb2UarY9S6l+a51qVRQcYut0ePuYGH/n8xNfiz7rMPfmzqxVzZq/NsluCmARwcFwY6D8c=
X-Received: by 2002:a05:6402:748:b0:523:40d0:34d1 with SMTP id
 p8-20020a056402074800b0052340d034d1mr1414354edy.4.1693387492337; Wed, 30 Aug
 2023 02:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230811030750.1335526-1-guoren@kernel.org> <cd3924fb-8639-4fa5-8aae-bc2b20a63dec@roeck-us.net>
In-Reply-To: <cd3924fb-8639-4fa5-8aae-bc2b20a63dec@roeck-us.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 30 Aug 2023 17:24:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTVJtTpq0rTrcT+MEGsq5KKUmpZJ+GKaVaw=6pD-3t+fw@mail.gmail.com>
Message-ID: <CAJF2gTTVJtTpq0rTrcT+MEGsq5KKUmpZJ+GKaVaw=6pD-3t+fw@mail.gmail.com>
Subject: Re: [PATCH] csky: Fixup -Wmissing-prototypes warning
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 30, 2023 at 4:11=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Thu, Aug 10, 2023 at 11:07:50PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Cleanup the warnings:
> >
> > arch/csky/kernel/ptrace.c:320:16: error: no previous prototype for 'sys=
call_trace_enter' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/ptrace.c:336:17: error: no previous prototype for 'sys=
call_trace_exit' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/setup.c:116:34: error: no previous prototype for 'csky=
_start' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/signal.c:255:17: error: no previous prototype for 'do_=
notify_resume' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:150:15: error: no previous prototype for 'do_t=
rap_unknown' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:152:15: error: no previous prototype for 'do_t=
rap_zdiv' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:154:15: error: no previous prototype for 'do_t=
rap_buserr' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:157:17: error: no previous prototype for 'do_t=
rap_misaligned' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:168:17: error: no previous prototype for 'do_t=
rap_bkpt' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:187:17: error: no previous prototype for 'do_t=
rap_illinsn' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:210:17: error: no previous prototype for 'do_t=
rap_fpe' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:220:17: error: no previous prototype for 'do_t=
rap_priv' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:230:17: error: no previous prototype for 'trap=
_c' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/traps.c:57:13: error: no previous prototype for 'trap_=
init' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/vdso/vgettimeofday.c:12:5: error: no previous prototyp=
e for '__vdso_clock_gettime64' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/vdso/vgettimeofday.c:18:5: error: no previous prototyp=
e for '__vdso_gettimeofday' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/vdso/vgettimeofday.c:24:5: error: no previous prototyp=
e for '__vdso_clock_getres' [-Werror=3Dmissing-prototypes]
> > arch/csky/kernel/vdso/vgettimeofday.c:6:5: error: no previous prototype=
 for '__vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> > arch/csky/mm/fault.c:187:17: error: no previous prototype for 'do_page_=
fault' [-Werror=3Dmissing-prototypes]
> >
> > Link: https://lore.kernel.org/lkml/20230810141947.1236730-17-arnd@kerne=
l.org/
> > Reported-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
>
> I get the following build errors in linux-next. Bisect points to this pat=
ch.
I missed this:

diff --git a/arch/csky/include/asm/traps.h b/arch/csky/include/asm/traps.h
index 1e7d303b91e9..732c4aaa2e26 100644
--- a/arch/csky/include/asm/traps.h
+++ b/arch/csky/include/asm/traps.h
@@ -3,6 +3,8 @@
 #ifndef __ASM_CSKY_TRAPS_H
 #define __ASM_CSKY_TRAPS_H

+#include <linux/linkage.h>
+
 #define VEC_RESET      0
 #define VEC_ALIGN      1
 #define VEC_ACCESS     2

Sorry, I would send another pull request to fixup mainline code.

>
> Building csky:defconfig ... failed
> --------------
> Error log:
> In file included from arch/csky/include/asm/ptrace.h:7,
>                  from arch/csky/include/asm/elf.h:6,
>                  from include/linux/elf.h:6,
>                  from kernel/extable.c:6:
> arch/csky/include/asm/traps.h:43:11: error: expected ';' before 'void'
>    43 | asmlinkage void do_trap_unknown(struct pt_regs *regs);
>       |           ^~~~~
>
> [ and many more similar errors ]
>
> Guenter
>
> ---
> # bad: [56585460cc2ec44fc5d66924f0a116f57080f0dc] Add linux-next specific=
 files for 20230830
> # good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
> git bisect start 'HEAD' 'v6.5'
> # bad: [17582b16f00f2ca3f84f1c9dadef1529895ddd9a] Merge branch 'for-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
> git bisect bad 17582b16f00f2ca3f84f1c9dadef1529895ddd9a
> # good: [bd6c11bc43c496cddfc6cf603b5d45365606dbd5] Merge tag 'net-next-6.=
6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect good bd6c11bc43c496cddfc6cf603b5d45365606dbd5
> # bad: [b22935905f9c5830bfd1c66ad3638ffdf6f80da7] Merge branch 'for-linux=
-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
> git bisect bad b22935905f9c5830bfd1c66ad3638ffdf6f80da7
> # good: [692f5510159c79bfa312a4e27a15e266232bfb4c] Merge tag 'asoc-v6.6' =
of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-l=
inus
> git bisect good 692f5510159c79bfa312a4e27a15e266232bfb4c
> # good: [b91742d84d29c39b643992b95560cfb7337eab18] mm/shmem.c: use helper=
 macro K()
> git bisect good b91742d84d29c39b643992b95560cfb7337eab18
> # good: [19134bc23500a01bfdb77a804fc8e4bf8808d0cc] mm: fix kernel-doc war=
ning from tlb_flush_rmaps()
> git bisect good 19134bc23500a01bfdb77a804fc8e4bf8808d0cc
> # bad: [858e6c6fd1960650c6a44b8158e1ac26ee63e26d] Merge branch 'for-curr'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git
> git bisect bad 858e6c6fd1960650c6a44b8158e1ac26ee63e26d
> # bad: [9d6b14cd1e993d2ff98df0cef6d935ce6fd4dbec] Merge tag 'flex-array-t=
ransformations-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gu=
stavoars/linux
> git bisect bad 9d6b14cd1e993d2ff98df0cef6d935ce6fd4dbec
> # good: [3b425dd2aeb8c876805a4cc29d84a6c455b43530] parisc: led: Move regi=
ster_led_regions() to late_initcall()
> git bisect good 3b425dd2aeb8c876805a4cc29d84a6c455b43530
> # good: [48d25d382643a9d8867f8eb13af231268ab10db5] Merge tag 'parisc-for-=
6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-lin=
ux
> git bisect good 48d25d382643a9d8867f8eb13af231268ab10db5
> # bad: [c8171a86b27401aa1f492dd1f080f3102264f1ab] csky: Fixup -Wmissing-p=
rototypes warning
> git bisect bad c8171a86b27401aa1f492dd1f080f3102264f1ab
> # good: [1362d15ffb59db65b2df354b548b7915686cb05c] csky: pgtable: Invalid=
ate stale I-cache lines in update_mmu_cache
> git bisect good 1362d15ffb59db65b2df354b548b7915686cb05c
> # good: [c1884e1e116409dafce84df38134aa2d7cdb719d] csky: Make pfn accesso=
rs static inlines
> git bisect good c1884e1e116409dafce84df38134aa2d7cdb719d
> # first bad commit: [c8171a86b27401aa1f492dd1f080f3102264f1ab] csky: Fixu=
p -Wmissing-prototypes warning



--=20
Best Regards
 Guo Ren
