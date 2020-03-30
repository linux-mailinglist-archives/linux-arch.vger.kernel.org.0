Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A648197EE2
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 16:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgC3Osn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 10:48:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32909 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgC3Osn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 10:48:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id g18so6828737plq.0
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9RNoEzbbgw1c3biOrP2WMrvjOX1CmcwEAo3VDKIBII=;
        b=aSyzzFktASEqcZhmB14e5xHTl92y/72UvBBsaaRCAyWnWpmvbzGIjKCJdLPgee4I5X
         rOUfWVK6SavrVoysy9IwPaHWJZfnqzx9moJe0rUklBt7+DsCJBhW8tGaTUjzboAafJim
         xyeV9AiAc/YoUyc1uwRISMv8q/VDE8TkrAVJ7L2RnIM7Q7LFrb7chdsw+LKImkmltE4v
         sFGMnhLui+FWD3Uf33DFXUhdyYaQrzMElFKqPZHKp153XxzwvxcbS/yIX9TjcAl/lzBG
         WbZZIjfA/fYkmupRenjZWg9V5ymG10ie5ioXP2xEaJTstRDHG6OHLI6GngNWwHScVXzK
         y2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9RNoEzbbgw1c3biOrP2WMrvjOX1CmcwEAo3VDKIBII=;
        b=NGcStjghuI1z28rcRJH4cCWR+bkLB6T7H/lfdUQPSJAq3Tu7Gi10TohX/oZDW9/CXM
         sOheDj5tHA70ttLv27zsxs9s+pCJ1Z1jA/ubLTo5gbXoTAGauyi2sdC6cgaH+/57RxdA
         lU8L5HyzA3isfB/sGcjoC0oGHcQ5ozoozYPcFJQZM5hZyLgkVQ9rZ6CFbdtxkSD3N3dv
         LIpXqm2jHbRdTFdtQWKKOpIlcI5OweXtrgDEA+Z4VJPl4aFaY3npEGm+EEr9bRh3Beym
         RTQlXFWZ0Iwz4gwGL6Hz0uR22kyrU0BMiC0GwnDalv3y2dUwdjB/dsXHLkO153kFEely
         D3EQ==
X-Gm-Message-State: ANhLgQ0HxwMofKdhTQI7s9Z6lLM0FjvZG7bea8eJTWBwJcRAmwgiaBxC
        20k6/3IFqwZDk54khDHxHUU=
X-Google-Smtp-Source: ADFU+vvpiSFpS8RMWEin6rlzj/fguPJ1G741G/jqPjqHtucmPq88Qv8j6MmaYJJ+0UKvbolgIlkLTA==
X-Received: by 2002:a17:90a:240e:: with SMTP id h14mr13737086pje.5.1585579721277;
        Mon, 30 Mar 2020 07:48:41 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id c19sm10394552pfo.205.2020.03.30.07.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:48:40 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 0EFC4202804E3F; Mon, 30 Mar 2020 23:48:39 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Conrad Meyer <cem@FreeBSD.org>,
        Mark Stillwell <mark@stillwell.me>,
        Patrick Collins <pscollins@google.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Thomas Liebetraut <thomas@tommie-lie.de>,
        Yuan Liu <liuyuan@google.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 16/25] lkl tools: host lib: posix host operations
Date:   Mon, 30 Mar 2020 23:45:48 +0900
Message-Id: <3fabf7fce74f62cfdace9dbdc26d6e787ba618b8.1585579244.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

This commit implements LKL host operations for POSIX hosts.  The
operations are implemented to be portable in various POSIX OSs.

Cc: Conrad Meyer <cem@FreeBSD.org>
Cc: Mark Stillwell <mark@stillwell.me>
Cc: Patrick Collins <pscollins@google.com>
Cc: Pierre-Hugues Husson <phh@phh.me>
Cc: Thomas Liebetraut <thomas@tommie-lie.de>
Cc: Yuan Liu <liuyuan@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/lib/Build        |   2 +
 tools/lkl/lib/posix-host.c | 353 +++++++++++++++++++++++++++++++++++++
 2 files changed, 355 insertions(+)
 create mode 100644 tools/lkl/lib/posix-host.c

diff --git a/tools/lkl/lib/Build b/tools/lkl/lib/Build
index dba530424e4a..0e711e260a3a 100644
--- a/tools/lkl/lib/Build
+++ b/tools/lkl/lib/Build
@@ -1,8 +1,10 @@
 CFLAGS_config.o += -I$(srctree)/tools/perf/pmu-events
+CFLAGS_posix-host.o += -D_FILE_OFFSET_BITS=64
 
 liblkl-y += fs.o
 liblkl-y += net.o
 liblkl-y += jmp_buf.o
+liblkl-$(LKL_HOST_CONFIG_POSIX) += posix-host.o
 liblkl-y += utils.o
 liblkl-y += dbg.o
 liblkl-y += dbg_handler.o
diff --git a/tools/lkl/lib/posix-host.c b/tools/lkl/lib/posix-host.c
new file mode 100644
index 000000000000..4be1611a8942
--- /dev/null
+++ b/tools/lkl/lib/posix-host.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <stdlib.h>
+#include <sys/time.h>
+#include <time.h>
+#include <signal.h>
+#include <assert.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <time.h>
+#include <stdint.h>
+#include <sys/uio.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/syscall.h>
+#include <poll.h>
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
+static void print(const char *str, int len)
+{
+	int ret __attribute__((unused));
+
+	ret = write(STDOUT_FILENO, str, len);
+}
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
+static lkl_thread_t thread_create(void (*fn)(void *), void *arg)
+{
+	pthread_t thread;
+
+	if (WARN_PTHREAD(pthread_create(&thread, NULL, (void *)fn,
+					arg)))
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
+static unsigned long long time_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+
+	return 1e9*ts.tv_sec + ts.tv_nsec;
+}
+
+static void *timer_alloc(void (*fn)(void *), void *arg)
+{
+	int err;
+	timer_t timer;
+	struct sigevent se =  {
+		.sigev_notify = SIGEV_THREAD,
+		.sigev_value = {
+			.sival_ptr = arg,
+		},
+		.sigev_notify_function = (void *)fn,
+	};
+
+	err = timer_create(CLOCK_REALTIME, &se, &timer);
+	if (err)
+		return NULL;
+
+	return (void *)(long)timer;
+}
+
+static int timer_set_oneshot(void *_timer, unsigned long ns)
+{
+	timer_t timer = (timer_t)(long)_timer;
+	struct itimerspec ts = {
+		.it_value = {
+			.tv_sec = ns / 1000000000,
+			.tv_nsec = ns % 1000000000,
+		},
+	};
+
+	return timer_settime(timer, 0, &ts, NULL);
+}
+
+static void timer_free(void *_timer)
+{
+	timer_t timer = (timer_t)(long)_timer;
+
+	timer_delete(timer);
+}
+
+static void panic(void)
+{
+	assert(0);
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
+struct lkl_host_operations lkl_host_ops = {
+	.panic = panic,
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
+	.tls_alloc = tls_alloc,
+	.tls_free = tls_free,
+	.tls_set = tls_set,
+	.tls_get = tls_get,
+	.time = time_ns,
+	.timer_alloc = timer_alloc,
+	.timer_set_oneshot = timer_set_oneshot,
+	.timer_free = timer_free,
+	.print = print,
+	.mem_alloc = (void *)malloc,
+	.mem_free = free,
+	.gettid = _gettid,
+	.jmp_buf_set = jmp_buf_set,
+	.jmp_buf_longjmp = jmp_buf_longjmp,
+};
+
-- 
2.21.0 (Apple Git-122.2)

