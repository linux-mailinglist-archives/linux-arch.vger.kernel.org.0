Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B53D55F28C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 02:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiF2A6Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 20:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiF2A6X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 20:58:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6120CE2C;
        Tue, 28 Jun 2022 17:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D61EFB8210B;
        Wed, 29 Jun 2022 00:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E470C341C8;
        Wed, 29 Jun 2022 00:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656464299;
        bh=qzXzyU3Yxwkc5XoKYIl4dSB/mDLg7UqRnK4AC6snhZQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hiakdTfXzYVHnt8rotaaK4/4vf9Jm1h+sYAUrz+zMLPSM5E4rWUFyo8rGX5PESKLl
         SY2grO9EbqiR2Nh8X1DlSWeFnUzx1cg+HuylAwTsj3sr/+ORIBdOpNsXMOnWmuN6ka
         e2KJOMM1+ScuOsUPDAC1TZ/o0/sRKF5JLy0VULpTw8abuMurRFrQ2sdxT5B5uo3PDr
         DXaHPlaEBpEPp5jGAs1Zib5nV/ajkGe5CzC/WOwT8Mrm5V0CYmaFpYEomoQw4Cf14U
         D6FpTXAQNTrIUIZxZWmpBkwKNqx6a/kMQOdKaXi3gnqvGIHJkYKlz1LMjrtMKpRGng
         Lgc0rh6qy+uLA==
Date:   Tue, 28 Jun 2022 17:58:17 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Juergen Gross <jgross@suse.com>
cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] virtio: support requiring restricted access per
 device
In-Reply-To: <20220622063838.8854-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.22.394.2206281758050.4389@ubuntu-linux-20-04-desktop>
References: <20220622063838.8854-1-jgross@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 22 Jun 2022, Juergen Gross wrote:
> Instead of an all or nothing approach add support for requiring
> restricted memory access per device.
> 
> Changes in V3:
> - new patches 1 + 2
> - basically complete rework of patch 3
> 
> Juergen Gross (3):
>   virtio: replace restricted mem access flag with callback
>   kernel: remove platform_has() infrastructure
>   xen: don't require virtio with grants for non-PV guests


On the whole series:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


>  MAINTAINERS                            |  8 --------
>  arch/arm/xen/enlighten.c               |  4 +++-
>  arch/s390/mm/init.c                    |  4 ++--
>  arch/x86/mm/mem_encrypt_amd.c          |  4 ++--
>  arch/x86/xen/enlighten_hvm.c           |  4 +++-
>  arch/x86/xen/enlighten_pv.c            |  5 ++++-
>  drivers/virtio/Kconfig                 |  4 ++++
>  drivers/virtio/Makefile                |  1 +
>  drivers/virtio/virtio.c                |  4 ++--
>  drivers/virtio/virtio_anchor.c         | 18 +++++++++++++++++
>  drivers/xen/Kconfig                    |  9 +++++++++
>  drivers/xen/grant-dma-ops.c            | 10 ++++++++++
>  include/asm-generic/Kbuild             |  1 -
>  include/asm-generic/platform-feature.h |  8 --------
>  include/linux/platform-feature.h       | 19 ------------------
>  include/linux/virtio_anchor.h          | 19 ++++++++++++++++++
>  include/xen/xen-ops.h                  |  6 ++++++
>  include/xen/xen.h                      |  8 --------
>  kernel/Makefile                        |  2 +-
>  kernel/platform-feature.c              | 27 --------------------------
>  20 files changed, 84 insertions(+), 81 deletions(-)
>  create mode 100644 drivers/virtio/virtio_anchor.c
>  delete mode 100644 include/asm-generic/platform-feature.h
>  delete mode 100644 include/linux/platform-feature.h
>  create mode 100644 include/linux/virtio_anchor.h
>  delete mode 100644 kernel/platform-feature.c
> 
> -- 
> 2.35.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
