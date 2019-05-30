Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7162D2FDC6
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfE3O3l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3O3l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:29:41 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647DB25AE7;
        Thu, 30 May 2019 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559226580;
        bh=MOK0Q0CBcC4ffnKxK65gGpI4OI3xMaujvGqobppRdSc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zBalS9N1SjTiPLA9KUgcgJ7w4KPB18QNfTkKU0fhz/j2S6111JM6bXUyocTtDqwqa
         8hOyFFM5I5Gg6bzFZcmYtuXdvb9g1/cGVpywc57BC/EZ11XJagh4v6BuOr3brfZbFn
         +dMA/kqAZSEb6t6yd66D41ogmshMWJ+SWQFRvuDs=
Subject: Re: [PATCH v5 2/3] s390: Fix vDSO clock_getres()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, shuah <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190528120446.48911-1-vincenzo.frascino@arm.com>
 <20190528120446.48911-3-vincenzo.frascino@arm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <dbcf69ff-1fe7-3a2e-5940-11fed052d45e@kernel.org>
Date:   Thu, 30 May 2019 08:29:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528120446.48911-3-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/28/19 6:04 AM, Vincenzo Frascino wrote:
> clock_getres in the vDSO library has to preserve the same behaviour
> of posix_get_hrtimer_res().
> 
> In particular, posix_get_hrtimer_res() does:
>      sec = 0;
>      ns = hrtimer_resolution;
> and hrtimer_resolution depends on the enablement of the high
> resolution timers that can happen either at compile or at run time.
> 
> Fix the s390 vdso implementation of clock_getres keeping a copy of
> hrtimer_resolution in vdso data and using that directly.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
> Note: This patch is independent from the others in this series, hence it
> can be merged singularly by the s390 maintainers.
> 

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
