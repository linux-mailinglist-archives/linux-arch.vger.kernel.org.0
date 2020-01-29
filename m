Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7737414C679
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2020 07:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgA2G1K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jan 2020 01:27:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgA2G1K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Jan 2020 01:27:10 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2A22067C;
        Wed, 29 Jan 2020 06:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580279229;
        bh=oXTODPPEtyYViFG/qy2k/m0F+1/ivnHKdVwxHe04wKU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=sNsNTd92426V//z/W5gIgopUCS5dFpSf6Upp8q1zU/uFDCItd0Kuk0PA5pq3kwdkE
         GcEru2eHhJoohX9UtMCtvC7h/cvaPOTmXTwnPO6RVWIzmGBqaZSV7GchFldApPcRzD
         Zrnd6bZFPXrdvZMGKU8JLp5IVhMfBIPkyO6Df30s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200128072002.79250-8-brendanhiggins@google.com>
References: <20200128072002.79250-1-brendanhiggins@google.com> <20200128072002.79250-8-brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
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
Date:   Tue, 28 Jan 2020 22:27:08 -0800
Message-Id: <20200129062709.5B2A22067C@mail.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Quoting Brendan Higgins (2020-01-27 23:20:02)
> Add kunit_shutdown, an option to specify that the kernel shutsdown after
> running KUnit tests, to the kernel-parameters.txt documentation.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index ade4e6ec23e03..0472b02ce16bb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2054,6 +2054,13 @@
>                         0: force disabled
>                         1: force enabled
> =20
> +       kunit_shutdown  [KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel a=
fter
> +                       running tests.
> +                       Default:        (flag not present) don't shutdown
> +                       poweroff:       poweroff the kernel after running=
 tests.
> +                       halt:           halt the kernel after running tes=
ts.
> +                       reboot:         reboot the kernel after running t=
ests.

Maybe drop the full stops on the short descriptions.

Otherwise,

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

