Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF44AA200A
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfH2Pwj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 11:52:39 -0400
Received: from foss.arm.com ([217.140.110.172]:47470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfH2Pwj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:52:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1145D28;
        Thu, 29 Aug 2019 08:52:39 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0F633F718;
        Thu, 29 Aug 2019 08:52:37 -0700 (PDT)
Subject: Re: [PATCH 5/7] arm64: compat: vdso: Remove unused
 VDSO_HAS_32BIT_FALLBACK
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
 <20190829111843.41003-6-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1908291420060.1938@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <100cf343-1cac-84d9-3a4f-5de801fc4482@arm.com>
Date:   Thu, 29 Aug 2019 16:52:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908291420060.1938@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 29/08/2019 13:21, Thomas Gleixner wrote:
> On Thu, 29 Aug 2019, Vincenzo Frascino wrote:
> 
>> As a consequence of Commit 623fa33f7bd6 ("lib:vdso: Remove
> 
> -ENOSUCH commit ....
> 
> Just say:
> 
> VDSO_HAS_32BIT_FALLBACK has been removed from the core ....
>

Thanks Thomas, I will fix it in v2.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
