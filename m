Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D518270ADE
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 07:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgISFci (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 01:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISFci (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 01:32:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6613C0613CE;
        Fri, 18 Sep 2020 22:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5l9UdMdT1kpasilHhGsGPjscN8WXGeNxjxm4ligfssk=; b=PklvwxxyywnV/HztolsBfh+KxB
        p+DlUY5tfy5HxdLj9mLod7nWbg9/RLtsgLrCV8I/JaVHsrldswQqbhkGeWbX5F4Hgz8jPiHSv73wh
        ZeB9Gm6dscU1ihdBAlLiCp443+GLOyVy4v4hxP0Va/Z98gWKIWifnpucMizD7IeNpdotxVVrDdu1u
        A57dTGJOMfP7zxeb7K4kYxPGHjVR/PubVK6dABHRBMqENzmWy2ssSqUxhy+7izdy4SFo7ghTdQfuQ
        VQTOzvfFnDAF/+Wuw/hyGy1K1lZWTThEFcw2YlUf2mPME0FlHAP5RWon7gnPFOJYdV2Nb1spKRfhN
        tmGxk44A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJVU9-0000dS-Kx; Sat, 19 Sep 2020 05:32:33 +0000
Date:   Sat, 19 Sep 2020 06:32:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/9] ARM: oabi-compat: rework epoll_wait/epoll_pwait
 emulation
Message-ID: <20200919053233.GH30063@infradead.org>
References: <20200918124624.1469673-1-arnd@arndb.de>
 <20200918124624.1469673-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918124624.1469673-6-arnd@arndb.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> index 855aa7cc9b8e..156880943c16 100644
> --- a/arch/arm/include/asm/syscall.h
> +++ b/arch/arm/include/asm/syscall.h
> @@ -28,6 +28,17 @@ static inline int syscall_get_nr(struct task_struct *task,
>  	return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;
>  }
>  
> +static inline bool __in_oabi_syscall(struct task_struct *task)
> +{
> +	return IS_ENABLED(CONFIG_OABI_COMPAT) &&
> +		(task_thread_info(task)->syscall & __NR_OABI_SYSCALL_BASE);
> +}
> +
> +static inline bool in_oabi_syscall(void)
> +{
> +	return __in_oabi_syscall(current);
> +}
> +

Maybe split these infrastructure additions into a separate helper?

> +#if !defined(CONFIG_ARM) || !defined(CONFIG_OABI_COMPAT)
> +/* ARM OABI has an incompatible struct layout and needs a special handler */
> +static inline struct epoll_event __user *
> +epoll_put_uevent(__poll_t revents, __u64 data,
> +		 struct epoll_event __user *uevent)
> +{
> +	if (__put_user(revents, &uevent->events) ||
> +	    __put_user(data, &uevent->data))
> +		return NULL;
> +
> +	return uevent+1;
> +}
> +#else
> +struct epoll_event __user *
> +epoll_put_uevent(__poll_t revents, __u64 data,
> +		 struct epoll_event __user *uevent);
> +#endif

So after you argued for this variant I still have minor nitpicks:

I alway find positive ifdefs better where possible, e.g.

#if defined(CONFIG_ARM) && defined(CONFIG_OABI_COMPAT)
external declaration here
#else
the real thing
#endif

but I still find the fact that the native case goes into the arch
helper a little weird.
