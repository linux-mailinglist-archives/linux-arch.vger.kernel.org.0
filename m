Return-Path: <linux-arch+bounces-284-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF7B7F10F0
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 11:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6015AB217E2
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 10:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86CF51E;
	Mon, 20 Nov 2023 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4EqiGCn"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B6BD9
	for <linux-arch@vger.kernel.org>; Mon, 20 Nov 2023 02:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700477751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w3RVGtwvMaa0LWKwchTi9Ln865mxgwWs3dJKxuLZfco=;
	b=I4EqiGCnLPfV7lAjM9em7p7V6qCAAnWZTlJ+QwA2hzhIO+upLwO6osjvgmT0lhaVDPN00M
	zaebeB36y0u+9n4oS6uOFfqJJkvv9v9ROs0ozVAe8TWPgFWsOuVQQ1EoaNFZQuAAq665xs
	an+v5Bl2RtmbvwcGvf9O8A9FUzFb0Ek=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-KaDYnevWOLCl99oI2912ag-1; Mon,
 20 Nov 2023 05:55:47 -0500
X-MC-Unique: KaDYnevWOLCl99oI2912ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79FFD28B72E2;
	Mon, 20 Nov 2023 10:55:46 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.195.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AA7A2026D4C;
	Mon, 20 Nov 2023 10:55:40 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
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
Subject: [PATCH 0/5] jump_label: Fix __ro_after_init keys for modules & annotate some keys
Date: Mon, 20 Nov 2023 11:55:23 +0100
Message-ID: <20231120105528.760306-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi folks,

After chatting about deferring IPIs [1] at LPC I had another look at my patches
and realized a handful of them could already be sent as-is.

This series contains the __ro_after_init static_key bits, which fixes
__ro_after_init keys used in modules (courtesy of PeterZ) and flags more keys as
__ro_after_init.

[1]: https://lore.kernel.org/lkml/20230720163056.2564824-1-vschneid@redhat.com/

Cheers,
Valentin

Peter Zijlstra (1):
  jump_label,module: Don't alloc static_key_mod for __ro_after_init keys

Valentin Schneider (4):
  context_tracking: Make context_tracking_key __ro_after_init
  x86/kvm: Make kvm_async_pf_enabled __ro_after_init
  x86/speculation: Make mds_user_clear __ro_after_init
  x86/tsc: Make __use_tsc __ro_after_init

 arch/x86/kernel/cpu/bugs.c     |  2 +-
 arch/x86/kernel/kvm.c          |  2 +-
 arch/x86/kernel/tsc.c          |  2 +-
 include/asm-generic/sections.h |  5 ++++
 include/linux/jump_label.h     |  1 +
 init/main.c                    |  1 +
 kernel/context_tracking.c      |  2 +-
 kernel/jump_label.c            | 49 ++++++++++++++++++++++++++++++++++
 8 files changed, 60 insertions(+), 4 deletions(-)

--
2.41.0


