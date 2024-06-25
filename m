Return-Path: <linux-arch+bounces-5074-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C59161CA
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 10:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB923286F87
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD7149003;
	Tue, 25 Jun 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxtayqUD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF57148FE5;
	Tue, 25 Jun 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305906; cv=none; b=Vsp71e6KdakE+WrzCmtNqNoEt2YMAzfml1S5ksMrkH7CNvoNk7emVN0REf2r79shimi1td1/ro1D58fSc0842/suPo4yl4SJjFhNra5GuavIG0Rd93dbqnM7xOyW0I6S8at9zviSIcB8IrHssomsy3KB1DcK9MvydK2OOumc/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305906; c=relaxed/simple;
	bh=D6eaihrBuRXlBbFlKmoRvuO//cNJrecy//x09Y7t1L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxzeaElbqiVXcFb/9/dZdIYWwl7qKhWbzprUCbMj+06uBZFX46Ig3dtN4FPGEMl2Ii+mdTxruU5FOoYQXawu88t58+RgTbdBHgu+6KM2r5ccRXmzC5CYW2IsfL2yU5hLByELlUw4TpH0h/bcpJV8lxrHkc1VQWEP4PuarDFr7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxtayqUD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9b523a15cso37593745ad.0;
        Tue, 25 Jun 2024 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719305904; x=1719910704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9GuOsLR671aW57nNhKzROWH1Hjh5iQv0zp32oCvBD0=;
        b=OxtayqUDeqVNJI94P6Oxzkn4iFkbvjak99kF/yX1gaIFt0Iafq/uM+fGcr9snq5/P1
         xjZhgA0A+sP+vafj4TjP5QRJO2tx2FzQPIaM2e+PHvpgEGUMr6NguynH/NXmH5KL8Ype
         EpcqtNY4XIIGvl/yDZkzyRdVqtwTfcZVrzLflsVDkt3oUgr6pvqR8S1MiT/m8TpIH95V
         byXW4rCeNeKnjV4A55ZGSFxKo7NBzIjiEBPcrR4j5Lj4UnpKD1+LKUZpXnWx+6aPiT7X
         39Edk9YkVdNoRmeSTZjhB5yxG7gDmcBvmFndYuNVz6ZRLSVCVHdxobUxqlQ9K34zoy3B
         dFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305904; x=1719910704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9GuOsLR671aW57nNhKzROWH1Hjh5iQv0zp32oCvBD0=;
        b=TAJUXXCv52H4s216JtaZBwHmNZfCkZfVKuwUqdFmwZ0RLnvGOmZL4TlMp3528BbMVR
         BrD5lPDS6J/oNQyZntW95Ajprc3oVkJ0YYYPye6WL35MG7g27dTDFTOzOvYoN89fENqL
         Uu/p8t/eXqbMfGJ/FK1yXJIlW+LhythFFcQSPDUZp+JdNEjwHIFt+sLE9p0CTwglmig2
         twqYe38dz4PZ+ovHGenkD0RDKpFimH9MAsbdvZ3/o1RWNpVXGCfhot6r/qfpG3NZBAnr
         y9YTcxlAvJHHirrYwBe9p13LEibhxcNmV6nXB3qufC+T2aIPaUOZgsGs1bIVYTZPku/b
         Kiqw==
X-Forwarded-Encrypted: i=1; AJvYcCVJNorFQZw8JEqCRjh7ppoUGcfErude3MF2wN9IfFgAdkgABxvpwmJDv7eIVXImPotlMuY5/X5zmosZDf9Hj5r5TvGMf8qbjaOtVO3+oEAfkHtblXl+NKCd+M9EXQkBgCuZozI7i5SW+w==
X-Gm-Message-State: AOJu0YyRQaijVnA/fQaSFhvxVe3XrLAZLsHqBdQBFEFU5UrwNnheF8YK
	IpjUzlM6n0IcCPMyNmEe3VW4tYCnu9zay+GJVQSKQx2ysEwoIv7L
X-Google-Smtp-Source: AGHT+IE9x9dH6IKjN4+unaAQ4toER0+WbCcuiHV3FDy+d3Ech66p/oZQL/TWIuMx8S3W3AbNkeYZ2w==
X-Received: by 2002:a17:903:228a:b0:1f4:8bb9:924f with SMTP id d9443c01a7336-1fa5e640661mr39332155ad.1.1719305904072;
        Tue, 25 Jun 2024 01:58:24 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb5debc3sm76332845ad.216.2024.06.25.01.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 01:58:23 -0700 (PDT)
Message-ID: <1765f4ca-e5eb-4dfd-b986-10e7228cdc33@gmail.com>
Date: Tue, 25 Jun 2024 17:58:21 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH lkmm v2 1/2] tools/memory-model: Add locking.txt and
 glossary.txt to README
To: "Paul E. McKenney" <paulmck@kernel.org>, Marco Elver <elver@google.com>,
 Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <a07d41c9-5236-44ad-8e89-f3be5da90e98@gmail.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <a07d41c9-5236-44ad-8e89-f3be5da90e98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

locking.txt and glossary.txt have been in LKMM's documentation for
quite a while.

Add them in README's introduction of docs and the list of docs at the
bottom.  Add access-marking.txt in the former as well.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Cc: Marco Elver <elver@google.com>
---
v2:
  Removed trailing white space (Andrea).

--
 tools/memory-model/Documentation/README | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 44e7dae73b29..9999c1effdb6 100644
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



