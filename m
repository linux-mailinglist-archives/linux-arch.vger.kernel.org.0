Return-Path: <linux-arch+bounces-2102-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8784BC5A
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 18:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE0A1F24702
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 17:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BB17C76;
	Tue,  6 Feb 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq0S1O89"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46417997
	for <linux-arch@vger.kernel.org>; Tue,  6 Feb 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241194; cv=none; b=bV7KclSV2o7BHtMKBW/tCI8Jn2ckRDMNsUnTn2gpk0II7BPnwtEk/F5PzLshXW34uTTyiW8Fu55vfamF9WfdnoC3Qt0JAEgomglkWw74K3CfbPTuHq2Q996Y7qco2TvRGB7bgq6bNo0K9jDCwqT8HtKBQqeLSpfxBHrQl0jTdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241194; c=relaxed/simple;
	bh=kGZuyujQSSpKDsAqhvgihpAhgWWTrSHGvIIAvUQoGOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdoHwp0s8tBVRdd3J8hDkMO57hnTCv9N156kxT5QSqHmeAPR+zJhgr+yeWFjiyQJGI9/BAa6zqmtviCB8AWifb9sQIZ1ozWelgfIBluCDlranAbO/9FyBMeL3/R46sBYjYWVcyua9CeEvnnlit6FUULzvQi33cwoCy0i8UxNTjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iq0S1O89; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707241191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qxND/0mZm42XCHvHVamaG/IBrDPXcu6uEcDyFY4xk/M=;
	b=Iq0S1O89xfdklz2o/b8n9xr32cokT/O53lIuoklhGr58FxS/cqY4fXXOE3+fidX+BBT2Wb
	e79yn7N3ZQ/YmvuLkbYOxeD3VtB+X2LQb1bzG+eQp57U94FfssCxO3y0reYrDRLpz9dhsu
	ZRmEAGpl0Fj42Q0wG6uGMVR+U60E4K8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-y-6ALdsPOPquZcBcqHR_VQ-1; Tue,
 06 Feb 2024 12:39:47 -0500
X-MC-Unique: y-6ALdsPOPquZcBcqHR_VQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AD7829AC002;
	Tue,  6 Feb 2024 17:39:46 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 09A752026D06;
	Tue,  6 Feb 2024 17:39:39 +0000 (UTC)
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
Subject: [PATCH v2 0/5] jump_label: Fix __ro_after_init keys for modules & annotate some keys
Date: Tue,  6 Feb 2024 18:39:06 +0100
Message-ID: <20240206173911.4131670-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi folks,

This series fixes __ro_after_init keys used in modules (courtesy of PeterZ) and
flags more keys as __ro_after_init. Further context for why I'm looking into
this here: http://lore.kernel.org/r/20230720163056.2564824-1-vschneid@redhat.com

Compile & boot tested for x86_64_defconfig and i386_defconfig.


@Peter, regarding making __use_tsc x86_32, I hit a few snags.

Currently, for the static key to be enabled, we (mostly) need:
o X86_FEATURE_TSC is in CPUID
o determine_cpu_tsc_frequencies passes

All X86_64 systems have a TSC, so the CPUID feature is a given there.

Calibrating the TSC can end up depending on different things:
o CPUID accepting 0x16 as eax input (cf. cpu_khz_from_cpuid())
o MSR_FSB_FREQ being available (cf. cpu_khz_from_msr())
o pit_hpet_ptimer_calibrate_cpu() doesn't mess up

I couldn't find any guarantees for X86_64 on having the processor frequency
information CPUID leaf, nor for the FSB_FREQ MSR (both tsc_msr_cpu_ids and
the SDM seem to point at only a handful of models).

pit_hpet_ptimer_calibrate_cpu() relies on having either HPET or the ACPI PM
timer, the latter being widely available, though X86_PM_TIMER can be
disabled via EXPERT.

The question here is: are there any guarantees that at least one of these
can be relied upon for x86_64?

And with all of that, there is still the "apicpmtimer" cmdline option which
currently invokes notsc_setup() on x86_64. The justification I found for it was
in 0c3749c41f5e ("[PATCH] x86_64: Calibrate APIC timer using PM timer"):

  """
  On some broken motherboards (at least one NForce3 based AMD64 laptop)
  the PIT timer runs at a incorrect frequency.  This patch adds a new
  option "apicpmtimer" that allows to use the APIC timer and calibrate it
  using the PMTimer.
  """

Revisions
=========

v1 -> v2
++++++++

- Collected tags (Josh, Sean)
- Fixed CONFIG_JUMP_LABEL=n compile fail (lkp)

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
 include/linux/jump_label.h     |  3 +++
 init/main.c                    |  1 +
 kernel/context_tracking.c      |  2 +-
 kernel/jump_label.c            | 49 ++++++++++++++++++++++++++++++++++
 8 files changed, 62 insertions(+), 4 deletions(-)

--
2.43.0


