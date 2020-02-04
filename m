Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C097151664
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 08:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgBDHTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 02:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgBDHTQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Feb 2020 02:19:16 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF32B21582;
        Tue,  4 Feb 2020 07:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580800755;
        bh=gsyVytQK3lixYjo33kenNe/YEUvIbsBpfPWPkn8VMak=;
        h=In-Reply-To:References:From:To:Subject:Cc:Date:From;
        b=YOESc0J/SHEpC/EWipMosXdbRmdp9/hgZzW02aTkN02BWA7qg8SdYtNgTEc9CMzE4
         I2IL8ok2TF1bqiwmH14mE92yxsGbgdBhHidnG9n/DbA8zO2mvbFv0qd3pLEth4flUR
         FNDsbDpC6W63KwlisnBO2WxUXSS+iuHw99Nwe4lY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
References: <20200130230812.142642-1-brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        akpm@linux-foundation.org, alan.maguire@oracle.com,
        anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com,
        keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com,
        skhan@linuxfoundation.org, yzaikin@google.com
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch all KUnit tests
Cc:     gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org,
        knut.omang@oracle.com, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 23:19:14 -0800
Message-Id: <20200204071915.AF32B21582@mail.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Quoting Brendan Higgins (2020-01-30 15:08:05)
> ## TL;DR
>=20
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.

Is there any diff from v1 to v2? I don't know what changed, but I see
that my Reviewed-by tag has been put on everything, so I guess
everything I said was addressed or discussed in the previous round.

