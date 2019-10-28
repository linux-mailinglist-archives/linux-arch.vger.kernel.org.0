Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B25E7AD7
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2019 22:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbfJ1VGH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Oct 2019 17:06:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35849 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389536AbfJ1VGG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Oct 2019 17:06:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id c22so378394wmd.1
        for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2019 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uRLJnnkoKtrt3q1ob0/siBgAznuJHarDQvJURi9aQb4=;
        b=SIpiQHIotDzzIYqm9aXXXSdbbNyIiBGfjR5nwKGqhflsnh3A5ENnvL5ku7plympJ56
         nU36hscWDg92/FfoUgg6mGZV1MQZ06P3qheMpNe3W+BoMzXYLyDOcBz9DFqkhDIEdh5B
         gqbt6pLe8aajvT9/ApxWiQy6qHncmnK9uEhkZ9EqPdAXzu6B6PFTNwcVhG3P2ju+X3f/
         sfPBA2pEnzU6TygZk9bck8dKivYNrYpRDwfFHpK5yH8NWhYl07OW9N75iEfLQn0AVE4T
         Xhi5EjkHr/H2F2I9Ee4ffmNMGotxS1WZGlXL+yrOupHrVgXxi75kCPijWu4pb+5VrVqk
         yHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uRLJnnkoKtrt3q1ob0/siBgAznuJHarDQvJURi9aQb4=;
        b=HTxWcFhuYvrJ36Dhho/p3V0Dxo1yN5klEeJq713qffkPTmGte8JU146ZJj9MwuZ2m6
         KGXi3uxagUkh9e7b3DG1TwQGqBeMiJRIszCcVS5FroeiChGn25qEsw3j47TBTpBDtqLL
         jSpmT4zcWW3zzntohG1jaV/rX8TxEtHHMg1aevXMo4y9f02DxQ/O1x9PGH7mD/Wf9Zu6
         3yABTRwt+tQre40Q7KcLJuZq8cdnjAa3OZXrJF+rbLGkrs3LzeB/HkHeAhzPm8eG82an
         l5z0BzVVNhAtmb1Sjnb90uxzdOa5PszNAxYkbaNenXHX1DJdi3G7sLWviTuGEcPJ+2RU
         EnWw==
X-Gm-Message-State: APjAAAWWHEvhqSkX8DwbIOHxBdBRObfcWtDwvkvF17QXpAqB5P/8QVee
        aCVuzjn9VHniZqXMSYsM661zh4umKIfh6g==
X-Google-Smtp-Source: APXvYqxLhsR1PGtmh9drHOLTiE38etYU0uqVFMpWhqoC1tXLMotQdsLS61o8y7c30loRYYNwzvsK1Q==
X-Received: by 2002:a7b:ce99:: with SMTP id q25mr1133067wmj.115.1572296762897;
        Mon, 28 Oct 2019 14:06:02 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net. [88.138.106.230])
        by smtp.gmail.com with ESMTPSA id b196sm927822wmd.24.2019.10.28.14.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:06:00 -0700 (PDT)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/6] Improvements for random.h/archrandom.h
Date:   Mon, 28 Oct 2019 22:05:53 +0100
Message-Id: <20191028210559.8289-1-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

During patch review for an addition of archrandom.h for arm64,
it was suggeted that the arch_random_get_* functions should be
marked __must_check.  Which does sound like a good idea, since
the by-reference integer output may be uninitialized when the
boolean result is false.

In addition, I noticed a few other minor inconsistencies between
the different architectures: x86 defines some functional macros
outside CONFIG_ARCH_RANDOM, and powerpc isn't using bool.


r~


Richard Henderson (6):
  random: Mark CONFIG_ARCH_RANDOM functions __must_check
  x86: Move arch_has_random* inside CONFIG_ARCH_RANDOM
  x86: Mark archrandom.h functions __must_check
  powerpc: Use bool in archrandom.h
  powerpc: Mark archrandom.h functions __must_check
  s390x: Mark archrandom.h functions __must_check

 arch/powerpc/include/asm/archrandom.h | 24 +++++++++++++-----------
 arch/s390/include/asm/archrandom.h    |  8 ++++----
 arch/x86/include/asm/archrandom.h     | 24 ++++++++++++------------
 include/linux/random.h                |  8 ++++----
 4 files changed, 33 insertions(+), 31 deletions(-)

-- 
2.17.1

