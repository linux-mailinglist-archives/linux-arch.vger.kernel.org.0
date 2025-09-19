Return-Path: <linux-arch+bounces-13696-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C9CB8B041
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 20:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C96D1C27525
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0960277032;
	Fri, 19 Sep 2025 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="l4aYYwKO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F61227BA4;
	Fri, 19 Sep 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308340; cv=none; b=n7xrk0nbljqD9EGgCGgN6CmS0SLWF4m1WgMzk+yoj+0Kt5YriSd27OVFin3yq7ZheN43Lt63lfSPqPaj9nGgtwgFf+WEWlWo0GlS21/e/uPmG81zFYh4r3zuMSWl1E6RfZ960KrHe0urCDL6eBB0k7YDYgHGLPO6Ip2n5LlMZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308340; c=relaxed/simple;
	bh=H37s73J/sTetUrZnOXtGK1AH3JN1H3RvY/KRiB7PfUE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uv29WTtsqVTn+I5bTSW2SXM7doEbePICrML6jf1NXhadxPVastraS9loUXBSFUSgN1p7cnfmkIFIPvmI48+YAmMztnsCVDKCNZ1x1VL7ttJwc51i8M/rt4Rh6Es2YWSj7/blTJVeaV1h4XS6ablU40ykmqgGjWJ99uPKe7u8uGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=l4aYYwKO reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cT1xr04h3z1DHYY;
	Fri, 19 Sep 2025 20:58:56 +0200 (CEST)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cT1xq4l7Cz1DDB7;
	Fri, 19 Sep 2025 20:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758308335;
	bh=H37s73J/sTetUrZnOXtGK1AH3JN1H3RvY/KRiB7PfUE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=l4aYYwKOAvvAwuTK81mYNnQVjHX8smOvvLZwb1jvLjitM5DIvacvWmKbJaHUbi/9+
	 IpUy4KUHM00XmacQwjBbRN7rjAg/pTKolOCertvdIFRNS7gPuR0lIHTGmbcFNPgZVL
	 3RH80OAZlKZtHxS1N3JzMtHiZ5eiZ3EQHInyioB83PGM1K2c2MDE5xAXSSh49AdTef
	 D6tgPSD0LuV3kdQB1/hmUyuEEUq8wuKrNXJKl2B6yH+kqr+uDg95YO8VoCUbF55ISs
	 Ly33of9y431w2Ph+RTUeILkjHwWY3rA6pXaBB8fLgGmEsdsKP1I5Gmc2J62TWs2slE
	 XIVPQ+60bGKEw==
Message-ID: <aff441b7-984f-4dfe-b009-d208209fb045@gaisler.com>
Date: Fri, 19 Sep 2025 20:58:54 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix prototypes of reads[bwl]() on sparc64
From: Andreas Larsson <andreas@gaisler.com>
To: Al Viro <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org
Cc: linux-arch@vger.kernel.org
References: <20250810034208.GJ222315@ZenIV>
 <fbb1a96c-d913-4bdf-b40c-c8981601bbf9@gaisler.com>
Content-Language: en-US
In-Reply-To: <fbb1a96c-d913-4bdf-b40c-c8981601bbf9@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-19 20:02, Andreas Larsson wrote:
> Picking this up to my for-next.

...and swapping sparc64 to subject be prefix:

sparc64: fix prototypes of reads[bwl]()

Cheers,
Andreas


