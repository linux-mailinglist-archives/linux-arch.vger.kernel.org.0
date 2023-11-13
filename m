Return-Path: <linux-arch+bounces-197-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B37E960D
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 05:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D2F280E9A
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 04:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296EEEBC;
	Mon, 13 Nov 2023 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1K1WA2C"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EAC8DB
	for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 04:18:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2CF172B
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 20:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h62ZSBXNIpXAn1RjkyzytMnuk1I7FWNselF1cBuUf4A=;
	b=Q1K1WA2CDS+w0P67pzrdq2laEd8TALwxUOfYbuJ22jz7ZzbPMoqy3BVpL4nywomnLfPbN5
	eLa4WYvRcpRMffL+AADrMwEw8kvER0APq0x12eN3/h7NyI6WUFLGoRD9DJUmzsN55bG48Q
	dYvhbygfDPZoNapd+i43DbKpj8XWU5c=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-80wS_o99NTqfnC3I--BjqQ-1; Sun, 12 Nov 2023 23:18:46 -0500
X-MC-Unique: 80wS_o99NTqfnC3I--BjqQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so3101326a12.3
        for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 20:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849125; x=1700453925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h62ZSBXNIpXAn1RjkyzytMnuk1I7FWNselF1cBuUf4A=;
        b=OKjj2OrGlFMnUS7QiiVUsvF/ERNAU5iCgJqcilmM+Ey2F53tZgOwe3BBQ2jrdPviNh
         RbMdzw8UOTyPgVqe5AlGH+Ns+V3WeXb1j6OvQsjqdc7XR+TFygdJbvZv/YKMmnREoLWv
         A53SlsVyQFybX47qbnZmiPWL1KIS2XBAZ0U8SP3r1atgvbuLIsSVCNtl7JMhOsuQDA2y
         OKl45ybvpii1CDGVH1M0aRwDst4qbCAmqXhBKycyIKaKTxFzZSfAN4IroT8aH5an1F4I
         7Isj0b84aghWgjoJWeSFn8SwcOmm1nhtlovJHqtJyl05iY8BjLAL2NlmIRsE93CpzsFH
         5PsQ==
X-Gm-Message-State: AOJu0YyHE5uYTyMdpDsHOcAW/bMxsvqUGEGcENSHgzcp2qcpGupGBPNT
	Q0XeFOVWS8ctzGNTsV9EU3r9F4N0Xq2uUgjBsIN69DyqcveCejvdlHmDEEDdnixIqiclzJ4haBd
	z5zsUEVFFtDWxwUmoIQpudw==
X-Received: by 2002:a05:6a20:42a4:b0:186:4def:ccc9 with SMTP id o36-20020a056a2042a400b001864defccc9mr3622158pzj.10.1699849125604;
        Sun, 12 Nov 2023 20:18:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFobxPewEpgXbDDZKt4dnfeBouA3YHhqrzoLtSI/jkAmOjDXYCHvtcrl7wlb5s/tPAkxp4efQ==
X-Received: by 2002:a05:6a20:42a4:b0:186:4def:ccc9 with SMTP id o36-20020a056a2042a400b001864defccc9mr3622141pzj.10.1699849125345;
        Sun, 12 Nov 2023 20:18:45 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b001cc50146b43sm3198590plp.202.2023.11.12.20.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:18:45 -0800 (PST)
Message-ID: <b6f833a5-49be-4bd9-b31e-143e2fbec2ca@redhat.com>
Date: Mon, 13 Nov 2023 14:18:35 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 17/22] x86/topology: convert to use
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
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JM5-00CTyD-Ri@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JM5-00CTyD-Ri@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:30, Russell King (Oracle) wrote:
> Convert x86 to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/x86/kernel/topology.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


