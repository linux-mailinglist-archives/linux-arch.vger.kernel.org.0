Return-Path: <linux-arch+bounces-11458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC079A93CC6
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F54447424
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D58221F0A;
	Fri, 18 Apr 2025 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuhqsS63"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDBE214812;
	Fri, 18 Apr 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001050; cv=none; b=mmn8Epw0EL7H19tEFl7i2c3hhwRxGOBJA+m1zs+NCEGyLIvgvpH0LI4o4TsHkKR3oOy7/1ccGdlKEPECEdGKRqPPAXv96zo49j3vVf6MivzOk0eBpJNy5frBTYScwYiAKz3v2C2Afmrt9MISLR3woA+QoWVyCIvv6fyg/7RtILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001050; c=relaxed/simple;
	bh=c0CB/DXF9gNgqSz9i4xYW55k+UT3LJPOcOwZZ95mDpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv6EH0MIMmA3H/oN5DE4OFsDuSkAIVH9NEkV/lbw/1fP6FiDzy2CniUpxutaskRz6yvETmC0DZDO+K+3zpvK9DQ/BwkloYbcIz16+k3RY6cbsApklJhdIHLvHOAiW+wtNFLOsCfpCauG+c4DpW2QWuSO5onyJ1KVduBZW+MwXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuhqsS63; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso14134195e9.0;
        Fri, 18 Apr 2025 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745001047; x=1745605847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EM2y7Xj/ptDYmV6jJYUrAv1l7drHOgK9Ux557VTdNY=;
        b=NuhqsS634VGh6n2WsVkWjj+HBUsT6S3vmYpV8Z53nSnRoImSolO8bdo/c4ztdhPCnu
         ewJGj+QeJsdTqaK6wM/h5IypzeI+DWMBgQB6DpywiNh4RaaEfUPu1UM5/bGcXP6azbtv
         K1IhCSJuV4F0eN+OIU8wimilaij8YWfSUFArlCybXtD46VepOQIQbzyEbIMi/N2LFy62
         O+kqOFFTz8x3HCwhaWiR7Cofrs7kggE8W1ikvzO8bGCBgjC6VGGjVUwmwtvW4OXnnzSm
         2qSuoia+AcCu6dcn0Hq6rgfzld0cPQ5pr+b9binrT/LOMqdpGAe+1O2iQFKB3V0M6Y/2
         aOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745001047; x=1745605847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EM2y7Xj/ptDYmV6jJYUrAv1l7drHOgK9Ux557VTdNY=;
        b=aoGR6wpOvr57Y5/LejBJs0rcx9N8xDvdsl4uFgSJlkKtAvujK/Guf6ukucIbD5qL79
         MEz7ekzDxXf7kDLbc1h6UCVT353vUKxOeZ8+kxWuIaj83mi613juFeUl7liJx5Pf6YMp
         0qfkVG8ieABzF0M4mr6gTWMzkMAk4f2gj5/92F7akgUiYW88yLE9w4L146L3mSz7eZzt
         ZS4MaqQf9A5tZy6eBNiykdD+q/PL2umZpeWx+K5KiCyrHI5evHrsFbmJ62OXgxr/668N
         rm5sa5URfl5lP01a2eqUOYs+qeGSCVJwKpe6VPziL/0THDUGXYm929ne78U8QRFh3ph7
         n4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVQMMrW22zrEUMzNAytiVED1crEnVsVURNA4Kf1DKb4hhQ3QO3k4wU3FZXrRENrcUoh6LeQKrVrxDIO@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDe8SnGRcSSMNBCGIxTqxtof03leTo8e/MdogRuqe5afJ/0zJ
	sf3WL4nWgtyoiOByU592T1jBFRcYQJZ0Tf0oZ/3dpilmbCSfeoBw
X-Gm-Gg: ASbGncsPZjJYvfFqE8RjB9YG4BNdNY886OxPew8gOXJ+SLpLeMZsQEck0+KS9DqC2BH
	aZAYOAk0og+5fFZR6OmN1dgeSKq34+KpT3mfYUWlf4e/r0AzRku4MEB2ImVgUENHd2Pe0XCdiZX
	RsNsTfmSLsLmL4lSlww/wtHO8KUlVnmyPkqPz3vNMNY2ayJm4uD34VJMghbJtqmgcjrkFAlioLH
	VKdoh0bUUvVHfhCgzBhJa1YJSjY5h1n7vdN9t8sCQXNMTcJev06bACrmRnPSummXMkWG0MYne+N
	Dq580H2jreIWgXkGt2GNZWLyB1kAfZjqb5Pe
X-Google-Smtp-Source: AGHT+IEw2DgG4Fznx8yp5fVzK7z/tYxtlhO2MRgAoo21zkKMF8tUl96AfuzvkPw8EiCzvjOVZ8EXrg==
X-Received: by 2002:a05:600c:1549:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-4406b235409mr26940785e9.9.1745001046789;
        Fri, 18 Apr 2025 11:30:46 -0700 (PDT)
Received: from andrea ([151.76.46.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acc9esm32078575e9.13.2025.04.18.11.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 11:30:46 -0700 (PDT)
Date: Fri, 18 Apr 2025 20:30:42 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, kernel-team@meta.com, mingo@kernel.org,
	stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH 0/4] LKMM documentation updates for v6.16
Message-ID: <aAKaAXQApP8JoQkL@andrea>
References: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>

On Fri, Apr 18, 2025 at 10:29:53AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series provides the following documentation updates, all courtesy
> of Akira Yokosawa:
> 
> 1.	docs/README: Update introduction of locking.txt.
> 
> 2.	docs/simple.txt: Fix trivial typos.
> 
> 3.	docs/ordering: Fix trivial typos.
> 
> 4.	docs/references: Remove broken link to imgtec.com.

Thanks for the updates; for this series,

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

