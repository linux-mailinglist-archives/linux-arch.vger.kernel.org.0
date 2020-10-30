Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F62A2A0A50
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 16:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgJ3Ptr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 11:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgJ3Ptm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:42 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A3320A8B;
        Fri, 30 Oct 2020 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604072981;
        bh=Nohcs14NXVmzDPgy7u84GYyJC54hRaPFadvgsNBjXrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNj45AqwPZGaVSNZpP/1A40HzTQLDVBwf2c34+4NvqbGTUhoh/FO1BRqJrOzNVruE
         LD4BOIie9hoNn4iQjlQcwnREWhJReYlSVouLAnKm8M47AUNXUKe7p+0J5aXJlKS3Jx
         fB308cFDSQauT/MWaRTsr+6FJpvDCoAqru2H5sJE=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linus.walleij@linaro.org, arnd@arndb.de
Subject: [PATCH 6/9] ARM: oabi-compat: rework sys_semtimedop emulation
Date:   Fri, 30 Oct 2020 16:49:16 +0100
Message-Id: <20201030154919.1246645-6-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030154919.1246645-1-arnd@kernel.org>
References: <20201030154519.1245983-1-arnd@kernel.org>
 <20201030154919.1246645-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

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
index 37bea07c12f2..fc7340fa4702 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1342,6 +1342,9 @@ long ksys_old_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct old_timespec32 __user *timeout);
+long __do_semtimedop(int semid, struct sembuf *tsems, unsigned int nsops,
+		     const struct timespec64 *timeout,
+		     struct ipc_namespace *ns);
 
 int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 		int __user *optlen);
diff --git a/ipc/sem.c b/ipc/sem.c
index f6c30a85dadf..c7725031c2ba 100644
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

