Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D42F595C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 22:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbfKHVMn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 16:12:43 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732622AbfKHVMm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 16:12:42 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mt71D-1he6Ia3jLN-00tVVi; Fri, 08 Nov 2019 22:12:02 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 08/23] y2038: ipc: remove __kernel_time_t reference from headers
Date:   Fri,  8 Nov 2019 22:07:28 +0100
Message-Id: <20191108210824.1534248-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ovo0znhTfBciqHb5dk0y9f3n8qBGpYoN5a+fnOutVi0zwjP5IUw
 HjIVyFgCbCf58CGn4gwb5GNQIGmRVw5mMk8UaHe2qlr3ru5M8GkK4eRrsN2PFQIfGyB1mmZ
 nxJu8Pco7TO8N2iXYpgX8cHBRts25B+w8zGGR49P65oOsNPllFUrHlwNLsnOMRJh3vZ5gZn
 vGIyiYPc0ivZ7E/oWr5Rg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EknCUVeDeik=:kFs35h3Qt8AyXZ2wLRCzrT
 YmJt6ugFf5BcZj0XVNSYiCfXF2ZKLKP597Bd2wzHGFLq2sJ7DZV79y4hPpYmK0HLEqR+4bUDo
 2IrKvgJRSEDI7Y3XEidmjGen8tcGv/fr+x30rF7r+ZAQheq2HdsdfDojlmkDUegAnwv205p9J
 Gl3FGYDv1U+SQQhvzTlQFZ16AombosrEgM6SIAy+vL3oxygTzXrsOEHpHHw3R1PAjLFMKh3kY
 bCVuJ9JJEf2ypKk9q8KeJ9EjOZux0gGtaLmL5AJzUEY88C5Td6Lt/Pjn8H1sEcepIKpZXANlK
 YHTWE+3gmeMwsHoVO0UdLkX9iwJNbQwLVIabxORRj/p9/GIz7JEOHdd0wwjUhHpzV3Aq9pRse
 hWp7CEiBUvo+eQrHAhsA/5mD5WzRjVV9omb+QCWDzvyJ+RSEbiPEg5vCdpb2fQaJEPk5GxvTu
 iqu2lwYjL7rzSvZnnOPhAXuyWZdwsb7+GaYiR+woosbqPbUlRBpBjahjxqVUogx8l0y9/9x6q
 Yc+3T3lEuiX2Om2g9dt5lqFof2y519ROqQfcFkp9+e1tFTxSY0OyNnr8UGQ3hBOOGV1pOc8qg
 rKkhlOwNMMhf2ZfJb0Yj44txpMD/P5rCgADdR+jPj5dH8cP+6PtStusgw8h88iDe7EGQ6dDnK
 adJMPF6VF3ecWYvZ+lg9aD331VzTIKEy8Uv+6T0zMt3hAQQB9ZeWW9SoqUCtGOexgZb4hYtw2
 RF2mIWtYV+RAkc/0XWTAKKbQLKGCvizAft3ZrkQ3TILY9WzIiY+WiJQKeLo5BpsAPucT+WhKn
 8DIRQ/j+I+dkO/biVhC5KG5tcHGW1p7hcaeCuPKiTtZAyFKpfD/jm2Q6iKnEyYfx5wfzxVP3E
 ERJYOUdYmAa4C2oTobnQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are two structures based on time_t that conflict between libc and
kernel: timeval and timespec. Both are now renamed to __kernel_old_timeval
and __kernel_old_timespec.

For time_t, the old typedef is still __kernel_time_t. There is nothing
wrong with that name, but it would be nice to not use that going forward
as this type is used almost only in deprecated interfaces because of
the y2038 overflow.

In the IPC headers (msgbuf.h, sembuf.h, shmbuf.h), __kernel_time_t is only
used for the 64-bit variants, which are not deprecated.

Change these to a plain 'long', which is the same type as __kernel_time_t
on all 64-bit architectures anyway, to reduce the number of users of the
old type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/uapi/asm/msgbuf.h    |  6 +++---
 arch/mips/include/uapi/asm/sembuf.h    |  4 ++--
 arch/mips/include/uapi/asm/shmbuf.h    |  6 +++---
 arch/parisc/include/uapi/asm/msgbuf.h  |  6 +++---
 arch/parisc/include/uapi/asm/sembuf.h  |  4 ++--
 arch/parisc/include/uapi/asm/shmbuf.h  |  6 +++---
 arch/powerpc/include/uapi/asm/msgbuf.h |  6 +++---
 arch/powerpc/include/uapi/asm/sembuf.h |  4 ++--
 arch/powerpc/include/uapi/asm/shmbuf.h |  6 +++---
 arch/sparc/include/uapi/asm/msgbuf.h   |  6 +++---
 arch/sparc/include/uapi/asm/sembuf.h   |  4 ++--
 arch/sparc/include/uapi/asm/shmbuf.h   |  6 +++---
 arch/x86/include/uapi/asm/msgbuf.h     |  6 +++---
 arch/x86/include/uapi/asm/sembuf.h     |  4 ++--
 arch/x86/include/uapi/asm/shmbuf.h     |  6 +++---
 include/uapi/asm-generic/msgbuf.h      | 12 ++++++------
 include/uapi/asm-generic/sembuf.h      |  7 +++----
 include/uapi/asm-generic/shmbuf.h      | 12 ++++++------
 18 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/arch/mips/include/uapi/asm/msgbuf.h b/arch/mips/include/uapi/asm/msgbuf.h
index 46aa15b13e4e..9e0c2e230274 100644
--- a/arch/mips/include/uapi/asm/msgbuf.h
+++ b/arch/mips/include/uapi/asm/msgbuf.h
@@ -15,9 +15,9 @@
 #if defined(__mips64)
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
+	long msg_stime;			/* last msgsnd time */
+	long msg_rtime;			/* last msgrcv time */
+	long msg_ctime;			/* last change time */
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
diff --git a/arch/mips/include/uapi/asm/sembuf.h b/arch/mips/include/uapi/asm/sembuf.h
index 60c89e6cb25b..43e1b4a2f68a 100644
--- a/arch/mips/include/uapi/asm/sembuf.h
+++ b/arch/mips/include/uapi/asm/sembuf.h
@@ -14,8 +14,8 @@
 #ifdef __mips64
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t sem_otime;		/* last semop time */
-	__kernel_time_t sem_ctime;		/* last change time */
+	long		 sem_otime;		/* last semop time */
+	long		 sem_ctime;		/* last change time */
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;
 	unsigned long	__unused2;
diff --git a/arch/mips/include/uapi/asm/shmbuf.h b/arch/mips/include/uapi/asm/shmbuf.h
index 9b9bba3401f2..680bb95b2240 100644
--- a/arch/mips/include/uapi/asm/shmbuf.h
+++ b/arch/mips/include/uapi/asm/shmbuf.h
@@ -17,9 +17,9 @@
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
+	long			shm_atime;	/* last attach time */
+	long			shm_dtime;	/* last detach time */
+	long			shm_ctime;	/* last change time */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
diff --git a/arch/parisc/include/uapi/asm/msgbuf.h b/arch/parisc/include/uapi/asm/msgbuf.h
index 6a2e9ab2ef8d..3b877335da38 100644
--- a/arch/parisc/include/uapi/asm/msgbuf.h
+++ b/arch/parisc/include/uapi/asm/msgbuf.h
@@ -16,9 +16,9 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 #if __BITS_PER_LONG == 64
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
+	long		 msg_stime;	/* last msgsnd time */
+	long		 msg_rtime;	/* last msgrcv time */
+	long		 msg_ctime;	/* last change time */
 #else
 	unsigned long	msg_stime_high;
 	unsigned long	msg_stime;	/* last msgsnd time */
diff --git a/arch/parisc/include/uapi/asm/sembuf.h b/arch/parisc/include/uapi/asm/sembuf.h
index 3c31163b1241..8241cf126018 100644
--- a/arch/parisc/include/uapi/asm/sembuf.h
+++ b/arch/parisc/include/uapi/asm/sembuf.h
@@ -16,8 +16,8 @@
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 #if __BITS_PER_LONG == 64
-	__kernel_time_t	sem_otime;		/* last semop time */
-	__kernel_time_t	sem_ctime;		/* last change time */
+	long		sem_otime;		/* last semop time */
+	long		sem_ctime;		/* last change time */
 #else
 	unsigned long	sem_otime_high;
 	unsigned long	sem_otime;		/* last semop time */
diff --git a/arch/parisc/include/uapi/asm/shmbuf.h b/arch/parisc/include/uapi/asm/shmbuf.h
index c89b3dd8db21..5da3089be65e 100644
--- a/arch/parisc/include/uapi/asm/shmbuf.h
+++ b/arch/parisc/include/uapi/asm/shmbuf.h
@@ -16,9 +16,9 @@
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 #if __BITS_PER_LONG == 64
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
+	long			shm_atime;	/* last attach time */
+	long			shm_dtime;	/* last detach time */
+	long			shm_ctime;	/* last change time */
 #else
 	unsigned long		shm_atime_high;
 	unsigned long		shm_atime;	/* last attach time */
diff --git a/arch/powerpc/include/uapi/asm/msgbuf.h b/arch/powerpc/include/uapi/asm/msgbuf.h
index 2b1b37797a47..969bd83e4d3d 100644
--- a/arch/powerpc/include/uapi/asm/msgbuf.h
+++ b/arch/powerpc/include/uapi/asm/msgbuf.h
@@ -11,9 +11,9 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 #ifdef __powerpc64__
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
+	long		 msg_stime;	/* last msgsnd time */
+	long		 msg_rtime;	/* last msgrcv time */
+	long		 msg_ctime;	/* last change time */
 #else
 	unsigned long  msg_stime_high;
 	unsigned long  msg_stime;	/* last msgsnd time */
diff --git a/arch/powerpc/include/uapi/asm/sembuf.h b/arch/powerpc/include/uapi/asm/sembuf.h
index 3f60946f77e3..008ae77c6746 100644
--- a/arch/powerpc/include/uapi/asm/sembuf.h
+++ b/arch/powerpc/include/uapi/asm/sembuf.h
@@ -26,8 +26,8 @@ struct semid64_ds {
 	unsigned long	sem_ctime_high;
 	unsigned long	sem_ctime;	/* last change time */
 #else
-	__kernel_time_t	sem_otime;	/* last semop time */
-	__kernel_time_t	sem_ctime;	/* last change time */
+	long		sem_otime;	/* last semop time */
+	long		sem_ctime;	/* last change time */
 #endif
 	unsigned long	sem_nsems;	/* no. of semaphores in array */
 	unsigned long	__unused3;
diff --git a/arch/powerpc/include/uapi/asm/shmbuf.h b/arch/powerpc/include/uapi/asm/shmbuf.h
index b591c4d7e4c5..00422b2f3c63 100644
--- a/arch/powerpc/include/uapi/asm/shmbuf.h
+++ b/arch/powerpc/include/uapi/asm/shmbuf.h
@@ -22,9 +22,9 @@
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 #ifdef __powerpc64__
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
+	long		shm_atime;	/* last attach time */
+	long		shm_dtime;	/* last detach time */
+	long		shm_ctime;	/* last change time */
 #else
 	unsigned long		shm_atime_high;
 	unsigned long		shm_atime;	/* last attach time */
diff --git a/arch/sparc/include/uapi/asm/msgbuf.h b/arch/sparc/include/uapi/asm/msgbuf.h
index ffc46c211d6d..eeeb91933280 100644
--- a/arch/sparc/include/uapi/asm/msgbuf.h
+++ b/arch/sparc/include/uapi/asm/msgbuf.h
@@ -13,9 +13,9 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 #if defined(__sparc__) && defined(__arch64__)
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
+	long msg_stime;			/* last msgsnd time */
+	long msg_rtime;			/* last msgrcv time */
+	long msg_ctime;			/* last change time */
 #else
 	unsigned long msg_stime_high;
 	unsigned long msg_stime;	/* last msgsnd time */
diff --git a/arch/sparc/include/uapi/asm/sembuf.h b/arch/sparc/include/uapi/asm/sembuf.h
index f3d309c2e1cd..cbcbaa4e7128 100644
--- a/arch/sparc/include/uapi/asm/sembuf.h
+++ b/arch/sparc/include/uapi/asm/sembuf.h
@@ -14,8 +14,8 @@
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 #if defined(__sparc__) && defined(__arch64__)
-	__kernel_time_t	sem_otime;		/* last semop time */
-	__kernel_time_t	sem_ctime;		/* last change time */
+	long		sem_otime;		/* last semop time */
+	long		sem_ctime;		/* last change time */
 #else
 	unsigned long	sem_otime_high;
 	unsigned long	sem_otime;		/* last semop time */
diff --git a/arch/sparc/include/uapi/asm/shmbuf.h b/arch/sparc/include/uapi/asm/shmbuf.h
index 06618b84822d..a5d7d8d681c4 100644
--- a/arch/sparc/include/uapi/asm/shmbuf.h
+++ b/arch/sparc/include/uapi/asm/shmbuf.h
@@ -14,9 +14,9 @@
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 #if defined(__sparc__) && defined(__arch64__)
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
+	long			shm_atime;	/* last attach time */
+	long			shm_dtime;	/* last detach time */
+	long			shm_ctime;	/* last change time */
 #else
 	unsigned long		shm_atime_high;
 	unsigned long		shm_atime;	/* last attach time */
diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
index 90ab9a795b49..7c5bb43ed8af 100644
--- a/arch/x86/include/uapi/asm/msgbuf.h
+++ b/arch/x86/include/uapi/asm/msgbuf.h
@@ -15,9 +15,9 @@
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
+	__kernel_long_t msg_stime;	/* last msgsnd time */
+	__kernel_long_t msg_rtime;	/* last msgrcv time */
+	__kernel_long_t msg_ctime;	/* last change time */
 	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
 	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
 	__kernel_ulong_t msg_qbytes;	/* max number of bytes on queue */
diff --git a/arch/x86/include/uapi/asm/sembuf.h b/arch/x86/include/uapi/asm/sembuf.h
index 89de6cd9f0a7..7c1b156695ba 100644
--- a/arch/x86/include/uapi/asm/sembuf.h
+++ b/arch/x86/include/uapi/asm/sembuf.h
@@ -21,9 +21,9 @@ struct semid64_ds {
 	unsigned long	sem_ctime;	/* last change time */
 	unsigned long	sem_ctime_high;
 #else
-	__kernel_time_t	sem_otime;	/* last semop time */
+	long		sem_otime;	/* last semop time */
 	__kernel_ulong_t __unused1;
-	__kernel_time_t	sem_ctime;	/* last change time */
+	long		sem_ctime;	/* last change time */
 	__kernel_ulong_t __unused2;
 #endif
 	__kernel_ulong_t sem_nsems;	/* no. of semaphores in array */
diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
index 644421f3823b..f0305dc660c9 100644
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ b/arch/x86/include/uapi/asm/shmbuf.h
@@ -16,9 +16,9 @@
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
+	__kernel_long_t		shm_atime;	/* last attach time */
+	__kernel_long_t		shm_dtime;	/* last detach time */
+	__kernel_long_t		shm_ctime;	/* last change time */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	__kernel_ulong_t	shm_nattch;	/* no. of current attaches */
diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
index 9fe4881557cb..af95aa89012e 100644
--- a/include/uapi/asm-generic/msgbuf.h
+++ b/include/uapi/asm-generic/msgbuf.h
@@ -13,9 +13,9 @@
  * everyone just ended up making identical copies without specific
  * optimizations, so we may just as well all use the same one.
  *
- * 64 bit architectures typically define a 64 bit __kernel_time_t,
- * so they do not need the first three padding words.
- * On big-endian systems, the padding is in the wrong place.
+ * 64 bit architectures use a 64-bit long time field here, while
+ * 32 bit architectures have a pair of unsigned long values.
+ * On big-endian systems, the lower half is in the wrong place.
  *
  * Pad space is left for:
  * - 2 miscellaneous 32-bit values
@@ -24,9 +24,9 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 #if __BITS_PER_LONG == 64
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
+	long		 msg_stime;	/* last msgsnd time */
+	long		 msg_rtime;	/* last msgrcv time */
+	long		 msg_ctime;	/* last change time */
 #else
 	unsigned long	msg_stime;	/* last msgsnd time */
 	unsigned long	msg_stime_high;
diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index 0bae010f1b64..137606018c6a 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -13,9 +13,8 @@
  * everyone just ended up making identical copies without specific
  * optimizations, so we may just as well all use the same one.
  *
- * 64 bit architectures use a 64-bit __kernel_time_t here, while
+ * 64 bit architectures use a 64-bit long time field here, while
  * 32 bit architectures have a pair of unsigned long values.
- * so they do not need the first two padding words.
  *
  * On big-endian systems, the padding is in the wrong place for
  * historic reasons, so user space has to reconstruct a time_t
@@ -29,8 +28,8 @@
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
 #if __BITS_PER_LONG == 64
-	__kernel_time_t	sem_otime;	/* last semop time */
-	__kernel_time_t	sem_ctime;	/* last change time */
+	long		sem_otime;	/* last semop time */
+	long		sem_ctime;	/* last change time */
 #else
 	unsigned long	sem_otime;	/* last semop time */
 	unsigned long	sem_otime_high;
diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index e504422fc501..2bab955e0fed 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -13,9 +13,9 @@
  * everyone just ended up making identical copies without specific
  * optimizations, so we may just as well all use the same one.
  *
- * 64 bit architectures typically define a 64 bit __kernel_time_t,
- * so they do not need the first two padding words.
- * On big-endian systems, the padding is in the wrong place.
+ * 64 bit architectures use a 64-bit long time field here, while
+ * 32 bit architectures have a pair of unsigned long values.
+ * On big-endian systems, the lower half is in the wrong place.
  *
  *
  * Pad space is left for:
@@ -26,9 +26,9 @@ struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
 #if __BITS_PER_LONG == 64
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
+	long			shm_atime;	/* last attach time */
+	long			shm_dtime;	/* last detach time */
+	long			shm_ctime;	/* last change time */
 #else
 	unsigned long		shm_atime;	/* last attach time */
 	unsigned long		shm_atime_high;
-- 
2.20.0

