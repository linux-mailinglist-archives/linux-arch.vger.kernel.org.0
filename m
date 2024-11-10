Return-Path: <linux-arch+bounces-8954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF2F9C3388
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 16:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C188B21327
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D4F132132;
	Sun, 10 Nov 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBvygyV/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA914594A;
	Sun, 10 Nov 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253914; cv=none; b=pRs4aAVTpYQOUB6t2e5N/UtbyHja0cgB4dmOZoZwiM5ZgfDXwiWwk5aiylVPf5dDh6wLQzQ/RNLpEa3iMTx2fV7KdsRJqH91IW6wwkblsC6ek6OoSyJfxspzWNOxfec8bfTOFVdwJJ3pTMBtugPH/s95cczKJpiXN1mQwp1JhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253914; c=relaxed/simple;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2oPkj3AEAWsl4PzpQINjxdYIn9R+OO/hBqbdcPCcmIGzHld4/uPdffCJ1+V7Rqg7LlVeqSQ2iqm1qju7wtlH/zkWieNbdMOgqzMNTJPBrC+0te99oKsHStTanP2vExmGK5UGrDkdcimt0v5ULseC+gS93zUi5o2/BqNRA+EWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBvygyV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12225C4CECD;
	Sun, 10 Nov 2024 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731253914;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBvygyV/Mjvld0aIkiXZXIflBOJfZRlCAqNUvBK0dOZan07Uqw16bhnmkC3Z/QcIy
	 27481oNJ1ysDhJJdYcJX3Ul8cO0Ela/l6A6n00UdLBi8FRhY+WeKJhUe6bU0Bg/LDX
	 vZn5Hz99AzI02syK1CFYF5wSUEoK0BZWHVFcmZk+TTAm+P6rzd4dizTN0LRea5gnxE
	 5RcDF2piiKuSmIHB97e0UXEujC2rs75K0Y6RFolARtr1RimygrX4SJ5zbmyLjvqioK
	 UOhKRhqvK0Uf+4kW73FvkxgrmKXZeejmOevl00kephjz9Gd6GWY+Eg4eyXItburk+u
	 wcbfQgiKjvg4Q==
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
Subject: [PATCH v19 15/19] selftests: ftrace: Remove obsolate maxactive syntax check
Date: Mon, 11 Nov 2024 00:51:49 +0900
Message-ID: <173125390957.172790.2130011540406916936.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173125372214.172790.6929368952404083802.stgit@devnote2>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
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


