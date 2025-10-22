Return-Path: <linux-arch+bounces-14259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4269CBFC0BF
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 15:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8158050902E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBAC34B69B;
	Wed, 22 Oct 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oabk0xc1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nzqpda4w"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797F34A791;
	Wed, 22 Oct 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137855; cv=none; b=KJp07F242UBtjL3yr1QzqQI7gc1MI8w4cilMvpyk2kQvex7M+35R0xzCq8uuKXXFgJgWQc0q19z1tnmvqaCl2CDlZULEyT8KlvSoypi9sRqHk3hTX/6fBH+LfAp16QDX19qU/juBl8S6MpW8ljnW/hkSDJqRnHpEBp70yIbtUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137855; c=relaxed/simple;
	bh=CIR/ZWzbwEbiXhlEBNdqsqs/9PhPP51zJIqFjRI5EY4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ltbpe0P/gT4jPdBaspcqRckJ1jlNZ0Fx6g1k1v9OrOuKBs9oyN8XOb63291ZQmeWAHKo0C9269MKjAM8MXO5htBoidHT91ynbTzRsV7KVxjUEdeC4ABEY7EY4e+wuzVs4t7uRP6m4pDmZydZiy3yimZOzSOYIAhZzGtxAJ9hVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oabk0xc1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nzqpda4w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121427.028021177@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kNQv3njWTivpuW5E4KHF9YZcsv4wOFLdcWKajfI6uBg=;
	b=oabk0xc1Nf7VY9C3AQ7UiVRmJ1WH3eG+DYIzNNCSHKCi3S6Zzh3zeb/3c8YLjsTzN/uME2
	sf7OaDFzGFIxLwl8bvb8nYXVGMnwDLfIwz1Ns5W65j66hqP9Xypy/og9gs7aAFN6d2NTPL
	Z/RVSoDTU9L/TjC8mK/YHWeb1ir3FVA8Sr+925QCQuYhPxwqu98p04SEhMVObzs3/NVkHJ
	w1Yl/ovPOcSIYECBh2Afr967bhlouHGrO3fougORlaDEif9L/ElrTD0Qj69YE+C2Uchl1d
	dw85twft8Q1RFwGu7LTLvnVe8+PCJII0w/uxhpWiHuND1/cLpMzX/nnIVtQixg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kNQv3njWTivpuW5E4KHF9YZcsv4wOFLdcWKajfI6uBg=;
	b=Nzqpda4wQr7nzUVW+1fK1RSQ+SU0bGbQ7YyxR4Zmabhzj22zRVuRLRp23ooD/2zbvnAX8x
	FRdPEYwV0LuUx0Dg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zilstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: [patch V2 02/12] rseq: Add fields and constants for time slice
 extension
References: <20251022110646.839870156@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:57:31 +0200 (CEST)

Aside of a Kconfig knob add the following items:

   - Two flag bits for the rseq user space ABI, which allow user space to
     query the availability and enablement without a syscall.

   - A new member to the user space ABI struct rseq, which is going to be
     used to communicate request and grant between kernel and user space.

   - A rseq state struct to hold the kernel state of this

   - Documentation of the new mechanism

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
V2: Fix Kconfig indentation, fix typos and expressions - Randy
    Make the control fields a struct and remove the atomicity requirement - Mathieu
---
 Documentation/userspace-api/index.rst |    1 
 Documentation/userspace-api/rseq.rst  |  118 ++++++++++++++++++++++++++++++++++
 include/linux/rseq_types.h            |   26 +++++++
 include/uapi/linux/rseq.h             |   38 ++++++++++
 init/Kconfig                          |   12 +++
 kernel/rseq.c                         |    7 ++
 6 files changed, 202 insertions(+)

--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -21,6 +21,7 @@ System calls
    ebpf/index
    ioctl/index
    mseal
+   rseq
 
 Security-related interfaces
 ===========================
--- /dev/null
+++ b/Documentation/userspace-api/rseq.rst
@@ -0,0 +1,118 @@
+=====================
+Restartable Sequences
+=====================
+
+Restartable Sequences allow to register a per thread userspace memory area
+to be used as an ABI between kernel and userspace for three purposes:
+
+ * userspace restartable sequences
+
+ * quick access to read the current CPU number, node ID from userspace
+
+ * scheduler time slice extensions
+
+Restartable sequences (per-cpu atomics)
+---------------------------------------
+
+Restartables sequences allow userspace to perform update operations on
+per-cpu data without requiring heavyweight atomic operations. The actual
+ABI is unfortunately only available in the code and selftests.
+
+Quick access to CPU number, node ID
+-----------------------------------
+
+Allows to implement per CPU data efficiently. Documentation is in code and
+selftests. :(
+
+Scheduler time slice extensions
+-------------------------------
+
+This allows a thread to request a time slice extension when it enters a
+critical section to avoid contention on a resource when the thread is
+scheduled out inside of the critical section.
+
+The prerequisites for this functionality are:
+
+    * Enabled in Kconfig
+
+    * Enabled at boot time (default is enabled)
+
+    * A rseq userspace pointer has been registered for the thread
+
+The thread has to enable the functionality via prctl(2)::
+
+    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
+          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
+
+prctl() returns 0 on success and otherwise with the following error codes:
+
+========= ==============================================================
+Errorcode Meaning
+========= ==============================================================
+EINVAL	  Functionality not available or invalid function arguments.
+          Note: arg4 and arg5 must be zero
+ENOTSUPP  Functionality was disabled on the kernel command line
+ENXIO	  Available, but no rseq user struct registered
+========= ==============================================================
+
+The state can be also queried via prctl(2)::
+
+  prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_GET, 0, 0, 0);
+
+prctl() returns ``PR_RSEQ_SLICE_EXT_ENABLE`` when it is enabled or 0 if
+disabled. Otherwise it returns with the following error codes:
+
+========= ==============================================================
+Errorcode Meaning
+========= ==============================================================
+EINVAL	  Functionality not available or invalid function arguments.
+          Note: arg3 and arg4 and arg5 must be zero
+========= ==============================================================
+
+The availability and status is also exposed via the rseq ABI struct flags
+field via the ``RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT`` and the
+``RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT``. These bits are read-only for user
+space and only for informational purposes.
+
+If the mechanism was enabled via prctl(), the thread can request a time
+slice extension by setting rseq::slice_ctrl.request to 1. If the thread is
+interrupted and the interrupt results in a reschedule request in the
+kernel, then the kernel can grant a time slice extension and return to
+userspace instead of scheduling out.
+
+The kernel indicates the grant by clearing rseq::slice_ctrl::reqeust and
+setting rseq::slice_ctrl::granted to 1. If there is a reschedule of the
+thread after granting the extension, the kernel clears the granted bit to
+indicate that to userspace.
+
+If the request bit is still set when the leaving the critical section,
+userspace can clear it and continue.
+
+If the granted bit is set, then userspace has to invoke rseq_slice_yield()
+when leaving the critical section to relinquish the CPU. The kernel
+enforces this by arming a timer to prevent misbehaving userspace from
+abusing this mechanism.
+
+If both the request bit and the granted bit are false when leaving the
+critical section, then this indicates that a grant was revoked and no
+further action is required by userspace.
+
+The required code flow is as follows::
+
+    rseq->slice_ctrl.request = 1;
+    critical_section();
+    if (rseq->slice_ctrl.granted)
+         rseq_slice_yield();
+
+As all of this is strictly CPU local, there are no atomicity requirements.
+Checking the granted state is racy, but that cannot be avoided at all::
+
+    if (rseq->slice_ctrl & GRANTED)
+      -> Interrupt results in schedule and grant revocation
+        rseq_slice_yield();
+
+So there is no point in pretending that this might be solved by an atomic
+operation.
+
+The kernel enforces flag consistency and terminates the thread with SIGSEGV
+if it detects a violation.
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -73,12 +73,35 @@ struct rseq_ids {
 };
 
 /**
+ * union rseq_slice_state - Status information for rseq time slice extension
+ * @state:	Compound to access the overall state
+ * @enabled:	Time slice extension is enabled for the task
+ * @granted:	Time slice extension was granted to the task
+ */
+union rseq_slice_state {
+	u16			state;
+	struct {
+		u8		enabled;
+		u8		granted;
+	};
+};
+
+/**
+ * struct rseq_slice - Status information for rseq time slice extension
+ * @state:	Time slice extension state
+ */
+struct rseq_slice {
+	union rseq_slice_state	state;
+};
+
+/**
  * struct rseq_data - Storage for all rseq related data
  * @usrptr:	Pointer to the registered user space RSEQ memory
  * @len:	Length of the RSEQ region
  * @sig:	Signature of critial section abort IPs
  * @event:	Storage for event management
  * @ids:	Storage for cached CPU ID and MM CID
+ * @slice:	Storage for time slice extension data
  */
 struct rseq_data {
 	struct rseq __user		*usrptr;
@@ -86,6 +109,9 @@ struct rseq_data {
 	u32				sig;
 	struct rseq_event		event;
 	struct rseq_ids			ids;
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+	struct rseq_slice		slice;
+#endif
 };
 
 #else /* CONFIG_RSEQ */
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -23,9 +23,15 @@ enum rseq_flags {
 };
 
 enum rseq_cs_flags_bit {
+	/* Historical and unsupported bits */
 	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+	/* (3) Intentional gap to put new bits into a separate byte */
+
+	/* User read only feature flags */
+	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT	= 4,
+	RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT	= 5,
 };
 
 enum rseq_cs_flags {
@@ -35,6 +41,11 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+
+	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE	=
+		(1U << RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT),
+	RSEQ_CS_FLAG_SLICE_EXT_ENABLED		=
+		(1U << RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT),
 };
 
 /*
@@ -53,6 +64,27 @@ struct rseq_cs {
 	__u64 abort_ip;
 } __attribute__((aligned(4 * sizeof(__u64))));
 
+/**
+ * rseq_slice_ctrl - Time slice extension control structure
+ * @all:	Compound value
+ * @request:	Request for a time slice extension
+ * @granted:	Granted time slice extension
+ *
+ * @request is set by user space and can be cleared by user space or kernel
+ * space.  @granted is set and cleared by the kernel and must only be read
+ * by user space.
+ */
+struct rseq_slice_ctrl {
+	union {
+		__u32		all;
+		struct {
+			__u8	request;
+			__u8	granted;
+			__u16	__reserved;
+		};
+	};
+};
+
 /*
  * struct rseq is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line.
@@ -142,6 +174,12 @@ struct rseq {
 	__u32 mm_cid;
 
 	/*
+	 * Time slice extension control structure. CPU local updates from
+	 * kernel and user space.
+	 */
+	struct rseq_slice_ctrl slice_ctrl;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1913,6 +1913,18 @@ config RSEQ
 
 	  If unsure, say Y.
 
+config RSEQ_SLICE_EXTENSION
+	bool "Enable rseq-based time slice extension mechanism"
+	depends on RSEQ && HIGH_RES_TIMERS && GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS
+	help
+	  Allows userspace to request a limited time slice extension when
+	  returning from an interrupt to user space via the RSEQ shared
+	  data ABI. If granted, that allows to complete a critical section,
+	  so that other threads are not stuck on a conflicted resource,
+	  while the task is scheduled out.
+
+	  If unsure, say N.
+
 config RSEQ_STATS
 	default n
 	bool "Enable lightweight statistics of restartable sequences" if EXPERT
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -389,6 +389,8 @@ static bool rseq_reset_ids(void)
  */
 SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
 {
+	u32 rseqfl = 0;
+
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
 			return -EINVAL;
@@ -440,6 +442,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
 
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
+		rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+
 	scoped_user_write_access(rseq, efault) {
 		/*
 		 * If the rseq_cs pointer is non-NULL on registration, clear it to
@@ -450,11 +455,13 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 		 */
 		unsafe_put_user(0UL, &rseq->rseq_cs, efault);
 		unsafe_put_user(0UL, &rseq->rseq_cs, efault);
+		unsafe_put_user(rseqfl, &rseq->flags, efault);
 		/* Initialize IDs in user space */
 		unsafe_put_user(RSEQ_CPU_ID_UNINITIALIZED, &rseq->cpu_id_start, efault);
 		unsafe_put_user(RSEQ_CPU_ID_UNINITIALIZED, &rseq->cpu_id, efault);
 		unsafe_put_user(0U, &rseq->node_id, efault);
 		unsafe_put_user(0U, &rseq->mm_cid, efault);
+		unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
 	}
 
 	/*


