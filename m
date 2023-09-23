Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C177AC48F
	for <lists+linux-arch@lfdr.de>; Sat, 23 Sep 2023 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjIWSxo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 23 Sep 2023 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIWSxo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Sep 2023 14:53:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0177FA;
        Sat, 23 Sep 2023 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695495189; x=1696099989; i=deller@gmx.de;
 bh=ZJtTrb7Sq+FmrmCPQSiH1SQiFHbV/uTZSgLibn8MqvI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=WtXP/FF0gTV3krMPKlozhyT9cCbVvNVGnUDybv+ELn1I2kayyLKd1ClDYXeCR5btw9fN5xQr+WI
 +JImi7HLFZVDAZtBbKWT+z4CViQTpvl4Hm5YEefu49VVSKPjgfVg9iJ4l2U/U/ezyCFN0qGTPYSVE
 lyUe0/iS+SRsMOHOARfw7OwWUYMUcaQht1ID2diG2Suy78NLIaaPmgkScBfVcodF4EIxwXNJ4QcMJ
 d/8m6PRSWF/kyMEvSgn+k/tvrELHfRBIFfN2sTH2We8lsEPOghTyHSWe2Cb1yCN2CpVDYtJrv0AP/
 inZi9kqNE8l3GQ46mSf0026xz85WZkYUJVYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.158.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1rg38V0FiA-013cUy; Sat, 23
 Sep 2023 20:53:09 +0200
Message-ID: <2fc195c7-f68a-e4e4-a122-4d68f31343d2@gmx.de>
Date:   Sat, 23 Sep 2023 20:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/4] video: fbdev: atyfb: only use ioremap_uc() on i386
 and ia64
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, arnd@arndb.de, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, geert@linux-m68k.org, mcgrof@kernel.org,
        hch@infradead.org, tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230921110424.215592-1-bhe@redhat.com>
 <20230921110424.215592-2-bhe@redhat.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230921110424.215592-2-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iYbDbg/qbmEkvsjiXB0WMmbZFhVM9vL3bJja5JuI4LGOuhlYh9K
 vqgr69Jux1RsXhRJ2yZWJDYZu7NY9WrY2l0Zoy4Wy0CE48q0junLTjbRRVukzNZL2+PI1jE
 fbxV70iMHfMDXycuyHZBhqYGNiDUvBP/GtylIwohPqwwkP1sohfcBWtq+ufoGhBDALmHSHX
 qvwwKrIkfVI9uXC7Imf+g==
UI-OutboundReport: notjunk:1;M01:P0:JTu5Qk0Qo2U=;aQUF38hNFB4gHf+A2OmqpQk1z+7
 4R5BiH0KKfP1NtJtJZQZJYAqc5wHiP3GU1him/4fb/7YaVi/yhjSj/evdvoU4jaurR7CBbkDA
 zVoje1G5iBEISuRWTzU+xT1mNuu1ezpBQ/jwqvRZ0O2SAkeRvDEpzeXLNEJux5Lqb/+F44l2N
 1AGV0dnBT71Pgrn1EYnHK0fzsBg6stVggmUOTqej4csdNCGuX1OrCKRKgw9MgGHMdzjmru2tI
 CWgTVNKyCPZ+NXjyX8l9BzPPlNJdmWjtR3typZfAc3MuCiecliwqyw0hIzz4pEKPeLEuNRAxv
 HL4d4OKYG+bN5LR9jPgy9aQYXlIOOZWbPERJQ6Sh3QdqIrL1Sd4VJ81L666EjQhha886S+K2t
 uhHtpZeU6O6Ot9bhz/IgvU5LvoGGpzdNcFTKDRSxiL4zUfFt+iuZ7zUF/yZMmIjJITL5xWPAL
 J0kZ5CQ9dDt11Ec54XdlXDqkNUMtpN28bvmMIioAHXP/T2uv/pMx/5BM7rL1HMZZtNkavNHhw
 qekhiLK/mHoGvIHGPzcNgMkhrnaifslsJ8G1Xzezy7GPmDV+1/twLTwrSBherfMBW4N7i3p3A
 mAXY3oXedTwDYwuy/3klDe/d6xWGSTee4aFyB++QDxJRv66CXYQgqsTGbvJtsmH4skHrqUlSm
 ChVUd0dCmOf/fxFbxyRmFUQEnAKh82mAZIzExl9sntUNp3eGTpjZi6zd6n+TS5hi9bC3cGsLf
 0Wo2GyII5SNZ/8ik1biQMd9UO4OsFv9BwEvj/5CsJ3Da4LlEXFjYGhqziuAETdqNiF4abRxPe
 dcvJHuGlchb4EnFMP45YNW+FtcautHkpl4qWowF1EfEOC54EIA9PKQPxY4s0l76rXf4XjnME+
 L/mCOseOgV4Ab+Adfok9/pDUSdvOY9sTsq/V4umV6vqANcTyUCfzY7sz2oEbUORrv0nSyGpRv
 HoPcJlL3XXcgposXzTk9VepWSBw=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/21/23 13:04, Baoquan He wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> extension, and on ia64 with its slightly unconventional ioremap()
> behavior, everywhere else this is the same as ioremap() anyway.
>
> Change the only driver that still references ioremap_uc() to only do so
> on x86-32/ia64 in order to allow removing that interface at some
> point in the future for the other architectures.
>
> On some architectures, ioremap_uc() just returns NULL, changing
> the driver to call ioremap() means that they now have a chance
> of working correctly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

applied to fbdev git tree.

Thanks!
Helge


> ---
>   drivers/video/fbdev/aty/atyfb_base.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/=
aty/atyfb_base.c
> index 5c87817a4f4c..3dcf83f5e7b4 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -3440,11 +3440,15 @@ static int atyfb_setup_generic(struct pci_dev *p=
dev, struct fb_info *info,
>   	}
>
>   	info->fix.mmio_start =3D raddr;
> +#if defined(__i386__) || defined(__ia64__)
>   	/*
>   	 * By using strong UC we force the MTRR to never have an
>   	 * effect on the MMIO region on both non-PAT and PAT systems.
>   	 */
>   	par->ati_regbase =3D ioremap_uc(info->fix.mmio_start, 0x1000);
> +#else
> +	par->ati_regbase =3D ioremap(info->fix.mmio_start, 0x1000);
> +#endif
>   	if (par->ati_regbase =3D=3D NULL)
>   		return -ENOMEM;
>

