Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB8369AF3
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 21:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhDWTbw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 15:31:52 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14542 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWTbv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 15:31:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619206275; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=+/oWbT+YhpS+wVDK/yW7x/UFoHGSzJ0/A7AJlxQ6qZw=; b=xICGoYUqwYJg9caJy4kMRE0eqF5CmyLCoE2AsZvU/1yh6Uh8eNtgtZBWEohyF94tCdnZj0p6
 6Zg5xRenDTLEp3Oa9/p8GqCGK1Etx+EtXw+ndIJNDV6yFZrn0UX+VSp0Jwxfi5VXTntK2Qsp
 ZZPscJ2zxPKcahWB83AlvZha11M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60832082c39407c327b24547 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Apr 2021 19:31:14
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5B2FC4323A; Fri, 23 Apr 2021 19:31:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        PDS_BAD_THREAD_QP_64,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 721CFC433D3;
        Fri, 23 Apr 2021 19:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 721CFC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Arnd Bergmann'" <arnd@kernel.org>,
        "'Randy Dunlap'" <rdunlap@infradead.org>
Cc:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>,
        "'clang-built-linux'" <clang-built-linux@googlegroups.com>,
        "'linux-arch'" <linux-arch@vger.kernel.org>,
        "'Guenter Roeck'" <linux@roeck-us.net>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
In-Reply-To: <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
Subject: RE: ARCH=hexagon unsupported?
Date:   Fri, 23 Apr 2021 14:31:11 -0500
Message-ID: <026d01d73877$386a1920$a93e4b60$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHA6GaHPKlqiI34kZpdCyOyqmKBQAItWAQVAeg2vD8CQqkwGqq8WE2g
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
...
> > There is no current gcc C compiler in the 3 locations that I know of =
to look.
> > The one I tried is v4.6 and it is too old to work with current =
makefiles.
>=20
> Correct, as I understand it , work on gcc was stopped after the 4.6 =
release
> and any testing internally to Qualcomm was done using a patched clang. =
A
> few years ago this was said to be (almost?) entirely upstream, but as =
Nick
> points out it has never been possible to build an upstream hexagon =
kernel
> with an upstream clang.

The critical missing component for a conventional build are =
implementations for compiler-emitted calls to builtins like =
__hexagon_memcpy_likely_aligned_min32bytes_mult8bytes, __hexagon_modsi3 =
-- these are available in the toolchain libraries =
(LIBGCC=3Dlibclang_rt.builtins-hexagon.a) but not in the kernel.  This =
is easy to mitigate and yet disappointing that I did not do so before.  =
I will do it.

There is a hexagon cross toolchain used for testing QEMU (userspace) =
guest code test cases.  This same toolchain can be used to build the =
kernel.  I will share a reference to that toolchain, standby.

-Brian

