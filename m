Return-Path: <linux-arch+bounces-12080-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ACCAC1598
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 22:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA88502B13
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 20:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14924167A;
	Thu, 22 May 2025 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz+tznIS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84F188713;
	Thu, 22 May 2025 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747946389; cv=none; b=se0qq5qJmiqBmsdIa2pRVEa3bZuMpzG2mOcUuvQsn/rsQ6lrbICOs1ZjiUXQjP4JLhueg7Ixx6tMW0NhsA+fXKZfUNJ5FKFr7EHt1gUWRqHqhy28cCD39BQr6kvJvx770O0lrYGYNeMiWGijDrA9EV0IF87UgXurh+TM2bgYgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747946389; c=relaxed/simple;
	bh=cMzwioh17gENmm2R6XQJtayjD6KpeVsQzAG0gP6JKzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJCubsFJ2eCiEJPSeXl9nyMDp5bz2cYoCdr77ebgYQIDqv+rtG1hjeW/QsMV4O5nGCDoxSkJbcAGRnRfCPinSkc6LfmsDuWrhIMqEiKMAyzPKqwTXgTpvrkaiuhQFUpavnXXGhBOnmFGgLlYeZITop1FLPcbvXhBEoLiQIzb2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz+tznIS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a37a243388so3396353f8f.1;
        Thu, 22 May 2025 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747946386; x=1748551186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY91vjGYq1YGLlhS2Op+EncNJMVLvjFIbtv4AV1m54M=;
        b=Qz+tznISWBpd6P35dyE8B2vslk02Lzd4gMMntKRojgx/scK9Ize1LueGXzjEYTcBXK
         cDhJXHbkj8BCgpW8H+hyOtn9kvGg/YNztmS6AtXcwA1JEAvh/xPXnQDAYDQgfKS91jcK
         +TS0JSYoqpcg0muLbqGOqK7TMx8sT7PTe7W4/8O/TvBzQqidUwRgwCg3y/2iGkQBr+il
         ds5vr7oCb1E1GhfRK4TiTZKXLwF5YfG3LWRiFua12g0QkKZOyClOEbFAlexNSKX2nq4l
         HyUvFaQl17k/5Cb7mkff3HCptf0Luam6WMOXGga/J/lJTabwjY375fyZcEENyy74vX3p
         cbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747946386; x=1748551186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iY91vjGYq1YGLlhS2Op+EncNJMVLvjFIbtv4AV1m54M=;
        b=umQ6EUqqyJXde4TP4ekB9Ntog621oYfngBluO4RwSFsT4WDACjFURIa6rwdcuMJhzu
         xnH99wyHRsvK2bnKGNg5GwV3j+JcfbqqHSv3DoQNUpJWhSzYd6iJH9P39ouqXgHbzUHL
         1tfMwd8BIGs4SkxYwvYelUlajMwQ4yTPHX/EC9i2HTIDnqCq6/F9FbYI+9TZ0rwsCNSr
         MomDMc5YslRhE6ImNC7HjLinqzCzkPShZB3PwTnXv9Q5tXOq1nDdHoOz0tHWFCYJ0nTp
         TGhEf6ZSONoCoExEbIskrId3GLseLgZtSVATaIUWHLYziLPLDv0F6H42Atbmw+w8VN4A
         yJ0g==
X-Forwarded-Encrypted: i=1; AJvYcCULT1YXKuulT7VqjjmobtHuvVBRDDE3TucgAawFl54tsoRENyerCPgy+cBECZahZ75Qhjm00e7HsntZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnr/XhQJ9VbdykpK3uEKOCq6iky65JkiC2DEfkHapeu2pVu7Lr
	d2oXZtqNFe0Ok6a5Rnk2hMMD3Dq2g1ZeYpR3FL0RzDYEmLji1TCihaHo
X-Gm-Gg: ASbGncuQ3vodydsSpLSP+QfMZWOY190l36Re3LKou7SaxSnVyeTDh+11vXQrRUSh2Yq
	35vjbLcY3mlQPh4EsLN5Q4Xi8bjBDwlMDMGjpiio74VO3iQWpbsFC9FhVqOwMpgOqn03v8w5yp+
	5btW+11DqfEFKOzsavTQdh1YueW7+fTlMtqZ6DWIwn51MzFxoIc8Izl/WIeHHm+8fkvHWxV95HC
	vQb2EgNCGvQnPE4psXkkt9v9SN2YifpD0czVFoex72vdPwt7x1ooEgO6Ap7aluB6xYSZ6tAwwne
	asagRyU3VXHU0aqiIA61nvPyS1f7Kj1Tq6FDOkIdzh0f4Onr3FcsY/U4m/eDk9sv/U0CFgaPFdv
	31y3ysU9Mq6afIQ==
X-Google-Smtp-Source: AGHT+IHZKykx5QpTbOJ39X2Y8rlRcInjFkmlVDDOcIVZ9NAz79zmTmz0NgNUWcgHnZ4KBbSgnmrrAg==
X-Received: by 2002:a05:6000:3111:b0:3a3:75fa:a0f6 with SMTP id ffacd0b85a97d-3a375faa340mr14824005f8f.50.1747946385913;
        Thu, 22 May 2025 13:39:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3622b8a3esm23506026f8f.14.2025.05.22.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 13:39:45 -0700 (PDT)
Date: Thu, 22 May 2025 21:39:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH 00/15] Implement CONFIG_DEBUG_BUGVERBOSE_DETAILED=y, to
 improve WARN_ON_ONCE() output by adding the condition string
Message-ID: <20250522213944.5ba1eabc@pumpkin>
In-Reply-To: <20250515124644.2958810-1-mingo@kernel.org>
References: <20250515124644.2958810-1-mingo@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 14:46:29 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> Changes in -v2:
> 
>  - Incorporated review feedback:
> 
>     - Make the expanded strings conditional on the new
>       CONFIG_DEBUG_BUGVERBOSE_DETAILED=y switch, to address concerns
>       about the +100K kernel size increase, disabled by default.
> 
>     - Expanded the Cc: fields
> 
>  - Rebased to v6.15-rc6
> 
> This tree can also be found at:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git WIP.core/bugs
> 
> Thanks,
> 
> 	Ingo
> 
> =========================>  
> Original -v1 announcement:
> 
> This series improves the current WARN_ON_ONCE() output, if
> the new CONFIG_DEBUG_BUGVERBOSE_DETAILED=y option is enabled,
> from:
> 
>   WARN_ON_ONCE(idx < 0 && ptr);
>   ...
> 
>   WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410

What happens if the condition contains #defines?
Does it output what is in the source file, or the (bloated) expanded text?
For instance:
	WARN_ON_ONCE(min(foo, bar) < baz);
doesn't really want to show the expansion of min().

	David

