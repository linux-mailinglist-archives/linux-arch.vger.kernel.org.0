Return-Path: <linux-arch+bounces-10145-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DDA3553C
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 04:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48C13AC950
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 03:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4313B7AE;
	Fri, 14 Feb 2025 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKWE8J9o"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B152CCC5;
	Fri, 14 Feb 2025 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502935; cv=none; b=OkYtGkohYDmSuZVZR2VDPNAvAZBPQTxFeB30PBjFFcIbAQMpxDM9gsiWyHOZIw3PBz5TaxrnoXZ5arD86waBw58DUSc7AQvXmWP6v2xxMUWUib9gY1aK3SrveoNW+Zv9Zwltf24TtCruLwszJ4ycmjlsVJvLuIr793i51ShJ/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502935; c=relaxed/simple;
	bh=o6A7xuEyy0GYKf1mHa6EnId2Hk3+EkEYN+UcBfQPBps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PpCPWJbM9/JqePfT5wQAPehlyzG0cGDZlvDnX7fl/4u2QAkcQgCI0QWGvlFO6rOYeaYAeqmLhwITzRSWWNbGN8m20RGvel6UnDd9WfyYaw2nkNJuqLAL3kCnTR8rpQo7nKS/qu2iHUkdf0PywCx1I+zW0DGOQU26e07OWu3kYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AKWE8J9o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=SpBZhNJf9VAwv3CM2HFINMYiP5ZKV41Iw5vGkWokPz4=; b=AKWE8J9oC+5cmKIq9GbkJKtXdx
	LItUBTq2j2PEbYqbUMl/INRK9ByLQ3YAZSE8zwb2g/Vzj9tufoyLYRR1pkyiEjcvAH3PINn6dF6ns
	+49IdfCX5Zr7c51z/ubgpFdWNuv/NfTBM1m5j7dd4W4HYCmQcIZWBt4JAAA41Jwyfip/l5hA6CB9c
	g+7tJV1yVEe4Sl8g3ezkic6QMloPZPkhX20Fp0ayRrrfbTpQrCKQYjSzrE8ksaVS3C5vjZ1+mzdRY
	m6eicNPjC4Eg6pjBYQ1ZGWe9TNNCbkxVR3q/Ix6yAXJ0wAcZvBXIpwDF669rD/iueneE9dVcrh/jN
	CelKw3Ng==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1timAt-0000000A2yV-2TCl;
	Fri, 14 Feb 2025 03:15:31 +0000
Message-ID: <6958d7a5-2403-423d-a0a3-0c43931a7d30@infradead.org>
Date: Thu, 13 Feb 2025 19:15:28 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RFCv2 0/5]Implement kernel-doc in Python
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1739447912.git.mchehab+huawei@kernel.org>
Content-Language: en-US
In-Reply-To: <cover.1739447912.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,


On 2/13/25 4:06 AM, Mauro Carvalho Chehab wrote:
> Hi Jon,
> 
> That's the second version of the Python kernel-doc tool.
> 
> As the previous version, I tried to stay as close as possible of the original
> Perl implementation, as it helps to double check if each function was 
> properly translated to Python.  This have been helpful debugging troubles
> that happened during the conversion.

Since this new version is supposed to be bug-for-bug compatible, I will wait
until later to test the current known bugs that I know about in (Perl) kernel-doc.

For a preview of most of them, you can read:
https://lore.kernel.org/linux-doc/3a6a7dd0-72f1-44c6-b0bc-b1ce76fca76a@infradead.org/

and its follow-up email (today).

There are quite a few problems with parsing function parameters that use
typedefs.


-- 
~Randy


