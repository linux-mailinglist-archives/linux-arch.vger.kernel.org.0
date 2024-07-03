Return-Path: <linux-arch+bounces-5236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0869260D4
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB5B28A89B
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349017A587;
	Wed,  3 Jul 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7QCLfwU"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AA1791ED
	for <linux-arch@vger.kernel.org>; Wed,  3 Jul 2024 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010930; cv=none; b=qUfLNZo8kj4FNdOfjaSXQ/HNOGDBGyGBsXgg1NiSvSSFdYyGREA+kptRUtJtBbmRJp6KCN8iLg5GLe+y1WDzbinJ/xnv/0l7cwGZoHio07wgdDieSk8rthJZ9bShk4ayRXzJ5K9KAYh2oLAq1zbb4G+uOvAXUblOwXLZgtvfUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010930; c=relaxed/simple;
	bh=nOrLYdaQKWbCBzur09331cdOZ260WekYtYvlyXlVvNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KtkYNO96xqgA90lwrONVuiDPqIyJLP/ccn/hTNu1PV7CYkj73JQZPnTbnO7wPIghopDkJ5T4igkRQnFCaq/d8C6qj9EkFao9GFOj+3CJi6avUik1P1zqEg3ky6SGtcOmpevSjpqmZsLT10QNVNdBEZXc65ofwh1Nx14mXTb/rPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7QCLfwU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720010927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2MEP5KBKlMKx9T4CmY7WwoI0xWCk7Wv3Ry4wWTTbIMQ=;
	b=P7QCLfwUcz3mg2A5ElG0ooCZzvadMZYJQAY+KS5kE9t26MDPBMjQjMeIVsODzCMY0DCEJe
	Ep41J0lxy3oVja+gVxtNGpFAqxAWuEZ+B4IoZ6kbPZ0+Ce8G1w7kNVvkv7sURdc29q/d8S
	McbqP4YFFDZhyIzrpg868ivJMZwIMfI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-lLLkZi0MOUGZAxdlDt2aTQ-1; Wed, 03 Jul 2024 08:48:46 -0400
X-MC-Unique: lLLkZi0MOUGZAxdlDt2aTQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee4a63e95cso53379241fa.1
        for <linux-arch@vger.kernel.org>; Wed, 03 Jul 2024 05:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010924; x=1720615724;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MEP5KBKlMKx9T4CmY7WwoI0xWCk7Wv3Ry4wWTTbIMQ=;
        b=OxeJG56Hhv/RlG7EsKzKo451kjzdAeYsiuChJPgSUgzkYGAdoPj1JgJkqXj2ID14Xi
         VvgQBtCpws1xPBDSCGlrUwQJhkFWzEo3YQlxKRD2fUdormXvMbZpcD0zkQ0lGPxvZAa4
         HgXXWd1xkH1pxIKY7T5m1XKiCOm2/tILNLoMaSqbY5kwBNEGgR/faf+0SN3Ih8dOl5LM
         QqRueXzA8i6k3GTFGKy11e5BZfZ5UMJQr7yDRIJWb/Xe0n3LOZp/BTI50n9SaU2SuE2A
         nH3OxSYH8u9f7RDBzTEVU9/+s737GUizNbWRyVxte9rUGgrIKliZQuum7BF4Z1wELkts
         SlXg==
X-Forwarded-Encrypted: i=1; AJvYcCWm1A4rk2wg7lsXHPH1sYXFanMYRHpIOFFgE/5JeiYweCpQm0u0OQP0Xjr7qlp2ZhxSINC8/aTVSI0R2BfdsbltYNSuyI2S4AQwgA==
X-Gm-Message-State: AOJu0YwdyjunjULgnwduhHFOrygKFbUuB5n1ciiDiQj4spOyu8MoC4EC
	U+vz7lLzpNeaC2IPyaek7QECHaHc0mHxdJmjwxIsoBAxPaUfcK1s74/Zm4RukLaYeoaJUDhrNTl
	r8cBXYxq1PVUNXnyMAWIkw2dByudLPrNJXAmMmilKaVMUuc9pnuES6notbc4=
X-Received: by 2002:a2e:a7c2:0:b0:2ee:45f3:1d13 with SMTP id 38308e7fff4ca-2ee5e704e51mr78434011fa.47.1720010924679;
        Wed, 03 Jul 2024 05:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5TqWKFAuIwTILcZtQfViw3L54aF8RKuLImctjrV+bIlLQQRnHKZJF7c8esvbcZCiclXd1w==
X-Received: by 2002:a2e:a7c2:0:b0:2ee:45f3:1d13 with SMTP id 38308e7fff4ca-2ee5e704e51mr78433691fa.47.1720010924256;
        Wed, 03 Jul 2024 05:48:44 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8cd8sm15773145f8f.27.2024.07.03.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:48:43 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, seanjc@google.com
Cc: pbonzini@redhat.com, seanjc@google.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
 nsaenz@amazon.com, linux-trace-kernel@vger.kernel.org, graf@amazon.de,
 dwmw2@infradead.org, pdurrant@amazon.co.uk, mlevitsk@redhat.com,
 jgowans@amazon.com, corbet@lwn.net, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, amoorthy@google.com
Subject: Re: [PATCH 00/18] Introducing Core Building Blocks for Hyper-V VSM
 Emulation
In-Reply-To: <D2FTASL4CXLN.32GYJ8QZH4OCR@amazon.com>
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <D2FTASL4CXLN.32GYJ8QZH4OCR@amazon.com>
Date: Wed, 03 Jul 2024 14:48:42 +0200
Message-ID: <87ikxm63px.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenz@amazon.com> writes:

> Hi Sean,
>
> On Sun Jun 9, 2024 at 3:49 PM UTC, Nicolas Saenz Julienne wrote:
>> This series introduces core KVM functionality necessary to emulate Hyper-V's
>> Virtual Secure Mode in a Virtual Machine Monitor (VMM).
>
> Just wanted to make sure the series is in your radar.
>

Not Sean here but I was planning to take a look at least at Hyper-V
parts of it next week.

-- 
Vitaly


