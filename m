Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167AA369B46
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 22:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbhDWU1b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 16:27:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50342 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhDWU1b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 16:27:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619209614; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=DSbiIptFyG6M9pjdmGFsplYKvwsvZF7o76XdO+3XPjE=; b=TarOUvX+SUyRJaRJl1MpVf3MS0Ryay4ZGyJ6gnR2OEOAM9iI+0aLNXeHuyAjadMt3i4HTdMC
 GLMVFjr9G4fwn/oPOc+6DTSiRuZDhnC81rpA51lVn/T+bnupT0vWbBTy0KRxR6hZaU8Kjuyt
 6HLssbCdF7aTwMlR7Gcnypuo3qg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60832d7e74f773a664d1ccb1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Apr 2021 20:26:38
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9CEFFC433F1; Fri, 23 Apr 2021 20:26:37 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7A2AC433D3;
        Fri, 23 Apr 2021 20:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7A2AC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     <bcain@codeaurora.org>, "'Arnd Bergmann'" <arnd@kernel.org>,
        "'Randy Dunlap'" <rdunlap@infradead.org>
Cc:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>,
        "'clang-built-linux'" <clang-built-linux@googlegroups.com>,
        "'linux-arch'" <linux-arch@vger.kernel.org>,
        "'Guenter Roeck'" <linux@roeck-us.net>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com> <026d01d73877$386a1920$a93e4b60$@codeaurora.org>
In-Reply-To: <026d01d73877$386a1920$a93e4b60$@codeaurora.org>
Subject: RE: ARCH=hexagon unsupported?
Date:   Fri, 23 Apr 2021 15:26:34 -0500
Message-ID: <027401d7387e$f5630120$e0290360$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHA6GaHPKlqiI34kZpdCyOyqmKBQAItWAQVAeg2vD8CQqkwGgKUjDBFqqfGhmA=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> -----Original Message-----
> From: bcain=3Dcodeaurora.org@codeaurora.org
...=20
> There is a hexagon cross toolchain used for testing QEMU (userspace) =
guest
> code test cases.  This same toolchain can be used to build the kernel. =
 I will
> share a reference to that toolchain, standby.

It's published as a container in the Gitlab Container Registry.  You can =
use docker/podman to pull =
"registry.gitlab.com/qemu-project/qemu/qemu/debian-hexagon-cross" in =
order to use it.

-Brian

