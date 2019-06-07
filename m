Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8D385EE
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFGIHT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 04:07:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfFGIHT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 04:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KMTOjZOt6BKNdwNx8Ebfe50Na45GQkzWalc7XXT6zV4=; b=gUrzDU4WY3ZDbo8lcxgsikvBt
        Gk/hCRgMJufxg1JP0EiHMgv3rW3FTF5YlIOF5lwojw0Vtmugp/lHlLizM9NRf/e3yKeUqmCd0Zemq
        zx8uNPPPRNfImn+2IFgekQpgFW1/oQy/S2EESOhkYQM/IXXSqv4E/3YDd8nQU8v05iO7ozzW4EGPN
        fwb++MbbuniaJF04HclowhKkT/iaHsGrLExCsLo9SQgROaxNItKKT3ETdE49oHREjTn6pPBhFJtEg
        uAOrOlsb7mWX4fTtopbZirLCbiKs5iuYoa0qGCa8QrZ2hgGEm4z7mb3ANt1nwEQJW5cusG+tB+kxh
        58BwvwZHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZ9tz-00013c-Mi; Fri, 07 Jun 2019 08:07:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 387A1202CD6B2; Fri,  7 Jun 2019 10:07:06 +0200 (CEST)
Date:   Fri, 7 Jun 2019 10:07:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 07/14] x86/cet/ibt: Add arch_prctl functions for IBT
Message-ID: <20190607080706.GS3419@hirez.programming.kicks-ass.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
 <20190606200926.4029-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200926.4029-8-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 06, 2019 at 01:09:19PM -0700, Yu-cheng Yu wrote:

> +static int handle_bitmap(unsigned long arg2)
> +{
> +	unsigned long addr, size;
> +
> +	if (get_user(addr, (unsigned long __user *)arg2) ||
> +	    get_user(size, (unsigned long __user *)arg2 + 1))
> +		return -EFAULT;
> +
> +	return cet_setup_ibt_bitmap(addr, size);
> +}


> +	/*
> +	 * Allocate legacy bitmap and return address & size to user.
> +	 */
> +	case ARCH_X86_CET_SET_LEGACY_BITMAP:
> +		return handle_bitmap(arg2);

AFAICT it does exactly the opposite of that comment; it gets the address
and size from userspace and doesn't allocate anything at all.
