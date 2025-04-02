Return-Path: <linux-arch+bounces-11212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F6A786DB
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 05:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D67416E44B
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 03:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6122FF4D;
	Wed,  2 Apr 2025 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDBAg03k"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A7F4E2;
	Wed,  2 Apr 2025 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743565370; cv=none; b=aUZt7MoaGBGwk8NGq1JzYYlfUtJ96guGUjFZObFYpCPI1Tsx1+6RJTjGoYBHgyhDENjPHu9b/KQ7vbvD4tUcJMkOeJ/0tWQ83muErXDPCGN/vo6Wz5oLuuG9DX2TE2lFAueuqTCF5W5/vUwBLcv+QfYA0d5cc3+jS6YsgHIYxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743565370; c=relaxed/simple;
	bh=V2e2nwSbZeY0394xlWvihWRW0KwuglxPVjbYt+qSt5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW8FbG3fkJLMgLb8iEBHvZANnxlRnQ0Piqqu4Smpr2WospfMV7wf7QC/1ImkDUZ/NCpaZlCkZah3JSv4m8FcFGv9v4KNy1LlFIalwsPcwea4hVef1giF9/xmJim8z20DmCCiS1n1+CnPb23l038Qns9IGjATmaD9l9UgL6prr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XDBAg03k; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CfNMzRI2XDl7ZbVtkTrjOHHTHVANpEi1cK2v4Rcq0rE=; b=XDBAg03ked4nw0XHPZ98s4MHCr
	Ngz2X2G0KIo+tVsx3cIPzSXYRGF7UAsIAhPSbWFW7whz1EHcIGCEUSiqzrHipcuK2MzsEBxm9ibCD
	1oPbYB60JlPeYk32G62MstD4ZaF5SgPWbKWf57Skmm2Em2Ugu86zZ6k9a5mJumWe/6EtyiFl+KnnB
	4+BRuiXis6eEZtIlzwNNBYc0ciGHpqRukQybsokVYyrmf90atCAXtfkbn5ZDc81C7+m8tO++2paV4
	OU0wJbeiq47WbpnvfvBEc4vsOohzMCS3BY2+LXJlzJ7DmnuNghrl3E7MXmZaT8aFC+klWYC4JA+uT
	+hSuWttA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzp00-00000006xAn-3emH;
	Wed, 02 Apr 2025 03:42:45 +0000
Message-ID: <2c1cbb51-cc16-4292-ad30-482d93935d91@infradead.org>
Date: Tue, 1 Apr 2025 20:42:41 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] lib/crc: remove unnecessary prompt for CONFIG_CRC32
 and drop 'default y'
To: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250401221600.24878-1-ebiggers@kernel.org>
 <20250401221600.24878-2-ebiggers@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250401221600.24878-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi 

On 4/1/25 3:15 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> All modules that need CONFIG_CRC32 already select it, so there is no
> need to bother users about the option, nor to default it to y.
> 

My memory from 10-20 years ago could be foggy, but ISTR that someone made at least
CRC16 and CRC32 user-selectable in order to support out-of-tree modules...
FWIW.
But they would not need to be default y.


> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/sh/configs/edosk7705_defconfig        | 1 -
>  arch/sh/configs/kfr2r09-romimage_defconfig | 1 -
>  arch/sh/configs/sh7724_generic_defconfig   | 1 -
>  arch/sh/configs/sh7770_generic_defconfig   | 1 -
>  lib/Kconfig                                | 8 +-------
>  5 files changed, 1 insertion(+), 11 deletions(-)
> 

-- 
~Randy


