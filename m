Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 522236870E
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2019 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfGOKaA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jul 2019 06:30:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:56018 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbfGOKaA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jul 2019 06:30:00 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hmyF1-0000zw-A2; Mon, 15 Jul 2019 13:29:55 +0300
Subject: Re: [PATCH] generic arch_futex_atomic_op_inuser() cleanup
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
References: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <3d9eef14-4059-0f8a-e76f-a8a09d730913@virtuozzo.com>
Date:   Mon, 15 Jul 2019 13:29:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks like this code is dead and therefore looks strange.
I've found it during manual code review and decided to send patch
to pay your attention to this problem.
Probably it's better to remove this code at all?

On 7/15/19 1:27 PM, Vasily Averin wrote:
> Access to 'op' variable does not require pagefault_disable(),
> 'ret' variable should be initialized before using,
> 'oldval' variable can be replaced by constant.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  include/asm-generic/futex.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
> index 8666fe7f35d7..e9a9655d786d 100644
> --- a/include/asm-generic/futex.h
> +++ b/include/asm-generic/futex.h
> @@ -118,9 +118,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  static inline int
>  arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
>  {
> -	int oldval = 0, ret;
> -
> -	pagefault_disable();
> +	int ret = 0;
>  
>  	switch (op) {
>  	case FUTEX_OP_SET:
> @@ -132,10 +130,8 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
>  		ret = -ENOSYS;
>  	}
>  
> -	pagefault_enable();
> -
>  	if (!ret)
> -		*oval = oldval;
> +		*oval = 0;
>  
>  	return ret;
>  }
> 
