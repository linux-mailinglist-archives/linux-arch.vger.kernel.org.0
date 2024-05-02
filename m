Return-Path: <linux-arch+bounces-4132-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A548B97DE
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 11:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E408280C7E
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4153F537E7;
	Thu,  2 May 2024 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfRbClCN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE793399F;
	Thu,  2 May 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642620; cv=none; b=NgCTwoU1o2iHd3p2pf2LTIgPCT3YR9whh1XSbL7yipxYTH7XoTXu1SsEXp3qLOvfeDD+L4heHwZTN8QWfGc4oTGaBDuUEveqnHLp9v9R1zkgoDTJGtt6GKatNl20jhh82zRBlgNZ4Q7FQW9/tY9BFeJCoEgn+eUxlW8EDa7MHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642620; c=relaxed/simple;
	bh=FIzeZJYnZscgqBQf6sx7BpTt08i8y139B79afV1c+Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXwe9Uqd2ds/XIB+HmOzLSH0HWPpMnnOrwx9kMWYLqXz9KirU+LHChidUJH2jmIDjlvVp7Ae2yi/eyTVuJC+4XRsXo7pezX+O94PBD6zAccfFLh36G7bFv1X67K51qgFeGBMTc0Cjo8BNVG7a6Hhl12wU07OHe7bm51ywcf51es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfRbClCN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-347e635b1fcso5807900f8f.1;
        Thu, 02 May 2024 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714642617; x=1715247417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/c84BgCk6s/7DORneUPqXXNJ43ZSe5m+K4sWZwg6XVk=;
        b=mfRbClCNPE9NQCecoF20TkUyIbiVlK+rl2L2pLlQlMTDWIAhP5r+8dtLMbC2DIN5ty
         KqqD6ltn4wz460ayM4MP2T1cztXvj1bcvz2OckEACluWo4SGuFAxI7EXWG4sx5X4ME0J
         oRwoPCZdqgkui8yjXAsWiB10zlIdukwc9i0taIIvYZFkuAx3L1UUXl1OegmI2ueW+ZMz
         DxoScAfcxC+Azbe3MPBy96ubdizlfFo7GfkUjrgPA0VvWfGiKjDeQcSPc5khpdEzcMnL
         XdUtAOK1K4RX68yMK3S70ntMGmWlBEWS8bje6xkHG66+VieDH9+DpJffQAIq24E+7nYV
         tpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642617; x=1715247417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c84BgCk6s/7DORneUPqXXNJ43ZSe5m+K4sWZwg6XVk=;
        b=MTblwTTy/79vmWha/fcSer/7R5VMvLlpIAMd3ftC3uROX6BLYdnfX0HzBZDOS3FMeS
         NBvJ3cTtAu5JyS5OGTKLKduEVzGdkELgtOgIAdE1tgkrZL8Zpx2Zc1j2j1ckJcuPN+46
         O769q/22d7EP5RGsqNcnCk4yF0f/odjb0abmhk9qKN9XECY02PT4v6k3bUUsY/PJbXA6
         tkyYL/YpGiZxWhla3ly7REFaLYFfoJx41NhSH+gntqg3fQKj+g35fDdidEkX6l3rrO7N
         86ObKw09tYuXJK8sKtfaSS2z4eWReySuKdJWXbcVXLowr35d6y/HlW43VzI8WyKKRgIS
         T/0g==
X-Forwarded-Encrypted: i=1; AJvYcCXRmDTA05u420zZoWxb+2MgPq0iAtI4nWvVEf+3hc+3Ij4ILmdoQ8tvIr9dQHu8ZxaqRbW8ra1M+aUx4a5n/l2om4yHWCGHpTC14Q==
X-Gm-Message-State: AOJu0YxSY0KAO10c2C2H300FTGObT66IXVINLn7uS40RC5Iz8zk08cSQ
	Twgx3/B84DAqniI5HC7ivtIZv7Jyf8/aWLauRfMD/6CvA8xkRkvU
X-Google-Smtp-Source: AGHT+IG3Ex/f5wt3guow043GN7wXhJQVBgWdDO9AFUKjm3q9KqLPK3WtKbd+9lCoMI+hqXXms70XiQ==
X-Received: by 2002:a5d:4686:0:b0:347:d352:d5c2 with SMTP id u6-20020a5d4686000000b00347d352d5c2mr3584683wrq.13.1714642616367;
        Thu, 02 May 2024 02:36:56 -0700 (PDT)
Received: from andrea ([31.189.114.81])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d638d000000b0034de69bb4bcsm814990wru.85.2024.05.02.02.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:36:56 -0700 (PDT)
Date: Thu, 2 May 2024 11:36:51 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH v2 memory-model 0/3] LKMM updates for v6.10
Message-ID: <ZjNes3y88guG2vZc@andrea>
References: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
 <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>

> This series contains LKMM documentation updates:
> 
> 1.	Documentation/litmus-tests: Add locking tests to README.
> 
> 2.	Documentation/litmus-tests: Demonstrate unordered failing cmpxchg.
> 
> 3.	Documentation/atomic_t: Emphasize that failed atomic operations
> 	give no ordering.
> 
> 4.	Documentation/litmus-tests: Make cmpxchg() tests safe for klitmus.

For the series,

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

