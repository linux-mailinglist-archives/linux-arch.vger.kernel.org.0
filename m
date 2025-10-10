Return-Path: <linux-arch+bounces-14008-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65245BCDD5B
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217325468CA
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1C2FB084;
	Fri, 10 Oct 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXi92g/s"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017F32FB0BC
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110937; cv=none; b=D/LRK+v9p/WNJb3BmXzrH43UiUN+9fT/2MAJ9QyuuNH8SVPxN1Wfzkm/LSV5ceL9SmMrwOlCReRZo0lbmBL0TBdPCPxOq4xoQTLTP2aFGyOgysC1woLyp28lr1h0pc4UtAsRvEsakMtZLJ26TfSVAXdqkkxipRFQ0gvn0RWrluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110937; c=relaxed/simple;
	bh=tUCxDYx2/0NN5QR1DEvZrfPrIv3zYWsV4oVjHSBsnzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJk8Vm86u2QjdDdUyxrA//iR5ibEMbo6giO9sT/rnOdRE1ve+8Dg81NVI7BjGzW5SRGTtXOinNL159psKo+ve2nEfup5plV3J4ks6MJFY9m857X0ZXaChbyHSocKAP+/50C/MrSbVA6SYFeyDcC8/So6yG2ESFgYuVyLl1ekIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXi92g/s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760110935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypuA88VHIrtZCycTQvLRbp4fTjYOiPnVr/lgVBnkLI0=;
	b=AXi92g/sdqnUTFhWSm3/RSKFDv02lv5kjkJI/C3xG/4Tay9BTMlJUiu3cx1l7slbW2cXnu
	kAOxLzGlOKk3O7hge/2RqlXCFy1UjmX19ZiFWs7a9RX7sqy10nMdG5V+KzhYXmhj4BggoJ
	av7TsZ3ehO0HFIWLvUSTsS8Zt34CSSg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-7bEM6FEUOcOziUsCCagKng-1; Fri,
 10 Oct 2025 11:42:10 -0400
X-MC-Unique: 7bEM6FEUOcOziUsCCagKng-1
X-Mimecast-MFC-AGG-ID: 7bEM6FEUOcOziUsCCagKng_1760110923
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A5C2195609D;
	Fri, 10 Oct 2025 15:42:03 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.224.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EFB11800576;
	Fri, 10 Oct 2025 15:41:47 +0000 (UTC)
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
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: [PATCH v6 05/29] jump_label: Add annotations for validating noinstr usage
Date: Fri, 10 Oct 2025 17:38:15 +0200
Message-ID: <20251010153839.151763-6-vschneid@redhat.com>
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

Deferring a code patching IPI is unsafe if the patched code is in a
noinstr region.  In that case the text poke code must trigger an
immediate IPI to all CPUs, which can rudely interrupt an isolated NO_HZ
CPU running in userspace.

Some noinstr static branches may really need to be patched at runtime,
despite the resulting disruption.  Add DEFINE_STATIC_KEY_*_NOINSTR()
variants for those.  They don't do anything special yet; that will come
later.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/jump_label.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index fdb79dd1ebd8c..c4f6240ff4d95 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -388,6 +388,23 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_FALSE_RO(name)	\
 	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT
 
+/*
+ * The _NOINSTR variants are used to tell objtool the static key is allowed to
+ * be used in noinstr code.
+ *
+ * They should almost never be used, as they prevent code patching IPIs from
+ * being deferred, which can be problematic for isolated NOHZ_FULL CPUs running
+ * in pure userspace.
+ *
+ * If using one of these _NOINSTR variants, please add a comment above the
+ * definition with the rationale.
+ */
+#define DEFINE_STATIC_KEY_TRUE_NOINSTR(name)					\
+	DEFINE_STATIC_KEY_TRUE(name)
+
+#define DEFINE_STATIC_KEY_FALSE_NOINSTR(name)					\
+	DEFINE_STATIC_KEY_FALSE(name)
+
 #define DECLARE_STATIC_KEY_FALSE(name)	\
 	extern struct static_key_false name
 
-- 
2.51.0


