Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7361C3A6A7E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 17:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhFNPfu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 11:35:50 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:38073 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233583AbhFNPfs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 11:35:48 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id ABC9F580963;
        Mon, 14 Jun 2021 11:33:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Jun 2021 11:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/m73zM5bRc8SxBckYjWBihWHS+D
        cE2aCLZ0aiG4SCFI=; b=oyoiP7lI+Yi6LLPsCPhJYATK9cDoDcCY489i+0VzeW/
        WfpkMeksaDwytsWlHjCPMBWfT/VBJ27rz5KEVOMj7F1Q8nLs90T0aA8hHS42h0sl
        Yd1fP/nTwEPz0JAu1OlGzrIPud3GID6Hk21Gje5sHYINYUazH7SY95JI4FKsDohX
        wr+Ch8TXpfesOCTrdgZjw10ccVLlF2okXtX3IW2LF0wH3Ycgtuw5R9qUAJ0ReEeV
        z6AMSqCOHOmpR8YQJPKuCcVk2pNlbLqCgScUF6DASTOM7TknMgSO6gfPi/ul2JVS
        gQtR/6XAMs9Eg4q9bRBjGu9Ooi8ENlkUnwToq/gDB7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/m73zM
        5bRc8SxBckYjWBihWHS+DcE2aCLZ0aiG4SCFI=; b=ZxDrcIIIgxF2AYmqpi7goX
        MgpmD3qgbpIVzx8IVEeqwP/v8ZK8xqWtl6LAMWhQ3kZpm8XSIfBpP/J1Kza25XRc
        //MU/WTKGioqPUTIYNCj1LgKuCyfuM5Q6Pc+G5dThFcuMgSH0ygBMb9pGVDPNh+/
        6gjeifeXtbo54QBuOAkgKX4G4LkdopNaPNE5d1KFBc6k69I5Yv8z+hIQb1eP6PS6
        X5nRboMHRjSKpa+ezGCuIuaPVdkaQ/lixVNbYzagQIOt00h6lGMteU1jbMUeXejC
        mit+XTpRDpetJ2DtG+4DqoIGtUNRVLm9hyktW1zwcbisk7bUT6w7xc5cuWWaNXIw
        ==
X-ME-Sender: <xms:1nbHYPM1DKytrC09E4LrE2M4iG0h6VvIxFgKGRaSTXVb73RWTLeAuQ>
    <xme:1nbHYJ9mpfftksenOFWdTdY9IYnuyas2VOIk4CxRY_NgCA2pSo_DH986aamc08NNB
    cbU45SS7o6luMPPcwI>
X-ME-Received: <xmr:1nbHYOTjk3_ybJdixn3jocfiLgiFzmJtnCbeXAOHdRe4PcZuQ5nUO5OCCufyRas4WqImzaI5Pu7W3EqUHQL_ulv3jLZdzsvBr3Uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:1nbHYDtMykP2Pafz3TYJv7sDXf7ZBNNZzlQBfwVYWakN6HJUAr8n4g>
    <xmx:1nbHYHc7R0ozKFh5Qf3GgsgrejnwdrXP4tzIE3YI_3Ck0vxhNl0wqw>
    <xmx:1nbHYP3XWyRjeMjO1SWVJIL3MGp2JVnqpmWWzCPU5y9zOpDd91zICA>
    <xmx:2HbHYC0w4GS3G5rmcXce06pn57foNGRiIJmKvZWQtNcp3zszr6OTsw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jun 2021 11:33:42 -0400 (EDT)
Date:   Mon, 14 Jun 2021 17:33:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Drew Fustini <drew@beagleboard.org>, liush@allwinnertech.com,
        Wei Wu =?utf-8?B?KOWQtOS8nyk=?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH v2 09/11] riscv: soc: Initial DTS for Allwinner D1
 NeZha board
Message-ID: <20210614153341.z2nkx6sazaahhjfd@gilmour>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-13-git-send-email-guoren@kernel.org>
 <20210607072434.3g3bqxdlpxjirg6k@gilmour>
 <CAJF2gTStppyEoLD-ZToeHYdnzNoFhH2+3Lhd76=M8OFKS=Syow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="57v6yqtbd77tvyfk"
Content-Disposition: inline
In-Reply-To: <CAJF2gTStppyEoLD-ZToeHYdnzNoFhH2+3Lhd76=M8OFKS=Syow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--57v6yqtbd77tvyfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 07, 2021 at 04:07:37PM +0800, Guo Ren wrote:
> On Mon, Jun 7, 2021 at 3:24 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > +             reset: reset-sample {
> > > +                     compatible = "thead,reset-sample";
> > > +                     plic-delegate = <0x0 0x101ffffc>;
> > > +             };
> >
> > This compatible is not documented anywhere?
>
> It used by opensbi (riscv runtime firmware), not in Linux. But I think
> we should keep it.

This should have a documentation still.

Maxime

--57v6yqtbd77tvyfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYMd21QAKCRDj7w1vZxhR
xSH4APwP68R0c/83yQvYSsRfAXKMipDvM+sVGT0uphG7+6JyJQEAhDC6yd2FpJ0y
Re9TWov4hPAnvz5HPAFkSktsoX1hBwA=
=p0a+
-----END PGP SIGNATURE-----

--57v6yqtbd77tvyfk--
