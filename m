Return-Path: <linux-arch+bounces-12829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE8B0878B
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 10:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B66D4A378D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB927FD6E;
	Thu, 17 Jul 2025 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxseUcsg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049192797AF;
	Thu, 17 Jul 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739624; cv=none; b=lBSiwRDhu2p3nVelYZqWrzqHzdMFZcMOuJtD6Ui2xMWeqmTBiB19gfbW5nUN83ZuvORHJTq32H6aSh6TjWdwSiqG0X4H/VOCeC2KhG9w9LgJE56E91ElMfFgPnGd9av/1vmQEQeicoMwOfw5Zd9nCQ4G/hxua4JVubq2FbaTH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739624; c=relaxed/simple;
	bh=pX2EcTfO2rVRCOehEfwLbnYVPG97ExZcriLomj9cUw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLOOktc2dcvaqKMt/yzO4ObuZzn+zlRuLY5maltdmitRDkJoU1Q+BXz7qKTW5ESIKgYkobHj1BajR6Iqdzv/f+UztYLdMc+90FqfhBFpoLN5z8mZ/AcuHmHgRfUa0IvIM2YSIK3dnq2y15afzZeybCPtWKGCycFvzcfFy0WBCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxseUcsg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74af4af04fdso1270545b3a.1;
        Thu, 17 Jul 2025 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752739622; x=1753344422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=im5kVo3zSpTE/DJNANRWfM6LSaXoUCrNcMb0usGbVWE=;
        b=CxseUcsg4gZrxQuH3HLJq4N43goY2Xrp6WM8OtXJFbGbNovX/+tevvVjixsb70tZq6
         q6T8vlAXex0eYuMcyUaa2PBreH2FpcNloCsgbMyuRDoShTJn/nCxkXC2qeGNWANsw8XX
         XqTVt8/KIuAy0AYs2T36VcbrzYjkZo4GPrR5AtYGBQ31NZQNv7miuwqYT/rwMG282wti
         ZeM8Y58RlB43P6JjEdI/kAFvBN90PDY5y1j7A3pCTrxD5I6OCGDpnb0AFxsPTyJTk5aA
         hBqnQ7va2I/HNv3SYIM9PJd/OjhiLInYsSm+drXOor/VMDgEnXGXSVRJv+eZhmO3D/Lb
         Mwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739622; x=1753344422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im5kVo3zSpTE/DJNANRWfM6LSaXoUCrNcMb0usGbVWE=;
        b=K+905acQeTEz/p4ABgP7wjouD3M1My8GyjlmJfz3zgRheFN+tfWtMd/Sw8rUD2uzgX
         W/Ko4i9DoC3nmP8oX8XGQjOATPffl6PGQ/heCPmi00N6BUPlbrAaMVVUnQ0iLiIsMmUV
         M0pz7BmMtMQQg/MP98BOzdEFN0dE+KuNyXoJ2CLzhgSj8bax9sfpbCUFl8F4OLoZ6GyI
         lsMJ2AW4A7G74Zz07/xFuTYmdSH77bCNPLJRvX12Dpfc3DwAR1SeccupYsyvZ4GYlAGH
         sV/1CL14TJzGYL3xV0HehkAQTK1dsUHxdbCDfYLtRwHFfJSF36u47GoHUwohE4JPG4zS
         HjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0VvhLEe9/BwA/BAqVQDLKcrUB0D07tHXTWKbHE8j9k9BIpGixROGvXtCS9wwms9uvbRAGcMiDggRJ@vger.kernel.org, AJvYcCVMj+b9aPOiQvOyYKfWwiivwq+OC8u5wv4+9oQzE2MDJUCKqNFSGElroJEKHrCZ/nPTO9O0AXQ0oc7+DQ==@vger.kernel.org, AJvYcCVzwdVgUww0dlQ50TFkbBOMtG4njTq27UI5KrBL40KPHexfPhyhHCEp37hJTL2+IaF5t76J@vger.kernel.org, AJvYcCWRtqUFbQIwBdB90T5Y2eHBMcnX5qZiSonbmLIdgXx5bxfkpfgQj1NZ0bCa9f2Fz/Ib6vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+oxW6aMq5WY/2LZxi2WPorMGZAGlG7AFVOR+hsU7Xj5QFu2X
	72/5i8FixaW8MCuSxM4dfQWGuHgAb9n+/5ZZVUOt57nV+prVUyDHZ56u
X-Gm-Gg: ASbGncvOLlu0CMwNi13IMJTRz0ZApWWh5iEC/LP43uNMKAHnhGM+UVF4Yh2hUuJrN73
	40qPEM96SA3cjiIM5QlC9ZkgBNi5PGPRKN0y7HIDf6AwcVDWoFheR+NHAf5U92boOIa0pffWxrg
	53TxulEeAED8VIc/84pzwIMozqDy8l3UxQ0ZNykNXYlH93/G9T1lgQmERHWHHMGUZYIdhY4rrtt
	dehq/DouSX02Sd7iHE9JOcOsZvdFgX74exmW9Wrqpiu6yJVn274baamfSyCTr3L6aroT0COiyR5
	Yvyh6RjWizj1+evSvMxsIq63KPHWw7SjGqvZOFXoeYwXWsx4GbXIsPCtLv8nxGy00s2IT/UYxMZ
	v3xA1j9p/7nQd/bbRj/EJ4g==
X-Google-Smtp-Source: AGHT+IE08tSUk8BSkHFbd4EGRS/BqZYs0+NRXRJzu2DZCsZqn5s44suw+fSLDKaq/HOZ137Bw55IqA==
X-Received: by 2002:a05:6a21:329d:b0:234:21aa:b538 with SMTP id adf61e73a8af0-2390c744e99mr3819001637.1.1752739622119;
        Thu, 17 Jul 2025 01:07:02 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4c9c4sm15629003b3a.126.2025.07.17.01.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 01:06:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 856104225A33; Thu, 17 Jul 2025 15:06:53 +0700 (WIB)
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
Subject: [PATCH 0/4] Convert atomic_*.txt and memory-barriers.txt to reST
Date: Thu, 17 Jul 2025 15:06:13 +0700
Message-ID: <20250717080617.35577-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963; i=bagasdotme@gmail.com; h=from:subject; bh=pX2EcTfO2rVRCOehEfwLbnYVPG97ExZcriLomj9cUw0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkVa2M/tu4s3Xpl4sbdZkmuW5Qqp9kEnCyP9S1w2WXJs U2L9V5sRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYyNYDhf62nQ93kRfOvPbKN OMnziueC1RTZmFdnGl9cyH//c3r+hK+MDI8L1Bt0UudIP/yqzsbAcrghOLhiuUrjAw4zvpX9K59 MZgMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Atomic types, atomic bitops, and memory barriers docs are included in kernel
docs build since commit e40573a43d163a ("docs: put atomic*.txt and
memory-barriers.txt into the core-api book") as a wrapper stub for
corresponding uncoverted txt docs. Let's turn them into full-fledged reST docs. 

Bagas Sanjaya (4):
  Documentation: memory-barriers: Convert to reST format
  Documentation: atomic_bitops: Convert to reST format
  Documentation: atomic_t: Convert to reST format
  Documentation: atomic_bitops, atomic_t, memory-barriers: Link to
    newly-converted docs

 Documentation/RCU/rcu_dereference.rst         |    2 +-
 .../atomic_bitops.rst}                        |   43 +-
 .../{atomic_t.txt => core-api/atomic_t.rst}   |  211 ++-
 Documentation/core-api/circular-buffers.rst   |    4 +-
 Documentation/core-api/index.rst              |    6 +-
 .../memory-barriers.rst}                      | 1594 +++++++++--------
 Documentation/core-api/refcount-vs-atomic.rst |    5 +-
 .../core-api/wrappers/atomic_bitops.rst       |   18 -
 Documentation/core-api/wrappers/atomic_t.rst  |   19 -
 .../core-api/wrappers/memory-barriers.rst     |   18 -
 Documentation/driver-api/device-io.rst        |    4 +-
 Documentation/locking/spinlocks.rst           |    5 +-
 Documentation/virt/kvm/vcpu-requests.rst      |    4 +-
 13 files changed, 1000 insertions(+), 933 deletions(-)
 rename Documentation/{atomic_bitops.txt => core-api/atomic_bitops.rst} (54%)
 rename Documentation/{atomic_t.txt => core-api/atomic_t.rst} (67%)
 rename Documentation/{memory-barriers.txt => core-api/memory-barriers.rst} (67%)
 delete mode 100644 Documentation/core-api/wrappers/atomic_bitops.rst
 delete mode 100644 Documentation/core-api/wrappers/atomic_t.rst
 delete mode 100644 Documentation/core-api/wrappers/memory-barriers.rst


base-commit: cae58415830f326822593ec01deebe5fdaeb33a2
-- 
An old man doll... just what I always wanted! - Clara


