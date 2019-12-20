Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADDA1272D8
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2019 02:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLTBhZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Dec 2019 20:37:25 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41740 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLTBhY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Dec 2019 20:37:24 -0500
Received: by mail-pl1-f202.google.com with SMTP id q6so2340675pls.8
        for <linux-arch@vger.kernel.org>; Thu, 19 Dec 2019 17:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=ZRY76nUi493+xuL7Tm0FlcOAyz0Ji1nFyA0Xlgk3AOY=;
        b=J143fqLZK4/lFzYrCfOIl3+2NbBbgVzLDSm4kEMxZktRis7lgreOCdxYJMeKPplkMr
         hSvPqstpn+bS83eJywSg4D1b1NnNaZKth1RGcbxQlbJXzymKqYCrpDhspOdmjZMZJAIa
         EVq6a8wp2BjjNPZhfifKOfE32LIe7ZDb7s537MMfK6RKt8WDX/8AlrlzRPwiyiVL+gdM
         o+H4bB45aiSA0r6k6yUMWDXVt6zN/mn+OF9zD5qopCyG4wLAKpciAbuN1IyLqfDzPqaR
         sK9p/dlPN2mXF3aCcHsGnVmUdCw2leQQMuwTxhXwL7/tkka64TwMlx9H42rQnN2jcNOi
         fntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ZRY76nUi493+xuL7Tm0FlcOAyz0Ji1nFyA0Xlgk3AOY=;
        b=a/uMNJq3ZoKgV+09Ub0ud6Ce74znptJWn0ukWf/HvrouuLLGyf5a9lXZMRkqOQZi33
         gFvKx+oFygw5wHumnDUtFPz3wrtZKW3c6+BmLTVqbGHMu6Q6H0cDwvE9wVscHUJQp3Dn
         pYgsPJATVAPbrARs6Vvz+boPeTG6VnfmkfsaUoLRJ6rHeTfLC7BnDOmT3KeIyUbdxo6d
         hQMaYsd/y+bVRdJ7a+L3Vo1OBB+/AxOAqXFPfhS7jNr1vHxlN5dy0ME8BRMxgOXT1tbJ
         TOa4Cr9EHOWkhHtgpsn3nW2cZhQIvK8M3Tu/ilrjIHYEWsC93XC3j5FD3h10NDCaZop7
         /Uxg==
X-Gm-Message-State: APjAAAUSwMI2EO2gIyttBSVygOVwg9sc6XSWX+phq5Q+wZps5zeOFvVv
        GEOItnenVrH1bLmU/HrK1lPuRwo=
X-Google-Smtp-Source: APXvYqxaNmZqoXs4tYB6snO5BmWk18re5etHg7lWZji+j3yxRsEA601c51JheS86Ob+7tZu24lPAgpI=
X-Received: by 2002:a63:f107:: with SMTP id f7mr12336875pgi.76.1576805843222;
 Thu, 19 Dec 2019 17:37:23 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:36:39 -0800
In-Reply-To: <20191217180152.GO5624@arrakis.emea.arm.com>
Message-Id: <20191220013639.212396-1-pcc@google.com>
Mime-Version: 1.0
References: <20191217180152.GO5624@arrakis.emea.arm.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] arm64: mte: Do not service syscalls after async tag fault
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
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

When entering the kernel after an async tag fault due to a syscall, rather
than for another reason (e.g. preemption), we don't want to service the
syscall as it may mask the tag fault. Rewind the PC to the svc instruction
in order to give a userspace signal handler an opportunity to handle the
fault and resume, and skip all other syscall processing.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
On Tue, Dec 17, 2019 at 10:01 AM Catalin Marinas <catalin.marinas@arm.com> =
wrote:
>
> On Fri, Dec 13, 2019 at 05:43:15PM -0800, Peter Collingbourne wrote:
> > On Wed, Dec 11, 2019 at 10:44 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > > index dd2cdc0d5be2..41fae64af82a 100644
> > > --- a/arch/arm64/kernel/signal.c
> > > +++ b/arch/arm64/kernel/signal.c
> > > @@ -730,6 +730,9 @@ static void setup_return(struct pt_regs *regs, st=
ruct k_sigaction *ka,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs->regs[29] =3D (unsigned long)&user->=
next_frame->fp;
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs->pc =3D (unsigned long)ka->sa.sa_han=
dler;
> > >
> > > + =C2=A0 =C2=A0 =C2=A0 /* TCO (Tag Check Override) always cleared for=
 signal handlers */
> > > + =C2=A0 =C2=A0 =C2=A0 regs->pstate &=3D ~PSR_TCO_BIT;
> > > +
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ka->sa.sa_flags & SA_RESTORER)
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sigtramp =3D =
ka->sa.sa_restorer;
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> > > @@ -921,6 +924,11 @@ asmlinkage void do_notify_resume(struct pt_regs =
*regs,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (thread_flags & _TIF_UPROBE)
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uprobe_notify_resume(regs);
> > >
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (thread_flags & _TIF_MTE_ASYNC_FAULT) {
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_thread_flag(TIF_MTE_ASYNC_FAUL=
T);
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 force_signal_inject(SIGSEGV, SEGV_MT=
EAERR, 0);
> >
> > In the case where the kernel is entered due to a syscall, this will
> > inject a signal, but only after servicing the syscall. This means
> > that, for example, if the syscall is exit(), the async tag check
> > failure will be silently ignored. I can reproduce the problem with the
> > program below:
> [...]
> > This patch fixes the problem for me:
> >
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index 9a9d98a443fc..d0c8918dee00 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -94,6 +94,8 @@ static void el0_svc_common(struct pt_regs *regs, int
> > scno, int sc_nr,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const syscall_fn_t syscall_table[])
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long flags =3D current_thread_info=
()->flags;
> > + =C2=A0 =C2=A0 =C2=A0 if (flags & _TIF_MTE_ASYNC_FAULT)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>
> It needs a bit of thinking. This one wouldn't work if you want to handle
> the signal and resume since it would skip the SVC instruction. We'd need
> at least to do a regs->pc -=3D 4 and probably move it further down in thi=
s
> function.

Okay, how does this look?

Peter

 arch/arm64/kernel/syscall.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 9a9d98a443fc..49ea9bb47190 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -95,13 +95,29 @@ static void el0_svc_common(struct pt_regs *regs, int sc=
no, int sc_nr,
 {
 	unsigned long flags =3D current_thread_info()->flags;
=20
-	regs->orig_x0 =3D regs->regs[0];
-	regs->syscallno =3D scno;
-
 	cortex_a76_erratum_1463225_svc_handler();
 	local_daif_restore(DAIF_PROCCTX);
 	user_exit();
=20
+#ifdef CONFIG_ARM64_MTE
+	if (flags & _TIF_MTE_ASYNC_FAULT) {
+		/*
+		 * We entered the kernel after an async tag fault due to a
+		 * syscall, rather than for another reason (e.g. preemption).
+		 * In this case, we don't want to service the syscall as it may
+		 * mask the tag fault. Rewind the PC to the svc instruction in
+		 * order to give a userspace signal handler an opportunity to
+		 * handle the fault and resume, and skip all other syscall
+		 * processing.
+		 */
+		regs->pc -=3D 4;
+		return;
+	}
+#endif
+
+	regs->orig_x0 =3D regs->regs[0];
+	regs->syscallno =3D scno;
+
 	if (has_syscall_work(flags)) {
 		/* set default errno for user-issued syscall(-1) */
 		if (scno =3D=3D NO_SYSCALL)
--=20
2.24.1.735.g03f4e72817-goog

