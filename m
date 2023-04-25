Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEC06EE971
	for <lists+linux-arch@lfdr.de>; Tue, 25 Apr 2023 23:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjDYVNm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Apr 2023 17:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjDYVNl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Apr 2023 17:13:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B92121;
        Tue, 25 Apr 2023 14:13:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 388365C00D4;
        Tue, 25 Apr 2023 17:13:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 25 Apr 2023 17:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682457220; x=1682543620; bh=/iuXGrOcSJSS9UZ1O6Ds5RLPrCkyp8EAICf
        zOKQByYg=; b=W3pU67JSMazC0N22gSCJbSO19MubbwJitkOepeRkpdwnJ5hoGpc
        oWqxKoqqH73ABO15eSXau0T3JrPTaq4O9o7cNGtbyn+Ea1VFS5hMULMWiYAOmVEp
        R017PelTgJql/H/5c2CzSqBHm2SK2ad1AtiNZia+6yL7066+YBzU4qJ3IZfjhACM
        pitHvLkmd9RFv332+0EFX3qt3LR8rk8ugsg+GPf3L5FurPzQmVwXJCIFux5Mg0hj
        WKKPIQJ3K24JMP5gkoGOIvBjMmRts/YcYxBdoPQzWnFbnUp5lbuqXAlZrJFu1Mb6
        6/5tg9XV/PKTqgQyysV+YfMQgxvPKpx+j/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682457220; x=1682543620; bh=/iuXGrOcSJSS9UZ1O6Ds5RLPrCkyp8EAICf
        zOKQByYg=; b=P7V3NMTjkpLDpHQvhIxcVkpamR8DClxq/2wd//tNM7QVRQKs0w7
        hJnIhVmPeVl5NLJLQzByr+5Wd0NJS3iJBe1tKBm3EK9vb3/hL6N0hmn3RenaQbo8
        P8hBT3XBMXbZVKgA6sBah+268LYMs4wXOjtAM4wlX6lF1mE+m60Q8+Lp6mf9IN2F
        XWU/UjXCXWmAApTo+/EyS9HL04+J5EJHTrRfeCGrPMpvsNr5lcWUqVtDv7sDHX42
        FgSBAJ/pdCYn+O00E2Gz1zvPKUB/cxVz2IzV/0qZEr1tEgs+2igQmW0PoHiG9Hyl
        9v2tRepkuNz2eYLiMVJsh02IksAblKiTbfg==
X-ME-Sender: <xms:hEJIZNbGyMLhuYQsiXfcHLSpbCnYefNU3xNSXQ5Ettvb51CKPAPZUQ>
    <xme:hEJIZEYJX3sUbEb3Tq3LTQ9PzyJXK18v4AVLGVUClxc8FchkzR8rDqgv6Xz4etdNm
    N51ofNlp_GDVh4e3gI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hEJIZP8utCHdWVe_GDJ-yUVhH3J6Ud56s-F1zwtuF5Fa0Uu7iP8Msg>
    <xmx:hEJIZLqI6PVSdoip85v6Xgit7-VScg-FeeLyJgMW3Tq21yP9ItakRg>
    <xmx:hEJIZIoXlTIm5YSYCw20p_RjuGq1ma0JiRp6pwILakguUidRHSyeiw>
    <xmx:hEJIZDUybiIVJbC0CXFuU3kMBEioI37lqOvMEgS-J1wOJ9pgvoIW_Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EA0EEB60086; Tue, 25 Apr 2023 17:13:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <e15befc1-2b38-4824-8112-31f6cfe3dd41@app.fastmail.com>
In-Reply-To: <CAHk-=wiwZ4pR=nqhdzPs2kpHPhmL=Dcy_-N4Ly3nvgUJPE-9FQ@mail.gmail.com>
References: <66184958-d99a-4f64-bc67-50a703f51019@app.fastmail.com>
 <CAHk-=wiwZ4pR=nqhdzPs2kpHPhmL=Dcy_-N4Ly3nvgUJPE-9FQ@mail.gmail.com>
Date:   Tue, 25 Apr 2023 22:13:15 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Thomas Huth" <thuth@redhat.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.4
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 25, 2023, at 20:27, Linus Torvalds wrote:
> On Mon, Apr 24, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>>
>> These are various cleanups, fixing a number of uapi header files to no
>> longer reference CONFIG_* symbols, and one patch that introduces the
>> new CONFIG_HAS_IOPORT symbol for architectures that provide working
>> inb()/outb() macros
>
> Strange. I was sure we had this, but you're right, we only had HAS_IOM=
EM.
>
> And then we had that HAS_IOPORT_MAP which was kind of related.
>
> Anyway, the new HAS_IOPORT looks like something we should always had
> had, I have no complaints, I was just expressing surprise that it
> wasn't already there ;)

Yes, we've discussed this over a long time, and thankfully Niklas has
a nice series that we should be able to complete soon. There was an
older series he did a few years ago that you Nak'ed because it silently
turned outb/inb operations into nops on architectures without PIO
capabilities. The coming series is what we did in response to that,
and it's clearly the right solution, it's just tedious to work out
the exact details for how to deal with individual drivers that
can work both with and without PIO support, e.g. i8250 uarts.

     Arnd
