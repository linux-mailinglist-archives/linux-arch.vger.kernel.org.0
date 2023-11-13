Return-Path: <linux-arch+bounces-193-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E97E95F3
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 05:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBA2B20AE9
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 04:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33B4C150;
	Mon, 13 Nov 2023 04:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdpZOw9E"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE553C2CD
	for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 04:09:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B49BE
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 20:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699848575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2bRjfP7yOuv9SAdAE0QP2CBFoAYrMs60Lu0SjYCCHg=;
	b=DdpZOw9EVotEnA6JMbayfVU34Nqdbkfl5tXWxMWEq74e96U6Cc/tzAjDYiGhQ/nxRcPtmC
	MneTD6b24WTrT3Z+UtfAts8QcgzVIliWl+gQJKvHVnzEoraERYQD8zddj5Is6kjGa9kX0l
	od8Kq4p8qalCcd5SVpupiwp5nJ/PZPw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-mTFKarTAN82zd6BTuBJAUg-1; Sun, 12 Nov 2023 23:09:33 -0500
X-MC-Unique: mTFKarTAN82zd6BTuBJAUg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b7bf1c206fso3975639a12.2
        for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 20:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848572; x=1700453372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2bRjfP7yOuv9SAdAE0QP2CBFoAYrMs60Lu0SjYCCHg=;
        b=cbNAIj1kliSRfTdKPPaxpH19toBB8sismfaqJbZImz2pLkoAXNMehVblkmBbwxuO5z
         F3qewsLXyEApDk0NMovSSoyaR1ibsN0pgfmsUnamkuhLrQRMmNEQg/2lizaIiUug9cx2
         bhowOIAWF7COo9JtZd73P6eqeAQxLoCQ6K6TOTo0EosZmbgOPk8Ex+LmVJ41almCxJbg
         wenYQjsvPRmNYWi77j2Xmy6Ulh7nNdvnGY1V1czWmxrB4h1HNCPDCpXA5d+NRFxNRIfY
         xECIVUqvViwx3bghZP0EoEvIRbBsQDLqPzS0EglX+3lDcDwAsJTaIqCuCyzkII8MNRLM
         09Dw==
X-Gm-Message-State: AOJu0Yw53PcEPODFp+lD2V4YID3QP/trt3Ic0GOSSY+flmPJslClIRpG
	e+IWASfZ8s+dELAKz0d9NaILD93H8WRNnQiUOiBq+cglunzDw9DyzKwQtjKITYBJyJVG37jUxcT
	qAGAo8g3moygAd1RGSy5ZYQ==
X-Received: by 2002:a17:90b:1a8c:b0:27d:ba33:6990 with SMTP id ng12-20020a17090b1a8c00b0027dba336990mr3197166pjb.10.1699848572562;
        Sun, 12 Nov 2023 20:09:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2k5SwVakWG7zKK4WUWbKBo4uYLTXEgbcXMEekUsR8f4+eMr6ksf4A21GkOdsMSomj6DSw2A==
X-Received: by 2002:a17:90b:1a8c:b0:27d:ba33:6990 with SMTP id ng12-20020a17090b1a8c00b0027dba336990mr3197155pjb.10.1699848572281;
        Sun, 12 Nov 2023 20:09:32 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001cc3098c9f8sm3225162plh.275.2023.11.12.20.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:09:31 -0800 (PST)
Message-ID: <55e640c3-491c-4f55-b432-a41f48405a02@redhat.com>
Date: Mon, 13 Nov 2023 14:09:25 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 14/22] arm64: convert to arch_cpu_is_hotpluggable()
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLq-00CTxq-CF@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JLq-00CTxq-CF@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/7/23 20:30, Russell King (Oracle) wrote:
> Convert arm64 to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/arm64/kernel/setup.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


