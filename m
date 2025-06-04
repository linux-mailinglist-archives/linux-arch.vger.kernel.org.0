Return-Path: <linux-arch+bounces-12209-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD3ACDE4F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0789F1897EDF
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B128D8FB;
	Wed,  4 Jun 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZlNJidwy"
X-Original-To: linux-arch@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445F33DF;
	Wed,  4 Jun 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041584; cv=none; b=KzgHQGNIeRPNnXnZxH1wfDbTThpbEsFqowZedGGgtCh5qAGVZOpilfKg7AU5hnMZTFvfhfCdQn/qLkB4DAdiennpKnOPRPiK8CsxSUNDVu87zX9FLKk0DH9PFJj+A2gAN0zuBfRqfM4cdYWL86OHfKuxE8yTUTwGZYv2ouxRqnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041584; c=relaxed/simple;
	bh=qj1wXFWn/k0q+9pBku0c2DhqWxiMsO51WgTTVtOCaRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PdZ4rPu3s4wgi91+NlrJdnD2UOEIQdahaB076NcC9kYK3P+jDH/BE8tO5bsoqtuEICfUVnc+DVC/xBu+y0gZ7IHZadbQ54yQYesFBHcqzss7FPFDR64L+cG80uh/A1Wkxs75LeR7bo0chLEXzaPFDbmpdfs6fABx7ywF1yUj22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZlNJidwy; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8B39E41A90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1749041581; bh=LjjTe/RnLIgB3GLa+a3sJGMhTl4SyHlvR/y+FhkSjTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZlNJidwyK++0BfHq3lI+mJ5k5aMXddZE07omGrpON7mgqblWJEKoNiGhrZOy6s2XC
	 2v90BXtTL+hSEQxGk2g12vWK/ZUvJFuALy1FkIHqEb+bY3id6afnYJlCFFZAYXcCae
	 BrQHH35QFQSrl+U7bDv8JG/ELWXVLESsKHkmwufXbt+n6rGf4E45DXkrRnj/mXN27E
	 tb3kFTIZ63fYBr6ZqLn3WfElwrCueasFmQ9AC4DwHL1ABRS4jDsfqH8sX+GY075xmC
	 B+K/FhCHJSQTzQec0leodvOpvUd3D+nOq8N7QyeSARlThPIY/kGQGscC4AtI+8kGTb
	 Ax91xER7jgBpw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8B39E41A90;
	Wed,  4 Jun 2025 12:53:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Roman Kisel <romank@linux.microsoft.com>, alok.a.tiwari@oracle.com,
 arnd@arndb.de, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 kys@microsoft.com, mingo@redhat.com, mhklinux@outlook.com,
 tglx@linutronix.de, wei.liu@kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3 01/15] Documentation: hyperv:
 Confidential VMBus
In-Reply-To: <20250604004341.7194-2-romank@linux.microsoft.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-2-romank@linux.microsoft.com>
Date: Wed, 04 Jun 2025 06:53:00 -0600
Message-ID: <87ecvzk6s3.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roman Kisel <romank@linux.microsoft.com> writes:

> Define what the confidential VMBus is and describe what advantages
> it offers on the capable hardware.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  Documentation/virt/hyperv/coco.rst | 125 ++++++++++++++++++++++++++++-
>  1 file changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hyperv/coco.rst
> index c15d6fe34b4e..b4904b64219d 100644
> --- a/Documentation/virt/hyperv/coco.rst
> +++ b/Documentation/virt/hyperv/coco.rst

[...]

> +
> +Here is the data flow for a conventional VMBus connection and the Confidential
> +VMBus connection (C stands for the client or VSC, S for the server or VSP):
> +
> ++---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
> +|               |       |                 |        |                |
> +|               |       |                 |        |                |
> +|               |       |                 ==========                |
> +|               |       |                 |        |                |
> +|               |       |                 |        |                |
> +|               |       |                 |        |                |
> ++----- C -------+       +-----------------+        +------- S ------+

This will generate all kinds of errors during the docs build and will
not give the results you are looking for - please actually build the
docs after making a change like this.

You need to put the diagram into a literal block.

Thanks,

jon

