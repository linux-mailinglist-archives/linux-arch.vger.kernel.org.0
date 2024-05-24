Return-Path: <linux-arch+bounces-4528-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 941D58CE82C
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4775D1F21570
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2937D12C7FA;
	Fri, 24 May 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlRgEh1/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3513CF6A;
	Fri, 24 May 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565035; cv=none; b=Cn/xt3KSt5QCprgEzHhI3ZYDujxg2gwiAGEic7+Dq5iLy1Nr8wzjmXnlTyCRulS577YOBvYRPbylXMmihRVEW4Zmzxf4TqD8pIUctTz1Egm51Pv0zdtvKPDI+ka3XsRXItHuYJB7OcqYk3znk8exJ2c9vlzCPc97ylKgozXZEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565035; c=relaxed/simple;
	bh=te8WqY13pplD0Ep81lKFRvtAPJGL9XVbqVS3zopt1lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZYIVxNuzoOuClhdyTeEy7HpDCeNeD1/0adHZZuHIDBwX5m1G3jzyJT1THDXRQdCLn5Ojc4JlV5/rdgVmWhKS29FsLR/DSUBL5ucH9W57X8Na/u0NYITejopzFoGuMF9zOScUVNLS+GgzHWA85iNQJMr8IfXOZYWg2jZd+2wAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlRgEh1/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95abc7259so9989981fa.3;
        Fri, 24 May 2024 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716565031; x=1717169831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=am47x4MU+bqzzZBwTp7sclMKdw8mhe7B3fecU5xve+I=;
        b=MlRgEh1/nXcqX//VRR2zykV5M4orD85SYYEQJdNtgh/DgawWKI43N4dJ9VtdDqPLRO
         d8DhhqyDTsWNJl0jaAt3lydD8FqV4WkYYqqvY3HWxdI+EOTfpZGYCpDYC9azjiUz3yXN
         W76QhKRyIl2iOr7CxUlleni4ASQ5WfbgSwMnI4Jl9xAAqxzHpFzB9u0feKi/eQdrO2rT
         PBDK0VmTtdhxK5+4k3tSHyNwwLd1V1AQXGx+Lu8fOsytUBT4Ur/FS89cHwxDrQOkHFzR
         +7/byce9GWlkvNfFlbNLzgEjJvsspKhxgRGIRmWYQQbZ/+ExmKhnzSCB/QMu5dNbYuQu
         +A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716565031; x=1717169831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am47x4MU+bqzzZBwTp7sclMKdw8mhe7B3fecU5xve+I=;
        b=SBvUoPyY1nCBNEnezl30K6USvVBHvZSnLwHYjy+bZPxKvlGDhQtL8FAHuWrMa6aPbA
         Y4UOduWXQCCXRDBZYVE7dxwUKMJ2B7Hneeo8xOW/UUzCAUY3eXMXS2LPX8PtHC8mhpMm
         VgSi1i9fdDX1puezFOVLv776Hnz+elZwHIk3WsBvnqhj8aBOwjdhbcxS8WJzBTodyt6j
         6iW2ViZPHd9HDgJ5TfJHRoP/FaPMBCq4Lh1IK7oNG1DcCNmjTZNIO81/trQOlJY59mm0
         zWDOuaqvahbFAFJp2GqvigSTut2FEXEsAlNohJJ3OR05AXX/iqfswGVlB408DLwLso86
         YjzA==
X-Forwarded-Encrypted: i=1; AJvYcCV1XkR89SWlGPiihm2KdhJ7XWYfpZRXWi8zdtBAIxK11SLZ530FSqhrqQ+G3vctRiBXra8f4Ki3sllorEaELls8YxGm+lWkHSZy3Q==
X-Gm-Message-State: AOJu0Yz5xfrE/gWcL6JunY7YX06k1CQ2dspeuHFgj5fKN+6d0th11zuF
	6uPAruIxIyyImvkKJQP8aneKsjRtPFqGNIr5TpVo3ZU/Wy3HHc/9
X-Google-Smtp-Source: AGHT+IGAqI6jZgCzvEvNQYBkfiZdxZ8mYH7eGI+wwekB7Bqq12LNvgN1r/sFXCq4NFEJkf1t3dwt6w==
X-Received: by 2002:a05:651c:8a:b0:2e0:aeba:ba90 with SMTP id 38308e7fff4ca-2e95b2ca9damr14804241fa.46.1716565031337;
        Fri, 24 May 2024 08:37:11 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210897bc02sm23724085e9.22.2024.05.24.08.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:37:10 -0700 (PDT)
Date: Fri, 24 May 2024 17:37:06 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <ZlC0IkzpQdeGj+a3@andrea>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524151356.236071-1-parri.andrea@gmail.com>

> - While checking the information below using herd7, I've observed some
>   "strange" behavior with spin_is_locked() (perhaps, unsurprisingly...);
>   IAC, that's also excluded from this table/submission.

For completeness, the behavior in question:

$ cat T.litmus 
C T

{}

P0(spinlock_t *x)
{
	int r0;

	spin_lock(x);
	spin_unlock(x);
	r0 = spin_is_locked(x);
}

$ herd7 -conf linux-kernel.cfg T.litmus
Test T Required
States 0
Ok
Witnesses
Positive: 0 Negative: 0
Condition forall (true)
Observation T Never 0 0
Time T 0.00
Hash=6fa204e139ddddf2cb6fa963bad117c0

Haven't been using spin_is_locked for a while...  perhaps I'm doing
something wrong?  (IAC, will have a closer look next week...)

  Andrea

