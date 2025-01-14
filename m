Return-Path: <linux-arch+bounces-9773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7ADA10F2A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 19:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69364161FED
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 18:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0F1FDA92;
	Tue, 14 Jan 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEhJktr9"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5A20C48C
	for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877761; cv=none; b=l0rQ0yk5vsXbyuaqo6CAVzi3Uo2ppKhN2pGM25YRgsfDq/Ao3wvrrPbYrDkDEUwedJZeF9dk6O+zHxDbyodEYuOWrQGoIvcFOL+mz45pPoU0CLjzm6jNuHqtOqZ8zTVLF7/uBqsR5S51I5XAkrNR02SevCP7jbVjRR6AEFNIaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877761; c=relaxed/simple;
	bh=Sn4CkfGPBGkxtb+yEGlclR1Y9e/nLQScbrLRXCTxOxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IV7WbMRjBtyZ2iCNsOVvQtu98HFTNfAmKtxx2J7YjEreKodxyL54rhbSmcSdUX6QWthZOvhcIwnGH7tEVn4y/KpRsb2ENx/xzZf2BybkOybuOyQD0/35XjfFJt9dsipTaczUd8VEoSXYmKqpsN10RsJ1gB8JHUq3jGeeL6ZiNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEhJktr9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736877759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vO7Dcae3S+ckJLBtr7bo/IIVyHg02LNyvWNatP3bxFA=;
	b=IEhJktr9fqdLKFqJMquVWn6MDKEqrJJUSE4jWrbOfc3/Exew/vm6WiUFilFSlPOB7rDwkJ
	KCrlRTLgbxbgdilpu8ymB292Es4unf+ft402DlWHi1Jf20qR/0YwFRDn0eMH2t0G+O0M8P
	JzIXdM8Ss2UEamrN4JF2mcMrfuwqn6E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-79n9fhnhPJ65-rfaOeT4Rg-1; Tue,
 14 Jan 2025 13:02:34 -0500
X-MC-Unique: 79n9fhnhPJ65-rfaOeT4Rg-1
X-Mimecast-MFC-AGG-ID: 79n9fhnhPJ65-rfaOeT4Rg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69EBE19560AA;
	Tue, 14 Jan 2025 18:02:31 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.55])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60C94195608A;
	Tue, 14 Jan 2025 18:02:09 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v4 23/30] context_tracking: Turn CT_STATE_* into bits
Date: Tue, 14 Jan 2025 18:51:36 +0100
Message-ID: <20250114175143.81438-24-vschneid@redhat.com>
In-Reply-To: <20250114175143.81438-1-vschneid@redhat.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

A later patch will require to easily exclude CT_STATE_KERNEL from a genuine
a ct->state read CT_STATE_KERNEL, which requires that value being non-zero
and exclusive with the other CT_STATE_* values.

This increases the size of the CT_STATE region of the ct->state variable by
two bits.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking_state.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 0b81248aa03e2..eb2149b20baef 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -11,11 +11,11 @@
 
 enum ctx_state {
 	CT_STATE_DISABLED	= -1,	/* returned by ct_state() if unknown */
-	CT_STATE_KERNEL		= 0,
-	CT_STATE_IDLE		= 1,
-	CT_STATE_USER		= 2,
-	CT_STATE_GUEST		= 3,
-	CT_STATE_MAX		= 4,
+	CT_STATE_KERNEL		= 1,
+	CT_STATE_IDLE		= 2,
+	CT_STATE_USER		= 4,
+	CT_STATE_GUEST		= 8,
+	CT_STATE_MAX		= 9,
 };
 
 struct context_tracking {
-- 
2.43.0


