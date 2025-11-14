Return-Path: <linux-arch+bounces-14765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3424FC5DEB3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 16:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E90D13A03F4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8771329E52;
	Fri, 14 Nov 2025 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMKYjwTd"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32C1E285A
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132712; cv=none; b=M7bFREORMxjvE2JuC0eYdbPEwUuxdXaldVhVnrUpNkua2gNDJs7AxgmB02oTbuibDCmF4axbca3fBrA3B2xmGjOIOQq4GkbEjtTxjaKauEhujwooOPEq4OBSk/5lf2hg5MkKCnWNPURkSfdAxl5TWGWPsM8SVwf7L4ISuOQm8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132712; c=relaxed/simple;
	bh=Z/EAI9hFh4H6XJt0ufOWcsWMChKRCUqaHJ27tZfIUEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/soIoMfrBRpvAeYubnyOI99FG39yF4Ehs6CP7THWOF+NGus8ZDJXd1OqTN16UOxKb/Sg+SxGzUpcpDMJ2SwE27Hzgd/xIUYJ5OE1CkoniTk6qr7pj44UKnK8GCHz/K1WdSORX9aWgdHVajgNCbzMuQDi5gRc8qhz1/dTIXzS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMKYjwTd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763132710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5MmuDhyyCRvim2U70KrPJRnnsespTvM3TjOrkj7aIY=;
	b=IMKYjwTd8rLpNLVXLeRbEXkjPnkbTek8ENZnagkJ3+Y6GbslKsfYAF5hwU1VAQYv1j864C
	9da31yMX4e7ot3w85YJen0VXyFYLn9EiCgYPvu87T+sf5h0nQE8aO95COXI+FA8i0GhaF8
	2CIeITfxhQQbMVzr004a4XW2C09thSk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-bfH3JdWFP9aA7fMba-3JXg-1; Fri,
 14 Nov 2025 10:05:07 -0500
X-MC-Unique: bfH3JdWFP9aA7fMba-3JXg-1
X-Mimecast-MFC-AGG-ID: bfH3JdWFP9aA7fMba-3JXg_1763132702
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 816D61800EF6;
	Fri, 14 Nov 2025 15:05:02 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.226.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0974619560B9;
	Fri, 14 Nov 2025 15:04:48 +0000 (UTC)
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
	Petr Tesarik <ptesarik@suse.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v7 11/31] loongarch/paravirt: Mark pv_steal_clock static call as __ro_after_init
Date: Fri, 14 Nov 2025 16:01:13 +0100
Message-ID: <20251114150133.1056710-12-vschneid@redhat.com>
In-Reply-To: <20251114150133.1056710-1-vschneid@redhat.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The static call is only ever updated in

  __init pv_time_init()
  __init xen_time_setup_guest()

so mark it appropriately as __ro_after_init.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/loongarch/kernel/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index b1b51f920b231..9ec3f5c31fdab 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -19,7 +19,7 @@ static u64 native_steal_clock(int cpu)
 	return 0;
 }
 
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
+DEFINE_STATIC_CALL_RO(pv_steal_clock, native_steal_clock);
 
 static bool steal_acc = true;
 
-- 
2.51.0


