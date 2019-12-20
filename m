Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCE127306
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2019 02:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLTBtW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Dec 2019 20:49:22 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:51330 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLTBtW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Dec 2019 20:49:22 -0500
Received: by mail-yw1-f73.google.com with SMTP id a16so5522693ywa.18
        for <linux-arch@vger.kernel.org>; Thu, 19 Dec 2019 17:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=HZMnRQf2RzyKu0EQDfD1pRubT2qoNtln9gX9VZl7+Lw=;
        b=QnD2X8ugKAM+uICpb7uuNo+E46l8sDMOx9E2HllXNNfZ3iUHNx7MEf5Cn0GjUwfRTd
         OKLau0tl6dua5duaimUEqxFDkRJkuWXPc1v3yiTigDeXisZZhWPRv1M51ulShTut74/0
         ma4/kaNbkejRaCDbNXrYqFSVIMW6S7OmDHydlpWtXpRIAnu59Prcrx0HfLn2aunMypwl
         V/jocBvh3oyonQOMr0+IlqC4PufPaZsPxYCPTQvKCuf8MX3m8fwh0Yhq6AU39rgKPAN0
         9TRM3nrbL70rMxgLnlQHhKSO+5WtC9JO6YIi9gIZROJcL/Yc3wkGv5PENac6siscxMHp
         TN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=HZMnRQf2RzyKu0EQDfD1pRubT2qoNtln9gX9VZl7+Lw=;
        b=Xan57yUn9cdCPJJQgYwDaQjOz6PArMSmw059V+aAGTKW+Q2g5y0y7gwqddT1KiXgVY
         1HFKtMNaas+nIIBNslLUJ5MzB2x8G2boAYQVOyvcrMaMey8ziNLXP4wOkJFuyFazZtyn
         XB6ZOBG8WIZHaXUnFMhhl+8IPkd89of8hZYQ5BhQP7IJiLAhH6BL+PSc8uqbae7EJS15
         gS0pAhm2e/K5eGXFk5JPXGYxfO+RYt9L2fDnqF7lsPjV9DofLzcnJLA0vo4PDT8a+dIb
         s3p+cdwcDOst32im0L8bdp3T/UW004oGrof5DrRs92lMay9KUjfMrVCzc1zYHAiw7lrM
         kDCQ==
X-Gm-Message-State: APjAAAX2WIbi0oDxigfoWUWPLyOWSOruf3ointJ6OUkKV2ibap7GPXi6
        XwZ6ouedqzURSNu/pH9Mr8maznY=
X-Google-Smtp-Source: APXvYqzIKCMr5RBHVty3PxKkUeb+z/z35I8hFPiVh8D2zq2tXjZ8EsxBxsgexdyHh/iBIMSJ8f2vGqE=
X-Received: by 2002:a81:618a:: with SMTP id v132mr9055009ywb.388.1576806560029;
 Thu, 19 Dec 2019 17:49:20 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:48:53 -0800
In-Reply-To: <CAMn1gO4iv1FsxV+aR3CgU=jgmVjHL0YQF-xJJG0UMv3nJZnOBw@mail.gmail.com>
Message-Id: <20191220014853.223389-1-pcc@google.com>
Mime-Version: 1.0
References: <CAMn1gO4iv1FsxV+aR3CgU=jgmVjHL0YQF-xJJG0UMv3nJZnOBw@mail.gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] arm64: mte: Clear SCTLR_EL1.TCF0 on exec
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
On Thu, Dec 19, 2019 at 12:32 PM Peter Collingbourne <pcc@google.com> wrote=
:
>
> On Wed, Dec 11, 2019 at 10:45 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > + =C2=A0 =C2=A0 =C2=A0 if (current->thread.sctlr_tcf0 !=3D next->thread=
.sctlr_tcf0)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_sctlr_el1_tcf=
0(next->thread.sctlr_tcf0);
>
> I don't entirely understand why yet, but I've found that this check is
> insufficient for ensuring consistency between SCTLR_EL1.TCF0 and
> sctlr_tcf0. In my Android test environment with some processes having
> sctlr_tcf0=3DSCTLR_EL1_TCF0_SYNC and others having sctlr_tcf0=3D0, I am
> seeing intermittent tag failures coming from the sctlr_tcf0=3D0
> processes. With this patch:
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index ef3bfa2bf2b1..4e5d02520a51 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -663,6 +663,8 @@ static int do_sea(unsigned long addr, unsigned int
> esr, struct pt_regs *regs)
> =C2=A0static int do_tag_check_fault(unsigned long addr, unsigned int esr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pt_regs *regs)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "do_tag_check_fault %lx %lx\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current->thread.sctlr_t=
cf0, read_sysreg(sctlr_el1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_bad_area(addr, esr, regs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> =C2=A0}
>
> I see dmesg output like this:
>
> [ =C2=A0 15.249216] do_tag_check_fault 0 c60fc64791d
>
> showing that SCTLR_EL1.TCF0 became inconsistent with sctlr_tcf0. This
> patch fixes the problem for me:
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index fba89c9f070b..fb012f0baa12 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -518,9 +518,7 @@ static void mte_thread_switch(struct task_struct *nex=
t)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!system_supports_mte())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>
> - =C2=A0 =C2=A0 =C2=A0 /* avoid expensive SCTLR_EL1 accesses if no change=
 */
> - =C2=A0 =C2=A0 =C2=A0 if (current->thread.sctlr_tcf0 !=3D next->thread.s=
ctlr_tcf0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_sctlr_el1_tcf0(=
next->thread.sctlr_tcf0);
> + =C2=A0 =C2=A0 =C2=A0 update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_gcr_el1_excl(next->thread.gcr_excl);
> =C2=A0}
> =C2=A0#else
> @@ -643,15 +641,8 @@ static long set_mte_ctrl(unsigned long arg)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> - =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* mte_thread_switch() checks current->thread=
.sctlr_tcf0 as an
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* optimisation. Disable preemption so that i=
t does not see
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* the variable update before the SCTLR_EL1.T=
CF0 one.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 preempt_disable();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 current->thread.sctlr_tcf0 =3D tcf0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_sctlr_el1_tcf0(tcf0);
> - =C2=A0 =C2=A0 =C2=A0 preempt_enable();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 current->thread.gcr_excl =3D (arg & PR_MTE_EX=
CL_MASK) >>
> PR_MTE_EXCL_SHIFT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_gcr_el1_excl(current->thread.gcr_excl)=
;
>
> Since sysreg_clear_set only sets the sysreg if it ended up changing, I
> wouldn't expect this to cause a significant performance hit unless
> just reading SCTLR_EL1 is expensive. That being said, if the
> inconsistency is indicative of a deeper problem, we should probably
> address that.

I tracked it down to the flush_mte_state() function setting sctlr_tcf0 but
failing to update SCTLR_EL1.TCF0. With this patch I am not seeing any more
inconsistencies.

Peter

 arch/arm64/kernel/process.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index fba89c9f070b..07e8e7bd3bec 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -319,6 +319,25 @@ static void flush_tagged_addr_state(void)
 }
=20
 #ifdef CONFIG_ARM64_MTE
+static void update_sctlr_el1_tcf0(u64 tcf0)
+{
+	/* no need for ISB since this only affects EL0, implicit with ERET */
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCF0_MASK, tcf0);
+}
+
+static void set_sctlr_el1_tcf0(u64 tcf0)
+{
+	/*
+	 * mte_thread_switch() checks current->thread.sctlr_tcf0 as an
+	 * optimisation. Disable preemption so that it does not see
+	 * the variable update before the SCTLR_EL1.TCF0 one.
+	 */
+	preempt_disable();
+	current->thread.sctlr_tcf0 =3D tcf0;
+	update_sctlr_el1_tcf0(tcf0);
+	preempt_enable();
+}
+
 static void flush_mte_state(void)
 {
 	if (!system_supports_mte())
@@ -327,7 +346,7 @@ static void flush_mte_state(void)
 	/* clear any pending asynchronous tag fault */
 	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
 	/* disable tag checking */
-	current->thread.sctlr_tcf0 =3D 0;
+	set_sctlr_el1_tcf0(0);
 }
 #else
 static void flush_mte_state(void)
@@ -497,12 +516,6 @@ static void ssbs_thread_switch(struct task_struct *nex=
t)
 }
=20
 #ifdef CONFIG_ARM64_MTE
-static void update_sctlr_el1_tcf0(u64 tcf0)
-{
-	/* no need for ISB since this only affects EL0, implicit with ERET */
-	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCF0_MASK, tcf0);
-}
-
 static void update_gcr_el1_excl(u64 excl)
 {
 	/*
@@ -643,15 +656,7 @@ static long set_mte_ctrl(unsigned long arg)
 		return -EINVAL;
 	}
=20
-	/*
-	 * mte_thread_switch() checks current->thread.sctlr_tcf0 as an
-	 * optimisation. Disable preemption so that it does not see
-	 * the variable update before the SCTLR_EL1.TCF0 one.
-	 */
-	preempt_disable();
-	current->thread.sctlr_tcf0 =3D tcf0;
-	update_sctlr_el1_tcf0(tcf0);
-	preempt_enable();
+	set_sctlr_el1_tcf0(tcf0);
=20
 	current->thread.gcr_excl =3D (arg & PR_MTE_EXCL_MASK) >> PR_MTE_EXCL_SHIF=
T;
 	update_gcr_el1_excl(current->thread.gcr_excl);
--=20
2.24.1.735.g03f4e72817-goog

