Return-Path: <linux-arch+bounces-3691-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF38A563A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB55D283750
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED6178297;
	Mon, 15 Apr 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Z2NNj3R6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085874E37;
	Mon, 15 Apr 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194487; cv=none; b=Ggf3YH0mEx/1fBcgJa2gRL9IloU+Bwk29ni5vtCSOnFElgGUeMFESOtd2EKUqPWjB1i8aJQXOt7L40TJJu/IcAVp3Z9HzQYesPSUn+G3oxAdBMwRUC0DUt481TFTF+m3u6DR4bZrpdl6v3NG8N2G56mMQTCDjUJCDPod9jukxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194487; c=relaxed/simple;
	bh=Iq/BAyjc5JNnm7ciLspG3W/QYIP8bHIZPTm1FiCQeSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uYDjTdIxpkK2sLt40y1j06OFOQzj/xTIQL9n7y111jmPFC0G/XndpHPdN+03hLgXUEHlB1CMBtHiGb8I1pQENewcmmneM/46D5SqBhMFm3wc7NW75AJzAV/6mc0LyWoBtkx82pBtCZSkuqUQqhyaAX8cObruxwWLQPyChefpJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Z2NNj3R6; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1713194477;
	bh=Iq/BAyjc5JNnm7ciLspG3W/QYIP8bHIZPTm1FiCQeSM=;
	h=From:To:Cc:Subject:Date:From;
	b=Z2NNj3R66GuilicS3pNP2dCxBOlmYwoAkWwkNp3q6mpRL3iifBUzGZ5bUvRbcbmRe
	 WunFCx3+TqN3NqsdFr4gPjtUrwDVpMlK4INOdC3+gewi9LOY7n5njOH2Y+pSje1M23
	 rtTLmMpNncLjhXNynx+ISgz1o2S3VYAgeBZv2CKbIkiy6bApQjaGMNbPtH8GDZTTlB
	 4YPseLev4KTF3JJGyCNdTPNQ992dHEpv/JKB1vqTJuUPiX+8297lUhx+NMXiT4BEeR
	 FFx8IJtLN43O1IaywRS+MQJ3BFwxJN47fm5MXmmL6GBROGxAeGKRWAWGjrB4Zz1qnl
	 U7bvDsLQekcew==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VJ9qd3ZSrzvb0;
	Mon, 15 Apr 2024 11:21:17 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	"levi . yun" <yeoreum.yun@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 0/2] sched: rseq mm_cid updates
Date: Mon, 15 Apr 2024 11:21:12 -0400
Message-Id: <20240415152114.59122-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series consists of 2 patches. It is based on v6.9-rc4.

- A fix aiming for v6.9-rc (to be backported to stable kernels):
  "sched: Add missing memory barrier in switch_mm_cid"

- An improvement patch aiming for v6.10:
  "sched: Move mm_cid code from sched.h to core.c"

Thanks,

Mathieu

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: levi.yun <yeoreum.yun@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: x86@kernel.org

Mathieu Desnoyers (2):
  sched: Add missing memory barrier in switch_mm_cid
  sched: Move mm_cid code from sched.h to core.c

 arch/x86/include/asm/barrier.h |   3 +
 include/asm-generic/barrier.h  |   8 +
 kernel/sched/core.c            | 277 ++++++++++++++++++++++++++++++---
 kernel/sched/sched.h           | 237 +---------------------------
 4 files changed, 270 insertions(+), 255 deletions(-)

-- 
2.39.2

