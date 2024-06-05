Return-Path: <linux-arch+bounces-4697-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A38FC0C5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 02:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C01F22B10
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 00:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA9446B5;
	Wed,  5 Jun 2024 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5/r5YYn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13587322E;
	Wed,  5 Jun 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547238; cv=none; b=md1vNfncCIwB5WPWu8cvbVQ01+bT2m6xuzrb0Rz7ki9gNG8KdrlB6OrJNuicqyb9rruCcFJ78kE0fiD3JJTb0tgR5KTxc6yqXTGgpeA/H6OKNJAS9V2AxILO8k2Eks1tKoGp+666uuKv91VJSNQzdHwEd+7bElHePSlkMikGsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547238; c=relaxed/simple;
	bh=HENd5fiJMx/MtTkFeqvrO/93dIE7gf62GjvWxTdsVJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7t3qjgPAF70XosZSk98ApGD+rTgU+vhIt+aE7rm9yu7fwtVVOWrUup3pErZ/Yz5q29zLWXd27SnQEGlOZ1qOkFWwLmDriF0ABt0nbjWSP6nWnb7KNRvoNx9ex5RBwcl9muaSEHuxUhkMxn7Rp1RFN/ouyhbfPCQW9vxSKBnA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5/r5YYn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f47f07acd3so14749475ad.0;
        Tue, 04 Jun 2024 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717547236; x=1718152036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBtLwt7lgRUR7ONP1Rg5DOx1RKZzwOytsyB0wwugp00=;
        b=L5/r5YYn7B10+ipxhrn5qPZr7DrCGY8hUMhfKhB0FsfTM5CqEhejlhk0S2NBhIan1P
         U8r8MbKW/SUUp8G7xM6jSaesXP6xZ4Ko0XChiuBVzRdv+wFZGSI4ojzYV7UQsSZhaJmC
         Mr6YFA/itamlmSPQCfQ/5C8BABQsi7Be0xxyPwzeAa2/jRIs7Z0lLQAkvGOuBHEnuRFI
         JsRECLrPnpFaYJGdDSzv+ha7sKX6ht+zKcjDEPRLxBCPH4j5tdUVk3MEOFYwXVNzrm1B
         2oVP4OolKKNtpzGE8qZhBlQLExmihdWgwXNAdL07f6nIYyydsef6d0CY3yruNwkfKEzd
         ujAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547236; x=1718152036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBtLwt7lgRUR7ONP1Rg5DOx1RKZzwOytsyB0wwugp00=;
        b=FI6opS7yxQ8ZxdTxjki/L/nQcwY0ra3wBwLkKsby6+eFRXcR6WsTlgTNkVJcoMsnvB
         GYtPpXXWlOKvlxHU0eJ1AwftCGJE/gKsV3jU+IfWiBFrz9+rOw6dTYB74RNlwIB6dwwQ
         V0c3K0Je8v7M9fNtGCwB8IJt+jgzzI4zQPRWuiDsXw6yC92ZI0SsVY6JHBlo+ryIxyLl
         Crm88M2ksUBB8LWcNi/A9cqRMSxuO4yqjYoZoKLOS6Ic9k4FXL9DjjyNWEGszaI+H+lS
         SzecQWZOF9UfTeJBj2c5l4bv2vjEOZYc3LxX8mAdKtXnx3uCqox4uhcTR26uN1RPf5CL
         m8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+xOMJHwfa3E/lKPAjTIOKXjvzBjXdv/uuuj9eCyq587NJceSDRi62O4SA9dUApn64UI5/7Hj0aY2xf5QQF64iU8IwjR9Dt7J0oE2UvmX00cQgMUT7XD/a66OKq579NjE0hTKvrdBVcQ==
X-Gm-Message-State: AOJu0YxOmQ0rFoJvuvmCdcWOJIhU3vIK3atH7ZKVlqOH+UOzjrcfc+tg
	pd+Ov/mmXy8D8FzSB1uP8T0saW0hHx6pU475FytNjZimqMsV6ae3
X-Google-Smtp-Source: AGHT+IG3yTkEitTTZ/PYudLCodSY9uzbOKHKEgaLZr2DEhrrtH8kk4WwnVaYGKe7HWzg89nA+jpR/Q==
X-Received: by 2002:a17:903:41ce:b0:1f6:7c7a:a7a0 with SMTP id d9443c01a7336-1f6a5a9b0edmr11262675ad.59.1717547236099;
        Tue, 04 Jun 2024 17:27:16 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323e9ae4sm89421725ad.191.2024.06.04.17.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 17:27:15 -0700 (PDT)
Message-ID: <99545c09-4a14-4f8d-9d3b-c687fc318714@gmail.com>
Date: Wed, 5 Jun 2024 09:27:12 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH memory-model 1/3] tools/memory-model: Add
 atomic_and()/or()/xor() and add_negative
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Puranjay Mohan <puranjay@kernel.org>, Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>, Akira Yokosawa <akiyks@gmail.com>
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-1-paulmck@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20240604221419.2370127-1-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Tue,  4 Jun 2024 15:14:17 -0700, Paul E. McKenney wrote:
> From: Puranjay Mohan <puranjay@kernel.org>
> 
> Pull-849[1] added the support of '&', '|', and '^' to the herd7 tool's
> atomics operations.
> 
> Use these in linux-kernel.def to implement atomic_and()/or()/xor() with
> all their ordering variants.
> 
> atomic_add_negative() is already available so add its acquire, release,
> and relaxed ordering variants.
> 
> [1] https://github.com/herd/herdtools7/pull/849
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Andrea Parri <parri.andrea@gmail.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: Akira Yokosawa <akiyks@gmail.com>

Pull-849 and Pull-855 at herdtools7 happened after the release of 7.57.
So I thought patches 1/3 and 2/3 needed to wait a next release of
herdtools7.

But these changes don't affect existing litmus tests.
So I don't oppose them to be merged into 6.11.

It's up to Paul!

        Thanks, Akira

> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: <linux-arch@vger.kernel.org>


