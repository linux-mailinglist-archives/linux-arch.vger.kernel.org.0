Return-Path: <linux-arch+bounces-4514-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63F68CDFC6
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 05:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B29B280C4C
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 03:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B921F383AE;
	Fri, 24 May 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi9rwsZm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5E383A3;
	Fri, 24 May 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521431; cv=none; b=FWJeWVra5ejX7nDweKIQ9YSDgGsYXSjNM0rx/sylF86sqnRuNP3Js3hzoPjqedTPJvwy0M8UuzHDTP77ENo6A/rhf49ZLQ/GXOvuZHwvbAMBqgznIRF+K+iTBRHLq6H9ZKuzrF6GrZ+UF6/Ma3YgS+xxec6Lh85R3Sc4y5hpdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521431; c=relaxed/simple;
	bh=r3YwiMgvXdQKE//rPaYPY2L80Qx4x4rXfe3g0MmSGjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=netIpKL4e5E5skCTTQ2hWE95DdNQJ3sJxfasB8PC6y/wAaWrdO7iCWYJtIDzVAxZTlB1LB0chEr3po72iyPNOuav5CwI2aWxepMtkm3BWA2U6laHGB+ZS7PyE68R2uM7Do6Szue42nBkg6++1fA8alM9lfb1GLTwf8R3DiXL1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi9rwsZm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso86602861fa.2;
        Thu, 23 May 2024 20:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716521428; x=1717126228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzWa7XnzMR5h26Uinu8DB/WEtIGsJskb8/pORa0/L0g=;
        b=Gi9rwsZmrtldCwobNSgAzpTBxeosgsH2jo/zitNl3ArekU1eNAXXHo0LoJyXGd6xez
         QOCcdvVZ0ronax7CGgpprY7sm9l1Ut0KLiKSMAHqBnItf8wcBsBVazzhHtr/jniOom1K
         c+nRgWsxBms7p9ZhFY738KRTk8Nq6RcD7cPngrhheS3EQQnthtX5fHwzio2yAoRlCywA
         6IpxKM+yfoH2PW92ClD02qIihSh/gxnMg112wRsAKtZHhHmfIBij5BfJGoZdgjoc5bBO
         19XPiKgu0VIiK1wlw1sxdYWRuW44W2RbKv61G/YRPPpSqacozPrMoz2Ao6Qia1vHR+MI
         IrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521428; x=1717126228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzWa7XnzMR5h26Uinu8DB/WEtIGsJskb8/pORa0/L0g=;
        b=jg0inXy6OfDCc7YCdqgFA4Omx8b2i++Rd/NDBUcZIMWSCAlEZmcYgBOkO56W8NQpFm
         mnAIfK0FzxKNFuyXVMpa1Fu4tKUsYD3w4+0psmDplmV0sShjAramdfvVu66HEN/0Vmte
         h/NFERgKYwSGoGWvcWkP4opFpILCHTiimVUU4/C4qGCo+nTOIqILRRj1uXWUTBPi2djL
         9vhHyi8aT5G/YMpGIWB+GYTdN7Jgtrx+CVhh91ILHbueFuayqp2llNOf4jCjGfCNcP0Q
         k/5nCnajv0OFIlMHju20Q5mdcHlRu+gaIVYKcRF3tHa7dQDEAzhrHdpsJ7/rpwN+4Orr
         Z88w==
X-Forwarded-Encrypted: i=1; AJvYcCVXTQqEZTvOxszPV8MUIf8GbWPcGgGwaj3lu1Odw+/OKb4dRlsG51DapdD6mtfuGsk9sum3EoVC8xfm8z24w7+2xCXUSUPkr5OLLGXh3sKhUFQnrD5U3W+gkYehDfyLj/Rl3nBlbxl8Eg==
X-Gm-Message-State: AOJu0YyaBmJ8S17rM/3gA0VrLtABtrskr/yUm+pii2E3Ez+WYLlUT6yA
	Z3SlFqztS1R1wBat/mN/KMQ5xKF/uMQIPfw+pHUXH7PmSKYnYGXYmwJWHg==
X-Google-Smtp-Source: AGHT+IH4TgYKScSqHpv1n8zIVAzS2pRx8PS85s+D4g6HYjglJFbAer8k9YNJbrUt4pM6oJ0BBARPPA==
X-Received: by 2002:a05:6512:3b20:b0:523:41ec:125a with SMTP id 2adb3069b0e04-529663e631amr711448e87.46.1716521427791;
        Thu, 23 May 2024 20:30:27 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852404204sm754653a12.48.2024.05.23.20.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 20:30:26 -0700 (PDT)
Date: Fri, 24 May 2024 05:30:22 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, boqun.feng@gmail.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <ZlAJzioZnQqNLivU@andrea>
References: <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <Zk4jQe7Vq3N2Vip0@andrea>
 <73e08b17-cb2a-4e14-a94f-7144c5738684@huaweicloud.com>
 <Zk9waJNBwifS/Ops@andrea>
 <1b1485f8-9c84-4221-b955-622dbf2fd953@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1485f8-9c84-4221-b955-622dbf2fd953@huaweicloud.com>

> Do you mean the one example in Table 3?
> What about cmpxchg() or cmpxchg_acquire()?

Yes, Table 3.

The cmpxchg*() primitives were not discussed in the paper.  IIRC, their
representation has not changed since at least 1c27b644c0fd.


> We're definitely getting rid of some lines in herd7, that have been added
> solely for dealing with this specific case of LKMM.

Good.  If the herd7 maintainers are "tired" of dealing with those lines,
that's definitely a big fat "why" to put in a changelog.


> Deal with what, no longer having to learn OCaml to be sure that the LKMM's
> formal definition matches the description in memory_barriers.txt?

Nope.  ;-)   Dealing with the review, testing, and maintainance of a new
representation.


> - it makes it easier to maintain the LKMM in the future, because you don't
> have to work around hidden transformations inside herd7
> - it makes implicit behavior explicit
> - it makes it easier to understand that the formalization matches the
> intention
> - it makes it easier to learn the LKMM from the formalization without having
> to cross-reference every bit with the informal documentation to avoid
> misunderstandings

Jonas -  You write "less hidden", "less implicit", but I keep reading "a
representation I/some people would expect".  We've already acknowledged
that's no deciding factor to abandon the current seasoned representation.

  Andrea

