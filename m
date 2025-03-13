Return-Path: <linux-arch+bounces-10745-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9875BA5FD89
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 18:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E243BFEF5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E11C84D6;
	Thu, 13 Mar 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhTFLr4N"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A51C84B6;
	Thu, 13 Mar 2025 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886274; cv=none; b=fKJSZ6/2AVafjsbjyfFzHUIiXnT3vGUgJxdkhxmZoikwgcNmOefpGCYi9HmzbAi+e1hozIB6fe5YDE0+U3Rt2qJ8EgtJlmo0XdW+Tm/9fNngVjxFIM56ifRRPfDrAys7E8l1w0rRi31f5Zt+VeZcCtqP7ftCSBEA+fy12OTz3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886274; c=relaxed/simple;
	bh=x0LfkQleJqSHMA533kQRyLGRE1i8J4My1tYGLUMBafM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s46NQJmBUJrAoCHH8uN9dQC5Aj3SY7nvK9A9Jc+LN8Qw8oeQdkHQLqdQRMgUEN3dw3KYOVcsLJBi26nhVgIkGfD5A3Ah29BxwB9/4kWABBVWwrg47ExqorbsABA/96Mw+qEbVltMVCvIT+4zKxnTPjw4kAZ1pJsniws+QgNRDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhTFLr4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B49C4CEDD;
	Thu, 13 Mar 2025 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886273;
	bh=x0LfkQleJqSHMA533kQRyLGRE1i8J4My1tYGLUMBafM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhTFLr4Ne31b8oAE7DB2okHcYLVlBcnDz2KSrPKq1bfOx08KKvfQUKkz2kqBNLt+0
	 xw3//f+ZmNusDqD2VQBDKVCc3lyNPNEs5As0GOPaIVU1Ah/TZxqftpzBqyXiJ6mGWw
	 VFhByLIf+c59MrlA490XOy0OsI/yo4JLrbIlzCMsFpZ3TCBbX5gDNiLYFncPtZpG3t
	 3Qe9HprMHPXdSpkXMgzk+Q/NGNhxWaNpEmnncCuhAvrKLixU6mFCOyI8uraA/Ad1zg
	 iQv5JxHRFlgGk3ftlAa2yRpOZzP3Ki0G1sjN+LwlMaOTOFRw8vBx25mR/0rs8VIY8+
	 nJFrVge5guncg==
Date: Thu, 13 Mar 2025 10:17:49 -0700
From: Kees Cook <kees@kernel.org>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
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
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v4 00/14] Add support for suppressing warning backtraces
Message-ID: <202503131016.5DCEAEC945@keescook>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>

On Thu, Mar 13, 2025 at 11:43:15AM +0000, Alessandro Carminati wrote:
> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.

Thanks for picking this series back up! I honestly thought this had
already landed. :)

> With CONFIG_KUNIT enabled, image size increase with this series applied is
> approximately 1%. The image size increase (and with it the functionality
> introduced by this series) can be avoided by disabling
> CONFIG_KUNIT_SUPPRESS_BACKTRACE.

Yeah, as with my prior review, I'm a fan of this. It makes a bunch of my
very noisy tests much easier to deal with.

-Kees

-- 
Kees Cook

