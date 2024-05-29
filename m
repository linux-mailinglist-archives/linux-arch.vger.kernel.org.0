Return-Path: <linux-arch+bounces-4571-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254E98D29AE
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 02:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1551F2682C
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 00:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022DA15A4B7;
	Wed, 29 May 2024 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqeBHGuR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4B2F2A;
	Wed, 29 May 2024 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716944132; cv=none; b=GIFkFO3HQMK7AaHG/OLO+LDwoggPACdA5dZNu82DjljnK1DzCf1Lfc/mncsPaD6TwS7GY7bx44XrA0eMnavqs+7cc+oXGvvEzGlhvMMWlQLzWbLKQyYgeZ2C/DkEJ7eSrWUUS+jVCS25G1TsapzlfRZktilF3r/qy/TZ/e+GdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716944132; c=relaxed/simple;
	bh=zGz4gAwWFZgK44rZc0IVq8EUqO+SDwchcULLx0Sl+2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA9867z6dDqkwDY1yz0+7O6dr0RwYhn9XrxSoOVevBldkAX0xgM6OFLi1Zy4Z7mgahWVnqXt4qyV9zI2oZ9g1WQBHH6wphjwaI/cAu1p9Vu1ROlNH2jcFl94YE9D5RjqPPDsPYda+x5V1uHPNUPkPPHX0d/AqsQvK9/ia21p7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqeBHGuR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354e22bc14bso1225103f8f.1;
        Tue, 28 May 2024 17:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716944130; x=1717548930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bC53XzM+uy8PiLd8YOyk6YbyRBUin82pX9N2ZdNewo=;
        b=GqeBHGuR4i8fl05e4P0/ZMIiQX8+r9LO168nUffsvWp8y90FGRVJBY8xwBbsoXqonX
         109JWhdKJc2gAmVx9nLcBeNPnDaJFuIPOCaL2Zl8x89u9vbW2eneh3d3A5qaLZkCl47P
         uRRNpt5LhapyUgL/f4BnWdECH9eToYe8dp5omSIxbZInNmz9f3YFBpEcSW4OP+/nx3Ld
         YftwU1jCjaVfPALpPVHFgnHTy8AY1mkqxdE8OWP9RPFCPn4Sbt06RJ1r2YX8twNyum2o
         s0oK7r2Ke7SEWsaIuXuj5CPg2M4IhETGlz4AilZVvBsPgAQbvatyUp5Dik9CNDQmyeiS
         r8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716944130; x=1717548930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bC53XzM+uy8PiLd8YOyk6YbyRBUin82pX9N2ZdNewo=;
        b=UCLk+urqUyL04s1QcfkuW9YMz3NeHGX8vrD6Oj+TgxlPtqHlj13vCEMdSQM67KJ1o+
         VpK4t/7ML7CvcFW6uU9EcpXI+Nl1V6g7WtLsxj3kFWtubQLUCIK9HypOO8r70VZws29w
         fwPRZwum5IJGZWyJy5T1Et+Oh/XIsJwA0wT+xxJEw0J9DepIPVWWhU41IX/a7CwgeC5O
         zv1dGopFFLuCTdAV5mDUTgdXtYIg840SoU250/Yilzc16sVV0MPiwdKzzFuW7srgasI8
         F8k6FXiNjPevMJ+YdqB8xUWD/h2HEgyxDJc3oNtw8e0O+v4xi5ENIHn0YfyH3WsVjqQF
         sLKA==
X-Forwarded-Encrypted: i=1; AJvYcCVTIzCff8e6/WFFiK2tlgVsY7j++ZpY9pREoYsrIYuO4x628voHRqnAUw93MRVPekKPyz9kxROuYnE7OEugT91MU6kQf41ELr828w9yXsZXzJTJDUUHEf8OerlNNdrxACNePxSvzTixU8dfWAJMM205qGi5UdBX0mKTPZZoWqdFuR4B6A==
X-Gm-Message-State: AOJu0YzhMzFfl3z9n5hn62gAE0AE0eWA1ZxfnhgcJEC5tTpb//oBDOtZ
	GgUEiGVsCo3BDVcfJwL+0OR/OWpQO1tNZtwoH6w9+xPXp2pCSkho
X-Google-Smtp-Source: AGHT+IEvUEkslbEuJ36n5fUNNcqqyx4kLtZsPYT6w2lhIJyJzqT2Uw+KYtCXxmqNpjL+xf8GkG/5cA==
X-Received: by 2002:a5d:4f04:0:b0:351:c7c7:985f with SMTP id ffacd0b85a97d-3552fe19145mr9586169f8f.53.1716944129495;
        Tue, 28 May 2024 17:55:29 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6328c97eeesm175282766b.111.2024.05.28.17.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 17:55:29 -0700 (PDT)
Date: Wed, 29 May 2024 02:55:24 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
Message-ID: <ZlZ8/Nv3QS99AgY9@andrea>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528151052.313031-8-alexghiti@rivosinc.com>

> +	select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA

IIUC, we should make sure qspinlocks run with ARCH_WEAK_RELEASE_ACQUIRE,
perhaps a similar select for the latter?  (not a kconfig expert)

  Andrea

