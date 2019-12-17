Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4D1225FF
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2019 08:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfLQH6h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 02:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfLQH6h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 02:58:37 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76942072D;
        Tue, 17 Dec 2019 07:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576569516;
        bh=PKix5UkE1pjZ91wIWtn3Cxmm/NgC7fD1N+XCGrlerOc=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=KunVHOnJ26M+HY0Zbm7xsxRl0nadBs5iWR37RatXykPyxoODmRASWVsqKSFu9WXN7
         i9gOOh9fLtJCgcZwWrT2yE0XXVs4xQB2pNGnlkSi9yQI/KkVwK+TIRGCmYE3RyC6Cn
         496v2oAjGt5DZ1isIRWinAShFPZr0iljBJBiG/Kk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216220555.245089-5-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com> <20191216220555.245089-5-brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org,
        knut.omang@oracle.com, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        akpm@linux-foundation.org, alan.maguire@oracle.com,
        anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        davidgow@google.com, jdike@addtoit.com, keescook@chromium.org,
        richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org,
        yzaikin@google.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 4/6] init: main: add KUnit to kernel init
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 23:58:36 -0800
Message-Id: <20191217075836.C76942072D@mail.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Quoting Brendan Higgins (2019-12-16 14:05:53)
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().

Yes, but why? Is it desired to run the unit tests earlier than opening
the console or something?

>=20
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 978086cfd257d..ca880224c0bab 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -32,12 +32,10 @@ static bool kunit_run_all_tests(void)
>         return !has_test_failed;
>  }
> =20
> -static int kunit_executor_init(void)
> +int kunit_executor_init(void)

Should be marked __init? Even before this patch presumably.

>  {
>         if (kunit_run_all_tests())
>                 return 0;
>         else
>                 return -EFAULT;
>  }
> -
> -late_initcall(kunit_executor_init);
