Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE7832510C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 14:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBYN5u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 08:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhBYN5q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 08:57:46 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA58C061574;
        Thu, 25 Feb 2021 05:57:05 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d20so4637313qkc.2;
        Thu, 25 Feb 2021 05:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3S2/9NZCW9QVmXj9grkY/k8GsyFK+D3WBEzfAOeLxE=;
        b=t8MF1Qs6um/IJ27dP+R/8X4j9JbeDhG8huigp8RFGSkisQlib3Mo8fn57x+8dJcdNU
         W6TcJ464L4jl1tTsSZmo7gZl5evuv0MhrdiaTslyYzYZeFAQY3GJfBOr/apKSlgJjYBQ
         tVAjmhxY9tDT7iV/GXthJrdvGKnemSzBf6BWqjOM6yiYYF92UClaLANNgWh0CP1TWH2x
         pAiImpczPp/Aqium3UsM3oOpkJkL6Rjojp00UPK87lSDlgtB85W1u/S5xSgsolYaEEH9
         OYYkXgNuvTmOgKGGYY3LhKDZ/XwKl/36t7PYV6Tf2xOzBMXN2Y/gPOf+aDeu0WxV+KEO
         mX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3S2/9NZCW9QVmXj9grkY/k8GsyFK+D3WBEzfAOeLxE=;
        b=ab0NkD6IRST1qW6gqpjqOxd2ioOC0CTcvdZ3yxXAd38pZPFkcB2ytRSNgxCok2HJrF
         IL8o1Xjkx+rmL49h3Qoi2V0X/9yBscKlAd8L3rJNODZx92C1njVuCNrkozTghtik1/ry
         E4/gDT81gzN9IlPt5L4ZWZ7B/AC/pt4KS5OKtoJbvD6T/bcTUoCrNaoEYreF6JZC460x
         ojNfevrtRFDbTsBaW+TIAq386xdPXV2KC7IurnLh93PtJUjwNFaLSxcd2IJDGP2C7e9R
         Y+AtzGmK2F0GeLrNpz6pyqYAWJwNqEpeXvOdFzeOXiH+Y8M3Efz3Ac30QWpxLwU4EFEO
         HGLQ==
X-Gm-Message-State: AOAM532antRK+J0j372IMMRA9mzr6kpdqbImPCci+74b9nXUNmk0ep+N
        0T8KoDUBUBrLWbkhdne/tvw=
X-Google-Smtp-Source: ABdhPJwIoLmbkEdUBaV0j20N2p4kQqMq8twl/L7Q+AGbL1IVJRZjPNmoUaQsgWzi794pb71fOrP1Ag==
X-Received: by 2002:a37:a28e:: with SMTP id l136mr1183634qke.172.1614261424402;
        Thu, 25 Feb 2021 05:57:04 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id b65sm3913576qkd.120.2021.02.25.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 05:57:04 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/2] arch: enable GENERIC_FIND_FIRST_BIT for MIPS and ARM64
Date:   Thu, 25 Feb 2021 05:56:58 -0800
Message-Id: <20210225135700.1381396-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MIPS and ARM64 don't implement find_first_{zero}_bit in arch code and
don't enable it in config. It leads to using find_next_bit() which is
less efficient:

It's beneficial to enable GENERIC_FIND_FIRST_BIT as this functionality
is not new at all and well-tested. It provides more optimized code and
saves .text memory:

Alexander Lobakin (1):
  MIPS: enable GENERIC_FIND_FIRST_BIT

Yury Norov (1):
  arm64: enable GENERIC_FIND_FIRST_BIT

 arch/arm64/Kconfig | 1 +
 arch/mips/Kconfig  | 1 +
 2 files changed, 2 insertions(+)

-- 
2.25.1

