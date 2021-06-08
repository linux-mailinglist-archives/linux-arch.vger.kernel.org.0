Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D539ECD5
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 05:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhFHDRa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 23:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFHDR3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 23:17:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA8C061574;
        Mon,  7 Jun 2021 20:15:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k5so11068133pjj.1;
        Mon, 07 Jun 2021 20:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=7QJgmeOZHxm1wlCHFZhavmAZLKz2FF5Hv428G3b4qiw=;
        b=VTIEVOTLyXhOQe/MeRuSpN2ald0aymOH2UckQUkbGDMCnIWpLofhC3CcsWGO6G81jD
         rWunxyEAy2ZhgLcYR00X4AbEZk1j5BC/8NcRbdVVuKOD8+KnUn4/TCpILr7C32XqRToY
         sin0OyeSbpzbkoBpqneBi8GdLH2Z7/N18b3kF0Ps+Lk4MDwRPpFjSfRySdvw6C4c1DfX
         Van3r+hqrc3s2QAHIpTEOn5FTzL+QTW3T7TGMuWjY6i4MKtL9dFITUqB5EOQSBq4DvSD
         6h+x27wIC4NFr5GL5Id6MGuwBKIi02sjXx+buHb6JeURZXK6LtzNm0Ul+ax1Ar08t1bR
         Sqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=7QJgmeOZHxm1wlCHFZhavmAZLKz2FF5Hv428G3b4qiw=;
        b=f1eyr7J9KzYKqLMiRvyC0+Jv9YIf3zDquGSMgcpwyG5zrpFF6VfBIDlQDj4n6C4lij
         ObIbARIYhNXFQx2zimlzR7FhsntAI85GVoMiJU8TqcX/Q/xewOu9ZqfHyHsa1sNJls5T
         rbHMgNdlCEWUCZRoaQPzSlUfDAwlKSxSKB2bf4VcR6q7g+k5Ckry8N8sazk28P74wEuj
         0eruQk5rKAzDHYNPMjwA7TCTJMAGtX5AyNRs18eQ9x07bVUpLzmLssoXIg/LRc4Z1PgC
         s8bRuaNWh6FIb/14oyatqNraPqjI3EgfTYBNwpVnlzqjGMIa/SARjYtCdxd+OeeuWV19
         DpVg==
X-Gm-Message-State: AOAM533/MnGl/BmikYZqdFDupC+4k9oTB/LkIc7bfefONe8FNtdP1+Mw
        8r6vsvZBmYGptD0J3sXu/sU=
X-Google-Smtp-Source: ABdhPJyEpZ9jHgeUSsOnRiilTupzYo+aah3Y5D06OH682oRgr8S6Jdcc4g/fCCW+4iV8GPHoxi4iMw==
X-Received: by 2002:a17:90b:46c3:: with SMTP id jx3mr16570209pjb.206.1623122137531;
        Mon, 07 Jun 2021 20:15:37 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id z17sm9264539pfq.218.2021.06.07.20.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 20:15:37 -0700 (PDT)
Date:   Tue, 08 Jun 2021 13:15:32 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 3/4] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-4-npiggin@gmail.com>
In-Reply-To: <20210605014216.446867-4-npiggin@gmail.com>
MIME-Version: 1.0
Message-Id: <1623121901.mszkmmum0n.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of June 5, 2021 11:42 am:
> On big systems, the mm refcount can become highly contented when doing
> a lot of context switching with threaded applications (particularly
> switching between the idle thread and an application thread).
>=20
> Abandoning lazy tlb slows switching down quite a bit in the important
> user->idle->user cases, so instead implement a non-refcounted scheme
> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
> any remaining lazy ones.
>=20
> Shootdown IPIs are some concern, but they have not been observed to be
> a big problem with this scheme (the powerpc implementation generated
> 314 additional interrupts on a 144 CPU system during a kernel compile).
> There are a number of strategies that could be employed to reduce IPIs
> if they turn out to be a problem for some workload.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Update the comment to be clearer, and account for the improvement
to MMU_LAZY_TLB_REFCOUNT comment.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2ad1a505ca55..cf468c9777d8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -433,15 +433,16 @@ config MMU_LAZY_TLB_REFCOUNT
 	def_bool y
 	depends on !MMU_LAZY_TLB_SHOOTDOWN
=20
-# Instead of refcounting the lazy mm struct for kernel thread references
-# (which can cause contention with multi-threaded apps on large multiproce=
ssor
-# systems), this option causes __mmdrop to IPI all CPUs in the mm_cpumask =
and
-# switch to init_mm if they were using the to-be-freed mm as the lazy tlb.=
 To
-# implement this, architectures must use _lazy_tlb variants of mm refcount=
ing
-# when releasing kernel thread mm references, and mm_cpumask must include =
at
-# least all possible CPUs in which the mm might be lazy, at the time of th=
e
-# final mmdrop. mmgrab/mmdrop in arch/ code must be switched to _lazy_tlb
-# postfix as necessary.
+# This option allows MMU_LAZY_TLB_REFCOUNT=3Dn. It ensures no CPUs are usi=
ng an
+# mm as a lazy tlb beyond its last reference count, by shooting down these
+# users before the mm is deallocated. __mmdrop() first IPIs all CPUs that =
may
+# be using the mm as a lazy tlb, so that they may switch themselves to usi=
ng
+# init_mm for their active mm. mm_cpumask(mm) is used to determine which C=
PUs
+# may be using mm as a lazy tlb mm.
+#
+# To implement this, an arch must ensure mm_cpumask(mm) contains at least =
all
+# possible CPUs in which the mm is lazy, and it must meet the requirements=
 for
+# MMU_LAZY_TLB_REFCOUNT=3Dn (see above).
 config MMU_LAZY_TLB_SHOOTDOWN
 	bool
=20
--=20
2.23.0

