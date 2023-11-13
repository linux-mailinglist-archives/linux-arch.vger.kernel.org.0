Return-Path: <linux-arch+bounces-202-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 550A07E962B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 05:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221571C2031B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 04:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53682F9E2;
	Mon, 13 Nov 2023 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqiSUF2O"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757F11702
	for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 04:24:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6DC19B4
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 20:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XpkXMncYpwBWWz5YM4lExGVyIZbJdd8k4LtapRIRSU=;
	b=CqiSUF2OOoz7FDL8zJB1fpVBOFcXzYHcqyThP9jZgY4tu7iXzvwbC8ZhMoGYldCriGk3uF
	aRzYE69HUo44bFM8lx7cmgMcaXmnaKS4dWO6j5qm9HYPwlZMzJpU3LQVpCboPJppZMQ9g5
	VWTmZTRlDhmu6IH28mpkhmgqsUuhzEw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-aEnhL0_ANB-r2AHJ6mxxdQ-1; Sun, 12 Nov 2023 23:24:36 -0500
X-MC-Unique: aEnhL0_ANB-r2AHJ6mxxdQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b3e601436cso4676693b6e.1
        for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 20:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849475; x=1700454275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XpkXMncYpwBWWz5YM4lExGVyIZbJdd8k4LtapRIRSU=;
        b=iCvBtUMOUYDX7fyTCB2/NKAacASh06tVGbWh13rqPSyiM/4eU9SApAbSUPpBtKp1nK
         vcHbExDD0TLNoK7g/GgiOrt8Tq6FLjauE+FKhnh0OjmAOGPiSaEb56e1TpdGVF351Rqc
         ws4WB6RAy2tHwJYyaK4Uj1Gsuht8pkjKWT9u4ubTk6rE7tKfHtjTZaU459/cl/4uM44G
         IIhy6iDlRHj1vj9MS3820eAxl14kdZEMOYA1fVU7YZJRKbfBY8X9OwKcLGI4yKLYz2FM
         MccEUjFWR1V+DRaVRMOtOaiUO42JSdwBe5m6E5wp1CbRj/EXKfUc+mN02nW6A7fRZhBQ
         KBoA==
X-Gm-Message-State: AOJu0YwaYuF4DHJ3cZurFBxPLTxxJ+EdaxlLdpFlFrEP/EMbXoJv5qdw
	i4EQ/gQ/gryPtx1nnESOh4mRfpPvVLn9WuLj4RzGxQEG2D0VEtZ+C+jXyGh8rm5agLfeBUZe1N5
	fSAaNzbSHONO9V5vqBvkOXw==
X-Received: by 2002:a05:6808:1907:b0:3b2:a9bd:c38f with SMTP id bf7-20020a056808190700b003b2a9bdc38fmr8909966oib.37.1699849475411;
        Sun, 12 Nov 2023 20:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGpLquY73YkMUU9Mlaw3xcZEgmE+1wMz9SoOzUS3eERBYDajACgA3kg4BM9OvwoIC+iQZINQ==
X-Received: by 2002:a05:6808:1907:b0:3b2:a9bd:c38f with SMTP id bf7-20020a056808190700b003b2a9bdc38fmr8909944oib.37.1699849475200;
        Sun, 12 Nov 2023 20:24:35 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id fm6-20020a056a002f8600b006c4db182074sm3111661pfb.196.2023.11.12.20.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:24:34 -0800 (PST)
Message-ID: <d07a9e11-9752-4155-bbaf-b759ec4f99ac@redhat.com>
Date: Mon, 13 Nov 2023 14:24:27 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 22/22] riscv: convert to use
 arch_cpu_is_hotpluggable()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:31, Russell King (Oracle) wrote:
> Convert riscv to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/riscv/kernel/setup.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


