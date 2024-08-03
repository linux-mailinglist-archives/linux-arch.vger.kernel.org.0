Return-Path: <linux-arch+bounces-5950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB209466B9
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 03:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BBD283385
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125679D1;
	Sat,  3 Aug 2024 01:21:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398018C31;
	Sat,  3 Aug 2024 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722648116; cv=none; b=jnp4lHoXj7NarlLp5WkC4NLCFmSJMpI+H0xtlcgms/gVaPwCH0ltF93oA6tsbVJajqUNYiQczl7BLPOUwDzjYqHqRECVg0+G0r9P9fOzJtvFHGsW1Yzm06sPnbAn3cVFwfjTuhha1kmqWzouftTCDHiHdylKjQzJrFq2afszmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722648116; c=relaxed/simple;
	bh=yc6rfrGxg8brfCXgujpsIoNseDlszo67N9cpVC7FIRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx9CefCd+GMQfBigurEB0/COCuogAbTKpB38ny0cuSOC9q4eVSbQZZwIRAN2czWIxglfU+Mk1Ry+UJZjBHpqWHbeZogWkHcU1P+vvTP2Qn41uL8v6tH72ChTlwxq/KiYSbL2IAUeKKdIB34aEFXqGrT39+HTWkYt0nPUEB3FCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso5242747a12.2;
        Fri, 02 Aug 2024 18:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722648114; x=1723252914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMBNT0EM8eGZf7BSfCt8eBnkVGPYNvww8epbZVbys40=;
        b=hZfSHK8WlYuxivcRBMVRKxOp1mfhWvc9ry6wQOGjiPIg95/DbdTc3DxTyo2iptc0bg
         dU4IlKMFJXuzDKHgZgcAoZnaU2WzVYbTE/nD5gMXXTYtYX/hbJ34fmvK1c17aR95i1FM
         qd/XquBL/RgvEwUyBBXZbm7D8VcxZFxt6W0Tz2Qpf/TaE3wd4rnV9bKrMai6+fFug+8B
         9bjQcPohB+Y1ZvO/vPv3QWo2f8IH3fYF/CiVLXXfZKo2GSSLNaU1v5pZFShMbrUFL/rb
         cruVGQb7irGtz/6vwUcZ5q/NNwfKAKTYAO3JmvGVXdO3fYsRB1xiPvQNo6Izf/pfRadR
         NZoA==
X-Forwarded-Encrypted: i=1; AJvYcCXEQ90L57U5MBa32NeX4RwLa9TXdy5dn0QSBZC2Jarcl3RyDslCDvu+QLu0wW/vmUEtG7nO6Hf6op6q4YqRIzn+zia9jr10OUyijPr6Yctx2e3Y5Q8Wxnc7qrODwmj4Or5HDDP0gdsxyD/RCPK5bKE7mxMA5WseRuc2O0jfyvzlFN7V8luoCu3R1TItKowZJ0UoOfVLxxkdVkrl0MS+at/iaLZhTvry5ZpGxddvRTj6OjVkMEYYp9nPnXc/S90=
X-Gm-Message-State: AOJu0YzDXEjL98EKA+cYgMq9x39NZYNrA28vjut2q3xNHEQ/4mDtK5xe
	4+a64jEXtwvmByPX/wp2+m0l/S8yD6VSRzytEyCTc8lNj0CIQ5Fs
X-Google-Smtp-Source: AGHT+IGdA9x5DOJmhpwToasI08wQCO4Mq8GF39dZxj2+15+CMJh5IgxzUG4t/6AZuEXRjGJjtJLWvw==
X-Received: by 2002:a05:6a20:1588:b0:1c4:214c:cc0d with SMTP id adf61e73a8af0-1c69962418amr7570586637.36.1722648114087;
        Fri, 02 Aug 2024 18:21:54 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb098329sm2402194a91.23.2024.08.02.18.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 18:21:53 -0700 (PDT)
Date: Sat, 3 Aug 2024 01:21:52 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	kw@linux.com, kys@microsoft.com, lenb@kernel.org,
	lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org,
	robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev,
	ssengar@linux.microsoft.com
Subject: Re: [PATCH v3 3/7] Drivers: hv: Provide arch-neutral implementation
 of get_vtl()
Message-ID: <Zq2GMNnRFqH4psLv@liuwe-devbox-debian-v2>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-4-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726225910.1912537-4-romank@linux.microsoft.com>

On Fri, Jul 26, 2024 at 03:59:06PM -0700, Roman Kisel wrote:
> To run in the VTL mode, Hyper-V drivers have to know what
> VTL the system boots in, and the arm64/hyperv code does not
> have the means to compute that.
> 
> Refactor the code to hoist the function that detects VTL,
> make it arch-neutral to be able to employ it to get the VTL
> on arm64. Fix the hypercall output address in `get_vtl(void)`
> not to overlap with the hypercall input area to adhere to
> the Hyper-V TLFS.

Can you split the fix out? That potentially can be backported.

> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
> +
> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> +u8 __init get_vtl(void)
> +{
> +	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> +	struct hv_get_vp_registers_input *input;
> +	struct hv_get_vp_registers_output *output;
> +	unsigned long flags;
> +	u64 ret;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);

Hmm... I don't remember why the old code didn't use
hyperv_pcpu_output_arg but instead reused input+OFFSET as output.

Saurabh, can you comment on this?

Thanks,
Wei.

