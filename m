Return-Path: <linux-arch+bounces-10752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC922A603E3
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 23:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33047421902
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682951F5853;
	Thu, 13 Mar 2025 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vNslcPvd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD41F461C;
	Thu, 13 Mar 2025 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903507; cv=none; b=ncaL53BSyPj3adE7I3N0RsDA23UNBeWRjb4XthZpJJqyQHaJfdDe1I7gwT8mW0EI9RB3pQzcQ9zjQKxePULdDVMZNfbPmL5dqRpQI5OPj+GZ4kLmIEX+idLGPTgTs7bwcC56GcsXKaI5HCx8GBVLENf/nZeKgua0AyLwrILVdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903507; c=relaxed/simple;
	bh=GxNzFgXlCVEFcpDf3VLptEglWoUTczleCr4VuzyQIr4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bM6b1vDwiwZCyuulZaq9A3/GVreeojBgyeGdU3lhESOmjWp57ZfnL6/C9N0J2hvd3q6ar9I0EDctkbMkFdPntl7rNUtLkENKiY//qb69xdws1tgM7QGQafGP5WM1eOuXSA3GlvlG50nt6Rgv4fXiC14j2WCMHL1hoSbsZ+uQee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vNslcPvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6615C4CEE5;
	Thu, 13 Mar 2025 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741903506;
	bh=GxNzFgXlCVEFcpDf3VLptEglWoUTczleCr4VuzyQIr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vNslcPvdVPNB7E9fplso2uwQWydxF0LuafyC8Ekj6LJ17WeoKPzAu1lWUeLyq4wyx
	 YSG2VtnirdV4PAoDW58QNKBURHFBXAkymAmOjx0cdlO9qH75IKZQbVpmmhcAjZ7EP7
	 0n/ABlCGS0sNpOunuAQvLiC/vVhLZ4IVMsVmABVs=
Date: Thu, 13 Mar 2025 15:05:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Maxime Ripard <mripard@kernel.org>, Kees Cook <kees@kernel.org>,
 Alessandro Carminati <acarmina@redhat.com>,
 linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, Arnd
 Bergmann <arnd@arndb.de>, =?ISO-8859-1?Q?Ma=EDra?= Canal
 <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>, Daniel Diaz
 <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, Arthur Grillo
 <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, Alessandro Carminati
 <alessandro.carminati@gmail.com>, Jani Nikula <jani.nikula@intel.com>,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v4 00/14] Add support for suppressing warning backtraces
Message-Id: <20250313150505.cf1568bf7197a52a8ab302e6@linux-foundation.org>
In-Reply-To: <c8287bde-fa1c-4113-af22-4701d40d386e@roeck-us.net>
References: <20250313114329.284104-1-acarmina@redhat.com>
	<202503131016.5DCEAEC945@keescook>
	<20250313-abiding-vivid-robin-159dfa@houat>
	<c8287bde-fa1c-4113-af22-4701d40d386e@roeck-us.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 11:31:12 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Mar 13, 2025 at 06:24:25PM +0100, Maxime Ripard wrote:
> > > 
> > > Yeah, as with my prior review, I'm a fan of this. It makes a bunch of my
> > > very noisy tests much easier to deal with.
> > 
> > And for the record, we're also affected by this in DRM and would very
> > much like to get it merged in one shape or another.
> > 
> 
> I was unable to get maintainers of major architectures interested enough
> to provide feedback, and did not see a path forward. Maybe Alessandro
> has more success than me.

I'll put them into mm.git, to advance things a bit.

If someone wants to merge via a different tree, please speak up.

Hopefully the various arch maintainers will review at least their parts
of the series.


