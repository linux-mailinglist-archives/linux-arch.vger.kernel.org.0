Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F570B5AA
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 09:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjEVHBd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 03:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjEVHAw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 03:00:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DEE137
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 00:00:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af2f4e719eso20344531fa.2
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738845; x=1687330845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AahUWbcM1gd1dIKV3ajpbH14PSzhJ7702+mo4mqS4bw=;
        b=BOx3hh3zVFySbprqCFUQMf+fnYuA2iUWep9gxTTyP5WeKKesv2gkIt/oZ6gEvNuPqI
         gsjbEjKEDWqEmE5Xz+Nt/ksrroHKs3LUAOgWVbkRN1Kydxt9EKFhkr8TpfFEhu56yyMK
         Fi4/TilXApxKBTJwYVjZxj/UXLWFIj9+4VoHAGULRBmHb3Zda8kO4YxVCQ0d2N/ryL0/
         trIrcEVfvwtXA0iflvfhHsiTC15IrKKRjozmZ4AWsaglSOB7UzCOIdwM2j6Z++exTmfV
         E97bpCK0CgHzzii3nCIaFh8KtL2mBA+CmhLDuwxHMJPOnCXsxBPehRvCb+Dc2MeynGDJ
         h1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738845; x=1687330845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AahUWbcM1gd1dIKV3ajpbH14PSzhJ7702+mo4mqS4bw=;
        b=B+OkUxOSlS/7fAsCIfRoOcWxeRdVCcg7UbTWvHg1xNmde7VZ/T683iPXQpjGUwEeEN
         QaaOU66nZ37pEJYj+hRNz1yAp+0K6xdfoko0/6GID3Dle6Kb2gGIiWZpHEATV89qT5qc
         xy3aIqs4D6dHCnoQ+ilPfcGy6BUPxwAHuLvBfaL4F5kUoB8I2gYwcZvJ7Ja8Y2Wu4nsI
         ZNai5WoG7m39hU7gljzxtrXk3sKrkWde+S96JAnZcHeUCa+G9s8VNyFMNok79NWO7N3V
         vUqOiMljDqYCnBQTn6MyqFhGOeufWhQ6jkFF9WrLIRr4AUWmcJ8hlnPfkC7vhFlq3nWc
         z6vw==
X-Gm-Message-State: AC+VfDw31H72W/TCKa+K+aYJ6Sx2+SKD96r7MQcfc/pJi5GKXkN7nMR8
        4sMsqbmzJGvJZuAyQpAVQP8O/Q==
X-Google-Smtp-Source: ACHHUZ42e7ChwDWtOUUn4J77SbnYxbJJldABpTKqJYmVMK67oK/aQaDrAhMQZ3FMLOrwg7jn9I7vUw==
X-Received: by 2002:a2e:81d1:0:b0:2a7:a719:5943 with SMTP id s17-20020a2e81d1000000b002a7a7195943mr3785908ljg.40.1684738844861;
        Mon, 22 May 2023 00:00:44 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q4-20020a2e8744000000b002adb98fdf81sm1010187ljj.7.2023.05.22.00.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:00:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:00:41 +0200
Subject: [PATCH v2 06/12] cifs: Pass a pointer to virt_to_page() in
 cifsglob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v2-6-0948d38bddab@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Tom Talpey <tom@talpey.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Like the other calls in this function virt_to_page() expects
a pointer, not an integer.

However since many architectures implement virt_to_pfn() as
a macro, this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix this up with an explicit cast.

Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/cifs/cifsglob.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 414685c5d530..3d29a4bbbc40 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -2218,7 +2218,7 @@ static inline void cifs_sg_set_buf(struct sg_table *sgtable,
 		} while (buflen);
 	} else {
 		sg_set_page(&sgtable->sgl[sgtable->nents++],
-			    virt_to_page(addr), buflen, off);
+			    virt_to_page((void *)addr), buflen, off);
 	}
 }
 

-- 
2.34.1

