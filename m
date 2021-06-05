Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1539C97F
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 17:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFEP3k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 11:29:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:42997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEP3k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Jun 2021 11:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622906786;
        bh=V+/W+fEoSiOjB3w8FDJE2wQ1DNe8mLPtzk6quPwutvo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iojLmS3oTN1DZsuRR/9kSaXZCGZfZFJdGoPfE4LYE35NzhqE+PH0i8QWuoSoO3ig4
         0JngVPtJQX19ChfEqfqd/uYPbTfQMIgFOXT9yfcsDzgp5iQWkZ6M5rdwdgYtppmBQ+
         AgsMyUCQsUzlrWcQ2uUUGoVQflciOPKlRo41cXxA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MxUnz-1lQzxz0ynB-00xwA9; Sat, 05 Jun 2021 17:26:26 +0200
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
Subject: [PATCH v8 1/8] security: Add LSM hook at the point where a task gets a fatal signal
Date:   Sat,  5 Jun 2021 17:03:58 +0200
Message-Id: <20210605150405.6936-2-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605150405.6936-1-john.wood@gmx.com>
References: <20210605150405.6936-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AXIG8C6g+ihrnMi0Z4HkpARpgiKyCwVIo4zDsrAYAVY7GlNoZU6
 7O/98xMjJRXPp5Qat/wXAqITJjdc3Cg9KVDUkv9jMTAC4TmaJiwFSk+4T6TOSiObnjiNVug
 5nZhRlb2yHN0s2og2Qe+i3xYhvcGTiItAt6TDApjVwCMOjKleIr60AAiwo95nL9p1fVQ/6I
 S8e6Adp97nN0pqVcqVFpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+rmuCovomkA=:ToTPjaCqTPRANlpKwgY+BI
 Td9B1Od85sW7rN2BHlZx0S9yGMlNrRoNPYKw30EdwZpFQCw0MJ1R0CK7jNGYsnXyO/JWmtABx
 BP8IkODttWs14kSIcSCNKNy4q9JWsUjjZTaSYWrXwi64xsSYLhWaaddKFpk8MUuuvSv9uqJAX
 E/hUUtc0B9GArMYdIA78pHLTWuSIdCh8Q6yZFjSzqfSAR3zBStXRTFgc6GEb7llc9k4u8FD+R
 XtlGDWysWOLPvtgnghV5DjcNE6AUKsVR7/3NR/PDlkpUufHxi09Ppq7iL9YoFl0WE5upzqFIj
 q2ZzkVHB18mUQ06x7p6IFopYkvLGrVWFazETXmveEJbPqu/5Xu7Riy03cOUfz3v11HrIzMpMz
 +aIux0EuCwEfa60cVU4z8Nv7Zm4W7JsHaheyBhL6dxdOf/4gr4Hgajen8Eh3d8F6FbVSPOsxt
 s6Uybc/P9ER94vsN5/ev4rT+BM0jb2diW8cHTOUaV3rYTpxStwxWfbvo2PowP9gpvZVXNz+hx
 TSva2yUeepFKks37O8PHbO7IArxS+MAlRplA68Dn18k9iGuaEofOOzhOSpZcTTyMvillCS1iM
 xqv87MAi6Ut/ohkzwdAmStfNxUwBmvnY7nV9e8iChfcxFcplTo9Rx6RldUnyeSImra4jB7Vzx
 RpXyAAGqsDguITO8wNAo58W2qV5VbIh+W+g4Bv/8q+pxIopd3BEaf7KRG3D8XZq/xwcthsF6j
 wqyLd1NJlM3kM3uZl0ZVlHGMTBb4M37rkjQU5DqMJuu5YsZffDQO5e6ZNnBtcnt+pa8zge1yT
 auceOueO8F+cLAD8VsMsN/Y5wu6H3S0/kPvI24SydTLiJRY6XYuHqkDh2qVoyPCJnfkeGgDa7
 l+JKO2UYiadlnCcOEv/DRYUnCcD3MQAWGmIgoIUXbLesQfwXrIwoUVlqfxVLY+/2X5KxnltMR
 lU21EnKuEaYy41oQ7lvgOfWYYsSQ4i/w/egMQ05Hi30jVL3FoXlaWlI9UMRBTcs13VMp4M3JP
 cpn10EqaCybbccD3nURqqCVccxWiBfvbdBPp/8NvdtR7Uibubz38DMLWBhCZoPwm+Cn4J4NwY
 1+oTCRz76ExaLmdSmDYJMKJUpA2ai+aDo4z
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a security hook that allows a LSM to be notified when a task gets a
fatal signal. This patch is a previous step on the way to compute the
task crash period by the "brute" LSM (linux security module to detect
and mitigate fork brute force attack against vulnerable userspace
processes).

Signed-off-by: John Wood <john.wood@gmx.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
=2D--
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 4 ++++
 include/linux/security.h      | 4 ++++
 kernel/signal.c               | 1 +
 security/security.c           | 5 +++++
 5 files changed, 15 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 04c01794de83..e28468e84300 100644
=2D-- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -225,6 +225,7 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigne=
d long arg2,
 	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
 LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
+LSM_HOOK(void, LSM_RET_VOID, task_fatal_signal, const kernel_siginfo_t *s=
iginfo)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
 LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
 	 u32 *secid)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5c4c5c0602cb..fc8bef0f15d9 100644
=2D-- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -799,6 +799,10 @@
  *	security attributes, e.g. for /proc/pid inodes.
  *	@p contains the task_struct for the task.
  *	@inode contains the inode structure for the inode.
+ * @task_fatal_signal:
+ *	This hook allows security modules to be notified when a task gets a
+ *	fatal signal.
+ *	@siginfo contains the signal information.
  *
  * Security hooks for Netlink messaging.
  *
diff --git a/include/linux/security.h b/include/linux/security.h
index 06f7c50ce77f..609c76c6c764 100644
=2D-- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -433,6 +433,7 @@ int security_task_kill(struct task_struct *p, struct k=
ernel_siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg=
3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
+void security_task_fatal_signal(const kernel_siginfo_t *siginfo);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
 int security_msg_msg_alloc(struct msg_msg *msg);
@@ -1183,6 +1184,9 @@ static inline int security_task_prctl(int option, un=
signed long arg2,
 static inline void security_task_to_inode(struct task_struct *p, struct i=
node *inode)
 { }

+static inline void security_task_fatal_signal(const kernel_siginfo_t *sig=
info)
+{ }
+
 static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 					  short flag)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffcbd044..4380763b3d8d 100644
=2D-- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2804,6 +2804,7 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Anything else is fatal, maybe with a core dump.
 		 */
+		security_task_fatal_signal(&ksig->info);
 		current->flags |=3D PF_SIGNALED;

 		if (sig_kernel_coredump(signr)) {
diff --git a/security/security.c b/security/security.c
index b38155b2de83..208e3e7d4284 100644
=2D-- a/security/security.c
+++ b/security/security.c
@@ -1891,6 +1891,11 @@ void security_task_to_inode(struct task_struct *p, =
struct inode *inode)
 	call_void_hook(task_to_inode, p, inode);
 }

+void security_task_fatal_signal(const kernel_siginfo_t *siginfo)
+{
+	call_void_hook(task_fatal_signal, siginfo);
+}
+
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
=2D-
2.25.1

