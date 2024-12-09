Return-Path: <linux-arch+bounces-9313-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8539E88A4
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 01:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9868F16377C
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BF72572;
	Mon,  9 Dec 2024 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iax8gMl+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EADC28EA;
	Mon,  9 Dec 2024 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733702843; cv=none; b=eu+6LnSpb3BU4zcM/3Sv7SDHGVOPwwocZoCU4N+If7w285eHkRlQ4ZJpEWKVtSrO7ksnYwGtaT4CxYf5iPzk6/7Cle4HE62sCu0gwlVzGUvY0Now7yVc5PeAXMth0C2YYgBeSdNplYOv8l5sweF9RzRPpC/bqgFsh51Hz3n5+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733702843; c=relaxed/simple;
	bh=qQNrvfENV3cjN5xREbhZ7VhcAz/yAeIeQ9LRLJN97rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqzSjAP1f+HNIYmxLb/akpz5szyHyd0MOauHQt2gteW+ZN9HrIldFEdMvdltVhhoKQi9tUbtUCQ8iCPaNOAZ2Qdb8/j4CPFfIoD1fHIJ8fjLJ9oNvgvYVWsW0KY6sCR+caBiFOGTuN2lvdwDh5S9CJr2BLBE9BLETp1N+SQl7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iax8gMl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E74C4CED2;
	Mon,  9 Dec 2024 00:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733702842;
	bh=qQNrvfENV3cjN5xREbhZ7VhcAz/yAeIeQ9LRLJN97rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iax8gMl+0GT3J8M4iZ9gQyDPrIu27a3sIyltOK6REilnDJPHdyhdVAXaRpTxxtOqB
	 MuqYjX3mhFXSRTor5pSLAmTNhGqLX3rmQwUsVw1mIIQaMU8vd7TVVaPJGzHmpmf/D0
	 daiD828J/LIghaf4mumgtHGdKuVOqThvGRQ1PTODlqAUQpPGSsDwLt9knC26SfKG8m
	 WwmSMezcdQ82gahImT/PW3UM/9cgOCD2+zwAWFB94NzIC+EQ1lBvz5zRGeTOxXjn89
	 QpSpbyWeYA4tGb+l7kxIZkDNWiRpm9eHgkMBH9Vmty7qgrQhdwOU8rrzaCbGYjrm8x
	 /E28uEALgWPAg==
Date: Mon, 9 Dec 2024 00:07:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
	decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	sgarzare@redhat.com, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com, vkuznets@redhat.com,
	ssengar@linux.microsoft.com, apais@linux.microsoft.com,
	eahariha@linux.microsoft.com, horms@kernel.org
Subject: Re: [PATCH v3 1/5] hyperv: Move hv_connection_id to hyperv-tlfs.h
Message-ID: <Z1Y0uJlVn-86KHE8@liuwe-devbox-debian-v2>
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1732577084-2122-2-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1732577084-2122-2-git-send-email-nunodasneves@linux.microsoft.com>

On Mon, Nov 25, 2024 at 03:24:40PM -0800, Nuno Das Neves wrote:
> This definition is in the wrong file; it is part of the TLFS doc.
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

One comment about the ordering of the tags. It is better to organize
them in the following order:

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

I've made the change for you while applying the patch.

Thanks,
Wei.

