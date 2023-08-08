Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974CC773591
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 02:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjHHAwi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 20:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHHAwi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 20:52:38 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DC3170B;
        Mon,  7 Aug 2023 17:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1Z7LbxffltbPK1SHo7fxmLCfBnUSIOxwbsQyOLgeTiM=; b=CvAPVbIdkOl7UYswYzmU74xVVS
        XyjwUWRqWPGxovxX1GsoEzR6Xa3VSDYNRmkw81fkMog8jEpL8xbYMEOWL2rruiwTQ2XbCHP9tDZ1J
        MDrKtpx/owH55NmEOPcsFZB5Xi/vcenF8IIDF9ZGVUuyguUK/I2WMGWBtOFapIskEE7vKRfNZuPq3
        otA2sGbIDLzwQx1PzGu9hqocdTAqJjU+7bOJ/bZrylT0owjevMf3T9t84rXIoTKEGBNbx7r5UBivQ
        S24JILUF8XekC+4K1hSeYWl7r2YQLIDktntBUdKmRT4K26ok3Kg+mABGBlF21o9q9DvU1X6WXB2/w
        mHLKesRg==;
Received: from [177.45.63.19] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qTAxZ-00FAcr-T1; Tue, 08 Aug 2023 02:52:30 +0200
Message-ID: <c4998f14-2804-4291-efe4-f42d07cd9343@igalia.com>
Date:   Mon, 7 Aug 2023 21:52:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] futex: Flag conversion
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, tglx@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>, axboe@kernel.dk,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
References: <20230807121843.710612856@infradead.org>
 <20230807123322.952568452@infradead.org>
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230807123322.952568452@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em 07/08/2023 09:18, Peter Zijlstra escreveu:
> Futex has 3 sets of flags:
> 
>   - legacy futex op bits
>   - futex2 flags
>   - internal flags
> 
> Add a few helpers to convert from the API flags into the internal
> flags.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

> ---
>   kernel/futex/futex.h    |   63 +++++++++++++++++++++++++++++++++++++++++++++---
>   kernel/futex/syscalls.c |   24 ++++++------------
>   kernel/futex/waitwake.c |    4 +--
>   3 files changed, 71 insertions(+), 20 deletions(-)
> 
> --- a/kernel/futex/futex.h
> +++ b/kernel/futex/futex.h
> @@ -5,6 +5,7 @@
>   #include <linux/futex.h>
>   #include <linux/rtmutex.h>
>   #include <linux/sched/wake_q.h>
> +#include <linux/compat.h>
>   
>   #ifdef CONFIG_PREEMPT_RT
>   #include <linux/rcuwait.h>
> @@ -16,8 +17,15 @@
>    * Futex flags used to encode options to functions and preserve them across
>    * restarts.
>    */
> +#define FLAGS_SIZE_8		0x00
> +#define FLAGS_SIZE_16		0x01
> +#define FLAGS_SIZE_32		0x02
> +#define FLAGS_SIZE_64		0x03
> +

Minor nit: for consistent, I would go with SIZE_U8, instead of SIZE_8

> +#define FLAGS_SIZE_MASK		0x03
> +
>   #ifdef CONFIG_MMU
> -# define FLAGS_SHARED		0x01
> +# define FLAGS_SHARED		0x10
>   #else
>   /*
>    * NOMMU does not have per process address space. Let the compiler optimize
> @@ -25,8 +33,57 @@
>    */
>   # define FLAGS_SHARED		0x00
>   #endif
> -#define FLAGS_CLOCKRT		0x02
> -#define FLAGS_HAS_TIMEOUT	0x04
> +#define FLAGS_CLOCKRT		0x20
> +#define FLAGS_HAS_TIMEOUT	0x40
> +#define FLAGS_NUMA		0x80
> +
> +/* FUTEX_ to FLAGS_ */
> +static inline unsigned int futex_to_flags(unsigned int op)
> +{
> +	unsigned int flags = FLAGS_SIZE_32;
> +
> +	if (!(op & FUTEX_PRIVATE_FLAG))
> +		flags |= FLAGS_SHARED;
> +
> +	if (op & FUTEX_CLOCK_REALTIME)
> +		flags |= FLAGS_CLOCKRT;
> +
> +	return flags;
> +}
> +
> +/* FUTEX2_ to FLAGS_ */
> +static inline unsigned int futex2_to_flags(unsigned int flags2)
> +{
> +	unsigned int flags = flags2 & FUTEX2_SIZE_MASK;
> +
> +	if (!(flags2 & FUTEX2_PRIVATE))
> +		flags |= FLAGS_SHARED;
> +
> +	if (flags2 & FUTEX2_NUMA)
> +		flags |= FLAGS_NUMA;
> +
> +	return flags;
> +}
> +
> +static inline bool futex_flags_valid(unsigned int flags)
> +{
> +	/* Only 64bit futexes for 64bit code */
> +	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
> +		if ((flags & FLAGS_SIZE_MASK) == FLAGS_SIZE_64)
> +			return false;
> +	}
> +
> +	/* Only 32bit futexes are implemented -- for now */
> +	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
> +		return false;
> +
> +	return true;
> +} > +
> +static inline unsigned int futex_size(unsigned int flags)
> +{
> +	return 1 << (flags & FLAGS_SIZE_MASK);
> +}
>   
>   #ifdef CONFIG_FAIL_FUTEX
>   extern bool should_fail_futex(bool fshared);
> --- a/kernel/futex/syscalls.c
> +++ b/kernel/futex/syscalls.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
> -#include <linux/compat.h>
>   #include <linux/syscalls.h>
>   #include <linux/time_namespace.h>
>   
> @@ -85,15 +84,12 @@ SYSCALL_DEFINE3(get_robust_list, int, pi
>   long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
>   		u32 __user *uaddr2, u32 val2, u32 val3)
>   {
> +	unsigned int flags = futex_to_flags(op);
>   	int cmd = op & FUTEX_CMD_MASK;
> -	unsigned int flags = 0;
>   
> -	if (!(op & FUTEX_PRIVATE_FLAG))
> -		flags |= FLAGS_SHARED;
> -
> -	if (op & FUTEX_CLOCK_REALTIME) {
> -		flags |= FLAGS_CLOCKRT;
> -		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI &&
> +	if (flags & FLAGS_CLOCKRT) {
> +		if (cmd != FUTEX_WAIT_BITSET &&
> +		    cmd != FUTEX_WAIT_REQUEUE_PI &&
>   		    cmd != FUTEX_LOCK_PI2)
>   			return -ENOSYS;
>   	}
> @@ -201,21 +197,19 @@ static int futex_parse_waitv(struct fute
>   	unsigned int i;
>   
>   	for (i = 0; i < nr_futexes; i++) {
> +		unsigned int flags;
> +
>   		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
>   			return -EFAULT;
>   
>   		if ((aux.flags & ~FUTEX2_VALID_MASK) || aux.__reserved)
>   			return -EINVAL;
>   
> -		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
> -			if ((aux.flags & FUTEX2_SIZE_MASK) == FUTEX2_SIZE_U64)
> -				return -EINVAL;
> -		}
> -
> -		if ((aux.flags & FUTEX2_SIZE_MASK) != FUTEX2_SIZE_U32)
> +		flags = futex2_to_flags(aux.flags);
> +		if (!futex_flags_valid(flags))
>   			return -EINVAL;
>   
> -		futexv[i].w.flags = aux.flags;
> +		futexv[i].w.flags = flags;
>   		futexv[i].w.val = aux.val;
>   		futexv[i].w.uaddr = aux.uaddr;
>   		futexv[i].q = futex_q_init;
> --- a/kernel/futex/waitwake.c
> +++ b/kernel/futex/waitwake.c
> @@ -419,11 +419,11 @@ static int futex_wait_multiple_setup(str
>   	 */
>   retry:
>   	for (i = 0; i < count; i++) {
> -		if ((vs[i].w.flags & FUTEX_PRIVATE_FLAG) && retry)
> +		if (!(vs[i].w.flags & FLAGS_SHARED) && retry)
>   			continue;
>   
>   		ret = get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
> -				    !(vs[i].w.flags & FUTEX_PRIVATE_FLAG),
> +				    vs[i].w.flags & FLAGS_SHARED,
>   				    &vs[i].q.key, FUTEX_READ);
>   
>   		if (unlikely(ret))
> 
> 
