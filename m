Return-Path: <linux-arch+bounces-12828-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A7BB0878E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 10:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BBA3B3D4B
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5E27AC5A;
	Thu, 17 Jul 2025 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn8N00Us"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE6279788;
	Thu, 17 Jul 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739624; cv=none; b=V5+9bnw+phPBk3X2+U41AnSPo2j0N0TY0U2YnxZxjpFk+M0NevX12rlXf9guItzdp0KXjo+KoKWxi1xKmKXnPpzgWtP1LkMf4gm+jaPQqm6aAcKSh9+D2RFZLXTErbN2LGCye9H/q/tUg9E1JJJIUjejd5sLZKAR8mXubhG5NNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739624; c=relaxed/simple;
	bh=Amf/tcmlykYt4PNO/9loNZuMVckKO+RP2PEoUFHX7F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG0vRRV1jbOc2SyME8fjcxf0EHG0CSrBFgfNsAec3HWlWT+pwovoiAG/XtjlcdZJHbe8B0nevnKU6wCBmFr5rBAX5uksFUS+XoGTAf3AYULrR9eiRGaM3KPZ1YJVdRZO2C7hsy5ZiFLU1rYCgsTj6iRAiTBe0vTh97+IvDNjre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn8N00Us; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so589716a12.0;
        Thu, 17 Jul 2025 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752739621; x=1753344421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEICYXwHJnYV+JlpVihskAA1sLiQRmJXO7ELBw2JlIg=;
        b=Qn8N00Us3W7bi6jGiQlXgJXpiP9L/oH9saRAUOKSSW0be01UE45UNt2byunxRYRUA8
         b5/oyXg4zlfI7cM6WY389wlXwgGUbGzrWs+aL0JBofG4WxfdHu/reGeOvyKaaZA+zFJE
         2F9DlT4d5KatldY2pre+KRQ3fnBwNtTaK7BTBrpyg1smYYhia+4016ZjeAv4+KYwXPQJ
         QXjGTvfuCxjR3QtBiLodAmQEhux9rXABERSVK7GPBaaIIi7bwL+nHfOTS24s2HDnMfKg
         63/pkgb3KF58fvNqMSrOzbMtWlgXpC7UG4Etz4MsQ0qrgOD+zdkvuEVRD3fxuxIXVdHB
         ugeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739621; x=1753344421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEICYXwHJnYV+JlpVihskAA1sLiQRmJXO7ELBw2JlIg=;
        b=s643q+b7WECQiQ1QGasIJDDynW2DtwLNA5FJeXb6WiM63gn9OGiXbg8LuMEBq2HcMP
         Wub28oRId6KZ0g74+87o5baVv6Oey2AO1VMQovN8XCYeB7Zs1JHLv618ec1ncFuWtmI0
         3nuH4ickaWXoakqrdktZ1HkcjK3CPgxxcLro+pWWf/M7+OqV1nHhnn3u5lnO3O7cKpsf
         CGWOUzla8bD4oVIvTV5vk+xrDW24cgonYam4Yu/D7+Q6rgrb8PDEvSKvAjalkVOW+6FM
         UB34JseTHHL19nklTo8cvybOZSo1DFLbS4LvsGOUhLlkpYI3IBiAHmdzW7eXKBN+Wk60
         QINA==
X-Forwarded-Encrypted: i=1; AJvYcCU/6yqKmB72aZquLeJWw6d3cj+f1nWJpZKOdDBpGxPayPfpdNkikW891kjRBaNJE4NQ7pF8DT8Cr94aJQ==@vger.kernel.org, AJvYcCUBNu6/1RWlYMk2zpmUlMaB7Fz37w9CeYWBMFgD8PqjqrzPIugy7oniFf/Feo3HgMcdiRPm7vciS0HD@vger.kernel.org, AJvYcCV4rvxD/eBmdrUAWra9l7qcO6fV74bqqW6oJn8DyHP4uQqKuz1RX/+HyEHaMD+ybfWRTWY=@vger.kernel.org, AJvYcCWQdaT9gtrMNfK3Kl8Ta4E7H/dC/CbBGr+fisBez5ZVV70UIXRTAteN0YOl9xFLs7ReqgS5@vger.kernel.org
X-Gm-Message-State: AOJu0YzXmmase+0enbyKRmZLNzPDbUMHQfVtq/6UNRLqoQSg5/8iyM/L
	AxwLJxMQ19/AqoH3QGDXfK5pasTA5wXVFIXn1Qk5SsdO8jkIU1j+DkzD
X-Gm-Gg: ASbGncuxdEM1HH9K3oxWUF44XVPfWqR2dN358xz8T37rpbeLpC9NwYk/esIaVtATjhc
	ctW8mn3fILvmWFefRB4m6UzJxXVOW/LFO74BFW6v3YoQNMVzxsIvkpDSsBItvmkRabZzAcwEKVd
	6GcPUQsLCCpN8IC9d3tQU8vu4RN2VL5PgkFxKCgGKvwkfU3YBBhJRMxzjn5wP9Cjmu+dVBYRPZM
	4O9ZxB6ZbzifuCeANjXomrCkgPNdQrnJsVKC9Hshkf/lwOzB7id1enUmMqKqouIxhRPxY8Q/flP
	6h7Kax9elRXPyMOm3QrHi713+zODgQHj3+xlXtwjSqwwsnSJDG0BPXjXmQVfB1zpol2rW4qbCV0
	h2hmYsiTj+ottja2kKcqkGg==
X-Google-Smtp-Source: AGHT+IG3QuC55J8KKFSzBjINCCr8ZT92QeJcYht+3qyANQEuoCFOpKqMZhX+31uH4riMwW4AJpoG/A==
X-Received: by 2002:a17:903:faf:b0:235:799:eca5 with SMTP id d9443c01a7336-23e2576e67cmr86678065ad.44.1752739621206;
        Thu, 17 Jul 2025 01:07:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322781sm138066245ad.125.2025.07.17.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 01:06:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 29665401640E; Thu, 17 Jul 2025 15:06:53 +0700 (WIB)
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
Subject: [PATCH 3/4] Documentation: atomic_t: Convert to reST format
Date: Thu, 17 Jul 2025 15:06:16 +0700
Message-ID: <20250717080617.35577-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717080617.35577-1-bagasdotme@gmail.com>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13911; i=bagasdotme@gmail.com; h=from:subject; bh=Amf/tcmlykYt4PNO/9loNZuMVckKO+RP2PEoUFHX7F4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkVa5Nvta57pTalUqRtSglf09v9u9oVf7L5Wp+Ifs0ey izRdvptRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZyv5/hn5HaC4VmjxksVp5B WzoWvDGwUymUb+g0W9d9/1ay3EkHE4b/fj+fnjQ/FjhR37A1WvlzYrzinEDZoOSeE8Zvvmnemm/ ACgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert atomic types documentation to reST syntax:

* Add docs title
* Sentence-case headings
* List API functions in bullet list
* Mark-up notes and code blocks as appropriate

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../{atomic_t.txt => core-api/atomic_t.rst}   | 211 ++++++++++--------
 Documentation/core-api/index.rst              |   2 +-
 Documentation/core-api/wrappers/atomic_t.rst  |  19 --
 3 files changed, 117 insertions(+), 115 deletions(-)
 rename Documentation/{atomic_t.txt => core-api/atomic_t.rst} (67%)
 delete mode 100644 Documentation/core-api/wrappers/atomic_t.rst

diff --git a/Documentation/atomic_t.txt b/Documentation/core-api/atomic_t.rst
similarity index 67%
rename from Documentation/atomic_t.txt
rename to Documentation/core-api/atomic_t.rst
index bee3b1bca9a7b4..1f088eb2179c6c 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/core-api/atomic_t.rst
@@ -1,63 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-On atomic types (atomic_t atomic64_t and atomic_long_t).
+============
+Atomic types
+============
 
 The atomic type provides an interface to the architecture's means of atomic
 RMW operations between CPUs (atomic operations on MMIO are not supported and
 can lead to fatal traps on some platforms).
 
 API
----
+===
 
-The 'full' API consists of (atomic64_ and atomic_long_ prefixes omitted for
+The 'full' API consists of (atomic64\_ and atomic_long\_ prefixes omitted for
 brevity):
 
-Non-RMW ops:
+* Non-RMW ops:
 
-  atomic_read(), atomic_set()
-  atomic_read_acquire(), atomic_set_release()
+  * atomic_read(), atomic_set()
+  * atomic_read_acquire(), atomic_set_release()
 
 
-RMW atomic operations:
+* RMW atomic operations:
 
-Arithmetic:
+  * Arithmetic:
 
-  atomic_{add,sub,inc,dec}()
-  atomic_{add,sub,inc,dec}_return{,_relaxed,_acquire,_release}()
-  atomic_fetch_{add,sub,inc,dec}{,_relaxed,_acquire,_release}()
+    * atomic_{add,sub,inc,dec}()
+    * atomic_{add,sub,inc,dec}_return{,_relaxed,_acquire,_release}()
+    * atomic_fetch_{add,sub,inc,dec}{,_relaxed,_acquire,_release}()
 
 
-Bitwise:
+  * Bitwise:
 
-  atomic_{and,or,xor,andnot}()
-  atomic_fetch_{and,or,xor,andnot}{,_relaxed,_acquire,_release}()
+    * atomic_{and,or,xor,andnot}()
+    * atomic_fetch_{and,or,xor,andnot}{,_relaxed,_acquire,_release}()
 
 
-Swap:
+  * Swap:
 
-  atomic_xchg{,_relaxed,_acquire,_release}()
-  atomic_cmpxchg{,_relaxed,_acquire,_release}()
-  atomic_try_cmpxchg{,_relaxed,_acquire,_release}()
+    * atomic_xchg{,_relaxed,_acquire,_release}()
+    * atomic_cmpxchg{,_relaxed,_acquire,_release}()
+    * atomic_try_cmpxchg{,_relaxed,_acquire,_release}()
 
 
-Reference count (but please see refcount_t):
+  * Reference count (but please see refcount_t):
 
-  atomic_add_unless(), atomic_inc_not_zero()
-  atomic_sub_and_test(), atomic_dec_and_test()
+    * atomic_add_unless(), atomic_inc_not_zero()
+    * atomic_sub_and_test(), atomic_dec_and_test()
 
 
-Misc:
+  * Misc:
 
-  atomic_inc_and_test(), atomic_add_negative()
-  atomic_dec_unless_positive(), atomic_inc_unless_negative()
+    * atomic_inc_and_test(), atomic_add_negative()
+    * atomic_dec_unless_positive(), atomic_inc_unless_negative()
 
 
-Barriers:
+* Barriers:
 
-  smp_mb__{before,after}_atomic()
+  * smp_mb__{before,after}_atomic()
 
 
-TYPES (signed vs unsigned)
------
+Types (signed vs unsigned)
+==========================
 
 While atomic_t, atomic_long_t and atomic64_t use int, long and s64
 respectively (for hysterical raisins), the kernel uses -fno-strict-overflow
@@ -74,10 +77,11 @@ With this we also conform to the C/C++ _Atomic behaviour and things like
 P1236R1.
 
 
-SEMANTICS
----------
+Semantics
+=========
 
-Non-RMW ops:
+Non-RMW ops
+-----------
 
 The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
 implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
@@ -86,7 +90,7 @@ the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
 and are doing it wrong.
 
 A note for the implementation of atomic_set{}() is that it must not break the
-atomicity of the RMW ops. That is:
+atomicity of the RMW ops. That is::
 
   C Atomic-RMW-ops-are-atomic-WRT-atomic_set
 
@@ -109,14 +113,14 @@ atomicity of the RMW ops. That is:
 
 In this case we would expect the atomic_set() from CPU1 to either happen
 before the atomic_add_unless(), in which case that latter one would no-op, or
-_after_ in which case we'd overwrite its result. In no case is "2" a valid
+**after** in which case we'd overwrite its result. In no case is "2" a valid
 outcome.
 
 This is typically true on 'normal' platforms, where a regular competing STORE
 will invalidate a LL/SC or fail a CMPXCHG.
 
 The obvious case where this is not so is when we need to implement atomic ops
-with a lock:
+with a lock::
 
   CPU0						CPU1
 
@@ -131,7 +135,8 @@ with a lock:
 the typical solution is to then implement atomic_set{}() with atomic_xchg().
 
 
-RMW ops:
+RMW ops
+-------
 
 These come in various forms:
 
@@ -148,7 +153,7 @@ These come in various forms:
  - swap operations: xchg(), cmpxchg() and try_cmpxchg()
 
  - misc; the special purpose operations that are commonly used and would,
-   given the interface, normally be implemented using (try_)cmpxchg loops but
+   given the interface, normally be implemented using (try\_)cmpxchg loops but
    are time critical and can, (typically) on LL/SC architectures, be more
    efficiently implemented.
 
@@ -157,25 +162,27 @@ atomic variable) can be fully ordered and no intermediate state is lost or
 visible.
 
 
-ORDERING  (go read memory-barriers.txt first)
---------
+Ordering
+========
+
+.. note::
+   Go read Documentation/core-api/memory-barriers.rst first if you
+   don't have yet grasped intricacies of operations involving
+   memory barriers.
 
 The rule of thumb:
 
  - non-RMW operations are unordered;
-
  - RMW operations that have no return value are unordered;
-
  - RMW operations that have a return value are fully ordered;
-
  - RMW operations that are conditional are unordered on FAILURE,
    otherwise the above rules apply.
 
 Except of course when a successful operation has an explicit ordering like:
 
- {}_relaxed: unordered
- {}_acquire: the R of the RMW (or atomic_read) is an ACQUIRE
- {}_release: the W of the RMW (or atomic_set)  is a  RELEASE
+ - {}_relaxed: unordered
+ - {}_acquire: the R of the RMW (or atomic_read) is an ACQUIRE
+ - {}_release: the W of the RMW (or atomic_set)  is a  RELEASE
 
 Where 'unordered' is against other memory locations. Address dependencies are
 not defeated.  Conditional operations are still unordered on FAILURE.
@@ -185,7 +192,7 @@ subsequent. Therefore a fully ordered primitive is like having an smp_mb()
 before and an smp_mb() after the primitive.
 
 
-The barriers:
+The barriers::
 
   smp_mb__{before,after}_atomic()
 
@@ -202,14 +209,15 @@ These helper barriers exist because architectures have varying implicit
 ordering on their SMP atomic primitives. For example our TSO architectures
 provide full ordered atomics and these barriers are no-ops.
 
-NOTE: when the atomic RmW ops are fully ordered, they should also imply a
-compiler barrier.
+.. note::
+   When the atomic RmW ops are fully ordered, they should also imply a
+   compiler barrier.
 
-Thus:
+Thus::
 
   atomic_fetch_add();
 
-is equivalent to:
+is equivalent to::
 
   smp_mb__before_atomic();
   atomic_fetch_add_relaxed();
@@ -217,7 +225,7 @@ is equivalent to:
 
 However the atomic_fetch_add() might be implemented more efficiently.
 
-Further, while something like:
+Further, while something like::
 
   smp_mb__before_atomic();
   atomic_dec(&X);
@@ -225,13 +233,13 @@ Further, while something like:
 is a 'typical' RELEASE pattern, the barrier is strictly stronger than
 a RELEASE because it orders preceding instructions against both the read
 and write parts of the atomic_dec(), and against all following instructions
-as well. Similarly, something like:
+as well. Similarly, something like::
 
   atomic_inc(&X);
   smp_mb__after_atomic();
 
 is an ACQUIRE pattern (though very much not typical), but again the barrier is
-strictly stronger than ACQUIRE. As illustrated:
+strictly stronger than ACQUIRE. As illustrated::
 
   C Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
 
@@ -258,7 +266,7 @@ strictly stronger than ACQUIRE. As illustrated:
 This should not happen; but a hypothetical atomic_inc_acquire() --
 (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
 because it would not order the W part of the RMW against the following
-WRITE_ONCE.  Thus:
+WRITE_ONCE.  Thus::
 
   P0			P1
 
@@ -273,34 +281,42 @@ WRITE_ONCE.  Thus:
 is allowed.
 
 
-CMPXCHG vs TRY_CMPXCHG
-----------------------
+cmpxchg vs try_cmpxchg
+======================
 
-  int atomic_cmpxchg(atomic_t *ptr, int old, int new);
-  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new);
+.. code-block:: c
+
+   int atomic_cmpxchg(atomic_t *ptr, int old, int new);
+   bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new);
 
 Both provide the same functionality, but try_cmpxchg() can lead to more
 compact code. The functions relate like:
 
-  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
-  {
-    int ret, old = *oldp;
-    ret = atomic_cmpxchg(ptr, old, new);
-    if (ret != old)
-      *oldp = ret;
-    return ret == old;
-  }
+.. code-block:: c
+
+   bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
+   {
+     int ret, old = *oldp;
+     ret = atomic_cmpxchg(ptr, old, new);
+     if (ret != old)
+       *oldp = ret;
+     return ret == old;
+   }
 
 and:
 
-  int atomic_cmpxchg(atomic_t *ptr, int old, int new)
-  {
-    (void)atomic_try_cmpxchg(ptr, &old, new);
-    return old;
-  }
+.. code-block:: c
+
+   int atomic_cmpxchg(atomic_t *ptr, int old, int new)
+   {
+     (void)atomic_try_cmpxchg(ptr, &old, new);
+     return old;
+   }
 
 Usage:
 
+.. code-block:: c
+
   old = atomic_read(&v);			old = atomic_read(&v);
   for (;;) {					do {
     new = func(old);				  new = func(old);
@@ -310,12 +326,13 @@ Usage:
     old = tmp;
   }
 
-NB. try_cmpxchg() also generates better code on some platforms (notably x86)
-where the function more closely matches the hardware instruction.
+.. note::
+   try_cmpxchg() also generates better code on some platforms (notably x86)
+   where the function more closely matches the hardware instruction.
 
 
-FORWARD PROGRESS
-----------------
+Forward Progress
+================
 
 In general strong forward progress is expected of all unconditional atomic
 operations -- those in the Arithmetic and Bitwise classes and xchg(). However
@@ -328,30 +345,34 @@ while an LL/SC architecture 'can/should/must' provide forward progress
 guarantees between competing LL/SC sections, such a guarantee does not
 transfer to cmpxchg() implemented using LL/SC. Consider:
 
-  old = atomic_read(&v);
-  do {
-    new = func(old);
-  } while (!atomic_try_cmpxchg(&v, &old, new));
+.. code-block:: c
+
+   old = atomic_read(&v);
+   do {
+     new = func(old);
+   } while (!atomic_try_cmpxchg(&v, &old, new));
 
 which on LL/SC becomes something like:
 
-  old = atomic_read(&v);
-  do {
-    new = func(old);
-  } while (!({
-    volatile asm ("1: LL  %[oldval], %[v]\n"
-                  "   CMP %[oldval], %[old]\n"
-                  "   BNE 2f\n"
-                  "   SC  %[new], %[v]\n"
-                  "   BNE 1b\n"
-                  "2:\n"
-                  : [oldval] "=&r" (oldval), [v] "m" (v)
-		  : [old] "r" (old), [new] "r" (new)
-                  : "memory");
-    success = (oldval == old);
-    if (!success)
-      old = oldval;
-    success; }));
+.. code-block:: c
+
+   old = atomic_read(&v);
+   do {
+     new = func(old);
+   } while (!({
+     volatile asm ("1: LL  %[oldval], %[v]\n"
+                   "   CMP %[oldval], %[old]\n"
+                   "   BNE 2f\n"
+                   "   SC  %[new], %[v]\n"
+                   "   BNE 1b\n"
+                   "2:\n"
+                   : [oldval] "=&r" (oldval), [v] "m" (v)
+                   : [old] "r" (old), [new] "r" (new)
+                   : "memory");
+     success = (oldval == old);
+     if (!success)
+       old = oldval;
+     success; }));
 
 However, even the forward branch from the failed compare can cause the LL/SC
 to fail on some architectures, let alone whatever the compiler makes of the C
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 4bc132fefaab7f..6f15593d6889d4 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -48,7 +48,7 @@ Library functionality that is used throughout the kernel.
    this_cpu_ops
    timekeeping
    errseq
-   wrappers/atomic_t
+   atomic_t
    atomic_bitops
    floating-point
    union_find
diff --git a/Documentation/core-api/wrappers/atomic_t.rst b/Documentation/core-api/wrappers/atomic_t.rst
deleted file mode 100644
index ed109a964c7789..00000000000000
--- a/Documentation/core-api/wrappers/atomic_t.rst
+++ /dev/null
@@ -1,19 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-   This is a simple wrapper to bring atomic_t.txt into the RST world
-   until such a time as that file can be converted directly.
-
-============
-Atomic types
-============
-
-.. raw:: latex
-
-    \footnotesize
-
-.. include:: ../../atomic_t.txt
-   :literal:
-
-.. raw:: latex
-
-    \normalsize
-
-- 
An old man doll... just what I always wanted! - Clara


