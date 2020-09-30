Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E3B27E64D
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 12:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgI3KNR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 30 Sep 2020 06:13:17 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:46488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgI3KNR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Sep 2020 06:13:17 -0400
X-Greylist: delayed 926 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 06:13:17 EDT
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id E608E9F67144460A1187;
        Wed, 30 Sep 2020 17:57:44 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 30 Sep 2020 17:57:44 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 30 Sep 2020 17:57:44 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locking/atomic/bitops: Fix some wrong param names in
 comments
Thread-Topic: [PATCH] locking/atomic/bitops: Fix some wrong param names in
 comments
Thread-Index: AdaXEBX7ZwOiGoS6QqevemLv2dOXxg==
Date:   Wed, 30 Sep 2020 09:57:44 +0000
Message-ID: <efc3919563c249ceab488d682e19ee17@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Friendly ping :)
> Correct the wrong param name @addr to @p.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/asm-generic/bitops/lock.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h

