Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1E60FC15
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiJ0Pfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJ0Pfm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 11:35:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7656E2E1;
        Thu, 27 Oct 2022 08:35:41 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 64EB35C01E4;
        Thu, 27 Oct 2022 11:35:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Oct 2022 11:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666884939; x=
        1666971339; bh=dRLTpNEzJ/9mC9yd5buzdWEinbRx6mGEu2drnGQzQZk=; b=a
        koTNboqVrga1QpOEfjJJq4x77jtON5kwaOeHAUiJ/SdiHugV3R+yArzONiBKQTxC
        cdRQJHUMZFi25qnWiRwv27AuZqRlyUFzhWBqN5OXPlqvLhZlAsx1KAVqFoNC6pUU
        Hhy0strCFmBzuMXm+5ptjIwfHCd9seYxULxeo7f15zed6ZhPnd98QSr5NWdciUT/
        Ef9Nu9fCTAt4z5WK4XebLUOqGBH6sba4UtDZOFM8ODkP9x57OgNFaTJ8k1hBS7wa
        YctL5P+IdVuFN7ks879hsQo4/hjZcjAr3QcEaQu6IlA+owHtTBy1FuOJEZqwvLC1
        FnNVYHCSdqpEBSObI8/jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666884939; x=1666971339; bh=dRLTpNEzJ/9mC9yd5buzdWEinbRx
        6mGEu2drnGQzQZk=; b=feXVXU+IhVmbOWpTfmWIfgAydP4D5uoTkcDDuYl1MRK3
        K3Lyc9q9z/eV1tiPi9oZyPbO2f6eU6EZMjL368QIqfW8RU3+DbP2nxjKVTL4QqPg
        O3lpL/UVAFZ78vF1C2wsHa+Wy6ZjkYJzgeRJ+iZQCOslAbfjPBapZbYoQyi543R9
        6svOA5uMxJ9ugxVqukMWSJu4CF0G1smW5qoKaAkBNReK/V/fccHR6eP1uUHbu/GH
        DHt5I43fPXIrIgYGFJnfpNXzmZX/5HR0vXjyYOriQuW9gPTRTJkmGd+u3wM+Y8Bt
        rVwymf/P7E6W9TwTB7t+DqrLac1yx3B82sJ2mmmDlg==
X-ME-Sender: <xms:SqVaY9GFRul5if9IB4ujb2XDH1nVLL00Knhp17-5eEVcqx001Aoe9g>
    <xme:SqVaYyXc4pFaPt1_td30D-AKLaQiDLC2jV84J_8sipoBagq80IoqnoP1Y8WhVeet3
    prqs2Fmaiom3qI>
X-ME-Received: <xmr:SqVaY_JR3e661_XWRxt4HXIgYB-2YJoYIzWlCl7RBT5h0w41xEIO1HLMSWIsHpPWxBZOAXpOmIpC4jHaNM42Iwnhy0x-VKII1P820LT0qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeghohhjthgv
    khcurfhorhgtiiihkhcuoeifohhjuhesihhnvhhishhisghlvghthhhinhhgshhlrggsrd
    gtohhmqeenucggtffrrghtthgvrhhnpeelgeeifefgheeffeegfefhuedtgefgtdekkeei
    ffdvtedtudejvdekfeffhedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeifohhjuhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgt
    ohhm
X-ME-Proxy: <xmx:SqVaYzG81jee9twupnr_iuZD-FHVs0_E1sZc6vwSrMa9Gwg5hC4BNA>
    <xmx:SqVaYzXr8eq7pHMCZgaIR-UMdnrRyybNTczg23-6U5O0sKVtrG0JQQ>
    <xmx:SqVaY-NfFa7ONQOcr6yhB81RbERSD0MI0Zsx5ois6nx17WTxC1Lh2Q>
    <xmx:S6VaY6G5f2Om4lHhP_ZAn2qF1JHo4bJPTLvPZugWu76lnA02OWNNHg>
Feedback-ID: i71cc40f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Oct 2022 11:35:38 -0400 (EDT)
Received: by mail-itl.localdomain (Postfix, from userid 1000)
        id BD8E895E70; Thu, 27 Oct 2022 17:35:34 +0200 (CEST)
Date:   Thu, 27 Oct 2022 17:35:34 +0200
From:   Wojtek Porczyk <woju@invisiblethingslab.com>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH V2] uapi: Fixup strace compile error
Message-ID: <Y1qlRlncUqTtwzE2@invisiblethingslab.com>
Mail-Followup-To: guoren@kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>, Heiko Stuebner <heiko@sntech.de>
References: <20220804025448.1240780-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qsbsHDHXj9B+EzsL"
Content-Disposition: inline
In-Reply-To: <20220804025448.1240780-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--qsbsHDHXj9B+EzsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2022 at 10:54:48PM -0400, guoren@kernel.org wrote:
> Export F_*64 definitions to userspace permanently. "ifndef" usage made it
> vailable at all times to the userspace, and this change has actually brok=
en
> building strace with the latest kernel headers. There could be some debate
> whether having these F_*64 definitions exposed to the user space 64-bit
> applications, but it seems that were no harm (as they were exposed already
> for quite some time), and they are useful at least for strace for compat
> application tracing purposes.
>=20
> Fixes: 306f7cc1e9061 "uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 =
in fcntl.h"
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> ---
>  include/uapi/asm-generic/fcntl.h | 2 --
>  1 file changed, 2 deletions(-)

Hello,

Is this patch getting merged for 6.1? Will it be included in stable 6.0?


--=20
pozdrawiam / best regards
Wojtek Porczyk
Gramine / Invisible Things Lab
=20
 I do not fear computers,
 I fear lack of them.
    -- Isaac Asimov

--qsbsHDHXj9B+EzsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEaO0VFfpr0tEF6hYkv2vZMhA6I1EFAmNapUYACgkQv2vZMhA6
I1H3Tw//YUasUYN+M0z/OYxIB5ix7tTHJDCeafXY4QknOH+wIr7gPxlYU8Kj5+wH
aFBUAuJsGl3cR19rGVGMIV6w+kYfHB6D7skaCa7E4TX+PEQqRRCwtsePRE65JDR0
aE9qYNpEZNwdT9lgV5z6W91r99vt4H3E0Kz4VZeseFIzD/d8+JJe6oqp8q9Z9Q1N
FDJ7sqPWK34XRzGR48rmajRkOxSxHnqwPwDjD/Gd0dG99+lj6d4mL5QYKOI1tPqH
zvnvLpZi0c6oFTtOQZR7zrgZ3c2P2AKbdEIzWmxH3gZtK/pqHFFZkDzHz0IBbe1x
OwElFL1N6EGuzH9WflX7Z3lpYiDy1XDRhAmsvOx+a9RYvHWyGtipaYbCDR5FBhnh
dnrm6Bh6QbVaS9hBQ0RihlL+bch3azAjiagljVy+XoVgBhYelMRkTreYh1BVz24J
MUeS7MET3NuTdq8yYKrSD7YdF56k87BhlVKRd90m6Pp/lQhOFgcUuMHF6Nm5lJMp
PvBVuNR0bvd9uehz0pD3DJ8ENMecOC+sQNSRccSk8GyA7B3sB4Vv2tUBq3JibqqY
BJRxuGz47NEWJV8iNs9d0jcCIy/l8XZndQQNYxzbFC3wVHfWZeuq45WjJduooyPm
8XtOzfByM3+ggDdbTCDyBh/bYLFdkoPW0PQBBu6ljT2t03Z+M7w=
=VQwt
-----END PGP SIGNATURE-----

--qsbsHDHXj9B+EzsL--
