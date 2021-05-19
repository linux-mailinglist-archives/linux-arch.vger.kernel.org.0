Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D07D389291
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbhESPaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 11:30:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26132 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344451AbhESPaA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 11:30:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621438120; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=FQqOtTWuOS13BN8O02FNaShatp6JGVjdDGcLP0U0neg=; b=KIHeduoukiVtM/2ekPqn0HoTb/5H7QTwfEEP5Q+nK5RRd0tj/SHnq7+m7AhGkIAj5nFpR/xR
 0UlhoWMRPQVnrnb5646TLSZYRCoP2/2j5P/frKsSz5Ecd2DBkANJwMCLuyPj7b/W4wSneqLL
 xsR1AsPCEsjHvoUQH+vS6TCV7H8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60a52e8b2bff04e53b42c44e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 May 2021 15:28:11
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F231BC43217; Wed, 19 May 2021 15:28:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        PDS_BAD_THREAD_QP_64,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4C4FC433D3;
        Wed, 19 May 2021 15:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4C4FC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Randy Dunlap'" <rdunlap@infradead.org>,
        "'Arnd Bergmann'" <arnd@kernel.org>
Cc:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>,
        "'clang-built-linux'" <clang-built-linux@googlegroups.com>,
        "'linux-arch'" <linux-arch@vger.kernel.org>,
        "'Guenter Roeck'" <linux@roeck-us.net>,
        "Sid Manning" <sidneym@quicinc.com>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com> <026d01d73877$386a1920$a93e4b60$@codeaurora.org> <027401d7387e$f5630120$e0290360$@codeaurora.org> <24da08a4-e055-d8ac-8214-97d86cdcfd3d@infradead.org> <02a501d7388f$8dfb3b90$a9f1b2b0$@codeaurora.org> <42ab3057-3b43-7f98-6387-6e79761d2d3f@infradead.org>
In-Reply-To: <42ab3057-3b43-7f98-6387-6e79761d2d3f@infradead.org>
Subject: RE: ARCH=hexagon unsupported?
Date:   Wed, 19 May 2021 10:28:07 -0500
Message-ID: <06a701d74cc3$92bc59f0$b8350dd0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHA6GaHPKlqiI34kZpdCyOyqmKBQAItWAQVAeg2vD8CQqkwGgKUjDBFAndwqiQA36lpqQF/q2VJAknosvyql0WCYA==
Content-Language: en-us
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
...
> > Randy,
> >
> > 	I 100% agree, I would prefer a tarball myself.  I have been working =
with
> the team to produce the tarball and we haven't been able to deliver =
that yet.
> No good excuses here, only bad ones: somewhat tied up in process
> bureaucracy.
> >
> > I can share the recipe that was used to build the toolchain in the =
container.
> No Dockerfile required, just a shell script w/mostly cmake + make =
commands.
> All of the sources are public, but musl is a downstream-public repo =
because we
> haven't landed the hexagon support in upstream musl yet.
>=20
> Hi Brian,
> I can wait. :)

Randy, thanks for your patience.  We don't quite have all the kinks =
worked out for a release process but I have worked with the Linaro team =
to produce a clang-based cross toolchain and we can share a link:

https://codelinaro.jfrog.io/artifactory/codelinaro-qemu/2021-05-12/clang+=
llvm-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz

Contents:
- clang+llvm+lld+libunwind+libcxx+libcxxabi built from `llvmorg-12.0.0` =
release
- `qemu-hexagon` binary (scalar core only!) built from upstream =
github.com/qemu/qemu repo `15106f7dc3290ff3254611f265849a314a93eb0e`
- headers from linux kernel 5.6.18
- C library built from github.com/quic/musl commit =
aff74b395fbf59cd7e93b3691905aa1af6c0778c
- unabridged build details in =
https://github.com/quic/qemu/tree/d26f3843c794d9d9b17b637550dc3b5a2bacd83=
7/quic/container

Once we're able to produce releases on a more regular basis we should be =
able to share a hexagon-linux-user QEMU that can do scalar+vector.  And =
some time after that a sysemu-capable qemu.

Our process for this first run did not include a signature for the build =
tarball, and that is regrettable.  It will be included next time around. =
 I have produced the sha256 signature below (post hoc) of the tarball =
that I tested:

	55c51e8289cc21e6779cfc3b18bb9ad02632fc52d3c3a91bf6fdb4c8f578c84c  =
clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz

-Brian

