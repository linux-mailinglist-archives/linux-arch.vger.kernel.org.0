Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745BB6F12A6
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 09:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjD1Hnw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 03:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbjD1Hng (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 03:43:36 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D015FC0;
        Fri, 28 Apr 2023 00:42:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 615423200319;
        Fri, 28 Apr 2023 03:41:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 28 Apr 2023 03:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682667698; x=1682754098; bh=IpndvKPF8+ZBYjcJVQBy1hma252/YYop7a9
        JdT/8deI=; b=DclSOfxipXonjr10Zfze2g04tEcMacCmPEMQj9KSUXPgBjVvL3b
        MQo6fuWFJzT27nHJRs74jQBGwTtn2n2KHu5aTUjHmlrE0229hVE5oHF9yZDkS3ew
        p1PmAZmZsXTagjeqlDcNnPsWoMKrE3WDRUgwOnllR2Mxd40mEjio8JDSoZrBhcLY
        EpF/qnQ//QXfqOClL6sTo+6QcKph0TMZrseOTG+p/07lIk+CJDRuw9l1QbbyGXjO
        Eb35nUJHmU87iS3+aXTcjIEw3yWT1ZcEtVJ4ScA81na/2JXShjG0jXm+bNsByN9H
        0auAMaDbwZPPaqpkQeZO7SI/+wjiURWUsIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682667698; x=1682754098; bh=IpndvKPF8+ZBYjcJVQBy1hma252/YYop7a9
        JdT/8deI=; b=ZK/ac6fyNoZWTXPXbTwDD4R131otN5WDVVkeFrFt0hh+B+HJxI8
        X1G/CekMUpexmmrmmtZG9J6nlcBpYM2so1ttFbssFuvmAd/ypJumITr52uxj1kqy
        Zy5c2xC/bhpYC6ggOg+MvqevGn68/zmzyOJ/3I3FVAlKSomAD5e4Rd6yFIqBKGoS
        hfpNiJGqsm98wDNSPOSseTUhCzwwWb6vjvWT3xqdwN747++XNPbtRAEMqvBh4uIw
        8a5wbLZI4Yp1uAxenqy8Yq0fZoWyfdJOOTsgpDQXZZOenD4BGJ/pbNjPRx5NNA7H
        eRdIwS64tODrt1vngpa6XkfH9l9gVEeJE5g==
X-ME-Sender: <xms:sXhLZC_w2Ek7ASHPBn9INJdoLclKFnb0_xbl3lC3xmLCPyKQXxk-BA>
    <xme:sXhLZCuacs7cUiWYO0nEuiBYqB32l5BX1MLYeiBEMcK-fUP18Owr4Xr3Py6CFXhZd
    _Jcbs_IxCTeOMDCEhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedujedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:sXhLZICeUj5YmbBGBf_2m0H6PdWJkxUh3cvjU_9w54cXtxEeD9Uaeg>
    <xmx:sXhLZKfodyYkaB9AElovPFxDfwUHR8mUJf5ooIYAhxFkIsxA5POH_w>
    <xmx:sXhLZHPdS6QKadaKE8YtYrFaIvC03TvHzezzcglBLhUn06N1drpMBQ>
    <xmx:snhLZPb3qpLzi_KGSCW3CvjqMT17lW441eMUaxBX-rqa1NYZ3zdyZQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B945B60086; Fri, 28 Apr 2023 03:41:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <52dd950a-e714-4ebe-a663-4e0ec6463d03@app.fastmail.com>
In-Reply-To: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
Date:   Fri, 28 Apr 2023 08:40:51 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stanislav Kinsburskii" <skinsburskii@linux.microsoft.com>
Cc:     "Matt Turner" <mattst88@gmail.com>, x86@kernel.org,
        "Stanislav Kinsburskii" <stanislav.kinsburskii@gmail.com>,
        "Borislav Petkov" <bp@alien8.de>, linux-ia64@vger.kernel.org,
        "Mark Brown" <broonie@kernel.org>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, "Brian Cain" <bcain@quicinc.com>,
        linux-mips@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-alpha@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Omar Sandoval" <osandov@fb.com>, "Helge Deller" <deller@gmx.de>,
        linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Chris Down" <chris@chrisdown.name>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH 0/7] Expect immutable pointer in virt_to_phys/isa_virt_to_bus
 prototypes
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 15, 2023, at 12:17, Stanislav Kinsburskii wrote:
> This series is aimed to address compilation warnings when a constant p=
ointer
> is passed to virt_to_phys and isa_virt_to_bus functions:
>
>   warning: passing argument 1 of =E2=80=98virt_to_phys=E2=80=99 discar=
ds =E2=80=98const=E2=80=99=20
> qualifier from pointer target type
>   warning: passing argument 1 of =E2=80=98isa_virt_to_bus=E2=80=99 dis=
cards =E2=80=98const=E2=80=99=20
> qualifier from pointer target type
>
> The change(s) is the same for all architectures, but it's split into a=
 series on
> per-arch basis to simplify applying and testing on the maintainers sid=
e.
>

Looks all good to me. If everyone is happy with it, I'll queue it up
after in the asm-generic tree for 6.5, once rc1 is out.

 Arnd
