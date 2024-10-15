Return-Path: <linux-arch+bounces-8131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE7799DB53
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 03:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC01D1C21591
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDDF15688C;
	Tue, 15 Oct 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0gGcZ+Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E52B9CD;
	Tue, 15 Oct 2024 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955739; cv=none; b=UGlxtn1vgirD5tKeIsfwJ4hy2UEye2vHOXzAVeki1bDACRi3bNga09Mjm6kgEyx9PnvVeiVUB4Ej2vEsuaDk5eGAdE79poYGynk+mL6b7YRZTUhahYfr2mKPXb7UB8anvEs/GXE5UxjxWU9ARqoOdtynS8X0EKZ67EprA4By7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955739; c=relaxed/simple;
	bh=Bx7Z+eL127skZaVoMHO7+kp66v/K+hqkcje2iVhlIzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3L7dTe9c65d7n3m00STEcSjl6/HP776FX8OV28Nzmf+cik4REekF3zX0m+9BeB0Ko+5BQ9hgG/DSyk3sBCoaOkkhCq9VqWlDdFFtFzS89J0H3URXYL217OxtessWzIJenZN6TGd/vXjadtNTwEQsO4ZNPwGDLIuM1AiSnoASRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0gGcZ+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4141C4CEC3;
	Tue, 15 Oct 2024 01:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728955738;
	bh=Bx7Z+eL127skZaVoMHO7+kp66v/K+hqkcje2iVhlIzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0gGcZ+QI8SZMY+FzIu9CHHwWlVBixdSAULXP/j9kAYDevNRw4NCOsCV+/nMFjY7B
	 sZqXTZvf8bAnUwnY9UgelODnb6ki0v7LDbAMOPs/bQbKybzudTBNrtf8sjCVGVZOdW
	 C8f8yDKHLebuW6LsOJDuFheJRowna+LtdzOyCsy2hZ+e/ZsPXrJGsP6mIPm8vAaMX1
	 E2vJI5fuw+lXn1KQE00vha/0oKS0y1rRTDAAUVoaJalN1Iv1Aig8FF2+98zhzS4/S7
	 692rDMZOtnj+NKIwfVqwA0e6RJEpvPMIWeneuIiOoOWo5VogAV9V4ZKT/VNm0qfFz8
	 zT1bg4rRsH7IQ==
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
Subject: [PATCH v16 02/18] tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
Date: Tue, 15 Oct 2024 10:28:53 +0900
Message-ID: <172895573350.107311.7564634260652361511.stgit@devnote2>
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

Rename ftrace_regs_return_value to ftrace_regs_get_return_value as same as
other ftrace_regs_get/set_* APIs. arm64 and riscv are already using this
new name.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Changes in v16:
  - Simplified according to the recent change.
 Changes in v6:
  - Moved to top of the series.
 Changes in v3:
  - Newly added.
---
 include/linux/ftrace_regs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index b78a0a60515b..be1ed0c891d0 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -22,7 +22,7 @@ struct ftrace_regs;
 	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)


