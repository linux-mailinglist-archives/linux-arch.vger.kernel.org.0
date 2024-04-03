Return-Path: <linux-arch+bounces-3391-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE2B89709C
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039191F2738D
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5983714D426;
	Wed,  3 Apr 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgta/Mnr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0B14C5A5;
	Wed,  3 Apr 2024 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150407; cv=none; b=MeT/o84RWdJoTqEV2gUxqDKVw93Ni5RGkVIU2ecZoB5IAePeKJh6Y9BAOen43T76FjvIuUSJBW5mp9HxFkOyjOG1Ct2NzUIB91U1OMCBiXK0T+xt/6J3bOCPtyK0NDjTWnE/bwj3ok0NgiGSUG90pEp0/luKUS+ARYNc+DSmTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150407; c=relaxed/simple;
	bh=RCCT/5TpvcROnLQfnurJQ3QCbHt8dW3ImZclXmeu/JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBMXZRBhiy/BfGVyQWeHYIEIz7OIo/ZMjHWplEutLCvQZ+SaHo0q69pfO2WPqGnpeIaRaUNdo0qPPe0vXTfJgWDf9YmsDyQLilC47jL1NiVhnc3s46d3yJ9Kx6ThzHeYMSL1BmJ8QL7saT54VvHnYZMyc6GNo+WDoDGRRqyAVEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgta/Mnr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0d82c529fso54378375ad.2;
        Wed, 03 Apr 2024 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150404; x=1712755204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRPOdz6AnxublM7n3KmjYybYhLan42asyWOmMDzsw+o=;
        b=Lgta/MnrcbxSw3fkbvVuGZUTbk39aUBRkqWBoUWrGR6J+3fjwSpKBM9OP51TirSkGq
         qLc4vwyj5v2FTOozrHgc+rKL3oWaXNcMns98P79qHtlvXMLfmYao9EIZA8uZvkeygY2X
         O5Vkj6qjDkGLRfJvijsYx9pV6OjTAVCRyH/vw+4ZMCI0hk+SpHsr+eTH97h95nCoHOrS
         WXNGvesL4s3+iwLMAwRj2M3QBCTHQlBDposxFZv6lXwwRxdrVELZX/XiR+0r4h31yKfM
         sHFHqkPIYpjPkkAbM41ep5fqd8GQD7P+pKFoEKqtGPjsyspmWIMqOivFDCNDfQKGSY23
         5LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150404; x=1712755204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cRPOdz6AnxublM7n3KmjYybYhLan42asyWOmMDzsw+o=;
        b=RSII/5FNt1RLLzigAaAx/rnhbe/k1S3jZDf3w6fxg269S6D3yyL8Dc2lfYULADGyyL
         QhDR1EJ2TWuLpFTaNbM6eIV6RQBWOJRQXekMqB31wHnDlpu+Rl2FYkzcUKXcmMp98SPG
         FXlytr73QdLOJlXfX3gfJzsE/0uz7ble2Fl3c58FIJWw3oiHQmpRQ2uiIZyxVlWJ5/Nu
         2+rHYldqGX950kCAyD2nhNAd9fAfoz5YMCE48rOyVeROjg5FsKPr8nPujOcUJ7vLtrub
         ZL8KqkrtDIHZES1+kFzreT9UV5TMoERatUJze81KmZ/AbIg3yqtKa3VhsCTFjfvfQ5+h
         yMvg==
X-Forwarded-Encrypted: i=1; AJvYcCXgmMfwNlPO1DcDHf+y+1qiRXSnS+8Csg4Egd23lNllKgGIlhsTYk9DVZStjf2ySuxHys5Jdr5Y6qQwsRFZszFXXHKwF1DZH8JnDriANEFnM+lpliJsne8srfDauP9YZyB5uxzMpjszyuwQ01JnXjdfPeQN7xlQ196WNNUpOIvHbn+LOgfx+WcexM3WNEnCT1go6J654vhFuSu45Mwl64knK3fHH6/R66HQkWFIbz29/UJ4YCWEmVh4qiBhe9t7utqElhupx0YitOKdF6nBIsRseHVkDQYQF7uQ+cuRXK5MpUXcEIHIjIDeoOI59glm3g==
X-Gm-Message-State: AOJu0YyRXteQAytxeu5ifnfa1VUdh3TD3oEPjJ/GMT+uFxPrgGqf8z2r
	Wakk/c1bmKjtIPD+NWfN5hItLQJdDJH+x/11mt3cAevOFB2akIIwtEB9b+CM
X-Google-Smtp-Source: AGHT+IGx8oRVikcJmoZrmV6I1PpggSRavr/G5SNCkYR+IkJlaqrk2wHgg+ZazQ8Nymmw82Dh4v/u5A==
X-Received: by 2002:a17:903:32cc:b0:1e2:2d0c:fef0 with SMTP id i12-20020a17090332cc00b001e22d0cfef0mr17310539plr.48.1712150404272;
        Wed, 03 Apr 2024 06:20:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b001dd4d0082c8sm3855527plh.216.2024.04.03.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:20:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	x86@kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v3 13/15] sh: Move defines needed for suppressing warning backtraces
Date: Wed,  3 Apr 2024 06:19:34 -0700
Message-Id: <20240403131936.787234-14-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403131936.787234-1-linux@roeck-us.net>
References: <20240403131936.787234-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declaring the defines needed for suppressing warning inside
'#ifdef CONFIG_DEBUG_BUGVERBOSE' results in a kerneldoc warning.

.../bug.h:29: warning: expecting prototype for _EMIT_BUG_ENTRY().
	Prototype was for HAVE_BUG_FUNCTION() instead

Move the defines above the kerneldoc entry for _EMIT_BUG_ENTRY
to make kerneldoc happy.

Reported-by: Simon Horman <horms@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Added patch. Possibly squash into previous patch.

 arch/sh/include/asm/bug.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index 470ce6567d20..bf4947d51d69 100644
--- a/arch/sh/include/asm/bug.h
+++ b/arch/sh/include/asm/bug.h
@@ -11,6 +11,15 @@
 #define HAVE_ARCH_BUG
 #define HAVE_ARCH_WARN_ON
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"\t.long %O2\n"
+#else
+# define __BUG_FUNC_PTR
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+#endif /* CONFIG_DEBUG_BUGVERBOSE */
+
 /**
  * _EMIT_BUG_ENTRY
  * %1 - __FILE__
@@ -25,13 +34,6 @@
  */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
-# define HAVE_BUG_FUNCTION
-# define __BUG_FUNC_PTR	"\t.long %O2\n"
-#else
-# define __BUG_FUNC_PTR
-#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
-
 #define _EMIT_BUG_ENTRY				\
 	"\t.pushsection __bug_table,\"aw\"\n"	\
 	"2:\t.long 1b, %O1\n"			\
-- 
2.39.2


