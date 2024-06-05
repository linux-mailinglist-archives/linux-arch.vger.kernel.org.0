Return-Path: <linux-arch+bounces-4700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435568FC176
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 03:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC22E2841F5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 01:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A095577E;
	Wed,  5 Jun 2024 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtVd8Tce"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955E5812F;
	Wed,  5 Jun 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552654; cv=none; b=HRGoQyyx7VSFHGLcalMlX6qqNVoGjhl3dGSPSIvdbzXnfAwWEuWi/Poal6XhUQyLxeh1jXcrw3fPBdipvaBBAJ80IiVm5VXNe7QLzoUBp9yb+yurav8R4AIj6+KbEDnAQcJGjQGDyYaXyjfxuXBAN3lq5VNU6Kafc1DXQUL5Rkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552654; c=relaxed/simple;
	bh=QzovVf4qci3kvW1vMQctM+uKUriJAOx+Xy4xQsQUqnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvB1/Gwd8GPBV+peQzfQ3mrGXNWGs3VRigH914KHoBIU+UGfZtRcI0nN/xhy4h4g6PyI2RgH3pCuo9Govyo4GzQz5qLWhc8Yl9e1TA9vFbM3BnoNx0o+2bRWblkmmb4/U9LuvKt13BgeIundVgcJbWKyCmYp5pZVIyvJVs486V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtVd8Tce; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f68834bfdfso14161895ad.3;
        Tue, 04 Jun 2024 18:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717552652; x=1718157452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRQ2L84kKv0/0p53jg/iCgVwJYBRNYpHVrPukVuThKs=;
        b=UtVd8TceTxHx9nzKQGOvgPN6P3uRQZMN8vd1s9oxfP/k465XBSPLKfzHTeb2BoAJOu
         VoE8oTxiTVEV2vESZXRiv1d/iGWPrHDIqVktBSwfDA7Ee0RpB5SwhXFoshHV57PK0ChE
         2usdg/ZNrHDUDVTpIXhCnzwJDpereYd3IyLY9weijXoac5iGWkutGSxNGLmiqjaGMCjK
         uOxFzwYUA2ZBcsziuOFyCJopVgwReRkcCAoM5S+tpIxTcDgVhuAeiGsVXtv6KEPKK74I
         iJROAfwLO9/jiNU3fApWjID5OkfW7lXfGaACeTymjNc74W6tAhxGeoMiZfOpq7WWwvGk
         Ya9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717552652; x=1718157452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRQ2L84kKv0/0p53jg/iCgVwJYBRNYpHVrPukVuThKs=;
        b=dyFeqFGbsj7XLMlKLyGyRXsOikPCoXr1o2pIBq8uTRW8D+AoteKTcUxNDgGG3ABUmA
         AWWt31Ac5hZvjI4UUUP/WoKxtZdorYAqO3uFVgWxbV51N+Xxau751/HRpSGDeVhIfTFm
         2r31SF+JWrTcOUcvrl9dcyPRDokR/dQq6o+wt1xQAghSLDSipjsPOeVZlJcHTGC5f73y
         k10p7NfSwwD16F73QVlZLSLjTS0Go8mj6cLijsldSjobwrRyqJW9RUbueb0G900CgaRA
         qr0RQMYN9laenQnvHXQOYaUz1oq2m6be+ye33tSmfOOyxAqJBIVqfnQGsU986TP56UjT
         iYFw==
X-Forwarded-Encrypted: i=1; AJvYcCUw4uwc8Z4V+EyWZ6kXRuNAwwecGixLBClZ4w9VEj02ylfVPzKkojn7sdEA3Gjucxplj2uLB5r2w5LlHWol7Nsw66v39rwzl0z+WQdBhDulmqy3eKO2npEdDSNhxRVZ8c7Y2ny1wYhUAw==
X-Gm-Message-State: AOJu0YxCFzQan+kBOxZXqKcqknH2U9dV6NUbxqsoXgNYp1TQkYQQHvm0
	/rpyeYoOhOl75XnRSPqyf+mHLds12HxX6WsTvLnvPKMAJLGIfFZ+
X-Google-Smtp-Source: AGHT+IGhY8NWxmXyY5cm9IbPZfn9UpfnpG1B1H5+o1ZxPw3zhwQGAkJsS7G9NEocR/bhIoUpYKzKjA==
X-Received: by 2002:a17:902:d508:b0:1f4:8a64:707e with SMTP id d9443c01a7336-1f6a5a041f6mr15710965ad.14.1717552651897;
        Tue, 04 Jun 2024 18:57:31 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241c39dsm89848075ad.297.2024.06.04.18.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 18:57:31 -0700 (PDT)
Message-ID: <42fa4660-b3bf-4d09-bbad-064f9d4cc727@gmail.com>
Date: Wed, 5 Jun 2024 10:57:27 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH memory-model 3/3] tools/memory-model: Add KCSAN LF
 mentorship session citation
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Marco Elver <elver@google.com>, Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>, Akira Yokosawa <akiyks@gmail.com>
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-3-paulmck@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20240604221419.2370127-3-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 15:14:19 -0700, Paul E. McKenney wrote:
> Add a citation to Marco's LF mentorship session presentation entitled
> "The Kernel Concurrency Sanitizer"
> 
> [ paulmck: Apply Marco Elver feedback. ]
> 
> Reported-by: Marco Elver <elver@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: Akira Yokosawa <akiyks@gmail.com>

Paul,

While reviewing this, I noticed that
tools/memory-model/Documentation/README has no mention of
access-marking.txt.

It has no mention of glossary.txt or locking.txt, either.

I'm not sure where are the right places in README for them.
Can you update it in a follow-up change?

Anyway, for this change,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: <linux-arch@vger.kernel.org>
> ---


