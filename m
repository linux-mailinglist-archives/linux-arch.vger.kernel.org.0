Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE367511E0B
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbiD0PhC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbiD0Pg6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 11:36:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9AF5007C;
        Wed, 27 Apr 2022 08:33:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A3656210DF;
        Wed, 27 Apr 2022 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651073619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fVtXdWYhLenHSdj+T0ZdwLpRLd8WonOYcTgrNB+Z3jY=;
        b=Eat1kP2aBHsOlNBIKA1cGV2G+bvXpUau7r9w59sCbR2l7eYN2d7oC8FGmCXase93Nku7bV
        jiZIiZvcRKzblmi9I4rPSOEQOla1OYE2aMjFrhulRY4T6S3hLCVJ+42wSk8CohIluYieBJ
        uzRfCtdqBhKn+/2ondixZrhxHDO3cRg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF7661323E;
        Wed, 27 Apr 2022 15:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 790vOVJiaWIRFwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 15:33:38 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: [PATCH v2 0/2] kernel: add new infrastructure for platform_has() support
Date:   Wed, 27 Apr 2022 17:33:34 +0200
Message-Id: <20220427153336.11091-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In another patch series [1] the need has come up to have support for
a generic feature flag infrastructure.

This patch series is introducing that infrastructure and adds the first
use case.

I have decided to use a similar interface as the already known x86
cpu_has() function. As the new infrastructure is meant to be usable for
general and arch-specific feature flags, the flags are being spread
between a general bitmap and an arch specific one.

The bitmaps start all being zero, single features can be set or reset
at any time by using the related platform_[re]set_feature() functions.

The platform_has() function is using a simple test_bit() call for now,
further optimization might be added when needed.

[1]: https://lore.kernel.org/lkml/1650646263-22047-1-git-send-email-olekstysh@gmail.com/T/#t

Juergen Gross (2):
  kernel: add platform_has() infrastructure
  virtio: replace arch_has_restricted_virtio_memory_access()

 MAINTAINERS                            |  8 ++++++++
 arch/s390/Kconfig                      |  1 -
 arch/s390/mm/init.c                    | 13 +++----------
 arch/x86/Kconfig                       |  1 -
 arch/x86/kernel/cpu/mshyperv.c         |  5 ++++-
 arch/x86/mm/mem_encrypt.c              |  6 ------
 arch/x86/mm/mem_encrypt_amd.c          |  4 ++++
 drivers/virtio/Kconfig                 |  6 ------
 drivers/virtio/virtio.c                |  5 ++---
 include/asm-generic/Kbuild             |  1 +
 include/asm-generic/platform-feature.h |  8 ++++++++
 include/linux/platform-feature.h       | 16 +++++++++++++++
 include/linux/virtio_config.h          |  9 ---------
 kernel/Makefile                        |  2 +-
 kernel/platform-feature.c              | 27 ++++++++++++++++++++++++++
 15 files changed, 74 insertions(+), 38 deletions(-)
 create mode 100644 include/asm-generic/platform-feature.h
 create mode 100644 include/linux/platform-feature.h
 create mode 100644 kernel/platform-feature.c

-- 
2.34.1

