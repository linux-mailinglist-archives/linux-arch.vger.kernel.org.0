Return-Path: <linux-arch+bounces-3760-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5E8A858B
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4333B22669
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5F814039D;
	Wed, 17 Apr 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XOn+gjvb"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EDF63A;
	Wed, 17 Apr 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362520; cv=none; b=kgOuS1bY3LVtytDivwyGeNQyCGMOBJUKn/kYVFA7NjjVi0Xov3Lma4WE67lWo5k1ppZascEZyYexOVS6bnFh70qu+dUnTlyGjQCvdH28MFRHZkkraNDzdl7tgjzugIpXjR07z1BKPZDhzabX2LW6P66EmUFqCTcBDpwWbFOYqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362520; c=relaxed/simple;
	bh=GcvFtHsGPo/adYGfXVbwQgc0u1QkR/LMy1fy6H5Whzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klcheJxNkY6Aytdgy64qsFProPSFhdTh4BtymWIn4jtbOtK1UrWl1gkU/b8/Y3m9ZyRV/8ISam2EoPjDVtY3K4bOsTdyCf32d2vCsQ4OY16u2amKsdwpKiA8H0/U9PmvjD50FgDQeK0lckNIZ+Fh80NKvTBTWZxoDbgvZ/9kuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XOn+gjvb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4DfjWgrkyvkic8aAP5HZNr2ZFskxZL3uphk8p5naRQc=; b=XOn+gjvbTRu7w9/J4ik571TRh1
	WpwMuJDjUPD+eGILxTBNMdQDeSBTbLr0K8mQTS+CQ/xvO2AhXfEwwuzqRGRBExGGX3UTjr60AT5SR
	y2QgfBy789+J1BubFE/19NAsQURnDz1ZFGJuTd+3/dsy3ONa/XUPdmKo0JTAr1YkOBP2KZBTLAg5l
	qUAgrutp73V7VR5y4EN6C3ZN9mMoOhr6s+qJRr9gj7NGN9EKaPgb1qyT75PL9kai2RlgNSIAUDTJ6
	ZquxXVIAW7Ft/t3rd1M3sB0pWtdr+H273fuz5rQ+XKzGEfWZ0bpWoF/g16isq6ZG3dNx8JBtoozl5
	7eAR19nw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53384)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rx5qy-0003LA-24;
	Wed, 17 Apr 2024 15:01:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rx5qv-00060f-Aq; Wed, 17 Apr 2024 15:01:33 +0100
Date: Wed, 17 Apr 2024 15:01:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Luis <miguel.luis@oracle.com>,
	James Morse <james.morse@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
	justin.he@arm.com, jianyong.wu@arm.com
Subject: Re: [PATCH v6 02/16] cpu: Do not warn on arch_register_cpu()
 returning -EPROBE_DEFER
Message-ID: <Zh/WPYMJYepLbST/@shell.armlinux.org.uk>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
 <20240417131909.7925-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417131909.7925-3-Jonathan.Cameron@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 17, 2024 at 02:18:55PM +0100, Jonathan Cameron wrote:
> For arm64 the CPU registration cannot complete until the ACPI
> interpreter us up and running so in those cases the arch specific
> arch_register_cpu() will return -EPROBE_DEFER at this stage and the
> registration will be attempted later.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v6: tags
> ---
>  drivers/base/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 56fba44ba391..b9d0d14e5960 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -558,7 +558,7 @@ static void __init cpu_dev_register_generic(void)
>  
>  	for_each_present_cpu(i) {
>  		ret = arch_register_cpu(i);
> -		if (ret)
> +		if (ret != -EPROBE_DEFER)
>  			pr_warn("register_cpu %d failed (%d)\n", i, ret);

This looks very broken to me.

		if (ret && ret != -EPROBE_DEFER)

surely, because we don't want to print a warning if arch_register_cpu()
was successful?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

