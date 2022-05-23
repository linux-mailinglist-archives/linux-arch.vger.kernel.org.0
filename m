Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A43531F01
	for <lists+linux-arch@lfdr.de>; Tue, 24 May 2022 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiEWXAn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 May 2022 19:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiEWXAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 May 2022 19:00:43 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6E6A0D24;
        Mon, 23 May 2022 16:00:42 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e656032735so20361897fac.0;
        Mon, 23 May 2022 16:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/hOaZULQrF9LX4munHpY3wVXOQ9nYFe0ZRAvQXZ3vbE=;
        b=nGUkzijZu5ZFwvP8H84AwlAD1vdzdwA1fp5JhNnOjdcRC+ZxUoP+QYS9XM6GLQeWyk
         phuU243eWaA6M+lCDpQB8vQdh7UdO47A0ZJYAgW4Um8l1Je80E/ADeEln0UO4XBU06uk
         on8Kx0QGQnjxiqYAC4W9JuuCImAujkCxhohJ9HwGnvDEXHmXOp51TTJpBA0kMEvDsd2n
         XjWGc1x9K9Uo2HMgqryiDUOsGi2dZjT+EyH+RDMx5s3Jhl2IKdM5ql4zNVw3Tn+xZBSM
         iAI+2SAS0zaoEjNKFKND7vIAfWufy9XiIMFFVGaGrZQ9xEsjaYicgVQ/L7iaon8uSMaO
         GZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=/hOaZULQrF9LX4munHpY3wVXOQ9nYFe0ZRAvQXZ3vbE=;
        b=pIQ4PQPwPjLzQz4I3efGWVxiSPJBjdCJsArgMdaSSI3G5xIEY3uStlu0NRGOBFWGJr
         98iyZCWKVrCN/ItyM5bFx1q+EUAM+jjP3cRLEXrxtkHvxYZEZQgosn5tijtb15xFPmu2
         1ZmZOZZ4I1I80aOtzbroduovcVIf5G3YPyRwy84cVA74ukhb+oiotjycwws6f/cFQf8d
         EO8li25y8I20kFq82XzpMrZDOqSdP5gAzoJFX+P0l9pCrKjp/BH8vKpAn5d9ntBqzyWj
         48DsrOhGhaLaVPAXMPNFwQYOcFzSRfzTSYkvRUQLIru5SMGebJKSWDA8173cZaTRsJov
         cwKg==
X-Gm-Message-State: AOAM530XpvB3JCIzpbPJje9kRQqlYN/QWrmgM5uej6QmJthTGh/JcALW
        pDkJ2X94Ym7kKagjTPQY/rA=
X-Google-Smtp-Source: ABdhPJwFYvmU9t0f1/cxvvqr52oJVOx3ly87DqZ/EmOOoCe4wzWaAPc48YIP+GgJ2Vc9YQqj1/y/lw==
X-Received: by 2002:a05:6870:15cc:b0:ee:456f:c1e5 with SMTP id k12-20020a05687015cc00b000ee456fc1e5mr788661oad.46.1653346841457;
        Mon, 23 May 2022 16:00:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t5-20020a056871054500b000e686d1386asm4315531oal.4.2022.05.23.16.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:00:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 23 May 2022 16:00:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V9 20/20] riscv: compat: Add COMPAT Kbuild skeletal
 support
Message-ID: <20220523230039.GA238308@roeck-us.net>
References: <20220322144003.2357128-1-guoren@kernel.org>
 <CAJF2gTSCcYif4DEpvrJ6d02no3CU_viyE+OkhhjCV3VsGmcT5Q@mail.gmail.com>
 <0ecdb673-b9a8-40af-7dee-2ba7fe739e5f@roeck-us.net>
 <44686961.fMDQidcC6G@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44686961.fMDQidcC6G@diego>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 24, 2022 at 12:40:06AM +0200, Heiko Stübner wrote:
> Hi Guenter,
> 
> Am Montag, 23. Mai 2022, 18:18:47 CEST schrieb Guenter Roeck:
> > On 5/23/22 08:18, Guo Ren wrote:
> > > I tested Palmer's branch, it's okay:
> > > 8810d7feee5a (HEAD -> for-next, palmer/for-next) riscv: Don't output a
> > > bogus mmu-type on a no MMU kernel
> > > 
> > > I also tested linux-next, it's okay:
> > > 
> > > rv64_rootfs:
> > > # uname -a
> > > Linux buildroot 5.18.0-next-20220523 #7 SMP Mon May 23 11:15:17 EDT
> > > 2022 riscv64 GNU/Linux
> > > #
> > 
> > That is is ok with one setup doesn't mean it is ok with
> > all setups. It is not ok with my root file system (from
> > https://github.com/groeck/linux-build-test/tree/master/rootfs/riscv64),
> > with qemu v6.2.
> 
> That is very true that it shouldn't fail on any existing (qemu-)platform,
> but as I remember also testing Guo's series on both riscv32 and riscv64
> qemu platforms in the past, I guess it would be really helpful to get more
> information about the failing platform you're experiencing so that we can
> find the source of the issue.
> 
> As it looks like you both tested the same kernel source, I guess the only
> differences could be in the qemu-version, kernel config and rootfs.
> Is your rootfs something you can share or that can be rebuilt easily?
> 
I provided a link to my root file system above. The link points to two
root file systems, for initrd (cpio archive) and for ext2.
I also mentioned above that I used qemu v6.2. And below I said

> My root file system uses musl.

I attached the buildroot configuration below. The buildroot version,
if I remember correctly, was 2021.02.

Kernel configuration is basically defconfig. However, I do see one
detail that is possibly special in my configuration.

    # The latest kernel assumes SBI version 0.3, but that doesn't match qemu
    # at least up to version 6.2 and results in hangup/crashes during reboot
    # with sifive_u emulations.
    enable_config "${defconfig}" CONFIG_RISCV_SBI_V01

Hope that helps,

Guenter

---
BR2_riscv=y
BR2_TOOLCHAIN_BUILDROOT_MUSL=y
BR2_KERNEL_HEADERS_4_19=y
BR2_BINUTILS_VERSION_2_32_X=y
BR2_TARGET_RUN_TESTSCRIPT=y
BR2_SHUTDOWN_COMMAND_POWEROFF=y
BR2_SYSTEM_DHCP="eth0"
BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
BR2_PACKAGE_STRACE=y
BR2_PACKAGE_I2C_TOOLS=y
BR2_PACKAGE_PCIUTILS=y
BR2_PACKAGE_DTC=y
BR2_PACKAGE_DTC_PROGRAMS=y
BR2_PACKAGE_IPROUTE2=y
BR2_TARGET_ROOTFS_BTRFS=y
BR2_TARGET_ROOTFS_CPIO=y
BR2_TARGET_ROOTFS_CPIO_GZIP=y
BR2_TARGET_ROOTFS_EXT2=y
BR2_TARGET_ROOTFS_EXT2_SIZE="16M"
BR2_TARGET_ROOTFS_EXT2_GZIP=y
BR2_TARGET_ROOTFS_ISO_GZIP=y
BR2_TARGET_ROOTFS_SQUASHFS=y
# BR2_TARGET_ROOTFS_TAR is not set

