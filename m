Return-Path: <linux-arch+bounces-4546-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C578D0178
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317D81F21869
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5A15ECEC;
	Mon, 27 May 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGbJXfkV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6715ECF0;
	Mon, 27 May 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816489; cv=none; b=mP/EeCf7XEKIjEyiuWxTXCN1pGBMsBgLvhrjmcyPrUY3514DLU3SaQWcVQRoh6A8UUY3WDP8Bbo/am3Izfxq2Yof1xB+vjTHTBmW2k2WDJ2JtEqIW6VNS9n+Mz5+p1c/zQJKqQGHLxVXTZCTBT3Mxu4gmvZFaYESQDMxipcT1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816489; c=relaxed/simple;
	bh=QPBcibKyBusuJJW6N8QIorC7ot7ufZXzahC+ZmkGGCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX/MDAgcyjPFtcgVsZhBvvGGLNb2Ih82DrflMPj1fpolzhFYDkcK6KO886t+Hp5iKBAK4Pt+JlfVbPNTQv4BTxEznktrckAKCe/2MAoaGAylgaLQMRwtq8HSAmuaJ0k3191IByE/d4vTN+YF4QnO3l6E0RDrvObkZobdK/Qs+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGbJXfkV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3564a0bea19so3043321f8f.2;
        Mon, 27 May 2024 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716816486; x=1717421286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1abBfthlBeoo2zktXJUi6xTpqVnu+v6KAPi60X0AC0Y=;
        b=QGbJXfkVgMVtuNdZjIRABA1HSHvUj/depr/wsnRRAZfZzvLx+4PhkfdpB9nN+MztKf
         q1Ru4GrU4IyQt1CZDctVgqfMknTVdgNAmjH2klPBSXX1W6ZxsKd3pM5S/0e9HOwnDKhP
         CDIBYUO4XKROXPc6QSUGE+VvsUZH66bQzv6xc/u/pQ4eW4JxGctektpDInTRJMAEfLgx
         t2vpt37SzTf5EpCIBFbZn9aH2hd0xbo6g0HBJVUP4Zbv1bpOo2SkCusOfwFrQVAQHPRb
         uWUKha4IA5xMg+gdo+bFV6EQlAITxCmT2qMb4hXq5wJvHSjBGMNK3zH6W3c08glUE3ua
         lpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816486; x=1717421286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1abBfthlBeoo2zktXJUi6xTpqVnu+v6KAPi60X0AC0Y=;
        b=NarurHLY0ayzOiUl00qd92L3F9+nz7863oBIbsDA3U0VwGTuFYEfR1VRMcJ6yOu5ri
         X6FRbE55n0h5IVKAK8NCdiI2xoNZarggEVWhjb8dYvczYKsf7e1MW3zMD/iHDfWxcDNk
         +uNmLPXRfgaIR92X69RPfW4Dp70tpEO7C+Yz6cAh+PIVSRz6hzeyaTye5u4UQe6TRbrf
         fzX7MCiJp2+Fq4xPWvvH/hQ/Omwx0gKnVsvkU/bjEGR2DAVfbMndh9+jCtFPhoE6fXMN
         ptUsZrXuhFirJ///VRLbnm6pBEoYaX8W5qp+4BynNjxyLJ0Q3tBCLekXRqXCXXbpFSk8
         K+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUTw8LbAwyhmLLFsYfQBOJeHK1u0elfoEkI2J6ECcdKOOq50L47Pl8QLeWblqaYf0zCvs08ntGvsaG6Si1VR0RcHmwnIw63MhDFaciXIPrv2WIRZw1Zkz3xguKABzTeO3Lfq2Dv2pdhsg==
X-Gm-Message-State: AOJu0YyrGZ9Qp2xvHWaeHEP6TymWRqmXTUdFYHCaRpLbDW55HVULfXpw
	PlETxHMcRWO9W/PPLtb77F/4fF1JPbdZq7FdtSD+WLCrKi9OxZ+8
X-Google-Smtp-Source: AGHT+IFCsm+w4WkBs2uaYF1htGMLpN3Do3gTxrOWS99G3rbDTZ0JfujL83iOgmn4pU5fn/8WrjQuCw==
X-Received: by 2002:a5d:698c:0:b0:354:fa7d:dcfe with SMTP id ffacd0b85a97d-35526c272b4mr10251055f8f.23.1716816486056;
        Mon, 27 May 2024 06:28:06 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35867d26553sm4164856f8f.116.2024.05.27.06.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:28:05 -0700 (PDT)
Date: Mon, 27 May 2024 15:28:00 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <ZlSKYA/Y/daiXzfy@andrea>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>

> > +    |                smp_store_mb | W[once] ->po F[mb]                        |
> 
> I expect this one to be hard-coded in herd7 source code, but I cannot find
> it. Can you give me a pointer?

smp_store_mb() is currently mapped to { __store{once}(X,V); __fence{mb}; } in
the .def file, so it's semantically equivalent to "WRITE_ONCE(); smp_mb();".


> What about spin_unlock?

spin_unlock() is listed among the non-RMW ops/macros in the current table: it
is represented by a single UL or "Unlock" event (a special type of Store event
with (some special) Release semantics).


> I found the extra spaces in the failure case very hard to read. Any
> particular reason why you went with this format?

The extra spaces were simply to convey something like "belong to the previous
row/entry", but I'm open to remove them or other suggestions if preferred.

  Andrea

