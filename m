Return-Path: <linux-arch+bounces-5324-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AC992C6CC
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 01:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59E1284373
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jul 2024 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C641F189F46;
	Tue,  9 Jul 2024 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7YPbSV7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5AF189F24;
	Tue,  9 Jul 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569098; cv=none; b=XlUhooVMUk1sgelkjIS8XxheoEsTLUtzzQXz8vd8oHEivDoUoUe3xlUbZZx0bXAsxz3q8EpgWKcXPwCi6FsQR5N9vvlatExocD4bnlylJPITk6sVgnNSyf4PcjiWW3eAvJzK0yU8JWDsY62F3jaicBevJK9WWuxiX1M5mC0YxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569098; c=relaxed/simple;
	bh=3wzr2a0XimtxVC1KBQ1Ni94wnk3cR05AnPNN2T/ZKn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwRHULk5d1rct5QBRRGDRpbpr3cPPJsJzkq1rSX3kmuVJj6fYOgTYBOc33NElAGT2BQS0qM6TU/neXaTIgrqy5HM3Lud7U3AWADn5bz7W/9MkXKyDrqos5uA1iQ7PPbqRLBReB2gSB6cXNGi9gjwW9Qj5mAAGOcLeD2QE1ugFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7YPbSV7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso7149337a12.2;
        Tue, 09 Jul 2024 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720569095; x=1721173895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nB80/jNPAo2TOKBslokBr5EVRDZovXrVO3U4Gd3724I=;
        b=G7YPbSV7j+q7cm9sEHumGk1Ao09i6ud4c+UfN4XCrbysTR2lEDRR7KDjVsrDIHvVm1
         ysfc02b2mMxbldvRDBiE54OKN0jZIAY7ymbueAyr2kBFXRQ1PpOe3hFCdWc25mXJ4Fhn
         xTh/fye37bYrFV3nr8NQLzFOua1/i9KSzBaCW3e7tgb3vQzPbea0TbUNz9Dh/cnCtpRm
         THKNCgQ3vIsdS3JZqDlpDs6XM+DKcNn8qfoOMOm6oSg4wk2rbQsb3aku/p3ILOgQu2e2
         jTIYnFmAC9N063SZT/3IPdQU/KiWKh3/OXHjDb4V8IdlA142YrFuKq67XljnC87b/Hnr
         EnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720569095; x=1721173895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB80/jNPAo2TOKBslokBr5EVRDZovXrVO3U4Gd3724I=;
        b=Z6GTkR5FJJQ5Au4tBkf++ftMleU+nq/MOgrZQRBmMTWSMEv6mK4a9Qw1j+LlaPhHIm
         N4EpqY4sOwoUx+7PLE8RJ7ZVMVzgEEXqOdScR4HShOM2HBVubNbY5Ag4FvrAQCfLjId3
         oTZxaMIBaQqlaId57RQViFJS7i8VCq3+shWTPM7rcUgPo+U6h0zyyiYPqrMjMD8OHxu6
         Mu6WBgxrKovRIOUzwjR3uAacxm8jUt1QJAU/O6CT2W0JlvT8A3gzwRC6Kim5LHSKYKj4
         3wXTRb7wJDTmiSOluCUUBfVq0JQ5wMijG6TEMF5zwhIQoRboVRgg0hwIr8T7BS//NFtc
         UJUA==
X-Forwarded-Encrypted: i=1; AJvYcCVQOMUcEfYIYWhJzmTeqVtFyX7lEU8k5lyOJ+cdO4jLom5vGC+RkymoyU9kiWyhUeTeSYWO3PdWfA4nPbxuqTQgY0pivG8p98tNEjIHP22cbCLJ1bSn+1q2G7xboZ2NN0DhkSn3CKPLHnhmTTnF7RD2N3FjUFFSGE1ck3JCV0WRXRehmA==
X-Gm-Message-State: AOJu0YzxF6/u7EPArulzQ8nqf4TUTCozRHlIM2rowWDu1/g9ZQ5xg6Ok
	dn5/TDJUEmTw9hhU21uED1nfjTWFoO936DvPGouMGOXxCk1xKBAQ
X-Google-Smtp-Source: AGHT+IERo/xgDrSK200bxqmR2c3Sm004d5DwR5IVGhXm6Nz9ihnXROLaZHmA+7eaORxPCJKinnytmw==
X-Received: by 2002:a17:907:7e9c:b0:a6f:e3cf:2b8e with SMTP id a640c23a62f3a-a780b89dd3bmr375371966b.76.1720569095026;
        Tue, 09 Jul 2024 16:51:35 -0700 (PDT)
Received: from andrea ([84.242.162.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7fef9dsm115320266b.99.2024.07.09.16.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 16:51:34 -0700 (PDT)
Date: Wed, 10 Jul 2024 01:51:32 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 03/10] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <Zo3NBHUEMMec/6uD@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-4-alexghiti@rivosinc.com>
 <Zn1StcN3H0r/eHjh@andrea>
 <1cd452af-58cd-468c-9bb6-90f67711d0b0@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd452af-58cd-468c-9bb6-90f67711d0b0@ghiti.fr>

> > I admit that I found this all quite difficult to read; IIUC, this is
> > missing an IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check.
> 
> I'm not sure we need the zacas check here, since we could use a toolchain
> that supports zabha but not zacas, run this on a zabha/zacas platform and it
> would work.

One specific set-up I was concerned about is as follows:

  1) hardware implements both zabha and zacas
  2) toolchain supports both zabha and zacas
  3) CONFIG_RISCV_ISA_ZABHA=y and CONFIG_RISCV_ISA_ZACAS=n

Since CONFIG_RISCV_ISA_ZABHA=y, the first asm goto will get executed
and, since the hardware implements zacas, that will result in a nop.
Then the second asm goto will get executed and, since the hardware
implements zabha, it will result in the j zabha.  In conclusion, the
amocas instruction following the zabha: label will get executed, thus
violating (the semantics of) CONFIG_RISCV_ISA_ZACAS=n.  IIUC, the diff
I've posted previously in this thread shared a similar limitation/bug.

  Andrea

