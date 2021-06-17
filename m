Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6A3AA826
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 02:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhFQAeW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 20:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFQAeV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 20:34:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B60C061574;
        Wed, 16 Jun 2021 17:32:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so732944pjo.3;
        Wed, 16 Jun 2021 17:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=HlMAqLQxn6v+mWiiXUxQu/TdTnXdtQ7st+0tT7u1DFY=;
        b=HVWMTemgMHeY2VUSfacljFjPg0M/GfrzQ13PNudHzyQrFDqeFmIy0VAmJxC7l8I/g0
         DeNyxGemOr+cDh12p/+Dh4jUz7l2idGLs8ZDWPkbrikWSusJvIXHnqKcfbEaghaJJys+
         IeJKhqR4/wRm5zCPrHxuKBffIwHtxftuOHRObLBpC+t7iGj1N24SRKkl0Z2R8z5abEe4
         WLtd2ZjY3PSM3i/5h/D7tnLwC+sw6HYRw3/bHOcx20fahWLsXDxxaciUV7/OA88KOFox
         IMAdtoi74gW3r1QdDtjVOhb9r+BKDjhVtyXBO6M3zUpVhULVKIVTkLvFoLijMl2/iTNY
         2kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=HlMAqLQxn6v+mWiiXUxQu/TdTnXdtQ7st+0tT7u1DFY=;
        b=gXuzK3mF2FSuONOs2Wh99rqSJHh3XHXboTkFT2cT5JbAyZT9frNRA2nI+25DbSW9l3
         HM7Wir1kAaJiM9IV9tJjtOU9T5nXnTjdaBDdEGoFyWvcx1pBucQuXCL3ZB+0Jh7677tE
         lWk5MkHneTHnh+3wy4iKA6vMK3Of6AGJLk21SfcOaj28EpKl5Tah5HKTjhHgTYLSAlQW
         A8vPar/TDdVObZ9MepSrzUGNJ2hky7aleGb0Q/rD6f4BLQQ0ylskKMVs057DeBVRT4zM
         rawRkkpkDYV5AZn1YVo/blceIsRZc0nnmTq+Q6FQMixN3KXMMu11Xy6lS6pGJnxyjduB
         Bc2g==
X-Gm-Message-State: AOAM532tL8JW43gZ06+Dsf7+nMRPm5aTa7yfEC7wpYK2DF3T04Pr0sbS
        7YinGBoyL5cTdB6eyKwlE78=
X-Google-Smtp-Source: ABdhPJw1j+Sf3Rs1tAp4YIYmoABCfc/HdBFsODjUCrmIAPsu6DNBYVbsuoUQtu23Ubyav+KRXU0yLg==
X-Received: by 2002:a17:90a:c08f:: with SMTP id o15mr13401437pjs.166.1623889933645;
        Wed, 16 Jun 2021 17:32:13 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id s21sm3362607pgo.42.2021.06.16.17.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 17:32:13 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:32:07 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-3-npiggin@gmail.com>
        <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
        <1623629185.fxzl5xdab6.astroid@bobo.none>
        <02e16a2f-2f58-b4f2-d335-065e007bcea2@kernel.org>
        <1623643443.b9twp3txmw.astroid@bobo.none>
        <1623645385.u2cqbcn3co.astroid@bobo.none>
        <1623647326.0np4yc0lo0.astroid@bobo.none>
        <aecf5bc8-9018-c021-287d-6a975b7a6235@kernel.org>
        <1623715482.4lskm3cx10.astroid@bobo.none>
        <3b9eb877-5d1e-d565-5577-575229d18b6e@kernel.org>
        <1623803360.zd3fo9zm1z.astroid@bobo.none>
In-Reply-To: <1623803360.zd3fo9zm1z.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1623887812.eoi29y243g.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of June 16, 2021 11:02 am:
> Excerpts from Andy Lutomirski's message of June 16, 2021 10:14 am:
>> akpm, please drop this series until it's fixed.  It's a core change to
>> better support arch usecases, but it's unnecessarily fragile, and there
>> is already an arch maintainer pointing out that it's inadequate to
>> robustly support arch usecases.  There is no reason to merge it in its
>> present state.

Just to make sure I'm not doing anything stupid or fragile for other=20
archs, I had a closer look at a few. sparc32 is the only one I have a=20
SMP capable qemu and initramfs at hand for, took about 5 minutes to=20
convert after fixing 2 other sparc32/mm bugs (patches on linux-sparc),
one of them found by the DEBUG_VM code my series added. It seems to work=20
fine, with what little stressing my qemu setup can muster.

Simple. Robust. Pretty mechanical conversion follows the documented=20
reciple. Re-uses every single line of code I added outside=20
arch/powerpc/. Requires no elaborate dances.

alpha and arm64 are both 4-liners by the looks, sparc64 might reqiure a=20
bit of actual code but doesn't look too hard.

So I'm satisfied the code added outside arch/powerpc/ is not some=20
fragile powerpc specific hack. I don't know if other archs will use=20
it, but they easily can use it[*].

And we can make changes to help x86 whenever its needed -- I already=20
posted patch 1/n for configuring out lazy tlb and active_mm from core=20
code rebased on top of mmotm so the series is not preventing such=20
changes.

Hopefully this allays some concerns.

[*] I do think mmgrab_lazy_tlb is a nice change that self-documents the=20
    active_mm refcounting, so I will try to get all the arch code=20
    converted to use it over the next few releases, even if they never
    switch to use lazy tlb shootdown.

Thanks,
Nick

---
 arch/sparc/Kconfig            | 1 +
 arch/sparc/kernel/leon_smp.c  | 2 +-
 arch/sparc/kernel/smp_64.c    | 2 +-
 arch/sparc/kernel/sun4d_smp.c | 2 +-
 arch/sparc/kernel/sun4m_smp.c | 2 +-
 arch/sparc/kernel/traps_32.c  | 2 +-
 arch/sparc/kernel/traps_64.c  | 2 +-
 7 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 164a5254c91c..db9954af57a2 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -58,6 +58,7 @@ config SPARC32
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
+	select MMU_LAZY_TLB_SHOOTDOWN
 	select OLD_SIGACTION
=20
 config SPARC64
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1eed26d423fb..d00460788048 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -92,7 +92,7 @@ void leon_cpu_pre_online(void *arg)
 			     : "memory" /* paranoid */);
=20
 	/* Attach to the address space of init_task. */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm =3D &init_mm;
=20
 	while (!cpumask_test_cpu(cpuid, &smp_commenced_mask))
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e38d8bf454e8..19aa12991f2b 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -127,7 +127,7 @@ void smp_callin(void)
 	current_thread_info()->new_child =3D 0;
=20
 	/* Attach to the address space of init_task. */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm =3D &init_mm;
=20
 	/* inform the notifiers about the new cpu */
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index ff30f03beb7c..a6f392dcfeaf 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -94,7 +94,7 @@ void sun4d_cpu_pre_online(void *arg)
 	show_leds(cpuid);
=20
 	/* Attach to the address space of init_task. */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm =3D &init_mm;
=20
 	local_ops->cache_all();
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 228a6527082d..0ee77f066c9e 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -60,7 +60,7 @@ void sun4m_cpu_pre_online(void *arg)
 			     : "memory" /* paranoid */);
=20
 	/* Attach to the address space of init_task. */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm =3D &init_mm;
=20
 	while (!cpumask_test_cpu(cpuid, &smp_commenced_mask))
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 247a0d9683b2..a3186bb30109 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -387,7 +387,7 @@ void trap_init(void)
 		thread_info_offsets_are_bolixed_pete();
=20
 	/* Attach to the address space of init_task. */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm =3D &init_mm;
=20
 	/* NOTE: Other cpus have this done as they are started
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index a850dccd78ea..b6e46732fa69 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2929,6 +2929,6 @@ void __init trap_init(void)
 	/* Attach to the address space of init_task.  On SMP we
 	 * do this in smp.c:smp_callin for other cpus.
 	 */
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm =3D &init_mm;
 }
--=20
2.23.0

