Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D741D2C0337
	for <lists+linux-arch@lfdr.de>; Mon, 23 Nov 2020 11:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgKWKZB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Nov 2020 05:25:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45841 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgKWKY7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2020 05:24:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id b17so17341426ljf.12;
        Mon, 23 Nov 2020 02:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DIiHwj3zzp1SABTt1Q6VlY96K3Om1JLL4a2Gj9szo8g=;
        b=eOo67ZJDQIFZOTk4Cv5FDEpZiM91eYQDmB13Pmm5j53eP9L7yI6Eio1QGjyZrtHBq7
         BNKCZV9xOh9+dyoLg936DzXwJY1C2o2SPTfdGX//nZkfG/vA0aLBai4OgmhyK1ixv3b+
         cfWqlw5dae/v71DNZZqoOHL7//u85L74DjOYUEfsovC29hx1LAerk1n8UVTa64zspxVL
         o0UH7JqpsT8ahBJPXUbGpCs8RIpxdKZntOeq69oj3f3BMA56xNS6rF+1rKYwOS2EyGUB
         aSHlSMwEG9deyyAYP6CaVXwm6kwpPoAw7ovz6C1fbJccogwL9rq+/60+ADQRP5Q+kL52
         HhPw==
X-Gm-Message-State: AOAM5336ntNFa60Aet7RDJOks1lqA4N2uarskq+Q/jypEIoQ/VkBg8kG
        t+loadlL60mUI8a4C5yhjSo=
X-Google-Smtp-Source: ABdhPJypPhINbxOPDDAy+PaHJNUlqNhM/8V6ncVpCoNzYAAdenvD9//gnaDWJRNgSPvUqaBBQdCBOQ==
X-Received: by 2002:a05:651c:326:: with SMTP id b6mr2712269ljp.339.1606127095742;
        Mon, 23 Nov 2020 02:24:55 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id h11sm1343594lfc.194.2020.11.23.02.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:24:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kh91q-000286-Gd; Mon, 23 Nov 2020 11:25:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 5/8] init: use type alignment for kernel parameters
Date:   Mon, 23 Nov 2020 11:23:16 +0100
Message-Id: <20201123102319.8090-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201123102319.8090-1-johan@kernel.org>
References: <20201123102319.8090-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Specify type alignment for kernel parameters instead of sizeof(long).

The alignment attribute is used to prevent gcc from increasing the
alignment of objects with static extent as an optimisation, something
which would mess up the __setup array stride.

Using __alignof__(struct obs_kernel_param) rather than sizeof(long) is
preferred since it better indicates why it is there and doesn't break
should the type size or alignment change.

Note that on m68k the alignment of struct obs_kernel_param is actually
two and that adding a 1- or 2-byte field to the 12-byte struct would
cause a breakage with the current 4-byte alignment.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 7b53cb3092ee..e668832ef66a 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -255,7 +255,7 @@ struct obs_kernel_param {
 		__aligned(1) = str; 					\
 	static struct obs_kernel_param __setup_##unique_id		\
 		__used __section(".init.setup")				\
-		__attribute__((aligned((sizeof(long)))))		\
+		__aligned(__alignof__(struct obs_kernel_param))		\
 		= { __setup_str_##unique_id, fn, early }
 
 #define __setup(str, fn)						\
-- 
2.26.2

