Return-Path: <linux-arch+bounces-330-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED327F3996
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 23:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480F8282A13
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1355C3D;
	Tue, 21 Nov 2023 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd9pvD4E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AC5191;
	Tue, 21 Nov 2023 14:56:59 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cf6373ce31so2155055ad.0;
        Tue, 21 Nov 2023 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700607419; x=1701212219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Joh8uuUk19mBxNee66MMAzQ/m9SU9DPYEeo2rbFlN7I=;
        b=jd9pvD4EsjHTio0o0qDAXju7073NsXRmfaOX2MLIhCGGAHELj4coEMtmG1HMyU2ag1
         9FSstQ9cE+ZsM5tD35F4d6gIFIeqymUueUQaxJTVqFEZOStF7TJBvXUCu8o4H6VPd4tA
         Pe8afH74n9uR8zuMTyJxAKkwtJRx1JQyckIvZhSQ8du565h/T/SmQCqWiR6OUtgSLASc
         Xah+8ggptcoufzPz0fX6eTn/ulzqBK6XoH4p7YRK0+ol2H2w5oBgXvrufzmuXmnjR5ds
         3UQoulKg3vYzLNpCp9dHnuW3x6tMsl/ypeewMDJ7rkhNa1qZ2UGQ5XUHr+u5MFnxF4uD
         KNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607419; x=1701212219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Joh8uuUk19mBxNee66MMAzQ/m9SU9DPYEeo2rbFlN7I=;
        b=AqSXn+tTmkDzL6TwF+g1orMouTinMfjmR6+dd6ztXwX+8t5ZDo13kaCjwrHvBTB0Af
         vHAMAg/N+msXuy17mCsKoYPSJedoYpxZv+KbNnhcOjUJPKBJ0SeGwkNUfwFLbfquSjrE
         H0Mi3o50dkqqz/gWwQ4irMAcPFQOkXGz2jQQ3qqdzT7dQqnllBtXgosq6x7dIQmCte7j
         SBoXYRWEtG8nlFITRs7721AY6yMqxom81KA7xUnV67ttKAeB2T3zYUHXg931e1cHFxJu
         UOf9FnzgqioNPF/b9lEz8BKAWfy6iAuoIu+x38gwLVSp0L1EwdegM6IPdLXd4FlVzrdX
         lyKw==
X-Gm-Message-State: AOJu0Yy8/eEFQXwZLEmxx9+TuUGVdTilSJCZYRfoRHiBsLbZkkoGyADO
	ObR2AyYO/Y3tA+fAczdF6NY=
X-Google-Smtp-Source: AGHT+IEF6WsI9IKqvQRbVbMHIddWP6SHyLEB9w/cjDLBvWk5i+07QkCWj/moZT9nk/fAWHTTOBYE3g==
X-Received: by 2002:a17:902:da91:b0:1ce:5ca7:1070 with SMTP id j17-20020a170902da9100b001ce5ca71070mr1173646plx.16.1700607419173;
        Tue, 21 Nov 2023 14:56:59 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7377:923f:1ff3:266d])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001cc47c1c29csm8413189plt.84.2023.11.21.14.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:56:58 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH 06/14] tools headers UAPI: Update tools's copy of unistd.h header
Date: Tue, 21 Nov 2023 14:56:41 -0800
Message-ID: <20231121225650.390246-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121225650.390246-1-namhyung@kernel.org>
References: <20231121225650.390246-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/asm-generic/unistd.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 76d946445391..756b013fb832 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -816,15 +816,21 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
-
 #define __NR_cachestat 451
 __SYSCALL(__NR_cachestat, sys_cachestat)
-
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+#define __NR_map_shadow_stack 453
+__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
+#define __NR_futex_wake 454
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
+#define __NR_futex_wait 455
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
+#define __NR_futex_requeue 456
+__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 457
 
 /*
  * 32 bit systems traditionally used different
-- 
2.43.0.rc1.413.gea7ed67945-goog


