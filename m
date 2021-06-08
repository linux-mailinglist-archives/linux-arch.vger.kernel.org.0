Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D962D39ED68
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 06:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhFHENN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 00:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhFHENN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jun 2021 00:13:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05914C061574;
        Mon,  7 Jun 2021 21:11:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c13so9946315plz.0;
        Mon, 07 Jun 2021 21:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=fujJUO0q2KI09Gf2Ts/MK4OrEH1MH3pS5M4uIA8d5KY=;
        b=tcYZlrbvJ6bwWx5hOtunH5FlXCQSIc1mB7bzpNZe23fnuXN0P1B9qK3liym3q2fqMF
         TUBPyWK1ZOMpCS5yddkJ84bAoIVftpAefDggUsr/uTdyBxgzLoSfNQgO8rOiBSXxqygT
         GFbGXnJNu5IgI+IGstU3e+dbZmSTU3+aKi63tb64KMuXH0FHCXbVV3RvKJg36CCH1FMk
         IKqtLtxeEw6JgGPC948jypG9g07rOnFHiNY01N8t+NBzZqm0DAIvsdbIQqiGg0jLoAB9
         iXjAI2gZS5Du/dCK9shEQibTPfE88qR6UO3ZkZNZMTDFXB7KAlo11gDoRr6gyUtrDQRk
         cREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=fujJUO0q2KI09Gf2Ts/MK4OrEH1MH3pS5M4uIA8d5KY=;
        b=lyp0nEeugNPQDkSNoB5i8cCpGK4eF+7B+XHv+gPeapeVnGkRsNbayHWnhNuHCLYbPs
         NX3BeQfEjiwQJFKjXND/07u2gQq3+0eqN9Iv6pYu2fW7VJKhijxpQyhql76qSKDukser
         6h0HjFSc7ls9l5ttt/6hvRf+TJ1E8Vsz9e2cx/mZ2bEb5q9Mn7u8Rl38P7UoWYMJIULH
         zMmbw+h79yZYxg/kWqw+/sUpxSd5mdYYjo3ytwMvOK6C25JxydrMC7CN5rY6mFJb/w0F
         alfz4luD5q6E5iLEwNa0iFSy8FrP3fVw4jkd5gXp1MxxierDG3prd08jQkj9J8+HNea0
         Yp9w==
X-Gm-Message-State: AOAM531iSXMFwg05ph41Rzo5KuIiv7ziY2R8H6tqoei6iyyDubWwvk+l
        afGaD8hvg1EUEB5gS1iNhPQ=
X-Google-Smtp-Source: ABdhPJxfxri2+uhmnYtzY5IcP7B7q38QCMIjrONmVg0s3CUrHRF1z33+8Ff6Hymls1OmPLXdOM7vxA==
X-Received: by 2002:a17:90a:8b0d:: with SMTP id y13mr4219564pjn.88.1623125469552;
        Mon, 07 Jun 2021 21:11:09 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id w79sm2876301pff.21.2021.06.07.21.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:11:09 -0700 (PDT)
Date:   Tue, 08 Jun 2021 14:11:04 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 1/4] lazy tlb: introduce lazy mm refcount helper
 functions
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>,
        =?iso-8859-1?q?Randy=0A?= Dunlap <rdunlap@infradead.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-2-npiggin@gmail.com>
        <20210607164934.d453adcc42473e84beb25db3@linux-foundation.org>
        <1623116020.vyls9ehp49.astroid@bobo.none>
        <20210607184805.eddf8eb26b80e8af85d5777e@linux-foundation.org>
In-Reply-To: <20210607184805.eddf8eb26b80e8af85d5777e@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1623125298.bx63h3mopj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andrew Morton's message of June 8, 2021 11:48 am:
> On Tue, 08 Jun 2021 11:39:56 +1000 Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> > Looks like a functional change.  What's happening here?
>>=20
>> That's kthread_use_mm being clever about the lazy tlb mm. If it happened=
=20
>> that the kthread had inherited a the lazy tlb mm that happens to be the=20
>> one we want to use here, then we already have a refcount to it via the=20
>> lazy tlb ref.
>>=20
>> So then it doesn't have to touch the refcount, but rather just converts
>> it from the lazy tlb ref to the returned reference. If the lazy tlb mm
>> doesn't get a reference, we can't do that.
>=20
> Please cover this in the changelog and perhaps a code comment.
>=20

Yeah fair enough, I'll even throw in a bug fix as well (your nose was right=
,=20
and it was too clever for me by half...)

Thanks,
Nick

--
Fix a refcounting bug in kthread_use_mm (the mm reference is increased
unconditionally now, but the lazy tlb refcount is still only dropped only
if mm !=3D active_mm).

And an update for the changelog:

If a kernel thread's current lazy tlb mm happens to be the one it wants to
use, then kthread_use_mm() cleverly transfers the mm refcount from the
lazy tlb mm reference to the returned reference. If the lazy tlb mm
reference is no longer identical to a normal reference, this trick does not
work, so that is changed to be explicit about the two references.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/kthread.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index b70e28431a01..5e9797b2d06e 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1314,6 +1314,11 @@ void kthread_use_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
=20
+	/*
+	 * It's possible that tsk->active_mm =3D=3D mm here, but we must
+	 * still mmgrab(mm) and mmdrop_lazy_tlb(active_mm), because lazy
+	 * mm may not have its own refcount (see mmgrab/drop_lazy_tlb()).
+	 */
 	mmgrab(mm);
=20
 	task_lock(tsk);
@@ -1338,12 +1343,9 @@ void kthread_use_mm(struct mm_struct *mm)
 	 * memory barrier after storing to tsk->mm, before accessing
 	 * user-space memory. A full memory barrier for membarrier
 	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
-	 * mmdrop(), or explicitly with smp_mb().
+	 * mmdrop_lazy_tlb().
 	 */
-	if (active_mm !=3D mm)
-		mmdrop_lazy_tlb(active_mm);
-	else
-		smp_mb();
+	mmdrop_lazy_tlb(active_mm);
=20
 	to_kthread(tsk)->oldfs =3D force_uaccess_begin();
 }
--=20
2.23.0

