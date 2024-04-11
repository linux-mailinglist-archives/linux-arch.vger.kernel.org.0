Return-Path: <linux-arch+bounces-3564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C68A18A8
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E812862DA
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383022942A;
	Thu, 11 Apr 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5YRkVIs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C141175A5
	for <linux-arch@vger.kernel.org>; Thu, 11 Apr 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849142; cv=none; b=qSLVjLNNoSwKu8cHpYcExrTq7ngvj7x40Bnml+Xxt7LaIJpq5Zt5yAyh6+9TeOdYiGEqJeeV3Nx+JwQItdjcGJqgiuVN1Yrx8I3y9w2QLhsPAuRlNypFIGVtDHZYID81JTJ4Rk8Gzr2GLlqetdAXKvqHwCqDiVNmLWKQPjTu3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849142; c=relaxed/simple;
	bh=S0tSkli8JleHY8iE9O2afY6bV3mjLC/eVHPCMEho8Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsk8dbQetVKEZBqNSFDZFsL+Gt03+iASl0FOywurA2Q9YqqIyJN0YtvnW4OBe6k5Rc5EHAmIxjR+P11an5li0ZD1eu3KWmhvNcf1LpOY9/DWY6/1/sTSqmgvxkMoXuyACWxym+ujcVM/UjI1pDwa7CXIq1qxI4CSLqY+ldHH09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U5YRkVIs; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4715991c32so1055888066b.1
        for <linux-arch@vger.kernel.org>; Thu, 11 Apr 2024 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712849138; x=1713453938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=U5YRkVIsfjsdxYrqviqFldW3aGgJpxI95Xx9WtuZtRE4oGNUou/5vryJRC9Fm9mbWI
         0oW0BHPWPWBNjOdKKZtlJlPuSTA7JCxqdpogQMFdoBWF1OD3kPk3rs7hdHqbvgvZDg0g
         FPiIFMNvhw/PbASOX8xkWBMy8iKmqHbZbXdnniQgC1etonGUdgwPRRGtUD4z+eu6vlgb
         Hnq5Ee+6VznM1khG44NboOAIt8kYqj5Q2zDb+onyXfL4pNnVpUZMlB7sfzDCSNFLZ1Ss
         C8s8Fb2FJ1eVCLip9agNb+b1Vd0rUZFWc6akd2nrOheBpdsw0oUWp/Fy5ElLUlEqV/k0
         LcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849138; x=1713453938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=LybAgCyVo4MXbUi/mFDn1PsYWPIdNk1ewkjoLO/cdJPH4K6rgFyPIhHABM71peykED
         9ItsXZgiybNarMhAVVGKWssYmEXokol3douBNFLTfKivc+Dktu/ao3QgqRG66027fuFh
         c0BIAMuGlQdAkifog+WT6YehpgVYiB3Xol2n9dRqt3A/LDL4N/agdnOh9+r0K9L6OXxA
         p84dldWMTNoMr+0g3QSwuacIssdTaUUPvNbem6em6lrTZH5plDBGEFJ3WmGr4duATnbT
         ahNSAV+bXZp7yKVxvbvXBO+usBzC9aJRCCuLl031qtiZugvugZbnIIHD/yOvFXn46iv6
         mPIw==
X-Forwarded-Encrypted: i=1; AJvYcCX977XuVIBI9hrlzuH6MxmFoa5+HHyf5uHdGupVeCKSgyX04PAavTy1ztFSJVCAwRkJA/FnRYrqrTOoLOy/qtS3VVfXnNPsz4al/g==
X-Gm-Message-State: AOJu0YzcGZ8HRu4pIEsiqmsSgXBrYTRxIX7xMf31QyFqM4HfqvK8MKPf
	TlVQ0WCrLj9ihbWxa501n0Lxr9sK5FStjV6Tt2HgP83i7t4BdRSVz9VztjaiGHs=
X-Google-Smtp-Source: AGHT+IEEewk7llSPmgrxe/7mA2rySV/OUDonUpYE2d0l2M0z39pI2HKiyjdOd8AbAw/PCbmxmW//Bg==
X-Received: by 2002:a17:906:4f06:b0:a52:3d1:6769 with SMTP id t6-20020a1709064f0600b00a5203d16769mr44591eju.14.1712849137563;
        Thu, 11 Apr 2024 08:25:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906350300b00a522c69f28asm225076eja.216.2024.04.11.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:25:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 18:25:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	speakup@linux-speakup.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-afs@lists.infradead.org, ecryptfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-arch@vger.kernel.org,
	io-uring@vger.kernel.org, cocci@inria.fr,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] treewide: Fix common grammar mistake "the the"
Message-ID: <0bd7ccc2-4d8c-455b-a6c2-972ebe1fcb08@moroto.mountain>
References: <20240411150437.496153-4-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411150437.496153-4-thorsten.blum@toblux.com>

On Thu, Apr 11, 2024 at 05:04:40PM +0200, Thorsten Blum wrote:
> Use `find . -type f -exec sed -i 's/\<the the\>/the/g' {} +` to find all
> occurrences of "the the" and replace them with a single "the".
> 
> Changes only comments and documentation - no code changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---

It's tricky to know which tree a patch like this would go through.  We
used to have a trivial tree for this stuff but I guess that didn't work.
It's possible that it could go through linux-doc, but probably it has to
go as a set of patches through each of the trees in the CC list.

regards,
dan carpenter


