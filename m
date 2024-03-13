Return-Path: <linux-arch+bounces-2982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4787B10F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 20:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4416EB2E3A2
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 19:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC84AEF6;
	Wed, 13 Mar 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzJix4eL"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5260272
	for <linux-arch@vger.kernel.org>; Wed, 13 Mar 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352950; cv=none; b=s8haHo03MkiG5XOQxmXg7hqIky+WkZS6Ctl2H6uWeyuIITtiOJRwv9bjSsNZY8ra97XjnlqSIqDFXtZL+Q2BqHe1x5UCc7WsuFUnp+8vO8jubplE09N5lT0GQx8MgMXR/jQYDlX7p5yDfQP+8jWXcLbGg8KCu8Gc380Nif4WsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352950; c=relaxed/simple;
	bh=SmKZWZOsYB/pJ+10dsUo6FKTrviWROv7v/wIEMqhvPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfOogPQzb19uJsni84/f/S6oDN/uF8iW2J59DJIdzPGNQwTlEcYXsNH2ftpsbwIgg5YEqJc/adt3Tl5qIZwwhgIUSmdk4WvWUqLoLRrfZLXcmxkLUtIYhLyvsVENbExXzPApSydk/kQV48JXTL5Mu4Z1UxbZmvRUck/UegA4PyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XzJix4eL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710352948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XucXp3hxAwKTj7st+z6y9+02SpKNl75gXYBpv6v0s08=;
	b=XzJix4eLAvzAABrjI6LYumny+wnNte4hQtZuhdydP+0XnJSYe3N79cMGatzGfTISmiWks/
	bcVwS/ma4jIiUihmjthDUS92BjM6knn80muHLZvOqJ21623FDEs/uyufs35/7GHrQKVoRI
	3+DjMj8x55vnUNrHIrC8G5Lpyaf0mdM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-kynu_JlIMbuON6sxRRgrVg-1; Wed,
 13 Mar 2024 14:02:22 -0400
X-MC-Unique: kynu_JlIMbuON6sxRRgrVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCB8A1C05EAD;
	Wed, 13 Mar 2024 18:02:20 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.115])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 40865C04221;
	Wed, 13 Mar 2024 18:02:15 +0000 (UTC)
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
Subject: [PATCH v3 4/4] x86/tsc: Make __use_tsc __ro_after_init
Date: Wed, 13 Mar 2024 19:01:06 +0100
Message-ID: <20240313180106.2917308-5-vschneid@redhat.com>
In-Reply-To: <20240313180106.2917308-1-vschneid@redhat.com>
References: <20240313180106.2917308-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

__use_tsc is only ever enabled in __init tsc_enable_sched_clock(), so mark
it as __ro_after_init.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49acc963..0f7624ed1d1d0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -44,7 +44,7 @@ EXPORT_SYMBOL(tsc_khz);
 static int __read_mostly tsc_unstable;
 static unsigned int __initdata tsc_early_khz;
 
-static DEFINE_STATIC_KEY_FALSE(__use_tsc);
+static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
 
 int tsc_clocksource_reliable;
 
-- 
2.43.0


