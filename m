Return-Path: <linux-arch+bounces-14780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45022C5DE80
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 16:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 597514F307E
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C064C334C02;
	Fri, 14 Nov 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKKh3xDd"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31139334693
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133394; cv=none; b=Fg1peVaKZXDtdHQWOkCIHWWuuPn0M5YCV6iiCySX5+jd3hy/YCN8wJWeVtvr0ydszTxKFMYWDWRvC+bbn1Sw16PASXmocHzYgXZekiEm4AM7J3335UQxtXmJanC6tbGHDDKRmPH5P2oepAfP/oIwf36hWgPuMjZr+PI4+ss/Wd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133394; c=relaxed/simple;
	bh=bRhz7pzmAvyxE+4fka8gvMXEnIf9tOF0eDiG/K4GcEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ua84dPzKYynZTDr8hfvM4pgzDsHBVmJGqunGoo7FSqP+/g14SHON3dblt2c70RqCo2j7moEt2gdZClg2MxY/VZvb+3CAqvw2vmf1cNnuVXRSqVUStyXaysdLiMWLElkCZrBCZz79HMonpmBAvXBr6GFpKOge9lWRcdLKexIGTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKKh3xDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763133392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wtNiwO7mQgs61ieJ83HPyGKadANIMB4TUgH9LUJTDI=;
	b=FKKh3xDdmPJ12i8gUYU1qoOdJVpq5dCNJilfkoVcJGAy8b02Py2x9Gi+ZBhESV0JiFJpcT
	PhlurwJX3cv+SmXlcl9sj9OKxzC2zsia6dRRAjO1ZPeM2vSsdM2VnFwcwkKOfUr+8wMTfj
	z+cJKSlxRsIvslWZ7Mda6t0cMRu+/Xo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-KUYqLZu4MQq0ZGtzVQ5_Tw-1; Fri,
 14 Nov 2025 10:16:26 -0500
X-MC-Unique: KUYqLZu4MQq0ZGtzVQ5_Tw-1
X-Mimecast-MFC-AGG-ID: KUYqLZu4MQq0ZGtzVQ5_Tw_1763133376
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 286521956094;
	Fri, 14 Nov 2025 15:16:16 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.226.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF3DD1800451;
	Fri, 14 Nov 2025 15:15:59 +0000 (UTC)
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
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
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
	Petr Tesarik <ptesarik@suse.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v7 26/31] x86/jump_label: Add ASM support for static_branch_likely()
Date: Fri, 14 Nov 2025 16:14:23 +0100
Message-ID: <20251114151428.1064524-6-vschneid@redhat.com>
In-Reply-To: <20251114150133.1056710-1-vschneid@redhat.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A later commit will add some early entry code that only needs to be
executed if nohz_full is present on the cmdline, not just if
CONFIG_NO_HZ_FULL is compiled in. Add an ASM-callable static branch macro.

Note that I haven't found a way to express unlikely (i.e. out-of-line)
static branches in ASM macros without using extra jumps, which kind of
defeats the purpose. Consider:

  .macro FOOBAR
	  // Key enabled:  JMP .Ldostuff_\@
	  // Key disabled: NOP
	  STATIC_BRANCH_UNLIKELY key, .Ldostuff_\@ // Patched to JMP if enabled
	  jmp .Lend_\@
  .Ldostuff_\@:
	  <dostuff>
  .Lend_\@:
  .endm

Instead, this should be expressed as a likely (i.e. in-line) static key:

  .macro FOOBAR
	  // Key enabled:  NOP
	  // Key disabled: JMP .Lend_\@
	  STATIC_BRANCH_LIKELY key, .Lend\@ // Patched to NOP if enabled
	  <dostuff>
  .Lend_\@:
  .endm

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/include/asm/jump_label.h | 33 ++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 61dd1dee7812e..3c9ba3948e225 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -7,7 +7,38 @@
 #include <asm/asm.h>
 #include <asm/nops.h>
 
-#ifndef __ASSEMBLER__
+#ifdef __ASSEMBLER__
+
+/*
+ * There isn't a neat way to craft unlikely static branches in ASM, so they
+ * all have to be expressed as likely (inline) static branches. This macro
+ * thus assumes a "likely" usage.
+ */
+.macro ARCH_STATIC_BRANCH_LIKELY_ASM key, label, jump, hack
+1:
+.if \jump || \hack
+	jmp \label
+.else
+	.byte BYTES_NOP5
+.endif
+	.pushsection __jump_table, "aw"
+	_ASM_ALIGN
+	.long 1b - .
+	.long \label - .
+	/* LIKELY so bit0=1, bit1=hack */
+	_ASM_PTR \key + 1 + (\hack << 1) - .
+	.popsection
+.endm
+
+.macro STATIC_BRANCH_TRUE_LIKELY key, label
+	ARCH_STATIC_BRANCH_LIKELY_ASM \key, \label, 0, IS_ENABLED(CONFIG_HAVE_JUMP_LABEL_HACK)
+.endm
+
+.macro STATIC_BRANCH_FALSE_LIKELY key, label
+	ARCH_STATIC_BRANCH_LIKELY_ASM \key, \label, 1, 0
+.endm
+
+#else /* !__ASSEMBLER__ */
 
 #include <linux/stringify.h>
 #include <linux/types.h>
-- 
2.51.0


