Return-Path: <linux-arch+bounces-4642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDCD8D7967
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 02:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFA61C20922
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2024 00:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDA610F1;
	Mon,  3 Jun 2024 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNylfbfV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A632EBB;
	Mon,  3 Jun 2024 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717375305; cv=none; b=Gz0FN5BIBnEJTyk8sS7ooeiDdmhlfA69osE3AWOg6igAdFFFwLDV534Sjp88AgXZRaMkW+cNmAcZIxejk8+uaUcswGS2g4aH2edUHhBw9wyjBpz3iEfccjn9PJfB8g0N6VXI7f4x040JG2sb0QidcmhgXNkUBnGC6k1BY1m3Eu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717375305; c=relaxed/simple;
	bh=zNI6H31zSexVbT2WSd9vhwqSF1Rqr5qSWm/aHU5mw9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bePVatLnkhH9uEkFiNmAxxHdVLzUJY3+bCW9v7snNLIC7OKhNqWHQom6h1a+2sVAihMg8yBqveOEZKJBbzygSkOqPVsC4BTOWeNwFHgRXOBaNrPqRXDzmxxBUjia4O4I8alnkfKL10cqa0wHVNpUkm4WpbMc6re0KCIJaO3F7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNylfbfV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42139c66027so5409465e9.3;
        Sun, 02 Jun 2024 17:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717375302; x=1717980102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1o/b1gFrtS3NBgE2MlOGvvhrWq5km+KT0/u0XHiWDI=;
        b=CNylfbfVVuMlK2m0uiqdmFUc/d9eTkfhQA4WXMxBbdiSg+vJUc20I6Cyxfane4vPTN
         X3zXYA3BTROqoODPnoPMatf7N8OUIFrnUHkz0p4WssZl8wcbM/MVUEXzIqzTNF0wxwza
         y5LxKPc8T+/U59MZa9NAhrlccbtQz6+acarQ4wH51a6r4KU6ZIX4DH22EQMfxR2HtuPG
         1UjywgDGkZF4h/vyRpzEvVbi6SBLH8SUzkBSx87gKqixW/QMMKCI9GLlm11H8oF4AN+3
         rG/YSwWXZ2rqcxIEv3OvgCQEYbicWXHMlRGzdWEtVy5UqpIGhLwJjCOTn3ttGO9UEuoO
         ei4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717375302; x=1717980102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1o/b1gFrtS3NBgE2MlOGvvhrWq5km+KT0/u0XHiWDI=;
        b=cVsWXMO3auy56lqdb2BdGjYCi/Y38IxI/7iFJ7JqPGBU+zXOwcJLXkbfmbNpOGjk8I
         RY9Lkpiwkxj4ObBM7qxDI2SA5uOJ16a9RQjekt2gBy1xbI+rV+IaRCB0P0eOYLw/nA1f
         M4CCPl50cM+tp/GAA6aamEEHzcE8+auMmEN0mw2e29QuN+KfcLnKdyltfFiqstwVzbUk
         HKvQDhx4kWgB+SFhMyZCbC37GbSpNi9ew6GBSWmv7N7rXHSz+ZTL2Ea9cjSg6Arx8uWD
         KQ4wVI6BfkE8FI2/DEZe2geXxvrnQkGFusXC7eRvhEwXuhtmb3WFecYFgqNuqx+o7rSb
         khFw==
X-Forwarded-Encrypted: i=1; AJvYcCVyxYFz0z5ZaIljBBTCwWxhthkhymGcLBrODCFZpNp4lKZ+TiFxyJ+B30V2RzZM9YNUtP+c2HQv69GuE0HsU+b7kvocvFCf+I8N4QDRB/EYY/1PRlTtK4naMz/wu+iilos70qUEKKeDE5sYtdNWZNBz+cpE5ekF8eaGJN9gEV6AsqGfOQ==
X-Gm-Message-State: AOJu0Ywoo8SYURqKcW1NqqCWXRKGQ1PvaLk/JSfwt7cogzo30z4Tu5LO
	6GPmEXgb7HuzTUlVamcUIh2Y99Y+ZUPyIaBTltLslxpOhthltsX7
X-Google-Smtp-Source: AGHT+IEKrFrvzelrpkV0lRgOFsb/p9GOQothVXAMqoQBPMn/xGvWBpPzq+U2wvFWRQYF+WD1KvBpmQ==
X-Received: by 2002:a05:600c:8a7:b0:41b:e4dd:e320 with SMTP id 5b1f17b1804b1-4212e09b9camr55984695e9.26.1717375302255;
        Sun, 02 Jun 2024 17:41:42 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a6522d405sm470024a12.1.2024.06.02.17.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 17:41:41 -0700 (PDT)
Date: Mon, 3 Jun 2024 02:41:36 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Guo Ren <guoren@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
Message-ID: <Zl0RQC4br7KoaGlC@andrea>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com>
 <ZlZ8/Nv3QS99AgY9@andrea>
 <39a9b28c-2792-45ce-a8c6-1703cab0f2de@ghiti.fr>
 <ZlnyKclZOQdrJTtU@andrea>
 <CAJF2gTTz2H5McxgsrEcMeCNMnchS6sr3vRn53J=FWk_6HPoP6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTz2H5McxgsrEcMeCNMnchS6sr3vRn53J=FWk_6HPoP6A@mail.gmail.com>

> I looked at the riscv-unprivileged ppo section, seems RISC-V .rl ->
> .aq has RCsc annotations.
> ref:
> Explicit Synchronization
>  5. has an acquire annotation
>  6. has a release annotation
>  7. a and b both have RCsc annotations
> 
> And for qspinlock:
> unlock:
>         smp_store_release(&lock->locked, 0);
> 
> lock:
>         if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
> 
> If the hardware has Store-Release and CAS instructions, they all obey
> Explicit Synchronization rules. Then RISC-V "UNLOCK+LOCK" pairs act as
> a full barrier, right?

Presuming you were thinking at CAS.aq (based on your previous remarks
above), that all seems right to me.  In fact, the (putative) Store.rl
and an LR.aq would also do it (by the same/mentioned rules).

  Andrea

