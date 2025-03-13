Return-Path: <linux-arch+bounces-10748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82079A5FF40
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 19:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11DA3B9A55
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237531DB154;
	Thu, 13 Mar 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dff/ayra"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0618952C;
	Thu, 13 Mar 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890676; cv=none; b=gHJBT816EVEx71dcW0OOvCdiwmD8akBAnBcdBHthaMLCgT0TeFwm0euGe24QoISo+vK3en+oAtxiPJhjk1WPpDpCT9L5Fm5qeB0R+MnG6C45IFtfwci0bt5LeZ3bv721G7UHGjNC2GV7+pR2OKHbHqZ1oux1zlN+vqhfitVQuUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890676; c=relaxed/simple;
	bh=R7IKmWAfEV6dguBunqVGGqHpFRfFDM8SuXUyyQU9jxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGlOWe324XwVpGMBJ6QFPV52UW2QfT7liW2i03E35dmYoDPRWY7X20f6GVSJ52DeggmO8muwDFHfvzIF+0Dy69vtLnVZTHmJ4AJQekAsJZg6Cec2tg14sWOEH2oWtxmRC+4qtbRSKwBrFyY9EmPqbGLqbSb5Dmwmcyn8Y7V5kjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dff/ayra; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403cbb47fso27007075ad.0;
        Thu, 13 Mar 2025 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890674; x=1742495474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jt5WSssG+OEvsuPkFz6BZY4vYElG8JeyaALVDa3jMX0=;
        b=dff/ayraWXwHg6p5rLQCltUtU/IfTflDLBIUaXJyRSlk57Wm1AbrhmRr0PVMVHsAha
         F6DE+WtNPHZmlLvyW4UBTt/OwjTVRTfc/qfQYrMa7G1j0bqwKSDr3Oe9tqpQnc8kxwvM
         4waY2BbSmxWMxRnCIoQ3z0ivEWTaflEeTCFelcpGiABIgRN9AkhJX/eCCu7iqQaXX6AG
         kdCqkplArE49svpeJReu9Lu4ZU+K6CSisnnSPrGDq8yjSqlGpV23bLX5dW4rE2NWRtD+
         n1FEjfguBv2IfUfnNJRXg90J5c0bUlpJagZPXeMCJM2b5DqEgRgRyuG0My9KSX3VeeWc
         UiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890674; x=1742495474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt5WSssG+OEvsuPkFz6BZY4vYElG8JeyaALVDa3jMX0=;
        b=rsowbsunLTIiH0jbdGJXsmR/MM5Q/AVzeCSpdSh4/jpGrN8GRTxFVh+WgqOXk8Q780
         rwfWNto0HMK75bRWaUx7bw6nmsUJVJ5rNFW7X2UckrYHuquVEyMuzgsk0ehDKgaBWiF6
         HpBAm1zwErZcI+XRRDLFeb5oRaMdQAvDS+nWteQv+yj1njzTYd5DmMrdqB25UF6Qs6wz
         rPKTBktnSzRi6HcKDw+D4I7XVCqnZWE07orBi5U/lKn1VBkr8Ga4DQTjOelziiPo146j
         eDN0/u+v6h/eYrSygHGFW83V2Rq1J1JWmhtXeUxGN5rEt9BB+bDgTfufpYkgI//uinBh
         3fqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUImNb7MkHMTBjXdvHNY0EXGH9BMGNHprXVAMf+gT/2CH2YmVyk7FfvloHZUPGZB8xslh/HvxTPBVQlThiLEGMg@vger.kernel.org, AJvYcCUrGnr29cMpHGmhE0ycHOK8AsKpsPiND074iCE3BEwyonEYY13ZiwONAiRaJj4f5nIuSNrYREuz5Z8=@vger.kernel.org, AJvYcCVR6mFPW43MtfhW4JyPt6klpjBFx4r87d7kUw/h/UeJ+uSFcNQagVWrDrvzGjqZfIOvQsTUABNtwMsTQxJU@vger.kernel.org, AJvYcCWVJvpdi+eLgH1Ofo9X62XKzUdfpnNPawnw1HQLvDeyGpQy1qpSNzX1ERvuqT8GXziKNq7b5WZptF2d@vger.kernel.org, AJvYcCXIj2oyBIvf4gWeufYtUtkRY3rJYeHDLGbq5dhA4GYi0U4Wme7Rj0pTuk7IcdmPHB5SVO/7NWS4HKOz1Q==@vger.kernel.org, AJvYcCXZdAn4kbT6LtpspRLSWF5Cwp9+T2p+5Nnh+wGKuCtAvrWqtQW0WluD1qNyhPsZx6m0LD4OG24uSljh0fT8@vger.kernel.org, AJvYcCXn6PaI1SVup/bV48s5z7r5XVsONOs76go4Ay35TXDZ6lQVm//S4M6GV03JOCv+3YtOZF+BZHhzmWHm@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWnl5NeA0GSRt7wB2hnzRQn8F9Zr7+ZOw2Jgs/n2JC0Pit5wy
	l1sVjprXJFVcVKbhe3rVo75iV1qiIx/6AQrrmwcW/yf2dS9RN7TJ
X-Gm-Gg: ASbGncuu5XTUUEkl3CP5/txGMxGJs6XxxLXABNaLqRFgw0sZVZcxq2Lz6rmEIlTQ2Q+
	/st1MO6SuW59FwxeRWSgpWcJeqoQqS//Zl6+kaR2Uy998yUXV2cmvgWFUEfuxvsGQp0ovCcDv5f
	t+nAok/Vk9NKIlIaos+0bL51SNlEiyu30FGlCl1HFDv+jqtgg7Qvh2tucIz8r8qCAZvmol+y+NB
	/DodUZ82F36+9nPPeboERoRE5yZ85eXBEDfpD+QmeMzvXE5xtwfL/vsQc6uF53nbZsjIUS9Nvyw
	Az2k56nCjzOT+/Y3Po1Ct6uBxqT9RDj+QkG4nJWgw5m8wBH1g+fD+Kw5qA==
X-Google-Smtp-Source: AGHT+IHUyL3JZBiKaHL1hLSTeQrgywlLwwEUN5of1N0Gy8TC0X3IRTq509SX5+fcaAZt7Xsc6jRvwQ==
X-Received: by 2002:a17:902:d48f:b0:220:fb23:48df with SMTP id d9443c01a7336-225dd8ed442mr5472005ad.36.1741890673680;
        Thu, 13 Mar 2025 11:31:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3011926599csm4185647a91.35.2025.03.13.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:31:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 13 Mar 2025 11:31:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maxime Ripard <mripard@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v4 00/14] Add support for suppressing warning backtraces
Message-ID: <c8287bde-fa1c-4113-af22-4701d40d386e@roeck-us.net>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <202503131016.5DCEAEC945@keescook>
 <20250313-abiding-vivid-robin-159dfa@houat>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-abiding-vivid-robin-159dfa@houat>

On Thu, Mar 13, 2025 at 06:24:25PM +0100, Maxime Ripard wrote:
> > 
> > Yeah, as with my prior review, I'm a fan of this. It makes a bunch of my
> > very noisy tests much easier to deal with.
> 
> And for the record, we're also affected by this in DRM and would very
> much like to get it merged in one shape or another.
> 

I was unable to get maintainers of major architectures interested enough
to provide feedback, and did not see a path forward. Maybe Alessandro
has more success than me.

Guenter

