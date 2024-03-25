Return-Path: <linux-arch+bounces-3174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2B88AFD7
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 20:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BBA345B08
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6F71B95B;
	Mon, 25 Mar 2024 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2GIPcWj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE51946C;
	Mon, 25 Mar 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394685; cv=none; b=unkn2fX76BRsSjVl3mfXMcL+IETbMYwXFH4lsU4xKZrr4/QnetbM9k6midWUo+NFSS9brc07bZQqKPVnS1oOceioPFruQ3V9CwvEaOrEaxfrGZOkzIBXaPTu72sq5G2WNLDuBrq65Ng+o0WurMUt3PWxvGi035cTiFbpEr3bK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394685; c=relaxed/simple;
	bh=TkGuL+w7G+3t6UUem74ucq9Zu8Hv0WBY2IBJlQ7xZQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEI9kccaAzouUrU/fbFbh0x2blCh+FJUS9EYj/WLgu51ksfTYBxH+n/w0AU5ZQPE+eSuLCpvU4SNInVSfLTJXgMNdVLNHX7nDF/LkdeaBzGTPQxae7DyN+/p3+OWwZXPm4RFkJwdfLILyfdTVfWolqWicFN+4icIAx4sx9vxzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2GIPcWj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2943607a12.0;
        Mon, 25 Mar 2024 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711394683; x=1711999483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8SlcQVDmaEWiOte6mDmefSXrzEKVOFtuPmb7V2Kzic=;
        b=g2GIPcWjYhY/TKBekNp9G3RH5zQW7HWUWyWjU4a3NA2BwZXYGkWMZyla6Wf2JfAzKb
         sOtkpvEqQWhnzvSloidpzBmsOg1T4T/oVm4/JZorkq0Ublr1neanl0p5cZEqWmEjkgKm
         DxYu27nZx63MzMH4zEOnk0ocQ3jyGfMyWiuRBCR7WhEKp3WEJYRYJAJyX5FvrkNEVZKD
         GrUNZOCBCOWk1aRCW8jtTi+HAMdFCCHxHF+f0pMOqcs6q4S8dSJg8piRQSaycYHfgN1u
         fDzuTBAS1FmQx2bxKD9LfP/dFBiFMtfG3WFNXGB8MjhVkbYvxyUkh8fSR8pN7PfmxVUP
         Ms+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394683; x=1711999483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8SlcQVDmaEWiOte6mDmefSXrzEKVOFtuPmb7V2Kzic=;
        b=T6nS/EGiTlpRiWfsOHFs/2J2DIm14wqkdhHh/IPKGKXCXs1Odogds9Af0QdDbrD2JF
         pc31kz7YSBpsZfoTQ3GtO4EkTx6uS/0/ITaZUFsJ/B1BmBnyFtJ2oiaxxDtH3bd8eqJ6
         8kfE6GNbU+FK2hmRpLZPzG+XrFlHwMWlRpHW6PKxaWPSrsg505aYPprL3zXRIsAawiN8
         BRHOk8pyCW0sbxOQuG1E7U9/MOo8aUDH4eow9e1yHnDzOCXUo5cJPEZacDRrO8mDJKBL
         5jj+nxOsRSNnCodxYHYXoE6wUrEvCENvceBZjWkBPBqy0Jaj16Q8u1XFH0HxcGAVS9HL
         o0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXMy/W6KhwZlJyibe2OWrqOcpOBJzHsiL2ZFW8elCXMrf1qkNEiqJq++TcL0E/wqPtW3flV3bmmoSN6Zk5iQDejpNIr/4Uy/JWKK95c8ZRFtCQpGBuhnhHr9bp2jDi/19j1RRBT5vLX2qim1iNkdhGFZ3L0jaK6Tay4QuUOSR9JlHuOVX5qRkeHg3xAFlbytamlXSXBG7jzWFapYI1039vgSgsGt0TtvXmTBoOYIik53pLrBHGxVR+RuIOu+vc3FNcrAAIIsH2YzPErQKmrX1QxeUnqrU4iXCAr5vcsfQA9OEqQYf+vgWp/L23fnWnMJg==
X-Gm-Message-State: AOJu0YxEp602xXjjpoxl8bSxu0JSd33jAmTr0DefPzeT8QPqG36LVK+8
	pTQGOPdkUUa00fXuoL+ypps9ZVUHM7hCs0oweuMUs3kUx6d2jyLI
X-Google-Smtp-Source: AGHT+IFwrImv53xAJXZaDSLJtn5nAAXYRWdj5wAShxC6nIYkDeejlGCGK79rEKa0DnGROBP9wWQclw==
X-Received: by 2002:a17:90b:3d8:b0:29b:a345:620a with SMTP id go24-20020a17090b03d800b0029ba345620amr10896738pjb.20.1711394683229;
        Mon, 25 Mar 2024 12:24:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a304700b0029bf9969afbsm10113710pjl.53.2024.03.25.12.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:24:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Mar 2024 12:24:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v2 05/14] drm: Suppress intentional warning backtraces in
 scaling unit tests
Message-ID: <e880828b-552e-488e-9f31-3989bec276ae@roeck-us.net>
References: <20240325175248.1499046-1-linux@roeck-us.net>
 <20240325175248.1499046-6-linux@roeck-us.net>
 <0729b218-53f1-4139-b165-a324794a9abd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0729b218-53f1-4139-b165-a324794a9abd@igalia.com>

Hi,

On Mon, Mar 25, 2024 at 04:05:06PM -0300, Maíra Canal wrote:
> Hi Guenter,
> 
> On 3/25/24 14:52, Guenter Roeck wrote:
> > The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
> > intentionally trigger warning backtraces by providing bad parameters to
> > the tested functions. What is tested is the return value, not the existence
> > of a warning backtrace. Suppress the backtraces to avoid clogging the
> > kernel log.
> > 
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > - Rebased to v6.9-rc1
> > - Added Tested-by:, Acked-by:, and Reviewed-by: tags
> > 
> >   drivers/gpu/drm/tests/drm_rect_test.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
> > index 76332cd2ead8..75614cb4deb5 100644
> > --- a/drivers/gpu/drm/tests/drm_rect_test.c
> > +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> > @@ -406,22 +406,28 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
> >   static void drm_test_rect_calc_hscale(struct kunit *test)
> >   {
> > +	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
> >   	const struct drm_rect_scale_case *params = test->param_value;
> >   	int scaling_factor;
> > +	START_SUPPRESSED_WARNING(drm_calc_scale);
> 
> I'm not sure if it is not that obvious only to me, but it would be nice
> to have a comment here, remembering that we provide bad parameters in
> some test cases.

Sure. Something like this ?

        /*
         * drm_rect_calc_hscale() generates a warning backtrace whenever bad
         * parameters are passed to it. This affects all unit tests with an
         * error code in expected_scaling_factor.
         */

Thanks,
Guenter

