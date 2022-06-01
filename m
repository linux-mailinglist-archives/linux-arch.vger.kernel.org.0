Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55B453A55A
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353004AbiFAMpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353091AbiFAMo7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:44:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790750052;
        Wed,  1 Jun 2022 05:44:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B90E5C0276;
        Wed,  1 Jun 2022 08:44:53 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654087493; x=
        1654173893; bh=ub+c6okPZwdQLkIW5lMu7hQ1gS1h1Ff56ZsM8OV2VO4=; b=v
        OqtjAVU8xRqiUC+PxkOe5oem6WnQC7gCDtAfL5i+pqaMu+jNIqHZz0h5YYgnvvMP
        EiAJftkitrYwf55KHLQsj3YbS/tmMI9t56/ncBu4MZBA4bmXaAAKbz8OBYMA5xJH
        1LXIg60eTiKCSFQiMWIsCgfupeMnRyd5o8SV+BM51Uza+hCn1JnusviUcjdq2qWK
        Uu+VsX6Nxumj2YRqpQyAmyyH9o1jSsvx1OoU7ZMcAH0ADNHm0ckpRxpFsmgJvZbM
        kVEyWFgOZPUsMWTph/i7Zy+MHWJkcJqrXeEdYjE1l1aYHfftXnX8oe069yoNV+Rs
        CYyrQoqKn2Ezwg+e2TEGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654087493; x=
        1654173893; bh=ub+c6okPZwdQLkIW5lMu7hQ1gS1h1Ff56ZsM8OV2VO4=; b=I
        Fl7RJvKobbryZfYJapdV68pyUr3ygTLE/cgiNTIrYWYSljpPRRlbToJpeb9UO88Z
        hcD+I0SDhPmT+Vzr53T4WPSoa4XBVuWU9Amr1k+J70lrZEcXYdSxv6qyX7vgsmwJ
        IPNqJFSTO9qyUPZQ3QOx4C1rppQsbvigGLzfeyPb0psag9MSanLEzlk8X59Y1UQY
        h7FCFr6PTtPGy0n2Bu7NK8eAFvApqDTPU7Q4OAJRsgsKSKUvr7qsp5u9kkCGe2FQ
        LU7O8Ps/TIHF8PjB7HoSCWxv4dEhcKYhajpI0m+HJ5MgshCLhToiPG7nfilxPFgG
        SMz2HOerunFJzADKkKbUw==
X-ME-Sender: <xms:RF-XYv7rIKl12oTZCAX0eaJ_rYiFwT8wWqzhaomzDDG0Zzr3iiVQNw>
    <xme:RF-XYk7LKLHLNLTSGJ__rRxbT13sONW68kyIYMI9GqC2trKB7XRwk1OWCnoSVrVG0
    x6B4h5wQdsrOe1qbS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:RF-XYmf8Thyw4HD_IE231ADPfsUfb6ixsfJdM5RLZn_UoX_JPI8MzQ>
    <xmx:RF-XYgJuPUrjLjU9M2GqmA-nrlSWxww6fgod_rTRauYocyz7j7sNcQ>
    <xmx:RF-XYjJnGS9YfkjcdheEQT5m386HJ_7mSwVoT1DVVJeuuvbAajGB6w>
    <xmx:RV-XYk6o3dQokokW8sL6mtBNAbrltL1loa9JphRu2jvoG2qxr8_5Vw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D413436A006F; Wed,  1 Jun 2022 08:44:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <2c21b163-9eea-4221-b92c-afe471853add@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-1-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:44:32 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "David Airlie" <airlied@linux.ie>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Yanteng Si" <siyanteng@loongson.cn>,
        "Huacai Chen" <chenhuacai@gmail.com>,
        "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH V12 00/24] arch: Add basic LoongArch support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:59=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> boot protocol LoongArch-specific interrupt controllers (similar to API=
C)
> are already added in the next revision of ACPI Specification (current
> revision is 6.4).
>

I=E2=80=99ve been reviewing all LA changes in past week and now I=E2=80=99=
m giving out R-b
for every patch I had reviewed in detail. (I don=E2=80=99t really now an=
ything about
 mm and processes so I just leave them).

I also tried to run the kernel on my machine with Huacai=E2=80=99s next =
tree and
Xuerui=E2=80=99s BPI patch.

I watched the =E2=80=9CNew World=E2=80=9D of LoongArch grow up from scra=
tch. And I must
say it=E2=80=99s a epic work showing the collaboration between community=
 and Loongson
company. Especially Xuerui who invested numerous days and nights without=
 any
return.

Thanks to all people involved.

- Jiaxun

