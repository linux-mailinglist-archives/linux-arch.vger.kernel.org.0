Return-Path: <linux-arch+bounces-14058-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2034BD5D79
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 21:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01F554EEE97
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B72C21FE;
	Mon, 13 Oct 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="M6nW1ISS"
X-Original-To: linux-arch@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA521ABD0;
	Mon, 13 Oct 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382181; cv=none; b=d4oDICs+KifmAAB9JsrI+iilRuh9IML2Y+/KQKJK/9Qj+L8W0Q+izxbBH+9Fw3itfHEzCZPX+fsT3a+NiFsMDP1lkxBlCsVUIyY/CMPJKyroMz2AdGK+fNs6QkajOFbygLOkGBeaWbIlBdTmoHhpFFI4z5KGR2ftgTSOcUdH9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382181; c=relaxed/simple;
	bh=j3JFInE4uEboS1h3cvrqQVXAUThb/4Aso5pJOsig16E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gqNERU0iP3WQGnBZcdbB+6hyl2xaapOXWsF867xNPk1Eg/VULkTQJBjAZDqWdKZwPyNQbFTjnX6FU/33VZVgfS7NZXdd1PsrvUgxdLHJkpM15n66dzf5dkLAdvyLTjKNDQardbUXMvPr/88CK1SQHBJkHt6q0CUdktYCeX7ZWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=M6nW1ISS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F027B40B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760382173; bh=w7jJZlyqEMOvON5ktIvS7ruzua7nNGxvQi4Hhetil0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M6nW1ISSENMJuIjLjj4upP8TsPWclCX7mJIl+cD15NBijVdRh2nI8qcITy1S7PaKv
	 Wtqty4w7naL/JIKoUvxCUA1jS6pDpIPxUfR1m/1prCpP4V0j7/96eLAFSG8jX6p3cf
	 e4MSqkmbqbg7fmAOC6dPlAiZPWV4+7EMCdC6EL+uHnSfJPm0twSuIlOrWavhSY10vN
	 dSrGWXmW1k4TCv41QfmF/x+cYREYAIVIIS0cAyLlVSz09iOTtCTN9hIEq8ZNo66knY
	 ZN1BmAdO39cxG68x4UAqBPzVk4e/o/Qju3I00LHStNS1X4UOtEkJdr3gPB4Naf3qKh
	 i/DNPIDvx31Tg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F027B40B1B;
	Mon, 13 Oct 2025 19:02:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Siddharth Nayyar <sidnayyar@google.com>, petr.pavlu@suse.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev,
 samitolvanen@google.com, sidnayyar@google.com, maennich@google.com,
 gprocida@google.com
Subject: Re: [PATCH v2 00/10] scalable symbol flags with __kflagstab
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
References: <20251013153918.2206045-1-sidnayyar@google.com>
Date: Mon, 13 Oct 2025 13:02:52 -0600
Message-ID: <87ikgieiar.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Nayyar <sidnayyar@google.com> writes:

> This patch series implements a mechanism for scalable exported symbol
> flags using a separate section called __kflagstab. The series introduces
> __kflagstab support, removes *_gpl sections in favor of a GPL flag,
> simplifies symbol resolution during module loading, and adds symbol
> import protection.

This caught my eye in passing ... some questions ...

The import protection would appear to be the real point of this work?
But it seems that you have kind of buried it; why not describe what you
are trying to do here and how it will be used?

I ask "how it will be used" since you don't provide any way to actually
mark exports with this new flag.  What is the intended usage here?

If I understand things correctly, applying this series will immediately
result in the inability to load any previously built modules, right?
That will create a sort of flag day for anybody with out-of-tree modules
that some may well see as a regression.  Is that really the intent?

Thanks,

jon

