Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583AF12268A
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2019 09:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLQISq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 03:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfLQISp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 03:18:45 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141F4206A5;
        Tue, 17 Dec 2019 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576570725;
        bh=YNGFt7tShZP7l2gj4FQAbDV6Pvp7fIytyh/Xoh1BP3Y=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=ytNsQJW37JnBBre+73DH/cMIClGb7UAc9BPxxSQ7b3H/lnt16NsONH/BbeWk4I10B
         VLmE/R8IYa9FjEsBMXuYSsNiHCEQYhKSDKBP2U4d7abNHXJK02tl0IXZbf44NP8ds8
         lyxanqz/E3uu8KENO2yvY4g5zHyEBQwSDLWo12qI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216220555.245089-6-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com> <20191216220555.245089-6-brendanhiggins@google.com>
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
Subject: Re: [RFC v1 5/6] kunit: test: add test plan to KUnit TAP format
User-Agent: alot/0.8.1
Date:   Tue, 17 Dec 2019 00:18:44 -0800
Message-Id: <20191217081845.141F4206A5@mail.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Quoting Brendan Higgins (2019-12-16 14:05:54)
> TAP 14 allows an optional test plan to be emitted before the start of
> the start of testing[1]; this is valuable because it makes it possible
> for a test harness to detect whether the number of tests run matches the
> number of tests expected to be run, ensuring that no tests silently
> failed.
>=20
> Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-=
version-14-specification.md#the-plan
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

