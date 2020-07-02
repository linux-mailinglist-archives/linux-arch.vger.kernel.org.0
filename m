Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469992125B2
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGBOKR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgGBOKR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:10:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7125CC08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:10:17 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bj10so6134798plb.11
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZNukGqivXQcGV5PlGwWwQGP0z/tZaH3aPXDvp4XDIk=;
        b=LCNpiDJ/KaAd0ZPQi4BEkQklasSqb2wlfHVAYZiZPxD79xWaYuPdZj6MU/ZsiMnK0i
         vCqi+ht36XyfCR7yi/3h6jyYOE3ovSGhUH5YMMgfcod9pwGwYC3ToO953rMApe5cXSuc
         THqVtBvieyTQoZhWle33ynexoXXXpmFdh8mOh1oRHZTsCB/jmeR/Y0Pjyd3vhEtIxHvG
         3vAudIJro98W57x3w0cQnSHNQcbvndvdLboX3EqhEhziXPLia8P9cj9xnqaLYXFvWxow
         wmD4sJqV/sJniW+iUV82sIqE6aUJb3ZNKbsnDtnRHhRCWn4OYLu6XpsvsIEU5Fb/27XB
         I9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZNukGqivXQcGV5PlGwWwQGP0z/tZaH3aPXDvp4XDIk=;
        b=c3f3yCvS06LuTV0BfF1eRneDqnnaloKsApYNemVpOZxeP3JqicMkoZgUbbCvK1nWPN
         hpo1f7YV+j5SmBjNSAOiPz0KP91Ul1dLRdQ7pLUB5rzy/yQi1gekgg/O6O9dxlRKkHZb
         5u5wI9xdi5mwG/xmhuTiKsob/qRAhO7C686G32ywMvSip/6Tl+TNdL2KMQVujFr0YXjN
         ClO8XMXBmw6QMULeHu2cEPku5urnJYYJSJnyFkGBDu5PI12f8Yj5dHY2/Q7qN94HCBgK
         HuhEXFbUl5eE44wPFHKGxhFy/QFsZXRjO1J1EqESIx1UacraRU5n5TTOVLTOavsV6Xk+
         Rhwg==
X-Gm-Message-State: AOAM530/xdkIMYIIKJscCwjiHLRFLd1T6BYhPGfUNagFYeaIFbLgsQ/b
        PdqR8TqfHDQkNchkPU441QDedpa2mWQ=
X-Google-Smtp-Source: ABdhPJxXM7jliXWULuCpyI2wyiKmT3IYgUr98jmEcS4g9J29k9SCWT3wSbwT7U6T5FgKKQUQ3LqyMw==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr1133877pls.309.1593699016861;
        Thu, 02 Jul 2020 07:10:16 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id b21sm9225255pfp.172.2020.07.02.07.10.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:10:16 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 2A5CE202D31D85; Thu,  2 Jul 2020 23:10:14 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 19/21] um: host: posix host operations
Date:   Thu,  2 Jul 2020 23:07:13 +0900
Message-Id: <4bfa3679f685f3c0d731f7d95e826f4c7d6bddb6.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit implements LKL host operations for POSIX hosts.  The
operations are implemented to be portable in various POSIX OSs.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 tools/um/lib/Build        |   2 +
 tools/um/lib/posix-host.c | 292 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+)
 create mode 100644 tools/um/lib/posix-host.c

diff --git a/tools/um/lib/Build b/tools/um/lib/Build
index fc967af4104a..dddff26a3b4e 100644
--- a/tools/um/lib/Build
+++ b/tools/um/lib/Build
@@ -1,4 +1,6 @@
 include $(objtree)/include/config/auto.conf
+CFLAGS_posix-host.o += -D_FILE_OFFSET_BITS=64
 
 liblinux-$(CONFIG_UMMODE_LIB) += utils.o
+liblinux-$(CONFIG_UMMODE_LIB) += posix-host.o
 liblinux-$(CONFIG_UMMODE_LIB) += jmp_buf.o
diff --git a/tools/um/lib/posix-host.c b/tools/um/lib/posix-host.c
new file mode 100644
index 000000000000..b6b5b2902254
--- /dev/null
+++ b/tools/um/lib/posix-host.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <limits.h>
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <sys/syscall.h>
+#include <lkl_host.h>
+#include "jmp_buf.h"
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
+static void print(const char *str, int len)
+{
+	int ret __attribute__((unused));
+
+	ret = write(STDOUT_FILENO, str, len);
+}
+
+static void panic(void)
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
+static struct lkl_sem *sem_alloc(int count)
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
+static void sem_free(struct lkl_sem *sem)
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
+static void sem_up(struct lkl_sem *sem)
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
+static void sem_down(struct lkl_sem *sem)
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
+static struct lkl_mutex *mutex_alloc(int recursive)
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
+static void mutex_lock(struct lkl_mutex *mutex)
+{
+	WARN_PTHREAD(pthread_mutex_lock(&mutex->mutex));
+}
+
+static void mutex_unlock(struct lkl_mutex *_mutex)
+{
+	pthread_mutex_t *mutex = &_mutex->mutex;
+
+	WARN_PTHREAD(pthread_mutex_unlock(mutex));
+}
+
+static void mutex_free(struct lkl_mutex *_mutex)
+{
+	pthread_mutex_t *mutex = &_mutex->mutex;
+
+	WARN_PTHREAD(pthread_mutex_destroy(mutex));
+	free(_mutex);
+}
+
+static lkl_thread_t thread_create(void* (*fn)(void *), void *arg)
+{
+	pthread_t thread;
+
+	if (WARN_PTHREAD(pthread_create(&thread, NULL, fn, arg)))
+		return 0;
+	else
+		return (lkl_thread_t) thread;
+}
+
+static void thread_detach(void)
+{
+	WARN_PTHREAD(pthread_detach(pthread_self()));
+}
+
+static void thread_exit(void)
+{
+	pthread_exit(NULL);
+}
+
+static int thread_join(lkl_thread_t tid)
+{
+	if (WARN_PTHREAD(pthread_join((pthread_t)tid, NULL)))
+		return (-1);
+	else
+		return 0;
+}
+
+static lkl_thread_t thread_self(void)
+{
+	return (lkl_thread_t)pthread_self();
+}
+
+static int thread_equal(lkl_thread_t a, lkl_thread_t b)
+{
+	return pthread_equal((pthread_t)a, (pthread_t)b);
+}
+
+static long _gettid(void)
+{
+#ifdef	__FreeBSD__
+	return (long)pthread_self();
+#else
+	return syscall(SYS_gettid);
+#endif
+}
+
+static struct lkl_tls_key *tls_alloc(void (*destructor)(void *))
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
+static void tls_free(struct lkl_tls_key *key)
+{
+	WARN_PTHREAD(pthread_key_delete(key->key));
+	free(key);
+}
+
+static int tls_set(struct lkl_tls_key *key, void *data)
+{
+	if (WARN_PTHREAD(pthread_setspecific(key->key, data)))
+		return (-1);
+	return 0;
+}
+
+static void *tls_get(struct lkl_tls_key *key)
+{
+	return pthread_getspecific(key->key);
+}
+
+struct lkl_host_operations lkl_host_ops = {
+	.panic = panic,
+	.print = print,
+	.mem_alloc = (void *)malloc,
+	.mem_free = free,
+	.thread_create = thread_create,
+	.thread_detach = thread_detach,
+	.thread_exit = thread_exit,
+	.thread_join = thread_join,
+	.thread_self = thread_self,
+	.thread_equal = thread_equal,
+	.sem_alloc = sem_alloc,
+	.sem_free = sem_free,
+	.sem_up = sem_up,
+	.sem_down = sem_down,
+	.mutex_alloc = mutex_alloc,
+	.mutex_free = mutex_free,
+	.mutex_lock = mutex_lock,
+	.mutex_unlock = mutex_unlock,
+	.gettid = _gettid,
+	.tls_alloc = tls_alloc,
+	.tls_free = tls_free,
+	.tls_set = tls_set,
+	.tls_get = tls_get,
+	.jmp_buf_set = jmp_buf_set,
+	.jmp_buf_longjmp = jmp_buf_longjmp,
+};
+
-- 
2.21.0 (Apple Git-122.2)

