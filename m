Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0A239CDFC
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhFFIQh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 04:16:37 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44467 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhFFIQh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 04:16:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3211A5C01A6;
        Sun,  6 Jun 2021 04:14:48 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
  by compute3.internal (MEProxy); Sun, 06 Jun 2021 04:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=EaIPF
        erzWo7dyTRx8nz8Yo/O8mfUUiuXUZP1FN4Xfhg=; b=DiUwvm82+Gqvwz62RITbP
        Q3MkBkHlZ7lSfSAHBYRmTRhbcGJF+pZMySQlHSX08QnLfdm4adQNhnWl0eRqUqcB
        sXfEAwNkZfGt1bAAv2ChYfk2eAH9mS9H9M0IDLh5GEtD2e2NKKZVPUKdhAk+gf39
        yLVRMLCjM7YgJffwuJHMAAM/6IMGUO+SkCLwRQoFFJJgmWZNkOr1UVZvW0omSIqU
        00fIJ8QxF96hRf7JP5+iUJ+/izk23igkwbt/EVTzT5aieh/nnohwoFSN6u80N0xO
        SlPRqBYIR4xTtQdyLq8nUbl0uW+1v/iJf+uEVSLFigdhkWmJDHGA5LpuwYqWrW7X
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=EaIPFerzWo7dyTRx8nz8Yo/O8mfUUiuXUZP1FN4Xf
        hg=; b=JInZWeeZvcm/sjW/I+xScGkMNftgYrt8Mb5iRLux35JevYzEXKEeKkLSV
        yy+botV5nam1teI38CYxGv1Ijr5JwDAL+2m8I8bBg52HppUoXr423qWCtxtUR5IS
        UIOFcyUmiT6WuBN/I4QXa+hAystzolsOndEBCT0AxMRgrz85fsfDSYmI0Yr9fB8W
        DUieRer8ct//04Jjnou6ygmD80DikYfQbJOoTzdIGuKQiIJUCo+XO9E+7a80RinL
        q5YiUI+O96XsBElTCcsSW9DG8i2gja5X7Htu5nCX6/8BWUIx1odLocimjGyCcYfB
        4mIvTLB0fSngNkTAO9667ZUtGtMkw==
X-ME-Sender: <xms:9oO8YOi-L4u6rbeRQLt6KpHDjza2nisVmpX6KDm3gOs5ot8KrXNJXw>
    <xme:9oO8YPDUrp68YrxS4FKLH47bbo0IYbYoKBoaCQm3ZQurvgRn44Q-QvuTqKm4UtRcl
    vVxXQSnZwd2hCDf6SI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedthedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepjefhieehieeikedvvdeltddvvdffffdvveefudefgeev
    ueehueevueegjeehueffnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:9oO8YGGiYAiZe5En-oyLW60kGrZbphPKenxQvKmmg_ZjuGKeSTolOQ>
    <xmx:9oO8YHS1V3dVl9YE3nRg0zPmOV2wvzjqnVAIV64VgCvXr71pKIp2Ew>
    <xmx:9oO8YLw-krhN-1r0yQc3FgpbY5r5C2TlMy2SRtUToFM3mQSy4gNMzQ>
    <xmx:-IO8YGpsLybRefumPtCs9FRVWeHYLYd31K_JLtRsI1PNJNVu2xkDrw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D8610130005F; Sun,  6 Jun 2021 04:14:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <2a51e6b8-37e5-43cb-b0b4-d6fdd1848fe3@www.fastmail.com>
In-Reply-To: <20210605211529.GA2326325@bjorn-Precision-5520>
References: <20210605211529.GA2326325@bjorn-Precision-5520>
Date:   Sun, 06 Jun 2021 16:14:24 +0800
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>,
        "Huacai Chen" <chenhuacai@loongson.cn>, arnd@kernel.org
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Huacai Chen" <chenhuacai@gmail.com>, linux-arch@vger.kernel.org
Subject: =?UTF-8?Q?LoongArch_(was:_Re:_[PATCH_V2_2/4]_PCI:_Move_loongson_pci_quir?=
 =?UTF-8?Q?ks_to_quirks.c)?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82021=E5=B9=B46=E6=9C=886=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=885:15=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A

+linux-arch and Arnd for arch related discussions

>=20
> If you're moving these from device-specific file to a generic file,
> these #defines now need to have device-specific names.
>=20
> But these appear to be for built-in hardware that can only be present
> in Loongson (I assume mips?) systems.  If that's the case, maybe they
> should go to a mips-specific file like arch/mips/pci/quirks.c?
>=20
> But I see you see you mention LoongArch above, so I don't know if
> that's part of arch/mips, or if there's an arch/loongson coming, or
> what.

As far as I read LoongArch should be a brand new RISC architecture.
I saw Loongson release some documents[1] and code[2] regarding this
new architecture.

Huacai, as you are submitting these code, does it mean Loongson intends
to mainline LoongArch kernel?
If so, I'm certain that there is a lot of drivers and other code can be
reused between MIPS part and LoongArch part for Loongson chips.
Could you please make an announcement about your plans?

Thanks.

[1]: https://github.com/loongson/LoongArch-Documentation
[2]: https://github.com/loongarch64
--=20
- Jiaxun
