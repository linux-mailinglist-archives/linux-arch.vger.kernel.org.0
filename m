Return-Path: <linux-arch+bounces-14021-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27990BCDDD3
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18BA402F69
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EAF26B759;
	Fri, 10 Oct 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8nQZ3jR"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA5262FE7
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111136; cv=none; b=XBL1wCYCATbf/J5/41I+B9bbMfgu8asIaApo2Q3OY0ccXUt7BnwUPe3q4Ykz1eH9bNaMC6k4uihj1UKrAUfNGLx6I2Swqbfc+Z0xjICjm2gImiCnBSKi3LHiqWl48BsdpeVap93D79XCFvEgPSoRzq4TGgZA+Mkw7dj9L5TQ97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111136; c=relaxed/simple;
	bh=6gwRQ8N4NntZmmDXYAiLd7E5pLJgG/Y5Z/6jO4QqfeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQBHLe8ji8gv8soua608zlkOicHvqHQtzmbHGRsWr4Byj5SssjeyfCUsihcKe2/6NETDpvCAbN7MAqHMPWj8WuqwS1hOGdqvyboMKqXT9rP47WNrKTxvJjcZOZngIb0PrGW0pdHMM5+1X8mfjtl586ZyKSFFY5sQWVCmSQUD3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8nQZ3jR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760111133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVMYi0dEPlAN5oTp+GqnRcFGW49bLqYyv2ugGfsmT5k=;
	b=Z8nQZ3jRQkVBvMf6PpcUxKH3iFi1Zq7WRC6d1w35oruj3APhEVadM+lhNUccfyTJq4mZ0t
	Is0C6+2oAhfFY9KPnT7plf4x7PgWHCUJc+1zA39JrubbNJujd+K7X9KkcjyTD3Ru4zwMrF
	B98OC214qWGDiOOEyY9/b2+J+zxeWgY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-thi_Xds-PSmRA2dcrK3vtw-1; Fri,
 10 Oct 2025 11:45:30 -0400
X-MC-Unique: thi_Xds-PSmRA2dcrK3vtw-1
X-Mimecast-MFC-AGG-ID: thi_Xds-PSmRA2dcrK3vtw_1760111126
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E36721800576;
	Fri, 10 Oct 2025 15:45:25 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.224.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BFE21800576;
	Fri, 10 Oct 2025 15:45:10 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>,
	Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v6 18/29] sched/clock, x86: Mark __sched_clock_stable key as allowed in .noinstr
Date: Fri, 10 Oct 2025 17:38:28 +0200
Message-ID: <20251010153839.151763-19-vschneid@redhat.com>
In-Reply-To: <20251010153839.151763-1-vschneid@redhat.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Later commits will cause objtool to warn about static keys being used in
.noinstr sections in order to safely defer instruction patching IPIs
targeted at NOHZ_FULL CPUs.

__sched_clock_stable is used in .noinstr code, and can be modified at
runtime (e.g. time_cpufreq_notifier()). Suppressing the text_poke_sync()
IPI has little benefits for this key, as NOHZ_FULL is incompatible with an
unstable TSC anyway.

Mark it to let objtool know not to warn about it.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/clock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c1a028e99d2cd..e6ef71d74ac95 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -78,8 +78,11 @@ static DEFINE_STATIC_KEY_FALSE_RO(sched_clock_running);
  *
  * Similarly we start with __sched_clock_stable_early, thereby assuming we
  * will become stable, such that there's only a single 1 -> 0 transition.
+ *
+ * Allowed in .noinstr as an unstable TLC is incompatible with NOHZ_FULL,
+ * thus the text patching IPI would be the least of our concerns.
  */
-static DEFINE_STATIC_KEY_FALSE(__sched_clock_stable);
+static DEFINE_STATIC_KEY_FALSE_NOINSTR(__sched_clock_stable);
 static int __sched_clock_stable_early = 1;
 
 /*
-- 
2.51.0


