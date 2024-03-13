Return-Path: <linux-arch+bounces-2981-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C02E87B0C8
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 20:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716651C2605A
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 19:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34B35D8FE;
	Wed, 13 Mar 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEupP52O"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA260251
	for <linux-arch@vger.kernel.org>; Wed, 13 Mar 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352942; cv=none; b=fNTMEy0Mhm5bKN0tHA3Y+8vdnlBWevuoGSLFYwhitzDX/6xrabc7nkyuKCwuyPJ1ownKx5GAOnZQEScaxT7AuQFAABSRXPQPpFnZbVfhIXBVohxzQ7n83ijj5qA9ox0/xMMa5yeLMHG/FFYEtKp0bEHUawOLSwAEtkt2UVCxjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352942; c=relaxed/simple;
	bh=s10C1zZjvwCXFycCx8SBZlUoJ+dZ4c7ymn57tEmK7hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjDeFzn0b02T8iXGUQSEe79644y0e7bXD0CpVn+BMiHPEOivDEaGG4r4KkhCEJbanEftCKEIBanhooyS2Fc0eiAKhj+Upu6wvp2TE5wLsOdPeJ8slfFW9yNPZJQhgvsti5PYG9mj1d9QDkY2+9vgA855jJN7/hna/KELfX4+wBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEupP52O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710352940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXp0Mm4yGTLmvCcCdU6JXDu0ajdt7pw4zFh18lmT1BM=;
	b=UEupP52OCR/HJJJpyG0JgrdEj71wnk9/82SC7CYtmoNJYN5nKu4FSUxepBvuJOKwuhT3Pa
	TppHsnohGh1QkKS4tqoLZjQxJO1i+LFO2PJCufo5ttk7jaf4u72x4A/Lp2RbUeYu5iU3Ky
	/vzsU/rXXvQo+Ym0FFBh9tiw837NTPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-WJUtYtCGOfiw3dIR08-FwQ-1; Wed, 13 Mar 2024 14:02:16 -0400
X-MC-Unique: WJUtYtCGOfiw3dIR08-FwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5AFD185A783;
	Wed, 13 Mar 2024 18:02:14 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.115])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A985C04224;
	Wed, 13 Mar 2024 18:02:09 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
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
Subject: [PATCH v3 3/4] x86/kvm: Make kvm_async_pf_enabled __ro_after_init
Date: Wed, 13 Mar 2024 19:01:05 +0100
Message-ID: <20240313180106.2917308-4-vschneid@redhat.com>
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

kvm_async_pf_enabled is only ever enabled in __init kvm_guest_init(), so
mark it as __ro_after_init.

Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 101a7c1bf2008..6c6ff015b99fd 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -44,7 +44,7 @@
 #include <asm/svm.h>
 #include <asm/e820/api.h>
 
-DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
+DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
 
 static int kvmapf = 1;
 
-- 
2.43.0


