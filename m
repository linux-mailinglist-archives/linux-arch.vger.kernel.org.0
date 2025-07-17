Return-Path: <linux-arch+bounces-12827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109AB08787
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 10:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3871A1796C4
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3292798F8;
	Thu, 17 Jul 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuJZK+r0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC5277CBD;
	Thu, 17 Jul 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739623; cv=none; b=ChuAyqu5L2zzjFq4vuq6izpCt0nw8XVe7z9JDbzea7zEQTF2LjICMohc7dALbBQ+WV8aRJ3URYFacqRzVqw+jAgjdr8Q6gQK8wO0QA4ruUuY8bgIsMRXULxSKlaMCpzP3lX4twXSbeiXEoVs/PhAhfyi7m/JjaSJQxdrmD19McE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739623; c=relaxed/simple;
	bh=U3rEHkMFDVqeYNM1YK+WP0qvm2uVyLOr+spTs97POZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtYOGT78w9i67T19RT8j/W/iXLUH6MVnIDE5QzY75z3s3481uoZx3vD+f58UN/jB9czZ0nv6tmEM4jT1m7WKdgJTEZwZTPfSjfRaKmCg0avpI4Bivt1f2rSLEpZIwXo0Xjcd0AEaxER2NBIYfSNH/IqZ8+RfzfLZNhZ8oH9IxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuJZK+r0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234f17910d8so5694295ad.3;
        Thu, 17 Jul 2025 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752739621; x=1753344421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tsmt0+LF0mgELoIzcxHsmAHqp6eKZ3MWd8Pt639i0Q=;
        b=UuJZK+r0CvJViRbZMiFvJE/YKPeo+l+r7t1/8LhSQRhAh3Bf0HJXcC2DkvxeqMgmMB
         7syEOdSi53GypkoGuTTemhH/OlXmPrjM2zuoRbSETKdXtk9oUykuiBdJi7UERglB5nuU
         IIFBHPAkobXM+/JOoDYiekcJR5D4AifobM9z1IkTFuBmdXCQbA1FIBwY8M4DzljgeDT4
         5FH2c/XHUn3412wa3RT4pbVwHHXyfiBc4+C74SFVS8tw42tcmyVhfN19O0SJZG3sK8XX
         jgMnzrgeGXlwonVdW7vUTW+fTpftXMg8DLtsK05cBoaPOoIB0KWWvpgqxYRBzfzY53Km
         d40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739621; x=1753344421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tsmt0+LF0mgELoIzcxHsmAHqp6eKZ3MWd8Pt639i0Q=;
        b=EvZGXC2TPpBFlMRk9iAsEkTUSw2WhPTQBXQzw0IkhLq/uZfUdVVsvoqTBil/s5gtSk
         xpP3M51sNHXc8o7BMHTibG/gYDsR48c3h7/L1FmNpS89iSnHgrtNY8yescu++peMc4M8
         3LVs/ILV9Wtg/EyEsVNtxppMJw0yq2IJWeuVj8p3avNwf+2fgK6WCmQv9ASxIwHU2GwO
         ZdSS0oguHocPTjcFR8OsDE6XNCAUjP+dbuzY1nSHh2LoZe3rihdX9AHElOBtziV2z9UG
         Sz82nWvxzOchN5m/2ENCyjawJOyHEQong6h388E8uMow8iZsU2xASBOUe3d7/I9vMex+
         yayg==
X-Forwarded-Encrypted: i=1; AJvYcCUZGTlJt7ef8HVRhoryuhEw7EM1nXLRaCZru2ruCPcdGegHugUX7rEtfqcx45KkK9QUS0P1@vger.kernel.org, AJvYcCVG8G25F4twLFqdLb/Fi86LeNHatVMnCaW8T6T2Jo3N9tagcK7fa2rkzhYnc7k3g1uxVplnO6zcGCMs@vger.kernel.org, AJvYcCVnTkFubW/nk5BcRQM/wT191bI45LnusyUSU3GQLCGPDpe7UdSSnb/lBCIQ82VZtNuO98eQ3i/6tbZI5A==@vger.kernel.org, AJvYcCX4fx1Pcn1qsCYfkpZz9Uu9khr3XyULiAcxlny5zsKfUeRBBDUqFfu//lxJY6QOVp4eZ1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ihvgvCYTE1iv6NYZHWkWVbHAjth2o7PR+6HWbEUclTlKtXEr
	S2jTcK1qlyE4Odxm9TNT2Gc0DrlFX0EhPNkkZOb29gjynxZRN8w4IrVl
X-Gm-Gg: ASbGncusT2i5J64zo/9qRAR+c1CkocvIEkBuC7u7AhnHG0sUQX5+Lxk8PXEO6luXick
	bc9j3Ze4qceJcWl7xyYwS034xMfX3IKdkafz+rdZCKKw5K7ANLnMpFBkDYb0X+Ifam8ujt+iO4G
	VY6sHXxV4A1IYAN7TjWNG6l365hVsGJtYuQU9lTaiD+FYi2+2Hr3wahib87hTI4dCai/ed8wsX4
	ypF5BW4XSyNroqsVWHNIdqygkAYsY6Qt1jTGvyeJgRxDJcWkw1RxT8HoA452MqJRjI/l0e7Ywpj
	pKjinD8pxuIuQOk0FgXuPFzm2fykUUxeQKD9vrt5Jns/6pP5bj0az51VH6jWPBbbLuy6SFfmxZ4
	tJveXvO7GO0TSIFLIqB2P1w==
X-Google-Smtp-Source: AGHT+IFDRHT5gKk69iHNgFOk4RqIEj9LmjlaBFo7IYhVrJNGWIeWcgsmkpyoZXnBkXuTx/sDripipA==
X-Received: by 2002:a17:902:fc43:b0:234:f15b:f158 with SMTP id d9443c01a7336-23e24ed60f5mr73096245ad.13.1752739620354;
        Thu, 17 Jul 2025 01:07:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e527sm142131915ad.187.2025.07.17.01.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 01:06:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E0828401640C; Thu, 17 Jul 2025 15:06:53 +0700 (WIB)
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
Subject: [PATCH 2/4] Documentation: atomic_bitops: Convert to reST format
Date: Thu, 17 Jul 2025 15:06:15 +0700
Message-ID: <20250717080617.35577-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717080617.35577-1-bagasdotme@gmail.com>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3923; i=bagasdotme@gmail.com; h=from:subject; bh=U3rEHkMFDVqeYNM1YK+WP0qvm2uVyLOr+spTs97POZ4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkVa5MTHyX29kj/kI2qCgg0q/lUFHmwhit6pT9jlmLez YUFX+d1lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCIp1xgZVvSb3tv6Zh3vIYZL 82sr7tezqahkng65dqrq902+n6fe7WNkOLPqpLfAjdMMlme+n+0JF5yQ7jrL5c61eUlnF5yfMm/ CXQYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert atomic bitops documentation to reST syntax:

* Sentence-case headings
* List API functions and their semantics in bullet list

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../atomic_bitops.rst}                        | 39 +++++++++----------
 Documentation/core-api/index.rst              |  2 +-
 .../core-api/wrappers/atomic_bitops.rst       | 18 ---------
 3 files changed, 20 insertions(+), 39 deletions(-)
 rename Documentation/{atomic_bitops.txt => core-api/atomic_bitops.rst} (60%)
 delete mode 100644 Documentation/core-api/wrappers/atomic_bitops.rst

diff --git a/Documentation/atomic_bitops.txt b/Documentation/core-api/atomic_bitops.rst
similarity index 60%
rename from Documentation/atomic_bitops.txt
rename to Documentation/core-api/atomic_bitops.rst
index edea4656c5c05f..b93c388fd9bdc4 100644
--- a/Documentation/atomic_bitops.txt
+++ b/Documentation/core-api/atomic_bitops.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =============
 Atomic bitops
 =============
@@ -11,53 +13,50 @@ API
 
 The single bit operations are:
 
-Non-RMW ops:
+* Non-RMW ops:
 
-  test_bit()
+  * test_bit()
 
-RMW atomic operations without return value:
+* RMW atomic operations without return value:
 
-  {set,clear,change}_bit()
-  clear_bit_unlock()
+  * {set,clear,change}_bit()
+  * clear_bit_unlock()
 
-RMW atomic operations with return value:
+* RMW atomic operations with return value:
 
-  test_and_{set,clear,change}_bit()
-  test_and_set_bit_lock()
+  * test_and_{set,clear,change}_bit()
+  * test_and_set_bit_lock()
 
-Barriers:
+* Barriers:
 
-  smp_mb__{before,after}_atomic()
+  * smp_mb__{before,after}_atomic()
 
 
 All RMW atomic operations have a '__' prefixed variant which is non-atomic.
 
 
-SEMANTICS
+Semantics
 ---------
 
-Non-atomic ops:
+* Non-atomic ops:
 
-In particular __clear_bit_unlock() suffers the same issue as atomic_set(),
-which is why the generic version maps to clear_bit_unlock(), see atomic_t.txt.
+  In particular __clear_bit_unlock() suffers the same issue as atomic_set(),
+  which is why the generic version maps to clear_bit_unlock(), see atomic_t.txt.
 
 
-RMW ops:
+* RMW ops:
 
-The test_and_{}_bit() operations return the original value of the bit.
+  The test_and_{}_bit() operations return the original value of the bit.
 
 
-ORDERING
+Ordering
 --------
 
 Like with atomic_t, the rule of thumb is:
 
  - non-RMW operations are unordered;
-
  - RMW operations that have no return value are unordered;
-
  - RMW operations that have a return value are fully ordered.
-
  - RMW operations that are conditional are fully ordered.
 
 Except for a successful test_and_set_bit_lock() which has ACQUIRE semantics,
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index a0c3749c655b05..4bc132fefaab7f 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -49,7 +49,7 @@ Library functionality that is used throughout the kernel.
    timekeeping
    errseq
    wrappers/atomic_t
-   wrappers/atomic_bitops
+   atomic_bitops
    floating-point
    union_find
    min_heap
diff --git a/Documentation/core-api/wrappers/atomic_bitops.rst b/Documentation/core-api/wrappers/atomic_bitops.rst
deleted file mode 100644
index bf24e4081a8f4c..00000000000000
--- a/Documentation/core-api/wrappers/atomic_bitops.rst
+++ /dev/null
@@ -1,18 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-   This is a simple wrapper to bring atomic_bitops.txt into the RST world
-   until such a time as that file can be converted directly.
-
-=============
-Atomic bitops
-=============
-
-.. raw:: latex
-
-    \footnotesize
-
-.. include:: ../../atomic_bitops.txt
-   :literal:
-
-.. raw:: latex
-
-    \normalsize
-- 
An old man doll... just what I always wanted! - Clara


