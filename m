Return-Path: <linux-arch+bounces-4159-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A358BA688
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 07:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5149EB21E26
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 05:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DF1139587;
	Fri,  3 May 2024 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lTewYTs2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77C13957E;
	Fri,  3 May 2024 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713155; cv=none; b=QvC+lkSfZDnVFIfk881Ej55RqpBIvWnQa7SBpXhfaQg4+jnf0qDMeowq10VNoju2uorimdP7aVyTYbEvSklo8PEU8JmAN/l3cWRYJWgAtonjJns2/j9640SYcv7vz79zWl17VOykqQiNQwUGpGZpdvqkfyV3ItHAUvyAXXviAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713155; c=relaxed/simple;
	bh=CqoZyhOSCmBy0sZ5Gg/UYcDTxCfEHRO6AHxKHOGnjPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ubs0XyC5QWX3chSx560lx/9ejhnrSOG7QUPLzYwlXpecfT6e7Vf4ewDJsc97RXsB4XkmI2zOSl/rvu+g5Ce3QeXtp56SLc06L4EheE3NPco/zbreDRM0gdCqT7RTjMKdbLAQZ8+TV9xJKSL+iXSTxpc41KIY4Hv8GuruLSuRQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lTewYTs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243D6C116B1;
	Fri,  3 May 2024 05:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714713154;
	bh=CqoZyhOSCmBy0sZ5Gg/UYcDTxCfEHRO6AHxKHOGnjPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTewYTs2ryNk/sSYDnCRe/Ql77/NkLpuSu+2Ur4TLDXLvqGlanDBMa+SPV1o8dO8r
	 GFd/liBdixcYIlR4cQ8tnVhD8pHMBsepIf9u0tvIIJxkFV3QonP06Wdv7D7AokNqNx
	 of+GOzMAO3UyZ2WFxjGeKVHVbbJm4dcSFZi2xUlM=
Date: Fri, 3 May 2024 07:12:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	amd-gfx@lists.freedesktop.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-arch@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 9c6ecb3cb6e20c4fd7997047213ba0efcf9ada1a
Message-ID: <2024050342-slashing-froth-bcf9@gregkh>
References: <202405030439.AH8NR0Mg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405030439.AH8NR0Mg-lkp@intel.com>

Ok, I'm getting tired of seeing these for the USB portion of the tree,
so I went to look for:

On Fri, May 03, 2024 at 04:44:42AM +0800, kernel test robot wrote:
> |-- arc-randconfig-002-20240503
> |   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used

This warning (same for all arches), but can't seem to find it anywhere.

Any hints as to where it would be?

thanks,

greg k-h

