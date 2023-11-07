Return-Path: <linux-arch+bounces-57-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D44CE7E478C
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 18:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75429B20DF8
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B159234CF4;
	Tue,  7 Nov 2023 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="HousSzc/"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477634CF6
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 17:48:11 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F912A
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 09:48:10 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc9784dbc1so36209975ad.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 09:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1699379290; x=1699984090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TY15kIau+eDARAHjRIt1BbGYq8C7hJS6gitrNXYnQoM=;
        b=HousSzc/TjsP9QqgcvSIDoufRgk897tprX2D8mQ95adj1B/2RgSgyZNdoHXOAi4POE
         RyGSeJv4XJeNzp1qJCFnJQQdRkoq56vsC4XirAWI7snyChYAVnTwpS3fa+wBy9WrqElS
         9R2e8WFkuuqV43XkSuhbARRfsELb92BgB/q37zaN2ZiYWtYUWAt96mKJdUdjhiN0/0FP
         o4hxVnfu24k/VrGRdQn2TDq9wXbKSdRoTirQs8urvQaLa+An1fTZu6enivRYHA9IM7Yb
         c87zXju/6oae3/n4iaoZqgW34MushccCIy0qF6RXIroGfOWMsOEZEH+xsciQFGCCFpP0
         jVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379290; x=1699984090;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY15kIau+eDARAHjRIt1BbGYq8C7hJS6gitrNXYnQoM=;
        b=I5IUlNs8/M5Pr+Mz5eGfXTT4ICMWScayfqd/lm1/aRCHiAkYYz/HRGbFOAEEv8dUXF
         4+xcBCMlbYRUsVLf58CENWb0th9n2sceRgyYosjo58ItJPGxJVHhL70qVuLC63NaJNG1
         s7q/gwWUqLgd4QZco+ZYk/yAC7oE+e+A4zctvlSh+oYS99yw7HMxDI6rZv/RL2roooQ9
         mAvcpJ+TA3xc2vM9k//DTwNgWuUGBouWf4q4o6TO+gtXKrz04v82yRv3jH8OPdtEuI57
         qafu3jURyR2Q/nnddnwcsPXV9UJF4NV0QOhPKYSUCQYH9p6fWItwxkFrxdS+gqZrTT16
         dfKw==
X-Gm-Message-State: AOJu0YxkcEAOWc8L+mfibyMJSImRAN9zW2Q1MzKhpAh0NXeOHPOnVAhd
	vqsKDpUnEKLIEVM+GUrxgFFcmg==
X-Google-Smtp-Source: AGHT+IE1uUN1bCnM0e+Ov1l1naTtElUtLA3DgMMTfPPCXEEwKaTGd4dv0hVEl36p8Py1780zIW4h7w==
X-Received: by 2002:a17:902:ccca:b0:1bd:c7e2:462 with SMTP id z10-20020a170902ccca00b001bdc7e20462mr31928892ple.11.1699379290316;
        Tue, 07 Nov 2023 09:48:10 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b001b9be3b94d3sm102654pls.140.2023.11.07.09.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:48:09 -0800 (PST)
Date: Tue, 07 Nov 2023 09:48:09 -0800 (PST)
X-Google-Original-Date: Tue, 07 Nov 2023 09:48:06 PST (-0800)
Subject:     Re: [PATCH RFC 22/22] riscv: convert to use arch_cpu_is_hotpluggable()
In-Reply-To: <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
CC: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
  linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
  linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, linux-csky@vger.kernel.org,
  linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
  salil.mehta@huawei.com, jean-philippe@linaro.org, jianyong.wu@arm.com, justin.he@arm.com,
  james.morse@arm.com, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rmk+kernel@armlinux.org.uk
Message-ID: <mhng-b535d186-b241-4fe8-a6b5-b06aff516d1c@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 07 Nov 2023 02:31:11 PST (-0800), rmk+kernel@armlinux.org.uk wrote:
> Convert riscv to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  arch/riscv/kernel/setup.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index f8875ae1b0aa..168f0db63d53 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -294,12 +294,9 @@ void __init setup_arch(char **cmdline_p)
>  	riscv_set_dma_cache_alignment();
>  }
>
> -int arch_register_cpu(int cpu)
> +bool arch_cpu_is_hotpluggable(int cpu)
>  {
> -	struct cpu *c = &per_cpu(cpu_devices, cpu);
> -
> -	c->hotpluggable = cpu_has_hotplug(cpu);
> -	return register_cpu(c, cpu);
> +	return cpu_has_hotplug(cpu);
>  }
>
>  void free_initmem(void)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

