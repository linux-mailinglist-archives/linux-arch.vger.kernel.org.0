Return-Path: <linux-arch+bounces-926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1890480F5DB
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 19:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD037281BD0
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5CC10F5;
	Tue, 12 Dec 2023 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="iJMGTlir"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4D791;
	Tue, 12 Dec 2023 10:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702407328; x=1703012128; i=rwahl@gmx.de;
	bh=IHz6BQHqma+jxYrd5WICx4pHCK4/jGS4y2B8Mb5NueA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=iJMGTlirtY6EwqRCUDDUytisGkGaTEkGc2xIs92K+4mHLlzpSn9JR8M29/9B0Fu8
	 nJqik5TOJWK29NxrtBEJ0DMNxZVvpzQQbGMD0GYubuVKCh87mYKxbLAzsPhJDcw6r
	 o4gMCRl8EthKiJR+swscGVmzPgOAidF01AS6h9lcPu50Oehz1MyUFugPhq2EWcEph
	 2puqjToyhWwIRPGJGOY/qJQbP/gkkJ2jFk/9AmiTOWouEMQMkHmqsDcSyjlqSlz6W
	 a9s6cpGyejjrLzp74HfL2Ck6PBACAeGnWnXWFVN31k8jIkHyIb/A07jjPWjd46Fs6
	 CKg6b956VwqCw/nh5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.159.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1rU5zt44zO-00upKL; Tue, 12
 Dec 2023 19:55:28 +0100
From: Ronald Wahl <rwahl@gmx.de>
To: rwahl@gmx.de
Cc: linux-kernel@vger.kernel.org,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH v2] stacktrace: check whether task has a stack before saving it
Date: Tue, 12 Dec 2023 19:55:18 +0100
Message-ID: <20231212185518.196361-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MB/WDCtYiYHNxM9BLr5WR3PDMxWmJZB7ojtx/agcyB0R7JgX+36
 TyBUlgGdSmWvf72RA9oPw7pZ9gI7tbVV9jCASAEJVTDm6jDhs4S8DDu+2n5WxwNY7ZIR0cs
 mdE6NAOHRlRPRPGEcBmDcEURfiRhn+wp0a5H+JD+7NTVXHJk1ATi/NB3pACNVUiSgMuXibY
 l2ZUECZ5nlNjhFY21tLxA==
UI-OutboundReport: notjunk:1;M01:P0:LPoQ8YsJ1rU=;e6aNZPDKFhUy4iTcSDun21tg8hd
 eN20FW/T7vWbC0Q5r6QOK9gvpQfDwuxOwJsEdEwho53DqQXI43/u3pf0kxoxPauJqV1AN4QxH
 gnrvYSTN3Ppx58pfvYnSXq77e1gLdcWc8yuXmMVUxRdg5ILIALg0mu+TlpMUpdEH8iSVAAVtT
 ORMahscVtRWMi+V1s+HryrwZDtNRRWD/mjVgwoGhAFPsLRJ7QFtNxOlPobbXJHovUcGO/GJjI
 t3Ql2AWjUtgWiOqIasKzEYPzvsk0JjQyLepWwOM5Wffw79/W8OxZfd0Q1gHwAC5ZGT2oSCth/
 1GcH44Z8omHyxpGNlHbLAYUGZmIrCYjGG/4IiMw3JjptdSyRgaFKhU+xBkFJdsfByiX1PuodS
 HSjKCFUCF/CXeujtB76Y63hbxaD8KcsUFUobAjJwo7DYt8osFM67X+4pC0fdSWwPjHEK5uBBD
 a0bYsrsCcK62TWmb6p859t1UZF6G2OQnOXD+keNxRbmLJarj2sSe9G1hc8qLQc20BfFNr9Cbl
 5WvE87Ga5aBxSbdqi8f991N0X2FRWz7DgEInsV5U76Gi3cHqXUtEJWRGKQhcQJp5NrgPzxurr
 nwmLmW4MCJSucWvlAj1jXKlSEfV/LoGHxWbegbbbS+u8TGdkHz1x80t2wOboq8+Y6hLRku6ou
 EqbQSrasGzD8X0uxejnexEo6Tgfuk2gUWYEsiwmBFdaQx2ODli8nNzFslaycJSrifqLN98+ds
 QeJLerrQ1b4ZSvySTn7MwWgiGk15waGixyZwoCKq0LLplqai8j1joJYrFbirTQrrVuMV4Oq5n
 EZRwoiF1CO3CEIunGMokhs9Bg4OKPnovioXQUzP9QQiE+xt5Iai9JntisfUY5zo2T6ODcjhVA
 rs6X8JGjmYaXw2D/rc7ga4F+2CwX9RtcQ4KTQ/Rfs20JKtdROpIwR+FZ17T7E605FJUudhU9/
 FinXk93y28m9gzKvY68WxQ0Zo/Q=

From: Ronald Wahl <ronald.wahl@raritan.com>

I encountered a crash on ARM32 when trying to dump the stack of some
zombie process. This is caused by a missing check whether the task
actually has a valid stack. This commit adds this check.

Commit 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
introduced this check for platforms that define CONFIG_ARCH_STACKWALK
but ARM32 is not one of them.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
V2: - added missing put_task_stack(task) to avoid memory leak

 kernel/stacktrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 9ed5ce989415..0bb67bd633c6 100644
=2D-- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -298,7 +298,11 @@ unsigned int stack_trace_save_tsk(struct task_struct =
*task,
 		.skip	=3D skipnr + (current =3D=3D task),
 	};

+	if (!try_get_task_stack(task))
+		return 0;
+
 	save_stack_trace_tsk(task, &trace);
+	put_task_stack(task);
 	return trace.nr_entries;
 }

=2D-
2.43.0


