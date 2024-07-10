Return-Path: <linux-arch+bounces-5325-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D792C6E8
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 02:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D67B21660
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 00:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD58EC4;
	Wed, 10 Jul 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq/MXSnd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4312A59;
	Wed, 10 Jul 2024 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570149; cv=none; b=QWTzlQiHdX3mt787MCinjeW8s1duUXT96kPUciqduhuTj8XeUwUUJrqTzltQRgnLy87RXPPFsG3+TIwmQcYw/7aJ22MxmVXs9jk35eZV6V1Mdz7YgYMv14uKFk4nsZHeZ5ifqSYOPwoG69XXgmPZyLHhiPV431bksvpx/sA+jkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570149; c=relaxed/simple;
	bh=RiPfe04ckyALJCeh5cO8SeOFPy1mMZTQ1u4krWpww2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuSv0y5QHXzjQQJlC4Vs4tnI3kixW4t38fC9jfPxqRK2rIpD6J1FAxrydesjbpaO4vMrDSoQ+Nzbr2bmm+/rPvGnjwojeRO72CvOMEpx5QTOt8aYPoSoMWvDFnNf8JeeJnyTgHF48pt5HIeeFkFtfG/HRqcszpnCUb+mwF/hbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq/MXSnd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77b60cafecso685177366b.1;
        Tue, 09 Jul 2024 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720570146; x=1721174946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3JRQ7EweQhSMEsvvdkrywMrGBjn1vj/+wD1zYMRcrw=;
        b=kq/MXSndQrA6maeuhLVNHzCUPNpKX+qDWReEAp1t0fVS1LTUEQGSNqq9KSf446yZ06
         tJKJtx9ygRmoJ3fl3GaHuvMzOyyr5CwpvmwWCyav4GzuYljXQtJV/Cdlj+jXkrkBq54C
         RmeF2n4oBjkoG091YAEnFlEFCy0TDLx7BC+7d42Vm4qW4C+3uZ0WekFTcY5RFw1KkQi+
         F5Swn7YgJakw+Hj4J2EZH9/OHzc7LB7AD9H9RXObnHiVcHSV3YRgUIWePHD831cGYxz8
         wX5/UCf1t6zie0TTOn8lO4IOzlb61sNL48h9d7iRHd0KdsNrNGll6iyTHkWKCo+ErPTE
         Rv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720570146; x=1721174946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3JRQ7EweQhSMEsvvdkrywMrGBjn1vj/+wD1zYMRcrw=;
        b=l2wmwbf5DXHPAKWSEnxSHbCleSIbCf4i6j0/XGLpi57f3vRx+pQBBovcCqzsJjcsJ9
         HEcnw6iDukUhb1D8iZD2erbrH23QjpDLwhIYlatHt2pO4axpJEhc9OqLQnWH7RNOWF4a
         ToqcBAFjPWdP5w5hhZgsLSFQ5ULG8rlBXcuR1Ly7PMZVj1LqneZYx7fd5KULoY1YlEnx
         /CJIkxnitK4TcuaP4ZcOVQ4EV4JM3PByFgMs7WUyHU6e38DjHoG7FS1x9pBvIEw4OvNy
         XQ6swecEVgdvW1GVkWmOS242KItbYjrrKob7Lmnv3xefsLiekqp3TjTty4d4Ziv6mf7c
         zTZw==
X-Forwarded-Encrypted: i=1; AJvYcCWEbpE7Rf/uH956DRMJFYy7ci/QUbCfiaVGH5ctsRmAne+ak2pqo1vOsYDvsJFgfcbJin4RUQZKdJDbHllrfsZ/Gk9N9WiFHxjAP2DqnF0y5I0NFpH6j+WjtXpr3CH+N55U/D2Lvjo3wrkUOdRmLTg+q2mIektl7kFCOm6C1sUZUU5wTQ==
X-Gm-Message-State: AOJu0YwnDRnpHGZaSgfgogKaDz+iuPZa3f/+m6i3BSYkCgT1nOh3QJ64
	ezdgDE1/McwySmc56p9KAD+fxvVeNn+EA9IltikX+SIlmiQIo7ic
X-Google-Smtp-Source: AGHT+IH7x5bIVF36rjoHSlDcBGTLTopoNVM1WIfL/wrBab5SBCqjguHyhpaatL3eld19b/5jP213Bg==
X-Received: by 2002:a17:906:2b57:b0:a77:cca9:b212 with SMTP id a640c23a62f3a-a780b7050dfmr283637466b.45.1720570145545;
        Tue, 09 Jul 2024 17:09:05 -0700 (PDT)
Received: from andrea ([84.242.162.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc88csm114316666b.6.2024.07.09.17.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 17:09:05 -0700 (PDT)
Date: Wed, 10 Jul 2024 02:09:02 +0200
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
	linux-arch@vger.kernel.org, Andrea Parri <andrea@rivosinc.com>
Subject: Re: [PATCH v2 07/10] riscv: Improve amoswap.X use in xchg()
Message-ID: <Zo3RHtQBvz27HiTK@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-8-alexghiti@rivosinc.com>
 <Zn1wDAXjBdJu48Oi@andrea>
 <c6c305a7-37d0-4834-ac65-1ac5d32014d1@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6c305a7-37d0-4834-ac65-1ac5d32014d1@ghiti.fr>

> > I actually see no reason for this patch, please see also my remarks
> > /question on patch #4.
> 
> You mean that we can't improve the fully-ordered version here?

Well, I mean, this patch doesn't AFAICT.  You've recently fixed these
LR/SC mappings in 1d84afaf0252 ("riscv: Fix fully ordered LR/SC
xchg[8|16]() implementations"), and the remaining look just fine to me.

  Andrea

