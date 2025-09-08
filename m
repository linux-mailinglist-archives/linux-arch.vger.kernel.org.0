Return-Path: <linux-arch+bounces-13424-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2589B49D2A
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 01:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D59A189A73F
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7262FF679;
	Mon,  8 Sep 2025 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tRUuKTO4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYZJ+vQK"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A82F28E3;
	Mon,  8 Sep 2025 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372397; cv=none; b=B4YGYObXyUIKDuXTStzxCwV7Bs5Q/yO/h//u/3SNXFJBN5l2GrRbB8cIWhd5115XRPJiNtahopupG4JVhVrhyIDp5b2ssrsyWfXy5XKIDMK58uuF9+YY7r0ONzl092nG/B/Ry3VuLSx7fYjDK3jOaTv4bjiCgkWUNW4/rr0nfeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372397; c=relaxed/simple;
	bh=sJUvIkOk7xRsZ8N1md77VtwlcW+xrqBYELwzAD9L3kc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RhZkxJ95j5Fi0LBy3dJaxQnTMTI/vTACppeExLM8YxhnqMmDLby+jkULrp0qlm3y/g7MZCvFa7P4nTxWdygAHd9Xc7SqsmM1RNz2NZhYQOSyOQy/i0rt19zhnrRDL1CaENFIOGPwv3fTvQNXtEJEr78ZES/ZUqM1gRd80ucS8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tRUuKTO4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYZJ+vQK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908225752.679815003@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757372392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uJbTU9ygKfI6/zvyWU+Vow5hjTzjort0MMfsywsVYMk=;
	b=tRUuKTO4XbAvXw+t88yT6uoUK8blCFEDcriT2OWhG3/G3zQ/Dw5CDcNNBJJ/kjQdCwS1T+
	0Sza16lnAZWRl1HodpDm9sMKYRbDMRIAdUAHM92Uq9I0J99n8AgfksKLvyjrKoXyQXF/Em
	sv3gYiet7TiwvEGnMPkivyaHmPzaOPbhLqysau7af2Icahzn+e/vO8xG8OwFzBP1nrsobG
	KtfjZm+eN8cxx9YOYKthicJ+bKClpVVHHiSmzYP4UeAs9KVPM3+Zi+GRkAxUvikUwWhnIx
	zpB/559RDzx6p8I5aghRtGQ2YerU0IpsFqM+rMD0q0olPJ5yFPbC2scV2e0ytw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757372392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uJbTU9ygKfI6/zvyWU+Vow5hjTzjort0MMfsywsVYMk=;
	b=DYZJ+vQKS75bOERhbPJx6LFHgjRAmaPzCDluZ5ObcXRVy7/8hgJhCTMll1mh47pEsnKwCb
	5Js/8CGfj5FCDNBw==
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
Subject: [patch 02/12] rseq: Add fields and constants for time slice extension
References: <20250908225709.144709889@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  9 Sep 2025 00:59:51 +0200 (CEST)

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
 Documentation/userspace-api/index.rst |    1 
 Documentation/userspace-api/rseq.rst  |  129 ++++++++++++++++++++++++++++++++++
 include/linux/rseq_types.h            |   26 ++++++
 include/uapi/linux/rseq.h             |   28 +++++++
 init/Kconfig                          |   12 +++
 kernel/rseq.c                         |    8 ++
 6 files changed, 204 insertions(+)

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
@@ -0,0 +1,129 @@
+=====================
+Restartable Sequences
+=====================
+
+Restartable Sequences allow to register a per thread userspace memory area
+to be used as an ABI between kernel and user-space for three purposes:
+
+ * user-space restartable sequences
+
+ * quick access to read the current CPU number, node ID from user-space
+
+ * scheduler time slice extensions
+
+Restartable sequences (per-cpu atomics)
+---------------------------------------
+
+Restartables sequences allow user-space to perform update operations on
+per-cpu data without requiring heavy-weight atomic operations. The actual
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
+    * A rseq user space pointer has been registered for the thread
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
+``RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT``. These bits are read only for user
+space and only for informational purposes.
+
+If the mechanism was enabled via prctl(), the thread can request a time
+slice extension by setting the ``RSEQ_SLICE_EXT_REQUEST_BIT`` in the struct
+rseq slice_ctrl field. If the thread is interrupted and the interrupt
+results in a reschedule request in the kernel, then the kernel can grant a
+time slice extension and return to user space instead of scheduling
+out.
+
+The kernel indicates the grant by clearing ``RSEQ_SLICE_EXT_REQUEST_BIT``
+and setting ``RSEQ_SLICE_EXT_GRANTED_BIT`` in the rseq::slice_ctrl
+field. If there is a reschedule of the thread after granting the extension,
+the kernel clears the granted bit to indicate that to user space.
+
+If the request bit is still set when the leaving the critical section, user
+space can clear it and continue.
+
+If the granted bit is set, then user space has to invoke rseq_slice_yield()
+when leaving the critical section to relinquish the CPU. The kernel
+enforces this by arming a timer to prevent misbehaving user space from
+abusing this mechanism.
+
+If both the request bit and the granted bit are false when leaving the
+critical section, then this indicates that a grant was revoked and no
+further action is required by user space.
+
+The required code flow is as follows::
+
+    rseq->slice_ctrl = REQUEST;
+    critical_section();
+    if (!local_test_and_clear_bit(REQUEST, &rseq->slice_ctrl)) {
+        if (rseq->slice_ctrl & GRANTED)
+                rseq_slice_yield();
+    }
+
+local_test_and_clear_bit() has to be local CPU atomic to prevent the
+obvious RMW race versus an interrupt. On X86 this can be achieved with BTRL
+without LOCK prefix. On architectures, which do not provide lightweight CPU
+local atomics this needs to be implemented with regular atomic operations.
+
+Setting REQUEST has no atomicity requirements as there is no concurrency
+vs. the GRANTED bit.
+
+Checking the GRANTED has no atomicity requirements as there is obviously a
+race which cannot be avoided at all::
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
@@ -71,12 +71,35 @@ struct rseq_ids {
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
@@ -84,6 +107,9 @@ struct rseq_data {
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
+	/* (3) Intentional gap to put new bits into a seperate byte */
+
+	/* User read only feature flags */
+	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT	= 4,
+	RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT	= 5,
 };
 
 enum rseq_cs_flags {
@@ -35,6 +41,22 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+
+	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE	=
+		(1U << RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT),
+	RSEQ_CS_FLAG_SLICE_EXT_ENABLED		=
+		(1U << RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT),
+};
+
+enum rseq_slice_bits {
+	/* Time slice extension ABI bits */
+	RSEQ_SLICE_EXT_REQUEST_BIT		= 0,
+	RSEQ_SLICE_EXT_GRANTED_BIT		= 1,
+};
+
+enum rseq_slice_masks {
+	RSEQ_SLICE_EXT_REQUEST	= (1U << RSEQ_SLICE_EXT_REQUEST_BIT),
+	RSEQ_SLICE_EXT_GRANTED	= (1U << RSEQ_SLICE_EXT_GRANTED_BIT),
 };
 
 /*
@@ -142,6 +164,12 @@ struct rseq {
 	__u32 mm_cid;
 
 	/*
+	 * Time slice extension control word. CPU local atomic updates from
+	 * kernel and user space.
+	 */
+	__u32 slice_ctrl;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1908,6 +1908,18 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
 
 	  If unsure, say N.
 
+config RSEQ_SLICE_EXTENSION
+	bool "Enable rseq based time slice extension mechanism"
+	depends on RSEQ && HIGH_RES_TIMERS && GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS
+	help
+          Allows userspace to request a limited time slice extension when
+	  returning from an interrupt to user space via the RSEQ shared
+	  data ABI. If granted, that allows to complete a critical section,
+	  so that other threads are not stuck on a conflicted resource,
+	  while the task is scheduled out.
+
+	  If unsure, say N.
+
 config DEBUG_RSEQ
 	default n
 	bool "Enable debugging of rseq() system call" if EXPERT
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -387,6 +387,8 @@ static bool rseq_reset_ids(void)
  */
 SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
 {
+	u32 rseqfl = 0;
+
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
 			return -EINVAL;
@@ -448,6 +450,12 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	if (put_user_masked_u64(0UL, &rseq->rseq_cs))
 		return -EFAULT;
 
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
+		rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+
+	if (put_user_masked_u32(rseqfl, &rseq->flags))
+		return -EFAULT;
+
 	/*
 	 * Activate the registration by setting the rseq area address, length
 	 * and signature in the task struct.


