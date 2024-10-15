Return-Path: <linux-arch+bounces-8145-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DB699DB8A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 03:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B62BB209A8
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8E16F839;
	Tue, 15 Oct 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9iXoM+8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA515B96E;
	Tue, 15 Oct 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955903; cv=none; b=e0Sw8MO0HY6PiFdYlbButC1DRQo5kwh5d9+YNoiZqBOSxHhyYmJN48rOR7lrizdAmEScGE2EBfcQ07cnAIy/h0r2qx+ibBJd61Lsxs3gfZbYG5GrkWaeQOTfZqJqDGbm8zKNJtII5Z4uSIFvBWCravJjb8KwLFEbhvBwzO/3KNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955903; c=relaxed/simple;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lW+wk2Tk0eUqPxlND+NWQCbQ8vnNlj1nnvzskNYPSKV4X25n0gV2e/JlsmZ6P8QVtdc/Nz8cfLkteVc9+OtjCDZH0SCnpGIqGaDYgKSOroLOTCJKkl7HgCND20jlOtYtTgZN/yW02//jqoaz+G5I47kJ3uqFx73XcWZYNqZC2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9iXoM+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42DFC4CEC6;
	Tue, 15 Oct 2024 01:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728955903;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9iXoM+8DYwt70jj7pT2hfKojGjo6ojgsnYH3ORt1Unrh5UxZLBvQPiAECmrdNCQC
	 NOmG9xv8kuDfpnqdLuZKTp9ubrdFMavHnvjGeJXd4WeR0u8Hu6S/D24bKcOb/3e/2p
	 m61CR3scvyBvO5CBJsf6pPxKZh3D2VaLfYh/7nt60HAbTgdvsc84fu4vxolDz6wobQ
	 1wBUdf3fOaDJgQTjGPYfqYLUPB6dM+ld6zHEyb4gTsji+D0c5gwvHNKeoW3Gugcnmi
	 45vnllOAqAaMA7oJymsEhimFibF4VbuDdIBcpzmPOqRjHIErPT7iJ1JNBRhBgC0+iM
	 wPYRw2SZFx1Ew==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH v16 16/18] selftests/ftrace: Add a test case for repeating register/unregister fprobe
Date: Tue, 15 Oct 2024 10:31:38 +0900
Message-ID: <172895589871.107311.13693485408514512047.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172895571278.107311.14000164546881236558.stgit@devnote2>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

This test case repeats define and undefine the fprobe dynamic event to
ensure that the fprobe does not cause any issue with such operations.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc
new file mode 100644
index 000000000000..b4ad09237e2a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - Repeating add/remove fprobe events
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=$FUNCTION_FORK
+REPEAT_TIMES=64
+
+for i in `seq 1 $REPEAT_TIMES`; do
+  echo "f:myevent $PLACE" >> dynamic_events
+  grep -q myevent dynamic_events
+  test -d events/fprobes/myevent
+  echo > dynamic_events
+done
+
+clear_trace


