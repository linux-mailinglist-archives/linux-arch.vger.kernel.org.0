Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC826FD4C
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 14:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgIRMrO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 08:47:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIRMrL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 08:47:11 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mo77T-1kquu045z1-00peri; Fri, 18 Sep 2020 14:46:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 6/9] ARM: oabi-compat: rework sys_semtimedop emulation
Date:   Fri, 18 Sep 2020 14:46:21 +0200
Message-Id: <20200918124624.1469673-7-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918124624.1469673-1-arnd@arndb.de>
References: <20200918124624.1469673-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OQM9k0kPghNnhr7huCyGsgsG9yt+ewhCkjkk1yCN4GHBE0dHqyG
 Od/WZv9NSjWM+UYqlwIWwhouyXoZFMOcsiFMShpMX57fox3x1M7ncV7zdFB3idmqO+KtVwB
 hqh8dh5MWw6xajNFjIu5ze4b3eM3mpzMRjDswsqXQ6mOZQ36k9yieMcv5Wt0oy29H2sef4N
 IQYmuP/GhfckbDfgwbJCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MmguxKmUUwc=:9kYi+keea4iOvvMApXUH/3
 UCBxQDGyd1wflj5PwUSypPMMrT38GLB6kp44alrM6DIVux2gdmxJxzN5Z2Kz38TyhzfC+3yqt
 yGjhvgNnbe9jC2WUBzcwTFHUEeB+OoFMGnkcCccc5y3efJL2Az017Nsrfsy5ixqwtXnKTnmdk
 hMf1mGT1dtD5ahraMva6u0mL7sB72KCg0//34WVI2KW/tXzXVLtbYVVHyY/doYNXI17ekVroW
 XcpfAkQYS0TtuICXVltbjQGDjQDdCq+hAezDQAQ/yGX8UXS19Poj185LT/OzOeVMcimBj2NiE
 7nlPjX6+27Z61syeTB4kFttP7PeQ87APUxv6z65sRjoSXaipPJyMmCVn16LeYBeU3Dr8D/SWF
 Y3DwmZTt5SW1iR++Lf/Rt74n/CQPllFOib1Aj+6G9QfjzqO2u272HOFN08ayGpuU722l0C+wE
 c6Oiz2SIKCv/lkwYhPV/5AXAwb2AAxSjvdNIYUL5Huqgv+HuofY69KyF/dqLwDCf83Q4VGScB
 dP7UptKjdvzdK1TPrvxsPujfWgQ1WrDt/gIZ4kMUHmY4/JHO4GG7xbC2w8Wb33JQ++iYMbSN5
 ge2JUEoxsjuJNV1k6rSkw0VBlWjhWtiHdauIVrWZX2hY5RXvr9h8nor2RIk47gn+IjLCJrFK9
 F1aE2428ow59aogGSHk75qHNoLWcK4Q+GLBGt3CvSvhc57nVPHzxIY8uGLG1Shu/301t5zMMZ
 U+EctU9kNdi5xPI08R/7I65WseruLPbta21ZMw0HTLS5+6tBqOJdLkeeiWF2qLa7hb+1Vo74i
 z2EiAHNG3WfKwyB7xpW0BwNz49/C3GdYJGOR0GCQp+7vZxv+PSNJDrA6jXxqL8vc+QxsHFt
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

sys_oabi_semtimedop() is one of the last users of set_fs() on Arm. To
remove this one, expose the internal code of the actual implementation
that operates on a kernel pointer and call it directly after copying.

There should be no measurable impact on the normal execution of this
function, and it makes the overly long function a little shorter, which
may help readability.

While reworking the oabi version, make it behave a little more like
the native one, using kvmalloc_array() and restructure the code
flow in a similar way.

The naming of __do_semtimedop() is not very good, I hope someone can
come up with a better name.

One regression was spotted by kernel test robot <rong.a.chen@intel.com>
and fixed before the first mailing list submission.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/sys_oabi-compat.c | 38 ++++++++------
 include/linux/syscalls.h          |  3 ++
 ipc/sem.c                         | 84 +++++++++++++++++++------------
 3 files changed, 77 insertions(+), 48 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index f9d8e5be6ba0..c3e63b73b6ae 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -80,6 +80,7 @@
 #include <linux/socket.h>
 #include <linux/net.h>
 #include <linux/ipc.h>
+#include <linux/ipc_namespace.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
@@ -294,46 +295,51 @@ struct oabi_sembuf {
 	unsigned short	__pad;
 };
 
+#define sc_semopm     sem_ctls[2]
+
 asmlinkage long sys_oabi_semtimedop(int semid,
 				    struct oabi_sembuf __user *tsops,
 				    unsigned nsops,
 				    const struct old_timespec32 __user *timeout)
 {
+	struct ipc_namespace *ns;
 	struct sembuf *sops;
-	struct old_timespec32 local_timeout;
 	long err;
 	int i;
 
+	ns = current->nsproxy->ipc_ns;
+	if (nsops > ns->sc_semopm)
+		return -E2BIG;
 	if (nsops < 1 || nsops > SEMOPM)
 		return -EINVAL;
-	if (!access_ok(tsops, sizeof(*tsops) * nsops))
-		return -EFAULT;
-	sops = kmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
+	sops = kvmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
 	if (!sops)
 		return -ENOMEM;
 	err = 0;
 	for (i = 0; i < nsops; i++) {
 		struct oabi_sembuf osb;
-		err |= __copy_from_user(&osb, tsops, sizeof(osb));
+		err |= copy_from_user(&osb, tsops, sizeof(osb));
 		sops[i].sem_num = osb.sem_num;
 		sops[i].sem_op = osb.sem_op;
 		sops[i].sem_flg = osb.sem_flg;
 		tsops++;
 	}
-	if (timeout) {
-		/* copy this as well before changing domain protection */
-		err |= copy_from_user(&local_timeout, timeout, sizeof(*timeout));
-		timeout = &local_timeout;
-	}
 	if (err) {
 		err = -EFAULT;
-	} else {
-		mm_segment_t fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_semtimedop_time32(semid, sops, nsops, timeout);
-		set_fs(fs);
+		goto out;
+	}
+
+	if (timeout) {
+		struct timespec64 ts;
+		err = get_old_timespec32(&ts, timeout);
+		if (err)
+			goto out;
+		err = __do_semtimedop(semid, sops, nsops, &ts, ns);
+		goto out;
 	}
-	kfree(sops);
+	err = __do_semtimedop(semid, sops, nsops, NULL, ns);
+out:
+	kvfree(sops);
 	return err;
 }
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 75ac7f8ae93c..bb5ed3a712a5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1340,6 +1340,9 @@ long ksys_old_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct old_timespec32 __user *timeout);
+long __do_semtimedop(int semid, struct sembuf *tsems, unsigned int nsops,
+		     const struct timespec64 *timeout,
+		     struct ipc_namespace *ns);
 
 int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 		int __user *optlen);
diff --git a/ipc/sem.c b/ipc/sem.c
index 8c0244e0365e..515a39a67534 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1978,46 +1978,34 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	return un;
 }
 
-static long do_semtimedop(int semid, struct sembuf __user *tsops,
-		unsigned nsops, const struct timespec64 *timeout)
+long __do_semtimedop(int semid, struct sembuf *sops,
+		unsigned nsops, const struct timespec64 *timeout,
+		struct ipc_namespace *ns)
 {
 	int error = -EINVAL;
 	struct sem_array *sma;
-	struct sembuf fast_sops[SEMOPM_FAST];
-	struct sembuf *sops = fast_sops, *sop;
+	struct sembuf *sop;
 	struct sem_undo *un;
 	int max, locknum;
 	bool undos = false, alter = false, dupsop = false;
 	struct sem_queue queue;
 	unsigned long dup = 0, jiffies_left = 0;
-	struct ipc_namespace *ns;
-
-	ns = current->nsproxy->ipc_ns;
 
 	if (nsops < 1 || semid < 0)
 		return -EINVAL;
 	if (nsops > ns->sc_semopm)
 		return -E2BIG;
-	if (nsops > SEMOPM_FAST) {
-		sops = kvmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
-		if (sops == NULL)
-			return -ENOMEM;
-	}
-
-	if (copy_from_user(sops, tsops, nsops * sizeof(*tsops))) {
-		error =  -EFAULT;
-		goto out_free;
-	}
 
 	if (timeout) {
 		if (timeout->tv_sec < 0 || timeout->tv_nsec < 0 ||
 			timeout->tv_nsec >= 1000000000L) {
 			error = -EINVAL;
-			goto out_free;
+			goto out;
 		}
 		jiffies_left = timespec64_to_jiffies(timeout);
 	}
 
+
 	max = 0;
 	for (sop = sops; sop < sops + nsops; sop++) {
 		unsigned long mask = 1ULL << ((sop->sem_num) % BITS_PER_LONG);
@@ -2046,7 +2034,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		un = find_alloc_undo(ns, semid);
 		if (IS_ERR(un)) {
 			error = PTR_ERR(un);
-			goto out_free;
+			goto out;
 		}
 	} else {
 		un = NULL;
@@ -2057,25 +2045,25 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	if (IS_ERR(sma)) {
 		rcu_read_unlock();
 		error = PTR_ERR(sma);
-		goto out_free;
+		goto out;
 	}
 
 	error = -EFBIG;
 	if (max >= sma->sem_nsems) {
 		rcu_read_unlock();
-		goto out_free;
+		goto out;
 	}
 
 	error = -EACCES;
 	if (ipcperms(ns, &sma->sem_perm, alter ? S_IWUGO : S_IRUGO)) {
 		rcu_read_unlock();
-		goto out_free;
+		goto out;
 	}
 
 	error = security_sem_semop(&sma->sem_perm, sops, nsops, alter);
 	if (error) {
 		rcu_read_unlock();
-		goto out_free;
+		goto out;
 	}
 
 	error = -EIDRM;
@@ -2089,7 +2077,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	 * entangled here and why it's RMID race safe on comments at sem_lock()
 	 */
 	if (!ipc_valid_object(&sma->sem_perm))
-		goto out_unlock_free;
+		goto out_unlock;
 	/*
 	 * semid identifiers are not unique - find_alloc_undo may have
 	 * allocated an undo structure, it was invalidated by an RMID
@@ -2098,7 +2086,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	 * "un" itself is guaranteed by rcu.
 	 */
 	if (un && un->semid == -1)
-		goto out_unlock_free;
+		goto out_unlock;
 
 	queue.sops = sops;
 	queue.nsops = nsops;
@@ -2124,10 +2112,10 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		rcu_read_unlock();
 		wake_up_q(&wake_q);
 
-		goto out_free;
+		goto out;
 	}
 	if (error < 0) /* non-blocking error path */
-		goto out_unlock_free;
+		goto out_unlock;
 
 	/*
 	 * We need to sleep on this operation, so we put the current
@@ -2192,14 +2180,14 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		if (error != -EINTR) {
 			/* see SEM_BARRIER_2 for purpose/pairing */
 			smp_acquire__after_ctrl_dep();
-			goto out_free;
+			goto out;
 		}
 
 		rcu_read_lock();
 		locknum = sem_lock(sma, sops, nsops);
 
 		if (!ipc_valid_object(&sma->sem_perm))
-			goto out_unlock_free;
+			goto out_unlock;
 
 		/*
 		 * No necessity for any barrier: We are protect by sem_lock()
@@ -2211,7 +2199,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		 * Leave without unlink_queue(), but with sem_unlock().
 		 */
 		if (error != -EINTR)
-			goto out_unlock_free;
+			goto out_unlock;
 
 		/*
 		 * If an interrupt occurred we have to clean up the queue.
@@ -2222,13 +2210,45 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 
 	unlink_queue(sma, &queue);
 
-out_unlock_free:
+out_unlock:
 	sem_unlock(sma, locknum);
 	rcu_read_unlock();
+out:
+	return error;
+}
+
+static long do_semtimedop(int semid, struct sembuf __user *tsops,
+		unsigned nsops, const struct timespec64 *timeout)
+{
+	struct sembuf fast_sops[SEMOPM_FAST];
+	struct sembuf *sops = fast_sops;
+	struct ipc_namespace *ns;
+	int ret;
+
+	ns = current->nsproxy->ipc_ns;
+	if (nsops > ns->sc_semopm)
+		return -E2BIG;
+	if (nsops < 1)
+		return -EINVAL;
+
+	if (nsops > SEMOPM_FAST) {
+		sops = kvmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
+		if (sops == NULL)
+			return -ENOMEM;
+	}
+
+	if (copy_from_user(sops, tsops, nsops * sizeof(*tsops))) {
+		ret =  -EFAULT;
+		goto out_free;
+	}
+
+	ret = __do_semtimedop(semid, sops, nsops, timeout, ns);
+
 out_free:
 	if (sops != fast_sops)
 		kvfree(sops);
-	return error;
+
+	return ret;
 }
 
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
-- 
2.27.0

