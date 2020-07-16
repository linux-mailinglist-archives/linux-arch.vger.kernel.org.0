Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029F2222B2F
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgGPSqV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 14:46:21 -0400
Received: from foss.arm.com ([217.140.110.172]:35120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgGPSqV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jul 2020 14:46:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D691A31B;
        Thu, 16 Jul 2020 11:46:20 -0700 (PDT)
Received: from [10.57.35.46] (unknown [10.57.35.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8418B3F718;
        Thu, 16 Jul 2020 11:46:19 -0700 (PDT)
Subject: Re: [PATCH] linux: arm: vdso: nullpatch vdso_clock_gettime64 for
 non-virtual timers
To:     Alex Bee <knaerzche@gmail.com>, linux-arch@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20200716150723.9389-1-knaerzche@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ac44a5a3-ca35-cd0a-f823-4b814c01c498@arm.com>
Date:   Thu, 16 Jul 2020 19:46:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716150723.9389-1-knaerzche@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alex,

On 2020-07-16 16:07, Alex Bee wrote:
> Along with commit commit 74d06efb9c2f ("ARM: 8932/1: Add clock_gettime64
> entry point") clock_gettime64 was added for ARM platform to solve the
> y2k38 problem on 32-bit platforms. glibc from version 2.31 onwards
> started using this vdso-call on ARM platforms.
> However it was (probably) forgotten to "nullpatch" this call, when no
> reliable timer source is available, for example when
> "arm,cpu-registers-not-fw-configured" is defined in devicetree for
> "arm,armv7-timer".
> This results in erratic time jumps whenever "gettimeofday" gets called,
> since the (non-working) vdso-call will be used instead of a syscall.
> 
> This patch adds clock_gettime64 to get nullpatched as well. It has been
> verified to work and solve this issue on Rockchip RK322x, RK3288 and
> RPi4 (32-bit kernel build) platforms.

FYI, a version of this patch was already submitted, and is just waiting 
for Russell to apply it:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8987/1

Robin.

> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>   arch/arm/kernel/vdso.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
> index 6bfdca4769a7..fddd08a6e063 100644
> --- a/arch/arm/kernel/vdso.c
> +++ b/arch/arm/kernel/vdso.c
> @@ -184,6 +184,7 @@ static void __init patch_vdso(void *ehdr)
>   	if (!cntvct_ok) {
>   		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
>   		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
> +		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
>   	}
>   }
>   
> 
