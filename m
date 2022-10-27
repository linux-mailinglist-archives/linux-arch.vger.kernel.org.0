Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EACC60EF16
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 06:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiJ0EiP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 00:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJ0EiP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 00:38:15 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8614C526;
        Wed, 26 Oct 2022 21:38:14 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h24so363413qta.7;
        Wed, 26 Oct 2022 21:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9y3j8vzxI3Bs4RKnrTd+K8GTPi6bFYnxVzmffLHGIBg=;
        b=GJvzoEdOmPDpLPrazBCrL6U7YYZWii13tJ8HDH0aQMBy6AltglMgY0txfr8DVyx5pW
         4ik6fRigcc/RkAoBmbFY5WKunV6pOrM7leYF6tmVHLESvJaerxzuS+MvfAjL0LPdmQgN
         ukFV3RawEMaXP05lMyGHepsJ7DiHFlDkk6wu8vI0SZZ93qpMv5iyORSbxDNsxkl61qK7
         PKkc1/pypEYPMUxXMmMush0cfo6Kdmn6AMIfPyTkV+zpgGYP3i6pcCbdzY2aCa64Lqvc
         JOUQ8Jg9ongJiCCDKU+QbKzwNLdkzXUsU0k4RvlADw+0KwlEMVT6koqGQaYmde/sbYVW
         aneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y3j8vzxI3Bs4RKnrTd+K8GTPi6bFYnxVzmffLHGIBg=;
        b=fjPtoPCRhTmAmCHVsPRDhTsi+EVCySp++RVYxsAwIoVOxy0PaAPNTXoV/7b84UEKAT
         I5vIWZGUVVS8q4oMzcuOpvzcowgqD22xfRPFO2eZjOm+IdIHOYB096XkK/x9GTRUiReC
         CR0IYF4WaCD8ngGk0PsfHR9veV22c+e9UOiN4ZSghWVfDEusDMMzoSDfE2lJOqpIc5Ju
         Pacvm1v5WGNn04h9nN/04Zrfszqm5Rg4cksCPM2PfkVu0lOU0ZqudL5JrAdnvz/KLcgp
         ESEIcBbF7uPugtRhwc/O9VqCVongRQ2BYBB+ks4syBDmeHgmOxrFf857OkfNVV2GO6rS
         ltKA==
X-Gm-Message-State: ACrzQf3geg4pOurNW/Rqu2/n6/I97wPD6rygKmt1RQPibOfcDbU/NHn/
        EhqxGAQw3oIsI+kU6DEXvwGP8aapgxY=
X-Google-Smtp-Source: AMsMyM640QLMgfa4qB1TWtLOKzgB9pq5UOmXm3xEJ42f9L9SIINqlbFNEjjywpVcqG5ZEWL4ZpT8SA==
X-Received: by 2002:a05:622a:4d4:b0:39c:7e8c:d740 with SMTP id q20-20020a05622a04d400b0039c7e8cd740mr39426921qtx.282.1666845493260;
        Wed, 26 Oct 2022 21:38:13 -0700 (PDT)
Received: from localhost ([2601:589:4102:7400:ade5:9c32:44f6:bc7d])
        by smtp.gmail.com with ESMTPSA id de13-20020a05620a370d00b006f9ddaaf01esm314723qkb.102.2022.10.26.21.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:38:12 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/3] bitmap: optimize small_const path for
Date:   Wed, 26 Oct 2022 21:38:07 -0700
Message-Id: <20221027043810.350460-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make all inline bitmap functions __always_inline to ensure that
small_const optimization is always possible, and improve on it for
find_next_bit() and friends.

Yury Norov (3):
  bitmap: switch from inline to __always_inline
  bitmap: improve small_const case for find_next() functions
  bitmap: add tests for find_next_bit()

 include/asm-generic/bitsperlong.h |  12 +++
 include/linux/bitmap.h            |  46 +++++-----
 include/linux/cpumask.h           | 144 +++++++++++++++---------------
 include/linux/find.h              |  85 ++++++++----------
 include/linux/nodemask.h          |  86 +++++++++---------
 lib/test_bitmap.c                 |  23 ++++-
 6 files changed, 208 insertions(+), 188 deletions(-)

-- 
2.34.1

