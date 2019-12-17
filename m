Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5AD12268E
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2019 09:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLQIVS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 03:21:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLQIVS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 03:21:18 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5D98206EC;
        Tue, 17 Dec 2019 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576570878;
        bh=nIYiVC67apMi4Vst3H8kFTSVpFYsff/+7MatcMr+Tow=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=EL8mMcuO1ffPqKAzobis1NhERxOvU+G+V+yGbKVNXuSfT8pj3orl0SpkjOka0LRJz
         SjkZY+NInGTUdJ2tyvNNcczUXOYzoNRl5BNgta8iXZ4Cag9ElC1ceMUGmsWJiGavw6
         hwDz5F8j8cYkw9F1WA1SNn4YY1PhFWfd+QvykR5M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216220555.245089-2-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com> <20191216220555.245089-2-brendanhiggins@google.com>
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
Subject: Re: [RFC v1 1/6] vmlinux.lds.h: add linker section for KUnit test suites
User-Agent: alot/0.8.1
Date:   Tue, 17 Dec 2019 00:21:17 -0800
Message-Id: <20191217082117.E5D98206EC@mail.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Quoting Brendan Higgins (2019-12-16 14:05:50)
> Add a linker section where KUnit can put references to its test suites.
> This patch is the first step in transitioning to dispatching all KUnit
> tests from a centralized executor rather than having each as its own
> separate late_initcall.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>

I thought your SoB should come last given you're sending the patch.

Otherwise,

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

