Return-Path: <linux-arch+bounces-1873-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D55843406
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 03:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A361C24947
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 02:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B91DF61;
	Wed, 31 Jan 2024 02:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="T+7vMyUI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921CE574
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 02:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668694; cv=none; b=Y/Om70Q8aOtqqRsD6kmVNbVjDBzyOUo/2idkrw0lbZiWDdoumLQgKiblDHzOpms3zByROB3WNEhG45C1K90xkpdXgaWJa7ALqWCeK4Pph54K2yx8geqG9Qb7tx+Htbe5NRF8UV0iozu3CvY6VxQyP+OcEyEPmRJjqqOATxQQx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668694; c=relaxed/simple;
	bh=21EOOfDX3QJoscC3qTFj1I2tpuBsaPAwtHgQo7BYlrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLPtD9uGBvjE5kdB9tFs4PzUZWbHO3iyEhe10nQzc3qZDKCSFuOf9IJ4ROXGVHFxjDiDYmjXkQfioZ0Nr53lKd/692zG4nmqTBC84vA+IGExclizJYHLHtrPrzYFwrKivJKgfxtOKaOtw9TAFoTlB9eqNqLMoFjRXLX13ddPWJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=T+7vMyUI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so2836477a12.1
        for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 18:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706668692; x=1707273492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N09f6sJYKv0DgOi8MMLVMh039rU6+gfv4wN0Iyy6R6U=;
        b=T+7vMyUIekK+cUz7XMlUFvbCCVjJleYNMUkn8aBSOLTx3BQ52R+7u9PwnmerOieDGU
         tPxAFx7w79H2e3MxtCGNNCVd2mQmuaYmyihYrWqZvri/5CtgQDUFP5lNjfE8gI/nfCrT
         4GFdQTQLh8kKTQMJjmdXghWJYv1kbl5bdG0A81RKsiZZjwGrPyX73Ql3mguDw2b6SpNm
         LEwvJr28f1MoMWtbRklgbsJk7jwr9m/f56xPZ8ZK/+BSrEwWLrFudVef0E2zRBc2UQUV
         0Gmacbrb7SFAqzZ/+2yANTbFb6oYTwk8Hmf5PFkXeCo+sy5ueNNc4COTjkF8OprEwf04
         ESWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706668692; x=1707273492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N09f6sJYKv0DgOi8MMLVMh039rU6+gfv4wN0Iyy6R6U=;
        b=lHHvgE7YNHh8zMg4J44/jAh4Kv990TFvurkYgdmIKN0EiFIaNDO869On78YwKtkMUw
         y6AJkfpnHMjjKzKBFgFPSFnHe9eUFXl3CgjqtOelZQuR2cdpJWC/pPxVezhjO7bHO3bV
         Fbg6zlf37Iapt0YMv0y5QBu8Ey5FEWxth+pNfzBiexWfFBbg8gJsJ+sBe0v0leWg3Qsa
         S3+uNrLCJSBe0+xn9G+7iIIV252E585dn9zmKa7PH8lgTCe0ahktlMfBI0fPmJgZiv42
         AK0wfDvpN3HB0uLdWW2pfSaW8mVssV8hc8YrI+Mz3nLSY4rwqsSP4p5Gxwj3uWAXzF6I
         VBuA==
X-Gm-Message-State: AOJu0YwDQ379d4m/nycaRDMYXpq7TmFb6WPXvE7G59bi1ctM+qvSWoLY
	Hs8BMZ9z+VJrch2hedSLcSTK4TzzYcjRDzMbcTtjsW5zz2PQucvPEEY0S3o7qEqtmSyUZLpQU2s
	V
X-Google-Smtp-Source: AGHT+IF3nqKBEWVvci4SEZHcSu5GXkVElPYZJQUjCfKrIEylC/tWBpIZMu1aOQe1t168W5NNY8DKnw==
X-Received: by 2002:a17:902:ea0a:b0:1d7:199:cfc5 with SMTP id s10-20020a170902ea0a00b001d70199cfc5mr484297plg.117.1706668692197;
        Tue, 30 Jan 2024 18:38:12 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d88400b001d706e373a9sm7935517plz.292.2024.01.30.18.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 18:38:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rV0UL-00HZeK-17;
	Wed, 31 Jan 2024 13:38:09 +1100
Date: Wed, 31 Jan 2024 13:38:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/8] dax: Introduce dax_is_supported()
Message-ID: <ZbmykQpcllC/LY6J@dread.disaster.area>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
 <20240130165255.212591-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130165255.212591-2-mathieu.desnoyers@efficios.com>

On Tue, Jan 30, 2024 at 11:52:48AM -0500, Mathieu Desnoyers wrote:
> Introduce a new dax_is_supported() static inline to check whether the
> architecture supports DAX.
> 
> This replaces the following fs/Kconfig:FS_DAX dependency:
> 
>   depends on !(ARM || MIPS || SPARC)
> 
> This is done in preparation for its use by each filesystem supporting
> the dax mount option to validate whether dax is indeed supported.
> 
> This is done in preparation for using dcache_is_aliasing() in a
> following change which will properly support architectures which detect
> dcache aliasing at runtime.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: nvdimm@lists.linux.dev
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/Kconfig          |  1 -
>  include/linux/dax.h | 10 ++++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 42837617a55b..e5efdb3b276b 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -56,7 +56,6 @@ endif # BLOCK
>  config FS_DAX
>  	bool "File system based Direct Access (DAX) support"
>  	depends on MMU
> -	depends on !(ARM || MIPS || SPARC)
>  	depends on ZONE_DEVICE || FS_DAX_LIMITED
>  	select FS_IOMAP
>  	select DAX
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b463502b16e1..cfc8cd4a3eae 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -78,6 +78,12 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  		return false;
>  	return dax_synchronous(dax_dev);
>  }
> +static inline bool dax_is_supported(void)
> +{
> +	return !IS_ENABLED(CONFIG_ARM) &&
> +	       !IS_ENABLED(CONFIG_MIPS) &&
> +	       !IS_ENABLED(CONFIG_SPARC);
> +}

Uh, ok. Now I see what dax_is_supported() does.

I think this should be folded into fs_dax_get_by_bdev(), which
currently returns NULL if CONFIG_FS_DAX=n and so should be cahnged
to return NULL if any of these platform configs is enabled.

Then I don't think you need to change a single line of filesystem
code - they'll all just do what they do now if the block device
doesn't support DAX....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

