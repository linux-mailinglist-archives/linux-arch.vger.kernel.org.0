Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD92FC90B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbhATDcL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732044AbhATC3v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83323C061757
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id md11so1204219pjb.0
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGQWaBCb6xyX2z4xSeInVBXId5ylF2dTazNBLRLKGXM=;
        b=BMy9fvohHTuuZFtfmSwgnSDTbHyIMRq0KxO/cQiJSRX9pOx3tQ1S3qeiIRq2nFgorW
         H9nMD9yw3FuMzdhrgDO8+2CeFrNFcHuerR4NzF2vK+b9RbTq+l3Y+3kIkNeFoGegQ+Dx
         RLag79cJQYDCXHtxKZ+0fqSMHPcHPDM2/oG5Yf/7Nmi3+H2f1LZnTmL/9MpgXjCUaez7
         SxdYNOI+Jya11+F/tWyBA9XJDusjYem8NyPhjDa+OkfpCr5bT1G7Cb7gCIz9wZYrzFA2
         /6iVcrT9ItdVVlDCAlHeTWT14FEbOS2ha7rAZesh2dd0RS3Q22MQa8hpnXzqSq+tlEAM
         Zdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGQWaBCb6xyX2z4xSeInVBXId5ylF2dTazNBLRLKGXM=;
        b=CXQBeky88aD7EwDySAgtx5TOpAMnISv4l6dKW/JEbh4FijDdEm0EXtH59DO4kcsN2x
         Lli4NL+CZNClSI5TDZP+/LyXFQl9RsltUaKV3f/rQ0zPjYUb+sLsvwYeTY34kzmbhRlS
         2WLQNClRfbu29lJGM+KqloyeP7FSL+1PFX/kfGVjdTKXsMXsLOnzDYUJof8Ll/FU80yQ
         ql56y+J34/njxRSMpaXba6dCYUSWkAMwg2KGgCWwG5SInQRhvnwHw67R1kv7SdtgCWwM
         tnAA5Q/Wbr53U+YdS9Z7oJz9Bew9gk6aqYmF/YUK+u4KwmzdAfzz9kdRkM5HI5kV+FLN
         JOww==
X-Gm-Message-State: AOAM530R8tY+tZb/91c7R84K7klbc9/3OyISj2UV04v0+ACcSVv+y4X4
        5/RgmhHoLhu2ka0tDRZPs9g=
X-Google-Smtp-Source: ABdhPJzS+ZvIcH2bOLf1L7oL+tkwQv/hlq+Wyml8shHJZY8UToQzQ3tujXzJrVDNVlyBRMFfvSNWKw==
X-Received: by 2002:a17:902:788b:b029:de:a2fb:3edf with SMTP id q11-20020a170902788bb02900dea2fb3edfmr7708782pll.66.1611109775958;
        Tue, 19 Jan 2021 18:29:35 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id g201sm404047pfb.81.2021.01.19.18.29.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:29:35 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id A592220442D40D; Wed, 20 Jan 2021 11:29:33 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 17/20] um: host: posix host operations
Date:   Wed, 20 Jan 2021 11:27:22 +0900
Message-Id: <42d405bb13ac4489d9cbdefa40b821d9eb4e14e1.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit implements LKL host operations for POSIX hosts.  The
operations are implemented to be portable in various POSIX OSs.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 tools/um/lib/Build        |   3 +
 tools/um/lib/jmp_buf.c    |  14 ++
 tools/um/lib/posix-host.c | 272 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 tools/um/lib/jmp_buf.c
 create mode 100644 tools/um/lib/posix-host.c

diff --git a/tools/um/lib/Build b/tools/um/lib/Build
index 77acd6f55e76..dddff26a3b4e 100644
--- a/tools/um/lib/Build
+++ b/tools/um/lib/Build
@@ -1,3 +1,6 @@
 include $(objtree)/include/config/auto.conf
+CFLAGS_posix-host.o += -D_FILE_OFFSET_BITS=64
 
 liblinux-$(CONFIG_UMMODE_LIB) += utils.o
+liblinux-$(CONFIG_UMMODE_LIB) += posix-host.o
+liblinux-$(CONFIG_UMMODE_LIB) += jmp_buf.o
diff --git a/tools/um/lib/jmp_buf.c b/tools/um/lib/jmp_buf.c
new file mode 100644
index 000000000000..fcb15bbaa38a
--- /dev/null
+++ b/tools/um/lib/jmp_buf.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <setjmp.h>
+#include <lkl_host.h>
+
+void lkl_jmp_buf_set(struct lkl_jmp_buf *jmpb, void (*f)(void))
+{
+	if (!setjmp(*((jmp_buf *)jmpb->buf)))
+		f();
+}
+
+void lkl_jmp_buf_longjmp(struct lkl_jmp_buf *jmpb, int val)
+{
+	longjmp(*((jmp_buf *)jmpb->buf), val);
+}
diff --git a/tools/um/lib/posix-host.c b/tools/um/lib/posix-host.c
new file mode 100644
index 000000000000..f7c170fd3fd9
--- /dev/null
+++ b/tools/um/lib/posix-host.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <limits.h>
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <sys/syscall.h>
+#include <lkl_host.h>
+
+/* Let's see if the host has semaphore.h */
+#include <unistd.h>
+
+#ifdef _POSIX_SEMAPHORES
+#include <semaphore.h>
+/* TODO(pscollins): We don't support fork() for now, but maybe one day
+ * we will?
+ */
+#define SHARE_SEM 0
+#endif /* _POSIX_SEMAPHORES */
+
+
+struct lkl_mutex {
+	pthread_mutex_t mutex;
+};
+
+struct lkl_sem {
+#ifdef _POSIX_SEMAPHORES
+	sem_t sem;
+#else
+	pthread_mutex_t lock;
+	int count;
+	pthread_cond_t cond;
+#endif /* _POSIX_SEMAPHORES */
+};
+
+struct lkl_tls_key {
+	pthread_key_t key;
+};
+
+void *lkl_mem_alloc(unsigned long mem)
+{
+	return malloc(mem);
+}
+
+void lkl_mem_free(void *mem)
+{
+	return free(mem);
+}
+
+void __attribute__((weak)) lkl_print(const char *str, int len)
+{
+	int ret __attribute__((unused));
+
+	ret = write(STDOUT_FILENO, str, len);
+}
+
+void lkl_panic(void)
+{
+	assert(0);
+}
+
+#define WARN_UNLESS(exp) do {						\
+		if (exp < 0)						\
+			lkl_printf("%s: %s\n", #exp, strerror(errno));	\
+	} while (0)
+
+static int _warn_pthread(int ret, char *str_exp)
+{
+	if (ret > 0)
+		lkl_printf("%s: %s\n", str_exp, strerror(ret));
+
+	return ret;
+}
+
+
+/* pthread_* functions use the reverse convention */
+#define WARN_PTHREAD(exp) _warn_pthread(exp, #exp)
+
+struct lkl_sem *lkl_sem_alloc(int count)
+{
+	struct lkl_sem *sem;
+
+	sem = malloc(sizeof(*sem));
+	if (!sem)
+		return NULL;
+
+#ifdef _POSIX_SEMAPHORES
+	if (sem_init(&sem->sem, SHARE_SEM, count) < 0) {
+		lkl_printf("sem_init: %s\n", strerror(errno));
+		free(sem);
+		return NULL;
+	}
+#else
+	pthread_mutex_init(&sem->lock, NULL);
+	sem->count = count;
+	WARN_PTHREAD(pthread_cond_init(&sem->cond, NULL));
+#endif /* _POSIX_SEMAPHORES */
+
+	return sem;
+}
+
+void lkl_sem_free(struct lkl_sem *sem)
+{
+#ifdef _POSIX_SEMAPHORES
+	WARN_UNLESS(sem_destroy(&sem->sem));
+#else
+	WARN_PTHREAD(pthread_cond_destroy(&sem->cond));
+	WARN_PTHREAD(pthread_mutex_destroy(&sem->lock));
+#endif /* _POSIX_SEMAPHORES */
+	free(sem);
+}
+
+void lkl_sem_up(struct lkl_sem *sem)
+{
+#ifdef _POSIX_SEMAPHORES
+	WARN_UNLESS(sem_post(&sem->sem));
+#else
+	WARN_PTHREAD(pthread_mutex_lock(&sem->lock));
+	sem->count++;
+	if (sem->count > 0)
+		WARN_PTHREAD(pthread_cond_signal(&sem->cond));
+	WARN_PTHREAD(pthread_mutex_unlock(&sem->lock));
+#endif /* _POSIX_SEMAPHORES */
+
+}
+
+void lkl_sem_down(struct lkl_sem *sem)
+{
+#ifdef _POSIX_SEMAPHORES
+	int err;
+
+	do {
+		err = sem_wait(&sem->sem);
+	} while (err < 0 && errno == EINTR);
+	if (err < 0 && errno != EINTR)
+		lkl_printf("sem_wait: %s\n", strerror(errno));
+#else
+	WARN_PTHREAD(pthread_mutex_lock(&sem->lock));
+	while (sem->count <= 0)
+		WARN_PTHREAD(pthread_cond_wait(&sem->cond, &sem->lock));
+	sem->count--;
+	WARN_PTHREAD(pthread_mutex_unlock(&sem->lock));
+#endif /* _POSIX_SEMAPHORES */
+}
+
+struct lkl_mutex *lkl_mutex_alloc(int recursive)
+{
+	struct lkl_mutex *_mutex = malloc(sizeof(struct lkl_mutex));
+	pthread_mutex_t *mutex = NULL;
+	pthread_mutexattr_t attr;
+
+	if (!_mutex)
+		return NULL;
+
+	mutex = &_mutex->mutex;
+	WARN_PTHREAD(pthread_mutexattr_init(&attr));
+
+	/* PTHREAD_MUTEX_ERRORCHECK is *very* useful for debugging,
+	 * but has some overhead, so we provide an option to turn it
+	 * off.
+	 */
+#ifdef DEBUG
+	if (!recursive)
+		WARN_PTHREAD(pthread_mutexattr_settype(
+				     &attr, PTHREAD_MUTEX_ERRORCHECK));
+#endif /* DEBUG */
+
+	if (recursive)
+		WARN_PTHREAD(pthread_mutexattr_settype(
+				     &attr, PTHREAD_MUTEX_RECURSIVE));
+
+	WARN_PTHREAD(pthread_mutex_init(mutex, &attr));
+
+	return _mutex;
+}
+
+void lkl_mutex_lock(struct lkl_mutex *mutex)
+{
+	WARN_PTHREAD(pthread_mutex_lock(&mutex->mutex));
+}
+
+void lkl_mutex_unlock(struct lkl_mutex *_mutex)
+{
+	pthread_mutex_t *mutex = &_mutex->mutex;
+
+	WARN_PTHREAD(pthread_mutex_unlock(mutex));
+}
+
+void lkl_mutex_free(struct lkl_mutex *_mutex)
+{
+	pthread_mutex_t *mutex = &_mutex->mutex;
+
+	WARN_PTHREAD(pthread_mutex_destroy(mutex));
+	free(_mutex);
+}
+
+lkl_thread_t lkl_thread_create(void* (*fn)(void *), void *arg)
+{
+	pthread_t thread;
+
+	if (WARN_PTHREAD(pthread_create(&thread, NULL, fn, arg)))
+		return 0;
+	else
+		return (lkl_thread_t) thread;
+}
+
+void lkl_thread_detach(void)
+{
+	WARN_PTHREAD(pthread_detach(pthread_self()));
+}
+
+void lkl_thread_exit(void)
+{
+	pthread_exit(NULL);
+}
+
+int lkl_thread_join(lkl_thread_t tid)
+{
+	if (WARN_PTHREAD(pthread_join((pthread_t)tid, NULL)))
+		return (-1);
+	else
+		return 0;
+}
+
+lkl_thread_t lkl_thread_self(void)
+{
+	return (lkl_thread_t)pthread_self();
+}
+
+int lkl_thread_equal(lkl_thread_t a, lkl_thread_t b)
+{
+	return pthread_equal((pthread_t)a, (pthread_t)b);
+}
+
+long lkl_gettid(void)
+{
+	return syscall(SYS_gettid);
+}
+
+struct lkl_tls_key *lkl_tls_alloc(void (*destructor)(void *))
+{
+	struct lkl_tls_key *ret = malloc(sizeof(struct lkl_tls_key));
+
+	if (WARN_PTHREAD(pthread_key_create(&ret->key, destructor))) {
+		free(ret);
+		return NULL;
+	}
+	return ret;
+}
+
+void lkl_tls_free(struct lkl_tls_key *key)
+{
+	WARN_PTHREAD(pthread_key_delete(key->key));
+	free(key);
+}
+
+int lkl_tls_set(struct lkl_tls_key *key, void *data)
+{
+	if (WARN_PTHREAD(pthread_setspecific(key->key, data)))
+		return (-1);
+	return 0;
+}
+
+void *lkl_tls_get(struct lkl_tls_key *key)
+{
+	return pthread_getspecific(key->key);
+}
+
+struct lkl_host_operations lkl_host_ops = {
+};
+
-- 
2.21.0 (Apple Git-122.2)

