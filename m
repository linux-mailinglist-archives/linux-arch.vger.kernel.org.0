Return-Path: <linux-arch+bounces-4994-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF79991193C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 06:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C53C284586
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 04:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136712B176;
	Fri, 21 Jun 2024 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WasrXOsh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5AAD4E;
	Fri, 21 Jun 2024 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718943023; cv=none; b=vArwPCCY089+9YkpBtzgNem5SbCrVVAS+PrvyhITt2Iz/dQ8QCrGc7oaEwiWP+FzJHJSn7urZkwkuJzxhhuqQBF2rsg/VG30Q5DVOJ7IIWwXedcn/dlzlcJVHz5pa5PXBPH95mj2RaOfEio4PXhM6lPxYA3vU+R6To2yz6rqGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718943023; c=relaxed/simple;
	bh=1f4MI1DI2o7vqspkvfFqDdA2EaZwjWclhVSDKHUnVAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHeTzXHTU3xF4AnpB8nc05rLPy3ptnKyrDa5usGh8Tx2QbPv12HQNveKG0Gj1uXbqpVS91AbPFGwDgNx+6mamUbR20C2g7pb22NqPB14aC5jYXjOJt0I2+YTzlKYZWf5k9aJCcAJNYb1oAav/xfDW6EbZGwqSmkpCKqRz2Bl/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WasrXOsh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7041ed475acso1496244b3a.2;
        Thu, 20 Jun 2024 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718943022; x=1719547822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shEiJV8IO8E1rXYoedpXjaqgM9pXQUHq+ze/O/2ukGM=;
        b=WasrXOsh+6OIiX9KyUUjwYCJuAZijI7cE3LQ9aCecIKe61KsWPcMs7hUzLjWmhy47K
         oIsXAyUF8Zjy3J2E63vB6lMliV7t7sVzXd7QVbhtaFsVx01rqx4hiRcDRUqQGfNxAqXM
         /5/vjMr6Lj59FlIbwmXI2+GPhdOCrR4DqNtOlkw7ha+uwienUvJrjaosHgYUzp49tUxe
         gK7pjfE4pETgPyjI2H5gn3Ea6H3yoZrfK88fjHrwf6Ow870wxXZvxNSsx+wmnpjNDHT6
         JM0KKzKsUHP4vvsk7zPt9RtB1+yhrTQ+H57o40HjwegZ+5aNXSp3Vz7lP5lmgxKF2YhU
         L/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718943022; x=1719547822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shEiJV8IO8E1rXYoedpXjaqgM9pXQUHq+ze/O/2ukGM=;
        b=FiI5mraYlBMmXpP+4aPlooNaTMbea0K7JH5kXac/K55wo6DDpfpQh5xiYko/bPbA3a
         dY1f0DtcyPRfBd5wNVM5aJSKOn5xan4h7rMByOav75S7JqZlitPoNWjWYSNcFeZ0Et6O
         +j0TB6lNlDdesKcAFOrf77K5o/QjsIcX4ZNIBd5j6pXVECkhbQlg+Rn+Uyp/w2PiAOob
         KNxbHLvpKNaRxSilH9I6hjVjD1IRHQk5NAdda4qnc1fU4JpZi0HQJeqA19fDKlLVBE/a
         zKL4bh22cZJLtbc9WPamNCnSl8xMb4y7/SsEUpSi81KyWrUK4ojDHszAk7CSxtuOytDQ
         Nbnw==
X-Forwarded-Encrypted: i=1; AJvYcCUezE+X2b+0djet8lH8YzlHj8CWUGqZzU8LBHioAZ+0Fh4ZBUh9Xko0IzEsZDZL/p1TWn0gSFAJk11T6sxzXu2hHIDI4F/olToOPoMKyKSuM8lCUgf3UpL/75BAQjSpkEzUE9APO+phSg==
X-Gm-Message-State: AOJu0YwvkTtE4Z8aKNOiQ0VxdzdkhS86jN1/R8zvnT4WsYeOQbu6yudT
	y8cofokvf51wCShq82hs8TWAjrT3lFT9c0KJFWrpUCinXEV5kIj0+53JNw==
X-Google-Smtp-Source: AGHT+IE2ljdGI2dXAlwLCHpYTPQjQrh6ZykdzcKSciKBymJSC5KG+IVJyQ5OX6HP22vx2NMXKNJFPA==
X-Received: by 2002:a62:e507:0:b0:705:a18a:6870 with SMTP id d2e1a72fcca58-70629c1e9b7mr6220786b3a.5.1718943021697;
        Thu, 20 Jun 2024 21:10:21 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065124dd03sm431032b3a.113.2024.06.20.21.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 21:10:21 -0700 (PDT)
Message-ID: <acea86e9-757e-482d-a693-e6c4e85a38af@gmail.com>
Date: Fri, 21 Jun 2024 13:10:17 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH lkmm 1/2] tools/memory-model: Add locking.txt and glossary.txt
 to README
To: "Paul E. McKenney" <paulmck@kernel.org>, Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, Akira Yokosawa <akiyks@gmail.com>
References: <ae2b0f62-a593-4e7c-ab51-06d4e8a21005@gmail.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <ae2b0f62-a593-4e7c-ab51-06d4e8a21005@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

locking.txt and glossary.txt have been in LKMM's documentation for
quite a while.

Add them in README's introduction of docs and the list of docs at the
bottom.  Add access-marking.txt in the former as well.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Marco Elver <elver@google.com>
---
 tools/memory-model/Documentation/README | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 44e7dae73b29..08be2140a0fa 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -9,6 +9,8 @@ depending on what you know and what you would like to learn.  Please note
 that the documents later in this list assume that the reader understands
 the material provided by documents earlier in this list.
 
+If LKMM-specific terms lost you, glossary.txt might help you.
+
 o	You are new to Linux-kernel concurrency: simple.txt
 
 o	You have some background in Linux-kernel concurrency, and would
@@ -21,6 +23,9 @@ o	You are familiar with the Linux-kernel concurrency primitives
 	that you need, and just want to get started with LKMM litmus
 	tests:  litmus-tests.txt
 
+o	You would like to access lock-protected shared variables without
+	having their corresponding locks held:  locking.txt
+
 o	You are familiar with Linux-kernel concurrency, and would
 	like a detailed intuitive understanding of LKMM, including
 	situations involving more than two threads:  recipes.txt
@@ -28,6 +33,11 @@ o	You are familiar with Linux-kernel concurrency, and would
 o	You would like a detailed understanding of what your compiler can
 	and cannot do to control dependencies:  control-dependencies.txt
 
+o	You would like to mark concurrent normal accesses to shared
+	variables so that intentional "racy" accesses can be properly
+	documented, especially when you are responding to complaints
+	from KCSAN:  access-marking.txt
+
 o	You are familiar with Linux-kernel concurrency and the use of
 	LKMM, and would like a quick reference:  cheatsheet.txt
 
@@ -62,6 +72,9 @@ control-dependencies.txt
 explanation.txt
 	Detailed description of the memory model.
 
+glossary.txt
+	Brief definitions of LKMM-related terms.	
+
 herd-representation.txt
 	The (abstract) representation of the Linux-kernel concurrency
 	primitives in terms of events.
@@ -70,6 +83,10 @@ litmus-tests.txt
 	The format, features, capabilities, and limitations of the litmus
 	tests that LKMM can evaluate.
 
+locking.txt
+	Rules for accessing lock-protected shared variables outside of
+	their corresponding critical sections.
+
 ordering.txt
 	Overview of the Linux kernel's low-level memory-ordering
 	primitives by category.
-- 
2.34.1



