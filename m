Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7050339C9F0
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEQz4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 12:55:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:36119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhFEQz4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Jun 2021 12:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622912003;
        bh=otmxS+gVRgDAzJeQxOs2w6E0luu3FW83ow2bhZxo5gQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G5KbARdHQQQgNxI2FJvfcRscUaHQrno2MD/rSTc1sOcDqCu+W2cSs5q7ODICA39oD
         OX18lDrwumasVhPx8MmJgy/v1yAcCg5E6HR2RS7KuVMY2nHwnEdRk2rM/FiE+jBvQo
         rCDAPt4XCpFD+aQ+AwHw6aJ6q/Zx9R7lOf/L0lM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MAfYw-1leWwF0r1M-00B0Vt; Sat, 05 Jun 2021 18:53:23 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     John Wood <john.wood@gmx.com>, Andi Kleen <ak@linux.intel.com>,
        valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v8 5/8] security/brute: Notify to userspace "task killed"
Date:   Sat,  5 Jun 2021 17:04:02 +0200
Message-Id: <20210605150405.6936-6-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605150405.6936-1-john.wood@gmx.com>
References: <20210605150405.6936-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uMv9ak4LGcurS/eU8qDGWIbV7ZOGW4XEx+44iIG6e1cPWgqWEGP
 N+VtYyKNxdTodFiZDDUreZ0Lw/IpX7v1VxMLM6ib8SjyCDaE4Glk3bDXlSsJpB0Zkh9Nkgs
 YHAH6jEyjdBBQXDTcpFNrYUrcWXKAiBec3gm7IdiuE3TeWdFaJNdO5/bK2W3GNfylflM/eC
 GcVQPik7Oxw+qmi76Hi8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dBg1cf3l2FQ=:eI4Ff6J8VEeAXIlSK8bfjf
 JvIXuoaFJIwHbWyqbBddFSh61VfbnlACb5DLLeRkKDekuYtqo2z2+Xil6A9aq8M9Af8XKzq15
 PISbhVm6du8fhWAzRvm/kKplKjonR3Ddp0VqF8111vt4tJ2lTymdWB7RjswWHJJZ+lpj2dfyk
 oL2j5jRDyIjzWsLD7zQBA96sUzcfU/RW53vQdaX/i8YNTm2TZnMv6ujs0yQ7vbmwixaBd8cFq
 i/Gh2IKDFb5teFZ58u78Jb2+B0YFfIVJ+Rwwvaiu2zbjgfiyCOTRUfQfxDUHnAkNp0Su/Lq5K
 QQpFanD5gt2g3tEh6S3mVonERL7aFQq4WbqXAQKoGRyS+wcU2o9qnNXjHf3AOrTXMmBb9BnGw
 cam6fX58C+wIH2kWIbgYCyNKvVLyppNt0XNIkI5156zDK3DIHpt4CVEUmXZAZcxHlmJFzywg7
 W3Pca1XU29HSD0u1h3l1MmQmUbNr7ryQSBzW+iEiBO68RmpdhAffDDnETMxFuFVNnaHaBrkj1
 jMEchE3fBTmsB99bmugtYYs63C+5RnswLfyjTJiuuGVrqKdKIWbigjDu6QFjAk23fjw3flu7D
 Do0BxkGxvUVlNox7Kc5CdDhiMcE6H9cSS17O7agVmzpAunYc3DM91vjII3d5FkedJJtXw7BwV
 bNhrTV3UMy2wwjlFRqhEBeDxPyYiQqiV26khAbaVyWF+jH9WWZfkX9/PHIjDFVwoYDk2VvZZ5
 9ufUQ6V1LeeC5StXzgrx88eIKw9KTp84VfT+uVUUK2A4ssNqPAjXjUNkqj/SZO1SXWC6BZxe5
 8ePpfD6brOcPXcB0i1xa06f9JBk2fn8P8NZeBvnYxi3m7zoY/N86odrHJ6ugQlTVQGVdjZu3Y
 Ax9ZFGoBEJ+9ZssMQVgejuWAxbbXTagYVrh7n7BUR6oLSpjJKYrVlzDzaW/qVzS2c8Q+UCnbt
 euj7oKJlO2FMXia604ARVnNV5LjEfo0eAvqFqE1vkGMzEvJK6LAU4pdN9h+0r4n9BV6M7c/Qt
 CezP04VqsBqLbQrYf95Ng9qD0CHNinJYePv8QrU9GnmHKVCzTKCFsMLEo9zq++WButnFNoQED
 so4TOFDtcJqRmv858pVip1oFdB7ggLegj8b
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a new SIGCHLD si_code to notify to userspace, using the "waitid"
system call, that a task has been killed by Brute LSM to mitigate a
brute force attack.

This is useful to supervisors in order to decide if a process that has
been killed to avoid an attack needs to be respawned. This way, it is
possible to avoid the scenario where a brute force attack can be
continued due to the respawn of a process. Although the xattr of the
executable is accessible from userspace, in complex daemons this file
may not be visible directly by the supervisor as it may be run through
some wrapper. So, the waitid notification is necessary.

To achieve this, use the task_struct security blob to hold a flag that
shows when a task has been killed by Brute LSM, and also, test this flag
in the "wait_task_zombie" and "do_notify_parent" functions.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 arch/x86/kernel/signal_compat.c    |  2 +-
 include/brute/brute.h              | 16 ++++++++
 include/uapi/asm-generic/siginfo.h |  3 +-
 kernel/exit.c                      |  6 ++-
 kernel/signal.c                    |  4 +-
 security/brute/brute.c             | 59 +++++++++++++++++++++++++++++-
 6 files changed, 85 insertions(+), 5 deletions(-)
 create mode 100644 include/brute/brute.h

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_comp=
at.c
index 06743ec054d2..d4656f1b6341 100644
=2D-- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -30,7 +30,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGSEGV !=3D 9);
 	BUILD_BUG_ON(NSIGBUS  !=3D 5);
 	BUILD_BUG_ON(NSIGTRAP !=3D 6);
-	BUILD_BUG_ON(NSIGCHLD !=3D 6);
+	BUILD_BUG_ON(NSIGCHLD !=3D 7);
 	BUILD_BUG_ON(NSIGSYS  !=3D 2);

 	/* This is part of the ABI and can never change in size: */
diff --git a/include/brute/brute.h b/include/brute/brute.h
new file mode 100644
index 000000000000..8531a7038711
=2D-- /dev/null
+++ b/include/brute/brute.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BRUTE_H_
+#define _BRUTE_H_
+
+#include <linux/sched.h>
+
+#ifdef CONFIG_SECURITY_FORK_BRUTE
+bool brute_task_killed(const struct task_struct *task);
+#else
+static inline bool brute_task_killed(const struct task_struct *task)
+{
+	return false;
+}
+#endif
+
+#endif /* _BRUTE_H_ */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic=
/siginfo.h
index 5a3c221f4c9d..ffc3ed2d4bce 100644
=2D-- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -274,7 +274,8 @@ typedef struct siginfo {
 #define CLD_TRAPPED	4	/* traced child has trapped */
 #define CLD_STOPPED	5	/* child has stopped */
 #define CLD_CONTINUED	6	/* stopped child has continued */
-#define NSIGCHLD	6
+#define CLD_BRUTE	7	/* child was killed by brute LSM */
+#define NSIGCHLD	7

 /*
  * SIGPOLL (or any other signal without signal specific si_codes) si_code=
s
diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c04193e18..69bcbd00d277 100644
=2D-- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -69,6 +69,8 @@
 #include <asm/unistd.h>
 #include <asm/mmu_context.h>

+#include <brute/brute.h>
+
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
 	nr_threads--;
@@ -1001,6 +1003,7 @@ static int wait_task_zombie(struct wait_opts *wo, st=
ruct task_struct *p)
 	pid_t pid =3D task_pid_vnr(p);
 	uid_t uid =3D from_kuid_munged(current_user_ns(), task_uid(p));
 	struct waitid_info *infop;
+	bool killed_by_brute =3D brute_task_killed(p);

 	if (!likely(wo->wo_flags & WEXITED))
 		return 0;
@@ -1114,7 +1117,8 @@ static int wait_task_zombie(struct wait_opts *wo, st=
ruct task_struct *p)
 			infop->cause =3D CLD_EXITED;
 			infop->status =3D status >> 8;
 		} else {
-			infop->cause =3D (status & 0x80) ? CLD_DUMPED : CLD_KILLED;
+			infop->cause =3D (status & 0x80) ? CLD_DUMPED :
+				killed_by_brute ? CLD_BRUTE : CLD_KILLED;
 			infop->status =3D status & 0x7f;
 		}
 		infop->pid =3D pid;
diff --git a/kernel/signal.c b/kernel/signal.c
index 4380763b3d8d..c85c091ecc27 100644
=2D-- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -55,6 +55,8 @@
 #include <asm/siginfo.h>
 #include <asm/cacheflush.h>

+#include <brute/brute.h>
+
 /*
  * SLAB caches for signal bits.
  */
@@ -2012,7 +2014,7 @@ bool do_notify_parent(struct task_struct *tsk, int s=
ig)
 	if (tsk->exit_code & 0x80)
 		info.si_code =3D CLD_DUMPED;
 	else if (tsk->exit_code & 0x7f)
-		info.si_code =3D CLD_KILLED;
+		info.si_code =3D brute_task_killed(tsk) ? CLD_BRUTE : CLD_KILLED;
 	else {
 		info.si_code =3D CLD_EXITED;
 		info.si_status =3D tsk->exit_code >> 8;
diff --git a/security/brute/brute.c b/security/brute/brute.c
index 4e0fd23990c8..e5c9098addf9 100644
=2D-- a/security/brute/brute.c
+++ b/security/brute/brute.c
@@ -56,6 +56,59 @@ struct brute_raw_stats {
 	u8 flags;
 } __packed;

+/**
+ * struct brute_task - Task info.
+ * @killed: Task killed to mitigate a brute force attack.
+ */
+struct brute_task {
+	u8 killed : 1;
+};
+
+/*
+ * brute_blob_sizes - LSM blob sizes.
+ */
+static struct lsm_blob_sizes brute_blob_sizes __lsm_ro_after_init =3D {
+	.lbs_task =3D sizeof(struct brute_task),
+};
+
+/**
+ * brute_task() - Get the task info.
+ * @task: The task to get the info.
+ *
+ * Return: A pointer to the brute_task structure.
+ */
+static inline struct brute_task *brute_task(const struct task_struct *tas=
k)
+{
+	return task->security + brute_blob_sizes.lbs_task;
+}
+
+/**
+ * brute_set_task_killed() - Set task killed to mitigate a brute force at=
tack.
+ * @task: The task to set.
+ */
+static inline void brute_set_task_killed(struct task_struct *task)
+{
+	struct brute_task *task_info;
+
+	task_info =3D brute_task(task);
+	task_info->killed =3D true;
+}
+
+/**
+ * brute_task_killed() - Test if a task has been killed to mitigate an at=
tack.
+ * @task: The task to test.
+ *
+ * Return: True if the task has been killed to mitigate a brute force att=
ack.
+ *         False otherwise.
+ */
+inline bool brute_task_killed(const struct task_struct *task)
+{
+	struct brute_task *task_info;
+
+	task_info =3D brute_task(task);
+	return task_info->killed;
+}
+
 /**
  * brute_get_current_exe_file() - Get the current task's executable file.
  *
@@ -296,8 +349,10 @@ static void brute_kill_offending_tasks(const struct f=
ile *file)

 	read_lock(&tasklist_lock);
 	for_each_process(task) {
-		if (task->group_leader =3D=3D current->group_leader)
+		if (task->group_leader =3D=3D current->group_leader) {
+			brute_set_task_killed(task);
 			continue;
+		}

 		exe_file =3D get_task_exe_file(task);
 		if (!exe_file)
@@ -311,6 +366,7 @@ static void brute_kill_offending_tasks(const struct fi=
le *file)
 		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_PID);
 		pr_warn_ratelimited("offending process %d [%s] killed\n",
 				    task->pid, task->comm);
+		brute_set_task_killed(task);
 	}
 	read_unlock(&tasklist_lock);
 }
@@ -735,4 +791,5 @@ static int __init brute_init(void)
 DEFINE_LSM(brute) =3D {
 	.name =3D KBUILD_MODNAME,
 	.init =3D brute_init,
+	.blobs =3D &brute_blob_sizes,
 };
=2D-
2.25.1

