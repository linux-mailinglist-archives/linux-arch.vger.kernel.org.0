Return-Path: <linux-arch+bounces-7325-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5197960D
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603C12836A5
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30A91C6F56;
	Sun, 15 Sep 2024 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgLRop+f"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4B1C689B;
	Sun, 15 Sep 2024 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391560; cv=none; b=bDmh0Cl2Obh7kahGsd3PqfWvk15rcL9dnmLKhgWBUU8+Kxh7HBmezHbetAEw8eYoqA3S+cPGo4Toh1hm7ahvZZn/3bfW249ZuLI8MIx2fnnLw3ZqfDYfQWJObCpIUO1mBD2HT/WqS3piPKQSwmIMdmx8CdNOTbkNYpNXufXz1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391560; c=relaxed/simple;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBTfxLvmsfGRCZ0Ar3NKghOpy7dpSgwX1D6TbvtDq73AxzEFaH4gBZc+bZw8Xi9L66ODzzn3OyUFvEfPKHsobOxOCyWXBGfNewjem5cwdm4XBDTJuygPki6YNO35OKYvgW90SXpr+98fb3qrqKCv5Jugj/9Ncfb11u3OLEMP8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgLRop+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34E9C4CEC3;
	Sun, 15 Sep 2024 09:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391560;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IgLRop+f0EFbOh+YvBUrCrFW9D9SYC1Fqb8xzPaZOv6Eu8s1guT5nkUwyDWgGrv/y
	 VDEdf+v9WtiKZVZiZRnD2ATK9HtOYjBJcaAhF3UIY/bklOhHt7Ul9BzN/6NWg29m9x
	 fpKw25rpM4uXOUB/Rl5v+oEGuuJJCPJBAyOY9EnjqO+Kzu32Gy3X0JAYqpLuSc7e/c
	 dugpDGqcRpPbD7phdewx/Iax7yIR7FA6qbvPF9tq5joesULOUyd+r6mvFLzJeH9tlI
	 02dB+G36RkNJKOESGiymFo6ErXt+RdAK3MKshiojipxShb8an2idOw4ntlPsXUEPXb
	 ND9LuHRo+HQCQ==
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
Subject: [PATCH v15 16/19] selftests: ftrace: Remove obsolate maxactive syntax check
Date: Sun, 15 Sep 2024 18:12:35 +0900
Message-Id: <172639155503.366111.18154967940821774431.stgit@devnote2>
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

Since the fprobe event does not support maxactive anymore, stop
testing the maxactive syntax error checking.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 61877d166451..c9425a34fae3 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -16,9 +16,7 @@ aarch64)
   REG=%r0 ;;
 esac
 
-check_error 'f^100 vfs_read'		# MAXACT_NO_KPROBE
-check_error 'f^1a111 vfs_read'		# BAD_MAXACT
-check_error 'f^100000 vfs_read'		# MAXACT_TOO_BIG
+check_error 'f^100 vfs_read'		# BAD_MAXACT
 
 check_error 'f ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
 check_error 'f ^vfs_read+10'		# BAD_PROBE_ADDR


