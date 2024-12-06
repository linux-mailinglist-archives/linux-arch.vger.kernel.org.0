Return-Path: <linux-arch+bounces-9279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD2D9E61FC
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 01:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE22168FB3
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 00:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803E42AB3;
	Fri,  6 Dec 2024 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuxk5Sp5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57671B652;
	Fri,  6 Dec 2024 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443945; cv=none; b=nyx2xeXRlb5BuydVcIs8bqTny/0FqawUzsw/5I1LlVVPcyKfzXhGkaSJ5nuWUIgAlmNmm7r8mVR+d274Qwh4+ANG9S6Tlui21WdQqIPEvoYyX8fFVyJSxWXb/yDiO+QUus5Swm8XA8dY145Lm2N4n2A41tFJldCvmeH4uMjFp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443945; c=relaxed/simple;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHlj/4MWGs1FTqwrZZkV8uxxRNPV0pevvxjgj9EFTXCDA0O3ald+SsLS5sdTsvlYWEqlyymceH3tkixvy0/gYHRzxpFn2tMiCaLx4XbuAO/bMqIZY3sEkgEbAGoPVktOHLOW9n0hh96h+N5QV78G4zqklGkGoaMOAimKL8JGpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuxk5Sp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051B4C4CEDD;
	Fri,  6 Dec 2024 00:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733443944;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuxk5Sp5QYZHWLqltZM7ZMcX8AlKjCoH2mtf2oMdH0a9ljBQ1KOHNIJ+IHxeScLr5
	 SISSaBidYu13QUsA1fI47IhTYSthNE5ZGqirMxjofZDigTreaoDlR5l5BuDz5hyvNk
	 eQF1qEPGWoa5LEq11XckN6Ygd2Qbv2xqA/sI1tHzytXM8iD67eZTHKY0VOhalDxArO
	 6EMEu6+juYJyOpZMvmfMCXxaOEFAJpMUm1MJT9HMd9Mi818MR9DaBidRNt8hG51YaX
	 CkVlFSsJgC9hPRl2fbuTf/b7LfahSuBWy0dtPg+Gnbxc0YSSeTh+c9LPWG9g9enDpt
	 0Jch1wLBUg9Tg==
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
Subject: [PATCH v20 16/19] selftests/ftrace: Add a test case for repeating register/unregister fprobe
Date: Fri,  6 Dec 2024 09:12:19 +0900
Message-ID: <173344393958.50709.12251302243554551661.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173344373580.50709.5332611753907139634.stgit@devnote2>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
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


