Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90978DC69
	for <lists+linux-arch@lfdr.de>; Wed, 30 Aug 2023 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbjH3Spl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Aug 2023 14:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbjH3ILQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Aug 2023 04:11:16 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE41A2;
        Wed, 30 Aug 2023 01:11:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-792918c5f33so127214639f.3;
        Wed, 30 Aug 2023 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693383073; x=1693987873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYDzreiruH6qbDLXg2iLXCvSh9G4cLtJs9x6gJkSy4U=;
        b=VRc3L/YJmlEqi9nW+I4BpFQV2geuHX+gL4RmSF1Kpn5C2lL1mM/eEZ+2Q5rp63om0i
         tfwHJ+BW52bA2/hqzMh1h+3BX7tDIB6yEEzDkVrk5CIip3PesyNRFMjLATpMxeD5DIgV
         HhSjv1NHEsvuqukPoeIWnCEsmmFwx8HHv+ZKuuDCgembecfxXd2a1bpOq84/IFtpfbMt
         ae4so5eQo4oP62KoeQu4SL5KGP+pGhedeM7Lji4bepydO0ATJp2wtdcxclPN3sOND6Bi
         dhuCDkKBDM8MTLjZR5nS4Ejja7WtvIsRovlBlTe3ZNaUWJ109Cs1EN6t4VCbky+m6mxH
         9Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693383073; x=1693987873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYDzreiruH6qbDLXg2iLXCvSh9G4cLtJs9x6gJkSy4U=;
        b=fdp8SgkKLtvsYmXLPoro6bKgkHq0IJnIv+/kA6oajjP+fHNcFa6OWNWlcDg15MZw6m
         wci6GpSeoGqW+sBARcLj9zSrorl2SefLkT6sTG4XdhzKgHjb24jDMzcTB/wbf9bbMKf6
         cHwc6ypfXBy0vpVlqUp0GUTejMSUXmkrDMVX1O3ibCdqa4oP+TucI/rJyY/jr5QJb8ii
         YfYLdrAmUogsEH6oOLifdFGzb++YYHDWyQLd0L1WNShOX/e9mXBB6u28c/35WDmrzdcL
         rp79aJzpwj187SKAuQ7Qk8r7YH34VPqIaAYmchfpn/yQ/4kmA7aLqTd3XS28mVeQj8Jc
         kAfg==
X-Gm-Message-State: AOJu0YxBJS/XJak0lBCnaeZ7PPNCAHxJOX5e8G0LT73rVBTVGT/G9Cr+
        B3DXVUV1ELU3ItXarzaQeObP0koP8i4=
X-Google-Smtp-Source: AGHT+IFLukJjgPDCF+6dPVVFCsQtUYJRqy8yK01NHrroGa5RFO41C2WL5CPpF/m8ShUQRg8pSqKOLw==
X-Received: by 2002:a6b:7a03:0:b0:787:34d:f1ea with SMTP id h3-20020a6b7a03000000b00787034df1eamr1946784iom.8.1693383072910;
        Wed, 30 Aug 2023 01:11:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h12-20020a6b7a0c000000b007836c7e8dccsm3762285iom.17.2023.08.30.01.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 01:11:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Aug 2023 01:11:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] csky: Fixup -Wmissing-prototypes warning
Message-ID: <cd3924fb-8639-4fa5-8aae-bc2b20a63dec@roeck-us.net>
References: <20230811030750.1335526-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811030750.1335526-1-guoren@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 10, 2023 at 11:07:50PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Cleanup the warnings:
> 
> arch/csky/kernel/ptrace.c:320:16: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
> arch/csky/kernel/ptrace.c:336:17: error: no previous prototype for 'syscall_trace_exit' [-Werror=missing-prototypes]
> arch/csky/kernel/setup.c:116:34: error: no previous prototype for 'csky_start' [-Werror=missing-prototypes]
> arch/csky/kernel/signal.c:255:17: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:150:15: error: no previous prototype for 'do_trap_unknown' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:152:15: error: no previous prototype for 'do_trap_zdiv' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:154:15: error: no previous prototype for 'do_trap_buserr' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:157:17: error: no previous prototype for 'do_trap_misaligned' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:168:17: error: no previous prototype for 'do_trap_bkpt' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:187:17: error: no previous prototype for 'do_trap_illinsn' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:210:17: error: no previous prototype for 'do_trap_fpe' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:220:17: error: no previous prototype for 'do_trap_priv' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:230:17: error: no previous prototype for 'trap_c' [-Werror=missing-prototypes]
> arch/csky/kernel/traps.c:57:13: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
> arch/csky/kernel/vdso/vgettimeofday.c:12:5: error: no previous prototype for '__vdso_clock_gettime64' [-Werror=missing-prototypes]
> arch/csky/kernel/vdso/vgettimeofday.c:18:5: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
> arch/csky/kernel/vdso/vgettimeofday.c:24:5: error: no previous prototype for '__vdso_clock_getres' [-Werror=missing-prototypes]
> arch/csky/kernel/vdso/vgettimeofday.c:6:5: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
> arch/csky/mm/fault.c:187:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
> 
> Link: https://lore.kernel.org/lkml/20230810141947.1236730-17-arnd@kernel.org/
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

I get the following build errors in linux-next. Bisect points to this patch.

Building csky:defconfig ... failed
--------------
Error log:
In file included from arch/csky/include/asm/ptrace.h:7,
                 from arch/csky/include/asm/elf.h:6,
                 from include/linux/elf.h:6,
                 from kernel/extable.c:6:
arch/csky/include/asm/traps.h:43:11: error: expected ';' before 'void'
   43 | asmlinkage void do_trap_unknown(struct pt_regs *regs);
      |           ^~~~~

[ and many more similar errors ]

Guenter

---
# bad: [56585460cc2ec44fc5d66924f0a116f57080f0dc] Add linux-next specific files for 20230830
# good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
git bisect start 'HEAD' 'v6.5'
# bad: [17582b16f00f2ca3f84f1c9dadef1529895ddd9a] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect bad 17582b16f00f2ca3f84f1c9dadef1529895ddd9a
# good: [bd6c11bc43c496cddfc6cf603b5d45365606dbd5] Merge tag 'net-next-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect good bd6c11bc43c496cddfc6cf603b5d45365606dbd5
# bad: [b22935905f9c5830bfd1c66ad3638ffdf6f80da7] Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
git bisect bad b22935905f9c5830bfd1c66ad3638ffdf6f80da7
# good: [692f5510159c79bfa312a4e27a15e266232bfb4c] Merge tag 'asoc-v6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
git bisect good 692f5510159c79bfa312a4e27a15e266232bfb4c
# good: [b91742d84d29c39b643992b95560cfb7337eab18] mm/shmem.c: use helper macro K()
git bisect good b91742d84d29c39b643992b95560cfb7337eab18
# good: [19134bc23500a01bfdb77a804fc8e4bf8808d0cc] mm: fix kernel-doc warning from tlb_flush_rmaps()
git bisect good 19134bc23500a01bfdb77a804fc8e4bf8808d0cc
# bad: [858e6c6fd1960650c6a44b8158e1ac26ee63e26d] Merge branch 'for-curr' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git
git bisect bad 858e6c6fd1960650c6a44b8158e1ac26ee63e26d
# bad: [9d6b14cd1e993d2ff98df0cef6d935ce6fd4dbec] Merge tag 'flex-array-transformations-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux
git bisect bad 9d6b14cd1e993d2ff98df0cef6d935ce6fd4dbec
# good: [3b425dd2aeb8c876805a4cc29d84a6c455b43530] parisc: led: Move register_led_regions() to late_initcall()
git bisect good 3b425dd2aeb8c876805a4cc29d84a6c455b43530
# good: [48d25d382643a9d8867f8eb13af231268ab10db5] Merge tag 'parisc-for-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect good 48d25d382643a9d8867f8eb13af231268ab10db5
# bad: [c8171a86b27401aa1f492dd1f080f3102264f1ab] csky: Fixup -Wmissing-prototypes warning
git bisect bad c8171a86b27401aa1f492dd1f080f3102264f1ab
# good: [1362d15ffb59db65b2df354b548b7915686cb05c] csky: pgtable: Invalidate stale I-cache lines in update_mmu_cache
git bisect good 1362d15ffb59db65b2df354b548b7915686cb05c
# good: [c1884e1e116409dafce84df38134aa2d7cdb719d] csky: Make pfn accessors static inlines
git bisect good c1884e1e116409dafce84df38134aa2d7cdb719d
# first bad commit: [c8171a86b27401aa1f492dd1f080f3102264f1ab] csky: Fixup -Wmissing-prototypes warning
