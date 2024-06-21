Return-Path: <linux-arch+bounces-4995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAE691193E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 06:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08841C2133B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 04:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A993612B177;
	Fri, 21 Jun 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwI4gSHm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B58AD4E;
	Fri, 21 Jun 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718943149; cv=none; b=Gzldiq5j9dnI9ISXeyc94k2o7sWR08AwRnJrlR3caWkR3kE1TtpNxNZcMKEtajwIFZKev9zEs+EbZFKf/y2veOOpUFjj1Z1kQuE2HPo4vIDpGsgT7C8pTJTOSU+9qCCoj+Cc5xdbdP3pBn2QPuwSctozmOg+G6UMVpAWbZWILs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718943149; c=relaxed/simple;
	bh=rtVZIJcL5kkqMWjP4yhfSFPXG4wJJOFi2G58nad5ADQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDFyPtgmXqB9Ah1FMN5tljLrhpPdaq/P9XxksL35DJdgbn1Zv+AB5RYk843zhC2nkLxehwARdAJWDvnHhM7hdttSo+7HHgeMcoeLuEjLDUqpPRKI6TYdGP/JSkDsBPpAdWyzs1hxCIMlWLw8dXJziI8WpWH+FVaUk4gRFk1WC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwI4gSHm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7062c0ee254so1384605b3a.0;
        Thu, 20 Jun 2024 21:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718943147; x=1719547947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOPtoIteRsS5kXJ6kYmkYXqVjnfQu+Uu3LqctysfLHE=;
        b=hwI4gSHmi5b9YVUKsE4ymj6EZdgtT/H+OJYqNHl/Ar1/j7wz1g/78qbB6zFI/AEJMN
         ENhH0u8b7pSSAJO2AaXbJZhe/ro7GYbzOgrU/kD6zSsuMiAWhjxbrNXq080DsOD/LqlD
         D4pvveZNfXUiraVkvtjhhQPjEPs1NH1w40Hxr7fCngmo3DgCQ1ZAI2J/ack4mXfBCHUU
         ablF3ur2g2Np+LoLYU8jDwSys+W2ub18M1eqP5AknxyhzYuJ9SkidvD6Wt8Z5MOFcKjZ
         4Wec6mSYwF5TEQOsO63JAgE1N1uVYQqc5G8eTyH+S4IQXqJSffNBobr7Vi5bUwzn7GiO
         z+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718943147; x=1719547947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOPtoIteRsS5kXJ6kYmkYXqVjnfQu+Uu3LqctysfLHE=;
        b=msxxmXsnugFPFet343ewvG8I9hnal5uRwLD16+SSPQ9NptTrqPS6h8DRPVb1K8aCfR
         YMMOLYpSlrIXBu8pg8zkqVVfndCkSxGltatrvfANeG6/f40osLNOmtsP8OqrxGFI1Oh3
         I1vXP5sd8R7Jf9Sb37BEIU1m1SypkflGwgV6jewlGuiYzFWDwlvK1JpLMjtYZqA9ZIef
         /dB7wH8DsbHmGXaK/QzGe28nqfaex40p5TDy6HWPLSAcxDQF4m7JW+p685muOyuXm7ZK
         pNtM762nf9Fh8R/SwRysc9H2bCNsfHEE39DMiM3V4sxnCRneBcjQUHfvNPQkKe2Hp6+j
         GaEA==
X-Forwarded-Encrypted: i=1; AJvYcCWhMRRTqMxy1m5KIB7vMf3i2wE95NRGBM+0kza+NpCV/lrbepFCuneB/hHjrwtEzuIs0sqQCH+q5+9T1btQQIXqVY0eMbvo3w1j8zpvEEe/em89K6jA9KgzvmSoDEmZWVivMovUeoqhGg==
X-Gm-Message-State: AOJu0Yzv5RMIZGBw54SrOfb1sKZ31c3H/1DN6gd8igbk8dyQpjIIGEzU
	5eYMWaocc6HW0jYG2bub9WYHlIT65gxiA9LiPgi0bq6d4kQVfJwD
X-Google-Smtp-Source: AGHT+IGew5vlNZk5FPW2s1GpatdbY+osTiPSIGPrX8dOn0j9xc3+kLZV/5nX7Oxg3+dj2nWvPAXbhQ==
X-Received: by 2002:a05:6a00:3cc2:b0:705:a7f8:5b8f with SMTP id d2e1a72fcca58-70629cefbecmr8797723b3a.31.1718943147458;
        Thu, 20 Jun 2024 21:12:27 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065124dee3sm433300b3a.134.2024.06.20.21.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 21:12:27 -0700 (PDT)
Message-ID: <9823e90e-6589-4bd8-a852-373c26904b35@gmail.com>
Date: Fri, 21 Jun 2024 13:12:23 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH lkmm 2/2] tools/memory-model: simple.txt: Fix stale reference
 to recipes-pairs.txt
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

There has never been recipes-paris.txt at least since v5.11.
Fix the typo.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
It might well be a name existed in LKMM's dev phase, but I'm not sure.

 tools/memory-model/Documentation/simple.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/simple.txt b/tools/memory-model/Documentation/simple.txt
index 4c789ec8334f..21f06c1d1b70 100644
--- a/tools/memory-model/Documentation/simple.txt
+++ b/tools/memory-model/Documentation/simple.txt
@@ -266,5 +266,5 @@ More complex use cases
 ======================
 
 If the alternatives above do not do what you need, please look at the
-recipes-pairs.txt file to peel off the next layer of the memory-ordering
+recipes.txt file to peel off the next layer of the memory-ordering
 onion.
-- 
2.34.1



