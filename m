Return-Path: <linux-arch+bounces-2104-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B022E84BC60
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 18:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25BB1C24E67
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 17:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C885134C7;
	Tue,  6 Feb 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzXx0nDj"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C505F1B7EE
	for <linux-arch@vger.kernel.org>; Tue,  6 Feb 2024 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241201; cv=none; b=HsCjoqtUjFNpXq6mEqUCcruOgaOlsavxe583oi/gHbkynphRV4rO7oiIcRuJCVxJJcBBvBtbRsmPT+0GW3V0YzGrZsKaukLRixYI1Gu4yfXQ4844Dtdy5GEuaJlRapxcNzB+e8KDruFMYrEoXQ1ib6RMkZvFJ1+BcKPBPEpoeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241201; c=relaxed/simple;
	bh=DFZQ/EilDH1t8WOKFPKN8p7KM/uu/NEDA8dWflqpPdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWjhyhWTrGoj23vp/PmmdixnYFIaJlKDPp5KaOREwob30IBIse45YEUlZM/jIxZVRuraXtUWfKXwga02VVIhw/sXE0bp8nWeKuN+myDC06pE3hI6554CwxvdGxnoLuTdUiZci3V5jeS1dZZ2qVMrv21j7x0yeG6yxOEZxGknsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzXx0nDj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707241198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wAVeOMisjibwqonq5yPJYQ58Exx1w9fjDotka9U+BN4=;
	b=hzXx0nDjem+73U+5mEeU2OkGNq0GZLZmJRcXME8+UcOSnBdS+Br4rlPQXx6vMsn8wmv1u7
	Fbg5WZnoHKWLGpiz8xZAHQ7dJs255Zt1WRlhnCDGxJACW34SmflnhLLfXEHKKQFE3/d7M6
	E8bU20vy6fz2yeBhu2jYJcI2VlM8SSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-X4XQR69UNdyvfJZ65mDaVw-1; Tue, 06 Feb 2024 12:39:57 -0500
X-MC-Unique: X4XQR69UNdyvfJZ65mDaVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2041E101FA2C;
	Tue,  6 Feb 2024 17:39:56 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A881D2026D06;
	Tue,  6 Feb 2024 17:39:51 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	Michael Kelley <mikelley@microsoft.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH v2 2/5] context_tracking: Make context_tracking_key __ro_after_init
Date: Tue,  6 Feb 2024 18:39:08 +0100
Message-ID: <20240206173911.4131670-3-vschneid@redhat.com>
In-Reply-To: <20240206173911.4131670-1-vschneid@redhat.com>
References: <20240206173911.4131670-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

context_tracking_key is only ever enabled in __init ct_cpu_tracker_user(),
so mark it as __ro_after_init.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/context_tracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 6ef0b35fc28c5..cc4f3a57f848c 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -432,7 +432,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE(context_tracking_key);
+DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
 static noinstr bool context_tracking_recursion_enter(void)
-- 
2.43.0


