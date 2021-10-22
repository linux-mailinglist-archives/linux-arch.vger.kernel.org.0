Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474A64379EA
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhJVPbE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhJVPbD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:31:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46353C061764;
        Fri, 22 Oct 2021 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NG3632i+4v3MDTRJw3HCsO0U7kLnqAJBZ49cEMZvijs=; b=PFKSGYIijyAVIlHtcYr/NeGAES
        eRm9M9jAOqCtZo1aJQ0b5X3dW0N963Ee7GMw8HlkYcd/ILutVlagUEHlYnm8kNvkUXuP748P2tNB7
        ZCQ3JYIyIgcAaqbnxKOWyVm8qoZoGum6NRc+y75pvSoUEsfX8+cb4jEHFfjh+eb59BvdKiwgjxOdw
        va5VV/Q9BOfyODRHXibbnr53rSzDwINtMJBPU+11GFw4zmmwEDWkM0xsDoJMjKTjvw1WHoU8azR0y
        T5ujCVssWBJE+DkQ/NV+SUa5xg/AedZ911VDBNNzZyId8ZUpb3kny/ocBXYbNxoo3mwvD/CvoDOur
        1O1vNOiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdwOE-00DyY9-U7; Fri, 22 Oct 2021 15:23:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7763E300288;
        Fri, 22 Oct 2021 17:23:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7D7992C0CA182; Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Message-ID: <20211022152104.555771734@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 17:09:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: [PATCH 7/7] selftests: proc: Make sure wchan works when it exists
References: <20211022150933.883959987@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This makes sure that wchan contains a sensible symbol when a process is
blocked. Specifically this calls the sleep() syscall, and expects the
architecture to have called schedule() from a function that has "sleep"
somewhere in its name. For example, on the architectures I tested
(x86_64, arm64, arm, mips, and powerpc) this is "hrtimer_nanosleep":

$ tools/testing/selftests/proc/proc-pid-wchan
ok: found 'sleep' in wchan 'hrtimer_nanosleep'

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211008235504.2957528-1-keescook@chromium.org
---
 tools/testing/selftests/proc/Makefile         |    1 
 tools/testing/selftests/proc/proc-pid-wchan.c |   69 ++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/proc/proc-pid-wchan.c

--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -8,6 +8,7 @@ TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-loadavg-001
 TEST_GEN_PROGS += proc-pid-vm
+TEST_GEN_PROGS += proc-pid-wchan
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-pid-wchan.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Make sure that wchan returns a reasonable symbol when blocked.
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+#define perror_exit(str) do { perror(str); _exit(1); } while (0)
+
+int main(void)
+{
+	char buf[64];
+	pid_t child;
+	int sync[2], fd;
+
+	if (pipe(sync) < 0)
+		perror_exit("pipe");
+
+	child = fork();
+	if (child < 0)
+		perror_exit("fork");
+	if (child == 0) {
+		/* Child */
+		if (close(sync[0]) < 0)
+			perror_exit("child close sync[0]");
+		if (close(sync[1]) < 0)
+			perror_exit("child close sync[1]");
+		sleep(10);
+		_exit(0);
+	}
+	/* Parent */
+	if (close(sync[1]) < 0)
+		perror_exit("parent close sync[1]");
+	if (read(sync[0], buf, 1) != 0)
+		perror_exit("parent read sync[0]");
+
+	snprintf(buf, sizeof(buf), "/proc/%d/wchan", child);
+	fd = open(buf, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			return 4;
+		perror_exit(buf);
+	}
+
+	memset(buf, 0, sizeof(buf));
+	if (read(fd, buf, sizeof(buf) - 1) < 1)
+		perror_exit(buf);
+	if (strstr(buf, "sleep") == NULL) {
+		fprintf(stderr, "FAIL: did not find 'sleep' in wchan '%s'\n", buf);
+		return 1;
+	}
+	printf("ok: found 'sleep' in wchan '%s'\n", buf);
+
+	if (kill(child, SIGKILL) < 0)
+		perror_exit("kill");
+	if (waitpid(child, NULL, 0) != child) {
+		fprintf(stderr, "waitpid: got the wrong child!?\n");
+		return 1;
+	}
+
+	return 0;
+}


