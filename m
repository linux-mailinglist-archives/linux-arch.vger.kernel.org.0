Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C613E3C8607
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhGNOZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 10:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhGNOZm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jul 2021 10:25:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC8C06175F;
        Wed, 14 Jul 2021 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hbo3XSupWSCKSRuwZnseKrr9Q5lRrR0wScUsbhREDp8=; b=jtal+prTNziB/n3KcqRrm7KUsO
        fe10Y7R3s6gWqkCEXhbA10Ubl1nKC3tuGMVphwhAWYxsjSYuGoIRYlTiukdVf0Ujb4WZhC26M+nwL
        724qGyU3+2fl93eX/58UegwyIKrvkxYW7ZYiEiOuQMF8HZKTu+TWeWAJWbrmq2LOf2w8KaV9T/0UW
        1LX3Vss0kbxRfgjVh5Uo6vNfO/aisTkKdpSMxS8AJxeBuc4fI2oTqrGQcVvxWFoizMOa918tnpLH4
        aJ+7IOy1MwrK2bCJaz79jI00XExW2M7TtCw7x7OJJY0cLcsEsa4Ot4Jl2Al8JihiOgijvyXEDayAE
        v3tyNRDw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3fm4-002HPc-AF; Wed, 14 Jul 2021 14:22:23 +0000
Date:   Wed, 14 Jul 2021 15:22:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH] Decouple build from userspace headers
Message-ID: <YO7zEFNSXOY8pKCQ@infradead.org>
References: <YO3txvw87MjKfdpq@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO3txvw87MjKfdpq@localhost.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> -#define signals_blocked false
> +#define signals_blocked 0

Why can't we get at the kernel definition of false here?

> new file mode 100644
> --- /dev/null
> +++ b/include/stdarg.h
> @@ -0,0 +1,9 @@
> +#ifndef _LINUX_STDARG_H
> +#define _LINUX_STDARG_H
> +typedef __builtin_va_list __gnuc_va_list;
> +typedef __builtin_va_list va_list;
> +#define va_start(v, l)	__builtin_va_start(v, l)
> +#define va_end(v)	__builtin_va_end(v)
> +#define va_arg(v, T)	__builtin_va_arg(v, T)
> +#define va_copy(d, s)	__builtin_va_copy(d, s)
> +#endif

Empty lines before and after the include guards would be nice.

What do we need the __gnuc_va_list typedef for?

Otherwise this looks great.  As a follow on maybe move the new header
to <linux/stdarg.h> to make clear to everyone that we are using our
own version.
