Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBAC23C583
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 08:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHEGBF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 02:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgHEGBC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Aug 2020 02:01:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 327A020842;
        Wed,  5 Aug 2020 06:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596607262;
        bh=GwODHQP5f3m1ZPOaXoOR2GBwrPzaDHh5wSknqwF8wIM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R7sn2dyDd5RQkvjd02GllD6XEFhU/fWt1RyrqkPk7FXA3d8GUX+nL8YqafM92yU4R
         7gcrKWgqfj52viL9XuEU+zze7w0QZ1hF1m/K7T9xdmP53NjhNsfom6oswJIzSO7wNU
         9eDfZKv8ytYNuD8zDfkXPi6xpZjohJdWmjtdnfAc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200804204745.987648-6-brendanhiggins@google.com>
References: <20200804204745.987648-1-brendanhiggins@google.com> <20200804204745.987648-6-brendanhiggins@google.com>
Subject: Re: [PATCH v6 5/5] Documentation: kunit: add a brief blurb about kunit_test_suite
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        akpm@linux-foundation.org, alan.maguire@oracle.com,
        anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com,
        keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com,
        skhan@linuxfoundation.org, yzaikin@google.com
Date:   Tue, 04 Aug 2020 23:01:01 -0700
Message-ID: <159660726105.1360974.11438808412702251122@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Quoting Brendan Higgins (2020-08-04 13:47:45)
> Add a brief blurb saying how and when the kunit_test_suite() macro
> works to the usage documentation.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-=
tools/kunit/usage.rst
> index 3c3fe8b5feccf..961d3ea3ca19a 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -211,6 +211,11 @@ KUnit test framework.
>  .. note::
>     A test case will only be run if it is associated with a test suite.
> =20
> +``kunit_test_suite(...)`` is a macro which tells the linker to put the s=
pecified
> +test suite in a special linker section so that it can be run by KUnit ei=
ther
> +after late_init, or when the test module is loaded (depending on whether=
 the

"late_init" probably needs some italics or something, but otherwise.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
