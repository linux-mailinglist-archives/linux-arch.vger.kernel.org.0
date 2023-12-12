Return-Path: <linux-arch+bounces-924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A92B80F49D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 18:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE871C20AE7
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6267D89C;
	Tue, 12 Dec 2023 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePqER2dE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12422B9;
	Tue, 12 Dec 2023 09:27:51 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d336760e72so8029535ad.3;
        Tue, 12 Dec 2023 09:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402070; x=1703006870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jynICPKoLwHaNl/nb1iCaIX3mL0xnnXkT4vQVCsRZhA=;
        b=ePqER2dELffZ7v0W6QBXdxpdZnF+D8lY3wgasOxEsI8ltHVpGR9O+qOLLaREPEmR9m
         Q3G3aObWHyQMzkWtgOhu/aw9G30sPpXW/zQNdQgTMv6KHR3i4k427Zk+G7iv56g4YF86
         kIVY/WdvGjv7c/dW0JfGHbN33SfXctAy6bbc5pbIFCWqBAAaCgCiSy6baBxzS70gqIvp
         6y1lXechWjKDEK2SwKMhX4vhknxjfQhM2lZdulQ3URg4j5QIxQZWwAi8WGcMTacLriSH
         V63sCPpLGvuz4UuzMgcfmwRgGSZbsAOl5jzoPBxXh2Jldpb+cTPFOL8cFx1pzFAGttPc
         xz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402070; x=1703006870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jynICPKoLwHaNl/nb1iCaIX3mL0xnnXkT4vQVCsRZhA=;
        b=FsvyzRLY2K8k13aVQ9qLCnIfbR0pr1McdnMrVqJGgJ6Y84j5TFgZxlxahWOxy/oX22
         atSS1T3BbJIPc1163TQpGvIdh0LmQZUCNrhqypDTpprb+J+t8H1MJHTTGjnoj5S0y1Z8
         ekBfi1kVZGXB9DvRGyYQve8WOALD5gU+Gpz7Rt6eoQYFYkJ3UpYiaZLFTsTANvaXg9/f
         V0Y8Fx/el6AFDUjiLCMKwLQUthp5CsTxGQDxRKBMBTWfV4h6yTWUAoZ8ckr5/hh+Ho69
         isA26V4poNkYppVF33Jo7AjdD3WER9dKXrT+wluvLLhBz+jyjvjtskDOjt0aUCPSBt0E
         ZYjQ==
X-Gm-Message-State: AOJu0YxfynQ/klHz5HIOfjhW6TrjgUxTSPlhfJjBOTVk90nIZ3B1oGOc
	ujTLc+FemEHODqFQmeEJVnNZjZLtzC9yl+v0
X-Google-Smtp-Source: AGHT+IEmzmstegOSP1NfPzK2eL1lR3d6LdaJTZkEhbecs67QjwOFdMmSiK5G1lV1xqQY3ZbScwc06A==
X-Received: by 2002:a17:902:d64a:b0:1d3:479d:3d56 with SMTP id y10-20020a170902d64a00b001d3479d3d56mr379083plh.133.1702402069993;
        Tue, 12 Dec 2023 09:27:49 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001cf511aa772sm8863170plg.145.2023.12.12.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:27:49 -0800 (PST)
From: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	Neeraj.Upadhyay@amd.com,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 5/5] doc: Clarify historical disclaimers in memory-barriers.txt
Date: Tue, 12 Dec 2023 22:56:53 +0530
Message-Id: <20231212172653.11485-5-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212172343.GA11383@neeraj.linux>
References: <20231212172343.GA11383@neeraj.linux>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit makes it clear that the reason that these sections are
historical is that smp_read_barrier_depends() is no more.  It also
removes the point about comparison operations, given that there are
other optimizations that can break address dependencies.

Suggested-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: <linux-arch@vger.kernel.org>
Cc: <linux-doc@vger.kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 Documentation/memory-barriers.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index d414e145f912..4202174a6262 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -396,10 +396,11 @@ Memory barriers come in four basic varieties:
 
 
  (2) Address-dependency barriers (historical).
-     [!] This section is marked as HISTORICAL: For more up-to-date
-     information, including how compiler transformations related to pointer
-     comparisons can sometimes cause problems, see
-     Documentation/RCU/rcu_dereference.rst.
+     [!] This section is marked as HISTORICAL: it covers the long-obsolete
+     smp_read_barrier_depends() macro, the semantics of which are now
+     implicit in all marked accesses.  For more up-to-date information,
+     including how compiler transformations can sometimes break address
+     dependencies, see Documentation/RCU/rcu_dereference.rst.
 
      An address-dependency barrier is a weaker form of read barrier.  In the
      case where two loads are performed such that the second depends on the
@@ -560,9 +561,11 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 
 ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
 ----------------------------------------
-[!] This section is marked as HISTORICAL: For more up-to-date information,
-including how compiler transformations related to pointer comparisons can
-sometimes cause problems, see Documentation/RCU/rcu_dereference.rst.
+[!] This section is marked as HISTORICAL: it covers the long-obsolete
+smp_read_barrier_depends() macro, the semantics of which are now implicit
+in all marked accesses.  For more up-to-date information, including
+how compiler transformations can sometimes break address dependencies,
+see Documentation/RCU/rcu_dereference.rst.
 
 As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
 DEC Alpha, which means that about the only people who need to pay attention
-- 
2.40.1


