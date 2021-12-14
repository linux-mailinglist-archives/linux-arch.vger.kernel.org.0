Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A6D4747CF
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhLNQXr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbhLNQXf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:35 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF63C061785
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:14 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id u20-20020ac24c34000000b0041fcb2ca86eso6751822lfq.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=olRZ/+DsKDaAFuaGG/j7BFeaFh0ExVig2xDV8tj79mY=;
        b=AZMbPv6YU75omW1PCY67bzSuU/ZVSn7oXZSZ2epvS8xVB1tmOznv1nY4Ye3LciG8CF
         SJbN8SvrgxgB1hrzotG9LvFYgvZrX2/O/92JBYMGvOozkVY2s7YDFK7i30mwJAStwLNU
         GHjq6GKC2p7ur/RolwtuvKxhB5ZzIYEBCaPUAXV7ReSn4ANGtvtEHpsOG+2+CureWcYC
         UhqRbNO9zV/IPkP7zKKl06hAU7vtjVbAe51+z4+t0/yP4Z/kvGehTffXMIQArgFRhFHw
         LhMWPx1NUKj6vZ0vF7s29kb/5xBQApSzCLXoFS6UcZ4xXjKSz6rIzJTwiNS3U3UhE152
         QeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=olRZ/+DsKDaAFuaGG/j7BFeaFh0ExVig2xDV8tj79mY=;
        b=bwEEmPbfX/hTkr9RZ0/8BdBXKjMm/03AtY+hy1f0drb9RnjUZ2QyKMZZEGAJniQGOB
         2gFg6wXqX/474+qND2UJSSyhlYwV148Zrcfngu7ZYRSUa5toqh20YHRRa7DCWmv0khRM
         /Oye1LKvtxRdhGLFywBXpuhQnv+DjAq+IQcKcunQd5J901cUR7nWahQCRggChvNypC46
         YtFfr84d1eUv9NNNP2ePXgWGhgp6NWWdaun9Y9DHty6vvMAYw4wpOgdZfslKu07dhAkr
         v4jH8ZjRNGN8Fy16ILwTDUz3gx34EMO5Ou9mdYspbslYmTu2xr7r8yPhpHUxgJsbFi5X
         3fIQ==
X-Gm-Message-State: AOAM5303awrrNi1MgQvxhrJegkJLrfX39Gg+arhCbGZlEEygXB3xAzfO
        oQhbD0vjzqVpx5dCNArXa/FTC49mjlo=
X-Google-Smtp-Source: ABdhPJxHTLK1yWIsE4vKmI5uGLTSba2Nc1bS0PGDcbFD0uKbOw3JLrJKYPGR2xP/idljX/8IJjgOdYVH8N8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:6512:2246:: with SMTP id
 i6mr5863432lfu.24.1639498992700; Tue, 14 Dec 2021 08:23:12 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:36 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-30-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 29/43] kmsan: handle memory sent to/from USB
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Depending on the value of is_out kmsan_handle_urb() KMSAN either
marks the data copied to the kernel from a USB device as initialized,
or checks the data sent to the device for being initialized.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Ifa67fb72015d4de14c30e971556f99fc8b2ee506
---
 drivers/usb/core/urb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 30727729a44cc..0e84acc9aea53 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -8,6 +8,7 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/log2.h>
+#include <linux/kmsan-checks.h>
 #include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/usb/hcd.h>
@@ -426,6 +427,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 			URB_SETUP_MAP_SINGLE | URB_SETUP_MAP_LOCAL |
 			URB_DMA_SG_COMBINED);
 	urb->transfer_flags |= (is_out ? URB_DIR_OUT : URB_DIR_IN);
+	kmsan_handle_urb(urb, is_out);
 
 	if (xfertype != USB_ENDPOINT_XFER_CONTROL &&
 			dev->state < USB_STATE_CONFIGURED)
-- 
2.34.1.173.g76aa8bc2d0-goog

