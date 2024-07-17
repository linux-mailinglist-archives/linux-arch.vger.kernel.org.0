Return-Path: <linux-arch+bounces-5451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10849337B0
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 09:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45687284637
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 07:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506621B28A;
	Wed, 17 Jul 2024 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lM5UPU7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dcqK+/Vp"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217810A19;
	Wed, 17 Jul 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200740; cv=none; b=PrLBmvNAUPYB8JPyzQcy9VvHDbmeC+8uIYSXykGYCatbjWpCbCuGKVugK+1j1Y1OqQRkWZMUm5IJfmda9NYWZIcxs3ikfu+A4rK2/4ECCL1lYExWAUuOVUWoG/ZsciLO4D4Eid4krtATCdbS41XdHvwKUPnugy+6wnOpyMKfmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200740; c=relaxed/simple;
	bh=7PaaGe8nbz1zISpPoYX/H9K+UT7ygtmRKsOFHz497zk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IIKTG2+urqVOcdYSiJK+sniVUQ/N03Uw3g3EAVWAfgFJZ7E0GXwUpJo1NUYKj/D3isYJPq5LsbIr4ChU1BX8FATMETJ3+pzIdzdA6WoF4RI87WeTqbnKE7UvJ2MyqqXyjngyeQF+q1IDCrLh5gyNz79pBj5PzJf4Wezk4BG6vqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lM5UPU7h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dcqK+/Vp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5F2341380363;
	Wed, 17 Jul 2024 03:18:56 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Wed, 17 Jul 2024 03:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721200736; x=1721287136; bh=dVPCdXoCdl
	fuyxQFCO6tR60KWH2cIVkXd2rdl5L6JqE=; b=lM5UPU7h2Gq1rDOJG6qFaYML4f
	WUGnNEzzA+AYF8qAHUk85HSVSwDB1RzWoxMCLbYobLM5URqk0zFWW8X++y+v/f9U
	hkdgH7E8AoHUc7CvidcNMcTykk8kGgXrpkpX37TcNTmIRRyaV5AEtPW7f770Qt1k
	BF3z602UqV2IYxHY4STREyKbOx8ADlXK2GCy7P7+VpQpUZ9UCkj9spKsMBOoy65X
	0X5GvUN5OC7Tqk8By3EojwaJoVTG8nD6y4Kr9q/VOqiRJ9SHE4btUE96UHkezzFS
	D75znMHiptX6Wf6evkVzTNS5DFQ5SunudahqQZkefdwbgxB5mUT+oNmd3UwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721200736; x=1721287136; bh=dVPCdXoCdlfuyxQFCO6tR60KWH2c
	IVkXd2rdl5L6JqE=; b=dcqK+/VpvAT5m8FFZ9SAjVK2TWAvP5Gmhhf4aBWHlZuR
	g4NxLayfnuwlG9N9dRGexf+qvsQ746FlSfoeyWVJDB1xNBepXehBJIKlIXer4Tl6
	G8A3doOYJLmzbAzTf806hgrRiEp3fFY1IKBCa62ybQlwTvNS2ZcamzEgf91c5gfD
	dO5aMTqitBINe53zPn5AdBvlBuKtS6evhiK4Lnzv3o2jFZvzGQyZHkpCsFBNiiy+
	zNgbmQQZZVX4nfXU3T1j2gVkdosYyJgMGTndHA/QUdBMllHVzTydeJNhJ1L8+SqD
	IX9BcxNgED7E/fFP2+5/0hylgld7OhAx2pQlMlEUOA==
X-ME-Sender: <xms:X3CXZnkS4MySrDCNJmdRSbgJyYIiXKvq7vTVgK1SiDA3QTfmf0c2sA>
    <xme:X3CXZq2vgskOCgv-9iBuU9y29xVihAmW1Fda2e0ObVvE8bZh3H0AkYthBE8ABQrch
    g28sGCeeHNJS2dVOD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeehgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:X3CXZtqSVif7SXVane0MA2st5Alch9esIxtR04_W7jQ6Z5-CfqJ8Rw>
    <xmx:X3CXZvnOpznvZfVxzrvuH0-Iw9XfPBLiKzQDuTLBs0MGK4aI2fuL-A>
    <xmx:X3CXZl2aNkhPgdY4Yh0rjLq3shhuUxaQlFFYEcfEmZ6nemGgSGK1GA>
    <xmx:X3CXZuvjkUJuFk4zxEkx21K4CdLiPeJWSjfA17bC8ZgVrAHBI3gnmw>
    <xmx:YHCXZvyfIjmJ1IWmNAQLtesNHzDXM32lg7kvkZ5JoEyfkXqInb12K5Qn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 01FBD19C005F; Wed, 17 Jul 2024 03:18:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dfa20cd0-03d4-4178-a343-6387dd884e72@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
 <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
 <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
Date: Wed, 17 Jul 2024 09:18:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Masahiro Yamada" <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org
Subject: Re: [GIT PULL] asm-generic updates for 6.11
Content-Type: text/plain

On Wed, Jul 17, 2024, at 07:08, Linus Torvalds wrote:
> On Tue, 16 Jul 2024 at 21:57, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>   ./arch/arm64/include/generated/uapi/asm/unistd_64.h
>   ./arch/arm64/include/generated/asm/syscall_table_32.h
>   ./arch/arm64/include/generated/asm/syscall_table_64.h
>   ./arch/arm64/include/generated/asm/unistd_32.h
>   ./arch/arm64/include/generated/asm/unistd_compat_32.h
>   ./include/generated/autoconf.h
>   ./usr/include/asm/unistd_64.h
>

I've tried to come up with a patch that avoids including
asm/unistd.h in most files, which would give some relief
and hopefully let you get through the merge window in 
case we can't figure out my Makefile bug quickly.

It's only a small drop in the ocean of excessive header
inclusions, but it's still a step in the right direction
I think. I'll do some more testing on other architectures
with this patch so I can send you something that works.

You can also just revert the three arm64 commits for now

d2a4a07190f4 arm64: rework compat syscall macros
e632bca07c8e arm64: generate 64-bit syscall.tbl
7fe33e9f662c arm64: convert unistd_32.h to syscall.tbl format

since the patch to remove uapi/asm-generic/unistd.h
wasn't part of the 6.11 series yet and nothing else
depends on the arm64 conversion.

      Arnd

 extern const unsigned long sys_call_table[];
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index f08408b6e826..274b67f02f3e 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -13,7 +13,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/syscalls.h>
+#include <linux/syscalls_api.h>
 
 #include <asm/cpufeature.h>
 #include <asm/syscall.h>
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..9a535916dc03 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -92,6 +92,7 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
+#include <linux/syscalls_api.h>
 #include <linux/posix-timers.h>
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index e6c00e860951..5144b80027be 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -3,7 +3,6 @@
 #define _LINUX_BINFMTS_H
 
 #include <linux/sched.h>
-#include <linux/unistd.h>
 #include <asm/exec.h>
 #include <uapi/linux/binfmts.h>
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 56cebaff0c91..89c307da6e5d 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -17,7 +17,6 @@
 #include <linux/fs.h>
 #include <linux/aio_abi.h>	/* for aio_context_t */
 #include <linux/uaccess.h>
-#include <linux/unistd.h>
 
 #include <asm/compat.h>
 #include <asm/siginfo.h>
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 90507d4afcd6..f1ddc1eb9290 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -9,13 +9,6 @@
 #include <linux/bug.h>			/* For BUG_ON.  */
 #include <linux/pid_namespace.h>	/* For task_active_pid_ns.  */
 #include <uapi/linux/ptrace.h>
-#include <linux/seccomp.h>
-
-/* Add sp to seccomp_data, as seccomp is user API, we don't want to modify it */
-struct syscall_info {
-	__u64			sp;
-	struct seccomp_data	data;
-};
 
 extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 			    void *buf, int len, unsigned int gup_flags);
@@ -397,8 +390,6 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #define exception_ip(x) instruction_pointer(x)
 #endif
 
-extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
-
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);
 
 /*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fff820c3e93e..2613b8f264bb 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -86,7 +86,6 @@ struct mnt_id_req;
 #include <linux/bug.h>
 #include <linux/sem.h>
 #include <asm/siginfo.h>
-#include <linux/unistd.h>
 #include <linux/quota.h>
 #include <linux/key.h>
 #include <linux/personality.h>
diff --git a/include/linux/syscalls_api.h b/include/linux/syscalls_api.h
index 23e012b04db4..bf997576453f 100644
--- a/include/linux/syscalls_api.h
+++ b/include/linux/syscalls_api.h
@@ -1 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _LINUX_SYSCALLS_API_H
+#define _LINUX_SYSCALLS_API_H
+
 #include <linux/syscalls.h>
+#include <linux/seccomp.h>
+#include <asm/syscall.h>
+
+/* Add sp to seccomp_data, as seccomp is user API, we don't want to modify it */
+struct syscall_info {
+	__u64			sp;
+	struct seccomp_data	data;
+};
+
+extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
+
+#endif
diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 8e193f3a33b3..0dfe926e70df 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -3,7 +3,6 @@
 #define _TRACE_SYSCALL_H
 
 #include <linux/tracepoint.h>
-#include <linux/unistd.h>
 #include <linux/trace_events.h>
 #include <linux/thread_info.h>
 
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 33d8c9f4aa6b..523a53f12d4f 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -11,7 +11,6 @@
 
 #include <linux/stddef.h>
 #include <linux/types.h>
-#include <linux/unistd.h>
 
 /**
  * struct lsm_ctx - LSM context information
diff --git a/kernel/exit.c b/kernel/exit.c
index be81342caf1b..a78a6e97615a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -13,6 +13,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/seccomp.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/capability.h>
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d5f89f9ef29f..1067da7a8409 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -14,6 +14,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
+#include <linux/seccomp.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
diff --git a/lib/syscall.c b/lib/syscall.c
index 006e256d2264..5fb67b3699b9 100644
--- a/lib/syscall.c
+++ b/lib/syscall.c
@@ -3,7 +3,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/export.h>
-#include <asm/syscall.h>
+#include <linux/syscalls_api.h>
 
 static int collect_syscall(struct task_struct *target, struct syscall_info *info)
 {

