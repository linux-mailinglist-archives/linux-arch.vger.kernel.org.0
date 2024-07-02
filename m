Return-Path: <linux-arch+bounces-5217-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9AE923CB0
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 13:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6B6B24707
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E04615B551;
	Tue,  2 Jul 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOduV29B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D715B57B;
	Tue,  2 Jul 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920572; cv=none; b=nAmfbq3B6Q6QiTpRGOi8RsZt28+Ya8AwRK5ygOcIxGYtnmpI4N70Qh3UFko13PEo0gRuzDJrrb8kad0Sm6o5p60EyYjFs0j3+1jdTrlRZlF35mg4fhzaypVy4Z073hwj5RMuOEDIoQWZtoNaXAGLG3yaKorCZ4Scj6pOhoAW+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920572; c=relaxed/simple;
	bh=F3c82IvqkobVQ+cEL944LWTOKeY//8FJeGn9VOXvKeY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZQSgaUxVDt9KuMB6BRQlXheXoz8Hw5V+0bx9+to6w6JS8iNWIcDGPHbro9HrhY0gLUdrWYhUcrJPR5yFtpkMDLNIaj10ecdu65XPKgXgSfsFZJCPaslfy3SdX/tkTfheiNWCjtP4PhlHBC3ibTy+1thGzWTFr1qo23tis1SV9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOduV29B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a5344ec7so29138915ad.1;
        Tue, 02 Jul 2024 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719920570; x=1720525370; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5O9QJHV6HJ3iFkZ9r/sweFUWbG/UePP1lmvYv1+YTU=;
        b=WOduV29B8coD7YGCZbzPEKNZN6eaycPUZl3qizhCY0c45ZBZ0RNf8DT+4JSKeXk9+6
         u3PQ5dw+rDWG8RZJAtt9mhe7kRaV+83jyQgs2dBHmYhVG8l+3x/LllniZhAKhFJv/f6X
         JtABgLysw8dnUwQVB6WUYKVNUUfdab5fFen+zzrMngzAaNMob2ItRj650iURHblcNSUm
         SL/GbCtRWYAVPJ/zs/WOrsI6gpHAZvGm1lz7mObS7/R5vo6DMzh1Eo/uS51YSOxmelwr
         9GxJiQFLZxRIcTUmkZGSNw9JSW9pu3Xzl9XZOv+dEbH3PiuHWCb5yfR/TvjuaPpZhp1P
         Ldvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719920570; x=1720525370;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+5O9QJHV6HJ3iFkZ9r/sweFUWbG/UePP1lmvYv1+YTU=;
        b=YTa/c+amPvY0RD1ib+HK2UUru3+DM124uqMoDzB4E8jbtHmEKYjf/onGBJAGrNDddq
         ewkxa6DIZL2SKbu69PM0sBrYPCyfs/cHMVOkaM1KqpKgIrRumTJ39gfnjcoI2jTge2pt
         asLVG7G6iWfZy4Dy29AgJsUTEP9cJ/whc4p5V1kA0emqKYNNUVuKHzCpFQEfpH2ECOxU
         DayfYhk2y12Vub4L9zZEY+rQxB9ITG04ZDLBdWQb5qBbYr27vJPGe/wb74Ju9Ij9vG70
         JlcN956rCgwHlMbC/U1KXRhhNi9PIoW4a7IZN7jcklTXtpQuBBv1DaAq2DEmU9rxVPzR
         7s6A==
X-Forwarded-Encrypted: i=1; AJvYcCWaISpZevUzj+GRgfcBV545AMOwA32AKifFnLiSytqhfoIKV8kUJDWXg9vMtRNgLs3fyrNVq8lOciUkLPAsUEI+0FVNgiqE2LiPIm1vZI/UuS9A247sBtUmyBlAVomEovlF0CM9iJsclw==
X-Gm-Message-State: AOJu0YzUd/W67t1gM6hcWeVmo+Rp1d//VL3tLTzJY/WJAjO0jIu91wo/
	xcK0Pimxi8aKxDy09pqCyf7icRaegkFhUmtSQdHAOK3aCGsrF1RR
X-Google-Smtp-Source: AGHT+IHbd96Fl/zaLJfz/U+3GNERR5Bvjwmw+1PyosVep26jKEoIa97jasJAI8d0Oe3YSe7eMNjctA==
X-Received: by 2002:a17:903:188:b0:1fa:9ea1:bc7a with SMTP id d9443c01a7336-1fadb4d9067mr110159615ad.34.1719920570111;
        Tue, 02 Jul 2024 04:42:50 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8cbbsm81914625ad.106.2024.07.02.04.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 04:42:49 -0700 (PDT)
Message-ID: <5866a20e-4b36-4eb9-b589-8135f86ceb6a@gmail.com>
Date: Tue, 2 Jul 2024 20:42:44 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
From: Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH lkmm] docs/memory-barriers.txt: Remove left-over references to
 "CACHE COHERENCY"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 8ca924aeb4f2 ("Documentation/barriers: Remove references to
[smp_]read_barrier_depends()") removed the entire section of "CACHE
COHERENCY", without getting rid of its traces.

Remove them.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Will Deacon <will@kernel.org>
---
 Documentation/memory-barriers.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 4202174a6262..93d58d9a428b 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -88,7 +88,6 @@ CONTENTS
 
  (*) The effects of the cpu cache.
 
-     - Cache coherency.
      - Cache coherency vs DMA.
      - Cache coherency vs MMIO.
 
@@ -677,8 +676,6 @@ include/linux/rcupdate.h.  This permits the current target of an RCU'd
 pointer to be replaced with a new modified target, without the replacement
 target appearing to be incompletely initialised.
 
-See also the subsection on "Cache Coherency" for a more thorough example.
-
 
 CONTROL DEPENDENCIES
 --------------------

base-commit: 7579cedf8efed9a05b2537f4c276571e4753a907
-- 
2.34.1


