Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5DD1F3786
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 12:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgFIKCI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 06:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgFIKCH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jun 2020 06:02:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4281207C3;
        Tue,  9 Jun 2020 10:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591696927;
        bh=RWvA/egJNR2+v+decCg83OM5wqAsGNKdFJYEQrto1Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIcI0NI+m3Pjb85pqODykVVez33oYrBxREtDzx9VHafhVBXgYKb5O/aikGDsFfPoc
         zSseZqs9tVcsqIM64LZUeAvqkvNq6sl1xzQ71o7JmNsjFYS/EccVc6dl0m9A0m1H6F
         /mwkx4/Ff5TOtMdku7bDdhvbFRbQJqy95rN53zoo=
Date:   Tue, 9 Jun 2020 11:02:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Message-ID: <20200609100202.GB25362@willie-the-truck>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 27, 2020 at 10:17:37PM +0100, Dave Martin wrote:
> Add documentation for the PR_PAC_RESET_KEYS ioctl added in Linux
> 5.0 for arm64.

[...]

> +If the arguments are invalid,
> +and in particular if
> +.I arg2
> +contains set bits that are unrecognized
> +or that correspond to a key not available on this platform,
> +the call fails with error
> +.BR EINVAL .
> +.IP
> +.B Warning:
> +Because the compiler or run-time environment
> +may be using some or all of the keys,
> +a successful
> +.IP
> +For more information, see the kernel source file
> +.I Documentation/arm64/pointer\-authentication.rst
> +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> +(or
> +.I Documentation/arm64/pointer\-authentication.txt
> +before Linux 5.3).
> +.B PR_PAC_RESET_KEYS
> +may crash the calling process.

I might be misreading this, but this looks like the kernel reference appears
mid-sentence. Regardless, I think we should drop the kernel doc reference,
as I mentioned on the SVE patches.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
