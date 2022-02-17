Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C774BA8D1
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbiBQSue (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244641AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E7F532EB;
        Thu, 17 Feb 2022 10:50:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lw4so9369046ejb.12;
        Thu, 17 Feb 2022 10:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hlr/d/ERnD+pEeo92J4Kt7XJIn6OwqkRg8lOkxiwSi8=;
        b=D3JhmgGijhe3YeJmKhqsDrxlZTQ+nnCfZEpNZe7LPE6dXw10y8ST1pJLuyZD5e9HsZ
         lYgmzgswvUJZc5BG65+MszYjimqoG3vM6Ml372J3SYkzyHW1C54yGU6uIqZ4Q+ZuwpjO
         5pr91+m/GY85v3qUuCnd9CdkAnGV4Tt9QSlOlvBfAaWd7cE87MC+cDAJ6WtT7kw7bxih
         Iq//cM3wU2OYT/r4Q6VO4yQnPs/wfiMma84wIdcgzJj85X6E8AzrfOpHeBmYj/jTDGch
         gGOgACbSUluM7aIKdO2fyOLJ2Zvxkah6bFib0+ej4/7nj4orH5+wHFMQI0spXovkWqSf
         eikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hlr/d/ERnD+pEeo92J4Kt7XJIn6OwqkRg8lOkxiwSi8=;
        b=bWofK+jJdNavO1pnJjEZI7zufYZcmW7GaypFCRhnCkXrL66XBtOMxKvTSuD37XKymg
         kp2T3zOZYMytx79M1XuFu0OckRA5glV231zXiW/wIztp+yiGQMNfreViXKK7xeB1O9im
         95RqDthf8xBV23dp44MnUHynvQpVm6s3+LD1vdXIgp2qZN8795WupP6mBgJj3cEpPBMq
         NuMisIdZV9/TsU23UatV8j5TWKX/PPJiV5OsoEWZ/xEdNlbK2bbUGKmopF6/a2uB/8SG
         5nTvM5LTkcf2p/guVT8a4rs61SNId9BCM195uZHBgoCoLz8EX6rJha2tDzDz47BzpZus
         1lLQ==
X-Gm-Message-State: AOAM531QsKxTM2NDa3BLF87/hz9l8j+rh+HAyU/bpV6FFonfyRf2ZZZa
        273k8Kg50CbQAJ69fn4Hc1M=
X-Google-Smtp-Source: ABdhPJyfVVaVMtT7VEzDXjRAGsw/dEiLnrRHhU06v4Gu0cLH+aZPppiyCb2ciGRnLovYHS91Jz/N0w==
X-Received: by 2002:a17:906:1582:b0:6a8:3574:119 with SMTP id k2-20020a170906158200b006a835740119mr3374995ejd.173.1645123809650;
        Thu, 17 Feb 2022 10:50:09 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:09 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [RFC PATCH 12/13] staging: greybus: audio: Remove usage of list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:28 +0100
Message-Id: <20220217184829.1991035-13-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217184829.1991035-1-jakobkoschel@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The list iterator module should not be used if data == NULL.
module can only old a legitimate value if data != NULL.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index b589cf6b1d03..e19b91e7a72e 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -599,8 +599,8 @@ static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 			break;
 	}
 	if (!data) {
-		dev_err(dai->dev, "%s:%s DATA connection missing\n",
-			dai->name, module->name);
+		dev_err(dai->dev, "%s DATA connection missing\n",
+			dai->name);
 		mutex_unlock(&codec->lock);
 		return -ENODEV;
 	}
-- 
2.25.1

