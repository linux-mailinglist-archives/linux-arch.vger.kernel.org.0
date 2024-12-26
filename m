Return-Path: <linux-arch+bounces-9507-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 322479FC87D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 06:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5C21626FB
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 05:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5719750B;
	Thu, 26 Dec 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjcl9YPn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064B158874;
	Thu, 26 Dec 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735190099; cv=none; b=Y5KPXoPvmyLIK3m1op9P7kdx4/NDL+e5PXQ7LsOyWdy3swQEICIianlI7xE5htx92+1ifQN8kVGcR9QgS3lnDb6ofAN9p606hN+c01JZ4oAtRiQpj47/qzmNFWoKRKgVZ2t42CRH74SpusqjUBRH1C2W+5dTkglhZRa03STobPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735190099; c=relaxed/simple;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1LKCoNYVTyq8XP8qhio/kdthsSwraGV7dcMEmPPxyA4zfSSSfwCCpiE9TOUgde934wrsMD8XqFQBXVhQD3a5VrWAvca4xxo7ZaEkdxCtJSFsB8Ug8sacRYb7jhKPOEr+ArgBknhpElVOz3HY2hfIOmZN3lcpMYcC0kgE2jbwPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjcl9YPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5084BC4CED1;
	Thu, 26 Dec 2024 05:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735190099;
	bh=MTl3WOEWmkU7N1ZYT3IdZA3wW+cclx8nbkw1UKe91tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sjcl9YPnOGOa1fBg/hEgbwkarES+lX1zJc14KsNBsEgmaj8paWWgvbyzHvT4A/Zep
	 gSz11r+npZLtgauSRE2+rIz4PJ/0mLwhqv3SG3qY38QvKlDC9W4MsJ3jVtRtpHNqJo
	 TugJtqTasiv4M10Rl4DzctozQmToB5Pa9ZK2RhRFhJLN5b8hxbulvnWDdNxHxrKKUZ
	 Jnse9MGn5oXLK+9rjropy8duhi99t6jJkjJXlSoV45pV+2+u1JC2tsagpx+XHf0jld
	 ge0HUynD/t8UatVn0e2HXNwoWhU1EfPA5kjA/Fm78Fty3W6wd5d/Lfr3Gq95PQLIcz
	 AD+pMTTebgYlw==
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
Subject: [PATCH v22 17/20] selftests/ftrace: Add a test case for repeating register/unregister fprobe
Date: Thu, 26 Dec 2024 14:14:54 +0900
Message-ID: <173519009398.391279.4625924605120064761.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173518987627.391279.3307342580035322889.stgit@devnote2>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
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


