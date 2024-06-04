Return-Path: <linux-arch+bounces-4695-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FC08FBFAB
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 01:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557A7288F3D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 23:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2914B077;
	Tue,  4 Jun 2024 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKBe8Mqb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38482D98;
	Tue,  4 Jun 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542713; cv=none; b=aa82dXM3T4Zgjg2NUX9t9DQAVyBTiFfKnpFDK44boE8C2BIXEJp4yVnKts8DXx6SqhpW1UD9bI6NM3Dy3kGkkZJeSrndK/GXcI3cIIPJVBnEmHc4l3YojlzynirmGVxsBrZ1l3JS6bP4TVCwryEy5jA+UpCwLiCoDJ+cLSt7Kng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542713; c=relaxed/simple;
	bh=4FuPX6BuZt4dQvMbIXSBlmgsmIGMVwsF9WNh0YACBZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS3kaLPzMWbYmaYEB0YAW8HzRgrk83GucHXWv6LakDsiIm22M00oEyZ3+73PQ10KCHEpGK3d/jzIv81ODLBHf7dZW3VSi+Tep7oSf3VnPONJYag+nuylhTMpp/CXgibzMLMxVfMUKAMGg7AsCqhK8Q7NHxQWld7D0coQAPwkR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKBe8Mqb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4214053918aso15854435e9.2;
        Tue, 04 Jun 2024 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717542710; x=1718147510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sX/6mmC8XZEQDMuHxkMrvCE97OCxQjuaydG2h3AIVKE=;
        b=GKBe8MqbHYDNi2m9f2jPe+v8gDGFxD0CFMroimKKpvAUlPlJ7fbjZI1Wr7/d0e7BKv
         xZtJi08ImUNmwPt2T7NJ6ciNzFqVJWFK5dTujnReWoQrc+e5zC/nbFIXQjh0AyfWbNvQ
         aKkc6stklbdnNYdeRPsXcCc5N5jR3D9dE7j86bnLVw1vgDxplYJm9qQtVzQ/336P7haW
         BWQGWiXiQzpPXCqb9OxwzFLdUyypJmUgRv6Ro5rBCHUDy6YwCc4A4Nd1oaENp51vGj8C
         E+DGn6v2jsPaohUMv1GvXjRCYhZvdThClCy7RC8DtkAgj2sqUx2QoS+uIZxke0HD5euI
         9OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717542710; x=1718147510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX/6mmC8XZEQDMuHxkMrvCE97OCxQjuaydG2h3AIVKE=;
        b=rtgGIFeghl1C8KNAwcUDoaHLt2gIaF//PDi5rwqFjegpx4L4Jonxd+AeCL++KfJ+UR
         8ztA00ZZBDdOrw0MMO3rQQekBWbLfstGkti8SPrBCoptbrYt1bfTb3iOAl3q4m9LYeZy
         gVb905+SnxwSpK3VjNvbQ67yKRkKHlnXK6jAyLtSseiV275gJaq/JuI+Wk1pJYSJ974h
         C8kC5HYc9V56Za3jWVij9D0ijNJOhJWaLYYlcBdDl8NlzlPREk3Krnqp6z/5jkT9evDN
         bwl2ffjeHr4FRx6T+MzeiW4Z/2A8oBMZvX9QbLoqGpSwOFI3lVZ5C7GpJmpVW5c3wNpn
         xiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoLplUyVMyFptusO7sIVpGd6hm2xHK4tg/8HlEZRAfQyfZv07uYpxQ3OQ+bsDk6rygOkIll2MSuyZISweRVW5ONXKywjVy1Kho/A==
X-Gm-Message-State: AOJu0Yw8uBl+KBI2dC9N9bvjhL0XOCm1PLKF90lOefPpPW1bgHcLaebY
	phQQ9tG8cXuPNQlscpB/yMF+v3OHId2vuZQiXDvchZ1vK/bFaWxM
X-Google-Smtp-Source: AGHT+IEHjrRL1cylLduq+CkvBeCKQ7MWSOYgB3YuHQ5rTi3i8sHMU/lxwECcL+AYyh7dF4CNkt/jZQ==
X-Received: by 2002:a05:600c:524d:b0:41a:3868:d222 with SMTP id 5b1f17b1804b1-4215625804amr7276975e9.0.1717542710207;
        Tue, 04 Jun 2024 16:11:50 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215812969fsm1181195e9.23.2024.06.04.16.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 16:11:49 -0700 (PDT)
Date: Wed, 5 Jun 2024 01:11:45 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com,
	Marco Elver <elver@google.com>, Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH memory-model 3/3] tools/memory-model: Add KCSAN LF
 mentorship session citation
Message-ID: <Zl+fMRgK7q47PrVy@andrea>
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-3-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604221419.2370127-3-paulmck@kernel.org>

On Tue, Jun 04, 2024 at 03:14:19PM -0700, Paul E. McKenney wrote:
> Add a citation to Marco's LF mentorship session presentation entitled
> "The Kernel Concurrency Sanitizer"
> 
> [ paulmck: Apply Marco Elver feedback. ]
> 
> Reported-by: Marco Elver <elver@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

