Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25139C9E0
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFEQee (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 12:34:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:53599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEQee (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Jun 2021 12:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622910700;
        bh=d0ThzL6H3ZgX1iy++Zve4fg1GWGCL9gUNpUEh/9SJtk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BuDP4OKL2j+CO6onsweK/K1KkYYu7I/kH+jhZ5PntqQFdTIH5E8AtMJIcqgrDvBVP
         VvU7zSrKp+ubV7jeVznxxj8uhJ95HiQNaUsJmFq1kZPdS58nh04QD77n1icWS+x4Co
         ywVo6FBtmOUJHa0SRZK8zoeb6HPdd4rnxOvUy4E8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MeU4s-1lHKJz3J9Y-00aT8a; Sat, 05 Jun 2021 18:31:40 +0200
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
Subject: [PATCH v8 4/8] security/brute: Mitigate a brute force attack
Date:   Sat,  5 Jun 2021 17:04:01 +0200
Message-Id: <20210605150405.6936-5-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605150405.6936-1-john.wood@gmx.com>
References: <20210605150405.6936-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eaoHbte0dcns/AzvPwU3vjWvzTt5OyHKFhMvw3CoF2yDAezUQXG
 HNL+Dz0RMocznxqLc/uqoDMWEiwIy9oVQAmVywfZcYdM0FqRELNwtjOp3/3Ez4hQkjUTbBe
 3kE1mRljNdwia+or7ZFdi/nK+l1r97CttJ0H2x4emoeySF4meERwpAfOMWx4y+7eTpkASXL
 asnTW9LUdyzRx3OBp+gpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Me4GWsjU9Io=:avuErcXWGckyfqeykMNLff
 v4oTeRj6F4cphQX08iNfKJbo7vA+WlE3ckHPPwaVQ6wN8qw+YEjPDb++wvEOD/tHdAo1MzILj
 2DexURIr+Sb2AOWd/fF2RJTFpZzdOXenT4cKFcpQwA2ihfzVOqd5g33IxkUO9S6Z84liq797Z
 wIn+YwhKBnEUFgKUjn+WeBsDIBKB2zj3pcM3oJRI/OdsQVIqeYFmABL/ZLo6vH0yhJyLct1f/
 /ZkKOAZzQfawoB8d6Ur6KdJUJMvb7gcuvsBooEnDiqvrMoL9GYA1oZoXuXbUUJc2zVjQgxSzJ
 UzIe7Dh07sq9k3zh7ZTxw2gNIm7DNUZsKctYzHIwHtTPTFQBHW58tif6qwdeGwxKXcZvqH0J7
 48GVCvMUJrA8KAaGXLTvSgkRT4tGkJddivRbIxSrw/q9GNsuHYmzONOko9Lz//1Mq5JLdYp8t
 YZ+qSODc7EIT2gnjhYMUCnN9OaEY9BzzZtQYUr5fK2QdeIovdOwpmJBdYopW9p5iL8gxj8PJx
 UsCctXYdxfbDnS0qyqXs1lWA1tpePBa5sHFKEiC/eoc5J1fa70wo187nk3pZsWF9vi2ebtAbm
 ttkry6c+SPJiTy4AKv9V6YnHW1O/1kWXzpIgm3007gmUVaxN7tqz0M3fzcWBptPKKlbuoPuuO
 X5T+73RnwlcVvuV7DxpeVAxTtMKYfcvNNMZsVLCcpW+DTL0hgkMh8bxQxM6Cxj+MpHvkruRgh
 Ur9pUukiUmy4UKsxoTkyGU5Tm7huEkMm0sN/ariuHZOwzfKsySy2E/2+XpW2tKqpU3wtSqDeP
 RRJNC+GohDqsTbpHVrHOjGH5dfELUurgOoX89iPvA9FqW+H0/2moxpITU2zDam6oH1oriN6qG
 bXbuPXLEqqhPt/dV+5/yzNzZfpHeH2NtoQzbAlrUVA7QRAhlQjPPltNDkntGt1oMRxzffpay5
 4GjXCHAjJhqv+7IpIPrG3j+NYvjYt/GWIAq3zz5r1M67nbvynw8pHL3LKnVVMY9fWIjdrHqd+
 OqYMyUXnZnKywfcnKCAjX+3OeRGApG9iGv2Ju0y6hrZq9ZRzeA9aBpVCRON9jUrLAYC20rcQd
 CfSeyyC/3WD+4GONhvNRIpyVK5RBzbR5TZk
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a brute force attack is detected all the offending tasks involved
in the attack must be killed. In other words, it is necessary to kill
all the tasks that are executing the same file that is running during
the brute force attack.

Also, to prevent the executable involved in the attack from being
respawned by a supervisor, and thus prevent a brute force attack from
being started again, test the "not_allowed" flag and avoid the file
execution based on this.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/brute/brute.c | 113 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 11 deletions(-)

diff --git a/security/brute/brute.c b/security/brute/brute.c
index 03bebfd1ed1f..4e0fd23990c8 100644
=2D-- a/security/brute/brute.c
+++ b/security/brute/brute.c
@@ -233,6 +233,88 @@ static inline void brute_print_attack_running(void)
 		current->comm);
 }

+/**
+ * brute_print_file_not_allowed() - Warn about a file not allowed.
+ * @dentry: The dentry of the file not allowed.
+ */
+static void brute_print_file_not_allowed(struct dentry *dentry)
+{
+	char *buf, *path;
+
+	buf =3D __getname();
+	if (WARN_ON_ONCE(!buf))
+		return;
+
+	path =3D dentry_path_raw(dentry, buf, PATH_MAX);
+	if (WARN_ON_ONCE(IS_ERR(path)))
+		goto free;
+
+	pr_warn_ratelimited("%s not allowed\n", path);
+free:
+	__putname(buf);
+}
+
+/**
+ * brute_is_same_file() - Test if two files are the same.
+ * @file1: First file to compare. Cannot be NULL.
+ * @file2: Second file to compare. Cannot be NULL.
+ *
+ * Two files are the same if they have the same inode number and the same=
 block
+ * device.
+ *
+ * Return: True if the two files are the same. False otherwise.
+ */
+static inline bool brute_is_same_file(const struct file *file1,
+				      const struct file *file2)
+{
+	struct inode *inode1 =3D file_inode(file1);
+	struct inode *inode2 =3D file_inode(file2);
+
+	return inode1->i_ino =3D=3D inode2->i_ino &&
+		inode1->i_sb->s_dev =3D=3D inode2->i_sb->s_dev;
+}
+
+/**
+ * brute_kill_offending_tasks() - Kill the offending tasks.
+ * @file: The file executed during a brute force attack. Cannot be NULL.
+ *
+ * When a brute force attack is detected all the offending tasks involved=
 in the
+ * attack must be killed. In other words, it is necessary to kill all the=
 tasks
+ * that are executing the same file that is running during the brute forc=
e
+ * attack. Moreover, the processes that have the same group_leader that t=
he
+ * current task must be avoided since they are in the path to be killed.
+ *
+ * The for_each_process loop is protected by the tasklist_lock acquired i=
n read
+ * mode instead of rcu_read_lock to avoid that the newly created processe=
s
+ * escape this RCU read lock.
+ */
+static void brute_kill_offending_tasks(const struct file *file)
+{
+	struct task_struct *task;
+	struct file *exe_file;
+	bool is_same_file;
+
+	read_lock(&tasklist_lock);
+	for_each_process(task) {
+		if (task->group_leader =3D=3D current->group_leader)
+			continue;
+
+		exe_file =3D get_task_exe_file(task);
+		if (!exe_file)
+			continue;
+
+		is_same_file =3D brute_is_same_file(exe_file, file);
+		fput(exe_file);
+		if (!is_same_file)
+			continue;
+
+		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_PID);
+		pr_warn_ratelimited("offending process %d [%s] killed\n",
+				    task->pid, task->comm);
+	}
+	read_unlock(&tasklist_lock);
+}
+
 /**
  * brute_get_xattr_stats() - Get the stats from an extended attribute.
  * @dentry: The dentry of the file to get the extended attribute.
@@ -295,6 +377,10 @@ static int brute_set_xattr_stats(struct dentry *dentr=
y, struct inode *inode,
  * created. This way, the scenario where an application has not crossed a=
ny
  * privilege boundary is avoided since the existence of the extended attr=
ibute
  * denotes the crossing of bounds.
+ *
+ * Also, do not update the statistics if the execution of the file is not
+ * allowed and kill all the offending tasks when a brute force attack is
+ * detected.
  */
 static void brute_update_xattr_stats(const struct file *file)
 {
@@ -306,7 +392,7 @@ static void brute_update_xattr_stats(const struct file=
 *file)
 	inode_lock(inode);
 	rc =3D brute_get_xattr_stats(dentry, inode, &stats);
 	WARN_ON_ONCE(rc && rc !=3D -ENODATA);
-	if (rc) {
+	if (rc || (!rc && stats.not_allowed)) {
 		inode_unlock(inode);
 		return;
 	}
@@ -320,6 +406,9 @@ static void brute_update_xattr_stats(const struct file=
 *file)
 	rc =3D brute_set_xattr_stats(dentry, inode, &stats);
 	WARN_ON_ONCE(rc);
 	inode_unlock(inode);
+
+	if (stats.not_allowed)
+		brute_kill_offending_tasks(file);
 }

 /**
@@ -433,21 +522,17 @@ static void brute_task_fatal_signal(const kernel_sig=
info_t *siginfo)
  * @bprm: Contains the linux_binprm structure.
  * @file: Binary that will be executed without an interpreter.
  *
- * This hook is useful to mark that a privilege boundary (setuid/setgid p=
rocess)
- * has been crossed. This is done based on the "secureexec" flag.
+ * If there are statistics, test the "not_allowed" flag and avoid the fil=
e
+ * execution based on this. Also, this hook is useful to mark that a priv=
ilege
+ * boundary (setuid/setgid process) has been crossed. This is done based =
on the
+ * "secureexec" flag.
  *
  * To be defensive return an error code if it is not possible to get or s=
et the
  * stats using an extended attribute since this blocks the execution of t=
he
  * file. This scenario is treated as an attack.
  *
- * It is important to note that here the brute_new_xattr_stats function c=
ould be
- * used with a previous test of the secureexec flag. However it is better=
 to use
- * the basic xattr functions since in a future commit a test if the execu=
tion is
- * allowed (via the brute_stats::not_allowed flag) will be necessary. Thi=
s way,
- * the stats of the file will be get only once.
- *
- * Return: An error code if it is not possible to get or set the statisti=
cal
- *         data. Zero otherwise.
+ * Return: -EPERM if the execution of the file is not allowed. An error c=
ode if
+ *         it is not possible to get or set the statistical data. Zero ot=
herwise.
  */
 static int brute_task_execve(struct linux_binprm *bprm, struct file *file=
)
 {
@@ -461,6 +546,12 @@ static int brute_task_execve(struct linux_binprm *bpr=
m, struct file *file)
 	if (WARN_ON_ONCE(rc && rc !=3D -ENODATA))
 		goto unlock;

+	if (!rc && stats.not_allowed) {
+		brute_print_file_not_allowed(dentry);
+		rc =3D -EPERM;
+		goto unlock;
+	}
+
 	if (rc =3D=3D -ENODATA && bprm->secureexec) {
 		brute_reset_stats(&stats);
 		rc =3D brute_set_xattr_stats(dentry, inode, &stats);
=2D-
2.25.1

