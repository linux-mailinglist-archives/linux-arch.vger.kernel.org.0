Return-Path: <linux-arch+bounces-10361-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17695A442E1
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4564175740
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626426A0DE;
	Tue, 25 Feb 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fJ2lbiyl"
X-Original-To: linux-arch@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04E267B9D;
	Tue, 25 Feb 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494027; cv=none; b=sGfLS+cmgIuvLMRvPB6roagFO84uFhTIg3/i9H80jQnAMLBQm5E60IkRqnzio+uGPbjG9qROAPpsvw1Fgl0SLOkv9mKdWfyhiziTAaC5vnsAUNszeIlynTgxuNQ9VgC1ecvcJWpg3QI35IQjH40g7M1lx9gjUDIsv1nd+YNE2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494027; c=relaxed/simple;
	bh=dd0Lvu9vWtwP6hlte0aze2JQWGVV9KkpYgCO1cFK9G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rp0nPGQFiQ1U86ZkUzdGSDMrJIaBTvQSSYaSfFoUlCme+SErHiTnvq9lnYA/UEFd7SfgCiMpNlgz84FJUlOOOCvWj6u0D6n/h9YxZqdHM1bQYSWiXP28OrvTH0cbNSOsmSsXi+c6j/Zyl1mhR6BGGQr7yJVMeDq63CSKA6EXxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fJ2lbiyl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 34F2548EC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740494025; bh=8knubZjmHbdNkHXs0YlcIjXdMA+wkzMRlO4Ystvh0HU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fJ2lbiyl+z6/FsuYjWGBrBwIHkHmPy7ibREYGbz9UuV60mZK4BNRPz1Lgo1WVIQq9
	 19Pyfw84KfLZbaLggWDVZckJRO0sTWXEuxMWGK/vRLwccHhnuPIEMv+F4plDw7aAOs
	 EEUTstgDy3GFZmy/C42fY5fJblcGTbg6wcMyMN+JoyKm07/XT0VeDpHSiigRISWYq1
	 QlgCJhHwSQmGRo5wubqAAvQQlu4DfljzHFRWHd9Rv7sQOaMY88EWvAr8voOPs0i80p
	 DFzYgP9CZkY+KrfT78qIcNx4/anbyvEOUeYpkLtAOKdcTieCzVFai/+NUGuhidDU6Z
	 t4hahOylxScGQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 34F2548EC5;
	Tue, 25 Feb 2025 14:33:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bingbu Cao
 <bingbu.cao@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>, Tianshu Qiu <tian.shu.qiu@intel.com>,
 linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 00/39] Implement kernel-doc in Python
In-Reply-To: <20250225085406.7fa87ee3@foz.lan>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
 <87msea29ah.fsf@trenco.lwn.net> <20250225085406.7fa87ee3@foz.lan>
Date: Tue, 25 Feb 2025 07:33:44 -0700
Message-ID: <8734g214c7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> There's no need to rush things there, provided that people refrain
> touching the Perl version of kernel-doc. So yeah, postponing it to
> the next merge window makes sense to me. Perhaps we should announce
> somewhere that we're in the process of doing such replacement, asking
> people to wait for 6.15-rc before sending any changes to kernel-doc.

I have no problem with sending an announcement ... but I wouldn't worry
about a flood of changes to the Perl script creating more work.  There's
not a lot of people willing to dive into that thing in the first
place...

Thanks,

jon

