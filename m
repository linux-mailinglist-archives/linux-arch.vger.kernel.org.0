Return-Path: <linux-arch+bounces-8212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86499FDAE
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 03:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72B02807BF
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D861018870B;
	Wed, 16 Oct 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beAD2PKc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83BB1494DD;
	Wed, 16 Oct 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040434; cv=none; b=b6GtOKvshlfzidQygXDREuAr5ZiO4DKsNueubZ2B2ZBqMOrpop9tDFP0V1fd8YHTsIhQfjXN7EJtr33VV2XI1oN2Okwsd7TbuKpxP/ghV2abn0zVYSqP1tSc8ApQGiqeB+Ap10a3H9AANMDuzJH1dLc6h9IFktre2o8wQya8csQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040434; c=relaxed/simple;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8Jj/aP1OPKTSTR6pOT+iN+ZW3j/MUEgXqwcX+2Z/Waj5CvaUS8rBPuAUmooZxaj/5FwyiDNge0fJF1vI01+K7qb9OL4KYft6Xh0xggVBDKb6y8hHTeV8qQR1w0mXClBS3UgUPOROUW+LiRtOA4PBznzfcbPnHuG3Y4v+1XwIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beAD2PKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D13C4CED0;
	Wed, 16 Oct 2024 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040434;
	bh=wZEjksI48uEO6V4KtS7yN1QVU17ztXbJ6mD6JSkXebk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beAD2PKcENWns9uIwkOndh/OtIFPZcqZXOhB5h+7pOKnI92oDAqmTaeV8mzEoH5ag
	 IzWHBPKbXrcgeX9oalt2kIj8ebnkp0PHCG4INFVybrnKaziRIka7yZ8ck26LUMkBt3
	 tPxaLQi0OuwIS+UBX91WLcmfygTMauExpPkDpjQz7KSTVP/XUTx5KVfnYV5w1EAV6O
	 kPkH3npfIpEp4PGKoPckDuduDiZ7yPpLklPar/6dajUufYqTXQdBxBnts2aKDaFog1
	 3IsKTXvuc2r38rB/Qg2RoR4auQdQSt0UtS0gvlBIOQbiMAQGhbPbgNOazDc6J4O3TL
	 h3aNAYUsRfsRw==
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
Subject: [PATCH v17 13/16] selftests: ftrace: Remove obsolate maxactive syntax check
Date: Wed, 16 Oct 2024 10:00:28 +0900
Message-ID: <172904042858.36809.3858231452910525736.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172904026427.36809.516716204730117800.stgit@devnote2>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
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


