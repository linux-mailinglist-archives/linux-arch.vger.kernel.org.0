Return-Path: <linux-arch+bounces-4462-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0198C8AB0
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 19:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512551C20A7A
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67713DB9C;
	Fri, 17 May 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L26Qd1ky"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C112F5A3;
	Fri, 17 May 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966114; cv=none; b=aGA750FvHdSlEyDjd3uH8C8i1gvrF/ihhJIWF7+2oZbV4nkVRgar9s+l7o5CRFTkq1SoBXd3L20zGNa74C3z4aSIiKXSCxLLRwUjrpB2nqwgMGVTgvEHkuXgUlnYj/y/8R6/ag5GHwMJPmIk6uqVtx5o+HsWBy3+1/ejbHVYiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966114; c=relaxed/simple;
	bh=8niseAwEvm4eufhgATrW3AOhRGKDVc/i+YYWQsWeM7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rX0FNicvKj/HaOgvbn55cMEfbqtfK/wdz7GtiPd40huNnE2/cIJWcEfOmnkrwjgV/oZiEqnOJHAltlLB/WEjju5ou3DfQ9RRY9kBaP52AVvKWWzP+cwfC5rT3Io4aa0sGWRNCdUHOYzH9P0yBP/cNCn5XYm9ZPmJrUtcd9DcNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L26Qd1ky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB656C4AF0E;
	Fri, 17 May 2024 17:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715966113;
	bh=8niseAwEvm4eufhgATrW3AOhRGKDVc/i+YYWQsWeM7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L26Qd1kyalzbhAN7I58oIXCoMGliFeN10tRbJywsR7G7832jC/g5AmuXZ3OYaRuav
	 KNaOX5qBPGdgXrS/dcYCW4tC9ZFk/O4U1MyTnqAHcASLOQ3IsdnWaFLJMzVeSoxnFH
	 JWTZoUmBiC/OrYwutQ0Qdbsf/qI+hAmoUcAiv7AolTnjhqaoDXLbT0j/c52VLqfXOS
	 j0bRAd6LC+/NE7+SiINnnT85UxoaPJlx1ssny0OQqZgKzh47ykuVNsyUV0D9EFI3HM
	 /KUjfoheuJp849m7k8FCDXkgTFDRYNSZifMnH15EtZFtCrrLJrYUxoMMCZM8SmChAJ
	 Ss6/MOR9E/FSA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-523b017a5c6so3459100e87.1;
        Fri, 17 May 2024 10:15:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4UBHDUxpkVDomeboGU6nj4NyznefjpK1+cH1Mz6sTXAGQjdMcCWVgwbmkDlB+GozE/z1YhlqDBQyA+0MsqVeRGdNvBBp2sqGcC+rIc5ngXwF0zxJ2DMH6W6ggqwZvnxHiqiJxuPjqW9P63cDyKl9QcVixuNZbpb5UZIkmq1PgRgLD2nnF+QmqLuJlQmw2I6QonNxRprk0jDVbALLb2eKJ1wJn+o/d3x8YUkgVYp3K8RwNSXuP06fiCgiVYxw=
X-Gm-Message-State: AOJu0Yz9AHyjP/UJiViRFYYCOqLT33Ds/y4gzGd/qq+JMbrhEOhNwWwU
	GoLCAXdWLc8KRqa+DFXMv1Gus+iH0MaRVNxG6QDT6QQWY5xJsPuMR5QS6LIiAutWG8TF1bJJbGV
	b0xDzGdBgcckQiMHQXI7svRDd3w==
X-Google-Smtp-Source: AGHT+IGUUWb0QqBy4GPMsKWcCTpt3kRDK3vukBnYnUPOMugpsBxrcXJSiRK62s1g28Bx/g92dGHcLhVZALfpiK1lJOw=
X-Received: by 2002:ac2:4643:0:b0:523:ae99:b333 with SMTP id
 2adb3069b0e04-523ae99b3c5mr5613808e87.64.1715966112010; Fri, 17 May 2024
 10:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514224508.212318-1-romank@linux.microsoft.com> <20240514224508.212318-6-romank@linux.microsoft.com>
In-Reply-To: <20240514224508.212318-6-romank@linux.microsoft.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 17 May 2024 12:14:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKXejxzixzwQO4U_00WAaV_iaEh8Mndf6R5BhLQsgVwLQ@mail.gmail.com>
Message-ID: <CAL_JsqKXejxzixzwQO4U_00WAaV_iaEh8Mndf6R5BhLQsgVwLQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drivers/hv/vmbus: Get the irq number from DeviceTree
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com, 
	hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org, 
	lpieralisi@kernel.org, mingo@redhat.com, mhklinux@outlook.com, 
	rafael@kernel.org, tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, 
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 5:45=E2=80=AFPM Roman Kisel <romank@linux.microsoft=
.com> wrote:
>
> The vmbus driver uses ACPI for interrupt assignment on
> arm64 hence it won't function in the VTL mode where only
> DeviceTree can be used.
>
> Update the vmbus driver to discover interrupt configuration
> via DeviceTree.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index e25223cee3ab..52f01bd1c947 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
> +#include <linux/of_irq.h>

If you are using this header in a driver, you are doing it wrong. We
have common functions which work on both ACPI or DT, so use them if
you have a need to support both.

Though my first question on a binding will be the same as on every
'hypervisor binding'.  Why can't you make your hypervisor interfaces
discoverable? It's all s/w, not some h/w device which is fixed.

Rob

