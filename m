Return-Path: <linux-arch+bounces-7310-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB459795DE
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC671C21018
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62F01C3F17;
	Sun, 15 Sep 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmqTpx+d"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C996FDC;
	Sun, 15 Sep 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391388; cv=none; b=iQomfDZ2SbaezSPK0HWrqtqLTpm7FpI8m6VdWxaONzaq5JcsrsC7E/fdDJLoGQjiKfTW9vULmi0mPtgHr6B6yTEGX9ZYsM6a/xxCEAI3H//8zUflWuWPND+ff7yTfFPvTIP2TyPjQsj85ziAAZ+rae99mzJRIRVR728hGsUkTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391388; c=relaxed/simple;
	bh=rRKaxXYSGjy3uALX7x2T5UKwohPT1CQYjtafBUFpzTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFOTSDIe3I0UtmU3zBNktIARghG7i1bfFA91yQiLH6qs3oM8NctJh/IXB/2hnGjXVlUQ/dKdaIeL2u0KWR8juobHf4Etv2fZ1x5huYKFwl1xSzh1xfLxs1qJ3yoTcNmu4MGjHpS702aAF3HF/yvmKFrylQxpxYnkD2zNoFJJQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmqTpx+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B62CC4CEC3;
	Sun, 15 Sep 2024 09:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391388;
	bh=rRKaxXYSGjy3uALX7x2T5UKwohPT1CQYjtafBUFpzTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmqTpx+dX4GjhTefN+Hnazs4A+t4CT0D3ibpDaRyDpGUFAWC37KtLz8lRokMi2/r2
	 S3Uc3rqz7slF9JT7k48NcEkE55lCO6zz91DPzlOejZ9zIxTkqvGI4VfmKsZBHyWDs5
	 CIuaNqTcpP6wWAHohIdmgHhL9Rj01CFJ6VG6E6WfTU9yTGnEegML3j7/zdS/wtdNie
	 97vlrNSrCAMUgwQEQw0bcFh8tGgmvzelU19o35t+/n5WgH+m5AQM+toDRZ39KX84lz
	 96+FE16V2LFdnenDGl3gNO/X6rO+avO5CDHh4DStvYfbaDABhUEF72998M6pyiyxRp
	 nsmf3TGQKRRMg==
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
Subject: [PATCH v15 01/19] tracing: Add a comment about ftrace_regs definition
Date: Sun, 15 Sep 2024 18:09:42 +0900
Message-Id: <172639138232.366111.5798792996195278927.stgit@devnote2>
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

To clarify what will be expected on ftrace_regs, add a comment to the
architecture independent definition of the ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Changes in v8:
  - Update that the saved registers depends on the context.
 Changes in v3:
  - Add instruction pointer
 Changes in v2:
  - newly added.
---
 include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index eafe43a5fa0d..e684addf6508 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -117,6 +117,32 @@ extern int ftrace_enabled;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
+/**
+ * ftrace_regs - ftrace partial/optimal register set
+ *
+ * ftrace_regs represents a group of registers which is used at the
+ * function entry and exit. There are three types of registers.
+ *
+ * - Registers for passing the parameters to callee, including the stack
+ *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
+ * - Registers for passing the return values to caller.
+ *   (e.g. rax and rdx on x86_64)
+ * - Registers for hooking the function call and return including the
+ *   frame pointer (the frame pointer is architecture/config dependent)
+ *   (e.g. rip, rbp and rsp for x86_64)
+ *
+ * Also, architecture dependent fields can be used for internal process.
+ * (e.g. orig_ax on x86_64)
+ *
+ * On the function entry, those registers will be restored except for
+ * the stack pointer, so that user can change the function parameters
+ * and instruction pointer (e.g. live patching.)
+ * On the function exit, only registers which is used for return values
+ * are restored.
+ *
+ * NOTE: user *must not* access regs directly, only do it via APIs, because
+ * the member can be changed according to the architecture.
+ */
 struct ftrace_regs {
 	struct pt_regs		regs;
 };


