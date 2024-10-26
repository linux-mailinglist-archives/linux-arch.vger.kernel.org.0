Return-Path: <linux-arch+bounces-8607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E669B14D0
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 06:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200B21C20D2A
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 04:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4491117BB1E;
	Sat, 26 Oct 2024 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4ryEgMD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1716EB76;
	Sat, 26 Oct 2024 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729917510; cv=none; b=jaAkoia/1NHz0Ur6tRmy4XGg7BP7T6lJLxMfHJYQz0yL1x/teCW8y4jAccIT7HAO0AWCthomqZ0R5YHsOAk4LHSAnbFnFlMqQC3J6AGu42Y077gWXMAu+5RoH9hy1MXaWPSGcaQIH8cED1zERKTho5rj6VscihXbgkiMrDq1ac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729917510; c=relaxed/simple;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFpViwBNqayEn6SoVpaC6WNI6XFAvxdinhSQBbQMF2CiT6ILMXg+2bruu5XCp1Pogmmf6P9/hJFzxJqY8N9oxsO1ZoLuWxYpdam1MkEXS6nY4JYdeQ5dGloJGL6DOqOAp2t2xEhU5FrcX7e/20hng8kgBN0Q6lh6U6C2JphVF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4ryEgMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089DCC4CEC6;
	Sat, 26 Oct 2024 04:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729917509;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4ryEgMDAhTyCfeqkqIEPJGO7PLOAtIzBl0T2/fZ3DWYH+GANNkNhojRZIKI5luP6
	 g4O6rb5A17IgIxCKBM7IwgfxR+eVfF2qLr8HmPk7K7NLnvIR9ig1UxukDMTsjbTv5/
	 AYXHdDQjhbtA+kl0qcizmm8kPv2AEkQe2W6TNLG7rwtZeRNr90OYWERUi0kyI7SUzu
	 5xklGCmLTvIbF3QGKKArL8Lh60p5KvNddCwv39/KHqO8NKUvi2rY7W/Ydi8LmyROMD
	 S58+2b0b5jvr2eCfpIir+WVDOLL8q24k7eZE1jiFX0kiDJk3IgodQrMqcF53aP8BKn
	 XWAV3e/GaeMlQ==
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
Subject: [PATCH v18 14/17] selftests: ftrace: Remove obsolate maxactive syntax check
Date: Sat, 26 Oct 2024 13:38:24 +0900
Message-ID: <172991750455.443985.15014750299175393031.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172991731968.443985.4558065903004844780.stgit@devnote2>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
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


