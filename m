Return-Path: <linux-arch+bounces-3331-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5189209E
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 16:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2D4283FD5
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C0414A82;
	Fri, 29 Mar 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUnOUR7H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D41FBA;
	Fri, 29 Mar 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726810; cv=none; b=HdL6QUR0uK57/gTcFmuwvsxwp7Is231eNnIyOK3oJoSeiErgq7txZMZXkemJ706h/3MmF23TBwrqyhDa9y9T797U3gTA7l+PYCyGN3Vb9GQ6TMhG45bwnPk+c/GXRpXpOdQ5QM7Yl7gPnUD9NcZZiU/zvvniuIML2PnCNLTipfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726810; c=relaxed/simple;
	bh=XCgoZLnAXnGDp3scNF5htnbob5J7JStC8D45eQoM9R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCDryKTCwNBa1XESY+HXrS2fCn9Ozuiym1DVVy5CR6Vvze0hKrsJPXVEBXqEViTLFl7Ah4vNuiXZkU1sw6aoJwNBYy/7swRzdJ6OJ4/g2oFdS5u6stGkcvDtlZvAxMIncnK4B4wXmzWtYqljaYhhZLEz+CdqsKwIqq45swgykpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUnOUR7H; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1519286a12.2;
        Fri, 29 Mar 2024 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711726808; x=1712331608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iN31wd2vCkiTGMz1OBtEaB4JW8VyiA1XbISlyEebr3E=;
        b=MUnOUR7HY6vwYa92neIZHYGUvH5I1dF1Bo7/9/nYC/METJ1LcvRfTJ3UrdSMmUe6FC
         gOsAAcZI5fuMBtnYd1XYteTpD7iilDnzNJGQCDkjNtdSbNtsjQ+H+tT/p1giGio6N6XG
         c/fOoWgNLNBTXbnefO75MQyI51dLo+b1SVQJb2BkA3/hB5pZIlony882eQZu9ZFNh0ep
         33bUFemjBqO3ZNk+x0tiQjkOnJ9fcXv2MQdOFypkFGG4FahpdXL6b/Vj7wCz/gfVSbTO
         MJv/wJzO/jQ7Kdcxmde4Pb9pySSflIuFcgkUN32tfKWGxoR+Pm6mK6F5SJkvChQwYmRp
         iBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726808; x=1712331608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN31wd2vCkiTGMz1OBtEaB4JW8VyiA1XbISlyEebr3E=;
        b=UZeXNTugUFF7ZLvxjcEC/t4b+REmywz0B1oaHxSC/FPLuIS2hcg1pnvyr0iY283ORN
         J5yEbOt82e+srx1WEoeZxx18mHADhxIVjqxIVbQNtO4YiNF84vQOwZMaHanx1QVhiyzi
         30wGweoNPXMcu+4ZWuBv3tB2/AoFu/tSpvKnPAWTc7R6lGG+QXfoQhPIQ7qjxKDGkZ/v
         ZJQajuGvmLhkcxFBNd/VvXMN8OomN4lQ8AYg3AZRV7z5QGBJz9SzBiYDR89eJ0i3NxkZ
         b5QdJT8wzr3pwABneBZST1fjtCVvHVrB0uBTt6LeVO0XZJ6PaIXbQAQEZLISaKtvJJrU
         M9VA==
X-Forwarded-Encrypted: i=1; AJvYcCVJOnvfqDstoGNWqya9c2CpvRlfeBuOGCz4oaW4BjNSstCi+JbsgNWSWKPkJTvDezGHP1l1yt3hbnjRuFMnFnP+ODAPa9B0KTgUzCTR4wBP509TYdlj1Yoc63C0gBx0PyATOTXRoU50jgTOCW5LOyzh02XO+PpOPZrzO6aKzu2WEDkkG11VeaYfUts4cuOCmJsj3BdXu8Ah9dTKuzXBAT0pXxXfErO3rzYezy4btqFL9YZzGWecZIDTEK13C8CLPsUfnn+9dXWOLXiWYAyrOYsmXUR2uml0icj4IJpVvUdrtlcQ8t8eBsSlQqEEb3VDGg==
X-Gm-Message-State: AOJu0Yzacj+0ODnB61m4DFEwTd9U4g+aPd/faEYvzFALoBq7a3kkjEky
	RWWg6gr0dcatrVIFarTUu05/TalspZjQ1+zHRsDZleqZmcPuyvLR
X-Google-Smtp-Source: AGHT+IF0O7HII5MYlv2g0E+BHBSm5qRGKAR+0KxI+xwk6+g8c7fXn65jtKX0C7ci+tZdnr/ge20LGw==
X-Received: by 2002:a05:6a20:3c90:b0:1a5:6bfb:76de with SMTP id b16-20020a056a203c9000b001a56bfb76demr2694088pzj.2.1711726808383;
        Fri, 29 Mar 2024 08:40:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b001dd578121d4sm3581907plx.204.2024.03.29.08.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:40:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 29 Mar 2024 08:40:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Simon Horman <horms@kernel.org>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH v2 12/14] sh: Add support for suppressing warning
 backtraces
Message-ID: <d7663e19-74d5-478d-becc-0a080075e7d6@roeck-us.net>
References: <20240325175248.1499046-1-linux@roeck-us.net>
 <20240325175248.1499046-13-linux@roeck-us.net>
 <20240327144431.GL403975@kernel.org>
 <320aacc6-b7e5-4c3d-948e-d0743ab26c5d@roeck-us.net>
 <20240327193920.GV403975@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327193920.GV403975@kernel.org>

On Wed, Mar 27, 2024 at 07:39:20PM +0000, Simon Horman wrote:
[ ... ]
> > > 
> > > Hi Guenter,
> > > 
> > > a minor nit from my side: this change results in a Kernel doc warning.
> > > 
> > >       .../bug.h:29: warning: expecting prototype for _EMIT_BUG_ENTRY(). Prototype was for HAVE_BUG_FUNCTION() instead
> > > 
> > > Perhaps either the new code should be placed above the Kernel doc,
> > > or scripts/kernel-doc should be enhanced?
> > > 
> > 
> > Thanks a lot for the feedback.
> > 
> > The definition block needs to be inside CONFIG_DEBUG_BUGVERBOSE,
> > so it would be a bit odd to move it above the documentation
> > just to make kerneldoc happy. I am not really sure that to do
> > about it.
> 
> FWIIW, I agree that would be odd.
> But perhaps the #ifdef could also move above the Kernel doc?
> Maybe not a great idea, but the best one I've had so far.
> 

I did that for the next version of the patch series. It is a bit more
clumsy, so I left it as separate patch on top of this patch. I'd
still like to get input from others before making the change final.

Thanks,
Guenter

