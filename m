Return-Path: <linux-arch+bounces-4491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AC88CC533
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A4F1C20DD5
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E09141987;
	Wed, 22 May 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsE67fzK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AE1419B5;
	Wed, 22 May 2024 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396881; cv=none; b=luzYDVQ9aj5/O6sIPmz8NCygsV/BmgZnhdyTwv9jh0abYy3+zD0YW77rstunVuVdirz0gl2RohoggWaJa6c7SKan5aBNODmDYTxsM+McDXqk3+zMA/LGyq2+bqk6AqHKsCEvTYsjnHdl66CXThY6FkLVX4RCnDEJ4Sqn2bseagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396881; c=relaxed/simple;
	bh=SxFqKG81RcYlQJ2ki3RdcNsEL3HN/h1cLBnj4wqhuBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp4eawISPLxoTFFb0+LYLCV5/WKhnVb5AUNwe3m//ftx47ZwVuZVfYPG835Q2M4lrNrp48zgGXmgR7S6Brw/bD+y9ncx5GlRexVDvjJ8Czy2bcq6YKTL2UkPi2ON3eDxPw+EyxJmIR4nhmyuwAUBYoXhgy+jl6dopUiA72YJGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsE67fzK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-420180b5898so42788495e9.2;
        Wed, 22 May 2024 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716396878; x=1717001678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HkoAtSNjqbdIRkeHvVP/AHp2at9+ZOj9SDYTfTwFVcE=;
        b=TsE67fzKbvGlO2bOUAfgaHf0HpJ5nuWWGMHte9jgwCFmIfUeCzQkZCJu11STni0R46
         qJQdlrLSmoK2+4cbSNAA6RIE5R5Oe2aZiGygwVUtEzD5cAKHfeL8emO0KegAYH8wQVnl
         6G47HiGRI/Hg27r0wdCCty0IG0mH0hkwIX92SiVx7cb3ykPIhKR7QkZvpLWhvkWA/A4j
         8iT+KFG79lmcGLChwzJbhflN7P9s2lsUGxn4+SDliu6QGB63GS0A4y7Ex/AV0lcArXL2
         FlAPZuPAirysWLEijSNchAOda66Gr3mahmkFZ7ElXD5B+W+ZM+NK88zAG2NHA0rEl2Nk
         BB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716396878; x=1717001678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkoAtSNjqbdIRkeHvVP/AHp2at9+ZOj9SDYTfTwFVcE=;
        b=gHfQTggHuIVbW7LiId/ThHt98c+eK75Vh5OZip1eylVgS2wA57DWUw88Nnv5WOYTac
         Z1F6T5NNGXoAUYFN2XZX7XrmQ5gFO0tLctK2Hl6y5frUj1ulO4N8rLSCUXyRhjlOW50l
         X68l+bTf02GTgdhMF5M2Z5/SDbZSpug75lgEeMsGEdHGslVpLNlY5NM71Ej67hh7M48i
         Fmpj/r8lCOeYX3Od/bEpJAzGq+59rYSLLxExzArQvclpAlGzBIm1tzUDz6ShnQGe1x6M
         OBsq7jJiEHk+jtyrCBsapqsNirkAjrwUrP6W9JCc1pJ5Guj1kDZnTPXJbKaAo6RyHyby
         kxSg==
X-Forwarded-Encrypted: i=1; AJvYcCVHTxIJr61flYoaX3OBqV61u654Gt8W0YKlQOLXRIN7Nr3KSY7S3H6wgZgk3MdVJ17Qzu5VxRi2Av5uzuS6PPcHrytg+FxfHv4JntGyvQFSA6NIMLOotx35bdBG0dOT3XvFZ9rNY6VADg==
X-Gm-Message-State: AOJu0YwUSf33hgySE3miP4+6C0drsA1Nfe9Dl4741jUi8UFMTtF00qVS
	fxEmb8HmoULVXQIBpoRvyl5Budgw9LfxUqTyy0V7DYZ5Sb31BByz
X-Google-Smtp-Source: AGHT+IG/D4wrf8oQJjN+1fGFRmovQrDTpQtVhFhplHKEQoVQlBwD1O8DvMcdBqEsuvZ8Wcw96nBP4g==
X-Received: by 2002:a5d:4449:0:b0:34d:750c:8b9 with SMTP id ffacd0b85a97d-354d8d859a2mr1879715f8f.51.1716396877587;
        Wed, 22 May 2024 09:54:37 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a623173c9b9sm74683666b.45.2024.05.22.09.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 09:54:36 -0700 (PDT)
Date: Wed, 22 May 2024 18:54:25 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, boqun.feng@gmail.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <Zk4jQe7Vq3N2Vip0@andrea>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>

Alan, all,

("randomly" picking a recent post in the thread, after having observed
this discussion for a while...)

> It would be better if there was a way to tell herd7 not to add the 'mb 
> tag to failed instructions in the first place.  This approach is 
> brittle; see below.

AFAIU, changing the herd representation to generate mb-accesses in place
of certain mb-fences...

> If you do want to use this approach, it should be simplified.  All you 
> need is:
> 
> 	[M] ; po ; [RMW_MB]
> 
> 	[RMW_MB] ; po ; [M]
> 
> This is because events tagged with RMW_MB always are memory accesses, 
> and accesses that aren't part of the RMW are already covered by the 
> fencerel(Mb) thing above.

... and updating the .cat file to the effects of something like

  -let mb = ([M] ; fencerel(Mb) ; [M]) |
  +let mb = (([M] ; po? ; [Mb] ; po? ; [M]) \ id) |

... can hardly be called "making RMW barriers explicit".  (So much so
that the first commit in PR #865 was titled "Remove explicit barriers
from RMWs".  :-))

Overall, this discussion rather seems to confirm the close link between
tools/memory-model/ and herdtools7.  (After all, to what extent could
any putative RMW_MB be considered "explicit" without _knowing the under-
lying representation of the RMW operations...)  My understanding is that
this discussion was at least in part motivated by a desire to experiment
and familiarize with the current herd representation (that does indeed
require some getting-used-to...); this suggests, as some of you already
mentioned, to add some comments or a .txt in tools/memory-model/ in order
to document such representation and ameliorate that experience.  OTOH, I
must admit, I'm unable to see here sufficient motivation(tm) for changing
the current representation (and model): not the how, but the why...

  Andrea

