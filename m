Return-Path: <linux-arch+bounces-12830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0422BB08795
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC645804C6
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9D283C82;
	Thu, 17 Jul 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHlLiuna"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7D283FD0;
	Thu, 17 Jul 2025 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739626; cv=none; b=nPDAZRqr86VzDfQxSqN14tIWoLabM2uGFf5ZLJ3FqLlUnEDiI+Z/F4z9ryt+l5XKXpq2i9DOL1Vqcau5Ci3Wchcd6EIk9JjNnsiiRHNCPWT3SYt7eUVf7w0fF3BlaLZX5aYoZbJqNJhwXUUvtABAavxAL/PPxZxlzMv43nzFUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739626; c=relaxed/simple;
	bh=ZsOkEZYPY0gtanPD4WMippjc1iuCC2bav9qM42yAVlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUCBG4IS8W34t46Gd/sTiK6ris0ag9cCz8IronJpI4925g/sn0ZG/5EKNjbM1lO95V9ZpK888iJItoTw6kx5EHX5FJwpx2jkLTGF7joQAlib1+I2PJui7U59k1EEPWcHI9BPDrJRqwtBK6oDEw9nLKAnEhoI0QsgWuHGel758sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHlLiuna; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso721821a91.0;
        Thu, 17 Jul 2025 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752739624; x=1753344424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ5k0Sh34AV2qjni7q2kIoyiqnIs55/ytzaUy228vQg=;
        b=lHlLiunaBbuEiChagUsPdSiKTyTaltJszh3OQu63XkTtlsmPX29ia7hSZ9IIqADdWO
         eQq/A81EfvSqCeG7OpJ8DIrRkWXKv7QI/pc2HsMT2FycG/PzFbq0MhC58XnmW0Ydim3A
         wWwSrEqy5nUx+Li19/rVVcsJJu2W0P79a2vMDdbuwFi8PQFdIrKowX+ZZWedFmoJJRP7
         lgq/GI3UvfMMvZ1+2Q2Dbg3bJMV+iCincgtz3vL8pDXfMgfTj8cN7XUOf0Itunp4hfHn
         l80UMn9zfmBmHa9CSdq5AA/+aJ4dzL9MXK4IFVQFj69K/d06Wq9YJYR+IFzQffkIVCOB
         oD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739624; x=1753344424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQ5k0Sh34AV2qjni7q2kIoyiqnIs55/ytzaUy228vQg=;
        b=aeNASJzJQWzASIdwuNeiHd/5N+rffw/62RqKkeaFdgikG2zPVSsF4wCQ1gcZ0HEwhx
         eD9BS/0bga4/Lrw+jcfRnCzxuRkZE9J1JEipQcwtKzcg8wCQyLkSizCPkcv/okG4xUFk
         WtVKV+suh3wi2Akq86Sy2ZE2H7IB7dZDHBfE0od9cuzRIWOWj4izNQ0fFWEzAPFuY9nq
         OHGI3yTxzbu3PDC2C7dabM2SkCoz7XZRTaiZVux9RfTA82sexd7wTyldMfw3noDl6Stx
         2HZS/a0E5Bm6RI37foZnrD0u5NkOWGmaAhlNdrcqjVle0+yoZQMSgnL8hZRhMhCwPvmk
         olDg==
X-Forwarded-Encrypted: i=1; AJvYcCVW79vs1OpGwvU/lrkEnFNoHn5tkS0W8M/QeFdsAHmTfHuEMwicVh4LG2vas2MCOBnDg4KN@vger.kernel.org, AJvYcCVvuAHv9SeTeas8EG6IpZtEOZ3Ury2KZ+vlU1NIVfzmA5/enAzXZ76SVcodLDpZo510uqw=@vger.kernel.org, AJvYcCWxwjxgmC5yyVHjVrdFAJNSMZfcB4kp43PkOSJ3IlpEYFbNzUSo29aaInnuLmrNs2r77efjYlG701A36g==@vger.kernel.org, AJvYcCXtmb9hvvyx3SQmUFtoZf0iE3plLfymR+vz3imtxVO9hwlHbJzImEygtEVQjTSEXQxd6pNywLIz4vNS@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQ3fjF2zNedhZEpIIbjJB0e+FB0SK7lU6MWs+BhGuQPstFzfw
	xvc6pWVqNk0Dyd6WNVVUPYJ0WcHK4DyJ9xgUfBP61yAcgEd8SWYmnWzD
X-Gm-Gg: ASbGncuZBT4L6VAZuYxaIlAgWFzojKHPAJ+fJ5VvNmWwEElrkMCjqDU1Jpi1yR64sEV
	UtxatmaSQbnKrS75aA6hB/6T6/R2xQuM3XGijcqQBmO8bL1bidaYFWoFWyZrQh5FLczuV93NNTD
	u6V/s7/TgcS5hm16yp4WBiV1/CNE7bnhLDz+Uhz+j0uW7WaoBhmbbZdFFQbirYsDJel+wKeIU6e
	0CtRkHvevTKMjXXezaKjKI18UMasx+a8zsJ1TrpdJeAEYd5iImGmMvPfUUvgQPQJ2NtXrlibjBP
	2+2724dqxclxch826zgDpgdFoCNXplCl8SKazz8CMS2pMceZFKSMdt9x9l2JdGWwp//eN3cTt8p
	sB4VOLZhjw3qhqEsDnm4xvw==
X-Google-Smtp-Source: AGHT+IGaAhkFViVCjDcH95NuJwq0Qavg1/VlyXQ+tThNvNSVE8B/KuvPv3o4kh4iIMQ44HF1sdaAmw==
X-Received: by 2002:a17:90a:d88c:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-31c9e7637cemr8210224a91.22.1752739623955;
        Thu, 17 Jul 2025 01:07:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f287bcasm2783269a91.32.2025.07.17.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 01:07:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4488D401640F; Thu, 17 Jul 2025 15:06:53 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux RCU <rcu@vger.kernel.org>,
	Linux CPU Architectures Development <linux-arch@vger.kernel.org>,
	Linux LKMM <lkmm@lists.linux.dev>,
	Linux KVM <kvm@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xavier <xavier_qy@163.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 4/4] Documentation: atomic_bitops, atomic_t, memory-barriers: Link to newly-converted docs
Date: Thu, 17 Jul 2025 15:06:17 +0700
Message-ID: <20250717080617.35577-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717080617.35577-1-bagasdotme@gmail.com>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8544; i=bagasdotme@gmail.com; h=from:subject; bh=ZsOkEZYPY0gtanPD4WMippjc1iuCC2bav9qM42yAVlI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkVa5NdvztPO5nkZOf8dvGxfoMJEX6ThOUb1896FCIzj 2fNLhuxjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkzwNGhiU5kzIu+bnKfY7I 4zFdcnhVWqbS0mNyi6SnXJ/4SOf/x0ZGhjc3snT4lfhSzKTfH2DkMBO4fE9s4odJyT1h8xjnF3P 3sAMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Now that both atomic bitops, atomic types, and memory barriers docs have
been converted, cross-reference them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/RCU/rcu_dereference.rst         |  2 +-
 Documentation/core-api/atomic_bitops.rst      |  6 ++++--
 Documentation/core-api/circular-buffers.rst   |  4 ++--
 Documentation/core-api/memory-barriers.rst    | 16 +++++++++-------
 Documentation/core-api/refcount-vs-atomic.rst |  5 +++--
 Documentation/driver-api/device-io.rst        |  4 ++--
 Documentation/locking/spinlocks.rst           |  5 ++---
 Documentation/virt/kvm/vcpu-requests.rst      |  4 ++--
 8 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 2524dcdadde2b8..dca197d689d78f 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -192,7 +192,7 @@ readers working properly:
 		so that a control dependency preserves the needed ordering.
 		That said, it is easy to get control dependencies wrong.
 		Please see the "CONTROL DEPENDENCIES" section of
-		Documentation/memory-barriers.txt for more details.
+		Documentation/core-api/memory-barriers.rst for more details.
 
 	-	The pointers are not equal *and* the compiler does
 		not have enough information to deduce the value of the
diff --git a/Documentation/core-api/atomic_bitops.rst b/Documentation/core-api/atomic_bitops.rst
index b93c388fd9bdc4..7f58c31a37a938 100644
--- a/Documentation/core-api/atomic_bitops.rst
+++ b/Documentation/core-api/atomic_bitops.rst
@@ -41,7 +41,8 @@ Semantics
 * Non-atomic ops:
 
   In particular __clear_bit_unlock() suffers the same issue as atomic_set(),
-  which is why the generic version maps to clear_bit_unlock(), see atomic_t.txt.
+  which is why the generic version maps to clear_bit_unlock(), see
+  Documentation/core-api/atomic_t.rst.
 
 
 * RMW ops:
@@ -64,5 +65,6 @@ clear_bit_unlock() which has RELEASE semantics and test_bit_acquire which has
 ACQUIRE semantics.
 
 Since a platform only has a single means of achieving atomic operations
-the same barriers as for atomic_t are used, see atomic_t.txt.
+the same barriers as for atomic_t are used, see
+Documentation/core-api/atomic_t.rst.
 
diff --git a/Documentation/core-api/circular-buffers.rst b/Documentation/core-api/circular-buffers.rst
index 50966f66e39829..3dc18a9f7dcf8a 100644
--- a/Documentation/core-api/circular-buffers.rst
+++ b/Documentation/core-api/circular-buffers.rst
@@ -233,5 +233,5 @@ against previous accesses.
 Further reading
 ===============
 
-See also Documentation/memory-barriers.txt for a description of Linux's memory
-barrier facilities.
+See also Documentation/core-api/memory-barriers.rst for a description of
+Linux's memory barrier facilities.
diff --git a/Documentation/core-api/memory-barriers.rst b/Documentation/core-api/memory-barriers.rst
index da8e682dc58d86..afb9bee0b80c4b 100644
--- a/Documentation/core-api/memory-barriers.rst
+++ b/Documentation/core-api/memory-barriers.rst
@@ -481,11 +481,12 @@ And a couple of implicit varieties:
      This means that ACQUIRE acts as a minimal "acquire" operation and
      RELEASE acts as a minimal "release" operation.
 
-A subset of the atomic operations described in atomic_t.txt have ACQUIRE and
-RELEASE variants in addition to fully-ordered and relaxed (no barrier
-semantics) definitions.  For compound atomics performing both a load and a
-store, ACQUIRE semantics apply only to the load and RELEASE semantics apply
-only to the store portion of the operation.
+A subset of the atomic operations described in
+Documentation/core-api/atomic_t.rst have ACQUIRE and RELEASE variants in
+addition to fully-ordered and relaxed (no barrier semantics) definitions.
+For compound atomics performing both a load and a store, ACQUIRE semantics
+apply only to the load and RELEASE semantics apply only to the store portion
+of the operation.
 
 Memory barriers are only required where there's a possibility of interaction
 between two CPUs or between a CPU and a device.  If it can be guaranteed that
@@ -1972,7 +1973,8 @@ There are some more advanced barrier functions:
    This makes sure that the death mark on the object is perceived to be set
    *before* the reference counter is decremented.
 
-   See Documentation/atomic_{t,bitops}.txt for more information.
+   See Documentation/core-api/atomic_t.rst and
+   Documentation/core-api/atomic_bitops.rst for more information.
 
 
  * dma_wmb();
@@ -2549,7 +2551,7 @@ operations are noted specially as some of them imply full memory barriers and
 some don't, but they're very heavily relied on as a group throughout the
 kernel.
 
-See Documentation/atomic_t.txt for more information.
+See Documentation/core-api/atomic_t.rst for more information.
 
 
 Accessing Devices
diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
index 94e628c1eb4975..28f5d6f80d19d0 100644
--- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -19,7 +19,8 @@ these memory ordering guarantees.
 The terms used through this document try to follow the formal LKMM defined in
 tools/memory-model/Documentation/explanation.txt.
 
-memory-barriers.txt and atomic_t.txt provide more background to the
+Documentation/core-api/memory-barriers.rst and
+Documentation/core-api/atomic_t.rst provide more background to the
 memory ordering in general and for atomic operations specifically.
 
 Relevant types of memory ordering
@@ -28,7 +29,7 @@ Relevant types of memory ordering
 .. note:: The following section only covers some of the memory
    ordering types that are relevant for the atomics and reference
    counters and used through this document. For a much broader picture
-   please consult memory-barriers.txt document.
+   please consult Documentation/core-api/memory-barriers.rst.
 
 In the absence of any memory ordering guarantees (i.e. fully unordered)
 atomics & refcounters only provide atomicity and
diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index 5c7e8194bef92b..9e27f64ce7b8b1 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -186,8 +186,8 @@ writeq_relaxed(), writel_relaxed(), writew_relaxed(), writeb_relaxed()
   comment that explains why the usage in a specific location is safe without
   the extra barriers.
 
-  See memory-barriers.txt for a more detailed discussion on the precise ordering
-  guarantees of the non-relaxed and relaxed versions.
+  See Documentation/core-api/memory-barriers.rst for a more detailed discussion
+  on the precise ordering guarantees of the non-relaxed and relaxed versions.
 
 ioread64(), ioread32(), ioread16(), ioread8(),
 iowrite64(), iowrite32(), iowrite16(), iowrite8()
diff --git a/Documentation/locking/spinlocks.rst b/Documentation/locking/spinlocks.rst
index bec96f7a9f2d7a..8cb1bf557a30e9 100644
--- a/Documentation/locking/spinlocks.rst
+++ b/Documentation/locking/spinlocks.rst
@@ -21,9 +21,8 @@ there is only one thread-of-control within the region(s) protected by that
 lock. This works well even under UP also, so the code does _not_ need to
 worry about UP vs SMP issues: the spinlocks work correctly under both.
 
-   NOTE! Implications of spin_locks for memory are further described in:
-
-     Documentation/memory-barriers.txt
+   NOTE! Implications of spin_locks for memory are further described in
+   Documentation/core-api/memory-barriers.rst.
 
        (5) ACQUIRE operations.
 
diff --git a/Documentation/virt/kvm/vcpu-requests.rst b/Documentation/virt/kvm/vcpu-requests.rst
index 06718b9bc95977..0dd1308dc5252a 100644
--- a/Documentation/virt/kvm/vcpu-requests.rst
+++ b/Documentation/virt/kvm/vcpu-requests.rst
@@ -289,6 +289,6 @@ architectures a function where requests may be checked if necessary.
 References
 ==========
 
-.. [atomic-ops] Documentation/atomic_bitops.txt and Documentation/atomic_t.txt
-.. [memory-barriers] Documentation/memory-barriers.txt
+.. [atomic-ops] Documentation/core-api/atomic_bitops.rst and Documentation/core-api/atomic_t.rst
+.. [memory-barriers] Documentation/core-api/memory-barriers.rst
 .. [lwn-mb] https://lwn.net/Articles/573436/
-- 
An old man doll... just what I always wanted! - Clara


