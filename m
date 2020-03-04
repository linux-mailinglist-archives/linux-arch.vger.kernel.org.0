Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9471179C28
	for <lists+linux-arch@lfdr.de>; Thu,  5 Mar 2020 00:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbgCDXKx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 18:10:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388400AbgCDXKx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 18:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=wrwrHXw+LNOFZFFMg/FDeMJ6lH0Xav8TTsXnysaRhrg=; b=tw5PI4uR1ew0T6GT3etvcIkt+p
        +0P2jwaX6zsPoCndUQbxsG+QjnaokBqJWLoEEWdijEHx+9dOsWDEVEErTXnfe0qA1Y9QhRdU0XZ/S
        qZIEVABVFOALiLdk6tLcO5jROd/WNi75N0iWSebavnHrXc99rpy90XIuY0L01YHhtryDivK96iWNx
        6wPXyPw7jazYFat2epMU79nM8khDVBmZKzgjh0S/vwwl88V5xDiZNA68vZm7jyTJTniateEn9ZKvj
        G7EGdpU0I9DAec1y/4EwvI/Sa4FuofkuW2kTRsnVyfaGUUB5xDMKL6hjLKQHfJAKW4e1mCbUAINyL
        LVloTZCQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9dAB-0005vr-1w; Wed, 04 Mar 2020 23:10:51 +0000
Subject: Re: [PATCH v3 7/7] Documentation: Add kunit_shutdown to
 kernel-parameters.txt
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200228012036.15682-8-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <22704191-ce7e-cac7-f7a0-1db822b20d84@infradead.org>
Date:   Wed, 4 Mar 2020 15:10:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228012036.15682-8-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/27/20 5:20 PM, Brendan Higgins wrote:
> Add kunit_shutdown, an option to specify that the kernel shutsdown after
> running KUnit tests, to the kernel-parameters.txt documentation.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Hi Brendan,

To be consistent with other parameters in this file:

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index dbc22d6846275..6ad63e98916f9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2099,6 +2099,14 @@
>  			0: force disabled
>  			1: force enabled
>  
> +	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after

that line should have an '=' sign after the param name:
	kunit_shutdown=

> +			running built-in tests. Tests configured as modules will
> +			not be run.
> +			Default:	(flag not present) don't shutdown
> +			poweroff:	poweroff the kernel after running tests
> +			halt:		halt the kernel after running tests
> +			reboot:		reboot the kernel after running tests
> +
>  	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
>  			Default is 0 (don't ignore, but inject #GP)
>  
> 

thanks.
-- 
~Randy

