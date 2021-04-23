Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAFF369C85
	for <lists+linux-arch@lfdr.de>; Sat, 24 Apr 2021 00:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhDWW0P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 18:26:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36680 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbhDWW0P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Apr 2021 18:26:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619216738; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=wMOnQpi7ovLRfONEKjZgRwn/sKBHpGwI4nuW9iNQ37g=; b=lIAJB8NQdadJZNH1XQQgxhfYkc/0l93vakl2UpLd0u27FQPHrR/mEu/DRbJs2pNC/4ZFGwFU
 1t2TT66fEdvx8HMWQAjmm12ljtHj7t+lF/JoeTB3x5+UFQ/S6w2mNeVdFWUMwdAD4ZrfNTq3
 BzUbYQIMRFNH41uxpk0V8hMhtaE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60834959f34440a9d4c428b1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Apr 2021 22:25:29
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0FD11C43217; Fri, 23 Apr 2021 22:25:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        PDS_BAD_THREAD_QP_64,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4491C4338A;
        Fri, 23 Apr 2021 22:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4491C4338A
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
        "'Guenter Roeck'" <linux@roeck-us.net>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com> <026d01d73877$386a1920$a93e4b60$@codeaurora.org> <027401d7387e$f5630120$e0290360$@codeaurora.org> <24da08a4-e055-d8ac-8214-97d86cdcfd3d@infradead.org>
In-Reply-To: <24da08a4-e055-d8ac-8214-97d86cdcfd3d@infradead.org>
Subject: RE: ARCH=hexagon unsupported?
Date:   Fri, 23 Apr 2021 17:25:22 -0500
Message-ID: <02a501d7388f$8dfb3b90$a9f1b2b0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHA6GaHPKlqiI34kZpdCyOyqmKBQAItWAQVAeg2vD8CQqkwGgKUjDBFAndwqiQA36lpqaqNLeCw
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
...
> > It's published as a container in the Gitlab Container Registry.  You =
can use
> docker/podman to pull "registry.gitlab.com/qemu-
> project/qemu/qemu/debian-hexagon-cross" in order to use it.
>=20
> Hi Brian,
>=20
> Maybe that will be useful to someone.
>=20
> However, I am looking for something like a tarball that I can download =
and
> deploy locally, like one can find at these locations:
>=20
> https://toolchains.bootlin.com/
> https://download.01.org/0day-ci/cross-package/
> https://mirrors.edge.kernel.org/pub/tools/crosstool/

Randy,

	I 100% agree, I would prefer a tarball myself.  I have been working =
with the team to produce the tarball and we haven't been able to deliver =
that yet.  No good excuses here, only bad ones: somewhat tied up in =
process bureaucracy.

I can share the recipe that was used to build the toolchain in the =
container.  No Dockerfile required, just a shell script w/mostly cmake + =
make commands.  All of the sources are public, but musl is a =
downstream-public repo because we haven't landed the hexagon support in =
upstream musl yet.

-Brian

