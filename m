Return-Path: <linux-arch+bounces-9345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C0B9EA4F2
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 03:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F59188BD6F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 02:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80581C7608;
	Tue, 10 Dec 2024 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpU9+oN8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FB199234;
	Tue, 10 Dec 2024 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796752; cv=none; b=VT9gctDI9qGtIamB+wyKs4iGGArHCav+CcBVhlnrjEBalcfI9oyS9YLdwrbO+8uaRwqaZqaRgRzvjj6xufLw48xYWGNiBa+wdAiaKe8JyeSXgoxkhg1lQuNRNAzy6eJQSilw6wKdDC2omlcIraPw0J2ZgzuVNwqzb6dm6dvlihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796752; c=relaxed/simple;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuQIODleyK2Olgh+NnIu4+/e1O3lrCR7RCasZU1EKeudtz46aIWgYX918NRE+lJBvPgQ8Nq4OrwyIFsJ7QoAur2uNngJEsePjr+SVAA544aNGlpkrZWRD4OqMjdAbiaO+8P6/jC0DVQwrSB2pY6tXf9ASa8Yu7EzhNbZaXUaSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpU9+oN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54480C4CED1;
	Tue, 10 Dec 2024 02:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796751;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpU9+oN8zT0DNK8zNUKYTS76uR1ss49VVkNT9tc4bj+HWlMFTEDfac7o/2eDCibZf
	 AXblBIeittXLrHGgVb+EUHFMa8hEZCnva5pXafIkhI1qw7yXW+M7wJ/RkqaTLYWjzu
	 7T7L4+S6QlfgfEEIj18WnojQYBmI182iki37gjaSiRWjhf4mqQOlw9KePX3CPe0b6D
	 bVkGltqCsZJHlSfpQSFEpkruIdfkaCYQIu6CDKZ81TKpspZYgo0sjw88cooRvqD1+y
	 wFM4a4U+RJ2vwXEhl9Y53aeI4nV0r311XLJPK10Smr0z+NiNUXDy8SrzxaMd1fe0Gx
	 AGEPeY4SBJMDg==
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
Subject: [PATCH v21 17/20] selftests/ftrace: Add a test case for repeating register/unregister fprobe
Date: Tue, 10 Dec 2024 11:12:26 +0900
Message-ID: <173379674599.973433.10962280538397238549.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173379652547.973433.2311391879173461183.stgit@devnote2>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
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


