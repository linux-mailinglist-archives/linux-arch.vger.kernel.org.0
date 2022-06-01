Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63BD53A4C6
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiFAMVU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352853AbiFAMUw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:20:52 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888CB5002C;
        Wed,  1 Jun 2022 05:20:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id AA8665805E8;
        Wed,  1 Jun 2022 08:20:49 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654086049; x=
        1654093249; bh=8Id7kSzEesLTn8HeoXOUKgYcL8YgganQCWoYyexhIh8=; b=R
        eIvrH15ITVSpe7ZygMACwj011Ctv8P16UZFlLjNhgw1m+g8h+PzeRv05UNv1nokc
        Z+0NkvMK3cXlogQRC06PqslKNVhKDmu2aQF7vdGioDqBw/O0jV/JKrjJrrJWGCdy
        z6pFh7Cr6OrW77r/leWtnbYuu74lmIKZwk7mnsmLllU1HD+8uxnIpach/e4feq+X
        ZvEVe84TUW71gHWWRseo/VgteYJQGeSJ76KDa5ATf3wa+aqc1x854bO7TJEozAT3
        +rJAACDT9u4fXR+BjpPk6PTJU4jNwojmYk3ES4c2tmOmCQC3nbGCKTzIvDvi/C5Y
        e+zBvGNOzY9fZh+zAZCzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654086049; x=
        1654093249; bh=8Id7kSzEesLTn8HeoXOUKgYcL8YgganQCWoYyexhIh8=; b=f
        uUWPZTcLdhXwT4+z4XyHE0/k46rd3cql+M8PpZqE1Dw+sFpXOKhlXq8VreEQPrk2
        hw8KA1Yzg5NIkwQNww48bGP7c5Ty7unaRP9jdGMk/Jk34/sLNbAirb9fGlDTdtdS
        BcE5n0eAzXjdKL1LnT9oO2Fg0B3iFO95jJdho36aidA37MnQYTOEGlxNlexOYI+G
        MNBAiguz6uRPlGZZ6rLmgovlXkk+1G2UjHvbKj4QKabIWMdlTUWi/CcK7Af2iLzD
        OUAh1KIBIDWhosXrXpXHwHc7tDpIofggJc9aYK3z40Ed2Uhx7xIpstr5D/Jb3yCb
        OXO07/yiDrZ+inQWC+3Cg==
X-ME-Sender: <xms:oFmXYu-M95Ws01w_E7u7Amq76cttaTWjQwwwhhMdUwZjfUlhkdyxIw>
    <xme:oFmXYuvXT7nkSKIhXNofEKpY7uvt2C8IslpSMtmLmwV9ZBZne4M5Wcd7stTnupu1h
    wvlz2wz8GvejF7TBiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:oFmXYkBpAHHsx7ApoG71DJI96P8VmxcQ74WEdOkJ0axWJixY2GLH5A>
    <xmx:oFmXYme8n0d1EwzT98iX-V8KlDp7fQSeW00yF0qpgH56vffpumltaA>
    <xmx:oFmXYjOGfz_fdKY8aF_bPwHtsmj8_W83jyAF-wXZY1l4Jc0R3GA6sg>
    <xmx:oVmXYuHDGNP8oUc8FcREow2ogQJJ0o4JSy6FwSN62NRQORmMsfWYgg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D852C36A006F; Wed,  1 Jun 2022 08:20:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <c2c7d0cd-c708-4efe-9fff-7d84fc274735@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-7-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-7-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:20:28 +0100
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
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Daniel Vetter" <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        "WANG Xuerui" <git@xen0n.name>
Subject: Re: [PATCH V12 06/24] LoongArch: Add writecombine support for drm
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:59=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> LoongArch maintains cache coherency in hardware, but its WUC attribute
> (Weak-ordered UnCached, which is similar to WC) is out of the scope of
> cache coherency machanism. This means WUC can only used for write-only
> memory regions.
>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Can still remember painful experiences on poke with WC on LS3B1500 + Pol=
aris.
Glad to see that WC is flawless this time.

Thanks.

> ---
>  drivers/gpu/drm/drm_vm.c         | 2 +-
>  drivers/gpu/drm/ttm/ttm_module.c | 2 +-
>  include/drm/drm_cache.h          | 8 ++++++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> index e957d4851dc0..f024dc93939e 100644
> --- a/drivers/gpu/drm/drm_vm.c
> +++ b/drivers/gpu/drm/drm_vm.c
> @@ -69,7 +69,7 @@ static pgprot_t drm_io_prot(struct drm_local_map *ma=
p,
>  	pgprot_t tmp =3D vm_get_page_prot(vma->vm_flags);
>=20
>  #if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__)=20
> || \
> -    defined(__mips__)
> +    defined(__mips__) || defined(__loongarch__)
>  	if (map->type =3D=3D _DRM_REGISTERS && !(map->flags &=20
> _DRM_WRITE_COMBINING))
>  		tmp =3D pgprot_noncached(tmp);
>  	else
> diff --git a/drivers/gpu/drm/ttm/ttm_module.c=20
> b/drivers/gpu/drm/ttm/ttm_module.c
> index a3ad7c9736ec..b3fffe7b5062 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.c
> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> @@ -74,7 +74,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching=20
> caching, pgprot_t tmp)
>  #endif /* CONFIG_UML */
>  #endif /* __i386__ || __x86_64__ */
>  #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
> -	defined(__powerpc__) || defined(__mips__)
> +	defined(__powerpc__) || defined(__mips__) || defined(__loongarch__)
>  	if (caching =3D=3D ttm_write_combined)
>  		tmp =3D pgprot_writecombine(tmp);
>  	else
> diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
> index 22deb216b59c..08e0e3ffad13 100644
> --- a/include/drm/drm_cache.h
> +++ b/include/drm/drm_cache.h
> @@ -67,6 +67,14 @@ static inline bool drm_arch_can_wc_memory(void)
>  	 * optimization entirely for ARM and arm64.
>  	 */
>  	return false;
> +#elif defined(CONFIG_LOONGARCH)
> +	/*
> +	 * LoongArch maintains cache coherency in hardware, but its WUC=20
> attribute
> +	 * (Weak-ordered UnCached, which is similar to WC) is out of the=20
> scope of
> +	 * cache coherency machanism. This means WUC can only used for=20
> write-only
> +	 * memory regions.
> +	 */
> +	return false;
>  #else
>  	return true;
>  #endif
> --=20
> 2.27.0

--=20
- Jiaxun
