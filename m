Return-Path: <linux-arch+bounces-4532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9938CE867
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 18:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B911C210B7
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6912C7FA;
	Fri, 24 May 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZwHdI6f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3F12D75D;
	Fri, 24 May 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566450; cv=none; b=BXryNhHRgJZLSN4pJvrQ6j0GOXuH7Vaov5OQj7x57sd05tjLBSkjUXXcZix6j+5o7YuvRiIQ2/gx8B+1lQPWE3Vj2o/SimHwlQAcNze8KO2BgbqxX43C/25DPuGeQopYWRvxlAk9TjPo1LL9F4653VR3/eSmTAP7JKR4YdQ97BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566450; c=relaxed/simple;
	bh=FnAaiCmQC7YRKlzCDKAI0OXamAuUxY3zUlnua8fn3oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibLECZA1SQbMO/y9D+8fnoYwFEk4lUAyzNdLsm8bv4YyxYhL2qEN6JhDWBJrDhh6OYUF3v5c+WjehNe2NAjI1/ABNvVL3bQPYrsnrSBON2yRBs+L6lOnZSu6Zvm6fymnF3nkxkRzDru7NE4JIszNs9d0sV8aLcqbGjuZorgi6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZwHdI6f; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4210c9d1df6so2340765e9.2;
        Fri, 24 May 2024 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716566447; x=1717171247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeGxIN2NLzfkcvB5SwbOf6TisZFQzjCd2Zm13eyZV2Y=;
        b=aZwHdI6fHD6FVqiwULtAjRG8q/+Xwgce+MLh0saIIQZuaze81i7+ndbL38ugVY7xKh
         FFR2YI+HauS/y9O512e6JtMLlic8Y67G1lMF1FQVuWn7o0CeonrXerxH30hLs7CBh5Yf
         tSoEUarxJIAc6Rs6l56FYf+P4pVDiaTmbli2mUaXN0Jx9rPUT2EXjwIry2/NHNDiHb+k
         FxjGAw9WniZae8mg6/usDCs5pu2JV0Vaa58qqLSSdZt2mKr4/44IIOoASwyPcickK2Zh
         Gj06JSfqAYLv2Uqjw0acPskIKOMOlIG5SF2l/bdzUFzr//TVT2jQKrkVq1P+3bZJqpy6
         9EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716566447; x=1717171247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeGxIN2NLzfkcvB5SwbOf6TisZFQzjCd2Zm13eyZV2Y=;
        b=XQRR6vhpRiuHM7nBvs/3Ital/4GObdH9hGucyOrGvnMBB45Xhz2hRW9a/kIrutTMDt
         Aj2UIaxEibCqQeSuL5War6QTzZC7IE0AWjpc7LAM3BWUW8E/iq+YMsFASWNOjMap0Mhz
         agqVt8lfPywReH96bkHSFl+yOqWVUl+r2e4ScPT11+7DGj7wo0qniQeKOmIZgS5+igwU
         mH8USq/+UhDP8qvkqmrBe9HARD+Dd6PNKdP9xsw4WZy8Z9R/G2hnHhYMzHhIirC8WKBB
         +8ZrPzRqxgV2bvbQUlxSy9HmcGITmm8lmAIO0IC6sumQsd4KbL/4e8pNbIUz2jeR20Cj
         5Xkw==
X-Forwarded-Encrypted: i=1; AJvYcCUHnx9LzGuzvMZoYcXohJ1wCu5lJbCHYHYHjWt24+ZhzQF4WIxTeBucheYgW6kqyFmTy7dViGhRj70fg44Y1RloKI14Xr3AMoprGDuCsGzDWx2cLgZw1OvaS3GS/UYIybrh6DSDVgI4Mg==
X-Gm-Message-State: AOJu0YyokkXCc4Nngge+1MPv8agTQkCtBw4EKUH57nHddhMMhfcQBezZ
	3xP93tSJaq0RlPetA0oVn96oLS4J6KZkza+8wyX3MHd4JE2hoCF9
X-Google-Smtp-Source: AGHT+IF1nzlmWcJjKLmWsVsX2Q/bz3pbEstFXA5fX3vj4NYfHb6SpOA1kbfUC2hwKB/oVXMdf4RHSw==
X-Received: by 2002:a05:600c:581a:b0:41f:f957:96ac with SMTP id 5b1f17b1804b1-421089d9dc3mr22424605e9.13.1716566447029;
        Fri, 24 May 2024 09:00:47 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089667fbsm24207395e9.9.2024.05.24.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:00:45 -0700 (PDT)
Date: Fri, 24 May 2024 18:00:43 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <ZlC5q7bcdCAe7xPp@andrea>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1c6d4146-86f8-4fd5-a23e-a95ba2464c9e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c6d4146-86f8-4fd5-a23e-a95ba2464c9e@rowland.harvard.edu>

> What's the difference between R and R*, or between W and W*?

AFAIU, herd7 uses such notation, "*", to denote a load or a store which
is also in RMW.

  Andrea

