Return-Path: <linux-arch+bounces-10351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EA2A4341F
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 05:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F45A189D5B2
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 04:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D019AD86;
	Tue, 25 Feb 2025 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT0pFtlj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CD189F57;
	Tue, 25 Feb 2025 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457697; cv=none; b=sfOYH7xSuByATQzuwg6h7Oe0GkUf6Rl/JOWrozprWoEKXE5OOWgfSgACGsteSmnnpPPIJ+B00w9LaIHMXT2CJdXNwxb7FefBWZu+9thfCLUkeKNVVT+ziA7lqxc8C0b6cugPb8d9yYGx7GKGH/GPN8K8w16XfGDxNdrRsvAZmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457697; c=relaxed/simple;
	bh=WTxSpawuERK/ZBZBLzdcu4rQ44kJS8Ior+f3QaFbD4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIsSp8j9P5F6CKprZf+NCAPNa0W8b6CETdwO9Wt6Ggaub0+lsFaNzpYAUJMgydmLl8TTFPeKXhaOkb6ygqOQ8pPvPJgRFwc/J860oXAfErO8/MTsIAP7hLEIDI+69xxhF1OIaQQzJLAb5rBKafkrZT+0Y0v9pQ5kG25BaUPFkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT0pFtlj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22101839807so1867915ad.3;
        Mon, 24 Feb 2025 20:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740457696; x=1741062496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DwzRod25NBc/IUFnmtj6zNS9Dw9ri8JzR7lTV9LJ3w=;
        b=LT0pFtljzcgPd9RNr3f5J8os3VwPqM4z8pL9+7OrnnWO+cMgH/IJFNBxqCBJLBRyuA
         USJSmqo+pwt4mjPVQ+rGw0uppwhNWxSOIzoKlC1tNa+4F1gAHorWSwZ6h8RcEpfXJLz+
         zmv89rv+mwLVmZUZblquSvHfbcCZbONDeis2nTcsDTliGfFAvwA/h6BNqFrwimDTVBnG
         6U8mmwvYjqGN1MwqHrc3o2Ptvan+HWTsdeTV+3Q5jk2aCKyTI7sMIxndFr9WfcC0Zh8N
         QaWWoW55wHgqcmN+TC8L1ug9D5rYDtykzQ+HuceQK8P2qbOxEutGJOQkA1l5wWxmD+mZ
         c6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740457696; x=1741062496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DwzRod25NBc/IUFnmtj6zNS9Dw9ri8JzR7lTV9LJ3w=;
        b=ld4Bh0pS54/vyRBEBn1JO1ML7vXM0j9C+5zYeCXU9/2cGRH+ZayzGc5bOYEqhBGH9e
         OltoFY38U9d9CTz4VUKE3is1Y9r+tcWo8HAK96kH9FG0EiJnN+68+51kMJOlOe4gnObg
         rwydrByZ7QyZvQHtQQRk2A0vUECbfcPpmrWABVEzo/gCVDdxa23THi5Pbl8OBBURTLg/
         VDTJVL5y8CR7wIm2GfO3jE6THJmQFk3DMKqGwtJLuv1g9OngYRwOKzhDwb3kS43vMXdi
         vAZ981QparE2/++/6PNSa74ZT3pEWWbpYmyBzq3pI2hbPmj3hNEGAhWJNsQ10N2LLqc4
         Ek9A==
X-Forwarded-Encrypted: i=1; AJvYcCWdVmlZgghvTHyodF4mYuEXinmeGFCCwY79W/2ENtRRdArXWjk9b8zhnsVLvAEPOA+L+AABT8cEn/qQi7vN@vger.kernel.org, AJvYcCWwmcqoSdHv1TeRLxRzqp2aNxnoJ49sSuCNoagFegEnbmq3i9OHFDSJCzXNdMDph2hu4i6HqlNDMHZq@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNIA0g1fPb5k6RAKn/EhPSY9BHvKviS7bRR3j6oU5Sdxbb0fn
	kO/7n2VY+qslvto6ruE3gmYrrvydVEf4JqzTcea6JHMc1Vohs5WD
X-Gm-Gg: ASbGncsgfmjR7Z8yWxbAPRRsXtfJ40qd6+EkVnnSlduSQS89g25BkuadjKCcE5c6FzD
	W1ccFD7ayDxHPnJdHLEHu4VgoLXkkwOTLd33+3vn7q9q4kfB5GNafM9CfGepw43ooFLT9pTs+lj
	evUOuQXI+BlmDig/xL6jlI/nORZPZWn8H7SM83IP92Hz4VIBe02FZ0YUfwIdsb8UH9FRIWtAl+k
	oEpKwkl+jXP+9J3lzAll62/QuliKejdi323ZHOv5fPpZJ4w3wJh5LHmGkr46r9ldrK2KsQRrTc6
	q2vawH32R/3bbt6+UToT8yOZj+pKubv5ZEhsSm7t4am/tsGWd0lNi0WyGyI2ZfvAM1TnYTjS
X-Google-Smtp-Source: AGHT+IG1fPJ5D8vBakIA4rQzjp6ci4WMzPWgrPPMcgkL0SJnknv5G1QU8PC/Wd/vT1m9BvjnKBlxCA==
X-Received: by 2002:a05:6a00:1390:b0:732:5651:e897 with SMTP id d2e1a72fcca58-73426ce80bbmr23106330b3a.11.1740457695745;
        Mon, 24 Feb 2025 20:28:15 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a518a10sm500364b3a.0.2025.02.24.20.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 20:28:14 -0800 (PST)
Message-ID: <ec893c4e-b4eb-4279-be66-1ca7e6bce7b1@gmail.com>
Date: Tue, 25 Feb 2025 13:28:08 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH memory-model 7/7] tools/memory-model: Distinguish between
 syntactic and semantic tags
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev, kernel-team@meta.com,
 mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Akira Yokosawa <akiyks@gmail.com>
References: <8cfb51e3-9726-4285-b8ca-0d0abcacb07e@paulmck-laptop>
 <20250220161403.800831-7-paulmck@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250220161403.800831-7-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 08:14:03 -0800, Paul E. McKenney wrote:
> From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> 
> Not all annotated accesses provide the semantics their syntactic tags
> would imply. For example, an 'acquire tag on a write does not imply that
> the write is finally in the Acquire set and provides acquire ordering.
> 
> To distinguish in those cases between the syntactic tags and actual
> sets, we capitalize the former, so 'ACQUIRE tags may be present on both
> reads and writes, but only reads will appear in the Acquire set.
> 
> For tags where the two concepts are the same we do not use specific
> capitalization to make this distinction.
> 
> Reported-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Tested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Tested-by: Akira Yokosawa <akiyks@gmail.com> # herdtools7.7.58

> ---
>  .../Documentation/herd-representation.txt     |  44 ++--
>  tools/memory-model/linux-kernel.bell          |  22 +-
>  tools/memory-model/linux-kernel.def           | 198 +++++++++---------
>  3 files changed, 132 insertions(+), 132 deletions(-)


