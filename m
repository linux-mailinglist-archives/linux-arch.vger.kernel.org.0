Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11989644589
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 15:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiLFOXV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 09:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiLFOXU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 09:23:20 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C92196;
        Tue,  6 Dec 2022 06:23:20 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BECC95C0124;
        Tue,  6 Dec 2022 09:23:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Dec 2022 09:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670336599; x=
        1670422999; bh=1i9KAnaualAN3RJiLZ4IkdDGmbffUXeErCmYosOp25c=; b=s
        FxqxZVccTvrAXSJixF7mmB3bOZevz2gn7d7/ecmiVOiUj4PZApFqKuz07m5BNO1i
        Dd5Ei4Wkofmh2veGKJ28UtevrrNaU24BL62h722Nur4mVuJsut28ik9HN+QNZkjx
        0p5u6Qo+TioisMJ5wSZYeKsiaF8qUvqcZKu527LUuIyrcmGj5HDnlXNPYm1tU4Rl
        U6JNn8C6ojR3YXa6p1cAUWM1rHjx617nihG/pefdZx/mSrP6qWtlJESR6W1X0T97
        3ZeW9hZFRGOUePrjdn2wxtEQDD33hDivqaOIb9lcBiMQaARVwTo6jpMLBgGtUZtV
        l2cr4iK/DCg47BFWwjlcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670336599; x=
        1670422999; bh=1i9KAnaualAN3RJiLZ4IkdDGmbffUXeErCmYosOp25c=; b=s
        OcEyCaMR7pMIDNeW/OfFpIFAHOryMp/U1ACR1PAvrcAIeiofmNK0THWI0dF8hYzq
        JRD/QwC8uF64Y3XRhGY5i3sS6rwPJ9/BJg8XfjEw2j5KPf/9Mi5WuQ7lG8aYoFMK
        Zij6PBJBo6o/sJ895NMdWZhMvJQreND80fk4b+2eprgJvkNAo9qOkMGoLCgD2RfB
        GQ7EZxvYkDUS7bc8gleWz3xCdIek120pFyWL8PtB51hPQm2r2KviW3AW1SH3MQOQ
        dJiHDLCNKk84FzfZ4OMSj0ZJuztJwkBZuRYiOpaqDJnCQ21GyCxH/kKdkCFvTQ19
        /cfP9TfN+rCo+xVuC/rxA==
X-ME-Sender: <xms:V1CPY_v67UVpdFYyqaoX45LVPwOvO2sCO6YLAEwAAuqdOGZMEh-Lsw>
    <xme:V1CPYwd7K-ed--dV1upm4MXkG3N5D6FAq6FhMUZZwlut9bdaStVdHgxOfCusrmuoL
    Z6-EVYMQi12Cipwij8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeigdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:V1CPYywE4PFZf7AKSy4CU27sjoyxJ147xXmp6o7U_aHIlEnrZxC7eg>
    <xmx:V1CPY-O6lIV-T5zQzXQGSV_Vem1I0q0Z8-ahB100ypDRaBTJomvPxA>
    <xmx:V1CPY_9Iw9_DAUtuRjcHYbD34NiCdD6r8ZRQzWj2zl_t0YKMWPQCYg>
    <xmx:V1CPY7b75rBLN83RJeL2KIHZGBK0tlvQcrdqbl1cvg8YSXi4iWl5Gg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 37ED9B60086; Tue,  6 Dec 2022 09:23:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <43fda82a-f3df-42c8-9eb2-23cf2dce8628@app.fastmail.com>
In-Reply-To: <0903321f-e0cf-fd7b-bbdd-fc4fdc0f05a0@189.cn>
References: <1670229006-4063-1-git-send-email-chensong_2000@189.cn>
 <2a3d3359-a5fd-453b-81f1-35c7a35fc12d@app.fastmail.com>
 <0903321f-e0cf-fd7b-bbdd-fc4fdc0f05a0@189.cn>
Date:   Tue, 06 Dec 2022 15:22:58 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Song Chen" <chensong_2000@189.cn>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] include/asm-generic/io.h: remove performing pointer
 arithmetic on a null pointer
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 6, 2022, at 07:01, Song Chen wrote:
> =E5=9C=A8 2022/12/5 18:04, Arnd Bergmann =E5=86=99=E9=81=93:
>> On Mon, Dec 5, 2022, at 09:30, Song Chen wrote:
>>=20
>> We have discussed this bit multiple times, and Niklas Schnelle
>> last posted his series to fix this as an RFC in [1].
>>=20
>
> Trace triggers the warning accidentally by including io.h indirectly=20
> because of the absence of PCI_IOBASE in hexagon. So what trace can do =
in=20
> this case is either to suppress warning or just ignore it, the warning=20
> will go away as long as hexagon has put PCI_IOBASE in place or=20
> implemented its own inb() etc, i think they will do it sooner or later.

hexagon/riscv/s390 should not implement inb(), there is no reason
for that because no hardware uses it. Half of the other architectures
that currently implement inb() should not do so either.

> Introducing HAS_IOPORT to trace seems no necessary and too much impact.

I don't think that trace has anything to do with it, the asm-generic
header should just not provde the inb() interface on architectures
that don't use it.

    Arnd
