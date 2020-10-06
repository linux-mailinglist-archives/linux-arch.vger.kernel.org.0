Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03AA284999
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJFJqV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJFJqV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:46:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59DC061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:46:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i3so1357186pjz.4
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZNukGqivXQcGV5PlGwWwQGP0z/tZaH3aPXDvp4XDIk=;
        b=HwDVM7QxcybG4EvFCugsftAH3oo2UXNwOj1XsI9VmAT1J8+7BxUyf6mipJ6c1LGllL
         XM7A544J+jGITSFqpAwwvKon9HIhMNmv4EZ2zLyD2xz4ljQPifBMaXKXSidjOIA8z1BR
         6m3s7i0AdnXPpPEHjlwYoQVQXpAX6t8kWtJOAhg531IXV0FDdUCi3qp2lD0ZeLeSJZcE
         o0upzVXVQZAOr27jq+RD9v6U0pi28NG4hXPYo/sa9qGW+whF5C0sdHjahUXtwaeKdc5j
         +2ELSQ6SGLkWM37iaEK0n5fcc2jp0wWP2tiLD9vnv/aJK4+6lyHcoblRD1L9gM2I0ezL
         8Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZNukGqivXQcGV5PlGwWwQGP0z/tZaH3aPXDvp4XDIk=;
        b=lSVxo/vVnRGT6EUkd7hqbsW4cHEb63wAa9yZrH6cNjG4Y5DPvyk1Dvhn3VQNWew4Y7
         bgEUNQUM4pA54OhKCfyUxgiBQHYWZUuDHsjiuptPsHbaiaGWzLFZMdkHCVC7PMGspZyP
         TtaZcUoQ0VzTxLpTBDVxFMPQEVWV7e3YGUipvlEYytu2sHU8/p5BDHd8UPB5n1pkRbRF
         +wn1Xztu3FnkYOQ7kAgsdPMIzEKYvmo0LLLqxpm/koKa8K1RsQbklfsmAzjA4mt1T0X8
         cxqe8HIaG7Ok12j6xeyEEIP2eZeMb0OhiGHC01QoZKE7MvtB1IrvPXKAWxC2DcxdCVvd
         3byQ==
X-Gm-Message-State: AOAM530waV1ODfvCOPK31SaIpsU4gLG+7hoMnTWUnnOD8MKQH6aBbev3
        +rAUQe+ZJgtAPPaN6+11c/g=
X-Google-Smtp-Source: ABdhPJwhamsYAscwEKB1xEdqZNh/5hm2Dtd5RZYllLmmvutA/ymcNTYBKeQFcsl7jNuJW/XBQbQByw==
X-Received: by 2002:a17:902:bc81:b029:d2:2988:4781 with SMTP id bb1-20020a170902bc81b02900d229884781mr2460796plb.50.1601977580422;
        Tue, 06 Oct 2020 02:46:20 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id l9sm2198899pjz.11.2020.10.06.02.46.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:46:19 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id B8DA420390F516; Tue,  6 Oct 2020 18:46:17 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 19/21] um: host: posix host operations
Date:   Tue,  6 Oct 2020 18:44:28 +0900
Message-Id: <63a3d215a0e430152020b3ef2d1f850fa8bb23c4.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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

