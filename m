Return-Path: <linux-arch+bounces-703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C0580591C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 16:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F161281E7E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F968EA7;
	Tue,  5 Dec 2023 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvHnm+WX"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA78196
	for <linux-arch@vger.kernel.org>; Tue,  5 Dec 2023 07:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701791538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
	b=MvHnm+WXonaZxwf7LRdXRiBFtUEOZrsifDkA8f+/CV1kKfsShOZhOGG6MFRX1HfSqqo3aI
	wHJKU6RXLCLpONENt41r7cfpdJwAJAS7yp0zpxohGgJxgxkIT/EPPSNjcgOkTDYQE//LTz
	KG23LObs9OZK3ifMIxZu1nA1HWqJo+U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-XG8G5-_YNmq4CBZ8KUoEnw-1; Tue, 05 Dec 2023 10:50:23 -0500
X-MC-Unique: XG8G5-_YNmq4CBZ8KUoEnw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b53d6a000so10351415e9.0
        for <linux-arch@vger.kernel.org>; Tue, 05 Dec 2023 07:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791117; x=1702395917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=qc+svGZqmaAnaGhzlPLiORWlYfdaVU/2ThbBCSkJ9CBuQVBjYqXLBXuOEq/Wk3t1c9
         S7AjX+H8AYRZnvSRcoYzixi5kYt8ybAXJDOCjtYSPl0GSUH/Oxwxryi7GC4IBHM2lqMx
         bjYWJpdLxlCTDtg0Swxq8VkLHSRMDkAMxbFKITosm6k0ouvgu1PvHSiQ5lDRb0WqU5zo
         NjAOZUpeCHyLynsZajeyrSZZvipJSxA16xOjMD7GXcZgG6MDe+TSQX5U8TQAIeGp1oYT
         4rjycqYae8Y4hIEE5vKK3bwqToxwDBS9WBRh8OYKjzZMGXTS2TBaJf2rpL/ZSeJkovUv
         i+7w==
X-Gm-Message-State: AOJu0YyTMB7GAc/yknGupHMmnNMwDSyoDaDezeiR884GGWQj9TV4cXjw
	P8JiuJ+VSvE8KvP2hAyZpQxX1ZcEht07VjQylSGnrlKgYcRA8hPm2/mQ9cxAnBExNTgQx86qtju
	fz24Ge2R7OXihLHSLwoEq8g==
X-Received: by 2002:a05:6402:1d0e:b0:54d:2efd:369e with SMTP id dg14-20020a0564021d0e00b0054d2efd369emr1100578edb.1.1701790673582;
        Tue, 05 Dec 2023 07:37:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMWm/1bFBFbNN6jWtOQ+6Wi9ETG9A4NbaILiBypRArdxNy576pceUJLgrbNKwNpAp9z7aoNA==
X-Received: by 2002:a05:6402:1d0e:b0:54d:2efd:369e with SMTP id dg14-20020a0564021d0e00b0054d2efd369emr1100547edb.1.1701790673178;
        Tue, 05 Dec 2023 07:37:53 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:912:71c8:c243:7b37:30b:a236])
        by smtp.gmail.com with ESMTPSA id r15-20020a056402018f00b0054c21d1fda7sm1244578edv.1.2023.12.05.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:37:52 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v4 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date: Tue,  5 Dec 2023 16:36:26 +0100
Message-ID: <20231205153629.26020-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205153629.26020-2-pstanner@redhat.com>
References: <20231205153629.26020-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_iounmap() in lib/pci_iomap.c is supposed to check whether an address
is within ioport-range IF the config specifies that ioports exist. If
so, the port should be unmapped with ioport_unmap(). If not, it's a
generic MMIO address that has to be passed to iounmap().

The bugs are:
  1. ioport_unmap() is missing entirely, so this function will never
     actually unmap a port.
  2. the #ifdef for the ioport-ranges accidentally also guards
     iounmap(), potentially compiling an empty function. This would
     cause the mapping to be leaked.

Implement the missing call to ioport_unmap().

Move the guard so that iounmap() will always be part of the function.

CC: <stable@vger.kernel.org> # v5.15+
Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
Reported-by: Danilo Krummrich <dakr@redhat.com>
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/pci_iomap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index ce39ce9f3526..6e144b017c48 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -168,10 +168,12 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 	uintptr_t start = (uintptr_t) PCI_IOBASE;
 	uintptr_t addr = (uintptr_t) p;
 
-	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+	if (addr >= start && addr < start + IO_SPACE_LIMIT) {
+		ioport_unmap(p);
 		return;
-	iounmap(p);
+	}
 #endif
+	iounmap(p);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
-- 
2.43.0


