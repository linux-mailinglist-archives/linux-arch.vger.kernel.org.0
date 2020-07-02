Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13B2125A1
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgGBOIh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbgGBOIh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:08:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F739C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:08:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so12588704pfu.8
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/87dVOT03QWsWrcTWI8VqWKTuAoiDkqp4zPRvF7J9Y=;
        b=iqPtQYky7j5nOAsd5/dhtcYRu3lJ8SptOB2u83BR9jWnSnpo+j8QqdJg1lBQSSVyo1
         T35WY1Ol02gSIhVqqIFqvXhXRGPGSe09Gu+L4ckWPXlnTbSYKlt9dPo2/tuOQ/AKw7w7
         dNGzG0h2AGc9SG6EiJKU4o6NHNisdc4Poemtaj6hdzI/h4lQ8hjm9TRTItCjo/mHSpok
         RmYf6WQXz+6fBbRC4vpr//rAguQ7a6OlZDxDaSw9uWOiNaTPUMHK5Tww1i/EWiw9MvYw
         kdo0ruQtJdEMLXxVmB6NGz3JMuEsjXMFM6259RRXtW3/FoOvnJVFQxlcDLesdTU3xZAh
         nGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/87dVOT03QWsWrcTWI8VqWKTuAoiDkqp4zPRvF7J9Y=;
        b=FfG0tSgILHsqHvs4H8m2mTOF//ZndGKe1gVV3noYE+aN97d1HZQi/immk7Egod5a5l
         9Ubx8eiPMRlINCxpEhwP6GyBpL89+QdqHXPTN42JTIXGgw4Jl5i9uRGHae6O6/s2O9OZ
         7v1ndRWRUIvhch+3EYScMxvNTxDSsQZHHXT84SYDUjim2ArkAnNoTJ+R6NSvWomAGClC
         QWp+LCg3B4XcUU92Fdg+mozkptpBPyqGfBM138RX/3XfpUCu9lgBzmfBRhnVuQ/JDoKr
         S7FEpFo47JShRYQtVNmNeRqOlSu+/wfYVfZUuZEwInZfDhCIRaX4U60hXd8e+v7813ZD
         lanw==
X-Gm-Message-State: AOAM533Dx/ZtUGg3CAcYQRSknCdZKlgVHD+cGGGCHDA+HCz9gmmndyJB
        lXSeqiP6MGPLDZK+4jV4e06ToXTEk0Y=
X-Google-Smtp-Source: ABdhPJw3lyQKkNsTs0ctYDmMqIO0TGkhB1e8QJXRWrFLRtw5i+lCuvpRsae03kVDfUt3GzCGBRfr/Q==
X-Received: by 2002:a62:7d56:: with SMTP id y83mr28334373pfc.293.1593698916704;
        Thu, 02 Jul 2020 07:08:36 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id w1sm2253975pfc.55.2020.07.02.07.08.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:08:36 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 9CE10202D31D1C; Thu,  2 Jul 2020 23:08:33 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 06/21] scritps: um: suppress warnings if SRCARCH=um
Date:   Thu,  2 Jul 2020 23:07:00 +0900
Message-Id: <103c87a24c9966f465cdc3c4e4d6519c81cf33d2.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit fixes numbers of warning messages about leaked CONFIG
options.  nommu mode of UML requires copies of kernel headers to offer
syscall-like API for the library users.  Thus, the warnings are to be
avoided to function this exposure of API.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 scripts/headers_install.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index a07668a5c36b..59966f3b4ebe 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -99,6 +99,9 @@ include/uapi/linux/raw.h:CONFIG_MAX_RAW_DEVS
 for c in $configs
 do
 	warn=1
+	if [ "$SRCARCH" = "um" ] ; then
+		break
+	fi
 
 	for ignore in $config_leak_ignores
 	do
-- 
2.21.0 (Apple Git-122.2)

