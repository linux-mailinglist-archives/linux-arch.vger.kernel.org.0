Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8681C14C687
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2020 07:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgA2GdI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jan 2020 01:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgA2GdI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Jan 2020 01:33:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19CB4206F0;
        Wed, 29 Jan 2020 06:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580279587;
        bh=28tEdmx9LwLU3uCpRLofPRp2G5hnsl0hstln6/EfErI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=hpswgamHW1zjyT7O2a0FPMr/N6O6c98hZVj9cwxMj0wb0TseNdIUbahMdqnjEt2MI
         xVOcrIYzJkoZJx5HLe2VlxdXmzVlbPisafSWULSODIosWLIfeqnBYwPRfPIzFL/yNt
         4UYFNxSqh81kJeAcn3CiA9aSzpockL2inznJnyWU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200128072002.79250-7-brendanhiggins@google.com>
References: <20200128072002.79250-1-brendanhiggins@google.com> <20200128072002.79250-7-brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 6/7] kunit: Add 'kunit_shutdown' option
To:     Brendan Higgins <brendanhiggins@google.com>,
        akpm@linux-foundation.org, alan.maguire@oracle.com,
        anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com,
        keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com,
        skhan@linuxfoundation.org, yzaikin@google.com
Cc:     gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org,
        knut.omang@oracle.com, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date:   Tue, 28 Jan 2020 22:33:06 -0800
Message-Id: <20200129063307.19CB4206F0@mail.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Quoting Brendan Higgins (2020-01-27 23:20:01)
> From: David Gow <davidgow@google.com>
>=20
> Add a new kernel command-line option, 'kunit_shutdown', which allows the
> user to specify that the kernel poweroff, halt, or reboot after
> completing all KUnit tests; this is very handy for running KUnit tests
> on UML or a VM so that the UML/VM process exits cleanly immediately
> after running all tests without needing a special initramfs.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Two nitpicks below

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 7fd16feff157e..d3ec1265a72fd 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
>  #include <kunit/test.h>
> +#include <linux/reboot.h>

Should this include come before kunit/test.h? I imagine the order of
includes would be linux, kunit, local?

> =20
>  /*
>   * These symbols point to the .kunit_test_suites section and are defined=
 in
> @@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suit=
es_end[];
> =20
>  #if IS_BUILTIN(CONFIG_KUNIT)
> =20
> +static char *kunit_shutdown;
> +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> +
> +static void kunit_handle_shutdown(void)
> +{
> +       if (!kunit_shutdown)
> +               return;
> +
> +       if (!strcmp(kunit_shutdown, "poweroff")) {
> +               kernel_power_off();
> +       } else if (!strcmp(kunit_shutdown, "halt")) {
> +               kernel_halt();
> +       } else if (!strcmp(kunit_shutdown, "reboot")) {
> +               kernel_restart(NULL);
> +       }

Kernel style would be to not have braces on single line if statements.

> +}
> +
>  static void kunit_print_tap_header(void)
>  {
>         struct kunit_suite * const * const *suites, * const *subsuite;
