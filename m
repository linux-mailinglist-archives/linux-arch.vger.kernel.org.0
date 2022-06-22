Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805CE554827
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 14:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiFVKUn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiFVKUj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 06:20:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32783AA73;
        Wed, 22 Jun 2022 03:20:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b7so18773021ljr.6;
        Wed, 22 Jun 2022 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BRog1sj+gmItJaQDKR7qvCAZWvkZ7pMz9+40o0vf0Gk=;
        b=UUojOJ/3GhSFIDFWciEjoZf31boWvOwfY/A6y80DZ2AqPaRsjijeEEkpKd45yfIx5X
         T5qwiHEcn+WfjIIofETUIL7tz5LDB4zY9kp9MXSk6OQPXBGINu1crWi36K4nlSPbmcb5
         ns2UU7VZZeTIkiEYmto2v5NIYv2eILa9rB1/5m64RuLA/T0D6ZO6Un72OVDXzcAUPK+l
         PPhyMaBqxhtQ7JBQjyj1kQGTXUr7u1jwMg9s0CMFPrR/rrEjUDhn9YWO0WIMfv01mIdK
         RsQBg9tKET+3y74+Bak6nDomvtwsGEXS410Cmc+nH5udKp7knt0HGyjhmQU3pC/HNiwM
         N4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BRog1sj+gmItJaQDKR7qvCAZWvkZ7pMz9+40o0vf0Gk=;
        b=FheO+cy32fujFLeN0t4RprwiTB8WoEVxbuGjzxirEtBdGoDx+N9/d7Yh3Fm9l0aB++
         iXOcOerjYSf+e6GZYlWm99/qPyU+t0R8Xv5G85fjZXoOJQMlxVlFTtm4Q3wm42R3sXXt
         CNB+HCG/dicGaOSLsbiXkGie4gKWNNZZ2ZW80wcaUMFYzx1UEcDD5cugLflBubriaKI0
         DkKuv90a8Pg2W9bIYwgab3V6VeU/ilT3X6lJUrHeTclVpKaQZUtx8WrVDZsG+O34TSiT
         M3xOFTu1l2rlHv4dWU0dDU/erxi6mAHIWZExHkRhnB4M8QAl/Pailwf8ziGviqXZbeCm
         Tdhg==
X-Gm-Message-State: AJIora+t8Y0OEHd7cHT6l1bbMhBjtQszBKiiU5Pd7rEgSbnzvZgS/GB4
        hvuRk1dqghj37Irz6ptpVhI=
X-Google-Smtp-Source: AGRyM1vNLGnKO9vo5sGvPhUVSiHmsOOuuHKaW0/zVzi+GGSxVG3rdNUjYtWUArgnCHBYbBTSu/+bRQ==
X-Received: by 2002:a05:651c:2105:b0:255:90b3:835c with SMTP id a5-20020a05651c210500b0025590b3835cmr1466695ljq.414.1655893233121;
        Wed, 22 Jun 2022 03:20:33 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id be25-20020a05651c171900b0025a877115e1sm265981ljb.76.2022.06.22.03.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:20:32 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] virtio: support requiring restricted access per
 device
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-arch@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
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
References: <20220622063838.8854-1-jgross@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <7eb66aec-df40-4e12-8211-8a6db4ad6060@gmail.com>
Date:   Wed, 22 Jun 2022 13:20:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220622063838.8854-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 22.06.22 09:38, Juergen Gross wrote:

Hello Juergen

> Instead of an all or nothing approach add support for requiring
> restricted memory access per device.
>
> Changes in V3:
> - new patches 1 + 2
> - basically complete rework of patch 3
>
> Juergen Gross (3):
>    virtio: replace restricted mem access flag with callback
>    kernel: remove platform_has() infrastructure
>    xen: don't require virtio with grants for non-PV guests
>
>   MAINTAINERS                            |  8 --------
>   arch/arm/xen/enlighten.c               |  4 +++-
>   arch/s390/mm/init.c                    |  4 ++--
>   arch/x86/mm/mem_encrypt_amd.c          |  4 ++--
>   arch/x86/xen/enlighten_hvm.c           |  4 +++-
>   arch/x86/xen/enlighten_pv.c            |  5 ++++-
>   drivers/virtio/Kconfig                 |  4 ++++
>   drivers/virtio/Makefile                |  1 +
>   drivers/virtio/virtio.c                |  4 ++--
>   drivers/virtio/virtio_anchor.c         | 18 +++++++++++++++++
>   drivers/xen/Kconfig                    |  9 +++++++++
>   drivers/xen/grant-dma-ops.c            | 10 ++++++++++
>   include/asm-generic/Kbuild             |  1 -
>   include/asm-generic/platform-feature.h |  8 --------
>   include/linux/platform-feature.h       | 19 ------------------
>   include/linux/virtio_anchor.h          | 19 ++++++++++++++++++
>   include/xen/xen-ops.h                  |  6 ++++++
>   include/xen/xen.h                      |  8 --------
>   kernel/Makefile                        |  2 +-
>   kernel/platform-feature.c              | 27 --------------------------
>   20 files changed, 84 insertions(+), 81 deletions(-)
>   create mode 100644 drivers/virtio/virtio_anchor.c
>   delete mode 100644 include/asm-generic/platform-feature.h
>   delete mode 100644 include/linux/platform-feature.h
>   create mode 100644 include/linux/virtio_anchor.h
>   delete mode 100644 kernel/platform-feature.c

I have tested the series on Arm64 guest using Xen hypervisor and didn't 
notice any issues.


I assigned two virtio-mmio devices to the guest:
#1 - grant dma device (required DT binding is present, so 
xen_is_grant_dma_device() returns true), virtio-mmio modern transport 
(backend offers VIRTIO_F_VERSION_1, VIRTIO_F_ACCESS_PLATFORM)
#2 - non grant dma device (required DT binding is absent, so 
xen_is_grant_dma_device() returns false), virtio-mmio legacy transport 
(backend does not offer these flags)


# CONFIG_XEN_VIRTIO is not set

both works, and both do not use grant mappings for virtio


CONFIG_XEN_VIRTIO=y
# CONFIG_XEN_VIRTIO_FORCE_GRANT is not set

both works, #1 uses grant mappings for virtio, #2 does not use it


CONFIG_XEN_VIRTIO=y
CONFIG_XEN_VIRTIO_FORCE_GRANT=y

only #1 works and uses grant mappings for virtio, #2 was rejected by 
validation in virtio_features_ok()


You can add my:
Tested-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com> # Arm64 
guest using Xen


>
-- 
Regards,

Oleksandr Tyshchenko

