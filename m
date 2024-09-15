Return-Path: <linux-arch+bounces-7326-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452FB979610
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E584A280FF0
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E561C689B;
	Sun, 15 Sep 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njlTVvuv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61321C5781;
	Sun, 15 Sep 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391572; cv=none; b=ogpo+FOltY+c+eayIBIPch/l47el+0K8L2QaGpTDvkgapAC+MRs89828YmVtFOgMrA7KwbHxwxe1Ejbjnil/Irm35BsY+J1ZyHEh6QZiG+jCuUm86vfdjGOmvYhr8JHQaNlo1DjbGjHQuWb5FAaAxu1wNSebhpkTm6VKjPtM79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391572; c=relaxed/simple;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJk9wMB+f23TcXCE+RyA6gRAkJ8GU5ln3J5BlcqYyfeKyOWNcm+TJ6UEgMqDXunLuOsK9BqW5IC9JVL0fLXLi+EzWXftoP8yK/7lShc4HMgpCfxQPy/RYE3HgomTdkUeFLFugTCq3bj9PmBFr3hiwvwpPGHwMWH1tlJcwVh3Z9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njlTVvuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390FBC4CEC3;
	Sun, 15 Sep 2024 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391572;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njlTVvuvWKhaAR87Y5Jqvs6+RvEtUnsTr6nCMuGiehpwCnJv7Wssl5/RNzwPGsFw3
	 sAOb0xlI+MgTWcdPqREllTK2p2K6M3Rj3/lDcb/wJDAID8r/9MKjc7XCQXYC76gC/5
	 1vtbz06mr87IgYonEwNUeh8dH3WdZ51hAycS611vQBvUcetcd37WU4fJQe3g1iLE5B
	 iuRb9DtdUGBJdN6l4hBqfE6HESwE1Ddo3ossebuOl4IxilmkSbVruDCWssJdFwbDiM
	 YmhyXbYJPZKOmh8hsbBDO8GcJzjPiBcK8whXrfdSamWq2pHqsHGZKRQPbch3hUjlSo
	 IRPkoDa3b/JXQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH v15 17/19] selftests/ftrace: Add a test case for repeating register/unregister fprobe
Date: Sun, 15 Sep 2024 18:12:46 +0900
Message-Id: <172639156599.366111.4796784641569240820.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172639136989.366111.11359590127009702129.stgit@devnote2>
References: <172639136989.366111.11359590127009702129.stgit@devnote2>
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


