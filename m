Return-Path: <linux-arch+bounces-4547-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C628D019C
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CA51C24490
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A415ECEC;
	Mon, 27 May 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiHVUzBf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D615ECF0;
	Mon, 27 May 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816751; cv=none; b=hKiAY92Nd5xgmiFZZWHWUgIeuPANDem2yWONIbTK5UoLDKkAJDJePyxJS8zaRWBr2qG9zFwrqlJ4I23cR7K+PpSZcTUm8PnGFZjVqtilQLZ2lQsrq55d0BrvVPgzu7ESPhbvBzCrPQiYJZ2I7067EUvNInWmnRteLFw4Fak6wKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816751; c=relaxed/simple;
	bh=pgZeXtSbEyXQ6I2ykA4tVLirFGIPg/Fk39T8jyzcKno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbvgwwALG6janTt4m3gdD91a1cFZG6GRg0Fp0OspZ59wZjYFkMowUmgQpQFwqvNEQodAa6cvvGx+WMWuHR7RiV0BvTuLW2r7XvOF1PGgx1hDKQeQYdY0IEyqRI1r6ijG4QIJi2v7qVfk/CVKbJ0jmvGfJKZKuE053nfK+ntsumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiHVUzBf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-420180b58c3so85049685e9.2;
        Mon, 27 May 2024 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716816748; x=1717421548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPelcZ7WHvjbzGj63vH28P2uqTe4G+u9uApH1oPNWBo=;
        b=PiHVUzBfpe5zih6niH/1s3M3CKowyeSfSbj4OH5SaPGXhrRYxpz9SH79WJT0LcWED9
         Lxpk0yKEqs2cMam/tfImNP6e5IOuop46RV6pH1zUsL3IVTdR7yk74f0RkC4oLIX5777r
         4NB5iqx02+jbKY0dGByJVXYrR9usDHF5HF3AGOtcFGvzCyE4RuTZ7DxQPsfG0pV2RmxC
         ZkxyDR2+cPo0GCDypI8EY6ytyJw7SKIGLHepH1DzNSNa0vusHfBzKxiH0+rbC4fyWN6E
         B52NqYuQeD8+JTPMZ+5gvTaCrnxP2fi3bACIGFhG/19Cv2FgKAHXFp0cg+SnY2dnPX3B
         fEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816748; x=1717421548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPelcZ7WHvjbzGj63vH28P2uqTe4G+u9uApH1oPNWBo=;
        b=WYDznSYYjRzdoNUqQmOI4NAOPHEL7k0gF0D1IMO2lkpNUijg8ZNmL/EEUsrXQ7ncjf
         20LuR0NuyenhTDmd4Xe5Cj1uI/nVdwPDNT+LVsBiTa/tYXLkDTH1RUGBfjriP7ZHaYjC
         G/ne9rOLqh+ZzKzq3Z4D+kMan8dn4h43CbWWuSq/i5MUTbIqnZsdXWiajY/98HZuaQ8e
         7OpZPUNkgZjw3k+gwAK9pxZkXloWDxGDRuW4e/E0/QpuTiB2Y30X6LEALpDJX8SSacih
         EBeTZNieo6B5/MjB2dQDGL7XRiOKIEhFASzd9yaXi69LCgiGb4yu92ONuE+wb27EK3TD
         0NZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFEFrb6ojUZVaawfpvRvs9lL1gg/tcvzkxZ/WA1WchP+E8yltorx8U85Rl/kp3yXsZ2uJkvmZSVkv+oqIIz8//LX3FYKwDjw2Th/yqmD4ida9WxmfKvJUdYBzCNz5vG2MewsECoPUX6Q==
X-Gm-Message-State: AOJu0YwVXYdi3IWWKxhguzmUznYrIbswBn+eiTB1cojMnYWJyG67zoRs
	LVExw1fP8skAbaMQtEv+YLylwf7dvI+2wg9Lzwr0c2xdKieceC+F
X-Google-Smtp-Source: AGHT+IEjetj0XxOYo7E9N5hGrPpt+t/8icovtDnfaD4dMEnpELKai925LdGc2zg3w3RyCWUT//PhkA==
X-Received: by 2002:a05:600c:46c5:b0:41b:855b:5d26 with SMTP id 5b1f17b1804b1-42108a4f8c4mr67045565e9.2.1716816747732;
        Mon, 27 May 2024 06:32:27 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee7e1fsm143047805e9.6.2024.05.27.06.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:32:27 -0700 (PDT)
Date: Mon, 27 May 2024 15:32:24 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <ZlSLaOiSqmX+mPDC@andrea>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1c6d4146-86f8-4fd5-a23e-a95ba2464c9e@rowland.harvard.edu>
 <ZlC5q7bcdCAe7xPp@andrea>
 <b7365700-a983-b787-e22a-7526621d4c18@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7365700-a983-b787-e22a-7526621d4c18@huaweicloud.com>

On Mon, May 27, 2024 at 02:25:01PM +0200, Hernan Ponce de Leon wrote:
> On 5/24/2024 6:00 PM, Andrea Parri wrote:
> > > What's the difference between R and R*, or between W and W*?
> > 
> > AFAIU, herd7 uses such notation, "*", to denote a load or a store which
> > is also in RMW.
> 
> I also got confused with this. What about the following notation?
> 
> 	R[once,RMW] ->rmw W[once,RMW]

I'll add a (minimal) legenda describing this and some other notations in the
next version.  As Jonas remarked in his reply, * is what you would currently
find in herd7-generated graphs, so I'd stick to it for the moment.

  Andrea

