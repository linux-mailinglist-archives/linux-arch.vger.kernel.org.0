Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A8955432E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350684AbiFVGiq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 02:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349773AbiFVGip (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 02:38:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381933137C;
        Tue, 21 Jun 2022 23:38:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E416D1FA12;
        Wed, 22 Jun 2022 06:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655879922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QMRrUcaW7noQ1pULOfC6DTDxjpRydqT5qx5KdCmqN2s=;
        b=F2GAX4tgcaaJK09IKfBFeDbtHvOq+IkDEU7l7PrA3RhoibYo+uttdFz2t+qPZAaQOwDw3A
        fHEDcSKePj6ww5nUqqNiqcxwleIRpxn45rgsUtNEvK5o15XMISBUcJfW8fMTMeto1TiYz1
        6avqbbonITmQT2qBICWookqie0msOhY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31A45134A9;
        Wed, 22 Jun 2022 06:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gMq2CvK4smKNUAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 22 Jun 2022 06:38:42 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-arch@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
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
Subject: [PATCH v3 0/3] virtio: support requiring restricted access per device
Date:   Wed, 22 Jun 2022 08:38:35 +0200
Message-Id: <20220622063838.8854-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of an all or nothing approach add support for requiring
restricted memory access per device.

Changes in V3:
- new patches 1 + 2
- basically complete rework of patch 3

Juergen Gross (3):
  virtio: replace restricted mem access flag with callback
  kernel: remove platform_has() infrastructure
  xen: don't require virtio with grants for non-PV guests

 MAINTAINERS                            |  8 --------
 arch/arm/xen/enlighten.c               |  4 +++-
 arch/s390/mm/init.c                    |  4 ++--
 arch/x86/mm/mem_encrypt_amd.c          |  4 ++--
 arch/x86/xen/enlighten_hvm.c           |  4 +++-
 arch/x86/xen/enlighten_pv.c            |  5 ++++-
 drivers/virtio/Kconfig                 |  4 ++++
 drivers/virtio/Makefile                |  1 +
 drivers/virtio/virtio.c                |  4 ++--
 drivers/virtio/virtio_anchor.c         | 18 +++++++++++++++++
 drivers/xen/Kconfig                    |  9 +++++++++
 drivers/xen/grant-dma-ops.c            | 10 ++++++++++
 include/asm-generic/Kbuild             |  1 -
 include/asm-generic/platform-feature.h |  8 --------
 include/linux/platform-feature.h       | 19 ------------------
 include/linux/virtio_anchor.h          | 19 ++++++++++++++++++
 include/xen/xen-ops.h                  |  6 ++++++
 include/xen/xen.h                      |  8 --------
 kernel/Makefile                        |  2 +-
 kernel/platform-feature.c              | 27 --------------------------
 20 files changed, 84 insertions(+), 81 deletions(-)
 create mode 100644 drivers/virtio/virtio_anchor.c
 delete mode 100644 include/asm-generic/platform-feature.h
 delete mode 100644 include/linux/platform-feature.h
 create mode 100644 include/linux/virtio_anchor.h
 delete mode 100644 kernel/platform-feature.c

-- 
2.35.3

