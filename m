Return-Path: <linux-arch+bounces-4541-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519858CFAF4
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 10:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42B31F21D31
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1B73C463;
	Mon, 27 May 2024 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6t26XGW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2223B79F;
	Mon, 27 May 2024 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797234; cv=none; b=sXN4pYYGswqp1PQaCHhqJrKrU0Ph627cri5bwXcu5bgsLIpfiSRGUL6b2KC7kGLEsFsCPuZN1LhY23rkmzo7c+W+kZjue53jM3PI6ThE7Sml6jKxcscQT1MRJ8HnwCs23JfKQwd85VqkJdPJ10BUHzhgyqK0jd9E963EKg4ZfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797234; c=relaxed/simple;
	bh=JW2Yz0SvJ2VIth2EGq/w8wxKWAupzo/M2exOJJXrJxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+bVmc6NqJhjLoy/719XCtfFhAkSg7gOzVM1CxK/ITPl/UEIVY4Kxyxw0zwDVE0c/GpvWb5UOIosScPOuEv8EB/QXJM9gUQ1qfcWTgnDO15fvu5h4celUXzvudJfkY/o9dF1VzOW58WiXvPLCr0uGHOBAKHUDYhP0vbfF3QY8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6t26XGW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4210aa0154eso13147875e9.0;
        Mon, 27 May 2024 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716797231; x=1717402031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zwupHlw5JOC4so0inXfl+e3LXwl4GExIuXIh8Z0Dqo=;
        b=b6t26XGWIJpc+B4i5wPG/2kiCXJcsio1o0mHS7JVestikQZh88zBL2U3U9TeGRmUzx
         T5fnWoCYVCSM0ODS2F2uNh+fnSzH25M12RLCBl2TBtB74LlFF4bZUZx7E4CnYRnqpKw6
         a4S83L+ooH7v+uZ+1X56FT7B/PAwY+00B9eAeOEYH84RT1tRm6/EZvAQO0n/Oybll70p
         M9X1osvnOMJ3+u7rioCX5SNwCOfW0m+SVcLytVRwmEXe3F+uYy14BQkZ75MyfvOH8g0n
         gjUJ0HRFhhK7I+N3vo6mgJ2qwQ8XoW9q5Z+kNi8kWajB1JItVVhM8t9tmLBD6ZlJ+v08
         pVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797231; x=1717402031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zwupHlw5JOC4so0inXfl+e3LXwl4GExIuXIh8Z0Dqo=;
        b=DoEYDp006sLCGS6ZfjGsInlw981MKN7SFrBAzZHF3cUXyZKtS3QmDVD+rlTizqBiaf
         OB4xiK2QFpjQKxC7pClruaIH4frtmwFlirebCtsAdqIqiOYiKkWYAzGPlihaYKVvGdrY
         3BXdhD4Pss8EezO2Tpbwn+FVMFQxwinryvswizPFuTbUzWasYRanVD0ZZRe1SIQRkxCK
         EUCzr60juKtle0XFfoukpQ4X84vA7MUfQI5U//m7vqABURnhxwtTd00YqExOZjRz20nY
         /8VgYxDabByBg5E0apbWsdk3QwCeiBsFBvcY5iSgeFS8IYHlEopUPolN+tnYcttofd3K
         y0tA==
X-Forwarded-Encrypted: i=1; AJvYcCXJBZwEHEFUVtfx4yS1IiqNAs3N8YtJkWX3aLQzB/ie6u0PY13gM7FkFKzhdYrj8SLwugt7iBpgYikEB7XZqJPX2xGUF3wP+YZre8jejoPypGaQqgrKaf/LV80CrzoHFaFHToHRrT4Agg==
X-Gm-Message-State: AOJu0Yx/tRfI+EdNLMWNPIIZEx+9CsNvmWHq9uYYyTHdB6QSN3qyk7XK
	fFUYMx9MiwXemxHstzpbni/T/erEhwIP4J3kulpjR+e4hyic2R/t
X-Google-Smtp-Source: AGHT+IGIELjzxKWqwNZfqhftsWzI+FUaf4J+jvqPrTm2kiBoxI1AE7hf94DLuh/xG9TKCi/eE6NDWQ==
X-Received: by 2002:a5d:598a:0:b0:356:4cd8:8501 with SMTP id ffacd0b85a97d-3564cd8874cmr8310849f8f.37.1716797231306;
        Mon, 27 May 2024 01:07:11 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9363sm8295932f8f.72.2024.05.27.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:07:10 -0700 (PDT)
Date: Mon, 27 May 2024 10:07:06 +0200
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
Message-ID: <ZlQ/Ks3I2BYybykD@andrea>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <ZlC0IkzpQdeGj+a3@andrea>
 <cf81a3c2-9754-4130-a67e-67d475678829@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf81a3c2-9754-4130-a67e-67d475678829@rowland.harvard.edu>

> It turns out the problem lies in the way lock.cat tries to calculate the 
> rf relation for RU events (a spin_is_locked() that returns False).  The 
> method it uses amounts to requiring that such events must read from the 
> lock's initial value or an LU event (a spin_unlock()) in a different 
> thread.  This clearly is wrong, and glaringly so in this litmus test 
> since there are no other threads!
> 
> A patch to fix the problem and reorganize the code a bit for greater 
> readability is below.  I'd appreciate it if people could try it out on 
> various locking litmus tests in our archives.

Thanks for the quick solution, Alan.  The results from our archives look
good.

  Andrea

